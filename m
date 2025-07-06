Return-Path: <linux-pci+bounces-31586-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA9AAFA761
	for <lists+linux-pci@lfdr.de>; Sun,  6 Jul 2025 20:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FBD01885177
	for <lists+linux-pci@lfdr.de>; Sun,  6 Jul 2025 18:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39175199934;
	Sun,  6 Jul 2025 18:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwH9AZ/7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9921459FA;
	Sun,  6 Jul 2025 18:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751827714; cv=none; b=nYqH4fWTDSGLSKj88yEOgnwVbweU/mPcu3QucJRCaZoxhv2bYueX/hUNPzLEVGhef7U9rVYhiI3U1IvbeMOiciEAKi/F5Cee05Qj+/+9D4ywM9ACTOU+EmshpbO6dEXF+DlEyywKQvSPWZslPIhl2h8VPmi/AnJPbiuuSSi+zc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751827714; c=relaxed/simple;
	bh=zIhBh4WZGJW3yEF46zQEWDQzXqoWuf8bFmd5PCgWvJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rq0NQWLEpMDgTHDcUpQm83991j8CpwfufjiFJ5/TzrWFLCjP2V9+UWoyG/Rkdtba5nzUgQ7HQVgzT0+udrCiRNwwcMDcPNS5Fq3oXFM7g93ceWWIYK66PNQNMglsDuqYLICtwbj6P+nZeG3ouLfav4ZUtZcVdNc1P6Sp2ckbLgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwH9AZ/7; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b321bd36a41so1903639a12.2;
        Sun, 06 Jul 2025 11:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751827712; x=1752432512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iX3pf+UqD3qOSyaJ9rlwwRl/aKN0viYUHi2BzUPJC0s=;
        b=kwH9AZ/738u6vnT5txS0vwS+r9jU0OznPnnCW6FGFiveNKom5N2tbDJVM+1CCMoJtK
         ghiO+w4BowCrzM9I7x+HDXKo4pUqlcQEIY0gekD4VzJf11E+crsN7u/v34JgU9H7BtM+
         4dw0ND+sjYdiA0u+NHZy11Iwg6bRT0TUkkXeh2oKaiG5J4TXos/qvruRnshVO45FEOQB
         uZApDyuhviuXLnBS52N7xjQ+sDHwQ9diwHkQf/I/AAoRDfJCzfO50ZiwzPbNMo0uberU
         EIlAFgAVfx0Uxxr9Dfxjy5myuHyNqAdQcQeyf5xp4ybN/UT46h6etUPLy3sicAYrMobm
         LhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751827712; x=1752432512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iX3pf+UqD3qOSyaJ9rlwwRl/aKN0viYUHi2BzUPJC0s=;
        b=Hj9qt5HlsaojIFnlXBSgBd/UippOSuDY3qkn1xssGC7uomcxxiRAe8m/z7XTZN/iJY
         4g9W8e2bBseA+zoaPBgphlvAG+kkS5oOTYw6j6HbUzcjT4w981frmS/WDjlc9Y2IRMS3
         tPjA5VVyVtb7pFrfyUHklNxGvKSTfAPbH/QEhCphgyBf3dkE9cesD9riDoy8oAuDQUsY
         fxt1bsVUNhpErlEoWVfvl9+/wn2/2oNi9pkzpXpGaXGJT5B3MFJUm0+Wb0Hi3H7duVGU
         Mn/0VYnNYDgcIp16YJESXS2MDWsU50lEsU/veD4x//Twztx5ngguYQxd5NUIS3dV4AV/
         7P1w==
X-Forwarded-Encrypted: i=1; AJvYcCV/U3WmZ2e5bwHcjJ9keBPtMKuqmvk2ojgeTCURbhNfm7CUgFqyAim4CjzpeDskw42SHRNW56iOmxMO@vger.kernel.org, AJvYcCXhb8gISkN4FHFe05u5eTexEAHgoqmyhkHgAu8XMLsNbfe4phNvu1QL9cjiY7U8Jx6+XdgXmXZ3K6Dnsj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpLJUhILeZOVpF6mZ8t3nUILN6397692FmW66j3tiZi6DOJYG4
	IJQdO0xhLla+uak1Fjk6H/IM3gOYJ9F1uAKEcn2AevyGpJa0Sj/ENmYlVL/yTQNWO6yjqbl+V1j
	R29m54YriTSSEspsGVxtDiM+e/HKyBi0=
X-Gm-Gg: ASbGnct57FKoZmTRX8sP1VO0dxtQH8h3WqGpWcszD8U1NRRviacvU5g17qWwoP609MP
	0HgKN6WqsFXScTGIQGvppV+qO1Wq0DhmxH/yb2/6oLo3Y5WH63TJoxqnT3xNQaGE4hDMxWbHZh0
	F9iY0wCwe4hY4IxKSLyMA6bBArXrtD3iQcu4P+xsM8ZTo=
X-Google-Smtp-Source: AGHT+IFMv6RNPbwrTyvUe0q0TmFZFulwvLGaN4n4uaZD/M+IAPp64PI4j3dqCcW1r6Ly7j/Bf6xM6iTEjUTmw4xYL5s=
X-Received: by 2002:a17:90b:4cc8:b0:311:9c1f:8524 with SMTP id
 98e67ed59e1d1-31aadd243afmr14155019a91.15.1751827711702; Sun, 06 Jul 2025
 11:48:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEzXK1qwHf5no6B2eCX1U7NGe-BoJYFLTHPkbM=_XpgrMAE2dw@mail.gmail.com>
 <20250311162407.GA630741@bhelgaas> <CAEzXK1o52evH1RhQpe3CuD=MoHiMk0gC32Gxw7RpSMMGWzyH8Q@mail.gmail.com>
