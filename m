Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A284658967
	for <lists+linux-pci@lfdr.de>; Thu, 29 Dec 2022 05:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbiL2E0x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Dec 2022 23:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbiL2E0v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Dec 2022 23:26:51 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B4A10C
        for <linux-pci@vger.kernel.org>; Wed, 28 Dec 2022 20:26:49 -0800 (PST)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 93065445B3
        for <linux-pci@vger.kernel.org>; Thu, 29 Dec 2022 04:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1672288007;
        bh=h/KnO9804k/G0ANgwnUXrRLhABXcv9swhnywHJA4Q/k=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=EGVsP6cL+VATZN+g6w2Pt+BI1SNVIdZHBc4oqkXAebQshMRG+aPS9na7uQvhGFfMw
         pYeVsWtVJVCK2iqTWKOy3eu+MnHaat1ebhxSCjGa7vrdKCJQQ+ZI7tgaw3UE/MDgTk
         OYUnMIymzHqwquNIrTl/52rHzJ0Se2obiwPRFKe+r/dQ9nvzuMUCRZngu/bk2EjLNZ
         LzNyVs98A95H7B/vIqXflI7fusltEeECSL90feqxaPVgeWrzL7v96JTreLF+NwnM33
         7d0zH4eGgn99ejHTx8OPvNQyAp534ZwPaGn+wn9HdNDq3NjtgQ+spKpOHbB9XY9lm1
         q2+LmeEw0Z2KQ==
Received: by mail-pf1-f197.google.com with SMTP id z16-20020a056a001d9000b0057d4ebe9513so9180166pfw.22
        for <linux-pci@vger.kernel.org>; Wed, 28 Dec 2022 20:26:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/KnO9804k/G0ANgwnUXrRLhABXcv9swhnywHJA4Q/k=;
        b=4B9KkIVIVyQffPj9tJx2cvWOyd0EwU5jcIyLD5WZgLueOzjl8/RFO1NU82zBFQNh2S
         zQZBFto/qjnp/glFkN2cic0CG63iNDpqiaDKcIOwlUO3NcLWJRkSdGTAegJPH48OcF/C
         uMGFZ1Fn/iu2pZrqZofyj5yktMJpw6t3GrF2CrUNbItZ0hVfIPL3K8BEfdGQxT0htBiX
         J/Pjd6ZP7/doPpzNI+EDJ03QEJgUPENoLaDeQTh7gm0vBpiMF1JiFUsFJPeWANAJIpQA
         R7nHGBtbVmfYP+gLw1WHjW2kOZwfYS3Ry5m/AzbIMk/qMWcDWhgXZ4ncOEC/hF/3AdRo
         nM3w==
X-Gm-Message-State: AFqh2kpL1w9ru4Cg1qkqQMZFj040Kz669c2wVfpB2gKmkUVpHpnRZBit
        GhHEGz76jMdI48flqEE+zDz+oBpiIwAkscFwQ3wFS+glnoO+D07BlZJMx2F+26OVw3Lcm9rgCLO
        UTIHz1HsyOLvtnHKPoPmihazo6h9y5uTay3Zs4/BgtwVZ+5eTx8PVFg==
X-Received: by 2002:a62:5e44:0:b0:576:af2d:4c4d with SMTP id s65-20020a625e44000000b00576af2d4c4dmr1722905pfb.69.1672288005701;
        Wed, 28 Dec 2022 20:26:45 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuM9UYhGiric0aikn1KEG4Oqkm3D18jNrtqP3adjypRkT7mW9I3ssB4c0s7s319ZxFMt6FFs8hOk4wiyfmqOVY=
X-Received: by 2002:a62:5e44:0:b0:576:af2d:4c4d with SMTP id
 s65-20020a625e44000000b00576af2d4c4dmr1722897pfb.69.1672288005268; Wed, 28
 Dec 2022 20:26:45 -0800 (PST)
