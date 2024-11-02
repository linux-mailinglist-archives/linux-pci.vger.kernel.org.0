Return-Path: <linux-pci+bounces-15857-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 988319BA26A
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 21:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56374282D87
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 20:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E774F1A254F;
	Sat,  2 Nov 2024 20:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="TAFDcEr7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0AC4EB50
	for <linux-pci@vger.kernel.org>; Sat,  2 Nov 2024 20:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730578973; cv=none; b=UjZfNlJVxUB5WPtflk7wldxq6XumH5+HDtysJW1XM8UCut9QFTD37H+l2PJ4Nor3ql6qJXy+kXKfs8oUngUspoqGh3/wrNZiZUFtSIYlvajJImOxQHSLaQ+AW12WkvAUpmIA2W8VGBjpig9zYoKvRgdjGsdC2bHRDjRbjxQO9vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730578973; c=relaxed/simple;
	bh=zRAX2ENaR0UMfJOj8d1UGNAWanY+N/tfDqoGkhhiaKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YbWghVpXF9it53VCYkKA6ECS44pzr+McH4YXTziVZ6dO5JKzlsCSXZdowKVKqWZ539MZcd77pyLJjK4BSCtY6I4yrbZKm6yDRVnUg59QhdKwi4cx5kDhxV6sdCLa7cm4npP0WIlNc1aLngDnLDJq6YEzKrPtbeJUpY3DkRpOqNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=TAFDcEr7; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1730578957; x=1731183757; i=wahrenst@gmx.net;
	bh=zRAX2ENaR0UMfJOj8d1UGNAWanY+N/tfDqoGkhhiaKs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=TAFDcEr7YLK33Cc7hTp0P8fiFGLvsVwaXLo1i6EJJr8O5rYM70OUdg5Hw5eFuxL/
	 eOOrI/ZP1mUuGzqGU/s6KqaRqd+yll2GK0dHlD2fnXfhGmBx9yoO7mbxi+6qQ2WDY
	 KdluWM4HeDwfPC9K1xjjN7UvrQeIxvnsqS30G+DKE1JVmvGom5Ki1WLPnP5Ze3jsf
	 9aNOFC7GaIkwGv2BmY+kvo9R2IPjwYmkFQid0z9G/2sytTRu0QikVvOReCMbZK7Ri
	 jAakB/f3naxwGkCZuhc6xX5pK1lrT4kavHoTYP0LCfpT5BDRgfw3AJ2lSBHahjldG
	 aB5Ly3+ByJi/VrWweA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MO9z7-1tVssG0hFB-00SbiK; Sat, 02
 Nov 2024 21:22:37 +0100
