Return-Path: <linux-pci+bounces-25325-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC1AA7CA00
	for <lists+linux-pci@lfdr.de>; Sat,  5 Apr 2025 17:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D83CD7A6C60
	for <lists+linux-pci@lfdr.de>; Sat,  5 Apr 2025 15:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A6D13B7A3;
	Sat,  5 Apr 2025 15:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MeiqUMvU"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CD51D52B;
	Sat,  5 Apr 2025 15:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743868207; cv=none; b=t5H2FGz85IBE03B0gwvNvvJ7i0uWBxmBbDDRvQSJn/zFH1sAU0gaY6fCxpyQ++R53+xqfbvGgwrBxx4dSu+My6pRKUMqtuU6M68VZVJGhsbZseNx/4M+fcmnxKzWCtFm4jxwU7oYQdRTXKLYfOZEKo7HJBMa7eeeoLfXDTR5VFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743868207; c=relaxed/simple;
	bh=PVpdjH9nvgFGickOdTwkkGNNRjtGLJ4GsjI6sxDj0/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eDaGuUmiVadzH1tCE8eDU7bOSjjjv/jKMtWKq3tdxJ8S0b73Xv4OsoLnlXu6mfVwZ6sG0noSRMp2Ir2I6Smxqf1jZf/llpWyQIvzVC11NNs77Y1O7PJZWNo6if+qqEGpnyf4biWtGK2pWPhGzBlCbqbknK4SPnajU9yCQtsfusU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MeiqUMvU; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=+t0sKLMwS+prv7H4cHe9k+nGJ49pCP3R5uikJVhJsa8=;
	b=MeiqUMvUKfXeF16EiXubdslrqk0qhFr98e0ZZwz2cGcpWptiYNSz/Nrvi8Onet
	qzAL2F1I9SH9UTDL8pJX6U4CI4TRDzOfZgJ0PfazPZU2EoeP5m4k6Qm1MuklwPXR
	kbGNsneR31Il7EAKK94F9tcIIDOquQLW2d/Mo39ben8qI=
Received: from [192.168.71.89] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAH1zb8UPFnaPO8EA--.23000S2;
	Sat, 05 Apr 2025 23:49:16 +0800 (CST)
Message-ID: <c52ac489-51e9-4803-bf64-2bb6cfbf30bf@163.com>
Date: Sat, 5 Apr 2025 23:49:16 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci: tegra194: Fix debugfs cleanup for !CONFIG_PCIEASPM
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
 thierry.reding@gmail.com, kw@linux.com, robh@kernel.org,
 bhelgaas@google.com, jonathanh@nvidia.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20250405152818.GA107831@bhelgaas>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250405152818.GA107831@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wAH1zb8UPFnaPO8EA--.23000S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7urykGrWfGw15Ar45GF45Wrg_yoW8Zw1rpw
	4kG345Kr4qy34SyF97Ca1kAF1Fy395Aw13Jw13urs7Zw4DAryDXFy8Ka1j9Fyfuw4DtF1U
	XFsY9Fn5G3WDZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UVMKtUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwwmo2fxR0BtuAABsX



On 2025/4/5 23:28, Bjorn Helgaas wrote:
> Follow subject line capitalization convention.
> 
> On Sat, Apr 05, 2025 at 10:54:59PM +0800, Hans Zhang wrote:
>> When CONFIG_PCIEASPM is disabled, debugfs entries are not created, but
>> tegra_pcie_dw_remove() and tegra_pcie_dw_shutdown() unconditionally call
>> debugfs_remove_recursive(), leading to potential NULL pointer operations.
>>
>> Introduce deinit_debugfs() to wrap debugfs_remove_recursive(), which is
>> stubbed for !CONFIG_PCIEASPM. Use this function during removal/shutdown to
>> ensure debugfs cleanup only occurs when entries were initialized.
>>
>> This prevents kernel warnings and instability when ASPM support is
>> disabled.
> 
> This looks like there should be a Fixes: tag to connect this to the
> commit that introduced the problem.

Hi Bjorn,

Thanks your for reply. Will add.

Fixes: bb617cbd8151 (PCI: tegra194: Clean up the exit path for Endpoint 
mode)

> 
> If this is something that broke with the v6.15 merge window, we should
> include this in v6.15 via pci/for-linus.  If this broke earlier, we
> would have to decide whether pci/for-linus is still appropriate or a
> stable tag.
> 

The original code that introduced the unconditional 
`debugfs_remove_recursive()` calls was actually merged in an earlier cycle.

> We did merge some debugfs things for v6.15, but I don't see anything
> specific to pcie-tegra194.c, so I'm confused about why this fix would
> be in pcie-tegra194.c instead of some more generic place.
> 

The Tegra194 driver conditionally initializes pcie->debugfs based on 
CONFIG_PCIEASPM. When ASPM is disabled, pcie->debugfs remains 
uninitialized, but tegra_pcie_dw_remove() and tegra_pcie_dw_shutdown() 
unconditionally call debugfs_remove_recursive(), leading to a NULL 
pointer dereference. This is specific to the Tegra194 implementation, as 
other drivers or core PCI code may already guard debugfs cleanup against 
uninitialized states through different mechanisms.

Best regards,
Hans


