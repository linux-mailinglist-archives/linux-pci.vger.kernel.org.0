Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAAB618B33
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 23:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiKCWOe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 18:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiKCWOd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 18:14:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD77E21261
        for <linux-pci@vger.kernel.org>; Thu,  3 Nov 2022 15:14:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 655826203F
        for <linux-pci@vger.kernel.org>; Thu,  3 Nov 2022 22:14:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E265C433C1;
        Thu,  3 Nov 2022 22:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667513671;
        bh=9JRR7uTuRBJrFx6A7yH7xbaljidoBRxx0tTlKNY/yec=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hF/vsKcwr4MAr4VAbRDotIZCUd0Z71BHlCgYiEIUKlCr3McthLrbe94iJ1M6lpjOR
         hhqshammH+dlC4dtEr09BWtRu9/cKRSoE+LF2/c6+IzRzI3T08W/WDB24U6jj6AtCU
         HYzeF5JRNuz6GEIPgPGkMI2tCdYbzUWTu8/8Ivsx0Rb/1RWIoU4Wi5fHBTQJyLP30+
         ESsnQvAlqn8lgQQQz0ECtdyHWHXnFvjAQVsOY0i/0XvG7bmtSKChz8p/PgpZsIwpMr
         fratGDgwpgNHWTmz4v3MeZzsxiH/6dY4L5aZ0AacqeVMzUWSv1YwwhrJL9RzYBZqkb
         kiSDsctAJfNmg==
Date:   Thu, 3 Nov 2022 17:14:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Tyler Hicks <code@tyhicks.com>
Cc:     Keith Busch <kbusch@kernel.org>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Zhiqiang Hou <Zhiqiang.Hou@nxp.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH] PCI: Align MPS to upstream bridge for SAFE and
 PERFORMANCE mode
Message-ID: <20221103221429.GA47218@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027225149.GA846989@bhelgaas>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 27, 2022 at 05:51:49PM -0500, Bjorn Helgaas wrote:
> On Tue, Oct 25, 2022 at 12:07:47AM -0500, Tyler Hicks wrote:
> > On 2022-10-20 15:24:37, Bjorn Helgaas wrote:

> > I've been talking to the firmware folks on why SAFE mode was selected,
> > based on Keith's question from Wednesday. From what I've been told,
> > U-Boot doesn't seed the RP MPS with a value so the kernel sees a value
> > of 128 for p_mps in pci_configure_mps() when using the DEFAULT mode.
> > Apparently UEFI does seed the RP MPS but we don't get that with U-Boot.
> > Therefore, SAFE mode was selected to get an initial, tuned RP MPS value
> > set to 256.
> 
> Are there any devices below the RP at the time we set MPS=256?
> 
> > > A subsequent hot-add will do nothing in pci_configure_mps(), and
> > > pcie_bus_configure_settings() looks like it would set the RP and EP
> > > MPS to the minimum of the RP and EP MPS_Supported.
> > > 
> > > Is that what you see?  What would you like to see instead?
> > 
> > No, not quite. After hot-add, we see the EP MPS set to 128 with SAFE
> > mode even though the RP MPS is 256.
> 
> Can you add the relevant topology here so we can work through the
> concrete details?  Is the endpoint hot-added directly below a Root
> Port?  Or is there a switch involved?  What are the MPS_Supported
> values for all the devices?  If there's a switch in the picture, it
> looks like we currently restrict to 128, I think because it's possible
> an endpoint that can only do 128 may be added.

Ping?  I'd like to talk about a concrete scenario.  It's too hard for
me to imagine all the possible things that could go wrong.

I guess part of what's interesting here is that things work better
when firmware has already configured MPS?  It doesn't seem like we
should *depend* on firmware having done that.

Bjorn
