Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2116B1A2290
	for <lists+linux-pci@lfdr.de>; Wed,  8 Apr 2020 15:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgDHNG2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Apr 2020 09:06:28 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:36970 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727902AbgDHNG1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Apr 2020 09:06:27 -0400
Received: from [192.168.1.4] (212-5-158-69.ip.btc-net.bg [212.5.158.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id AC2DFCFB4;
        Wed,  8 Apr 2020 16:06:24 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1586351185; bh=b49iDG8IN2LwQuXCivPrSYLmA+u1Ox/a/HqsWubR/cs=;
        h=Subject:To:Cc:From:Date:From;
        b=YnZae3dtnDweNils7UPkECsSFUcxag0g6B9OS0FcGO4iTuvphscpte+fPB9x1aHok
         chukJ1sx8kdHSZ54RXmoGFny7C33xmNV01xNjmcUKWq8FflRs3Bh3PvMNpNS6i3ZL7
         DnRBlD5hKjrv0/a8LnouZF5aZakeoKMkJkggOZH6gW26E0LUV6o6eWWlam76/AxC8N
         7pUBVXQoMmGLEi1HTp91BVrHpToaY/VIoG6XkImVnJwZLBfKb1bNCye3UNXFv31wVb
         Sn3PQTR+25cq/oCfXwcdNU+0ybwMNoN+Ik5tzkHdowDUdfGxufuZnVATQqIU2wFRuf
         oPd6kuKim7P9g==
Subject: Re: R: R: [PATCH v2 01/10] PCIe: qcom: add missing ipq806x clocks in
 PCIe driver
To:     ansuelsmth@gmail.com, 'Andy Gross' <agross@kernel.org>
Cc:     'Sham Muthayyan' <smuthayy@codeaurora.org>,
        'Bjorn Andersson' <bjorn.andersson@linaro.org>,
        'Bjorn Helgaas' <bhelgaas@google.com>,
        'Rob Herring' <robh+dt@kernel.org>,
        'Mark Rutland' <mark.rutland@arm.com>,
        'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>,
        'Andrew Murray' <amurray@thegoodpenguin.co.uk>,
        'Philipp Zabel' <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200402121148.1767-1-ansuelsmth@gmail.com>
 <20200402121148.1767-2-ansuelsmth@gmail.com>
 <b09627a8-d928-cf5d-c765-406959138a29@mm-sol.com>
 <053d01d60da2$49e0ca60$dda25f20$@gmail.com>
 <f333d990-6d76-0e04-5949-54ffe31bc0e9@mm-sol.com>
 <000401d60da5$0669a4c0$133cee40$@gmail.com>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <98b7eba1-4ab4-8d39-655f-01d31ca12406@mm-sol.com>
Date:   Wed, 8 Apr 2020 16:06:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <000401d60da5$0669a4c0$133cee40$@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/8/20 3:55 PM, ansuelsmth@gmail.com wrote:
>> in PCIe driver
>>
>> Hi Ansuel,
>>
>> On 4/8/20 3:36 PM, ansuelsmth@gmail.com wrote:
>>>> PCIe driver
>>>>
>>>> Ansuel,
>>>>
>>>> On 4/2/20 3:11 PM, Ansuel Smith wrote:
>>>>> Aux and Ref clk are missing in pcie qcom driver.
>>>>> Add support in the driver to fix pcie inizialization in ipq806x.
>>>>>
>>>>> Fixes: 82a82383 PCI: qcom: Add Qualcomm PCIe controller driver
>>>>
>>>> this should be:
>>>>
>>>> Fixes: 82a823833f4e PCI: qcom: Add Qualcomm PCIe controller driver
>>>>
>>>> and add:
>>>>
>>>> Cc: stable@vger.kernel.org # v4.5+
>>>>
>>>> But, I wonder, as apq8064 shares the same ops_2_1_0 how it worked
>> until
>>>> now. Something more I cannot find such clocks for apq8064, which
>> means
>>>> that this patch will break it.
>>>>
>>>> One option is to use those new clocks only for ipq806x.
>>>>
>>>
>>> How to add this new clocks only for ipq806x? Check the compatible and
>> add
>>> them accordingly?
>>>
>>
>> Yes, through of_device_is_compatible(). See how we done this in
>> qcom_pcie_get_resources_2_4_0.
>>
>> I thought about second option though - encoder what clocks we have for
>> any SoC but if you take into that direction you have to change the whole
>> driver :)
>>
>> Another option is to use clk_get_optional() for the clocks which you
>> have on ipq806x (and don't have on apq8064). Please research this one
>> first.
>>
>> --
>> regards,
>> Stan
> 
> Ok I will use get optional for the extra clocks. Should I add a warning if they 
> are not present? Also what about the extra reset? Should I follow the same
> approach? 
> Thx for the suggestions. 
> 

No warnings please. You should follow the same rules for resets.

-- 
regards,
Stan
