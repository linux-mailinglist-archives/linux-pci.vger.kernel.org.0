Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0513778C7E2
	for <lists+linux-pci@lfdr.de>; Tue, 29 Aug 2023 16:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236182AbjH2Oqm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Aug 2023 10:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237104AbjH2Oqg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Aug 2023 10:46:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7950E1A3;
        Tue, 29 Aug 2023 07:46:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00D9061B76;
        Tue, 29 Aug 2023 14:46:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949A6C433C7;
        Tue, 29 Aug 2023 14:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693320385;
        bh=Wu0JrSkHxk64keNMxXEukarfI1FylnbMH++UFrVPUQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pNxCY4W5J7TVKTnWEpIH6LL/ofOv7VXNzp7DRUziVaVwpCbs/wNLFZqBIpute9oUv
         KB+tsMzxlB6CKTI0qEH8qziTykAlmGoIhifn2fZmLALILd8k6UbVXRcEqEhfpZfMVA
         lnkKxJ7a5uMe1nnJDrAabr//MOvqcFTDpDVfY2/aPyeAtymh8I8H1s9TJqiEAMegGQ
         BKlBQ1xwFIPYVC2kUnDZ2UtUd8uKwEchume7olFB93j1dgz6xD6y0AwuCm0VlKNsy9
         v2eUerAgHDzYB4hMSrlMpyC9M4KbOB9aPlOg1aGSLqQXYCQUEmlAoVyEkVVxkx8/JZ
         OqDOsElEYvMPQ==
Date:   Tue, 29 Aug 2023 20:16:06 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/5] dt-bindings: PCI: brcmstb: Add brcm,enable-l1ss
 property
Message-ID: <20230829144606.GB33903@thinkpad>
References: <20230508220126.16241-1-jim2101024@gmail.com>
 <20230508220126.16241-2-jim2101024@gmail.com>
 <20230823074330.GF3737@thinkpad>
 <CA+-6iNwP+NbAdm0kNxZ5GwyPdTQyOjq7E2O-+mCU4fG-94BKBA@mail.gmail.com>
 <20230823181650.GL3737@thinkpad>
 <CA+-6iNzdYDJqwFofqkdS+iUK4w_s3eY_qa8JpbisyDn+fYg8XA@mail.gmail.com>
 <20230825064505.GA6005@thinkpad>
 <CAL_JsqK7LBLVrw9mF6ksrc70gikbjQe7EAYfLytoVySKxvTd=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqK7LBLVrw9mF6ksrc70gikbjQe7EAYfLytoVySKxvTd=w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 29, 2023 at 07:22:18AM -0500, Rob Herring wrote:
