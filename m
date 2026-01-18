Return-Path: <linux-pci+bounces-45104-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 010B7D39571
	for <lists+linux-pci@lfdr.de>; Sun, 18 Jan 2026 14:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A72BF30111B1
	for <lists+linux-pci@lfdr.de>; Sun, 18 Jan 2026 13:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A056932D0D8;
	Sun, 18 Jan 2026 13:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Kw94nNvf"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CF017A2F6;
	Sun, 18 Jan 2026 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744122; cv=none; b=ngcVssYBBA+koaG7LNWVgGDQy+eILdff9/VWvaXaoNMd3zivZRUY00wnkdPu+q+bQAZBErXtIVWU8pVLdFLbYrcnQUzBYnEeOV7DW96Q2r2Rqsg8yq29eMPxSuRPgIjqNCMLasnrDWfx/UZCpJ/XKWUAb3GqQl/OeZwI2MCWGuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744122; c=relaxed/simple;
	bh=/avj3KXIk3a5KxpHccpaIIecRqXYDWkNDG1i8H3oeJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rSvpA/7C6CIzXKBPJyUqKDHD/Qj6pbX1LkWQM7jvbE4MgdaPKCe98SgRi0iPHNesuwx6EhL4pQWjsG5X0PDHC/a0Hu7rgpAsV2l+dZp+GtLDAQPJ5ko67iK+GieSBPhDYZf2QQoHzcWctLLvaSfo/V0E1LdOCJCdc+DFYsaRUsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Kw94nNvf; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=Sq5Qv3yg8QGYvAyDcjQYMbTuxuA+X5I3uxOwSuqBdH0=;
	b=Kw94nNvfOEBQcnwj5wYc3BwWM7oOxQszDn97gOXb7wVksuNERgyWHePsuFxFFi
	kcqnmynmLRlyXgqJpdW4MmiZ3D1IkCoZvEPswXj5kkLPE7iJrRPyDUA2j9SRPZTO
	dvhpthZYustFemO1XsBhNYBj3EDTcy9t1C1vmyIllMGyo=
Received: from [IPV6:240e:b8f:927e:1000:e94b:3b22:e2ce:7986] (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgB3yrxw5Gxpy+keNg--.11679S2;
	Sun, 18 Jan 2026 21:47:29 +0800 (CST)
Message-ID: <2cd9359a-5c37-40c4-9fbd-316d79b8efa9@163.com>
Date: Sun, 18 Jan 2026 21:47:28 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] PCI: Refactor PCIe speed validation and conversion
 functions
To: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 kwilczynski@kernel.org, mani@kernel.org, ilpo.jarvinen@linux.intel.com,
 jingoohan1@gmail.com
Cc: robh@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251102143206.111347-1-18255117159@163.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20251102143206.111347-1-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PSgvCgB3yrxw5Gxpy+keNg--.11679S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFykKFyDuF1kuw48WFWxWFg_yoW8XF4Dpa
	y3Ka1fArW8G3sxGan3Xa1jqFy5Wan3JrW8Jry3Jas5Zw13ZFn3tr1DKryFgr9rtrWxXr12
	9F1jva4DC3WjkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Un2-5UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwxHKbmls5HGxggAA3V

Hi,

Gentle ping.

Best regards,
Hans

On 2025/11/2 22:32, Hans Zhang wrote:
> This series refactors PCIe speed validation and conversion logic to
> shared functions in the public header, eliminating code duplication
> and ensuring consistency across drivers.
> 
> ---
> Changes for v4:
> - Maintain O(1) array-based lookup for speed conversion (addressing
>    performance concerns from v3 feedback)
> - Move pcie_valid_speed() and pci_bus_speed2lnkctl2() to pci.h
> - Update dwc driver to use the shared functions
> - Rebase to v6.18-rc3.
> 
> This addresses the feedback from Lukas Wunner and Manivannan Sadhasivam
> on the v3 submission, ensuring no runtime performance regression while
> achieving code reuse.
> 
> Changes for v3:
> https://patchwork.kernel.org/project/linux-pci/patch/20250816154633.338653-1-18255117159@163.com/
> 
> - Rebase to v6.17-rc1.
> - Gentle ping.
> 
> Changes for v2:
> - s/PCIE_SPEED2LNKCTL2_TLS_ENC/PCIE_SPEED2LNKCTL2_TLS
> - The patch commit message were modified.
> ---
> 
> Hans Zhang (3):
>    PCI: Add public pcie_valid_speed() for shared validation
>    PCI: Move pci_bus_speed2lnkctl2() to public header
>    PCI: dwc: Use common speed conversion function
> 
>   drivers/pci/controller/dwc/pcie-designware.c | 18 +++-------------
>   drivers/pci/pci.h                            | 22 ++++++++++++++++++++
>   drivers/pci/pcie/bwctrl.c                    | 22 --------------------
>   3 files changed, 25 insertions(+), 37 deletions(-)
> 
> 
> base-commit: 691d401c7e0e5ea34ac6f8151bc0696db1b2500a


