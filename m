Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9B278518E
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 09:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbjHWHbL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 03:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbjHWHbL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 03:31:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91DAE52;
        Wed, 23 Aug 2023 00:30:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68422615B3;
        Wed, 23 Aug 2023 07:30:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E423CC433C7;
        Wed, 23 Aug 2023 07:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692775855;
        bh=0BU5tvuZoETLLYAzQzR1sD8FFkPX6j54eFyEPsWBB3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S6oVBX+c/AVyJt6WAVLtZ8XXBiSB2R0n/Y9V1xiyi/lJ02SycIsXE8WXobpe5Vbbu
         iqkiIyXxvkhczBoiglFGvXKBsmB0nOEZnY7ZEpBbsL2oOFbEogtmsux8iCl+ygFZ1m
         DSzI/tXpMaej4Rqkd+BiRGf4OkNXFc+aH9tdHH7FWJ7nax+uXdD9zLILElJt1n4mTn
         pqtLddxtsga5YZkSOfObuNqjUnvNRV4BLDLoi6Xh+5MbXb5UDRJQJYUlNl7R/DZvpd
         qGaLhJKrDeHXxiEF3heKSnfrUSGIgOqX6iaLsXCIeDJTkZi4VSAJ8eKW6vl2Pram/X
         ZDyLyKf55GB7w==
Date:   Wed, 23 Aug 2023 09:30:48 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Jim Quinlan <jim2101024@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/5] dt-bindings: PCI: brcmstb: Add brcm,enable-l1ss
 property
Message-ID: <ZOW1qDmTdy+8KODt@lpieralisi>
References: <20230623144100.34196-1-james.quinlan@broadcom.com>
 <20230623144100.34196-2-james.quinlan@broadcom.com>
 <ZON43rPGJGzjTTj/@lpieralisi>
 <CA+-6iNwRGsnRsT9R=iEzaJNCTLu_pQNG4x+noE8bqLYCRm_PHQ@mail.gmail.com>
 <ZOOFrqkAdW5d6WIj@lpieralisi>
 <CA+-6iNzZCFs_gQGqa8KAcBM6etFc=vAFoqFmde=xru2-O+F3_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNzZCFs_gQGqa8KAcBM6etFc=vAFoqFmde=xru2-O+F3_w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 21, 2023 at 12:01:50PM -0400, Jim Quinlan wrote:
