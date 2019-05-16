Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA87A1FEE0
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2019 07:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfEPFvY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 May 2019 01:51:24 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8813 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfEPFvX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 May 2019 01:51:23 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cdcfa610000>; Wed, 15 May 2019 22:51:29 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 15 May 2019 22:51:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 15 May 2019 22:51:22 -0700
Received: from [10.24.192.61] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 05:51:19 +0000
Subject: Re: [PATCH V3 27/29] PCI: OF: Add of_pci_get_reset_gpio() to parse
 reset-gpios from DT
To:     Rob Herring <robh@kernel.org>
CC:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190513180744.16493-1-mmaddireddy@nvidia.com>
 <20190513180744.16493-28-mmaddireddy@nvidia.com>
 <20190514183105.GA32636@bogus>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <2f0aedd3-92b6-f0bb-abab-3ed5fc6fda80@nvidia.com>
Date:   Thu, 16 May 2019 11:20:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514183105.GA32636@bogus>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557985889; bh=6qUpqr1/k7a8ckfkYIZWG1rjoMIPHv1N+KPbX6IkrjA=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=WIbED7NcQVPhaZ1E27NtSANJx69xKv/RbMhEBuIiw2KqBWkf68AnBk3mIFojtlyPa
         fP4aP6smt/yrBNUdNbCqJJX3PXiftNVODecVst7ksIk7678vd31QUrcD/E2ktSlRM3
         FrAYj45T3QvB9IWkH0GfFCGRCURXxoyA8HlUP29LhofbppudrIKTxWzQk8oh8RpbEF
         X1tgXLve6BOgzRbMQ8pr3WUgByG673a8zTgm3TUdKqIRw6WcmEPXXJbupAQSBZ0Jh9
         KGU//RSy79mX/FIEO5wNY/aH2yNC4+PsP7HR+OLmZGPDM8B64IZSNDg4yKb78PM4XK
         nNhlSxkpDRS4g==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 15-May-19 12:01 AM, Rob Herring wrote:
> On Mon, May 13, 2019 at 11:37:42PM +0530, Manikanta Maddireddy wrote:
>> This new helper function could be used by host drivers to get the reset
>> GPIO descriptor. If the property isn't assigned, it will return NULL to
>> the caller.
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>> V3: New patch to add helper function to parse "reset-gpios"
>>
>>  drivers/pci/of.c       | 18 ++++++++++++++++++
>>  include/linux/of_pci.h | 10 ++++++++++
>>  2 files changed, 28 insertions(+)
>>
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index 9454c90980c9..2a0282115ff0 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -6,6 +6,7 @@
>>   */
>>  #define pr_fmt(fmt)	"PCI: OF: " fmt
>>  
>> +#include <linux/gpio/consumer.h>
>>  #include <linux/irqdomain.h>
>>  #include <linux/kernel.h>
>>  #include <linux/pci.h>
>> @@ -224,6 +225,23 @@ int of_pci_get_max_link_speed(struct device_node *node)
>>  }
>>  EXPORT_SYMBOL_GPL(of_pci_get_max_link_speed);
>>  
>> +/**
>> + * of_pci_get_reset_gpio() - Get PCI reset gpio descriptor.
>> + *
>> + * @node: device node
>> + *
>> + * Returns PCI reset gpio descriptor from DT, or an ERR_PTR() if the
>> + * required property is invalid.
>> + */
>> +struct gpio_desc *of_pci_get_reset_gpio(struct device *dev,
>> +					struct device_node *node,
>> +					int dflags, char *label)
>> +{
>> +	return devm_gpiod_get_from_of_node(dev, node, "reset-gpios", 0, dflags,
>> +					   label);
>> +}
> There's nothing PCI specific about this and 'reset-gpios' is pretty 
> widely used. Either we should have this somewhere common or perhaps not 
> worth a wrapper to save 1 parameter.
>
> Also, I believe you can pass just 'reset' so the deprecated form 
> 'reset-gpio' can also be supported. 
>
> Rob

I also think that it doesn't need a wrapper to save one parameter.
I will drop this patch and use devm_gpiod_get_from_of_node() directly
in pci-tegra driver.

Manikanta


