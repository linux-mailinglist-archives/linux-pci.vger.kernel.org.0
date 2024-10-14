Return-Path: <linux-pci+bounces-14424-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D764799C2AC
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 10:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06C841C24E06
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 08:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FBB14B08E;
	Mon, 14 Oct 2024 08:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtoN6cgR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED0F1494A5;
	Mon, 14 Oct 2024 08:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728893447; cv=none; b=jSek6kF2ILbtyrzTgr6Bp7Kwp+NJOS4oh18NwTRvje+W7eJ44jwqpKrVBT01DwLlJ0X2KOJyj013ekVa9u5M4pW2n95vDZns0TayfT9BmNoUPmb0WXoDBFA5YoG5pOOIFMtIVR3+VdUWztx6dnGd6snjzn0p/N2Nd2ANNnrLcU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728893447; c=relaxed/simple;
	bh=6zY8EbhkGqptT08+pBMxn4kxXqfuOwf/dUQsikKnakQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZvYjlgPHWsZPClIqrmxlVA6PZzN6FT2QWE4kmJqPoP76Wz3cIRVatNsDNWk4gbUNhYyPeJ5jrCOS380wTwqiFo9uSASZ1hAqBulwEuBj5kHvR+GWO77C6adZhM1DbXJjQhyNIIoeIBJMBCLCRss2IDrVkfOKuYe1/4xoRw+tdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtoN6cgR; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4311c285bc9so26796585e9.3;
        Mon, 14 Oct 2024 01:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728893443; x=1729498243; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KW7kLQuHbcf54sFy0QOJU4AGEwenotEzl7dxQ9KdqLo=;
        b=HtoN6cgRc3Bt1z8NHbDZhZsRoyT/mhsFyJzlOS8kXp5kkQPdiRx7CUuJj6D7ku8lEi
         acdPDPgMyViFjosakHJ7K3bTVuOWSNg/pKAYBIsbezwqaEr5hXVET3RnJH4NwSDJSD8n
         lrfnUyQwLNvsKW12Ui+8JPB4PWb0eq+g52Kjq7BQPIinXLRiNa4Mpao7pYuXinDmhQRN
         ZKIlnR1ety00xZEewvQiCWFWrEWe7RujfhqzSc+vj1CQaoLODs9peOc6jAEpGjFmqagG
         YvemnPOxg5j0F+v4n5z8Tu01ndyFRHtca7rjBqHvVJJvm4prvCphbWnXsmxZKTlK7BsS
         PdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728893443; x=1729498243;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KW7kLQuHbcf54sFy0QOJU4AGEwenotEzl7dxQ9KdqLo=;
        b=Xe+2SRNZKH9YfdF8tpicq8Tx3ELumVnOnjL/QjGMrRcP7BZuoBzhGcivFagX3QQwsb
         epHjcAVlTbbvlT11XFJhzjWZr8hrgDYjinaDs95v/hcNfftP7pkia9KxK7gENl1eZvHi
         wpBZlMqIdwRSK/yVeX8mluU8vefyu1slzErl+npYiK/ctbZpVlTAwl1HPJQyBTfmnkyS
         qD6G3ogOEPUvQf961Ymzygss6uCoa0v+S7matZrvM3B/gLZACpFbn2CgDjxLJ9Q9rxJu
         0gNTx9BjI57OkDX3ot73KDHlJcwBkrfwJMRDQ6OVmtXyFdMji/1cvCjXoyN3SOuGiGpU
         96mw==
X-Forwarded-Encrypted: i=1; AJvYcCVDs61VqKo+uZ97+duuBZwm5vDmHe2Cxk479iGYPWijpIg6rhCJ3WKbinUSssiMmf8MSbnQXpuQW4Jb@vger.kernel.org, AJvYcCVtO3upQcstIA6XM/TGqH9rqyInMtV9A2HCnKHxB8NPoW5PMcthMLwFMgn3RUVjJasVdVJdN7YmjLppcQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgAs1eCe+1aUYRbj20N+1U7DU1V59Ii25lh9SQY0MZBA3gdVGW
	ApmyMmB/hjWqRaM9hETgRrT3t/QRBdAHCrDGsWSJ/qa8TiszSdQF