In-Reply-To: <CAEzXK1o52evH1RhQpe3CuD=MoHiMk0gC32Gxw7RpSMMGWzyH8Q@mail.gmail.com>
From: =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date: Sun, 6 Jul 2025 19:48:20 +0100
X-Gm-Features: Ac12FXw9dhR_OpsRZ5iPh8dqbJXGQuhCAVOR0GygrVcl9O_S3XKHLu2N3LaMK-4
Message-ID: <CAEzXK1oDh1fswcijN1xc-EnJmqRckgcAts_jb64HHSTYmSFoYg@mail.gmail.com>
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

Hi,

Is the data that i sent enough? Do you need more info?

Best regards,
Luis

On Wed, Mar 12, 2025 at 4:25=E2=80=AFPM Lu=C3=ADs Mendes <luis.p.mendes@gma=
il.com> wrote:
>
> Hi Bjron,
>
> Yes, I had trouble finding PCIe cards to test with Solidrun Clearfog
> Base mPCIe slot and indeed the Coral Edge TPU card does not have an
> open-source driver and the proprietary one that exists does not work
> in 32-bit architectures. So, yes it had no driver.
>
> I have now connected a mPCIe to PCIe extender and installed a Marvell
> 4-port SATA controller card and I will also include my Armada Duo
> system which is based on a Solidrun A388 SoM anyway and the Clearfog
> Base logs hope this  information further helps with the analysis,
>
> So for Solidrun Clearfog Base with Kernel 6.14-rc5 we have:
> dmesg output: https://pastebin.com/aw0X9Fb5
> lspci -vv: https://pastebin.com/5mDHJZ2C
> cat /proc/interrupts: https://pastebin.com/ASHN8cx7
> grep -r . /proc/irq: https://pastebin.com/mskASwYL
> decompiled armada-388-clearfog-base.dtb: https://pastebin.com/KuNFDmYP
>
> ------------------------------------------------------
> For PowerInno ArmadaDuo (2-slots PCIe) with Kernel 6.8.9 we have:
> dmesg output: https://pastebin.com/54HHrPVP
> lspci -vv: https://pastebin.com/KpE6Hc0r
> cat /proc/interrupts: https://pastebin.com/6L64ztse
> grep -r . /proc/irq: https://pastebin.com/raPkRBVk
>
> Best Regards,
> Lu=C3=ADs
>
> On Tue, Mar 11, 2025 at 4:24=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org=
> wrote:
> >
> > On Sun, Mar 09, 2025 at 11:10:58PM +0000, Lu=C3=ADs Mendes wrote:
> > > All logs presented were obtained from a SolidRun A388 ClearFog Base,
> > > if more detailed PCI logs are needed I have the other machine, the
> > > Armada Duo that has 2 PCIe slots and handles an AMD RX 550 GPU. Just
> > > let me know.
> > >
> > > - Complete dmesg log, booted with "pci=3Dnomsi"  is available here:
> > > https://pastebin.com/wDj0NGFN
> > > - Complete output of "sudo lspci -vv" is available here:
> > > https://pastebin.com/f4yHRhLr
> > > - Contents of /proc/interrupts is available here: https://pastebin.co=
m/ejDUuhbJ
> > > - Output of "grep -r . /proc/irq/" is available here:
> > > https://pastebin.com/4jvFBBhy
> >
> > Thank you very much for these.
> >
> > It looks like the only PCI device is 01:00.0: [1ac1:089a], a Coral
> > Edge TPU, and I don't see any evidence of a driver for it or any IRQ
> > usage.  Do you have any other PCI device you could try there?
> > Something with a driver that uses interrupts?
> >
> > Not critical right now, but I'm puzzled by this part of the dmesg log:
> >
> >   mvebu-pcie soc:pcie: host bridge /soc/pcie ranges:
> >   mvebu-pcie soc:pcie:      MEM 0x00f1080000..0x00f1081fff -> 0x0000080=
000
> >   mvebu-pcie soc:pcie:      MEM 0x00f1040000..0x00f1041fff -> 0x0000040=
000
> >   mvebu-pcie soc:pcie:      MEM 0x00f1044000..0x00f1045fff -> 0x0000044=
000
> >   mvebu-pcie soc:pcie:      MEM 0x00f1048000..0x00f1049fff -> 0x0000048=
000
> >   pci_bus 0000:00: root bus resource [mem 0xf1080000-0xf1081fff] (bus a=
ddress [0x00080000-0x00081fff])
> >   pci_bus 0000:00: root bus resource [mem 0xf1040000-0xf1041fff] (bus a=
ddress [0x00040000-0x00041fff])
> >   pci_bus 0000:00: root bus resource [mem 0xf1044000-0xf1045fff] (bus a=
ddress [0x00044000-0x00045fff])
> >   pci_bus 0000:00: root bus resource [mem 0xf1048000-0xf1049fff] (bus a=
ddress [0x00048000-0x00049fff])
> >   pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff]
> >
> > The first four mvebu-pcie lines make good sense and match the
> > first four pci_bus lines.  But I don't know where the
> > [mem 0xe0000000-0xe7ffffff] aperture came from.  It should be
> > described in the devicetree, but I don't see it mentioned in the
> > /soc/pcie ranges.
> >
> > Can you include the devicetree as well?

