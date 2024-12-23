Return-Path: <linux-pci+bounces-18965-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EF29FADEB
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 12:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C52E7A1169
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 11:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5151A0721;
	Mon, 23 Dec 2024 11:51:53 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4320E18BC19;
	Mon, 23 Dec 2024 11:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734954713; cv=none; b=NMS96Pa4Wwx5XkBBvmGE2VB5C96XjUKnVgfPcGfWnTBfE0AeFof3RvEBNt20l9APO8FhG/lelk/nqC0bGqaCLmErJA0MLyzdHrEbXU7kaQQiKJxM6fVKtTzSAhHlsWuINYAnngI2iuUkUb6tIO5Nw+WoDM+D3REnP7qAnx7IYzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734954713; c=relaxed/simple;
	bh=6ZpViNs5qrnoiqyRklUCfoSR9bRetdIHbKAAvq2ozwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KGTIdIEbfblCE7G11iNPALiokXH6eIj8yJmZjG9NVLrt7OXQQxlfcMT+EmctOj0hBEigZbF1rDEJqyKLCtf4nK3i6U4JuYn98elUEhFooKofovuS6xE8AL4ZkP2jQtKSIAPuowGjoBE3RMjwx9jbberhf7M15wULEWcJtSwvmdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 23 Dec 2024 20:51:43 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 585BC200909F;
	Mon, 23 Dec 2024 20:51:43 +0900 (JST)
Received: from iyokan2.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Mon, 23 Dec 2024 20:51:43 +0900
Received: from [10.212.247.91] (unknown [10.212.247.91])
	by iyokan2.css.socionext.com (Postfix) with ESMTP id 7E294AB183;
	Mon, 23 Dec 2024 20:51:42 +0900 (JST)
Message-ID: <5f978a20-3f28-4282-8688-b05f3a1f21b8@socionext.com>
Date: Mon, 23 Dec 2024 20:51:42 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] misc: pci_endpoint_test: Set reserved BARs for each
 SoCs
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241216073941.2572407-1-hayashi.kunihiko@socionext.com>
 <20241216073941.2572407-2-hayashi.kunihiko@socionext.com>
 <Z2E0EDC3tV76303d@ryzen> <56f1a6cf-40ad-4452-bce1-274eb3d124a9@socionext.com>
 <Z2QasXs0c9jQY8RL@x1-carbon>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <Z2QasXs0c9jQY8RL@x1-carbon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Niklas,

On 2024/12/19 22:08, Niklas Cassel wrote:
> On Thu, Dec 19, 2024 at 08:17:50PM +0900, Kunihiko Hayashi wrote:
>> On 2024/12/17 17:19, Niklas Cassel wrote:
>>
>>> If you simply add code that disables all BARs by default in am654, you
>>> should be able to remove these ugly is_am654_pci_dev() checks in the
>>> host
>>> driver, and the host driver should not be able to write to these
>>> reserved
>>> BARs, as they will never get enabled by pci-epf-test.c.
>>
>> However, dw_pcie_ep_reset_bar() only clears BAR registers to 0x0. BAR
>> doesn't have any "disabled" field, so I think that it means "32-bit,
>> memory,
>> non-prefetchable".
> 
>  From the DWC databook, 4.60a, section "6.1.2 BAR Details",
> heading "Disabling a BAR".
> 
> "To disable a BAR (in any of the three schemes), your application can
> write ‘0’ to the LSB of the BAR mask register."
> 
> dw_pcie_ep_reset_bar() calls __dw_pcie_ep_reset_bar(), which will
> write a zero to the LSB of the BAR mask register:
> https://github.com/torvalds/linux/blob/v6.13-rc3/drivers/pci/controller/dwc/pcie-designware-ep.c#L50

Now I missed it, and also find this description in the databook.

>>
>> https://github.com/torvalds/linux/blob/v6.13-rc3/drivers/pci/controller/dwc/pcie-designware-ep.c#L47-L52
>>
>> And even if each endpoint driver marks "BAR_RESERVED" to the features, it
>> is
>> only referred to as excluded BARs when searching for free BARs. So the
>> host
>> will recognize this "reserved" BAR.
> 
> A BAR that has been disabled on the EP side, will not have a size/
> be visible on host side.
> 
> Like I said, rk3588 calls dw_pcie_ep_reset_bar() on all BARs in EP init,
> like most DWC based EPC drivers, and marks BAR4 as reserved.
> This is how it looks on the host side during enumeration:
> 
> [   25.496645] pci 0000:01:00.0: [1d87:3588] type 00 class 0xff0000 PCIe
> Endpoint
> [   25.497322] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x000fffff]
> [   25.497863] pci 0000:01:00.0: BAR 1 [mem 0x00000000-0x000fffff]
> [   25.498400] pci 0000:01:00.0: BAR 2 [mem 0x00000000-0x000fffff]
> [   25.498937] pci 0000:01:00.0: BAR 3 [mem 0x00000000-0x000fffff]
> [   25.499498] pci 0000:01:00.0: BAR 5 [mem 0x00000000-0x000fffff]
> [   25.500036] pci 0000:01:00.0: ROM [mem 0x00000000-0x0000ffff pref]
> [   25.500861] pci 0000:01:00.0: supports D1 D2
> [   25.501240] pci 0000:01:00.0: PME# supported from D0 D1 D3hot

Surely writing 0 to dbi2.BARn (BAR mask) register disables BARn.
I tried to do that using UniPhier SoC, and found disabling any BARs in
the same way.

On the other hand, some other SoCs might have BAR masks fixed by the DWC
IP configuration. These BARs will be exposed to the host even if the BAR
mask is set to 0. However, such case hasn't been upstreamed, so there is
no need to worry about them now.

The am654 driver just doesn't call dw_pcie_ep_reset_bar(), so this case
probably doesn't apply.

Thank you,

---
Best Regards
Kunihiko Hayashi

