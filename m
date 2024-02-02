Return-Path: <linux-pci+bounces-2992-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA13846B38
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 09:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD1F1F2AD0A
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 08:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DE15FDC3;
	Fri,  2 Feb 2024 08:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="Yf+voq//"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D79B5FDB6
	for <linux-pci@vger.kernel.org>; Fri,  2 Feb 2024 08:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863780; cv=none; b=Y89Z9LYPeYG7/q1SNtBTCb+FReraOEhWgmT7S1iWiMX2hTA0rzflDN9l3PWV+mKuFrrm+I2lnQmng66lWNWFD6ej8zRg7J0+o/9sMsRsKxMYz5pAIYrmdZQMapcYd/EUI/cB8k+znRdP8Lk82YTbRXmtW2O+vxReafUkw5n/z0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863780; c=relaxed/simple;
	bh=s5g5tND4VncSJJnpgai+1STmfwY17PR0zOkvpBvqkBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brDcjs4vtZG/Grj76EKtUQiy1YS97gCWEHsveBvtjJoxL6YUaLGg3fA/iRVlNmpK6iXYB1rsAQIMt6Qp9Fd+uLyb2MECxPdPiWIbaMrHHJ/0JMeF8iWIYej+cjlcgZYPznSDeEZC9raU9VA/GIuu13PDDdydHrjuLyExWOJVoY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=Yf+voq//; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-603fdc46852so19169207b3.2
        for <linux-pci@vger.kernel.org>; Fri, 02 Feb 2024 00:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1706863776; x=1707468576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIPMr9gZ2ntFdhqS2A/x2RHH72S8+R3tOzCoETsh9oA=;
        b=Yf+voq//sAGg3WTgaevPYQy0hb2RJg9y1SmIIKJU7lM4x11x609ILkQt1cu2oHjB11
         Z2byK6cWb22h0AieGDxN6hJd5KWDgPQJA+yE1LuhaRujjc9Buj/NH40pWddd0Jbk4daC
         dgXn/5d2kptmSvpFMFiUH//ege/HU9nA4ebB3WOCkxIMXC5K2+ABZ2IDtAbc5OGsTP8O
         3I2bjeCZZCM6vKOVnLHBhJsM667LvF2IgOHAtu0aX9JC9r5/xInNL1adptRErMzJh/Nb
         jxGpHQV4QdGuTlVnuV4KFw3gYHt5vFHRn7YspplLO8TRUpzmPrD9kbnDVEw07Djaa636
         ZlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706863776; x=1707468576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VIPMr9gZ2ntFdhqS2A/x2RHH72S8+R3tOzCoETsh9oA=;
        b=FVKRsbNejBaIFLk6LOe3KFHTEuLIvC2NJrqCMUDl2uWMVfxpbtD0boS+QHmFN6JaTK
         WwOriXJ4jaGdRNOSz6Ud312DGXDchnTnGDncUR7FNXcDcdFfL0zCV+PvWQWDjpwgPWtW
         7y3czC8FYwQURRKnFPACs+zxmAgFYmSxU8lNdHSA1nX8goTAYKKDah1FKtgw7khSaudj
         C4sLUlW7csJ8SE5kc73RwQ6VGu0amTSrRYhZsQHyv56UNwY3QJYQQb5hHsi1CJJpPloz
         NmcdB4Qb6n7V7oIxm7qGiolge2zDGbUEwvb2K2EFCYDlVpDOb/mZGbQCgYu9GhyYfDd0
         UWlQ==
X-Gm-Message-State: AOJu0Ywj9sN4iPMNnjzKVtTXWq45Zd/BwRTslFCmMm7EagBuSBy+PNLQ
	begPByMGnFYCeHrxp4CKQhpHAqAjfBoSC/kBjsv31qqX+42zCDt8pbTRXuzfIY7gkYjnwLoZC6K
	LgaExuCc8DwqhEpDL4qS4YAyGH/zJiO/b7gjcLA==
X-Google-Smtp-Source: AGHT+IF0D39gNrmGTF17Hmk0hB+DrIWvGVp5pVLHi+wF6FPshuZ7YrcQykD87BeYp9GozcMFufqOk9CZnK7/8cpL6D0=
X-Received: by 2002:a25:c782:0:b0:dc2:2f4b:c9d8 with SMTP id
 w124-20020a25c782000000b00dc22f4bc9d8mr7270958ybe.16.1706863776050; Fri, 02
 Feb 2024 00:49:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130095933.14158-1-jhp@endlessos.org> <20240130101335.GU2543524@black.fi.intel.com>
 <CAPpJ_ef4KuZzBaMupH-iW0ricyY_9toa7A4rB2vyeaFu7ROiDA@mail.gmail.com>
 <Zbonprq/1SircQon@x1-carbon> <CAD8Lp47SH+xcCbZ9qdRwrk2KOHNoHUE5AMieVHoSMbVsMrdiNg@mail.gmail.com>
 <ZbrNLxHL03R66PxQ@x1-carbon> <ZbuyVbMEBWKi729y@x1-carbon>
