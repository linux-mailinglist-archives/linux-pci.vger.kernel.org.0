Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD8E65893E
	for <lists+linux-pci@lfdr.de>; Thu, 29 Dec 2022 04:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiL2Dq2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Dec 2022 22:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbiL2DqO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Dec 2022 22:46:14 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210B5101B
        for <linux-pci@vger.kernel.org>; Wed, 28 Dec 2022 19:46:09 -0800 (PST)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 65428418CA
        for <linux-pci@vger.kernel.org>; Thu, 29 Dec 2022 03:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1672285565;
        bh=RFBri1/C6XWJIWHmNZmgx9fF0TydY2X7i7krS6xCGok=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=VXS8RE9LZQMKVitVFwTtov7QGo26CNLIW4SbPQ5EDTrGrvyj5sAIVLRKeXqPVm6Aa
         P//M1oqgR+2tH/cDHbu5eOHeXtTFnkiZOJ7mKkTSyno7R8ZBAxp984Tmq1P26BKIpA
         EqpDpyZc6KYEC8LrEGKNCzOdOdv5Iz+Eszy1IZ8k9p93pndGD4ErImWj4By6Mg7eXz
         5FNpNA1+0iTYyz/HBtpXBUKF4VkMoRXMWlzKKtvLxp/ujNx3qdEvlETafoSXEF+Q9G
         FbsTCOpFuoat/YttRdWeCQtveBXiKN7K44YX1sMYoz9k/bGV4WuEQ6jno0WKMubXbg
         VBkZOLPvHKcJg==
Received: by mail-pj1-f69.google.com with SMTP id v17-20020a17090abb9100b002239a73bc6eso13423159pjr.1
        for <linux-pci@vger.kernel.org>; Wed, 28 Dec 2022 19:46:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFBri1/C6XWJIWHmNZmgx9fF0TydY2X7i7krS6xCGok=;
        b=5mIFJcAHLGFPCMjzqrEukPilmSInwqtHlAyYM6F24RdU7h9RrogAaCfQE0OeRTo4RR
         LvP/DJwKtJQlQec59fFybwjObdjCY4mX8LM0tiupAA2tLNtLORj5ccro4zVJH0m+AWAN
         d7qRWEZcX9NDBnAsCPlbK20wYyDotuG+4TMXnrM7VCnDGber5sj26NiIu5BJ5kLRWJVG
         dlWMm9jd2O6hkoQ4Y9XT48huBN3a/gPjC4L9z/QeT5iIXvJRoDRpoF2ORpEceGsYU/fo
         fyYCRXfqVbZ5COw6Sb2IReXe1qqBFGjAOg18VM6vMr3jZoak+P+cRmxwK1arSqCuaqfO
         fFJQ==
X-Gm-Message-State: AFqh2kr9sxQr70ZcXZ/D4Gm9tdX5XfQr1sniMMin1LaWCQO/unsFpWyz
        9n1/ElpQ+Ed+AiY5l1X3pjWZdpfLgZ10Iu9fBfYPOeJGDp6B+oSRCPUxHbaQnKIKfmCYm6SHJTi
        exas4shJdT07JUfk8ECLwmn2EAQ9GWmenO6wU7R30if1du4R53PjElw==
X-Received: by 2002:a17:90b:264d:b0:226:1564:643c with SMTP id pa13-20020a17090b264d00b002261564643cmr474414pjb.206.1672285563454;
        Wed, 28 Dec 2022 19:46:03 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuZDH/ySYGVdLb0dLFu62JfA0mByMF0OPZEdLl2IGY8zLoFnI2QBZcW6QKGxsACMpKHzo52W+IbkzqHGBUWK4g=
X-Received: by 2002:a17:90b:264d:b0:226:1564:643c with SMTP id
 pa13-20020a17090b264d00b002261564643cmr474408pjb.206.1672285563008; Wed, 28
 Dec 2022 19:46:03 -0800 (PST)
MIME-Version: 1.0
References: <20221226153048.1208359-1-kai.heng.feng@canonical.com> <20221226154643.kidhqooedmijj3iw@pali>
In-Reply-To: <20221226154643.kidhqooedmijj3iw@pali>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 29 Dec 2022 11:45:51 +0800
Message-ID: <CAAd53p4CU+K5sOumJYxENRE-Ci7zPKxk0ROszvBUPWV=1xYZyw@mail.gmail.com>
Subject: Re: [PATCH] PCI/portdrv: Avoid enabling AER on Thunderbolt devices
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     bhelgaas@google.com, Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Stefan Roese <sr@denx.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Pali,


