Return-Path: <linux-pci+bounces-23516-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E4DA5E1B8
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 17:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90917189964C
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 16:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB131C84AA;
	Wed, 12 Mar 2025 16:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWulS/s2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F2C1BB6BA;
	Wed, 12 Mar 2025 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741796753; cv=none; b=UmMONqlHkca3YEY+/lKljJO0gh9uAKGNd2/gq48Lv6ad0WG0EX7WSNkiXT6gTyEPrFPCD9wEfxJKOhE3kZhEGdifs+65p/qgZawTsfhW8NhSqHRwBLSKgP2oYHcBdiKq9sRCdPwd6Xr25M5S1WTJqSs/JCOgM1QNbZCPCmnsjAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741796753; c=relaxed/simple;
	bh=rY90rxIHmvPsvvolgFWb7qVxE7QcpDDHoiyqQQmLaAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k2rRdt2QAxnPpYLdSXeSsDwka2asAs1/sp79EMViQn3d+DKJKKdF/vEiPtS9BU0LTwBaGi4bgUEJrgmytY4z01oX4C55vY6f/ffKhDu5UwJpHR6xSc0W599kzgKcMmbA/T4Xm5e05Z6LevHCCfN469B2Xwuy3WPxl/3v2LgL/Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWulS/s2; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ff797f8f1bso106111a91.3;
        Wed, 12 Mar 2025 09:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741796751; x=1742401551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/i7DPvhWab5Hq2eXZ422jNKr+4Oovnt6cmD31Zbe+M=;
        b=BWulS/s2zVKh1rPSBmOqRtYWaxGoa1VNySRBy7NUK26Q0pu59p1Jv9TOUFW1+uRqm5
         YW3T9f2LHZl6ULsxLY9bYrEOVUKTqhzssHo5WDScPvhF04UOnhivAAmwr3G1l5eJQWN1
         wchVt76yHwI3G6cfYhsrCWHDyF1XtKIsBiQtGoDKTUte0j7XHWYDrXqdLSOP/u9AiErz
         ha+80uOEsBF44aaeGkPUOTDRFl4KQ5TpOCyzbVtpYuymrRsJlN48VbPdzc9CX6kqBtFc
         aTKoblLw7PAbGLKEuIP/viKgS7uWbHaPilzVneaaz4VHD+eO/FNIspRJAXHcMqioz2am
         RxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741796751; x=1742401551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/i7DPvhWab5Hq2eXZ422jNKr+4Oovnt6cmD31Zbe+M=;
        b=OcRJNy8RzC4R66ttdg/zxWMLMOZD6wXrLtD8aOSFIhaS0e1AKJK+/BNDZcFz3uXS6l
         zmDn82Q15973PwSby8QDsGgYGjtBeDULIxleGl6qTRvEVZToFnUxIgNhRM+4oGg4wv67
         2BRMU/JeyikYgkHXVmOk6n+b4UXwd00iV4p6lWghrFJ17pqoxlIHfrHqpAjpoAK/Fb9w
         BPcOBlVQ09Q35bWt+shzibDWSxWZp3Cei5MBCHc6JDJUx0ZeOetnEMoI1ut7oNnGYrkL
         kInfDVDmGRXUOgafea9hZYcTmUO4ZIg3siYk+65NsXDkP4h8F3pqdf27H25FKXIOMrI2
         XSQA==
X-Forwarded-Encrypted: i=1; AJvYcCUlzzJEsRM7DrpJCddFmEMcawMh+rNW25uXF3opbilXtTWUpwoUFtIU+3kC5t8dYPur52RSvBro4quD@vger.kernel.org, AJvYcCX5CFmi2VjcOL+795KomqHnlWU2TWXT7+0IJAHK0RSc98VlQvgd4R1bIPqPNQBmPo7vuip6v/KdV5YLptQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXt4gErhzUEFKqGeM5EQhPYQR0KR1If0do9yAJdFTl+4vjjdyX
	7RsfXTeGOp51LGt42FjcjcQudUUZoGDY0+rCbYDcULeCzY4fgsxYy2E0J5n7ZnMBjxi9f3jIUir
	BqQl+mTtRGVc2TRwA3ciaBRguEbI=
X-Gm-Gg: ASbGncsnY0zpGvH27fOlibiZKddG5nph0PYQ+phK3W+riqzCEv6rzIIhJxFgDMx+/WF
	UVp3r5OxCLOoq+iqqv4Cy3to+sqJ4FCLwUh/3b3VijqVhFssM958z1YOSL2pyas6C+/fqZldF9g
	5m0hjJw5UQiaTsuSAoBY3VWCav0l+ozNJCJ6cuDg==
X-Google-Smtp-Source: AGHT+IGGNvtDVGbaRdv7e3eXGPnCVv/thHnNgRe3wqpo/kD9EOMG3yTX/dEe0Mfvgr4Yj+X9oUJuXKjRW1qd0l/98tY=
X-Received: by 2002:a05:6a21:2d8d:b0:1f3:48d5:7303 with SMTP id
 adf61e73a8af0-1f58cbc54b8mr14596645637.31.1741796749230; Wed, 12 Mar 2025
 09:25:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEzXK1qwHf5no6B2eCX1U7NGe-BoJYFLTHPkbM=_XpgrMAE2dw@mail.gmail.com>
 <20250311162407.GA630741@bhelgaas>
