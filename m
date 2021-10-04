Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4177F42065B
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 09:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbhJDHEZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 03:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhJDHEY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 03:04:24 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C25C061745;
        Mon,  4 Oct 2021 00:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bI2np8Q4ILlCSNdI2CbmdBQy7PNhtLCcwtOCeHSi3AI=; b=I7Z4ccPfY7nDPNr6EHwknVa+QN
        iG784dwtgAi28T/fqzDCVj2Kla1RUorT3cMWRKTVtfMB7sGKMppf7YPS0r7AasJwyp9KgV65JDRYy
        +MRXvZCi4Us9Kd83vUvrqHB/XFp5wUstqrAUTxCHCmjKYrG3MAslIRSu7u4c8WpMr7s8bJIho62mW
        IJwn53s14knQ3VTWKtGh+UZhaPtjRBgj57O6Q7/9lMQi+sruCWbTv2P6JzrtAH2UGL/BaF360lQBV
        3wvunQ3roggPjyxowY67sV326QMRcVG5bkH2LIMWAP1daF6RQD6ptFOP9zAwNmvcL6qICKUSdPNUF
        9ngeyYkA==;
Received: from dsl-hkibng22-54f986-236.dhcp.inet.fi ([84.249.134.236] helo=[192.168.1.10])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1mXHzZ-0005CY-Hv; Mon, 04 Oct 2021 10:02:29 +0300
Subject: Re: [PATCH 4/5] cpufreq: tegra186/tegra194: Handle errors in BPMP
 response
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     rafael@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
        krzysztof.kozlowski@canonical.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, p.zabel@pengutronix.de,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20210915085517.1669675-1-mperttunen@nvidia.com>
 <20210915085517.1669675-4-mperttunen@nvidia.com>
 <20211004070145.pp3rafkinffk2pyh@vireshk-i7>
From:   Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <ea6c43ef-8787-168c-a8bf-5d8d41d627e8@kapsi.fi>
Date:   Mon, 4 Oct 2021 10:02:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211004070145.pp3rafkinffk2pyh@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 84.249.134.236
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/4/21 10:01 AM, Viresh Kumar wrote:
> On 15-09-21, 11:55, Mikko Perttunen wrote:
>> The return value from tegra_bpmp_transfer indicates the success or
>> failure of the IPC transaction with BPMP. If the transaction
>> succeeded, we also need to check the actual command's result code.
>> Add code to do this.
>>
>> While at it, explicitly handle missing CPU clusters, which can
>> occur on floorswept chips. This worked before as well, but
>> possibly only by accident.
>>
>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>> ---
>>   drivers/cpufreq/tegra186-cpufreq.c | 4 ++++
>>   drivers/cpufreq/tegra194-cpufreq.c | 8 +++++++-
>>   2 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
>> index 5d1943e787b0..6c88827f4e62 100644
>> --- a/drivers/cpufreq/tegra186-cpufreq.c
>> +++ b/drivers/cpufreq/tegra186-cpufreq.c
>> @@ -159,6 +159,10 @@ static struct cpufreq_frequency_table *init_vhint_table(
>>   		table = ERR_PTR(err);
>>   		goto free;
>>   	}
>> +	if (msg.rx.ret) {
>> +		table = ERR_PTR(-EINVAL);
>> +		goto free;
>> +	}
>>   
>>   	for (i = data->vfloor; i <= data->vceil; i++) {
>>   		u16 ndiv = data->ndiv[i];
>> diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
>> index a9620e4489ae..ac381db25dbe 100644
>> --- a/drivers/cpufreq/tegra194-cpufreq.c
>> +++ b/drivers/cpufreq/tegra194-cpufreq.c
>> @@ -242,7 +242,7 @@ static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
>>   
>>   	smp_call_function_single(policy->cpu, get_cpu_cluster, &cl, true);
>>   
>> -	if (cl >= data->num_clusters)
>> +	if (cl >= data->num_clusters || !data->tables[cl])
>>   		return -EINVAL;
>>   
>>   	/* set same policy for all cpus in a cluster */
>> @@ -310,6 +310,12 @@ init_freq_table(struct platform_device *pdev, struct tegra_bpmp *bpmp,
>>   	err = tegra_bpmp_transfer(bpmp, &msg);
>>   	if (err)
>>   		return ERR_PTR(err);
>> +	if (msg.rx.ret == -BPMP_EINVAL) {
>> +		/* Cluster not available */
>> +		return NULL;
>> +	}
>> +	if (msg.rx.ret)
>> +		return ERR_PTR(-EINVAL);
>>   
>>   	/*
>>   	 * Make sure frequency table step is a multiple of mdiv to match
> 
> Applied. Thanks.
> 

Thanks!

Mikko
