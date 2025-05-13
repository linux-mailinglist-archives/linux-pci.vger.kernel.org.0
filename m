Return-Path: <linux-pci+bounces-27638-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9713DAB5773
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 16:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28C2B1727A3
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 14:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E25F28C87E;
	Tue, 13 May 2025 14:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="adGwfDcr"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F61255E2B;
	Tue, 13 May 2025 14:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747147420; cv=none; b=hAXjqTC710FsKJHcA9mD2qk4JewweWh8TIJJssTGX8/LGJ+YU8W3WvlT62A5c0WuZl8v8ibk+DKQL0kExeVqYPpfI1gLbVjlmzIlRY6a7T667V6zV2Oc2sWnFGgq+3es9S/DDVGOHKoMS6D6caSy5RcWvqGc5nxY1OsgLT4sPfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747147420; c=relaxed/simple;
	bh=VfxNe0rCLbMoMOxCPumlZYseH+qXjuVOWDCcTC03n6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M4XsivqPTcWhaFu4up6u8NZEexzEeP7MQpc1KUX+pcSGfo1GCkAJeVRO/1BIYGBdqWWDop44ZaC6Ji5rAcxEd2GJAFps6ikSvtwZxpUnewa/sLV8RFpY4ZeKjtuDBQsTy3J+tkYOUE1jCqhXGubWiLS8PnGB5+hQCdoewp8mLF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=adGwfDcr; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=GL9CsiKAXD9gJT9DpZqey9QynbJ5hhQ893JVPfKEitU=;
	b=adGwfDcr8/V74c0kN+HfCgHzgMQlulohWG8PfLDCo2Mwg6gcO+PJj14o2tCZxJ
	kVp3RwLZBVtVNAXyCs33Wz/jP+wTKj7kJl9mqWjigJGI1RzQVgi232c9UqacPdoc
	3GuQCFb6uFh11MAQySTZx3ywLUye2gcu86CfZmbczHoHg=
Received: from [192.168.71.93] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgA3BvNzWiNoYRZOAg--.14360S2;
	Tue, 13 May 2025 22:42:59 +0800 (CST)
Message-ID: <f9e24bcc-5d90-46ea-a56e-bb2b061c4ae5@163.com>
Date: Tue, 13 May 2025 22:42:59 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2 0/3] Standardize link status check to return
 bool
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
 jingoohan1@gmail.com, cassel@kernel.org, robh@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250510160710.392122-1-18255117159@163.com>
 <k2ralcw6ynqfejsyk6z7vdodhbn5gu37gqkt4x6yzs7t2y4h5s@6ag7omevjfl2>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <k2ralcw6ynqfejsyk6z7vdodhbn5gu37gqkt4x6yzs7t2y4h5s@6ag7omevjfl2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PigvCgA3BvNzWiNoYRZOAg--.14360S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFy3uw4DArWfGF17KFyxGrg_yoW5GrWxpa
	45tayIyF1rJF4Y9a1Yv3WDC3WYq3ZrAF9rJws3ua42qFya9rW7Xr17JFySgF97JrW5Xr13
	tF13t3ZrGFsxJFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UBwZcUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxdMo2gjH7l-TQADsr



On 2025/5/13 17:40, Manivannan Sadhasivam wrote:
> On Sun, May 11, 2025 at 12:07:07AM +0800, Hans Zhang wrote:
>> 1. PCI: dwc: Standardize link status check to return bool.
>> 2. PCI: mobiveil: Refactor link status check.
>> 3. PCI: cadence: Simplify j721e link status check.
> 
> Please do not paste the patch subjects in cover letter. Cover letter should
> elaborate the issue this series is fixing, its purpose, any dependency etc...
> 

Dear Mani,

Thank you very much for your reply and reminder. In future submissions, 
I will pay attention to this point.

Best regards,
Hans

> - Mani
> 
>>
>> ---
>> Changes for RESEND:
>> - add Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>
>> Changes for v2:
>> - Remove the return of some functions (!!) .
>> - Patches 2/3 and 3/3 have not been modified.
>>
>> Based on the following branch:
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=controller/dw-rockchip
>> ---
>>
>> Hans Zhang (3):
>>    PCI: dwc: Standardize link status check to return bool
>>    PCI: mobiveil: Refactor link status check
>>    PCI: cadence: Simplify j721e link status check
>>
>>   drivers/pci/controller/cadence/pci-j721e.c             | 6 +-----
>>   drivers/pci/controller/dwc/pci-dra7xx.c                | 4 ++--
>>   drivers/pci/controller/dwc/pci-exynos.c                | 4 ++--
>>   drivers/pci/controller/dwc/pci-keystone.c              | 5 ++---
>>   drivers/pci/controller/dwc/pci-meson.c                 | 6 +++---
>>   drivers/pci/controller/dwc/pcie-armada8k.c             | 6 +++---
>>   drivers/pci/controller/dwc/pcie-designware.c           | 2 +-
>>   drivers/pci/controller/dwc/pcie-designware.h           | 4 ++--
>>   drivers/pci/controller/dwc/pcie-dw-rockchip.c          | 2 +-
>>   drivers/pci/controller/dwc/pcie-histb.c                | 9 +++------
>>   drivers/pci/controller/dwc/pcie-keembay.c              | 2 +-
>>   drivers/pci/controller/dwc/pcie-kirin.c                | 7 ++-----
>>   drivers/pci/controller/dwc/pcie-qcom-ep.c              | 2 +-
>>   drivers/pci/controller/dwc/pcie-qcom.c                 | 4 ++--
>>   drivers/pci/controller/dwc/pcie-rcar-gen4.c            | 2 +-
>>   drivers/pci/controller/dwc/pcie-spear13xx.c            | 7 ++-----
>>   drivers/pci/controller/dwc/pcie-tegra194.c             | 4 ++--
>>   drivers/pci/controller/dwc/pcie-uniphier.c             | 2 +-
>>   drivers/pci/controller/dwc/pcie-visconti.c             | 4 ++--
>>   drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c | 9 ++-------
>>   drivers/pci/controller/mobiveil/pcie-mobiveil.h        | 2 +-
>>   21 files changed, 37 insertions(+), 56 deletions(-)
>>
>>
>> base-commit: 286ed198b899739862456f451eda884558526a9d
>> -- 
>> 2.25.1
>>
> 