In-Reply-To: <20250311162407.GA630741@bhelgaas>
From: =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date: Wed, 12 Mar 2025 16:25:37 +0000
X-Gm-Features: AQ5f1Jqh0CCuMTOHdwiQU-EqZBpshIAwzoCDcB9ApKgmCrO6S2HMibkvZtBdmQE
Message-ID: <CAEzXK1o52evH1RhQpe3CuD=MoHiMk0gC32Gxw7RpSMMGWzyH8Q@mail.gmail.com>
Subject: Re: [PATCH] PCI: mvebu: Use devm_request_irq() for registering
 interrupt handler
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bjron,

Yes, I had trouble finding PCIe cards to test with Solidrun Clearfog
Base mPCIe slot and indeed the Coral Edge TPU card does not have an
open-source driver and the proprietary one that exists does not work
in 32-bit architectures. So, yes it had no driver.

I have now connected a mPCIe to PCIe extender and installed a Marvell
4-port SATA controller card and I will also include my Armada Duo
system which is based on a Solidrun A388 SoM anyway and the Clearfog
Base logs hope this  information further helps with the analysis,

So for Solidrun Clearfog Base with Kernel 6.14-rc5 we have:
dmesg output: https://pastebin.com/aw0X9Fb5
lspci -vv: https://pastebin.com/5mDHJZ2C
cat /proc/interrupts: https://pastebin.com/ASHN8cx7
grep -r . /proc/irq: https://pastebin.com/mskASwYL
decompiled armada-388-clearfog-base.dtb: https://pastebin.com/KuNFDmYP

------------------------------------------------------
For PowerInno ArmadaDuo (2-slots PCIe) with Kernel 6.8.9 we have:
dmesg output: https://pastebin.com/54HHrPVP
lspci -vv: https://pastebin.com/KpE6Hc0r
cat /proc/interrupts: https://pastebin.com/6L64ztse
grep -r . /proc/irq: https://pastebin.com/raPkRBVk

Best Regards,
Lu=C3=ADs

On Tue, Mar 11, 2025 at 4:24=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Sun, Mar 09, 2025 at 11:10:58PM +0000, Lu=C3=ADs Mendes wrote:
> > All logs presented were obtained from a SolidRun A388 ClearFog Base,
> > if more detailed PCI logs are needed I have the other machine, the
> > Armada Duo that has 2 PCIe slots and handles an AMD RX 550 GPU. Just
> > let me know.
> >
> > - Complete dmesg log, booted with "pci=3Dnomsi"  is available here:
> > https://pastebin.com/wDj0NGFN
> > - Complete output of "sudo lspci -vv" is available here:
> > https://pastebin.com/f4yHRhLr
> > - Contents of /proc/interrupts is available here: https://pastebin.com/=
ejDUuhbJ
> > - Output of "grep -r . /proc/irq/" is available here:
> > https://pastebin.com/4jvFBBhy
>
> Thank you very much for these.
>
> It looks like the only PCI device is 01:00.0: [1ac1:089a], a Coral
> Edge TPU, and I don't see any evidence of a driver for it or any IRQ
> usage.  Do you have any other PCI device you could try there?
> Something with a driver that uses interrupts?
>
> Not critical right now, but I'm puzzled by this part of the dmesg log:
>
>   mvebu-pcie soc:pcie: host bridge /soc/pcie ranges:
>   mvebu-pcie soc:pcie:      MEM 0x00f1080000..0x00f1081fff -> 0x000008000=
0
>   mvebu-pcie soc:pcie:      MEM 0x00f1040000..0x00f1041fff -> 0x000004000=
0
>   mvebu-pcie soc:pcie:      MEM 0x00f1044000..0x00f1045fff -> 0x000004400=
0
>   mvebu-pcie soc:pcie:      MEM 0x00f1048000..0x00f1049fff -> 0x000004800=
0
>   pci_bus 0000:00: root bus resource [mem 0xf1080000-0xf1081fff] (bus add=
ress [0x00080000-0x00081fff])
>   pci_bus 0000:00: root bus resource [mem 0xf1040000-0xf1041fff] (bus add=
ress [0x00040000-0x00041fff])
>   pci_bus 0000:00: root bus resource [mem 0xf1044000-0xf1045fff] (bus add=
ress [0x00044000-0x00045fff])
>   pci_bus 0000:00: root bus resource [mem 0xf1048000-0xf1049fff] (bus add=
ress [0x00048000-0x00049fff])
>   pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff]
>
> The first four mvebu-pcie lines make good sense and match the
> first four pci_bus lines.  But I don't know where the
> [mem 0xe0000000-0xe7ffffff] aperture came from.  It should be
> described in the devicetree, but I don't see it mentioned in the
> /soc/pcie ranges.
>
> Can you include the devicetree as well?