> On Fri, Aug 25, 2023 at 1:45 AM Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > On Thu, Aug 24, 2023 at 10:55:02AM -0400, Jim Quinlan wrote:
> > > On Wed, Aug 23, 2023 at 2:17 PM Manivannan Sadhasivam <mani@kernel.org> wrote:
> > > >
> > > > On Wed, Aug 23, 2023 at 09:09:25AM -0400, Jim Quinlan wrote:
> > > > > On Wed, Aug 23, 2023 at 3:43 AM Manivannan Sadhasivam <mani@kernel.org> wrote:
> > > > > >
> > > > > > On Mon, May 08, 2023 at 06:01:21PM -0400, Jim Quinlan wrote:
> > > > > > > This commit adds the boolean "brcm,enable-l1ss" property:
> > > > > > >
> > > > > > >   The Broadcom STB/CM PCIe HW -- a core that is also used by RPi SOCs --
> > > > > > >   requires the driver probe() to deliberately place the HW one of three
> > > > > > >   CLKREQ# modes:
> > > > > > >
> > > > > > >   (a) CLKREQ# driven by the RC unconditionally
> > > > > > >   (b) CLKREQ# driven by the EP for ASPM L0s, L1
> > > > > > >   (c) Bidirectional CLKREQ#, as used for L1 Substates (L1SS).
> > > > > > >
> > > > > > >   The HW+driver can tell the difference between downstream devices that
> > > > > > >   need (a) and (b), but does not know when to configure (c).  All devices
> > > > > > >   should work fine when the driver chooses (a) or (b), but (c) may be
> > > > > > >   desired to realize the extra power savings that L1SS offers.  So we
> > > > > > >   introduce the boolean "brcm,enable-l1ss" property to inform the driver
> > > > > > >   that (c) is desired.  Setting this property only makes sense when the
> > > > > > >   downstream device is L1SS-capable and the OS is configured to activate
> > > > > > >   this mode (e.g. policy==powersupersave).
> > > > > > >
> > > > > > >   This property is already present in the Raspian version of Linux, but the
> > > > > > >   upstream driver implementation that follows adds more details and
> > > > > > >   discerns between (a) and (b).
> > > > > > >
> > > > > > > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > > > > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > > > > ---
> > > > > > >  Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 9 +++++++++
> > > > > > >  1 file changed, 9 insertions(+)
> > > > > > >
> > > > > > > diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > > > > index 7e15aae7d69e..8b61c2179608 100644
> > > > > > > --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > > > > +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > > > > @@ -64,6 +64,15 @@ properties:
> > > > > > >
> > > > > > >    aspm-no-l0s: true
> > > > > > >
> > > > > > > +  brcm,enable-l1ss:
> > > > > > > +    description: Indicates that PCIe L1SS power savings
> > > > > > > +      are desired, the downstream device is L1SS-capable, and the
> > > > > > > +      OS has been configured to enable this mode.  For boards
> > > > > > > +      using a mini-card connector, this mode may not meet the
> > > > > > > +      TCRLon maximum time of 400ns, as specified in 3.2.5.2.2
> > > > > > > +      of the PCI Express Mini CEM 2.0 specification.
> > > > > >
> > > > > > As Lorenzo said, this property doesn't belong in DT. DT is supposed to specify
> > > > > > the hardware capability and not system/OS behavior.
> > > > >
> > > > > The "brcm,enable-l1ss" does NOT configure the OS behavior.
> > > > > It sets or not a mode bit to enable l1SS HW, whether or not the OS is
> > > > > configured for L1SS.
> > > > > It compensates for a problem in the PCIe core: the HW is not capable
> > > > > of dynamically
> > > > > switching between ASPM modes powersave and superpowersave.  I am actively
> > > > > advocating for our HW to change but that will take years.
> > > > >
> > > >
> > > > Okay, then I would say that the property name and commit message were a bit
> > > > misleading.
> > > >
> > > > I had briefly gone through the driver patch now. As per my understanding, you
> > > > have 2 modes in hw:
> > > >
> > > > 1. Clock PM - Refclk will be turned off by the host if CLKREQ# is deasserted by
> > > > the device (driving high) when the link is in L1.
> > > >
> > > > 2. L1SS - CLKREQ# will be used to decide L1SS entry and exit by the host.
> > >
> > > No, there are three, as enumerated in the commit message of
> > > "PCI: brcmstb: Configure HW CLKREQ# mode appropriate for downstream device"
> > >
> >
> > Yeah, another one is refclk always on.
> >
> > > >
> > > > Till now the driver only supported Clock PM through mode (1) but for supporting
> > > > L1SS you need to enable mode (2). And you are using this property to select mode
> > > > (2) when the L1SS supported devices are connected to the slot. Also, by
> > > > selecting this mode, you are loosing the benefit of mode (1) as both are not
> > > > compatible.
> > > >
> > > > My suggestion would be to just drop mode (1) and use mode (2) in the driver as
> > > > most of the recent devices should support L1SS (ofc there are exemptions).
> > > The disadvantage of this, as stated by the PCIe core HW designer, was
> > > that "doing so means
> > > we cannot enable the Cock Power Management capability since it may run afoul of
> > > the Tclron requirement."
> > >
> >
> > Ok.
> >
> > > I will attempt to press him on exactly what configurations and form
> > > factors would be
> > > vulnerable to this -- he was so convinced that it was a danger that he
> > > is against
> > > making L1SS mode the default.
> > >
> >
> > Hmm. After looking at this problem in detail, it looks to me that you can still
> > use DT but not with the property you proposed. Since these are hardware modes,
> > you can have a single DT property that specifies the mode that the driver can
> > use to configure the hw. It is similar to "phy-mode" property we have for the
> > network controllers.
> >
> > So you should have the property defined as below in binding:
> >
> > brcm,clkreq-mode:
> >   $ref: /schemas/types.yaml#/definitions/uint32
> >   enum: [ 0, 1, 2 ]
> 
> Is this really Broadcom specific?
> 

AFAIU, rest of the controllers do not have issues supporting Clock PM and L1SS
in hw. Neither does the spec define any incompatibility. So to me, this looks
like Broadcom specific.

- Mani

> Rob

-- 
மணிவண்ணன் சதாசிவம்
