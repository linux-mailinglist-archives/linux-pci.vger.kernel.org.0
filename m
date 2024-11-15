Return-Path: <linux-pci+bounces-16874-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AD89CDE41
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 13:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE83BB21731
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 12:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0711A3035;
	Fri, 15 Nov 2024 12:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Dliy4j70"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32B31B6D15;
	Fri, 15 Nov 2024 12:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731673780; cv=none; b=qTcSe9vzGzqe/ZkIZ1S+RaHC6Lo+fojpn6vh9OiGtmGIMzAR6iJy4v+79iWickZ7PK0PCh8X/o6KCwd4RhewC5b1B2GE3Kk8JpklSXE3IzKaFKooZuKT/+z5B7i+w+XNC8cguWHRHS3RuFYbZ42uge9oXmG1t/p+F3BygElWIHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731673780; c=relaxed/simple;
	bh=Wn7mCxZd7PZY0354mGjj5fKQa8WX8iyw262Lq0kdioQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=mBHDNMwVPfAp+VrIru7ycjuElwLnzxW6eCr7aXkbCyRbeg1Uyl9xniYwgZqXRcdAwFR2jvs/bF6uKkcf0SIDSBqAq4aPE1YkMmAyGJPV7ffel0P3wIqDFlw6254aVRYcW36HJ1za9lLIjINr/ImtJpBAcXv/0eyWWJhCBwA4YC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Dliy4j70; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1731673756; x=1732278556; i=wahrenst@gmx.net;
	bh=Wn7mCxZd7PZY0354mGjj5fKQa8WX8iyw262Lq0kdioQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Dliy4j70VsvEOGfnH+23cWTEp5YOA3IaX9daSuRdTQTsu6vC+tmbAllSJzslqq52
	 v13mXZhbL7G3/KihxvnXxdDFVBqaxGb7RB9UbJDx88Pxh/YXdKhb4Rp60lRxyVoEe
	 23D49co93ikc/PnKuPd4ex2En3PvW9dH44GPxfruneM7z36uz2TFU+XAWU8bIHzI8
	 TXfB44MYqPi3a/qJyAz4YPIue1FwVscdODnpD1xAqArUXtNlHT+DQvocJn/lIpylw
	 880FDAq/HpoV81YUtvJ1JJKYHjehsbS32yM2fBuy6CvudAxW4qMVffehgac7qAyuX
	 NMCDkpa6USpNngrqhA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5wLZ-1t8sEx2O7P-00BQn2; Fri, 15
 Nov 2024 13:29:16 +0100
