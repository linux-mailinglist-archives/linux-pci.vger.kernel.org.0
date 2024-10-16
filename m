Return-Path: <linux-pci+bounces-14615-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130339A0135
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 08:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 735DBB24DB4
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 06:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C7B18B48D;
	Wed, 16 Oct 2024 06:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdtNJPvO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E51360B8A;
	Wed, 16 Oct 2024 06:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729059317; cv=none; b=OyU91yqhoFKi3829VqBVD+ntZAqSr9nAEIznrhwV6eZOayxnnnmXbuAqy1TuOq2I5KI66XXtmMxobuQMyYaixIjNnetarO5ORHm+lR+1lW1QmJlQsLsoR1doeXe2wdXiZN7tpTBTVxbpui/l/rsY/8cAiq41d7lvEf9J+ESkPns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729059317; c=relaxed/simple;
	bh=5QlqQFbsraBNja/vvnJZK7fg7rwhZcLGk4smWz8inKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g0Ygh1n38iB8iNypIh61K8wCcdCQMXzOFBIyiuIUoyyJxX+KxapYMmj6psIEDf1fu01eBzyv5y9q9+0S3nv/izJODRtFQ7v4yfgUwpWayWIHnSzI4wWmcRgLL+rxsXDJQxLoKAk98/Cqu5MrXog4rlQB3fjK8AJRXWCApQRYtHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdtNJPvO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B421C4CECF;
	Wed, 16 Oct 2024 06:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729059316;
	bh=5QlqQFbsraBNja/vvnJZK7fg7rwhZcLGk4smWz8inKE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pdtNJPvOsWONhQ4vGRNvdcIHe2/KnhvO2wGB3pK1MEx2OrOtuwl5OW4EVdtAsUUZ6
	 QWWWpoesM3mvYrqJhZUx/gbLp5STTQGTuAEyXV7p3yOHmsVbyCIZEgAnyriVjcIqFm
	 BjPkvyzBaM7BIj5zUmXhseKZC1ZP/Kg1svvOf13jtPVaT8lh7oCr5PUZw/YnorVPUG
	 aKuoJfPw93k6v9kEVtmwOM3N/T/jienNKbeKUWtFihPmaQyeo1ZItl9xlBYogfGJMh
	 jSdugkECURoY5qCWWPXGsW5NhojXw9wMD90ZomcucjbO++EA9J8uyQYHx71UyESIWo
	 KXiEknxeMuFqw==
Message-ID: <f13618a6-0922-4fc8-af01-10be1ef95f0d@kernel.org>
Date: Wed, 16 Oct 2024 15:15:11 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/12] Fix and improve the Rockchip endpoint driver
To: Anand Moon <linux.amoon@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20241011121408.89890-1-dlemoal@kernel.org>
 <CANAwSgQ+YmSTqJs3-53nmpmCRKuqfRysT37uHQNGibw5FZhRvg@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <CANAwSgQ+YmSTqJs3-53nmpmCRKuqfRysT37uHQNGibw5FZhRvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/24 2:32 PM, Anand Moon wrote:
> Hi Damien,
> 
> On Fri, 11 Oct 2024 at 17:55, Damien Le Moal <dlemoal@kernel.org> wrote:
>>
>> This patch series fix the PCI address mapping handling of the Rockchip
>> endpoint driver, refactor some of its code, improves link training and
>> adds handling of the #PERST signal.
>>
>> This series is organized as follows:
>>  - Patch 1 fixes the rockchip ATU programming
>>  - Patch 2, 3 and 4 introduce small code improvments
>>  - Patch 5 implements the .get_mem_map() operation to make the RK3399
>>    endpoint controller driver fully functional with the new
>>    pci_epc_mem_map() function
>>  - Patch 6, 7, 8 and 9 refactor the driver code to make it more readable
>>  - Patch 10 introduces the .stop() endpoint controller operation to
>>    correctly disable the endpopint controller after use
>>  - Patch 11 improves link training
>>  - Patch 12 implements handling of the #PERST signal
>>
>> This patch series depends on the PCI endpoint core patches from the
>> V5 series "Improve PCI memory mapping API". The patches were tested
>> using a Pine Rockpro64 board used as an endpoint with the test endpoint
>> function driver and a prototype nvme endpoint function driver.
> 
> Can we test this feature on Radxa Rock PI 4b hardware with an external
> nvme card?

This patch series is to fix the PCI controller operation in endpoint (EP) mode.
If you only want to use an NVMe device connected to the board M.2 M-Key slot,
these patches are not needed. If that board PCI controller does not work as a
PCI host (RC mode), then these patches will not help.

-- 
Damien Le Moal
Western Digital Research

