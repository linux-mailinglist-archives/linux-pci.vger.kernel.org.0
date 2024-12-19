Return-Path: <linux-pci+bounces-18760-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE309F77B6
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 09:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A74E6189550D
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 08:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD87F1FC7E1;
	Thu, 19 Dec 2024 08:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="X/9yRedF"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB0F1FC7E0;
	Thu, 19 Dec 2024 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734598252; cv=none; b=rmKLRf5/je26PA628PqVelA/uvH2rUOFHQjUva2JLzih3/sYNyGnNerJwT4NDzU1b+smJYEoFK8Fzb6eAQ41upqCSXU+mGG6ad+Zi+INDQXZR6GGrePrqkwYaM83nNH8jizmWC+OUwsjJnJNjMvQvDRhF2i4xTBE3abXRUcR4mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734598252; c=relaxed/simple;
	bh=m0U7ilFtAFGXH8rQgMsPT893bh3t6+SqQpxRiY8iRAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tc9+0gMIWNJF+6+15DlM2kozid5ZtJUG5HiyEoJbU1fSLfJDzTCFv8zM/9kqCxHZBiMdoN40/0artGuD51NzciQPMlUiLdcsg2LVPJjtiVns2LlLhJvmcHCahZpQwRVLIW1twIZng+klLjjcbOZg+ZAVwvMviy2LbAO5p9VFDcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=X/9yRedF; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=X+QWZeciCtlO3h9lSaSbVhOwFLjdsNDfNT574pJ5UYs=;
	b=X/9yRedF6SBIVf0tiKEpWq+qwPgks+lDC5wtbDawGJ8MtEhH4s1vze+3tWnG9x
	IMR2j2QWMGLvKhac+s6btwJaqYMSQBvYklmx2Jo8zB72MjF+Rl05+qfTyIZTSxtk
	BlHS9hDeibVJzPXInhDIKyUDx52MQ1bMnGhK0zkbBKbA8=
Received: from [192.168.60.52] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3v9Ie3mNnAKXhAA--.39158S2;
	Thu, 19 Dec 2024 16:49:35 +0800 (CST)
Message-ID: <999ad91d-9b61-b939-a043-4ab3f07c72a1@163.com>
Date: Thu, 19 Dec 2024 03:49:33 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] PCI: cadence: Fixed cdns_pcie_host_link_setup return
 value.
Content-Language: en-US
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
 robh@kernel.org, bhelgaas@google.com, thomas.richard@bootlin.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, rockswang7@gmail.com
References: <20241219081452.32035-1-18255117159@163.com>
 <hldbrb5rgzwibq3xiak2qpy5jawsgmhwjxrhersjwfighljyim@noxzbf4cre3m>
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <hldbrb5rgzwibq3xiak2qpy5jawsgmhwjxrhersjwfighljyim@noxzbf4cre3m>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3v9Ie3mNnAKXhAA--.39158S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF1rtryfXryfAry7JryrJFb_yoWDGwbE9r
	n8uanrZ3WqkrZ3Ca13ur1ftrW5Cay2kFy7Jan7KFy3Jr1Sg3WDCrn0gr92vF48W39Iqr90
	9rnFva18Z34a9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnbyCJUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwO6o2dj2EKlWgAAsg


On 12/19/24 03:33, Siddharth Vadapalli wrote:
> On Thu, Dec 19, 2024 at 03:14:52AM -0500, Hans Zhang wrote:
>> If the PCIe link never came up, the enumeration process
>> should not be run.
> The link could come up at a later point in time. Please refer to the
> implementation of:
> dw_pcie_host_init() in drivers/pci/controller/dwc/pcie-designware-host.c
> wherein we have the following:
> 	/* Ignore errors, the link may come up later */
> 	dw_pcie_wait_for_link(pci);
>
> It seems to me that the logic behind ignoring the absence of the link
> within cdns_pcie_host_link_setup() instead of erroring out, is similar to
> that of dw_pcie_wait_for_link().
>
> Regards,
> Siddharth.
>
>
> If a PCIe port is not connected to a device. The PCIe link does not
> go up. The current code returns success whether the device is connected
> or not. Cadence IP's ECAM requires an LTSSM at L0 to access the RC's
> config space registers. Otherwise the enumeration process will hang.
>
> Regards,
> Hans