In-Reply-To: <ZbuyVbMEBWKi729y@x1-carbon>
From: Jian-Hong Pan <jhp@endlessos.org>
Date: Fri, 2 Feb 2024 16:49:00 +0800
Message-ID: <CAPpJ_efmzy_FU0urdHDmO5htOBCPaX-T5W+Er7AmWYhqUTwnyA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ata: ahci: Add force LPM policy quirk for ASUS B1400CEAE
To: Niklas Cassel <cassel@kernel.org>
Cc: Daniel Drake <drake@endlessos.org>, Vitalii Solomonov <solomonov.v@gmail.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, David Box <david.e.box@linux.intel.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Nirmal Patel <nirmal.patel@linux.intel.com>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, linux-ide@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Niklas Cassel <cassel@kernel.org> =E6=96=BC 2024=E5=B9=B42=E6=9C=881=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8811:01=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, Jan 31, 2024 at 11:43:59PM +0100, Niklas Cassel wrote:
> > On Wed, Jan 31, 2024 at 07:08:12AM -0400, Daniel Drake wrote:
>
> (snip)
>
> > In libata we perform a reset of the port at boot, see:
> > libata-sata.c:sata_link_hardreset()
> > after writing to SControl, we call
> > libata-core.c:ata_wait_ready() that will poll for the port being ready
> > by calling the check_ready callback.
> > For AHCI, this callback funcion is set to:
> > libahci.c:ahci_check_ready().
> >
> > A reset should take the device out of deep power state and should be
> > sufficient to establish a connection (and that also seems to be the
> > case when not using Intel VMD).
> >
> > However, if you want to debug, I would start by adding prints to
> > libata-sata.c:sata_link_hardreset()
> > libata-core.c:ata_wait_ready()
> > libahci.c:ahci_check_ready().
>
> FWIW, this will dump SStatus.DET every time the check_ready callback func=
tion
> (ahci_check_ready()) is called:
>
>
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 1a63200ea437..0467e150601e 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -1533,6 +1533,12 @@ int ahci_check_ready(struct ata_link *link)
>  {
>         void __iomem *port_mmio =3D ahci_port_base(link->ap);
>         u8 status =3D readl(port_mmio + PORT_TFDATA) & 0xFF;
> +       u32 cur =3D 0;
> +
> +       sata_scr_read(link, SCR_STATUS, &cur);
> +
> +       ata_link_info(link, "BUSY ? %d (status: %#x) SStatus.DET: %#x\n",
> +                     status & ATA_BUSY, status, cur & 0xf);
>
>         return ata_check_ready(status);
>  }

I think I can join the test based on kernel v6.8-rc2, too.

The original ASUS B1400CEAE has only one NVMe SSD.  I prepare the
patch ("ata: ahci: Add force LPM policy quirk for ASUS B1400CEAE") to
fix the power consumption issue for s2idle with enabled VMD.

The patch is a quirk limiting ASUS B1400CEAE only, not generic for the
SATA controller [8086:a0d3].  Then, I install another SATA HDD into
ASUS B1400CEAE for test.  The SATA HDD shows up and works.

$ dmesg | grep SATA
[    0.785120] ahci 10000:e0:17.0: AHCI 0001.0301 32 slots 1 ports 6
Gbps 0x1 impl SATA mode
[    0.785269] ata1: SATA max UDMA/133 abar m2048@0x76102000 port
0x76102100 irq 144 lpm-pol 3
[    1.096684] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)

However, if I simply revert the commit 6210038aeaf4 ("ata: ahci:
Revert "ata: ahci: Add Tiger Lake UP{3,4} AHCI controller"") (fix the
conflict, of course), then the SATA HDD disappears!!?  Both
CONFIG_SATA_MOBILE_LPM_POLICY=3D3 and 0 can reproduce the issue.

$ dmesg | grep SATA
[    0.783211] ahci 10000:e0:17.0: AHCI 0001.0301 32 slots 1 ports 6
Gbps 0x1 impl SATA mode
[    0.783399] ata1: SATA max UDMA/133 abar m2048@0x76102000 port
0x76102100 irq 144 lpm-pol 3
[    1.096685] ata1: SATA link down (SStatus 4 SControl 300)

Here is the dmesg of reverting ("ata: ahci: Revert "ata: ahci: Add
Tiger Lake UP{3,4} AHCI controller"")
https://bugzilla.kernel.org/show_bug.cgi?id=3D217114#c27
The code already includes the debug message in ahci_check_ready() from
Niklas.  However, the dmesg does not show the "BUSY ? ..." from
ahci_check_ready().

From these scenarios mentioned above, they all apply LPM policy to the
SATA controller [8086:a0d3].  But, they apply LPM policy at different
time:
* The patch ("ata: ahci: Add force LPM policy quirk for ASUS
B1400CEAE") applies LPM policy in early ahci_init_one(), which is the
probe callback.
* Reverting 6210038aeaf4 ("ata: ahci: Revert "ata: ahci: Add Tiger
Lake UP{3,4} AHCI controller"") applies LPM policy via "ahci_pci_tbl"
table.

Jian-Hong Pan

