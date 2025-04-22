Return-Path: <linux-pci+bounces-26382-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5B2A967D0
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 13:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D65A3188A3BA
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 11:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7935327CCDF;
	Tue, 22 Apr 2025 11:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ROQuW9o1"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC9F27CB17;
	Tue, 22 Apr 2025 11:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745321804; cv=none; b=oFtBAm7GAMCrFLgSsxLMOag6tDwdhw7Hzx2+42GElmuJYuo/7mW/FwZt6+cKXFNJn6ulVOh8kl2YF20ETwCBgWaOg8kgHJTpWS8qctDmTUSzBSgS0q9DDpBkbDus+MLN1uFNUjKQLp7YPuQmVmTiO+DlrKlSPyOby4EDUlrnzO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745321804; c=relaxed/simple;
	bh=MJldfOx2DArcafcToxkdvndWi6y6RoNm5FQ1BC9jUH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BG6lgFNyR3RxOL9+cprRhg43ueEH32blQP+MeNVnxNP0lfkz3HU/Nf6ODtO405zXCJ8BebCB1CZm0taGyzqUo7Qe659BtUBvAy6REryBpGZCPq1BIzbGBJLK8NgyV79DuxuXyauHJ4y5uNAG3qAgAMUzzYUZM/n8iz0tp/YR/6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ROQuW9o1; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=/h4icl4bJ4iZhQsY5JlIHbZk1g8xMGb+vnYxZQzIJw8=;
	b=ROQuW9o1y2i4S7lZJHDMjqdJKr9LmZjYaKLRJCSit8lKC5hNJkfJTzirIOYiUJ
	+ecUGD0PVEsA+Hp9rEKPhBOaZg8zxaNi1GAWSSFleiOuti+CSj5XmH9FZdGWXo5z
	+lQGOb41PLR38/E0yFP9aNnaQrJAI6PZWbmmilAz3C8pU=
Received: from [192.168.142.52] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wCX+C0efwdoQhSoBg--.12996S2;
	Tue, 22 Apr 2025 19:36:00 +0800 (CST)
Message-ID: <255a74b6-c16b-480e-b377-d87b3b6913b6@163.com>
Date: Tue, 22 Apr 2025 19:35:58 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] PCI: dw-rockchip: Reorganize register and bitfield
 definitions
To: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com, heiko@sntech.de
Cc: manivannan.sadhasivam@linaro.org, robh@kernel.org, jingoohan1@gmail.com,
 shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20250422112830.204374-1-18255117159@163.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250422112830.204374-1-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wCX+C0efwdoQhSoBg--.12996S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr45XryfJw1DGw4xJr15twb_yoW5JFyxp3
	Z8JFWfur43Jw4Ivan7Cw17ZFy8K3ZrAFyYgw4UKw18Ja40q3W8WFyfKF1F9Fy2qr4xKF12
	q39rX34I9F4ava7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UsSdgUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOg83o2gHfDNa2wAAsA



On 2025/4/22 19:28, Hans Zhang wrote:
> 1. PCI: dw-rockchip: Remove unused PCIE_CLIENT_GENERAL_DEBUG
> 2. PCI: dw-rockchip: Reorganize register and bitfield definitions
> 3. PCI: dw-rockchip: Unify link status checks with FIELD_GET
> 
> ---
> https://patchwork.kernel.org/project/linux-pci/patch/20250416151926.140202-1-18255117159@163.com/
> 
> Bjorn Helgaas:
> These would be material for a separate patch:
> 
> - The #defines for register offsets and bits are kind of a mess,
>    e.g., PCIE_SMLH_LINKUP, PCIE_RDLH_LINKUP, PCIE_LINKUP,
>    PCIE_L0S_ENTRY, and PCIE_LTSSM_STATUS_MASK are in
>    PCIE_CLIENT_LTSSM_STATUS, but you couldn't tell that from the
>    names, and they're not even defined together.
> 
> - Same for PCIE_RDLH_LINK_UP_CHGED, PCIE_LINK_REQ_RST_NOT_INT,
>    PCIE_RDLH_LINK_UP_CHGED, which are in PCIE_CLIENT_INTR_STATUS_MISC.
> 
> - PCIE_LTSSM_ENABLE_ENHANCE is apparently in PCIE_CLIENT_HOT_RESET_CTRL?
>    Sure wouldn't guess that from the names or the order of #defines.
> 
> - PCIE_CLIENT_GENERAL_DEBUG isn't used at all.
> 
> - Submissions based on the following v5 patches:

I'm very sorry. It should be like this:
- Submissions based on the following patches:

> https://patchwork.kernel.org/project/linux-pci/patch/1744850111-236269-1-git-send-email-shawn.lin@rock-chips.com/
> https://patchwork.kernel.org/project/linux-pci/patch/1744850111-236269-2-git-send-email-shawn.lin@rock-chips.com/
> https://patchwork.kernel.org/project/linux-pci/patch/1744850111-236269-3-git-send-email-shawn.lin@rock-chips.com/
> https://patchwork.kernel.org/project/linux-pci/patch/1744940759-23823-1-git-send-email-shawn.lin@rock-chips.com/
> ---
> 
> Hans Zhang (3):
>    PCI: dw-rockchip: Remove unused PCIE_CLIENT_GENERAL_DEBUG
>    PCI: dw-rockchip: Reorganize register and bitfield definitions
>    PCI: dw-rockchip: Unify link status checks with FIELD_GET
> 
>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 58 +++++++++----------
>   1 file changed, 29 insertions(+), 29 deletions(-)
> 
> 
> base-commit: 9d7a0577c9db35c4cc52db90bc415ea248446472
> prerequisite-patch-id: 5d9f110f238212cde763b841f1337d0045d93f5b
> prerequisite-patch-id: b63975b89227a41b9b6d701c9130ee342848c8b6
> prerequisite-patch-id: 46f02da0db4737b46cd06cd0d25ba69b8d789f90
> prerequisite-patch-id: d06e25de3658b73ad85d148728ed3948bfcec731