Message-ID: <a98a03a2-bf62-4598-bcd4-07975271e07e@gmx.net>
Date: Sat, 2 Nov 2024 21:22:35 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pcie_bwctrl fails to probe on Rpi 4 (linux-next-20241101)
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: Jim Quinlan <jim2101024@gmail.com>, Lukas Wunner <lukas@wunner.de>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, kernel-list@raspberrypi.com
References: <dcd660fd-a265-4f47-8696-776a85e097a0@gmx.net>
 <26c4c8fd-6afd-44fe-83a9-adebc1a281bc@broadcom.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <26c4c8fd-6afd-44fe-83a9-adebc1a281bc@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bRRnNjncJ9/und7brzkRb+bkth3g0joXCMO6vQlG1WIudKlR+gI
 VVY7IdA4Z4nZiOhWzBucKzWugRDj9s/YUvKDOpSboQrxNOiGXk+w7JnieWR7DzxDNgwJh2y
 rWs2HPU7YTXGlCPOYd4KKPqIhNAdknuKzwG+1FyHWzxVuOzOnbwiWtgZxqr6R58ebLBK282
 sr568n0MquQAiORTdmkIQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:81YSOXPKfjk=;hgjiT11hnjsK8rhfoqQOoU/GICj
 CJpbBfap9I4EuHzrngr87EyhNvMa/36G3VNj45hQxDD0IRZlEoWDmqJF68SCRRymNiF/Gccf3
 y+KW1eAHfil93vlJ57Z09mUDptTHgy1Drloisx1G1FawLu1HIC6iUktHDaVQl2N+kP/T7Ek0P
 li9Xim2+dqhRFaNm7gHa9itutLdUnNhb2VTo1Ex4Rw0rVDN5p1J1T1o3O5bd6xxTz0Ns9N9vx
 YaJqOh0kMVIObPioKv/Abx16ob61WMrij03N2ejzM6UDAhQzKv+tOxBWjmu8FQhdV7wTfNqu7
 RR2ZxUlK5CSVWQK5V4LGNuj83mqEU6sSAB9Dm6nLmzPpVD6icTH7RXn+p7+FKNbwOSAPi40sk
 gkJzch+Vo+8uQ8gKVHKSwnZW1TU6PW0PSareElyQKq2UkEu5P5KmF/CJ7EpAYC6pzabtMIqs5
 D7fKCcuWTWP7Y0iX6Wf28jn4bFa38n07eAvAHceFpTXiCDs3JQ93D5E4dluC4e3eSVXWqC56t
 LiM0US8Ectlpsw4F2OmiNruRzKqd58pFe/sYZAr+zSXsvy4Sw6fByPbKAUdxm4/I7IMi8q0o3
 HO+JhA0XQXcuEmr2AcTlFRLWRXf1WD7jBe1QRQBwXkSslvbtexPi6FXWsPkaf3XbPbWqkis5s
 ++8AZCmNc3plIvM0KLcK0MWhRgRKv4hieFLtJFJsO+aKktbTOOnf42S2saz36fdl8qzOmJITW
 JV8+rv2zqg63pwC+Bp1wa74fsGGTQ3/XeFzJelRT3SJADFed338dsWCWEws/Xe4O+5DKlBKsM
 aLxfGmm/enwYAl1HWtZrNYrw==

Hi Florian,

Am 02.11.24 um 18:37 schrieb Florian Fainelli:
> Hi Stefan,
>
> On 11/2/2024 9:53 AM, Stefan Wahren wrote:
>> Hi,
>> I tested linux-next-20241101 with the Raspberry Pi 4 (8 GB RAM,
>> arm64/defconfig) and during boot the driver pcie_bwctrl fails to probe.
>> Since this driver is very new, I assume this never worked before:
>>
>> [=C2=A0=C2=A0=C2=A0 6.843802] brcm-pcie fd500000.pcie: host bridge /scb=
/pcie@7d500000
>> ranges:
>> [=C2=A0=C2=A0=C2=A0 6.843851] brcm-pcie fd500000.pcie:=C2=A0=C2=A0 No b=
us range found for
>> /scb/pcie@7d500000, using [bus 00-ff]
>> [=C2=A0=C2=A0=C2=A0 6.843900] brcm-pcie fd500000.pcie:=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 MEM
>> 0x0600000000..0x0603ffffff -> 0x00f8000000
>> [=C2=A0=C2=A0=C2=A0 6.843940] brcm-pcie fd500000.pcie:=C2=A0=C2=A0 IB M=
EM
>> 0x0000000000..0x00bfffffff -> 0x0400000000
>> [=C2=A0=C2=A0=C2=A0 6.859915] vchiq: module is from the staging directo=
ry, the quality
>> is unknown, you have been warned.
>> [=C2=A0=C2=A0=C2=A0 6.885670] brcm-pcie fd500000.pcie: PCI host bridge =
to bus 0000:00
>> [=C2=A0=C2=A0=C2=A0 6.885704] pci_bus 0000:00: root bus resource [bus 0=
0-ff]
>> [=C2=A0=C2=A0=C2=A0 6.885725] pci_bus 0000:00: root bus resource [mem
>> 0x600000000-0x603ffffff] (bus address [0xf8000000-0xfbffffff])
>> [=C2=A0=C2=A0=C2=A0 6.885823] pci 0000:00:00.0: [14e4:2711] type 01 cla=
ss 0x060400 PCIe
>> Root Port
>> [=C2=A0=C2=A0=C2=A0 6.885858] pci 0000:00:00.0: PCI bridge to [bus 01]
>> [=C2=A0=C2=A0=C2=A0 6.885876] pci 0000:00:00.0:=C2=A0=C2=A0 bridge wind=
ow [mem
>> 0x600000000-0x6000fffff]
>> [=C2=A0=C2=A0=C2=A0 6.885954] pci 0000:00:00.0: PME# supported from D0 =
D3hot
>> [=C2=A0=C2=A0=C2=A0 6.909911] pci_bus 0000:01: supply vpcie3v3 not foun=
d, using dummy
>> regulator
>> [=C2=A0=C2=A0=C2=A0 6.910159] pci_bus 0000:01: supply vpcie3v3aux not f=
ound, using
>> dummy regulator
>> [=C2=A0=C2=A0=C2=A0 6.910251] pci_bus 0000:01: supply vpcie12v not foun=
d, using dummy
>> regulator
>> [=C2=A0=C2=A0=C2=A0 6.922254] mmc1: new high speed SDIO card at address=
 0001
