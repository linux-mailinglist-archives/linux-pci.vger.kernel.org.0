Return-Path: <linux-pci+bounces-26842-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B38A9DE53
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 03:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 047393A299F
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 01:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDCE182D0;
	Sun, 27 Apr 2025 01:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DIUGfBZB"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6401DD530;
	Sun, 27 Apr 2025 01:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745716856; cv=none; b=mCur1Sjp/0w40KVfbeSDIJnaKX3dlZQN4VyqsWAFFRyS10vW2mQXepic0nBArR8yDoC6IcHCOaYlU3Ie3EAY8CLMSc6O10J+Qn9u3Mzu+O25BCbMW/hgCx5CewB3nQZwdmHpLMML2YGAN8HHT7qRxMO89MFRmZq5QnlEPFxEH0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745716856; c=relaxed/simple;
	bh=UvnS6gPzfKQKpogwazhjV736OAM+avEcM9r5OAccqek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kbwKGz1CBE+Uv+g1RrhiTsr2l9gXi5AHBhZikLMXo3gsXvzcuzjCEAU82o0OB6N+tWGA3U7RRPYDsRJaIcvI+RZZZZsTBLniURWS4uvlVOJt1VgETYaxwuL/2qgK6Msj/aeyoKwPAvpnaa659WBn2HSy8JL94YHWNaywX79fIDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DIUGfBZB; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=ZaBGyOA3WCS7w8cIJqxwWoKZGcjfaxFGZHiWR6U+FO8=;
	b=DIUGfBZBB3Cdpo2on7p++sR0W/3QUZdLUPzA/mpCCA8wOANBYI1/WuMjUyxrOE
	dNY4V1clidQP5waMnSGOJT/7sLQaayiatyzdeDrBTH15NSQD1VoAZcCNTzxDEO0E
	YxApF8X+PNYciWmYtRez5hFn3ZdwpLp/2y28sSY2P93Ek=
Received: from [192.168.142.52] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDnAFw4hg1opY18Cw--.63138S2;
	Sun, 27 Apr 2025 09:19:53 +0800 (CST)
Message-ID: <d9da0347-ce8c-4b5e-91d9-d85ea6fa41d7@163.com>
Date: Sun, 27 Apr 2025 09:19:52 +0800
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
X-CM-TRANSID:_____wDnAFw4hg1opY18Cw--.63138S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxury8Ar4UJw48GF1fJFWfGrg_yoW5Zw4fpa
	95Ga1YkF4kJw43urZ7Za1DZr1SywsayrZ7J345uw10vr1DCr98tF48KrWYqa97urZ7tr10
	yr4rt3ZrCr15JFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UpGQgUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDww7o2gNCi89ZAABsD



On 2025/4/8 03:43, Christophe JAILLET wrote:
> Hi,
> 
> Nitpick: PATCH is missing within the [] in the subject.
> 
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

Dear all,

I see that the status of this patch is Rejected and I want to know why.

Best regards,
Hans



