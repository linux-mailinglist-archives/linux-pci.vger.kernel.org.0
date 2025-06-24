Return-Path: <linux-pci+bounces-30515-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC2CAE6B18
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 17:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3381D7AF389
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 15:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B197B2D663E;
	Tue, 24 Jun 2025 15:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jsHC5u0e"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D95C2D662E;
	Tue, 24 Jun 2025 15:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750778106; cv=none; b=KAJqlegru49nbR3V7fqE4sCitx9tym8LmTsVs4lxI/S/mx5tt6Pg7l/uvuvq7mO7gx/RE9vxQwBzdcuo5hqRqMvLwXck6Jg0QmugF1oUNIRHmbUVPbw6KDUCBAnmQVYKUheuFDdSDU2TIph+nsZSRHEHCLAPgtPLKWVSgzBd6KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750778106; c=relaxed/simple;
	bh=wVK+GSLm6XiLw79qxtYwtbRz7qh9vbwkDzohKaPdBEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=twuY2OFRmIz5OP1KeLuEZWVJSnkSLf3mS9mRYd4T19pqAUTyGkWxbsj8N/5MN8Gv0+NEzcQ9nG9MEOvmQr7aR3HU+SKQqayX/pF7cOGryiU6L7qrhMnc5L9KT7CWEkBTI/c9tGvwQta0cPeGOnnyFTr8veAvg1yFvIpd3fNbEnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jsHC5u0e; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=jXGxqTq/dX2Xt7HBwc+U4rbUlcNtOS2Fk6iyBC7fSYI=;
	b=jsHC5u0er1iQNhlLRZGBiIIjWREj5L9w4wED7dPXvxcRH/otOk9WgPXqsixitv
	6WwDvv/pPyN/Tp8MSwBGTcDL1a5DJvlu52o9S07Zg/k+/fKXmx9L3z1UNNG4nuil
	O/JBtO0Bdyrpu2Y6qPr+yYvdvW0qIG5v/BBjpjaDrzLkc=
Received: from [IPV6:240e:b8f:919b:3100:5951:e2f3:d3e5:8d13] (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgD3f8OywFpoVKdDAA--.9457S2;
	Tue, 24 Jun 2025 23:13:55 +0800 (CST)
Message-ID: <e4ce09f4-e70a-4975-a311-40a89df43f7a@163.com>
Date: Tue, 24 Jun 2025 23:13:54 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] PCIe: Refactor link speed configuration with
 unified macro
To: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 kwilczynski@kernel.org, mani@kernel.org, ilpo.jarvinen@linux.intel.com,
 jingoohan1@gmail.com
Cc: robh@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250607155545.806496-1-18255117159@163.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250607155545.806496-1-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:QCgvCgD3f8OywFpoVKdDAA--.9457S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw4DtF4rWrWkGF1xZrWUurg_yoWkWrXEvF
	y7tFy7Cr4UtrZ3Za4ayr43ZryrAay8Gr45AF18tw4rtFyavF4DCF1DurWDXa48WFsxGF4D
	JFn8Zr18Awn7CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUmL9UUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwx2o2havwMwdwAAsL

Dear Ilpo,

Gentle ping.

Best regards,
Hans

On 2025/6/7 23:55, Hans Zhang wrote:
> This series standardizes PCIe link speed handling across multiple drivers
> by introducing a common conversion macro PCIE_SPEED2LNKCTL2_TLS(). The
> changes eliminate redundant speed-to-register mappings and simplify code
> maintenance:
> 
> The refactoring improves code consistency and reduces conditional
> branching, while maintaining full backward compatibility with existing
> speed settings.
> 
> ---
> Changes for v2:
> - s/PCIE_SPEED2LNKCTL2_TLS_ENC/PCIE_SPEED2LNKCTL2_TLS
> - The patch commit message were modified.
> ---
> 
> Hans Zhang (3):
>    PCI: Add PCIE_SPEED2LNKCTL2_TLS conversion macro
>    PCI: dwc: Simplify link speed configuration with macro
>    PCI/bwctrl: Replace legacy speed conversion with shared macro
> 
>   drivers/pci/controller/dwc/pcie-designware.c | 18 +++---------------
>   drivers/pci/pci.h                            |  9 +++++++++
>   drivers/pci/pcie/bwctrl.c                    | 19 +------------------
>   3 files changed, 13 insertions(+), 33 deletions(-)
> 
> 
> base-commit: ec7714e4947909190ffb3041a03311a975350fe0


