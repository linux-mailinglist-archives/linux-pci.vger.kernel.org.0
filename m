Return-Path: <linux-pci+bounces-40810-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8D2C4B2D5
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 03:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BF144ED4B0
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 02:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81429344025;
	Tue, 11 Nov 2025 02:10:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.65.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB582F29;
	Tue, 11 Nov 2025 02:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.65.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762827035; cv=none; b=H9PL+wrLKNM2x8lXYiykMAetSF1VQWoIWzy4MYXj2ZxvLfrJfJtyUBq6ViGvVwqnaPWxXdaiVodCgWTsNiQJEB1h7j/YMIntiAnmImZRQXY00N3sVYSgusXekvOtAJe6eQuOM3gmznZ6nHfnhx4Sh7j5wFc4BUpFbUPVx/yND0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762827035; c=relaxed/simple;
	bh=VDGwfiR11ixBsaRmmY90McQtvJcD3lWu7mcPA3DCoZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kU32Wkcw6gq6xmsqS/cWGY8p7rdKIk8WMgojNCRKroZAwRIxJUuB1spYHKRqYAhau1kVTv+D27m/Fith2p7D8wPHtHAI2N8JY075ADPpI0Z/xOk4fhCMeXB79veYDNMLmois0Hz3pvLFKdCSMjPIXl91wH4GNnUxJkPy7IEN5gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=114.132.65.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip3t1762826986t355f97ce
X-QQ-Originating-IP: Hiq+d1HFsdfBnF0CzHzpOopV81Jpt/t8pVjS27nsYIM=
Received: from [IPV6:240f:10b:7440:1:62e3:2c99 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 11 Nov 2025 10:09:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12658501094839713575
Message-ID: <B721C8A516FDB604+a04b38d3-64ec-423f-9e4c-040c8d2aec76@radxa.com>
Date: Tue, 11 Nov 2025 11:09:42 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] Re: [PATCH] PCI: dw-rockchip: Skip waiting for link up
To: Niklas Cassel <cassel@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Damien Le Moal
 <dlemoal@kernel.org>, Anand Moon <linux.amoon@gmail.com>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Dragan Simic <dsimic@manjaro.org>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>
References: <55EB0E5F655F3AFC+136b89fd-98d4-42af-a99d-a0bb05cc93f3@radxa.com>
 <aRCI5kG16_1erMME@ryzen>
 <F8B2B6FA2884D69A+b7da13f2-0ffb-4308-b1ba-0549bc461be8@radxa.com>
 <780a4209-f89f-43a9-9364-331d3b77e61e@rock-chips.com>
 <4487DA40249CC821+19232169-a096-4737-bc6a-5cec9592d65f@radxa.com>
 <363d6b4d-c999-43d4-866e-880ef7d0dec3@rock-chips.com>
 <0C31787C387488ED+fd39bfe6-0844-4a87-bf48-675dd6d6a2df@radxa.com>
 <dc932773-af5b-4af7-a0d0-8cc72dfbd3c7@rock-chips.com>
 <aRHb4S40a7ZUDop1@ryzen>
 <2n3wamm3txxc6xbmvf3nnrvaqpgsck3w4a6omxnhex3mqeujib@2tb4svn5d3z6>
 <aRJEDEEJr9Ic-RKN@fedora>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <aRJEDEEJr9Ic-RKN@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: Ml1iSfLyJEsHuvOrvH1QriXQF9INzJkBMODePrOGpgAgkbli0chZE2CG
	oLjrgiR7uGB4XyPTvHON+woHHgIrJRyx1vOr29Oe+6s2Gx+Q1oaIKXkfOfi9TCQorhrIDaA
	1zwDL6MZIQu67bvlzIKE+ynsGU0U1Av2oimbQAGyOfO5Pe73IHgQ70LvLLwf73WgepDpKaR
	MIz2MxIantWv58Rl00q6AuXe//rIWvaSu68eEFXztSSGZ1aT+k4/3JDt6Xy13NVHdk7cZwj
	LwwObnOcNUN+yBJuYtKK+vjd+ZbtxBheoc22prKuk40TcvHs0Tdn5u7LQKlHF8pxPdksrnW
	a9pP1fjNlq9uRu8MINAWgWrhX/qlLzfxpFAeoAEz8QFqQhnvnqxTYWD5CRCvG35jndajpFb
	z9mBiXEglLEurdW7g2DOudccazUYBjeJ4eRfP/KbP+MUzhqw08etBxq94fR/MfcozJD9mdj
	wxTpDj1RzcOZTsIL6JN5HEzq7Y2wPZ4aO+pawlkjCA3VeC9+G/J4bMYJ+9hayq6Xo2qKut6
	tYZCwm7xRx6wD5FGvYT5xNR2AdzPg3YBDhhZxVTvjjXd4aQSa7bpWmbOtIT0W/z1CFwZVHM
	V284Jw1I+rybPM9SMEYTLsNGW7Y0Zs7RUtA4uBM3T/VJNua4jJanvalxtThXAo9Zt2KnSeH
	/AFW6AYWKvt1RBpy/jI9WyKGY/CDC6AYgMZPA++lM/z97Q7QqslcIWQMRACKvQqDQtXhTn2
	uhOiMbjRyC9B/IYccBTDvYOnQgkA+KAqdxW/lMiwr9vnYBQpWto1kwsLPt9KuYxIO8K/SJ2
	ZMoYI3nz/blOj+p2TkCNJ1xXD7d/LfAcyEeTZDvKSLEXGWII0GnxpbhCkaCScf+z1NRoTKl
	j5bp70AC4vfLVyNx9lXs2ifXAAQdq+om2/IPxrpxeBDLvQrp4DJLHxvKzV0StjyQX7PVSnP
	FEYm4TjamFGbobcPUJaz6RYvNYR4XGP8AsmFUY1Q0tJOe0oWT/1nEZx14R3sajgyHljvMOt
	7OKox8Dw6GzNY4Vbjp
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

