Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321D2602A89
	for <lists+linux-pci@lfdr.de>; Tue, 18 Oct 2022 13:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiJRLtr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Oct 2022 07:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiJRLtq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Oct 2022 07:49:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2B01FCCB;
        Tue, 18 Oct 2022 04:49:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED8C061070;
        Tue, 18 Oct 2022 11:49:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3B6C433C1;
        Tue, 18 Oct 2022 11:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666093783;
        bh=kvpfGFwNLffxg/x07Vc1xXunFD/ez/0u+fHzgqRDjms=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=M47r0o5/SZCtR63UhfpI6iktXfh7kIZmCQqV59eLzJSq1bFpIUqBX6UPZ2INmiZ/L
         hDNcbrujec2tNbvxelV7V6dGDllDXC7rIpM/DQH4ZJ5LTXHcpy1fNavOM8NSfT9B6c
         o4hxvCh/TicpAbymmz0nXEc0Nshmh0L8spj45tFMSSqeL9MoiO4tSXOBPTwEbgNQKO
         ItyUSvfnRAYPUFAE8KVcV3B74nYL3u8ZXoT96BCblV86Q6cF8s05PRNRy/0Jy67cJr
         il5b17BpsUzxLhqktJeq71qu32Yv8/STKnmYHl4T4a4h+c3KZh68WrnPWTJ47su+e+
         PIrceiWzcNqHA==
Date:   Tue, 18 Oct 2022 06:49:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Christian GMEINER <Christian.GMEINER@bachmann.info>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add Bachmann electronic GmbH vendor ID
Message-ID: <20221018114941.GA3789654@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH9NwWeiaHcWEx9eUQuHZAFzsxz3BhHh4aKUKfRySoJOLxRtQA@mail.gmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 18, 2022 at 10:41:50AM +0200, Christian Gmeiner wrote:
> Hi Bjorn
> 
> > On Mon, Oct 17, 2022 at 04:23:37PM +0200, Christian Gmeiner wrote:
> > > From: Christian GMEINER <Christian.GMEINER@bachmann.info>
> > >
> > > Signed-off-by: Christian GMEINER <Christian.GMEINER@bachmann.info>
> >
> > I tweaked it to shorten the name in the style of other entries and
> > sort it by numeric ID.
> 
> I am fine with that .. was not sure if there needs to be a match of
> the used define and
> the official "Member company" name:
> https://pcisig.com/membership/member-companies?combine=%22Bachmann+electronic%22

No, it doesn't need to match exactly, this is just internal Linux
stuff.  BTW, thanks for the pcisig.com link; I searched for that list
yesterday but couldn't find it.

> > I assume there's a driver that will use this definition.  If so, you
> > might want to post this patch (including my ack) along with the driver
> > so they get merged together.  But let me know if you need me to take
> > it directly.
> 
> I hope that one driver will see the public light sooner than later but
> I have no official time frame.

OK, just post this along with the driver that uses it so they get
merged at the same time.

> > Also it will be helpful if you can add the item to the PCI ID database
> > here: https://pci-ids.ucw.cz/read/PC?restrict=0, which will let lspci
> > identify devices with this Vendor ID.
> 
> Done - thanks.

Thank you!

Bjorn