>> [=C2=A0=C2=A0=C2=A0 7.013175] brcm-pcie fd500000.pcie: clkreq-mode set =
to default
>> [=C2=A0=C2=A0=C2=A0 7.015309] brcm-pcie fd500000.pcie: link up, 5.0 GT/=
s PCIe x1 (SSC)
>> [=C2=A0=C2=A0=C2=A0 7.015526] pci 0000:01:00.0: [1106:3483] type 00 cla=
ss 0x0c0330 PCIe
>> Endpoint
>> [=C2=A0=C2=A0=C2=A0 7.015626] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0=
x00000fff 64bit]
>> [=C2=A0=C2=A0=C2=A0 7.015954] pci 0000:01:00.0: PME# supported from D0 =
D3hot
>> [=C2=A0=C2=A0=C2=A0 7.062153] pci 0000:00:00.0: bridge window [mem
>> 0x600000000-0x6000fffff]: assigned
>> [=C2=A0=C2=A0=C2=A0 7.062191] pci 0000:01:00.0: BAR 0 [mem 0x600000000-=
0x600000fff
>> 64bit]: assigned
>> [=C2=A0=C2=A0=C2=A0 7.062221] pci 0000:00:00.0: PCI bridge to [bus 01]
>> [=C2=A0=C2=A0=C2=A0 7.062237] pci 0000:00:00.0:=C2=A0=C2=A0 bridge wind=
ow [mem
>> 0x600000000-0x6000fffff]
>> [=C2=A0=C2=A0=C2=A0 7.062255] pci_bus 0000:00: resource 4 [mem 0x600000=
000-0x603ffffff]
>> [=C2=A0=C2=A0=C2=A0 7.062269] pci_bus 0000:01: resource 1 [mem 0x600000=
000-0x6000fffff]
>> [=C2=A0=C2=A0=C2=A0 7.062590] pcieport 0000:00:00.0: enabling device (0=
000 -> 0002)
>> [=C2=A0=C2=A0=C2=A0 7.062812] pcieport 0000:00:00.0: PME: Signaling wit=
h IRQ 39
>> [=C2=A0=C2=A0=C2=A0 7.072890] pcieport 0000:00:00.0: AER: enabled with =
IRQ 39
>> [=C2=A0=C2=A0=C2=A0 7.091767] v3d fec00000.gpu: [drm] Using Transparent=
 Hugepages
>> [=C2=A0=C2=A0=C2=A0 7.124274] genirq: Flags mismatch irq 39. 00002084 (=
PCIe bwctrl) vs.
>> 00200084 (PCIe PME)
>> [=C2=A0=C2=A0=C2=A0 7.124391] pcie_bwctrl 0000:00:00.0:pcie010: probe w=
ith driver
>> pcie_bwctrl failed with error -16
>
> Yes this is a new failure for sure. So PME requests the interrupt line
> with IRQF_TRIGGER_HIGH | IRQF_SHARED | IRQF_COND_ONESHOT whereas the
> bwctrl driver does: IRQF_TRIGGER_HIGH | IRQF_SHARED | IRQF_ONESHOT.
> Reading through the comment of IRQF_COND_ONESHOT, that does not seem
> to be an incompatible configuration, but maybe it is an ordering issue
> here? That is, bwctlr should claim the interrupt line first, and then
> PME would too, and they would be OK with the flags?
sorry, i don't have any clue about PCIE and the related stuff.

