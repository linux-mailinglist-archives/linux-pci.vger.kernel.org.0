Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A5778802A
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 08:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242344AbjHYGph (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 02:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242359AbjHYGpT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 02:45:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322C6CE;
        Thu, 24 Aug 2023 23:45:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB91266278;
        Fri, 25 Aug 2023 06:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80247C433C7;
        Fri, 25 Aug 2023 06:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692945915;
        bh=gla2cfOgvXf1ls+zCWYltqg6BRHQzwcByC74kYvqg6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UesX+i6Czb8Fm6+flVdmaN1fmd5vBVG33llc5K4BHquKlH3823jHE6AUwGJVKFuBw
         pl209ectVdAIOS4RlRXO5/t4DzdBhz0Krc6MbHhARyTQz1C08//D2/K7doZqSaLsde
         /M9zU5NFeg5XrN8X6zcWozLMyjk2VSxjLu9y2A1Sw4CltuQ7Ejma7yBSVCPYaa5FJZ
         RIxFyt87qF91TNu9gg69WWNJNbnD7q2wFOdaEQMqv49Vy8aixpLF11G9SyA76QOduA
         S+j0kV8jOWcmDlkj6cGz0L7qu+nJBmvxfF+2EEhZjR0BJAsRtJVclTVsHJAf5bNBzW
         SnTzWYWFPB7sg==
Date:   Fri, 25 Aug 2023 12:15:05 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
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
        Rob Herring <robh@kernel.org>,
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
Message-ID: <20230825064505.GA6005@thinkpad>
References: <20230508220126.16241-1-jim2101024@gmail.com>
 <20230508220126.16241-2-jim2101024@gmail.com>
 <20230823074330.GF3737@thinkpad>
 <CA+-6iNwP+NbAdm0kNxZ5GwyPdTQyOjq7E2O-+mCU4fG-94BKBA@mail.gmail.com>
 <20230823181650.GL3737@thinkpad>
 <CA+-6iNzdYDJqwFofqkdS+iUK4w_s3eY_qa8JpbisyDn+fYg8XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNzdYDJqwFofqkdS+iUK4w_s3eY_qa8JpbisyDn+fYg8XA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 24, 2023 at 10:55:02AM -0400, Jim Quinlan wrote:
> On Wed, Aug 23, 2023 at 2:17 PM Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > On Wed, Aug 23, 2023 at 09:09:25AM -0400, Jim Quinlan wrote:
> > > On Wed, Aug 23, 2023 at 3:43 AM Manivannan Sadhasivam <mani@kernel.org> wrote:
> > > >
> > > > On Mon, May 08, 2023 at 06:01:21PM -0400, Jim Quinlan wrote:
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
> > > > > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
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
> > > > > +      using a mini-card connector, this mode may not meet the
> > > > > +      TCRLon maximum time of 400ns, as specified in 3.2.5.2.2
> > > > > +      of the PCI Express Mini CEM 2.0 specification.
> > > >
> > > > As Lorenzo said, this property doesn't belong in DT. DT is supposed to specify
> > > > the hardware capability and not system/OS behavior.
> > >
> > > The "brcm,enable-l1ss" does NOT configure the OS behavior.
> > > It sets or not a mode bit to enable l1SS HW, whether or not the OS is
> > > configured for L1SS.
> > > It compensates for a problem in the PCIe core: the HW is not capable
> > > of dynamically
> > > switching between ASPM modes powersave and superpowersave.  I am actively
> > > advocating for our HW to change but that will take years.
> > >
> >
> > Okay, then I would say that the property name and commit message were a bit
> > misleading.
> >
> > I had briefly gone through the driver patch now. As per my understanding, you
> > have 2 modes in hw:
> >
> > 1. Clock PM - Refclk will be turned off by the host if CLKREQ# is deasserted by
> > the device (driving high) when the link is in L1.
> >
> > 2. L1SS - CLKREQ# will be used to decide L1SS entry and exit by the host.
> 
> No, there are three, as enumerated in the commit message of
> "PCI: brcmstb: Configure HW CLKREQ# mode appropriate for downstream device"
> 

Yeah, another one is refclk always on.

> >
> > Till now the driver only supported Clock PM through mode (1) but for supporting
> > L1SS you need to enable mode (2). And you are using this property to select mode
> > (2) when the L1SS supported devices are connected to the slot. Also, by
> > selecting this mode, you are loosing the benefit of mode (1) as both are not
> > compatible.
> >
> > My suggestion would be to just drop mode (1) and use mode (2) in the driver as
> > most of the recent devices should support L1SS (ofc there are exemptions).
> The disadvantage of this, as stated by the PCIe core HW designer, was
> that "doing so means
> we cannot enable the Cock Power Management capability since it may run afoul of
> the Tclron requirement."
> 

Ok.

> I will attempt to press him on exactly what configurations and form
> factors would be
> vulnerable to this -- he was so convinced that it was a danger that he
> is against
> making L1SS mode the default.
> 

Hmm. After looking at this problem in detail, it looks to me that you can still
use DT but not with the property you proposed. Since these are hardware modes,
you can have a single DT property that specifies the mode that the driver can
use to configure the hw. It is similar to "phy-mode" property we have for the
network controllers.

So you should have the property defined as below in binding:

brcm,clkreq-mode:
  $ref: /schemas/types.yaml#/definitions/uint32
  enum: [ 0, 1, 2 ]

Then create definition for each mode in "include/dt-bindings/pci/brcm,stb.h".

#define BRCM_STB_CLKREQ_CLOCK_PM	0
#define BRCM_STB_CLKREQ_L1SS		1
#define BRCM_STB_CLKREQ_ON		2

If the property is not specified, the driver should use "Clock PM" as the
default mode as it was doing earlier.

Also, I think you can get rid of other checks in the driver (like PCIEASPM
Kconfig, clkreq_seen etc...) and solely rely on this property to set the mode.

What do you think?

- Mani

> >
> > But moving that decision to DT still doesn't seem right to me as the hardware
> > supports both modes and you are (ab)using DT to choose one or the other.
> 
> May be true, but there does not appear to be a Linux upstream-acceptable
> way of doing this on the command line either; please see my recent post
> on why this is so.
> 
> There will be cases where we want to override the default setting, either by
> command line or DT, but you folks have to give me a viable path on
> how to do this with it actually being accepted.
> 
> Regards,
> Jim Quinlan
> Broadcom STB/CM
> 
> >
> > - Mani
> >
> > > If this flag specifies
> > > > whether the PCIe controller supports L1SS or not, then it is fine but apparantly
> > > > this specifies that all downstream devices are L1SS capable which you cannot
> > > > guarantee unless you poke into their LNKCAP during runtime.
> > > Not true at all.  This setting affects only RC and whatever device is
> > > connected to its single downstream
> > > port.
> > >
> > > >
> > > > You should handle this in the driver itself.
> > >
> > > The driver has no way of knowing if the PCI subsystem is going from power_save
> > > to power_supersave or vice-versa -- there is no notification chain for this.  So
> > > what you say is not currently possible from the driver's perspective.
> > >
> > > Perhaps you would be happy if we changed it to "l1ss-support" in the
> > > spirit of the
> > > existing "clkreq-support" PCI parameter?
> > >
> > > Regards,
> > > Jim Quinlan
> > > Broadcom STB/CMi
> > >
> > > >
> > > > - Mani
> > > >
> > > > > +    type: boolean
> > > > > +
> > > > >    brcm,scb-sizes:
> > > > >      description: u64 giving the 64bit PCIe memory
> > > > >        viewport size of a memory controller.  There may be up to
> > > > > --
> > > > > 2.17.1
> > > > >
> > > >
> > > > --
> > > > மணிவண்ணன் சதாசிவம்
> >
> > > Date: Tue, 22 Aug 2023 21:01:47 +0000 (UTC)
> > > From: Florian Fainelli <messenger@webex.com>
> > > To: james.quinlan@broadcom.com
> > > Subject: Join me now in my Personal Room
> > >
> > > Hello,
> > >
> > > Join me now in my Personal Room.
> > >
> > > JOIN WEBEX MEETING
> > > https://broadcom.webex.com/join/florian.fainelli  |  490 282 179
> > >
> > >
> > > JOIN FROM A VIDEO CONFERENCING SYSTEM OR APPLICATION
> > > Dial sip:florian.fainelli@broadcom.webex.com
> > > You can also dial 173.243.2.68 and enter your meeting number.
> > >
> > >
> > >
> > > Can't join the meeting?
> > > https://help.webex.com/docs/DOC-5412
> > >
> > > PHONE DIALING GUIDELINES:
> > >         - Use Call Me when you are using office phone or Jabber.
> > >         - Use Call Using Computer when you are at home or traveling.
> > >
> > > In Office Calls:
> > >       - From Broadcom Office: 1-MEETING (1-6338464)
> > >
> > > Offsite Numbers Toll (Local) Calls:
> > >       - Canada, Richmond: +1-778-308-4007
> > >       - China: +86-400-819-1044
> > >       - Germany, Munich: +49-892-312-9611
> > >         - Germany, Regensburg: +49-(9)419-923-5940
> > >         - India: 00-080-0050-1631
> > >       - Israel: +97-239-786-477
> > >         - Japan, Tokyo: +81-366-344-937
> > >         - Malaysia: +603-2053-5189
> > >       - Singapore: +65-6349-2439
> > >       - South Korea, Seoul: +82-70-4732-0218
> > >       - Taiwan, Taipei: +886-277-047-765
> > >       - US, Denver: +1-720-726-9995
> > >         - US, Los Angeles: +1-310-616-5312
> > >         - US, Philadelphia: +1-215-305-7603
> > >       - UK, London: +44-207-660-8897
> > >         - UK, Manchester: +44-161-619-8089
> > >
> > > IMPORTANT NOTICE: Please note that this Webex service allows audio and other information sent during the session to be recorded, which may be discoverable in a legal matter. By joining this session, you automatically consent to such recordings. If you do not consent to being recorded, discuss your concerns with the host or do not join the session.
> >
> >
> >
> >
> >
> > --
> > மணிவண்ணன் சதாசிவம்



-- 
மணிவண்ணன் சதாசிவம்
