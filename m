Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862E06FD1B1
	for <lists+linux-pci@lfdr.de>; Tue,  9 May 2023 23:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbjEIV5F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 May 2023 17:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjEIV5E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 May 2023 17:57:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69EC1715;
        Tue,  9 May 2023 14:57:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7201B63527;
        Tue,  9 May 2023 21:57:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6525FC433D2;
        Tue,  9 May 2023 21:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683669422;
        bh=7Mn7+p/Q2eLP62hMTaKJnMjclUksFkBAVMNLV+0pt8I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=q9tqYV5Uees60Y4yUW6dg9ClrZmsd7wYlvlVPN+9xtTwbaLYXjtUoj0qQzqvT9cEC
         yL0WQ6AdtsvK/tPP5eDG+g6ewEGPphP7Zi1G3qnbNFn5wjMqld+sIjfHHSKEGkaV7m
         WgOfOroyvgbsb8yfzS9ZZtfV9SWXpQWARRVv/fNOKxRRDVyQnvMkUNdr7v6KY6aUzj
         u4I0VUd3D06gwDNvAQhqWXVjfokZ8x+lG+NE5aqIQJc8fKW25KhxcE5pB6yA38TNzh
         DzioE/qMX5y+3KOwksL4JozFfO9PKDQumgXvE61hPne4T/zVHNrBKS7E9JYyg4s+lY
         IVgYZwpVrGLHA==
Date:   Tue, 9 May 2023 16:57:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Dominic Rath <rath@ibv-augsburg.de>,
        krzysztof.kozlowski+dt@linaro.org, tjoseph@cadence.com,
        bhelgaas@google.com, lpieralisi@kernel.org, nm@ti.com,
        vigneshr@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bahle@ibv-augsburg.de
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: cadence-torrent: Add latency
 properties
Message-ID: <20230509215700.GA1277746@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH9NwWeJMnBTTOk-PG_5U-t5aLFEAWC+or9-FJYKSGbbHoH_YA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 09, 2023 at 05:31:19PM +0200, Christian Gmeiner wrote:
> > On Thu, Apr 27, 2023 at 07:50:30AM +0200, Dominic Rath wrote:
> > > From: Alexander Bahle <bahle@ibv-augsburg.de>
> > >
> > > Add "tx-phy-latency-ps" and "rx-phy-latency-ps" DT bindings for
> > > setting the PCIe PHY latencies.
> > > The properties expect a list of uint32 PHY latencies in picoseconds for
> > > every supported speed starting at PCIe Gen1, e.g.:
> > >
> > >   tx-phy-latency-ps = <100000 200000>; /* Gen1: 100ns, Gen2: 200ns */
> > >   rx-phy-latency-ps = <150000 250000>; /* Gen1: 150ns, Gen2: 250ns */
> >
> > Are these things that could/should be described in a more generic
> > place?  They don't look necessarily Cadence-specific.
> 
> As there is currently no generic binding, would you like to see a new
> yaml binding
> added (Documentation/devicetree/bindings/phy/phy.yaml) that contains just the
> two phy properties?

The whole thing is more a question for Rob.

Bjorn
