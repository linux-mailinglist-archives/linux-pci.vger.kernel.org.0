Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9F7786C9B
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 12:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238544AbjHXKN3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 06:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240830AbjHXKNH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 06:13:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0573198A;
        Thu, 24 Aug 2023 03:13:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AB6C64415;
        Thu, 24 Aug 2023 10:13:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4E3C433C8;
        Thu, 24 Aug 2023 10:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692871983;
        bh=4UDSCTf4UzQ5mpd8+4A0j7OY2qBf4OTnvs5eIzuBsHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IbOV1urTSkudunwOCH1Ibv38fRYfnw7bT5+LQfIchxJd71hR54VeyBEWuAyr6RM/f
         bk6awpjFKXaodurv1iBhrMk4svkdySvBiy5AbOgaINsks5l4zUfvD9BF4W4wvaSWyE
         Pgk9rYiGHiIwI+DLyEUVWbWXZ9X+VWCoR4aviSQMzDxjgriFkjjmFNC33ap+Th7zOa
         qKzznRR8T+7j1RPvNCqQuOruCIJcvv2QS80pgjuN0xlSDd1M1riQUO3HbfKBD9gFPS
         M6f3AGQAWUfv1a8OR5mdxezWZ3iFWgzdb0eBxV239XplNc8viCDyiE0dMUnn3+vYbG
         s6SgWI5Kj+2YA==
Date:   Thu, 24 Aug 2023 12:12:55 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
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
Message-ID: <ZOctJ3t1/UPc4kPj@lpieralisi>
References: <20230508220126.16241-1-jim2101024@gmail.com>
 <20230508220126.16241-2-jim2101024@gmail.com>
 <20230823074330.GF3737@thinkpad>
 <CA+-6iNwP+NbAdm0kNxZ5GwyPdTQyOjq7E2O-+mCU4fG-94BKBA@mail.gmail.com>
 <20230823181650.GL3737@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230823181650.GL3737@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 23, 2023 at 11:46:50PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Aug 23, 2023 at 09:09:25AM -0400, Jim Quinlan wrote:
> > On Wed, Aug 23, 2023 at 3:43 AM Manivannan Sadhasivam <mani@kernel.org> wrote:
> > >
> > > On Mon, May 08, 2023 at 06:01:21PM -0400, Jim Quinlan wrote:
> > > > This commit adds the boolean "brcm,enable-l1ss" property:
> > > >
> > > >   The Broadcom STB/CM PCIe HW -- a core that is also used by RPi SOCs --
> > > >   requires the driver probe() to deliberately place the HW one of three
> > > >   CLKREQ# modes:
> > > >
> > > >   (a) CLKREQ# driven by the RC unconditionally
> > > >   (b) CLKREQ# driven by the EP for ASPM L0s, L1
> > > >   (c) Bidirectional CLKREQ#, as used for L1 Substates (L1SS).
> > > >
> > > >   The HW+driver can tell the difference between downstream devices that
> > > >   need (a) and (b), but does not know when to configure (c).  All devices
> > > >   should work fine when the driver chooses (a) or (b), but (c) may be
> > > >   desired to realize the extra power savings that L1SS offers.  So we
> > > >   introduce the boolean "brcm,enable-l1ss" property to inform the driver
> > > >   that (c) is desired.  Setting this property only makes sense when the
> > > >   downstream device is L1SS-capable and the OS is configured to activate
> > > >   this mode (e.g. policy==powersupersave).
> > > >
> > > >   This property is already present in the Raspian version of Linux, but the
> > > >   upstream driver implementation that follows adds more details and
> > > >   discerns between (a) and (b).
> > > >
> > > > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > ---
> > > >  Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > index 7e15aae7d69e..8b61c2179608 100644
> > > > --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > @@ -64,6 +64,15 @@ properties:
> > > >
> > > >    aspm-no-l0s: true
> > > >
> > > > +  brcm,enable-l1ss:
> > > > +    description: Indicates that PCIe L1SS power savings
> > > > +      are desired, the downstream device is L1SS-capable, and the
> > > > +      OS has been configured to enable this mode.  For boards
> > > > +      using a mini-card connector, this mode may not meet the
> > > > +      TCRLon maximum time of 400ns, as specified in 3.2.5.2.2
> > > > +      of the PCI Express Mini CEM 2.0 specification.
> > >
> > > As Lorenzo said, this property doesn't belong in DT. DT is supposed to specify
> > > the hardware capability and not system/OS behavior.
> > 
> > The "brcm,enable-l1ss" does NOT configure the OS behavior.
> > It sets or not a mode bit to enable l1SS HW, whether or not the OS is
> > configured for L1SS.
> > It compensates for a problem in the PCIe core: the HW is not capable
> > of dynamically
> > switching between ASPM modes powersave and superpowersave.  I am actively
> > advocating for our HW to change but that will take years.
> > 
> 
> Okay, then I would say that the property name and commit message were a bit
> misleading. 
> 
> I had briefly gone through the driver patch now. As per my understanding, you
> have 2 modes in hw:
> 
> 1. Clock PM - Refclk will be turned off by the host if CLKREQ# is deasserted by
> the device (driving high) when the link is in L1.
> 
> 2. L1SS - CLKREQ# will be used to decide L1SS entry and exit by the host.
> 
> Till now the driver only supported Clock PM through mode (1) but for supporting
> L1SS you need to enable mode (2). And you are using this property to select mode
> (2) when the L1SS supported devices are connected to the slot. Also, by
> selecting this mode, you are loosing the benefit of mode (1) as both are not
> compatible.
> 
> My suggestion would be to just drop mode (1) and use mode (2) in the driver as
> most of the recent devices should support L1SS (ofc there are exemptions).
> 
> But moving that decision to DT still doesn't seem right to me as the hardware
> supports both modes and you are (ab)using DT to choose one or the other.

