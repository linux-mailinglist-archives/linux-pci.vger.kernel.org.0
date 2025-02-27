Return-Path: <linux-pci+bounces-22536-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B969A47C31
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 12:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6A483A3285
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 11:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088BEEEBB;
	Thu, 27 Feb 2025 11:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Im31ySNg"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085832288E3
	for <linux-pci@vger.kernel.org>; Thu, 27 Feb 2025 11:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655718; cv=none; b=MxWMTPOAHME1fcJn2L2JsZEdTk42LIcN73Gz5WQ9kiYwUEo902G3dU7jP47SYdLS3ZxeK5I/1dMUOIgX+WiotbLDfapJ3bTg6sOQCxDYpjNKgQm6P3/YkLm4PFsfcVBpIygSPXHEwKawo7LOrgsUQYpD/TOD0p4ZVtakRzZ3li0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655718; c=relaxed/simple;
	bh=hgOUu+hwfPUwrE8bf6Cn+W3DtZIUgNbom/7FIvUh/WE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mFgoYFJl2EZ74a18LKeTjBQ9Ljs5u6ppvBKAFgW7zECwId9JLJcrTaMO4aaZq4CKk+74l+W2lDCXc7M19DpjJZA/NNTeBcOKlIM6+cG02k+bD/c9gFNviiEjAV1JBscoXboSvlEUdixm5CQU58oO3nmZbdcwI4sCLTP4/s3yBCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Im31ySNg; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=aMYpwAV9uQZP+b5vW/oY9Ei+f0+Zf16jcX4P6SaKGF8=;
	b=Im31ySNgLPYkWU/wuRqo/HP1Lhhj1ojh94WfqbTnWo43ksHY/mndFaV170nRkb
	9OFB4Z0yMct3CVujWDXgZ1PVT4MwhUuoYmhgRxO7UDGdU8Y0hAKqImckAF6byDKQ
	n6MbOtpMOOOt7pO8k4bkW+Cyg6Cn3a8pcim34/IZimwbQ=
Received: from [192.168.34.52] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wC3_0Y7TMBn6N8wOg--.3582S2;
	Thu, 27 Feb 2025 19:27:56 +0800 (CST)
Message-ID: <38057c44-dee4-4acc-aa3f-01e9616fca6a@163.com>
Date: Thu, 27 Feb 2025 19:27:54 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [pci:controller/dwc 6/8]
 drivers/pci/controller/dwc/pcie-designware-debugfs.c:561:undefined reference
 to `dw_ltssm_sts_string'
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
 linux-pci@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <202502270336.4xpaTVPE-lkp@intel.com>
 <ef04f32a-593f-437d-8465-1634c12567ae@163.com>
 <20250227104353.GA961034@rocinante>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250227104353.GA961034@rocinante>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3_0Y7TMBn6N8wOg--.3582S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr4UZFWrJr4kXF15XFWDArb_yoW8Gw1Dpa
	y0ya18AFW8tw4SyayIvrsY9F1ftanrJr17WrZ8Gr1UurW2vFZ7GFn5tr43GFy7Xr1vkw4j
	ya18ZF15ta1qyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRNeOXUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxUBo2fAPGGB4wABs1



On 2025/2/27 18:43, Krzysztof Wilczyński wrote:
> Hello,
> 
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc
>>> head:   b9d6619b0c3ef6ac25764ff29b08e8c1953ea83f
>>> commit: d4dc748566221bfdd0345c282ec82d3eee457f39 [6/8] PCI: dwc: Add debugfs property to provide LTSSM status of the PCIe link
>>> config: sparc64-randconfig-001-20250227 (https://download.01.org/0day-ci/archive/20250227/202502270336.4xpaTVPE-lkp@intel.com/config)
> [...]
>> sparc64-randconfig-001-20250227:
>>
>> #
>> # DesignWare-based PCIe controllers
>> #
>> CONFIG_PCIE_DW=y
>> CONFIG_PCIE_DW_DEBUGFS=y
>> CONFIG_PCIE_DW_EP=y
>>
>>
>> Since this config is not configured with CONFIG_PCIE_DW_HOST, and the
>> dw_ltssm_sts_string function is in the pci-designware-host.c, the following
>> compilation error occurs.
> 
> No worries.  Thank you for having a look!
> 
>> Can you help move the dw_ltssm_sts_string function to pci-designware.c or
>> pci-designware-debugfs.c?
> 
> Have a look at the following:
> 
>    https://web.git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/dwc&id=02001ce4ff42bd85be3ed8b4a0a2580156f032a0
> 
> And let me know if this is OK with you.

I couldn't agree more. Thank you very much Krzysztof.

Best regards
Hans

>   
>> Or should I resubmit v6 patch?
> 
> No, need.  Thank you anyway, though.
> 
> 	Krzysztof




