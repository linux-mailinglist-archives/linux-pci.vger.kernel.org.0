Return-Path: <linux-pci+bounces-8210-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FB38FA7BC
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 03:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72BFE1F23E00
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 01:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262B5288A4;
	Tue,  4 Jun 2024 01:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilIRnfCX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED54C4A04;
	Tue,  4 Jun 2024 01:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717465894; cv=none; b=RdpWuNZBPQ8n18aw4a0nyqwqUuXj7RzhEEWVdIeUQ27GrPDGqpxufgt2udbX6KRtBkCevsUdUAK6aARkNCD+VmWfr2q6Fv2+z9qKyvTg5U37hfWVF4rZye6TCPOS3QZuoo2/AVnPk1xLe39vyEDJTg9FVBMsLCrBVLbY2tYuVcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717465894; c=relaxed/simple;
	bh=dEPv1dYC3IoPhn6DAU+v5jT+Lv/0U5BtbLurTzGUu1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WAzcGmZm5aFbjWDzOrLSZ1oShNIPBEPSfkkk4l9PoRkJShk3zuwFOQ/SHTowTEoXxK8yZ+GN7wO4ixhMxuNcyLq7bCCbzPBzd9jpb3X/IxR9RLt4iiS0/6u4WYLXsfgN8Swr44+b6ka6MnYX9Z4+Cpdjl5v6gB5YYaoay9HLwTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilIRnfCX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647E2C2BD10;
	Tue,  4 Jun 2024 01:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717465893;
	bh=dEPv1dYC3IoPhn6DAU+v5jT+Lv/0U5BtbLurTzGUu1k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ilIRnfCX2IMfOHYc9qygVQ7gs3ZJHi1xvtlDsULEKrGRSQcNVgAWPpKa8u9Yznb+4
	 ZrHy0Hgf6z26Oh10/wXCBY0XMeZS4UbeoQ8/02iUccl+Kv7pdck5c2dMF1p/77JLv4
	 SF0sGw26WeOtqgOKwKm3jJYgI+kUJG/EemC3ohi3WWLqv1j755c2FSG2eueA6nHt4o
	 lSoxP+YDI5Aw96mwq2q5JqmdxLdV9GBfqVaxRNhd9MBu7Y20HRUEwx9T4ksjCWCHO1
	 oukzoMq28Z12OUqyjVOg7N8pMfE8B1C+JJEuZkMlmIMuLDyM2fmLhKgzG0JTGL47aN
	 /emSPme8p9eew==
Message-ID: <b272c3e3-ccfc-49ab-bc0b-242cd01161e3@kernel.org>
Date: Tue, 4 Jun 2024 10:51:30 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/13] PCI: dw-rockchip: Add endpoint mode support
To: Kever Yang <kever.yang@rock-chips.com>, Niklas Cassel
 <cassel@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Jon Lin <jon.lin@rock-chips.com>, Shawn Lin <shawn.lin@rock-chips.com>,
 Simon Xue <xxm@rock-chips.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org
References: <20240529-rockchip-pcie-ep-v1-v4-0-3dc00fe21a78@kernel.org>
 <05b1bfa3-4284-4820-b0f6-124e08088456@rock-chips.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <05b1bfa3-4284-4820-b0f6-124e08088456@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/24 10:45, Kever Yang wrote:
> Hi Niklas,
> 
> On 2024/5/29 16:28, Niklas Cassel wrote:
>> Hello all,
>>
>> This series adds PCIe endpoint mode support for the rockchip rk3588 and
>> rk3568 SoCs.
>>
>> This series is based on: pci/next
>> (git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git)
>>
>> This series can also be found in git:
>> https://github.com/floatious/linux/commits/rockchip-pcie-ep-v4
>>
>> Testing done:
>> This series has been tested with two rock5b:s, one running in RC mode and
>> one running in EP mode. This series has also been tested with an Intel x86
>> host and rock5b running in EP mode.
> 
> I'm interesting how you test in Intel x86 host, PC scan the PCIe device 
> in BIOS, do you
> 
> power on the EP before PC power on?

Yes. Same with any host, not just x86.

-- 
Damien Le Moal
Western Digital Research


