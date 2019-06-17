Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FACE47FA0
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 12:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfFQK1m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 06:27:42 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:10348 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfFQK1m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2019 06:27:42 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d076b1e0000>; Mon, 17 Jun 2019 03:27:42 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 17 Jun 2019 03:27:41 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 17 Jun 2019 03:27:41 -0700
Received: from [10.24.192.33] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 17 Jun
 2019 10:27:38 +0000
Subject: Re: [PATCH V4 27/28] PCI: tegra: Add support for GPIO based PERST#
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Thierry Reding <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190613152404.GB30445@e121166-lin.cambridge.arm.com>
 <cb2dd446-1275-7179-33ac-e5c237d81da6@nvidia.com>
 <20190614143222.GB23116@e121166-lin.cambridge.arm.com>
 <1508173d-0ecc-f498-6ab2-78a718086b35@nvidia.com>
 <20190614145023.GA24588@e121166-lin.cambridge.arm.com>
 <20190614152304.GK15526@ulmo>
 <20190614155934.GA28253@e121166-lin.cambridge.arm.com>
 <51e4ae62-f842-1d2f-fbca-0b2063dd53a6@nvidia.com>
 <20190614165353.GB30511@e121166-lin.cambridge.arm.com>
 <1c662f82-8329-5e1b-58bf-b2fe1643adb0@nvidia.com>
 <20190617094839.GE18020@e121166-lin.cambridge.arm.com>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <0f9bb97d-5a30-a654-0cc6-a57a7bd894c8@nvidia.com>
Date:   Mon, 17 Jun 2019 15:57:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617094839.GE18020@e121166-lin.cambridge.arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560767262; bh=ArjMvMf+U4NnEGoelw4i9Pum1eYFcmh/YaKtRjFxtF4=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=HqTZIBSf4XlQBg2iWk38DqjsnZ4StA4aNt2JrzAnN1Xz4vAGBNzWnrVPN2yLf/lLP
         kUVRBbD6mU7ZhcUekI9zQBfDQfgSt7ISt/FnsSMZ0S/fpSuR4+PzeQJIi/GdVN8kjd
         P2n56yasB7YhgDmACgfFLKqY7xu6Z5BZ5+Ii8ajsNaT6DIxK8oDm+LQnKckDbzReQf
         JHiBPGqWT3nlo+GTKTGZ3EoWLr1/NptIbgGCKBV/KIHg21Uhlthn1w5YUGR1SjmsH4
         62ZN99B9pKLdfLhROkJuVLVcEiTFxJ+0CY/+RawNv5E1jdmLeOyz150z5bVoHss8Ba
         7T2t5Ut+TT4wQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 17-Jun-19 3:18 PM, Lorenzo Pieralisi wrote:
> On Fri, Jun 14, 2019 at 10:53:13PM +0530, Manikanta Maddireddy wrote:
>
> [...]
>
>>> Ok. My point then is that you have no way to enforce this requirement on
>>> platforms that actually need it, I do not even know if there is a
>>> way you can do it (I was thinking along the lines of using a
>>> compatible string to detect whether the GPIO #PERST reset is mandatory)
>>> but maybe this is not even a SOC property.
>>>
>>> Maybe what I am asking is overkill, I just wanted to understand.
>>>
>>> I was just asking a question to understand how you handle the case
>>> where a GPIO pin definition is missing in DT for a platform that
>>> actually needs it, the driver will probe but nothing will work.
>>>
>>> It would be good to describe this and capture it in the commit log.
>>>
>>> Thanks,
>>> Lorenzo
>> I can't think of a easy way to enforce this requirement. As you said
>> compatible string is per SOC, so we can't use it for a platform.
>> This issue is present on only one platform, so it is hard to miss the
>> DT property. That is the reason for publishing this patch with out this
>> enforcement in driver.
>>
>> I thought for changing PERST# to GPIO for all platform, but testing is
>> a tedious job. Also I don't have Tegra20 and Tegra30 platforms.
> I can't help with that.
>
>> Do you want me to drop the patch or update the limitation in the commit
>> log?
> It is Thierry's call, if he is OK with it fine by me, please do
> update the commit log, it will help everybody understand.
>
> Lorenzo

Sure, I will update the commit log in V5.
Please let me know if you completed reviewing this series, I will
send V5 addressing review comments in this patch.

Manikanta