On 11/11/25 04:59, Niklas Cassel wrote:
> On Mon, Nov 10, 2025 at 09:23:02PM +0530, Manivannan Sadhasivam wrote:
>>>
>>> Considering what Shawn says, that the switch gets enumerated properly
>>> if we simply add a msleep() in ->start_link(), which will be called
>>> by dw_pcie_host_init() before pci_host_probe() is called...
>>>
>>
>> Yes, that delay probably gives enough time for the link up IRQ to kick in before
>> the initial bus scan happens.
> 
> I think that the problem is that even for platforms with link up IRQ,
> we will always do:
> 1) dw_pcie_start_link() (if (!dw_pcie_link_up()))
> 2) pci_host_probe() from dw_pcie_host_init(), this will enumerate the bus
> 3) pci_rescan_bus() from the Link Up IRQ handler
> 
> Thus, in 2, when enumerating the bus, without performing any of the delays
> mandated by the PCIe spec, it still seems possible to detect a device (it
> must have been really quick to initialize), and to communicate with that
> device, however since we have not performed the delays mandated by the spec,
> it appears that the device might not yet behave properly.
> 
> Hence my suggestion to never call pci_host_probe() in dw_pcie_host_init()
> for platforms with Link Up IRQ.
> 
> At least for pcie-dw-rockchip.c, we only unmask the Link Up IRQ after
> dw_pcie_host_init() has returned, so I think that your theory: that Shawn's
> suggested delay causes the Link Up IRQ to kick in before the initial bus
> scan, is incorrect. (Since the IRQ should not be able to trigger until
> dw_pcie_host_init() has returned.)
> 
> 
>>
>>> ...we already have a delay in the link up IRQ handler, before calling
>>> pci_rescan_bus().
>>>
>>
>> That delay won't help in this case.
> 
> Sure, I was just saying that even though Shawn's patch made things work,
> it seems incorrect, as we do not want to add "the same delay" that we
> already have in the Link Up IRQ. (The delay in the Link Up IRQ should be
> the only one.)
> 
> 
>>> I think a better solution would be something like:
> 
> (snip)
> 
>> This solution will work as long as the PCIe device is powered ON before
>> start_link(). For CEM and M.2 Key M connectors, the host controller can power
>> manage the components. But for other specifications/keys requiring custom power
>> management, a separate driver would be needed.
>>
>> That's why I suggested using pwrctrl framework as it can satisfy both usecases.
>> However, as I said, it needs a bit of rework and I'm close to submitting it.
>>
>> But until that gets merged, either we need to revert your link up IRQ change or
>> have the below patch. IMO, the revert seems simple.
> 
> Using pwrctrl framework once it can handle this use case sounds good to me.
> 
> FUKAUMI, could you please send a revert of the two patches?

Leaving the commit message aside, I'm currently testing with a revert of 
the two patches.

Vanilla v6.18-rc5, CONFIG_PCI_DYNAMIC_OF_NODES=y, revert ec9fd499b9c6, 
revert 0e0b45ab5d77.

It works stably on the ROCK 5A. The link speed is 2Gb/s.

The ROCK 5C is unstable. It initially worked with a link speed of 4Gb/s, 
but eventually started showing kernel oops. The dts files for the 5A and 
5C are compatible and interchangeable, but even using the 5A's dts on 
the 5C, the operation remains unstable.

I plan to thoroughly investigate the ROCK 5C's behavior on v6.13, but 
for now, I believe reverting the two patches is the correct action.

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> Kind regards,
> Niklas
> 