> On Mon, Aug 21, 2023 at 11:41 AM Lorenzo Pieralisi
> <lpieralisi@kernel.org> wrote:
> >
> > On Mon, Aug 21, 2023 at 11:25:11AM -0400, Jim Quinlan wrote:
> > > On Mon, Aug 21, 2023 at 10:47 AM Lorenzo Pieralisi
> > > <lpieralisi@kernel.org> wrote:
> > > >
> > > > On Fri, Jun 23, 2023 at 10:40:54AM -0400, Jim Quinlan wrote:
> > > > > This commit adds the boolean "brcm,enable-l1ss" property:
> > > > >
> > > > >   The Broadcom STB/CM PCIe HW -- a core that is also used by RPi SOCs --
> > > > >   requires the driver probe() to deliberately place the HW one of three
> > > > >   CLKREQ# modes:
> > > > >
> > > > >   (a) CLKREQ# driven by the RC unconditionally
> > > > >   (b) CLKREQ# driven by the EP for ASPM L0s, L1
> > > > >   (c) Bidirectional CLKREQ#, as used for L1 Substates (L1SS).
> > > > >
> > > > >   The HW+driver can tell the difference between downstream devices that
> > > > >   need (a) and (b), but does not know when to configure (c).  All devices
> > > > >   should work fine when the driver chooses (a) or (b), but (c) may be
> > > > >   desired to realize the extra power savings that L1SS offers.  So we
> > > > >   introduce the boolean "brcm,enable-l1ss" property to inform the driver
> > > > >   that (c) is desired.  Setting this property only makes sense when the
> > > > >   downstream device is L1SS-capable and the OS is configured to activate
> > > > >   this mode (e.g. policy==powersupersave).
> > > > >
> > > > >   This property is already present in the Raspian version of Linux, but the
> > > > >   upstream driver implementation that follows adds more details and
> > > > >   discerns between (a) and (b).
> > > > >
> > > > > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 9 +++++++++
> > > > >  1 file changed, 9 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > > index 7e15aae7d69e..8b61c2179608 100644
> > > > > --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > > +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > > @@ -64,6 +64,15 @@ properties:
> > > > >
> > > > >    aspm-no-l0s: true
> > > > >
> > > > > +  brcm,enable-l1ss:
> > > > > +    description: Indicates that PCIe L1SS power savings
> > > > > +      are desired, the downstream device is L1SS-capable, and the
> > > > > +      OS has been configured to enable this mode.  For boards
> > > >
> > > > What does this mean ? I don't think DT properties are supposed
> > > > to carry information related to how the OS is configured.
> > >
> > > The DT setting in question is unrelated to the statement "and the OS
> > > has been configured to
> > > enable this mode".
> > >
> > > This is merely saying that even if you enable "brcm,l1ss-enable"
> > > that you may not get L1SS power savings w/o setting
> > > "CONFIG_PCIEASPM_POWER_SUPERSAVE=y".
> > > I mentioned that exact term but a reviewer nakked it because
> > > apparently DT descriptions should not be OS specific.
> > >
> > > I am actually open for this to be a command-line option but I wanted to honor
> > > what the Raspian OS folks have already done.  RaspianOS already has
> > > "brcm,enable-l1ss"
> > > set in their DTS files.
> >
> > This is about the mainline kernel, I don't have any visibility into
> > downstream kernels (where that property management was added without DT
> > and PCI maintainers supervision).
> >
> > Raspian OS folks' choice is theirs but it can't and it shouldn't override
> > the mainline review process even though I understand the position you
> > are in.
> 
> Understood, but using the command line has its warts as well; I now recall the
> discussion Bjorn and I  had regarding this option.  I'm pretty sure
> that upstreaam will not allow the following
> possible command line kernel params:
> 
>     brcm,enable-l1ss
>     pci=brcm,entable-l1ss
> 
> Bjorn suggested using the  documented but (IMO) obscure  and  rarely
> used  format
> 
>     pci=[<domain>:]<bus>:<dev>.<func>[/<dev>.<func>]*pci:<vendor>:<device>[:<subvendor>:<subdevice>]
> 
> but this is just going in the wrong direction; here's why.  Using the
> above iformat s completely dependent on the
> PCI "linux-domaiin"  property,  a non-HW related DT property I  might
> add.  Since "linux-domain" is already
> a valid and well-used  DT property, and the value of  the above
> command line format is dependent
> on the value of the "linux-domain", why not be consistent and let
> "brcm,enable-l1ss" be a Broadcom specific property?

I am just asking to add a module_param to the host controller driver.

Anyway - time is running out for v6.6, I need Rob's feedback, if I don't
hear from him today I will merge the last three patches and postpone the
discussion.

Thanks,
Lorenzo

> 
> Regards,
> Jim Quinlan
> Broadcom STB/CM
> 
> 
> >
> > Thanks,
> > Lorenzo
> >
> > >
> > > Regards,
> > > Jim
> > >
> > > > Again - it depends on what DT should be used for, I am not claiming to
> > > > have any authority on that, just asking.
> > > >
> > > > Thanks,
> > > > Lorenzo
> > > >
> > > > > +      using a mini-card connector, this mode may not meet the
> > > > > +      TCRLon maximum time of 400ns, as specified in 3.2.5.2.2
> > > > > +      of the PCI Express Mini CEM 2.0 specification.
> > > > > +    type: boolean
> > > > > +
> > > > >    brcm,scb-sizes:
> > > > >      description: u64 giving the 64bit PCIe memory
> > > > >        viewport size of a memory controller.  There may be up to
> > > > > --
> > > > > 2.17.1
> > > > >
> > > >
> > > >
> >
> >


