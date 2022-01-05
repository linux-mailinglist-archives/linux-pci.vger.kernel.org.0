Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9079F4855EF
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jan 2022 16:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241520AbiAEPgW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jan 2022 10:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241516AbiAEPgU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jan 2022 10:36:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74038C061245;
        Wed,  5 Jan 2022 07:36:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 653EB61796;
        Wed,  5 Jan 2022 15:36:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D663C36AE3;
        Wed,  5 Jan 2022 15:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641396978;
        bh=m/FLdBx2G7b5R4sxeNrOQpROzhLK2is5Mg4emG91w98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tmTU1ZxhPut+ldfGcqFedqOCjVFRUNwsQ83nCr1qmg2zjjNpZDBNgLw40lUmIOL/k
         WlaVmNhTxxm3AT7NySE/ft+ijbeUq67heu8d0i2PTrPC58ovXd2qvE4vHh4tGsx35Z
         C/BehMmDGMWhf7sBIqgumUt4QwYnaOwjyLUp2aj6FlRdO3qiWQ5qe/QJs/0Jxzw8yk
         kGoHcZ0yykmQgMqdCBetoPEQTivBCIWktbA9pzanTq3IdSIFiI//3SLhn671b/cg2e
         kZAwosoSxdzU5RnCHCMOXBZv4d7pe5EmHSkPVTCUbtkVjteHO55Kqhodt+xFSdEcvQ
         VMnBXtAQLl0Sg==
Received: by pali.im (Postfix)
        id E361082A; Wed,  5 Jan 2022 16:36:15 +0100 (CET)
Date:   Wed, 5 Jan 2022 16:36:15 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        devicetree@vger.kernel.org, PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH dt + pci 1/2] dt-bindings: Add
 'slot-power-limit-milliwatt' PCIe port property
Message-ID: <20220105153615.23cinx5sahnewcch@pali>
References: <20211031150706.27873-1-kabel@kernel.org>
 <YY6HYM4T+A+tm85P@robh.at.kernel.org>
 <20220105151444.7b0b216e@thinkpad>
 <CAL_Jsq+HjnDfDb+V6dctNZy78Lbz92ULGzCvkTWwSyop_BKFtA@mail.gmail.com>
 <20220105151410.wm5ti6kbjmvm5dwf@pali>
 <CAL_JsqL0mfRb7k4V-wjyGgjpB3pu88yPNT38k8zs-HoiVYaekQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqL0mfRb7k4V-wjyGgjpB3pu88yPNT38k8zs-HoiVYaekQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 05 January 2022 09:26:22 Rob Herring wrote:
> On Wed, Jan 5, 2022 at 9:14 AM Pali Rohár <pali@kernel.org> wrote:
> >
> > On Wednesday 05 January 2022 08:27:21 Rob Herring wrote:
> > > On Wed, Jan 5, 2022 at 8:14 AM Marek Behún <kabel@kernel.org> wrote:
> > > >
> > > > On Fri, 12 Nov 2021 09:25:20 -0600
> > > > Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > > On Sun, Oct 31, 2021 at 04:07:05PM +0100, Marek Behún wrote:
> > > > > > From: Pali Rohár <pali@kernel.org>
> > > > > >
> > > > > > This property specifies slot power limit in mW unit. It is a form-factor
> > > > > > and board specific value and must be initialized by hardware.
> > > > > >
> > > > > > Some PCIe controllers delegate this work to software to allow hardware
> > > > > > flexibility and therefore this property basically specifies what should
> > > > > > host bridge program into PCIe Slot Capabilities registers.
> > > > > >
> > > > > > The property needs to be specified in mW unit instead of the special format
> > > > > > defined by Slot Capabilities (which encodes scaling factor or different
> > > > > > unit). Host drivers should convert the value from mW to needed format.
> > > > > >
> > > > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > > > > Signed-off-by: Marek Behún <kabel@kernel.org>
> > > > > > ---
> > > > > >  Documentation/devicetree/bindings/pci/pci.txt | 6 ++++++
> > > > > >  1 file changed, 6 insertions(+)
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
> > > > > > index 6a8f2874a24d..7296d599c5ac 100644
> > > > > > --- a/Documentation/devicetree/bindings/pci/pci.txt
> > > > > > +++ b/Documentation/devicetree/bindings/pci/pci.txt
> > > > > > @@ -32,6 +32,12 @@ driver implementation may support the following properties:
> > > > > >     root port to downstream device and host bridge drivers can do programming
> > > > > >     which depends on CLKREQ signal existence. For example, programming root port
> > > > > >     not to advertise ASPM L1 Sub-States support if there is no CLKREQ signal.
> > > > > > +- slot-power-limit-miliwatt:
> > > > >
> > > > > Typo.
> > > > >
> > > > > But we shouldn't be adding to pci.txt. This needs to go in the
> > > > > schema[1]. Patch to devicetree-spec list or GH PR is fine.
> > > >
> > > > Hello Rob,
> > > >
> > > > Pali's PR draft https://github.com/devicetree-org/dt-schema/pull/64
> > > > looks like it's going to take some time to work out.
> > > >
> > > > In the meantime, is it possible to somehow get the
> > > > slot-power-limit-milliwatt property merged into pci.txt so that we can start
> > > > putting it into existing device-trees?
> > > >
> > > > Or would it break dt_bindings_check if it isn't put into dt-schema's
> > > > pci-bus.yaml?
> > > >
> > > > Or should we simply put it into current version of pci-bus.yaml and
> > > > work out the split proposed by Pali's PR afterwards?
> > >
> > > In the existing pci-bus.yaml is fine.
> >
> > Hello Rob! I do not think that it is possible to add this property
> > correctly in to the existing pci-bus.yaml file. As this file is not
> > prepared for slot properties. And I guess that adding new property at
> > "random" place is against the idea of schema validation (that validation
> > procedure accepts only valid DTS files).
> 
> The only issue I see is the property would be allowed in host bridge
> nodes rather than only root port or PCIe-PCIe bridge nodes because the
> current file is a mixture of all of those. I think a note that the
> property is not valid in host bridge nodes would be sufficient. It's
> still better than documenting in pci.txt.

Ok!