X-Google-Smtp-Source: AGHT+IHB551ffar+NCF/WbpQWRYMbBi4jUBFqKY6gFU4dyhsV5DnQg2e5zBiqHEqblV6Wx0Yv1ntWA==
X-Received: by 2002:adf:f050:0:b0:37d:454f:b49a with SMTP id ffacd0b85a97d-37d55262f0cmr7730417f8f.43.1728893442801;
        Mon, 14 Oct 2024 01:10:42 -0700 (PDT)
Received: from eichest-laptop ([2a02:168:af72:0:fd1:3993:f12c:5deb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a8671sm10788932f8f.18.2024.10.14.01.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 01:10:42 -0700 (PDT)
Date: Mon, 14 Oct 2024 10:10:40 +0200
From: Stefan Eichenberger <eichest@gmail.com>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Frank Li <frank.li@nxp.com>, Francesco Dolcini <francesco@dolcini.it>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v2] PCI: imx6: Add suspend/resume support for i.MX6QDL
Message-ID: <ZwzSAH3tfOo_6Cez@eichest-laptop>
References: <20241009131659.29616-1-eichest@gmail.com>
 <ZwgykRyE+jDU0CiU@lizhi-Precision-Tower-5810>
 <20241010201121.GA88411@francesco-nb>
 <ZwhY/dtSNPptgs27@lizhi-Precision-Tower-5810>
 <Zwk35efNI4EO1eir@eichest-laptop>
 <AS8PR04MB8676468EE98DDFEAD0D075AC8C7A2@AS8PR04MB8676.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8676468EE98DDFEAD0D075AC8C7A2@AS8PR04MB8676.eurprd04.prod.outlook.com>

Hi Richard and Frank,

On Sat, Oct 12, 2024 at 09:02:28AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Stefan Eichenberger <eichest@gmail.com>
> > Sent: 2024年10月11日 22:36
> > To: Frank Li <frank.li@nxp.com>
> > Cc: Francesco Dolcini <francesco@dolcini.it>; Hongxing Zhu
> > <hongxing.zhu@nxp.com>; l.stach@pengutronix.de; lpieralisi@kernel.org;
> > kw@linux.com; manivannan.sadhasivam@linaro.org; robh@kernel.org;
> > bhelgaas@google.com; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > kernel@pengutronix.de; festevam@gmail.com; Francesco Dolcini
> > <francesco.dolcini@toradex.com>; linux-pci@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; imx@lists.linux.dev;
> > linux-kernel@vger.kernel.org; Stefan Eichenberger
> > <stefan.eichenberger@toradex.com>
> > Subject: Re: [PATCH v2] PCI: imx6: Add suspend/resume support for i.MX6QDL
> > 
> > Hi Frank,
> > 
> > On Thu, Oct 10, 2024 at 06:45:17PM -0400, Frank Li wrote:
> > > On Thu, Oct 10, 2024 at 10:11:21PM +0200, Francesco Dolcini wrote:
> > > > Hello Frank,
> > > >
> > > > On Thu, Oct 10, 2024 at 04:01:21PM -0400, Frank Li wrote:
> > > > > On Wed, Oct 09, 2024 at 03:14:05PM +0200, Stefan Eichenberger wrote:
> > > > > > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > > > > >
> > > > > > The suspend/resume support is broken on the i.MX6QDL platform.
> > > > > > This patch resets the link upon resuming to recover
> > > > > > functionality. It shares most of the sequences with other i.MX
> > > > > > devices but does not touch the critical registers, which might
> > > > > > break PCIe. This patch addresses the same issue as the following
> > downstream commit:
> > > > > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%
> > > > > >
> > 2Fgithub.com%2Fnxp-imx%2Flinux-imx%2Fcommit%2F4e92355e1f79d225ea
> > > > > >
> > 842511fcfd42b343b32995&data=05%7C02%7Chongxing.zhu%40nxp.com%7C4
> > > > > >
> > 9cdf8aaeee54cec71c508dcea0215b1%7C686ea1d3bc2b4c6fa92cd99c5c3016
> > > > > >
> > 35%7C0%7C0%7C638642541899874406%7CUnknown%7CTWFpbGZsb3d8eyJWI
> > joi
> > > > > >
> > MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7
> > > > > >
> > C%7C%7C&sdata=DQGwcXYy0soCov1Uf4ycLQiisP8qlbBzOslyX3FY5Cs%3D&res
> > > > > > erved=0 In comparison this patch will also reset the device if
> > > > > > possible. Without this patch suspend/resume will not work if a
> > > > > > PCIe device is connected.
> > > > > > The kernel will hang on resume and print an error:
> > > > > > ath10k_pci 0000:01:00.0: Unable to change power state from D3hot
> > > > > > to D0, device inaccessible
> > > > > > 8<--- cut here ---
> > > > > > Unhandled fault: imprecise external abort (0x1406) at 0x0106f944
> > > > > >
> > > > > > Signed-off-by: Stefan Eichenberger
> > > > > > <stefan.eichenberger@toradex.com>
> > > > > > ---
> > > > >
> > > > > Thank you for your patch.
> > > > >
> > > > > But it may conflict with another suspend/resume patch
> > > > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2F
> > > > > lore.kernel.org%2Fimx%2F1727245477-15961-8-git-send-email-hongxing
> > > > > .zhu%40nxp.com%2F&data=05%7C02%7Chongxing.zhu%40nxp.com%7C4
> > 9cdf8aa
> > > > >
> > eee54cec71c508dcea0215b1%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
> > 7C
> > > > >
> > 0%7C638642541899892894%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
> > wMDA
> > > > >
> > iLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata
> > > > >
> > =xPBKoiWL8IceLlv%2F6lWoqkPWosh%2BRvG8jyA8NjKSsOI%3D&reserved=0
> > > >
> > > > Thanks for the head-up.
> > > >
> > > > Do you see any issue with this patch apart that? Because this patch
> > > > is fixing a crash, so I would expect this to be merged, once ready,
> > > > and such a series rebased afterward.
> > > >
> > > > I am writing this explicitly since you wrote a similar comment on
> > > > the
> > > > v1
> > > > (https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fl
> > > > ore.kernel.org%2Fall%2FZsNXDq%252FkidZdyhvD%40lizhi-Precision-Tower-
> > > >
> > 5810%2F&data=05%7C02%7Chongxing.zhu%40nxp.com%7C49cdf8aaeee54cec
> > 71c5
> > > >
> > 08dcea0215b1%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63864
> > 25418
> > > >
> > 99904634%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2l
> > uMzI
> > > >
> > iLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=x2OVvZsi4YIxSg
> > KGD
> > > > 7ZzqbRQjiTFK4%2BzMdgDv2qSdig%3D&reserved=0)
> > > > and I would like to prevent to have this fix starving for long just
> > > > because multiple people is working on the same driver.
> > >
> > > My key comment for this patch is use flags IMX_PCIE_FLAG_SKIP_TURN_OFF
> > > in suspend()/resume(), it is up to kw to pick which one firstly.
> > 
> > I will try to implement it as you proposed with the new flag.
> > 
> > However, what I figured out with kernel v6.12-rc1 I get the following warning
> > when booting on an i.MX6QDL even without my patch applied:
> > [    1.901199] PCI: bus0: Fast back to back transfers disabled
> > [    1.904754] mmc1: SDHCI controller on 2190000.mmc [2190000.mmc]
> > using ADMA
> > [    1.904914] mmc2: SDHCI controller on 2194000.mmc [2194000.mmc]
> > using ADMA
> > [    1.910686] pci 0000:01:00.0: [168c:003c] type 00 class 0x028000 PCIe
> > Endpoint
> > [    1.918390] NET: Registered PF_PACKET protocol family
> > [    1.918573] mmc0: SDHCI controller on 2198000.mmc [2198000.mmc]
> > using ADMA
> > [    1.924322] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x001fffff 64bit]
> > [    1.931635] Key type dns_resolver registered
> > [    1.936764] pci 0000:01:00.0: ROM [mem 0x00000000-0x0000ffff pref]
> > [    1.961043] pci 0000:01:00.0: supports D1 D2
> > [    1.961526] Registering SWP/SWPB emulation handler
> > [    1.965601] mmc0: new DDR MMC card at address 0001
> > [    1.976575] mmcblk0: mmc0:0001 Q2J54A 3.59 GiB
> > [    1.979794] Loading compiled-in X.509 certificates
> > [    1.985036] PCI: bus1: Fast back to back transfers disabled
> > [    1.991531] pci 0000:00:00.0: bridge window [mem 0x01000000-0x011fffff]:
> > assigned
> > [    1.998742]  mmcblk0: p1 p2 p3
> > [    1.999163] pci 0000:00:00.0: BAR 0 [mem 0x01200000-0x012fffff]:
> > assigned
> > [    2.003947] mmcblk0boot0: mmc0:0001 Q2J54A 16.0 MiB
> > [    2.008990] pci 0000:00:00.0: bridge window [mem 0x01300000-0x013fffff
> > pref]: assigned
> > [    2.009023] pci 0000:00:00.0: ROM [mem 0x01400000-0x0140ffff pref]:
> > assigned
> > [    2.009054] pci 0000:01:00.0: BAR 0 [mem 0x01000000-0x011fffff 64bit]:
> > assigned
> > [    2.017526] mmcblk0boot1: mmc0:0001 Q2J54A 16.0 MiB
> > [    2.022015] pci 0000:01:00.0: ROM [mem 0x01300000-0x0130ffff pref]:
> > assigned
> > [    2.032133] mmcblk0rpmb: mmc0:0001 Q2J54A 512 KiB, chardev (242:0)
> > [    2.036347] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> > [    2.036370] pci 0000:00:00.0:   bridge window [mem
> > 0x01000000-0x011fffff]
> > [    2.036384] pci 0000:00:00.0:   bridge window [mem
> > 0x01300000-0x013fffff pref]
> > [    2.042552] pps pps0: new PPS source ptp0
> > [    2.048338] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
> > [    2.083626] pci_bus 0000:00: resource 5 [mem 0x01000000-0x01efffff]
> > [    2.089972] pci_bus 0000:01: resource 1 [mem 0x01000000-0x011fffff]
> > [    2.093461] fec 2188000.ethernet eth0: registered PHC device 0
> > [    2.096283] pci_bus 0000:01: resource 2 [mem 0x01300000-0x013fffff pref]
> > [    2.096352] sysfs: cannot create duplicate filename
> > '/devices/platform/soc/1ffc000.pcie/pci0000:00/0000:00:00.0/resource0'
> > [    2.096365] CPU: 3 UID: 0 PID: 52 Comm: kworker/u19:2 Not tainted
> > 6.12.0-rc1 #54
> > [    2.096381] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> > [    2.096391] Workqueue: async async_run_entry_fn
> > [    2.103025] imx_thermal 20c8000.anatop:tempmon: Industrial CPU
> > temperature grade - max:105C critical:100C passive:95C
> > [    2.108932]
> > [    2.108940] Call trace:
> > [    2.108950]  unwind_backtrace from show_stack+0x10/0x14
> > [    2.121391] clk: Disabling unused clocks
> > [    2.127423]  show_stack from dump_stack_lvl+0x54/0x68
> > [    2.127451]  dump_stack_lvl from sysfs_warn_dup+0x58/0x64
> > [    2.134265] PM: genpd: Disabling unused power domains
> > [    2.138525]  sysfs_warn_dup from sysfs_add_bin_file_mode_ns+0xbc/0xcc
> > [    2.138547]  sysfs_add_bin_file_mode_ns from
> > sysfs_create_bin_file+0xac/0xb4
> > [    2.149242] ALSA device list:
> > [    2.150647]  sysfs_create_bin_file from
> > pci_create_resource_files+0x84/0x148
> > [    2.153183]   No soundcards found.
> > [    2.158407]  pci_create_resource_files from
> > pci_bus_add_device+0x24/0xe4
> > [    2.211699]  pci_bus_add_device from pci_bus_add_devices+0x2c/0x70
> > [    2.217930]  pci_bus_add_devices from pci_host_probe+0x7c/0xa4
> > [    2.223806]  pci_host_probe from dw_pcie_host_init+0x4ec/0x71c
> > [    2.229682]  dw_pcie_host_init from imx_pcie_probe+0x3a8/0x75c
> > [    2.235559]  imx_pcie_probe from platform_probe+0x5c/0xb0
> > [    2.241010]  platform_probe from really_probe+0xd0/0x3a4
> > [    2.246364]  really_probe from __driver_probe_device+0x8c/0x1d4
> > [    2.252321]  __driver_probe_device from driver_probe_device+0x30/0xc0
> > [    2.258803]  driver_probe_device from
> > __driver_attach_async_helper+0x50/0xd8
> > [    2.265892]  __driver_attach_async_helper from
> > async_run_entry_fn+0x30/0x144
> > [    2.272980]  async_run_entry_fn from process_one_work+0x154/0x2dc
> > [    2.279115]  process_one_work from worker_thread+0x250/0x3f0
> > [    2.284811]  worker_thread from kthread+0x110/0x12c
> > [    2.289726]  kthread from ret_from_fork+0x14/0x28
> > [    2.294461] Exception stack(0xe6a0dfb0 to 0xe6a0dff8)
> > [    2.299535] dfa0:                                     00000000
> > 00000000 00000000 00000000
> > [    2.307740] dfc0: 00000000 00000000 00000000 00000000 00000000
> > 00000000 00000000 00000000
> > [    2.315942] dfe0: 00000000 00000000 00000000 00000000 00000013
> > 00000000
> > [    2.323156] pcieport 0000:00:00.0: PME: Signaling with IRQ 293
> > [    2.329645] pcieport 0000:00:00.0: AER: enabled with IRQ 293
> > [    2.335553] sysfs: cannot create duplicate filename
> > '/devices/platform/soc/1ffc000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/res
> > ource0'
> > [    2.347794] CPU: 3 UID: 0 PID: 52 Comm: kworker/u19:2 Not tainted
> > 6.12.0-rc1 #54
> > [    2.355229] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> > [    2.361779] Workqueue: async async_run_entry_fn
> > [    2.366349] Call trace:
> > [    2.366362]  unwind_backtrace from show_stack+0x10/0x14
> > [    2.374183]  show_stack from dump_stack_lvl+0x54/0x68
> > [    2.379273]  dump_stack_lvl from sysfs_warn_dup+0x58/0x64
> > [    2.384706]  sysfs_warn_dup from sysfs_add_bin_file_mode_ns+0xbc/0xcc
> > [    2.391183]  sysfs_add_bin_file_mode_ns from
> > sysfs_create_bin_file+0xac/0xb4
> > [    2.398270]  sysfs_create_bin_file from
> > pci_create_resource_files+0x84/0x148
> > [    2.405360]  pci_create_resource_files from
> > pci_bus_add_device+0x24/0xe4
> > [    2.412113]  pci_bus_add_device from pci_bus_add_devices+0x2c/0x70
> > [    2.418334]  pci_bus_add_devices from pci_bus_add_devices+0x60/0x70
> > [    2.424642]  pci_bus_add_devices from pci_host_probe+0x7c/0xa4
> > [    2.430511]  pci_host_probe from dw_pcie_host_init+0x4ec/0x71c
> > [    2.436384]  dw_pcie_host_init from imx_pcie_probe+0x3a8/0x75c
> > [    2.442258]  imx_pcie_probe from platform_probe+0x5c/0xb0
> > [    2.447704]  platform_probe from really_probe+0xd0/0x3a4
> > [    2.453057]  really_probe from __driver_probe_device+0x8c/0x1d4
> > [    2.459014]  __driver_probe_device from driver_probe_device+0x30/0xc0
> > [    2.465493]  driver_probe_device from
> > __driver_attach_async_helper+0x50/0xd8
> > [    2.472580]  __driver_attach_async_helper from
> > async_run_entry_fn+0x30/0x144
> > [    2.479666]  async_run_entry_fn from process_one_work+0x154/0x2dc
> > [    2.485800]  process_one_work from worker_thread+0x250/0x3f0
> > [    2.491494]  worker_thread from kthread+0x110/0x12c
> > [    2.496408]  kthread from ret_from_fork+0x14/0x28
> > [    2.501140] Exception stack(0xe6a0dfb0 to 0xe6a0dff8)
> > [    2.506214] dfa0:                                     00000000
> > 00000000 00000000 00000000
> > [    2.514418] dfc0: 00000000 00000000 00000000 00000000 00000000
> > 00000000 00000000 00000000
> > [    2.522620] dfe0: 00000000 00000000 00000000 00000000 00000013
> > 00000000
> > 
> > This was not the case with kernel v6.11, do you have an idea where this comes
> > from? I did not dig into more detail yet but it looks a bit like a regression. The
> > driver still works, it just prints this duplicate filename warning.
> Hi Stefan:
> I use my i.MX6QP SabreSD board to make a quick boot test when both the
>  v6.12-rc2 and v6.12-rc1 are used.
> Since I don't have the i.MX6QDL board at my hand now.
> There is no dump, kernel boots successfully, and PCIe works well too.
> Do I miss something?
> BTW, the imx_v6_v7_defconfig is used in my tests.
> 
> root@imx6qpdlsolox:~# lspci
> 00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
> 01:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
> root@imx6qpdlsolox:~# uname -a
> Linux imx6qpdlsolox 6.12.0-rc2 #11 SMP Sat Oct 12 16:56:57 CST 2024 armv7l GNU/Linux
> root@imx6qpdlsolox:~#
> root@imx6qpdlsolox:~#
> root@imx6qpdlsolox:~# dmesg | grep pci
> [    0.442344] imx6q-pcie 1ffc000.pcie: host bridge /soc/pcie@1ffc000 ranges:
> [    0.442397] imx6q-pcie 1ffc000.pcie:       IO 0x0001f80000..0x0001f8ffff -> 0x0000000000
> [    0.442427] imx6q-pcie 1ffc000.pcie:      MEM 0x0001000000..0x0001efffff -> 0x0001000000
> [    1.659104] imx6q-pcie 1ffc000.pcie: iATU: unroll F, 4 ob, 4 ib, align 64K, limit 4G
> [    1.765277] imx6q-pcie 1ffc000.pcie: PCIe Gen.1 x1 link up
> [    1.770809] imx6q-pcie 1ffc000.pcie: Link: Only Gen1 is enabled
> [    1.770820] imx6q-pcie 1ffc000.pcie: Link up, Gen1
> [    1.784066] imx6q-pcie 1ffc000.pcie: PCIe Gen.1 x1 link up
> [    1.796446] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
> [    1.809095] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    1.809113] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> [    1.809125] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
> [    1.822423] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400 PCIe Root Port
> [    1.822451] pci 0000:00:00.0: BAR 0 [mem 0x00000000-0x000fffff]
> [    1.834148] pci 0000:00:00.0: ROM [mem 0x00000000-0x0000ffff pref]
> [    1.849760] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> [    1.890183] pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
> [    1.896293] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
> [    1.903109] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff pref]
> [    1.910386] pci 0000:00:00.0: Limiting cfg_size to 512
> [    1.915588] pci 0000:00:00.0: supports D1
> [    1.919638] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
> [    1.944036] pci 0000:01:00.0: [8086:10d3] type 00 class 0x020000 PCIe Endpoint
> [    1.951427] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x0001ffff]
> [    1.961171] pci 0000:01:00.0: BAR 1 [mem 0x00000000-0x0007ffff]
> [    1.967149] pci 0000:01:00.0: BAR 2 [io  0x0000-0x001f]
> [    1.972456] pci 0000:01:00.0: BAR 3 [mem 0x00000000-0x00003fff]
> [    1.978528] pci 0000:01:00.0: ROM [mem 0x00000000-0x0003ffff pref]
> [    1.985185] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
> [    2.020060] pci 0000:00:00.0: BAR 0 [mem 0x01000000-0x010fffff]: assigned
> [    2.032893] pci 0000:00:00.0: bridge window [mem 0x01100000-0x011fffff]: assigned
> [    2.046230] pci 0000:00:00.0: bridge window [mem 0x01200000-0x012fffff pref]: assigned
> [    2.059918] pci 0000:00:00.0: ROM [mem 0x01300000-0x0130ffff pref]: assigned
> [    2.072647] pci 0000:00:00.0: bridge window [io  0x1000-0x1fff]: assigned
> [    2.085371] pci 0000:01:00.0: BAR 1 [mem 0x01100000-0x0117ffff]: assigned
> [    2.097773] pci 0000:01:00.0: ROM [mem 0x01200000-0x0123ffff pref]: assigned
> [    2.112229] pci 0000:01:00.0: BAR 0 [mem 0x01180000-0x0119ffff]: assigned
> [    2.112266] pci 0000:01:00.0: BAR 3 [mem 0x011a0000-0x011a3fff]: assigned
> [    2.124738] pci 0000:01:00.0: BAR 2 [io  0x1000-0x101f]: assigned
> [    2.137379] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> [    2.149485] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
> [    2.149502] pci 0000:00:00.0:   bridge window [mem 0x01100000-0x011fffff]
> [    2.160835] pci 0000:00:00.0:   bridge window [mem 0x01200000-0x012fffff pref]
> [    2.173722] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
> [    2.193124] pci_bus 0000:00: resource 5 [mem 0x01000000-0x01efffff]
> [    2.193139] pci_bus 0000:01: resource 0 [io  0x1000-0x1fff]
> [    2.222093] pci_bus 0000:01: resource 1 [mem 0x01100000-0x011fffff]
> [    2.228389] pci_bus 0000:01: resource 2 [mem 0x01200000-0x012fffff pref]

Thanks a lot for testing on your side.

I think I was too early to assume it is a regression. I did some more
tests today and I can't see the issue with most configurations. I
uploaded the one that generates the issue on my system with kernel
v6.12-rc1.
https://drive.google.com/file/d/1ZHpg6tG82QjmiXylq0W2HSLnz97AgyN8

However, even if I enhance the pci-imx6.c driver with a simple pr_info
the trace disappears:
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 808d1f1054173..047f4ae0a2ed3 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1282,6 +1282,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
        u16 val;
        int i;

+       pr_info("%s - %s:%d\n", __func__, __FILE__, __LINE__);
+
        imx_pcie = devm_kzalloc(dev, sizeof(*imx_pcie), GFP_KERNEL);
        if (!imx_pcie)
                return -ENOMEM;

So most likely it is some sequence/timing issue. I have to check if I
find the time to investigate it further, but I guess it would be on my
side to figure out what happens.

Sorry for the (kind of) false alarm.

Regards,
Stefan