MIME-Version: 1.0
References: <20221226153048.1208359-1-kai.heng.feng@canonical.com> <20221226225045.GA400369@bhelgaas>
In-Reply-To: <20221226225045.GA400369@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 29 Dec 2022 12:26:33 +0800
Message-ID: <CAAd53p6pt462kcKeh6gaqU0fwTjFp+2zquCQfUHzyW5jRhfC6A@mail.gmail.com>
Subject: Re: [PATCH] PCI/portdrv: Avoid enabling AER on Thunderbolt devices
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Stefan Roese <sr@denx.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David E. Box" <david.e.box@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Tue, Dec 27, 2022 at 6:50 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc David]
>
> Hi Kai-Heng,
>
> Thanks for the report and the debugging!
>
> On Mon, Dec 26, 2022 at 11:30:31PM +0800, Kai-Heng Feng wrote:
> > We are seeing igc ethernet device on Thunderbolt dock stops working
> > after S3 resume because of AER error, or even make S3 resume freeze:
> > pcieport 0000:00:1d.0: AER: Multiple Corrected error received: 0000:00:1d.0
> > pcieport 0000:00:1d.0: PCIe Bus Error: severity=Corrected, type=Transaction Layer, (Receiver ID)
> > pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00008000/00002000
> > pcieport 0000:00:1d.0:    [15] HeaderOF
> > pcieport 0000:00:1d.0: AER: Multiple Uncorrected (Non-Fatal) error received: 0000:00:1d.0
> > pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> > pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00100000/00004000
> > pcieport 0000:00:1d.0:    [20] UnsupReq               (First)
> > pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 0a000052 00000000 00000000
>
> From a very quick look, I think 34...... ......52 is a PTM message (as
> you suggest below).
>
> > pcieport 0000:00:1d.0: AER:   Error of this Agent is reported first
> > pcieport 0000:04:01.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> > pcieport 0000:04:01.0:   device [8086:1136] error status/mask=00300000/00000000
> > pcieport 0000:04:01.0:    [20] UnsupReq               (First)
> > pcieport 0000:04:01.0:    [21] ACSViol
> > pcieport 0000:04:01.0: AER:   TLP Header: 34000000 04000052 00000000 00000000
> > thunderbolt 0000:05:00.0: AER: can't recover (no error_detected callback)
> >
> > This supposedly should be fixed by commit c01163dbd1b8 ("PCI/PM: Always disable
> > PTM for all devices during suspend"), but somehow it doesn't work for
> > this case.
> >
> > By dumping the PCI_PTM_CTRL register on resume, it turns out PTM is
> > already flipped on by either the Thunderbolt dock firmware or the host
> > BIOS. Writing 0 to PCI_PTM_CTRL yields the same result.
>
> Can you share your debug patch and corresponding dmesg log in the
> bugzilla?

Actually Windows has the same PTM issue too like what I replied to
Pali's message.

>
> > Windows is however not affected by this issue, by using WinDbg's !pci
> > command, it shows that AER is not enabled for devices connected via
> > Thunderbolt port, and that's the reason why Windows doesn't exhibit the
> > issue.
> >
> > So turn a blind eye on external Thunderbolt devices like Windows does by
> > disabling AER.
>
> Unless there's something in the PCIe or Thunderbolt spec that says AER
> shouldn't be used on external devices, I think we need to figure out
> the root cause before disabling AER on all removable devices.

You are right.

The most outstanding difference I can find is that the ACS is disabled
for all TBT dock's downstream ports.
So the ACS violation probably doesn't happen under Windows.

However the PTM message is still considered as Uncorrected error, so
the AER reset still happens on device resume.

I think when the reset happens (i.e. pcie_do_recovery()), the device
resume should be skipped. Not sure how to achieve that in a non-racy
way though.

>
> The dmesg in the bugzilla below is from an HP ZBook Fury 16.  Do you
> see this on any other platforms?  Do you have any HP BIOS contacts to
> ask about this?
>
> It seems like a firmware defect to enable PTM without knowing whether
> upstream devices have PTM enabled.

Yes, just raised the issue to HP.

>
> We could leave PTM enabled on upstream devices when suspending, but
> that apparently prevents some low-power states.  Adding David since he
> worked on that.

Leaving PTM enabled makes the system unable to suspend.

Kai-Heng

>
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=216850
> > Cc: Mario Limonciello <mario.limonciello@amd.com>
> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/pci/pcie/portdrv.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> > index 2cc2e60bcb396..59d00e20e57bf 100644
> > --- a/drivers/pci/pcie/portdrv.c
> > +++ b/drivers/pci/pcie/portdrv.c
> > @@ -237,7 +237,8 @@ static int get_port_device_capability(struct pci_dev *dev)
> >       if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> >               pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
> >           dev->aer_cap && pci_aer_available() &&
> > -         (pcie_ports_native || host->native_aer))
> > +         (pcie_ports_native || host->native_aer) &&
> > +         !dev_is_removable(&dev->dev))
> >               services |= PCIE_PORT_SERVICE_AER;
> >  #endif
> >
> > --
> > 2.34.1
> >
