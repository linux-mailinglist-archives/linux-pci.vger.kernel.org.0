Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B922305332
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jan 2021 07:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhA0GaA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jan 2021 01:30:00 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8611 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbhA0GU0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jan 2021 01:20:26 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601106000000>; Tue, 26 Jan 2021 22:19:44 -0800
Received: from [10.25.73.63] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Jan
 2021 06:19:33 +0000
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIXSBQQ0k6IGR3YzogZml4IHJlZmVyZW5j?=
 =?UTF-8?Q?e_leak_in_pex=5fep=5fevent=5fpex=5frst=5fdeassert?=
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        zhangqilong <zhangqilong3@huawei.com>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20201102143045.142121-1-zhangqilong3@huawei.com>
 <f09c0801-d584-3c27-d3e7-ca59a64a30d1@nvidia.com>
 <b1f6b6805a7746b48020d7cfaaa73fab@huawei.com>
 <20210125163431.GB5795@e121166-lin.cambridge.arm.com>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <ecc71860-1391-aca8-ce60-24497ddbcf7d@nvidia.com>
Date:   Wed, 27 Jan 2021 11:49:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210125163431.GB5795@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611728384; bh=H149k2HJXyD3ZZSbCbFoC+CkaNViV6Lg8T18vc3KGYg=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=bDJgtJEo893xTvKpAztvDejRyRFnqBGJS7jR6v8sZBy/OEERSLXQQt6XAlkDvQZVp
         1x6z/iNhq9ip7L7jjevZD89C3WZNb1PZnvLPY1kSdtetVuDmXV2DtORLvhtdIZLXQY
         l5h6m0EIbVMcFqRlTRVsp2BeG7RgnRZ7gnEfv/NJcz0dhNEBImRNwAwfZUfk9YX7dQ
         ARdQyszD9TdNCg0Q9HVnJEWXY7s2L0svNbJvyUg8PjixhFcR9T7psfp48ShLWaBHIA
         +kSXrP2g4kzvDXA+GlNjsnQhfGYIM7I2Y+cHwdEDKvf+fWhVSehFC8Vvs4Kn1FWj+R
         pgxy/eWEhlvgg==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/25/2021 10:04 PM, Lorenzo Pieralisi wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, Nov 03, 2020 at 03:14:21AM +0000, zhangqilong wrote:
>> Hi
>>
>>>
>>>
>>> On 11/2/2020 8:00 PM, Zhang Qilong wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> pm_runtime_get_sync will increment pm usage counter even it failed.
>>>> Forgetting to pm_runtime_put_noidle will result in reference leak in
>>>> pex_ep_event_pex_rst_deassert, so we should fix it.
>>>>
>>>> Fixes: c57247f940e8e ("PCI: tegra: Add support for PCIe endpoint mode
>>>> in Tegra194")
>>>> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
>>>> ---
>>>>    drivers/pci/controller/dwc/pcie-tegra194.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c
>>>> b/drivers/pci/controller/dwc/pcie-tegra194.c
>>>> index f920e7efe118..936510b5c649 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>>>> @@ -1662,6 +1662,7 @@ static void pex_ep_event_pex_rst_deassert(struct
>>>> tegra_pcie_dw *pcie)
>>>>
>>>>           ret = pm_runtime_get_sync(dev);
>>>>           if (ret < 0) {
>>>> +               pm_runtime_put_noidle(dev);
>>> Why can't we call pm_runtime_put_sync(dev) as that is what is being called in
>>> failure cases anyway further down in this API?
>>>
>> Both of the two functions are OK, the difference is that, when pm_runtime_put_sync failed(runtime of the device has error, the device is in Inaccessible state or other error state...), it only increase the usage count of the power, and do nothing else. We merely need call pm_runtime_put_noidle to decrease the usage count. If we call pm_runtime_put_sync to reset it, it will notify device bus type if the device can be suspended, and that is meanless when pm_runtime_put_sync failed.
> 
> I don't understand. Vidya any feedback ?
If I understand this correctly, we are assuming that nothing would have 
happened apart from just counter increment and hence don't want to run 
the idle check by calling pm_runtime_put_noidle(). On a different note, 
what is it that we are going to lose if we let the idle check also to 
run i.e. by calling pm_runtime_put_sync()?

Thanks,
Vidya Sagar
> 
> Lorenzo
> 
>> Thanks, best wish!
>>
>> Zhang Qilong
>>>>                   dev_err(dev, "Failed to get runtime sync for PCIe
>>> dev: %d\n",
>>>>                           ret);
>>>>                   return;
>>>> --
>>>> 2.17.1
>>>>
