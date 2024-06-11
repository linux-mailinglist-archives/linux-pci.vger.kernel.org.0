Return-Path: <linux-pci+bounces-8606-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 026F8904437
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 21:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8117CB226A6
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 19:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2491770F2;
	Tue, 11 Jun 2024 19:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="SngNSu9N"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66886BFD5;
	Tue, 11 Jun 2024 19:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718132753; cv=none; b=MKiwZ37LXZHRPQ9FBdkx6hkyyqdiEWKd5hOnRDjPESXp0M/nj5MDdJb4F9O6BtoO2u0vwk/aVS2gd0Cp1P52DPPVUsvozMzlETyAxrCF3SRb0lHz7KIdcBH/tffoy9lscC7oaIRucjoDmtP0qucS5mlKQVsMgNyrNObPxsjxOrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718132753; c=relaxed/simple;
	bh=nUBP7bsUfsEK+9gyrO8qtU3wCF77O8GiFAqW5AH+FkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kJEpcpFywObhoG/QyXtVfk8QgizUg5dwOliTDR61KZ9DLDt5F3U/P04DiPE03I/UNRGFqjLC+/bRJnBM1lVm8CvUVx8mu17FOVrE1CXLoNfb+NJGcSs/ngptnHOWceA3/dNG4ttcdRG6rPynpeU0kveNKo7qiPsL0GQUHcyfQog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=SngNSu9N; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1718132726; x=1718737526; i=wahrenst@gmx.net;
	bh=xUbVYqL/tSB6Erdm9Q9WWB8sr6RA+845QXSCGpIcgu4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SngNSu9Nrbx1uFjdj4DCnW7nXgccKxEqJ889pkGKYgduewarQnPxEpVPcRcaK8Yo
	 VdwCD2/409fikHCuHj2m0ICeXYi8OXbmez9/unN8g/f+aYxsXzW7VHSYQLdEhKsd5
	 7mEXo13CT7zFu1bMPE4Xqhk/tbD/H6UVQPfsZ3wvdhgk0aTQBTX8PCRtUM763YnEu
	 OUHKibh9ARBzJ7TNQttuVMWNP95Ys4kJLmzDpysNzqWyhRhOGQilMTboA67rAEdxD
	 MkwzcfTndATklJu1G/Qczsy5ZLDlSZ3ifJAgTCyPPe6Vymyk1ByNHNkM5/wQ4syta
	 H0jU82QksMIEvhYv8w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1Hdq-1sFRqm1cd8-00ESgm; Tue, 11
 Jun 2024 21:05:26 +0200
Message-ID: <ba8cdf39-3ba3-4abc-98f5-d394d6867f95@gmx.net>
Date: Tue, 11 Jun 2024 21:05:24 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Raspberry Pi5 - RP1 driver - RFC
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, Dave Ertman <david.m.ertman@intel.com>,
 Lizhi Hou <lizhi.hou@amd.com>, clement.leger@bootlin.com,
 Jeremy Linton <jeremy.linton@arm.com>
References: <ZmhvqwnOIdpi7EhA@apocalypse>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <ZmhvqwnOIdpi7EhA@apocalypse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OB0hfFsqxZr9kGH7XcJPaqr+ioKh+2kcAZtcaoyOIbHUQVeoSoQ
 TU1kXZ95icZh3jEZ/ynUq312plHbCXG1gbMR5cNxD3c0e+E8PC7fXZktLeqC+L5iLssusUu
 wtD1nAgXrpllrAjl40OLxh+tv50H47cmxjCBdj5gVPdQm2PCiUzlwYopLgj4aXqsaSXGcgv
 XHDIM4uxyFhSAV4qbx7pA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:un4fNYOcPEA=;NqyyWz/kMQ9QKJ47+10JgX7FWKm
 BMhxX+dcObiguuZshliAbKRhZQ/WczhJ9i6zzsCC+pVwzAqkwM5DXEsRScU7uFRC4Jskh8rGL
 Zo75OcU7LEP5XjlcsjSExw9uavjtm8FBMU/3lgDdQGe0EkwUYCzsADPpxFCDMK78z5akRpaZm
 sJAJ3uhltQs021NF4CQ6cUJNNaXCcX3CdQV28pF+fQ2eG3AEKrPIWptkRITvAJRYXmvdDj1/q
 e6XVmDz2vWkzA72E8fOYud1l8bFyO5VSaZWjFhX4YccVusuE0yvNLBGC0QWulJS1js3eBuDHw
 JOrNjt9JbTjqjxifqbWra92+lOfwONY2B3YgxMSHQEPMH11Oc/h2AMQV2Qi0pOd6bM9nZOqnE
 YfIdHl7WU2qEfy67r0MdCspArw0+az8tC3F5kVYsH8f+nroN9Ko52IjjRE/nTXesh5v30FNYa
 Hf2vfxxc+zuTL01qGv2ITz/HNuMScVJvHMCpgnLjFDuhltSQKfW4upujH3N8Bxk0nS+aT0K+d
 TnkCtvXqZsbFBGx4SBil7Gh6K1LnlPX7Py2klyWmk6kwh9M7QM7n0B7F9uPBLkF8OQRePP5cL
 verF8Y9YOyX46IpX1c2gJi9s+ISi/I5BXqyxXwASe6AM/zM7uqgA7R0gD0YWUi8yXU7epfwl4
 xDYTuyMW4SwyURJKqyKH6jBwqmhtfBuwKjIpu2BziOn4hN8QyHsZkMxlYPf2p/qzwToxu4g1n
 oN5yQ/7/xjKO9Q8lnP0KwpsqAtAGQ16OcPTSvxLX1hVx1wEtPCToaCUDV6Z6X0vSoOZN6VVvK
 F7HO+m8p41KaR8uee3ytOxcAepakG2k53CFgZy6CCnMBM=

Hi Andrea,

i added Jeremy, because AFAIK he was deeply involved in ACPI
implementation of the RPi 4.

Am 11.06.24 um 17:39 schrieb Andrea della Porta:
> Hi,
> I'm on the verge of reworking the RP1 driver from downstream in order fo=
r it to be
> in good shape for upstream inclusion.
> RP1 is an MFD chipset that acts as a south-bridge PCIe endpoint sporting=
 a pletora
> of subdevices (i.e.  Ethernet, USB host controller, I2C, PWM, etc.) whos=
e registers
> are all reachable starting from an offset from the BAR address.
> The main point here is that while the RP1 as an endpoint itself is disco=
verable via
> usual PCI enumeraiton, the devices it contains are not discoverable and =
must be
> declared e.g. via the devicetree. This is an RFC about the correct appro=
ach to use
> in integrating the driver and registering the subdevices.
>
I cannot provide much input into the technical discussion, but i would
prefer an approach which works good with DT and ACPI.

Best regards
Stefan
>
> Link:
> - [1]: https://github.com/raspberrypi/linux/blob/rpi-6.6.y/arch/arm/boot=
/dts/broadcom/rp1.dtsi
> - [2]: https://github.com/raspberrypi/linux/blob/rpi-6.6.y/drivers/mfd/r=
p1.c
> - [3]: https://lpc.events/event/17/contributions/1421/attachments/1337/2=
680/LPC2023%20Non-discoverable%20devices%20in%20PCI.pdf
> - [4]: https://lore.kernel.org/lkml/20230419231155.GA899497-robh@kernel.=
org/t/
> - [5]: https://lore.kernel.org/lkml/Y862WTT03%2FJxXUG8@kroah.com/


