Return-Path: <linux-pci+bounces-18769-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 695359F7A33
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 12:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59CEE7A1337
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 11:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7961B222563;
	Thu, 19 Dec 2024 11:18:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E99B2594;
	Thu, 19 Dec 2024 11:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734607082; cv=none; b=kYgXmtk09Q6EefLYUZmzFAoI0HJr2eD2PvFCH270uYCdljFnWkJyzTm2Olj9ZSovKxrOT9TO15cBkQhdxLuF77/0rMk3bCgE8vjZ2XiC53GGIzzmVXrAAny4G59H/VCN6TK9YDLs3RyWb1hiG3g76Tcj7eS1xt5twYhGwn02Sc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734607082; c=relaxed/simple;
	bh=8pBD7v2MrRzV+470E6q4OR0HHgmy2m8EVPZb1hfeuIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4mT9kuY7Y28QBW5+hFZfbMJxl8R6sGzsMo+YLpw9yvBzQ4OFX4hZaQAgE8gX9PWqnntVlhen0zAkobNkJ9vQUKgveTHdVxJy0fPcYFcOeTx4cYyKliYOS8fYl10PNjaJWbLXuRjMkS0QNFj1UUpUs80nrABIGDyPQQYZBzDeEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 19 Dec 2024 20:17:51 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id D5148200909F;
	Thu, 19 Dec 2024 20:17:51 +0900 (JST)
Received: from iyokan2.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Thu, 19 Dec 2024 20:17:51 +0900
Received: from [10.212.247.91] (unknown [10.212.247.91])
	by iyokan2.css.socionext.com (Postfix) with ESMTP id 4CE93AB186;
	Thu, 19 Dec 2024 20:17:51 +0900 (JST)
Message-ID: <56f1a6cf-40ad-4452-bce1-274eb3d124a9@socionext.com>
Date: Thu, 19 Dec 2024 20:17:50 +0900
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
 <Z2E0EDC3tV76303d@ryzen>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <Z2E0EDC3tV76303d@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Niklas,

Thank you for your comment.

On 2024/12/17 17:19, Niklas Cassel wrote:
> Hello Hayashisan,
> 
> On Mon, Dec 16, 2024 at 04:39:41PM +0900, Kunihiko Hayashi wrote:
>> There are bar numbers that cannot be used on the endpoint.
>> So instead of SoC-specific conditions, add "reserved_bar" bar number
>> bitmap to the SoC data.
> 
> I think that it was mistake to put is_am654_pci_dev() checks in
> pci_endpoint_test.c in the first place. However, let's not make the
> situation worse by introducing a reserved_bar bitmap on the host side as
> well.
> 
> IMO, we should not have any logic for this the host side at all.

I also think that is_am654_pci_dev() isn't good solution, and I agree 
with you.

> Just like for am654, rk3588 has a BAR (BAR4) that should not be written by
> pci_endpoint_test.c (as it exposes the ATU registers in BAR4, so if the
> host writes this BAR, all address translation will be broken).
> 
> An EPC driver can mark a BAR as reserved and that is exactly was rk3588
> does for BAR4:
> https://github.com/torvalds/linux/blob/v6.13-rc3/drivers/pci/controller/dwc/pcie-dw-rockchip.c#L300
> 
> Marking a BAR as reserved means that an EPF driver should not touch that
> BAR at all.
> 
> However, this by itself is not enough if the BAR is enabled by default,
> in that case we also need to disable the BAR for the host side to not
> be able to write to it:
> https://github.com/torvalds/linux/blob/v6.13-rc3/drivers/pci/controller/dwc/pcie-dw-rockchip.c#L248-L249
> 
> 
> If we look at am654, we can see that it does set BAR0 and BAR1 as reserved:
> https://github.com/torvalds/linux/blob/v6.13-rc3/drivers/pci/controller/dwc/pci-keystone.c#L967-L968
> 
> The problem is that am654 does not also disable these BARs by default.
> 
> 
> If you look at most DWC based EPC drivers:
> drivers/pci/controller/dwc/pci-dra7xx.c:
> dw_pcie_ep_reset_bar(pci, bar);
> drivers/pci/controller/dwc/pci-imx6.c:          dw_pcie_ep_reset_bar(pci,
> bar);
> drivers/pci/controller/dwc/pci-layerscape-ep.c:
> dw_pcie_ep_reset_bar(pci, bar);
> drivers/pci/controller/dwc/pcie-artpec6.c:
> dw_pcie_ep_reset_bar(pci, bar);
> drivers/pci/controller/dwc/pcie-designware-plat.c:
> dw_pcie_ep_reset_bar(pci, bar);
> drivers/pci/controller/dwc/pcie-dw-rockchip.c:
> dw_pcie_ep_reset_bar(pci, bar);
> drivers/pci/controller/dwc/pcie-qcom-ep.c:
> dw_pcie_ep_reset_bar(pci, bar);
> drivers/pci/controller/dwc/pcie-rcar-gen4.c:
> dw_pcie_ep_reset_bar(pci, bar);
> drivers/pci/controller/dwc/pcie-uniphier-ep.c:
> dw_pcie_ep_reset_bar(pci, bar);
> 
> They call dw_pcie_ep_reset_bar() in EP init for all BARs.
> (An EPF driver will be able to re-enable all BARs that are not marked as
> reserved.)
> 
> am654 seems to be the exception here.

The endpoint driver including am654 should surely call 
dw_pcie_ep_reset_bar() to initialize BARs at first.

> If you simply add code that disables all BARs by default in am654, you
> should be able to remove these ugly is_am654_pci_dev() checks in the host
> driver, and the host driver should not be able to write to these reserved
> BARs, as they will never get enabled by pci-epf-test.c.

However, dw_pcie_ep_reset_bar() only clears BAR registers to 0x0. BAR 
doesn't have any "disabled" field, so I think that it means "32-bit, 
memory, non-prefetchable".

 
https://github.com/torvalds/linux/blob/v6.13-rc3/drivers/pci/controller/dwc/pcie-designware-ep.c#L47-L52

And even if each endpoint driver marks "BAR_RESERVED" to the features, 
it is only referred to as excluded BARs when searching for free BARs. So 
the host will recognize this "reserved" BAR.

 
https://github.com/torvalds/linux/blob/v6.13-rc3/drivers/pci/endpoint/pci-epc-core.c#L123-L124

I've not actually used am654, but for example, when I tried to execute 
BAR test on the other SoC that has inaccessible BAR (marked as 
"reserved"), AER reported an uncorrectable bus error.
This behavior depends on the bus connection to the BAR.

It seems that access to the BAR is unavoidable even if calling 
dw_pci_ep_reset_bar() and marking as BAR_RESERVED.

But I don't have any other idea to avoid access to reserved BARs,
so this patch [2/2] will be withdrawn.

Thank you,

---
Best Regards
Kunihiko Hayashi

