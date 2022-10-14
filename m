Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7B45FEED8
	for <lists+linux-pci@lfdr.de>; Fri, 14 Oct 2022 15:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiJNNo1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Oct 2022 09:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiJNNoZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Oct 2022 09:44:25 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4B01CFC63;
        Fri, 14 Oct 2022 06:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1665754876;
    s=strato-dkim-0002; d=ibv-augsburg.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=3pB7WXwwUMURkXU3QEWf34QpwoK2MI1RffNpmhn/a1M=;
    b=k9Bvgqy0oNImODQd+O/9q5JMI+eemxIVBVFBnwe7y6AhGBnCLmFsKQ4lyADmi87b9u
    fi+yBXK9f/Dt4rM7qCztXFpeDijrAYdYQQkl9nnpWuErj/zf125NdCbWYTuJX07xV3om
    x1LHxc8Rc+SvlTUqGrNYFnWRnGBuBqNeudm+ESdclIXs/iMXqWppWP+w1QOGjKhITAlW
    Uh9frb4ZMkcsE2IhdGSTrj/y1Rx5v/KV9YNx12kF8EqlHSwPaYKISz9Iszg/dyqlnAY+
    GCNpV0XqHJv+tSjA0sm0U+Br0w1fRsSNUS2ymDD5QxSCXqlP7lYk1eDTnymQ6TRR47Ag
    5fFw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":KGMJfE6heLGk8b3w7Oa1fDtXwBjeDczIOHPRx8yNRKhFG/cxcP9dNdI9SxioDT8RvZMqtMfbyXFLOT+8odoEkA=="
X-RZG-CLASS-ID: mo00
Received: from JADEVM-DRA
    by smtp.strato.de (RZmta 48.2.0 DYNA|AUTH)
    with ESMTPSA id R6cb4ey9EDfFMag
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 14 Oct 2022 15:41:15 +0200 (CEST)
Date:   Fri, 14 Oct 2022 15:41:14 +0200
From:   Dominic Rath <dominic.rath@ibv-augsburg.net>
To:     Rob Herring <robh@kernel.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, tjoseph@cadence.com,
        bhelgaas@google.com, lpieralisi@kernel.org, nm@ti.com,
        vigneshr@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Alexander Bahle <bahle@ibv-augsburg.de>,
        Dominic Rath <rath@ibv-augsburg.de>
Subject: Re: [PATCH 1/3] dt-bindings: PCI: cdns: Add PHY latency properties
Message-ID: <20221014134114.GA307620@JADEVM-DRA>
References: <20221013062649.303184-1-dominic.rath@ibv-augsburg.de>
 <20221013062649.303184-2-dominic.rath@ibv-augsburg.de>
 <20221013191249.GA38183-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013191249.GA38183-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 13, 2022 at 02:12:49PM -0500, Rob Herring wrote:
> On Thu, Oct 13, 2022 at 08:26:47AM +0200, Dominic Rath wrote:
> > From: Alexander Bahle <bahle@ibv-augsburg.de>
> > 
> > Add "cdns,tx-phy-latency-ps" and "cdns,rx-phy-latency-ps" DT bindings for
> > setting the PCIe PHY latencies.
> > The properties expect a list of uint32 PHY latencies in picoseconds for
> > every supported speed starting at PCIe Gen1, e.g.:
> > 
> >   max-link-speed = <2>;
> >   tx-phy-latency-ps = <100000 200000>; /* Gen1: 100ns, Gen2: 200ns */
> >   rx-phy-latency-ps = <150000 250000>; /* Gen1: 150ns, Gen2: 250ns */
> 
> These are a property of the PHY or PCI host? Sounds like PHY to me and 
> that should be in the PHY node. No reason the PCI driver can't go read 
> PHY node properties.

I'm actually not sure if this a property of the PHY, the PCIe host, or
of the combination of the two.

We thought about adding this property to the PHY, too, but we didn't
know how to handle cases where a single PCIe host is linked with
multiple PHYs for multi-lane configurations (see TI's AM65x for
example). Which PHYs latency would you use to configure this PCIe RC?

Personally I don't have a very strong opinion either way - we just
didn't know any better than to put this into the PCIe host that needs
it. If you think this is better put into the PHY node we can of course
send a new version of this patch.

Is there any binding that specifies "generic" PCIe properties, similar
to ethernet-phy.yaml? We couldn't find any.

I guess in the AM64x case the "PHY" is serdes0_pcie_link below serdes0:

&serdes0 {
        serdes0_pcie_link: phy@0 {
	...

This seems to be described by bindings/phy/phy-cadence-torrent.yaml.

Should we add a generic (without cdns) tx/rx-phy-latency-ps property
there?

> If PTM is a standard PCIe thing, then I don't think these should be 
> Cadence specific. IOW, drop 'cdns'. 

Yes, it is a standard PCIe thing, but we haven't seen that many
implementations yet, so we didn't want to pretend to know what this
looks like in the generic case. We can of course drop 'cdns'.

Best Regards,

Dominic & Alexander