Jim ? We need to queue this series as soon as possible, if we don't
reach consensus by this evening I will queue the last three patches
only.

Lorenzo

> - Mani
> 
> > If this flag specifies
> > > whether the PCIe controller supports L1SS or not, then it is fine but apparantly
> > > this specifies that all downstream devices are L1SS capable which you cannot
> > > guarantee unless you poke into their LNKCAP during runtime.
> > Not true at all.  This setting affects only RC and whatever device is
> > connected to its single downstream
> > port.
> > 
> > >
> > > You should handle this in the driver itself.
> > 
> > The driver has no way of knowing if the PCI subsystem is going from power_save
> > to power_supersave or vice-versa -- there is no notification chain for this.  So
> > what you say is not currently possible from the driver's perspective.
> > 
> > Perhaps you would be happy if we changed it to "l1ss-support" in the
> > spirit of the
> > existing "clkreq-support" PCI parameter?
> > 
> > Regards,
> > Jim Quinlan
> > Broadcom STB/CMi
> > 
> > >
> > > - Mani
> > >
> > > > +    type: boolean
> > > > +
> > > >    brcm,scb-sizes:
> > > >      description: u64 giving the 64bit PCIe memory
> > > >        viewport size of a memory controller.  There may be up to
> > > > --
> > > > 2.17.1
> > > >
> > >
> > > --
> > > மணிவண்ணன் சதாசிவம்
> 
> > Date: Tue, 22 Aug 2023 21:01:47 +0000 (UTC)
> > From: Florian Fainelli <messenger@webex.com>
> > To: james.quinlan@broadcom.com
> > Subject: Join me now in my Personal Room
> > 
> > Hello,
> > 
> > Join me now in my Personal Room. 
> > 
> > JOIN WEBEX MEETING
> > https://broadcom.webex.com/join/florian.fainelli  |  490 282 179
> > 
> > 
> > JOIN FROM A VIDEO CONFERENCING SYSTEM OR APPLICATION
> > Dial sip:florian.fainelli@broadcom.webex.com
> > You can also dial 173.243.2.68 and enter your meeting number.
> > 
> > 
> > 
> > Can't join the meeting?
> > https://help.webex.com/docs/DOC-5412
> > 
> > PHONE DIALING GUIDELINES:
> >         - Use Call Me when you are using office phone or Jabber.
> >         - Use Call Using Computer when you are at home or traveling.
> > 
> > In Office Calls:
> > 	- From Broadcom Office: 1-MEETING (1-6338464)
> > 
> > Offsite Numbers Toll (Local) Calls:
> > 	- Canada, Richmond: +1-778-308-4007
> > 	- China: +86-400-819-1044
> > 	- Germany, Munich: +49-892-312-9611
> >         - Germany, Regensburg: +49-(9)419-923-5940
> >         - India: 00-080-0050-1631
> > 	- Israel: +97-239-786-477
> >         - Japan, Tokyo: +81-366-344-937
> >         - Malaysia: +603-2053-5189
> > 	- Singapore: +65-6349-2439
> > 	- South Korea, Seoul: +82-70-4732-0218
> > 	- Taiwan, Taipei: +886-277-047-765
> > 	- US, Denver: +1-720-726-9995
> >         - US, Los Angeles: +1-310-616-5312
> >         - US, Philadelphia: +1-215-305-7603
> > 	- UK, London: +44-207-660-8897
> >         - UK, Manchester: +44-161-619-8089
> > 
> > IMPORTANT NOTICE: Please note that this Webex service allows audio and other information sent during the session to be recorded, which may be discoverable in a legal matter. By joining this session, you automatically consent to such recordings. If you do not consent to being recorded, discuss your concerns with the host or do not join the session.
> 
> 
> 
> 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
