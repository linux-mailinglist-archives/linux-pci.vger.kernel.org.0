Return-Path: <linux-pci+bounces-25352-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92143A7D1A7
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 03:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A93416A4D6
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 01:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A3420F093;
	Mon,  7 Apr 2025 01:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eYW7R0s3"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CEA20E6EC;
	Mon,  7 Apr 2025 01:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743988642; cv=none; b=aBV8oZLRDQx13ouI8eCzf+bcpKWYICFEyvu7H/lx7HrwH7lAXPqG1B5o1SgYCujPdQoqW/i38kqEAoBZdT6HWWf28mgHT4lBlz/3fNEjJ6icVwO7pYstIghd57M5qnqOhlS06azPW42RFB5CH7HmgC/awhtJPhKFgHK/4KMitr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743988642; c=relaxed/simple;
	bh=jTxtvHUQTiieJDKEaeHc+Dcy9dp+8XVM1kYkT75QTrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GwjP6NmCgoS9mkTsuzg9P+wAcqnbSGSsBeAYCvtL9bwdaqyr/eKZ4Z+y5qXZ952Fd/K7z7346oMB0wWtfrHai/0CG/CHw6C4qtxI8SIekbS3xQkusLZlmsuQpmzaqFmP80ECF2upd7AUUtZDz47QJjKrzqt3KxWECpVhCF++Y34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eYW7R0s3; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=tyETaFYY/JUiWihlfOzZwF2bXPr6FQIVTqdDJM+AwWM=;
	b=eYW7R0s3sqixY+4EyMqgiRBmm61SMYjAVWxwnwjr0r2msVAPN3Vk9KD6qRcawE
	Gt1mMFO8eobEPLmNi/6gVr8MIHMWvP/sXCnUGpMbOVsZPb5rBEB8vrHTHEWLlGnV
	loX1aiDj8Ji43n7ZbjrTK9MHctdDL6fniSiI/FKHQXDAY=
Received: from [192.168.142.52] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3NzlxJ_NnbeWaEg--.62095S2;
	Mon, 07 Apr 2025 09:16:35 +0800 (CST)
Message-ID: <c0582215-e09e-44f7-a225-7c255e26d29f@163.com>
Date: Mon, 7 Apr 2025 09:16:33 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] PCI: tegra194: Fix debugfs directory creation when
 CONFIG_PCIEASPM is disabled
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: bhelgaas@google.com, jonathanh@nvidia.com, kw@linux.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-tegra@vger.kernel.org, lpieralisi@kernel.org,
 manivannan.sadhasivam@linaro.org, robh@kernel.org, thierry.reding@gmail.com
References: <20250406134355.49036-1-18255117159@163.com>
 <c51bbf38-0c6a-418f-b1e2-763d621186ff@wanadoo.fr>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <c51bbf38-0c6a-418f-b1e2-763d621186ff@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3NzlxJ_NnbeWaEg--.62095S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxury8Ar4rArW5uw4xGF1Dtrb_yoWrGF1rpa
	95JFWYkw4xAa13WrZ3Za1DZr1SyrsayrZ7J34S9w1vvr1DAr98tFW8GryYqas7CrZ2qF18
	Ar4YkFnrCr15XrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UpBTrUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxooo2fzIeX3LgAAsX



On 2025/4/7 02:10, Christophe JAILLET wrote:
> Le 06/04/2025 à 15:43, Hans Zhang a écrit :
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
>> Signed-off-by: Hans Zhang <18255117159-9Onoh4P/yGk@public.gmane.org>
>> ---
>> Changes since v1:
>> https://lore.kernel.org/linux-pci/20250405145459.26800-1-18255117159-9Onoh4P/yGk@public.gmane.org
>>
>> - The first version was committed incorrectly because the judgment
>>    parameter in "debugfs_remove_recursive" was not noticed.
>> ---
>>   drivers/pci/controller/dwc/pcie-tegra194.c | 27 +++++++++++++---------
>>   1 file changed, 16 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c 
>> b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index 5103995cd6c7..f048b2342af4 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -711,16 +711,27 @@ static void init_host_aspm(struct tegra_pcie_dw 
>> *pcie)
>>       dw_pcie_writel_dbi(pci, PCIE_PORT_AFR, val);
>>   }
>> -static void init_debugfs(struct tegra_pcie_dw *pcie)
>> +static int init_debugfs(struct tegra_pcie_dw *pcie)
> 
> I would keep it a void function.
> If devm_kasprintf() fails, which is unlikely, then the module should 
> still work correctly. So just a return; should be fine IMHO.
> 
> Usually, errors related to debugfs are silently ignored as is does not 
> prevent this to work.
> 

Hi Christophe,

Thanks your for reply. Will change.

Best regards,
Hans

> CJ
> 
>>   {
>> -    debugfs_create_devm_seqfile(pcie->dev, "aspm_state_cnt", 
>> pcie->debugfs,
>> +    struct device *dev = pcie->dev;
>> +    char *name;
>> +
>> +    name = devm_kasprintf(dev, GFP_KERNEL, "%pOFP", dev->of_node);
>> +    if (!name)
>> +        return -ENOMEM;
>> +
>> +    pcie->debugfs = debugfs_create_dir(name, NULL);
>> +
>> +    debugfs_create_devm_seqfile(dev, "aspm_state_cnt", pcie->debugfs,
>>                       aspm_state_cnt);
>> +
>> +    return 0;
>>   }
>>   #else
>>   static inline void disable_aspm_l12(struct tegra_pcie_dw *pcie) { 
>> return; }
>>   static inline void disable_aspm_l11(struct tegra_pcie_dw *pcie) { 
>> return; }
>>   static inline void init_host_aspm(struct tegra_pcie_dw *pcie) { 
>> return; }
>> -static inline void init_debugfs(struct tegra_pcie_dw *pcie) { return; }
>> +static inline int init_debugfs(struct tegra_pcie_dw *pcie) { return 0; }
>>   #endif
>>   static void tegra_pcie_enable_system_interrupts(struct dw_pcie_rp *pp)
>> @@ -1634,7 +1645,6 @@ static void tegra_pcie_deinit_controller(struct 
>> tegra_pcie_dw *pcie)
>>   static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
>>   {
>>       struct device *dev = pcie->dev;
>> -    char *name;
>>       int ret;
>>       pm_runtime_enable(dev);
>> @@ -1664,14 +1674,9 @@ static int tegra_pcie_config_rp(struct 
>> tegra_pcie_dw *pcie)
>>           goto fail_host_init;
>>       }
>> -    name = devm_kasprintf(dev, GFP_KERNEL, "%pOFP", dev->of_node);
>> -    if (!name) {
>> -        ret = -ENOMEM;
>> +    ret = init_debugfs(pcie);
>> +    if (ret < 0)
>>           goto fail_host_init;
>> -    }
>> -
>> -    pcie->debugfs = debugfs_create_dir(name, NULL);
>> -    init_debugfs(pcie);
>>       return ret;
>>
>> base-commit: a8662bcd2ff152bfbc751cab20f33053d74d0963