Message-ID: <b57a66ba-9443-4554-8d45-f5c7e13c066a@gmx.net>
Date: Fri, 15 Nov 2024 13:29:15 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] PCI/PME+pciehp: Request IRQF_ONESHOT because bwctrl
 shares IRQ
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241114142034.4388-1-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>
In-Reply-To: <20241114142034.4388-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GjmH/Y0aQo/ytPNEjrXVwfzr6rLhe0YNZZcWH2ymVMMF8b8l17M
 BySzNQrCQmQ944X0N1oc1IRh3IkTT1eNn8Auqam90q69tU+dF8xmaxVEaf6j3nu6UkdxYRU
 dO//1v69A2wU57oEs2Pp6H7jYWrPWIIZkWd5n/Sdn7TBcz5o6dYKVsWP2DgmUy7KDPsvcZV
 5Ws3IA1Zpg3XIqqZOreEg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:w2r5LH4mw9o=;af7D0RjeTpRmYrUw9cJh+ZV+fdq
 Uv+y31w29WxlIvhkOPVlhmTKXs4yED3Z5WAxZLHjOMc8wsFREvDSE3Vwh1uMxmAYWUR3kst94
 Ji5a7F7L4pgGaHtmuptK4if54U+6BgKKr0SlvRbflccYPRgtjfHAEerHBBViQh87CwqoIVFN1
 xxbbEBDqfMWW+VslDgQ9FEnqf8tQNBiPKpdI/oHkMJhBIo8Mysu2IVWhnfDDh5s0JJiuVzHCW
 Eb1cDvy5Swkv12nIKj7p79cyqt7APIMIjhCgd2Bv9+hDlHQ2wUdjOCPAKQr0Z8I+Gr5WCtDNd
 pjA8cnxUpRgPc1wxL2USD3zMGeHG7oawCN+UZjd2CmVVuyho0/tj7IQJiC2wxboNFzA0/eUFg
 +a913BSP3cmpoSwwhBiZar9m+knFQfN1dOrpCaFPMwRX+fr1CeBYrEOWqu7+f53nvp366xtec
 NskIdH74UeOpGUyk3PebYBIlSQyrB6772VKQiI7RGMpyA56Q9Egoz5jCxtHKtqwfPu6W8R0eJ
 6dQmifWShWF4xgEbFHbrCNQQRNguphcdFxeG5o6GPEF1Wv+PRdyc6ApI3JtjQvAjpVHtZoqbD
 uMehWhug9vcoWF25NZFljvS82Ad95BgR2EdGuTaB3maCKivHeGURtN7qgc3d5UKB5nuS0VyLU
 vbYD14SxFhBrE2iPuG3kL2gtKNMSLP0HFrYwwJ7Mw+m/vkHoz1d6ddbO5jpyqE2OGeViuFJYk
 Wgk0bfHxgYNA89jvluiSDtxiW/rfhjZmMdMi3/+ShKMT430Rn5Ngjy5CRI5KVblRrZv+GLxpE
 KSkc0CM09mvVEtE6JOlbUD0ra3zcXJnQS/PpCwL7RDXwPKM6JctyVGaiaclnlVP7bcj9dxdRi
 AjhSfzrRtHze9qCBb3yo8rWN848Dy98oq00x3s2rr1RcIA+EDy9GMbt0S

Hi Ilpo,

Am 14.11.24 um 15:20 schrieb Ilpo J=C3=A4rvinen:
> PCIe BW controller uses IRQF_ONESHOT to solve the problem fixed by the
> commit 3e82a7f9031f ("PCI/LINK: Supply IRQ handler so level-triggered
> IRQs are acked"). The IRQ is shared with PME and PCIe hotplug. Due to
> probe order, PME and hotplug can request IRQ first without IRQF_ONESHOT
> and when BW controller requests IRQ later with IRQF_ONESHOT, the IRQ
> request fails. The problem is seen at least on Rasperry Pi 4:
>
> pcieport 0000:00:00.0: PME: Signaling with IRQ 39
> pcieport 0000:00:00.0: AER: enabled with IRQ 39
> genirq: Flags mismatch irq 39. 00002084 (PCIe bwctrl) vs.00200084 (PCIe =
PME)
> pcie_bwctrl 0000:00:00.0:pcie010: probe with driver pcie_bwctrl failed w=
ith error -16
>
> BW controller is always enabled so change PME and pciehp too to use
> IRQF_ONESHOT.
>
> Fixes: 470b218c2bdf ("PCI/bwctrl: Re-add BW notification portdrv as PCIe=
 BW controller")
> Reported-by: Stefan Wahren <wahrenst@gmx.net>
> Link: https://lore.kernel.org/linux-pci/dcd660fd-a265-4f47-8696-776a85e0=
97a0@gmx.net/
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>
I tested this patch on my Raspberry Pi 4B (linux-next, arm64/defconfig),
but unfortunately this doesn't fix the issue completely:

[=C2=A0=C2=A0=C2=A0 6.635741] pcieport 0000:00:00.0: PME: Signaling with I=
RQ 39
[=C2=A0=C2=A0=C2=A0 6.638845] genirq: Flags mismatch irq 39. 00000084 (aer=
drv) vs.
00202084 (PCIe PME)
[=C2=A0=C2=A0=C2=A0 6.638954] pcieport 0000:00:00.0: AER: request AER IRQ =
39 failed
[=C2=A0=C2=A0=C2=A0 6.638970] aer 0000:00:00.0:pcie002: probe with driver =
aer failed
with error -16

Regards

