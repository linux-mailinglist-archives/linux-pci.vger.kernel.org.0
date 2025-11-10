Return-Path: <linux-pci+bounces-40680-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 226D3C45438
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 08:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6EF4188EF30
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 07:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F142E54B6;
	Mon, 10 Nov 2025 07:55:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bg2.exmail.qq.com (bg2.exmail.qq.com [114.132.63.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C917279787;
	Mon, 10 Nov 2025 07:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.63.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762761306; cv=none; b=aXsNveHBIf7sW4uRODkkaJpI+ScbvkAiEfXvFFmHcrxI90or2kcsoTgrV/Li0qeCkb3EC4KhtiCO0ijVQo/SkYHnTonxP4CTU0ckMAEeYpRYV4riaDlU+bz+wAg0BMdk4PfYUfQZiB2GuZDOCQZVDA4XoeTRM9pjoCQZaJH8D9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762761306; c=relaxed/simple;
	bh=LwvXpTSVojyx1MC96z6doTIVU2BtzwaHAIfGb93IdHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/WLl3x8jH2cVyN5dz1vaQsS7HVm4RwMyRfy2FHPSv4MhoHZ1Lu74n9ysaKeCpwRCQC89bdzZBdwE2IzfwkPyVxUgYHzzI/5Czo/QaqfbFapoVUTWbn+JR+a8s3T/XT0ymUKy0srRaKD2mg1SxNmDSykchiAnOSAu73ad4ncJ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=114.132.63.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip4t1762761171t85c608ae
X-QQ-Originating-IP: 4/pj04GV+NUG9bPpfO1T31SnMqTdV393yM24KkNEq88=
Received: from [IPV6:240f:10b:7440:1:64e0:6ba: ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 10 Nov 2025 15:52:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3134091033668820903
Message-ID: <0C31787C387488ED+fd39bfe6-0844-4a87-bf48-675dd6d6a2df@radxa.com>
Date: Mon, 10 Nov 2025 16:52:46 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] Re: [PATCH] PCI: dw-rockchip: Skip waiting for link up
To: Shawn Lin <shawn.lin@rock-chips.com>, Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Anand Moon <linux.amoon@gmail.com>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Dragan Simic <dsimic@manjaro.org>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
 mani@kernel.org
References: <20250113-rockchip-no-wait-v1-1-25417f37b92f@kernel.org>
 <1E8E4DB773970CB5+5a52c9e1-01b8-4872-99b7-021099f04031@radxa.com>
 <6e87b611-13ea-4d89-8dbf-85510dd86fa6@rock-chips.com>
 <aQ840q5BxNS1eIai@ryzen> <aQ9FWEuW47L8YOxC@ryzen>
 <55EB0E5F655F3AFC+136b89fd-98d4-42af-a99d-a0bb05cc93f3@radxa.com>
 <aRCI5kG16_1erMME@ryzen>
 <F8B2B6FA2884D69A+b7da13f2-0ffb-4308-b1ba-0549bc461be8@radxa.com>
 <780a4209-f89f-43a9-9364-331d3b77e61e@rock-chips.com>
 <4487DA40249CC821+19232169-a096-4737-bc6a-5cec9592d65f@radxa.com>
 <363d6b4d-c999-43d4-866e-880ef7d0dec3@rock-chips.com>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <363d6b4d-c999-43d4-866e-880ef7d0dec3@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: Nnd5cAEgLcFhaoh1TEl1DJYJf6tH1GPtz0M1lW/Y83FG0Y7A81bY4kY8
	UCyUIkphKW8g8LkRoe/5mvRRljOzdgBBZ0my6EdhTyhj2HNKazxJbrfXkpVQUjxFsds4zSa
	eJ77nEliz5VgZlxrVbKF/d22uPEIpi8zFk7I0uoyEfUUuj1m4O9RW4eH3jIsDOW//A+o9jo
	xlW0aF/lW4NRF1dWGf3ithBsdEuKY//7KYaXpcZzvsOWfaC7t/IrIEg71XHzla45JgZKlwK
	WDngZoN5bAxkjOMDcyQXPRnHeVsXqof5UQQXfY+Xz/4p+p9kfzYcxUsn1o4WLxIEdEczTzY
	SWLz3Zuc7WZKFjLQO8+lwQud3txm1pmQjqe/nbKSJzvOseoUljE2VMRQvtpBxBsz4pb06LA
	56EjbeQce5jc2+3Ilc+ILFTzqdPnBIGHlcvgpzaphoAZRaHvLRke4+VGGalXZ5k1rSTNJop
	EodhbJKYkETdx5tAQorF9knNXTStsWebZu+TEVakk5zzA3Dz4HouE2W8LNlmFux64M4lg43
	s/TFswj+XyXimmnF8/QmQSR4hHC4t+cW01Ze9Z+mOSjrLdB3coiS1BlYZSM7cyTcm77EOwo
	kyQRtm2DDMvOrv6oZffVhSYXwlbjCc7PEAOFyeKygVsfmk9TcpzCXkOGT84w8qL4GmeJNq0
	sXEgf+50URUkFU5HiXYsSq6RB2ncbimjpZVpYVcjzTXPrQr+SzYy2NZn4TbJZ41VuCjJdkD
	39GaHVNMsWVM8BxFk48IUtbXsG9OpmWnsw4a0QEyt9Jd6FylFGSHsQvpWO+DdUmeKG8v3vc
	Gr9i7eGeSKc5QdKavHcc8O2zlUKmxjEabs6QuVg6GY4qm9778vxdcnhinoHs1z2WuNxBseB
	m1FrnSA9UdGOBwD2NRGh9Tg3HzV7PynlYjmEmNVMeTJbfH7vhMyLJuQ3ogJ1l7fP3L/r/ri
	9CW3RRconjGKPWjalY6Nbck+RmOGmhwN0QUySDw8rAdEb2WlG84oRYzeJBAZufOlECp50+k
	tqZr60jZ0S2R9+0fSX
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-SPAM: true
X-QQ-RECHKSPAM: 3

Hi Shawn,

On 11/10/25 16:12, Shawn Lin wrote:
(snip)> Thanks for testing. I just got a ASM2806 switch as yours and 
verified it
> on vanilla v6.18-rc5. After 30 times of cold boot, two NVMes behind
> ASM2806 work as expected. Nothing special happened when I checked
> with PA as well. You could help check the log and lspci dump there[1].
> 
> [1]https://pastebin.com/sAF1fT0g

Thanks for the info!

I tried ASM2806 on Radxa ROCK 5B (RK3588).
  https://gist.github.com/RadxaNaoki/640e47d377add9fe38301de164d4058e

It doesn't work on PCIe 2.0 (M.2 E Key), but it does work on PCIe 3.0 
(M.2 M Key).

Could you try PCIe 2.0 slot on your board?

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.


