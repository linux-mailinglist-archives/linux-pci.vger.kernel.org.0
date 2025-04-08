Return-Path: <linux-pci+bounces-25463-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A0DA7F284
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 04:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E45723AD2FD
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 02:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0A73987D;
	Tue,  8 Apr 2025 02:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Uert+Zgk"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B77A1CF8B;
	Tue,  8 Apr 2025 02:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744077819; cv=none; b=G6bvj3PQfOrouTutG0d8hlJObGcRASySb0knn9dle/b4p36OLeFwLv62kRs1vmECDAPh81ouBwTxlSAT1Zp3uHJLaOsotvcz8OPZeY1tCZQCd/OtwuS5zDvYAF9GE+GUmRax/hDLFHRP/vsMB47zl1vkpb7il+ylqZm1SSCTjq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744077819; c=relaxed/simple;
	bh=oOBuLZNrpZDMPHBULeA4WGpPWTjGPws8XeGm/ujNWiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mNXpXV+We0sQAAx5LUoft96JYIkYQ1QYfcoZ1NWc1jR2uRQPgdVxPD+fvtlX6dFcEFFmnJ9sSsIr1ufiGk1DeYq1KteRPmhVDegdiIYLmKJlGn5zwjmrAKUDgzCltOU5NFnT0ZgPiPOm2g2+mm2JMwm4/z8XMP6wmGmohcIj2u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Uert+Zgk; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=zn7t/W9GYVoXl/YhbXBzh/8nBfmicUZkJ+wH0WcyuGQ=;
	b=Uert+ZgkbizD1AFSJ2M4yqLTZ1dlUR8bIXt8OYrkGGxL/GF164DXxkcvKL6xGC
	8itJ5IhawhOszMk3vJFR3SrdO2CnM/d+GHwwAvY5VcFvNKOf6cBmPZHBUwXwK2yp
	GRaCGKSmTnjIDAfFnMGYuaighRqNjjS6ibS+KE4QC4nIA=
Received: from [192.168.142.52] (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgCH5wO2g_Rn7T4rAA--.11073S2;
	Tue, 08 Apr 2025 10:02:32 +0800 (CST)
Message-ID: <d8478697-e53b-456c-a285-7e1a1c297ed9@163.com>
Date: Tue, 8 Apr 2025 10:02:30 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3] PCI: tegra194: Fix debugfs directory creation when
 CONFIG_PCIEASPM is disabled
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, lpieralisi@kernel.org
Cc: manivannan.sadhasivam@linaro.org, thierry.reding@gmail.com, kw@linux.com,
 robh@kernel.org, bhelgaas@google.com, jonathanh@nvidia.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20250407124331.69459-1-18255117159@163.com>
 <580c1b6a-ba32-48ea-9fd8-59884d0dbcbf@wanadoo.fr>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <580c1b6a-ba32-48ea-9fd8-59884d0dbcbf@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgCH5wO2g_Rn7T4rAA--.11073S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxury8Ar4UJFWfGFW8Gw4fAFb_yoW5uFWkpa
	95Ga1YkF48Jw4furZ7ua1UZr1Sywsayr97J34Y9w10vrn8Cr98tF18KFWYqa9rurZ7tw10
	yr4Sy3ZrCw45JFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UprWwUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxcpo2f0gV9pvAAAse



On 2025/4/8 03:43, Christophe JAILLET wrote:
> Hi,
> 
> Nitpick: PATCH is missing within the [] in the subject.
> 

Hi Christophe,

I will pay attention in the future.

> 
> Le 07/04/2025 à 14:43, Hans Zhang a écrit :
>> Previously, the debugfs directory was unconditionally created in
>> tegra_pcie_config_rp() regardless of the CONFIG_PCIEASPM setting.
>> This led to unnecessary directory creation when ASPM support was 
>> disabled.
>>
>> Move the debugfs directory creation into init_debugfs() which is
>> conditionally compiled based on CONFIG_PCIEASPM. This ensures:
>> - The directory is only created when ASPM-related debugfs entries are
>>    needed.
>> - Proper error handling for directory creation failures.
>> - Avoids cluttering debugfs with empty directories when ASPM is disabled.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>> Changes since v2:
>> https://lore.kernel.org/linux-pci/20250406134355.49036-1-18255117159@163.com/
>>
>> - Maintainer recommends ignoring the devm_kasprintf return value. The
>>    module should still work correctly. So just a return;
> 
> Note, that I'm not a maintainer ;-)
> 

Maybe I made a mistake. ;-)

No.72	 Christophe JAILLET <christophe ! jaillet () wanadoo ! fr> 
2104(0.17%)	@Hobbyists                       @French

Best regards,
Hans

> For what it worth:
> 
> Reviewed-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> 
> CJ
>>
>> Changes since v1:
>> https://lore.kernel.org/linux-pci/20250405145459.26800-1-18255117159@163.com/
>>
>> - The first version was committed incorrectly because the judgment
>>    parameter in "debugfs_remove_recursive" was not noticed.
>> ---
>>   drivers/pci/controller/dwc/pcie-tegra194.c | 19 ++++++++++---------
>>   1 file changed, 10 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c 
>> b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index 5103995cd6c7..bc419688527a 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -713,7 +713,16 @@ static void init_host_aspm(struct tegra_pcie_dw 
>> *pcie)
>>   static void init_debugfs(struct tegra_pcie_dw *pcie)
>>   {
>> -    debugfs_create_devm_seqfile(pcie->dev, "aspm_state_cnt", 
>> pcie->debugfs,
>> +    struct device *dev = pcie->dev;
>> +    char *name;
>> +
>> +    name = devm_kasprintf(dev, GFP_KERNEL, "%pOFP", dev->of_node);
>> +    if (!name)
>> +        return;
>> +
>> +    pcie->debugfs = debugfs_create_dir(name, NULL);
>> +
>> +    debugfs_create_devm_seqfile(dev, "aspm_state_cnt", pcie->debugfs,
>>                       aspm_state_cnt);
>>   }
>>   #else
>> @@ -1634,7 +1643,6 @@ static void tegra_pcie_deinit_controller(struct 
>> tegra_pcie_dw *pcie)
>>   static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
>>   {
>>       struct device *dev = pcie->dev;
>> -    char *name;
>>       int ret;
>>       pm_runtime_enable(dev);
>> @@ -1664,13 +1672,6 @@ static int tegra_pcie_config_rp(struct 
>> tegra_pcie_dw *pcie)
>>           goto fail_host_init;
>>       }
>> -    name = devm_kasprintf(dev, GFP_KERNEL, "%pOFP", dev->of_node);
>> -    if (!name) {
>> -        ret = -ENOMEM;
>> -        goto fail_host_init;
>> -    }
>> -
>> -    pcie->debugfs = debugfs_create_dir(name, NULL);
>>       init_debugfs(pcie);
>>       return ret;
>>
>> base-commit: a8662bcd2ff152bfbc751cab20f33053d74d0963


