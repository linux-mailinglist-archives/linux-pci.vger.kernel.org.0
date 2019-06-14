Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71735465AF
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 19:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfFNRXq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 13:23:46 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19637 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfFNRXq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jun 2019 13:23:46 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d03d8210001>; Fri, 14 Jun 2019 10:23:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 14 Jun 2019 10:23:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 14 Jun 2019 10:23:45 -0700
Received: from [10.24.192.32] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Jun
 2019 17:23:42 +0000
Subject: Re: [PATCH V4 27/28] PCI: tegra: Add support for GPIO based PERST#
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Thierry Reding <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190516055307.25737-28-mmaddireddy@nvidia.com>
 <20190604132233.GT16519@ulmo>
 <20190613152404.GB30445@e121166-lin.cambridge.arm.com>
 <cb2dd446-1275-7179-33ac-e5c237d81da6@nvidia.com>
 <20190614143222.GB23116@e121166-lin.cambridge.arm.com>
 <1508173d-0ecc-f498-6ab2-78a718086b35@nvidia.com>
 <20190614145023.GA24588@e121166-lin.cambridge.arm.com>
 <20190614152304.GK15526@ulmo>
 <20190614155934.GA28253@e121166-lin.cambridge.arm.com>
 <51e4ae62-f842-1d2f-fbca-0b2063dd53a6@nvidia.com>
 <20190614165353.GB30511@e121166-lin.cambridge.arm.com>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <1c662f82-8329-5e1b-58bf-b2fe1643adb0@nvidia.com>
Date:   Fri, 14 Jun 2019 22:53:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614165353.GB30511@e121166-lin.cambridge.arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560533025; bh=3CBnkFdGS4UTonodjsvkHODIWZ6WFboQ59T/RqSru8Y=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=lmaxOTZvROR0MfaPsBg4jLsAOYnOe6ahzTDz6xEqF3tenMe+bSiEBLsPIu+qLN7sS
         8QLBswT36O2eRT8dv3JWcWeEoPONNFz8iO6MsDkXxvp9QLTfXvQHdElUAj+02ANkGk
         7U31LaaPBXuoBhM0CNdW/Ik3v8Qz/I+qGs3RZSgrbVAJHnd+/s2OhfDYq3nafB5C37
         dWFHsPdc0ERWk/M/y+tM2/In7lw1HIYNDh8CICQXJ8dt3bG/8gd9u+KLJuWtrAy+QC
         49aKTa8Z4x2zBXxIce1igYzZQFWYXi5BE8PS51YctELQ29+vreQIMgPCktswU7WgIs
         a+1FIsxkL9p+A==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 14-Jun-19 10:23 PM, Lorenzo Pieralisi wrote:
> On Fri, Jun 14, 2019 at 10:00:49PM +0530, Manikanta Maddireddy wrote:
>
> [...]
>
>> GPIO based PERST# is per-platform requirement.
>> If DT prop is not present, then devm_gpiod_get_from_of_node() returns
>> NULL gpio_desc.
>>
>> struct gpio_desc *gpiod_get_from_of_node(struct device_node *node,
>>                                          const char *propname, int index,
>>                                          enum gpiod_flags dflags,
>>                                          const char *label)
>> {
>>         struct gpio_desc *desc;
>>         unsigned long lflags = 0;
>>         enum of_gpio_flags flags;
>>         bool active_low = false;
>>         bool single_ended = false;
>>         bool open_drain = false;
>>         bool transitory = false;
>>         int ret;
>>
>>         desc = of_get_named_gpiod_flags(node, propname,
>>                                         index, &flags);
>>
>>         if (!desc || IS_ERR(desc)) {
>> */* If it is not there, just return NULL */****if (PTR_ERR(desc) == -ENOENT)****return NULL;*
>>                 return desc;
>>         }
>> 	...
>>
>> }
> Ok. My point then is that you have no way to enforce this requirement on
> platforms that actually need it, I do not even know if there is a
> way you can do it (I was thinking along the lines of using a
> compatible string to detect whether the GPIO #PERST reset is mandatory)
> but maybe this is not even a SOC property.
>
> Maybe what I am asking is overkill, I just wanted to understand.
>
> I was just asking a question to understand how you handle the case
> where a GPIO pin definition is missing in DT for a platform that
> actually needs it, the driver will probe but nothing will work.
>
> It would be good to describe this and capture it in the commit log.
>
> Thanks,
> Lorenzo

I can't think of a easy way to enforce this requirement. As you said
compatible string is per SOC, so we can't use it for a platform.
This issue is present on only one platform, so it is hard to miss the
DT property. That is the reason for publishing this patch with out this
enforcement in driver.

I thought for changing PERST# to GPIO for all platform, but testing is
a tedious job. Also I don't have Tegra20 and Tegra30 platforms.

Do you want me to drop the patch or update the limitation in the commit
log?

Manikanta


