Return-Path: <linux-pci+bounces-26808-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FFFA9DBA5
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 17:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C11D7A331F
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 15:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA6425CC57;
	Sat, 26 Apr 2025 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MTNfI1bj"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3604979CF;
	Sat, 26 Apr 2025 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745679798; cv=none; b=DRCvYkXPN142RhSPgSKBInWb3RzTO0Tv6iysPEExC8L8hiLV/c1UuYoiuVdkeFPR+PqtHeTyzQ8vRWrIEow5RyjpAdv4i06a2ZQHty6rOunFK17hWKDlD43NGz9qAc95laxnbHdljbclDFXNZgMqk3xaj4yweEkw78MFlUqjQK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745679798; c=relaxed/simple;
	bh=qcwLaEogrcneoQ3HfNmnr34uKQuRptXO8bBDkZuKctk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UD3choS3F83zBRxGTC3EuLv8KbKd+CH1PvMW/QXO3pqqPnstoFAEyNhMakxwcrQN/M4kVUTVTh0fpmirEvDmcdeBksWXn9LilPw5QFxM/i7UhrGI4WvSafhGcXiTRIyY+iO06dY45I73CmI97TigGlzCUmzh3PQh54J4h8iXWKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MTNfI1bj; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=2NTP26rZSO4aLxowU1tMWp58BMiXt/URHc+KIhHuxrE=;
	b=MTNfI1bjj/6sOwjhpxl6bkmPC/+LTUKOPSiUAIeVV8nKWRz27uFqb1sJ+lDGtQ
	63MoHFbayfTFrFSrFK+NANLTRI56wf+0T1ppXgIdKpVkRgIFTswtZJ8DfmcNUM85
	eMNUYZOx0YDL/JumkNNFBNzS8YHXDrsFhuJdclLcPClrM=
Received: from [192.168.71.89] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wBXbM5v9QxolMNQCw--.59638S2;
	Sat, 26 Apr 2025 23:02:08 +0800 (CST)
Message-ID: <5e2844cc-8359-4b87-a8ce-eb5ebb85f8ff@163.com>
Date: Sat, 26 Apr 2025 23:02:08 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] PCI: Remove redundant MPS configuration
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
 heiko@sntech.de, thomas.petazzoni@bootlin.com,
 manivannan.sadhasivam@linaro.org, yue.wang@Amlogic.com,
 neil.armstrong@linaro.org, robh@kernel.org, jingoohan1@gmail.com,
 khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org
References: <20250425095708.32662-1-18255117159@163.com>
 <20250425095708.32662-3-18255117159@163.com>
 <20250425181345.bybgcht5tweyg43k@pali>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250425181345.bybgcht5tweyg43k@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXbM5v9QxolMNQCw--.59638S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZryUGr4UtrWfAw1rGF18Grg_yoW8Wr4xpa
	13XFs3JF4Fqr15uF17Ja10gr1fXasIkFy5Xws8GFW3Za4aqw1UGFy2krs0kasrXr4v9F17
	Za42v3ySyanxtaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UmYL9UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxM6o2gLzK+LogABst



On 2025/4/26 02:13, Pali Rohár wrote:
> On Friday 25 April 2025 17:57:08 Hans Zhang wrote:
>> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
>> index a29796cce420..d8852892994a 100644
>> --- a/drivers/pci/controller/pci-aardvark.c
>> +++ b/drivers/pci/controller/pci-aardvark.c
>> @@ -549,9 +549,7 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
>>   	reg = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + PCI_EXP_DEVCTL);
>>   	reg &= ~PCI_EXP_DEVCTL_RELAX_EN;
>>   	reg &= ~PCI_EXP_DEVCTL_NOSNOOP_EN;
>> -	reg &= ~PCI_EXP_DEVCTL_PAYLOAD;
>>   	reg &= ~PCI_EXP_DEVCTL_READRQ;
>> -	reg |= PCI_EXP_DEVCTL_PAYLOAD_512B;
>>   	reg |= PCI_EXP_DEVCTL_READRQ_512B;
>>   	advk_writel(pcie, reg, PCIE_CORE_PCIEXP_CAP + PCI_EXP_DEVCTL);
>>   
>> -- 
>> 2.25.1
>>
> 
> Please do not remove this code. It is required part of the
> initialization of the aardvark PCI controller at the specific phase,
> as defined in the Armada 3700 Functional Specification.

Hi Pali,

This series of patches is discussing the initialization of DevCtl.MPS by 
the Root Port. Please look at the first patch I submitted. If there is a 
reasonable method in the end, DevCtl.MPS will also be configured 
successfully. The PCIe maintainer will give the review opinions. Please 
rest assured that it will not affect the functions of the aardvark PCI 
controller.

Rockchip's RK3588 also has the same problem.


https://patchwork.kernel.org/project/linux-pci/patch/20250416151926.140202-1-18255117159@163.com/

Best regards,
Hans