On Mon, Dec 26, 2022 at 11:46 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Monday 26 December 2022 23:30:31 Kai-Heng Feng wrote:
> > We are seeing igc ethernet device on Thunderbolt dock stops working
> > after S3 resume because of AER error, or even make S3 resume freeze:
>
> Hello! Is igc ethernet the only device which does not work after resume?

Seems so.
A Thunderbolt NVMe enclosure plugged to the dock doesn't exhibit this
issue. I don't have an eGPU to try.

> Or do you have also more devices to test and check for this issue?
>
> I'm asking it just because to know if we are dealing with one device or
> there are lot of more. Because if it is just one device then it could be
> better to disable AER only for one targeted device instead of all. Error
> reporting is a feature which may help to detect broken HW unit and be use=
ful.
>
> > pcieport 0000:00:1d.0: AER: Multiple Corrected error received: 0000:00:=
1d.0
> > pcieport 0000:00:1d.0: PCIe Bus Error: severity=3DCorrected, type=3DTra=
nsaction Layer, (Receiver ID)
> > pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=3D0000800=
0/00002000
> > pcieport 0000:00:1d.0:    [15] HeaderOF
> > pcieport 0000:00:1d.0: AER: Multiple Uncorrected (Non-Fatal) error rece=
ived: 0000:00:1d.0
> > pcieport 0000:00:1d.0: PCIe Bus Error: severity=3DUncorrected (Non-Fata=
l), type=3DTransaction Layer, (Requester ID)
> > pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=3D0010000=
0/00004000
> > pcieport 0000:00:1d.0:    [20] UnsupReq               (First)
> > pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 0a000052 00000000 00=
000000
> > pcieport 0000:00:1d.0: AER:   Error of this Agent is reported first
> > pcieport 0000:04:01.0: PCIe Bus Error: severity=3DUncorrected (Non-Fata=
l), type=3DTransaction Layer, (Requester ID)
> > pcieport 0000:04:01.0:   device [8086:1136] error status/mask=3D0030000=
0/00000000
> > pcieport 0000:04:01.0:    [20] UnsupReq               (First)
> > pcieport 0000:04:01.0:    [21] ACSViol
> > pcieport 0000:04:01.0: AER:   TLP Header: 34000000 04000052 00000000 00=
000000
> > thunderbolt 0000:05:00.0: AER: can't recover (no error_detected callbac=
k)
> >
> > This supposedly should be fixed by commit c01163dbd1b8 ("PCI/PM: Always=
 disable
> > PTM for all devices during suspend"), but somehow it doesn't work for
> > this case.
> >
> > By dumping the PCI_PTM_CTRL register on resume, it turns out PTM is
> > already flipped on by either the Thunderbolt dock firmware or the host
> > BIOS. Writing 0 to PCI_PTM_CTRL yields the same result.
> >
> > Windows is however not affected by this issue, by using WinDbg's !pci
> > command, it shows that AER is not enabled for devices connected via
> > Thunderbolt port, and that's the reason why Windows doesn't exhibit the
> > issue.
>
> Could you try to manually enable AER on Windows (via touching PCIe
> config registers) if Windows can trigger this issue too, or not?

Actually I misread the output of WinDbg !pci command, the AER is also
enabled under Windows.
!pci command also shows the same PTM error in Header Log. I can also
find the AER warnings in Windows' Event Viewer.

I am asking hardware vendor to see if it's possible to fix it at firmware s=
ide.

However, on Windows the ACS is disabled for all downstream ports in
the dock, so unlike Linux there's no ACS violation.
That can be the reason why the igc device continues to work on Windows
despite AER errors.

So yes, this patch is wrong. Let me dig this issue a bit more.

Kai-Heng

>
> > So turn a blind eye on external Thunderbolt devices like Windows does b=
y
> > disabling AER.
> >
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D216850
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
> > @@ -237,7 +237,8 @@ static int get_port_device_capability(struct pci_de=
v *dev)
> >       if ((pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ROOT_PORT ||
> >               pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_RC_EC) &&
> >           dev->aer_cap && pci_aer_available() &&
> > -         (pcie_ports_native || host->native_aer))
> > +         (pcie_ports_native || host->native_aer) &&
> > +         !dev_is_removable(&dev->dev))
> >               services |=3D PCIE_PORT_SERVICE_AER;
> >  #endif
> >
> > --
> > 2.34.1
> >
