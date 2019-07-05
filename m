Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 312816042F
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2019 12:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfGEKL7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jul 2019 06:11:59 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8879 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfGEKL7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Jul 2019 06:11:59 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d1f226b0000>; Fri, 05 Jul 2019 03:11:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 05 Jul 2019 03:11:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 05 Jul 2019 03:11:57 -0700
Received: from [192.168.1.141] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Jul
 2019 10:11:54 +0000
Subject: Re: [PATCH] PCI: tegra: Fix support for GPIO based PERST#
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jon Hunter <jonathanh@nvidia.com>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190705084850.30777-1-jonathanh@nvidia.com>
 <20190705095008.GB17491@e121166-lin.cambridge.arm.com>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <3269adc0-215a-be7b-0820-bea7c07f6dcc@nvidia.com>
Date:   Fri, 5 Jul 2019 15:41:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190705095008.GB17491@e121166-lin.cambridge.arm.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562321516; bh=iuPlrRbm3SRRKi5NaJZmZm/BQsmRFpOi0nq1gIpKbP4=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=UOIH9ZOkFY4izZikflUYNA89wYJRhxtFgSvBW14H6qXL07AVK3Fb1vwlgI7cH6Iqm
         s0Kxngl3iyS68AKHteo58uPEi9wtS3Of1z7CTDOvTgRMdIVG1tzELjDFklSoZpQXfI
         ZB5vha0G6LAuwan2sfcyKSsvHXtuLTONdfXml2utCvQWnIeORZm/9/IxMgt5FOxajn
         NoxBPLEBwi65NoPWkxVfvw3KGHicZSVjY7PHl/WaGbXeQ8dS1MuJiDZ1hd7GFzr/3w
         Sgf6/EPffOTVfeJEb01y94SFH4MRTSOeQbIMMH3djzb6UBYwTFAavpusdgf13CGHly
         NfIqqvr95FCsQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 05-Jul-19 3:20 PM, Lorenzo Pieralisi wrote:
> On Fri, Jul 05, 2019 at 09:48:50AM +0100, Jon Hunter wrote:
>> Commit 5e5e9c23f82a ("PCI: tegra: Add support for GPIO based PERST#")
>> calls the function devm_gpiod_get_from_of_node() to request a GPIO.
>> Unfortunately, around the same time this was merged, commit 025bf37725f1
>> ("gpio: Fix return value mismatch of function gpiod_get_from_of_node()")
>> was also merged to fix the return value of the function
>> devm_gpiod_get_from_of_node() that was incorrectly returning NULL
>> instead of an error pointer encoded with -ENOENT if no GPIO was found.
>> When this fix for the GPIO subsystem was merged, PCI support for Tegra
>> devices that did not provide a GPIO for the PERST# (which is optional)
>> broke because the Tegra PCI driver was expecting NULL to be returned if
>> no GPIO was present and not -ENOENT.
>>
>> Fix this by checking to see if -ENOENT is returned from the function
>> devm_gpiod_get_from_of_node(), to indicate there is no GPIO for PERST#
>> present, and if this is the case set the variable 'reset_gpio' to NULL.
>> If the variable 'reset_gpio' is NULL then the Tegra PCI driver will
>> fallback to using the AFI register to toggle the PERST#. Finally,
>> correct the comment now that NULL is no longer returned from
>> devm_gpiod_get_from_of_node().
>>
>> Fixes: 5e5e9c23f82a ("PCI: tegra: Add support for GPIO based PERST#")
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>>  drivers/pci/controller/pci-tegra.c | 16 ++++++++++------
>>  1 file changed, 10 insertions(+), 6 deletions(-)
> Can I squash this in the original commit (ie Fixes: tag above) ? I do
> not think there is any issue with that, if there is please do let me
> know.
>
> Thanks,
> Lorenzo

Reviewed-by: Manikanta Maddireddy

Thank you Jon for publishing the fix.

Hi Lorenzo,

Yes, this patch can be squashed in the original commit.

Apologies for the inconvenience.

Manikanta

>> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
>> index 9cc03a2549c0..ff8a346f3e04 100644
>> --- a/drivers/pci/controller/pci-tegra.c
>> +++ b/drivers/pci/controller/pci-tegra.c
>> @@ -2295,18 +2295,22 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
>>  		}
>>  
>>  		/*
>> -		 * Returns null if reset-gpios property is not populated and
>> -		 * fall back to using AFI per port register to toggle PERST#
>> -		 * SFIO line.
>> +		 * Returns -ENOENT if reset-gpios property is not populated
>> +		 * and in this case fall back to using AFI per port register
>> +		 * to toggle PERST# SFIO line.
>>  		 */
>>  		rp->reset_gpio = devm_gpiod_get_from_of_node(dev, port,
>>  							     "reset-gpios", 0,
>>  							     GPIOD_OUT_LOW,
>>  							     label);
>>  		if (IS_ERR(rp->reset_gpio)) {
>> -			err = PTR_ERR(rp->reset_gpio);
>> -			dev_err(dev, "failed to get reset GPIO: %d\n", err);
>> -			return err;
>> +			if (PTR_ERR(rp->reset_gpio) == -ENOENT) {
>> +				rp->reset_gpio = NULL;
>> +			} else {
>> +				dev_err(dev, "failed to get reset GPIO: %d\n",
>> +					err);
>> +				return PTR_ERR(rp->reset_gpio);
>> +			}
>>  		}
>>  
>>  		list_add_tail(&rp->list, &pcie->ports);
>> -- 
>> 2.17.1
>>

