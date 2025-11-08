Return-Path: <linux-pci+bounces-40634-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C9596C42E33
	for <lists+linux-pci@lfdr.de>; Sat, 08 Nov 2025 15:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 595333472A8
	for <lists+linux-pci@lfdr.de>; Sat,  8 Nov 2025 14:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A32B1C84DF;
	Sat,  8 Nov 2025 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="P189H++3"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645151DA55
	for <linux-pci@vger.kernel.org>; Sat,  8 Nov 2025 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762611724; cv=none; b=MRh6/0sP3buFe7jiKi7zuWG7C8HJX3f+TKx4d897m4kgF7tsTb28ds3Emm5CfLdxysK3CcfIn+bWEKlUVqOsLX5wSJIHMFW8o6YUyfUxxA6AQnGy653J76zThLNd//P5eLB6d31loOjxBH83Dz90Woavkw8enTRcH6Fc44VGR8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762611724; c=relaxed/simple;
	bh=xFN01/OZAVS5twqZybqzefKbj7D6W91s2Fe+5Did+JA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=OP333XutfQKZRY6FTDn4tByuUvH766hxeFto8fe5G8n7/WvM2IBfASm89ynJR+pCvkYm5FplU/YpWUyyQVahxYzsy8jzBP3LiURbdGD9Wqo67FgZLTjtm/8bnrZMZaNtqadT5aZ0rbp9Nyy1VAyQkTduz45Yz/W6DzVqbsxiCP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=P189H++3; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
	s=key1; t=1762611715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LPn9l+QoDiG2QhjIafrV6sGFlG1kFs7V/OcM6xzYO04=;
	b=P189H++3jsjVCo2N95hPxrfBzWWByQ0uwh1OJKldQ/RBEV/5VZAgdfHmvB5vYrtufQnceg
	WApyA74cMwLyug8RtetofDrFbjO4cC48jNDcwONMyeACAcv0mvZh7ZnQTHA9JWew3W9ZWi
	qBH+ZmcO65lYR1rqmc/zMYzcY+ePOGBzLlpkSJWEtQRFD0OlobZPINuSI/Pfa3N7E2WfWU
	nCCihzEoTb6LsqNm1+Vx+pUpNlYVm8rgximClhXyAVtwZVUFQ52C1a15J2j7sy2BtrbfAF
	ZkHAeduwh8nm7yQz1YlcwyV/AAcYiwU/LwmBbOs2Z5KjF5B6UsH8uTsBVDLE8Q==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 08 Nov 2025 15:21:45 +0100
Message-Id: <DE3DPAVIOGZP.7RW4SGB8HXUT@cknow-tech.com>
Cc: "FUKAUMI Naoki" <naoki@radxa.com>, "Damien Le Moal"
 <dlemoal@kernel.org>, "Anand Moon" <linux.amoon@gmail.com>,
 <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 "Dragan Simic" <dsimic@manjaro.org>, "Lorenzo Pieralisi"
 <lpieralisi@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
 "Rob Herring" <robh@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 "Heiko Stuebner" <heiko@sntech.de>
Subject: Re: [PATCH] PCI: dw-rockchip: Skip waiting for link up
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Niklas Cassel" <cassel@kernel.org>, "Shawn Lin"
 <shawn.lin@rock-chips.com>
References: <20250113-rockchip-no-wait-v1-1-25417f37b92f@kernel.org>
 <1E8E4DB773970CB5+5a52c9e1-01b8-4872-99b7-021099f04031@radxa.com>
 <6e87b611-13ea-4d89-8dbf-85510dd86fa6@rock-chips.com>
 <aQ840q5BxNS1eIai@ryzen> <aQ9FWEuW47L8YOxC@ryzen>
In-Reply-To: <aQ9FWEuW47L8YOxC@ryzen>
X-Migadu-Flow: FLOW_OUT

On Sat Nov 8, 2025 at 2:27 PM CET, Niklas Cassel wrote:
> On Sat, Nov 08, 2025 at 01:34:32PM +0100, Niklas Cassel wrote:
>>=20
>> The pcie-dw-rockchip.c driver is modelled after the qcom driver.
>> So if this is a problem when a ASM2806 switch is connected, I would
>> expect qcom platforms to have the same problem.
>
> Looking more closely at this, comparing the "good" kernel:

There's another thing that caught my eye ...

> [    1.868857] pci 0004:40:00.0: [1d87:3588] type 01 class 0x060400 PCIe =
Root Port
> [    1.869509] pci 0004:40:00.0: ROM [mem 0x00000000-0x0000ffff pref]
> ...
> [    1.879764] pci 0004:41:00.0: enabling Extended Tags
> [    1.880614] pci 0004:41:00.0: PME# supported from D0 D3hot D3cold
> [    1.881409] pci 0004:41:00.0: 2.000 Gb/s available PCIe bandwidth, lim=
ited by 2.5 GT/s PCIe x1 link at 0004:40:00.0 (capable of 15.752 Gb/s with =
8.0 GT/s PCIe x2 link)

... 2.000 Gb/s ...

> [    1.888729] pci 0004:41:00.0: bridge configuration invalid ([bus 00-00=
]), reconfiguring
> ...
>
>
> With the "bad" kernel:
> [    1.383075] pci 0004:40:00.0: [1d87:3588] type 01 class 0x060400 PCIe =
Root Port
> [    1.383738] pci 0004:40:00.0: ROM [mem 0x00000000-0x0000ffff pref]
> ...
> [    1.415746] pci 0004:41:00.0: enabling Extended Tags
> [    1.416465] pci 0004:41:00.0: PME# supported from D0 D3hot D3cold
> [    1.417181] pci 0004:41:00.0: 4.000 Gb/s available PCIe bandwidth, lim=
ited by 5.0 GT/s PCIe x1 link at 0004:40:00.0 (capable of 15.752 Gb/s with =
8.0 GT/s PCIe x2 link)

... 4.0000 Gb/s

I don't know if that's relevant or important, but wanted to mention it.

Cheers,
  Diederik

> [    1.423384] pci 0004:41:00.0: bridge configuration invalid ([bus 00-00=
]), reconfiguring
> ...
>
>
> We can see that the pcie-dw-rockchip.c driver detects the ASM2806 switch
> in both cases. So the problem is not really with enumerating the root por=
t.
>
> The problem seems to be that with the "bad" kernel, you get a lot of:
> [    1.464651] pci 0004:42:00.0: devices behind bridge are unusable becau=
se [bus 43] cannot be assigned for them
>
> Because the bus ends are different, and conflicts with each other.
> I don't know why this happens.
>
> Perhaps we could add a quirk for ASM2806 that does some extra sleep if th=
at
> switch is detected, if for some reason, the switch is not actually ready
> after the delays defined by the PCIe specification.
>
> (And btw. please test with the latest 6.18-rc, as, from experience, the
> ASPM problems in earlier RCs can result in some weird problems that are
> not immediately deduced to be caused by the ASPM enablement.)
>
>
> Kind regards,
> Niklas

