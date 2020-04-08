Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1CC21A2247
	for <lists+linux-pci@lfdr.de>; Wed,  8 Apr 2020 14:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgDHMsQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Apr 2020 08:48:16 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:35254 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbgDHMsQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Apr 2020 08:48:16 -0400
Received: from [192.168.1.4] (212-5-158-69.ip.btc-net.bg [212.5.158.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 2E464CFB4;
        Wed,  8 Apr 2020 15:48:13 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1586350093; bh=7Eg3xvLl6DWrQSTLQ5XS22kCIbNhJ7asYuWQixzAxzM=;
        h=Subject:To:Cc:From:Date:From;
        b=HW8cDe6J1+QmHwi6fmWhIP6x0p70d1zdLRBOWnb7rcaMZtnPoaaoeL6Z80sxdGcwF
         AlamXw9UkQ8ZnLZUPWo5LPgFCjOl77+4sTbEcex9SX6NSujwc2Wxa28Q5h1CZQ2Rgu
         2zIEFVy5ZW6LnSbWdxoFQgYxzkkGQLRUUsMilgXjlgEl0q1bglgPENDdieXBaqRpTr
         R6usio8NhmQ8/isGjK3MAmPQK4o7PqTbspsSbcZ4M2nc0Hlm8QBtfQK3E8RW8R3cSe
         tB/QJW9AyiD+Xeu1CylzGp/OYkpKDExTcMFeb1pVgdJ3zFGcnDFXni0Zp9Zs7DBZp+
         W70orzuwpRpcg==
Subject: Re: R: [PATCH v2 01/10] PCIe: qcom: add missing ipq806x clocks in
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
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <f333d990-6d76-0e04-5949-54ffe31bc0e9@mm-sol.com>
Date:   Wed, 8 Apr 2020 15:48:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <053d01d60da2$49e0ca60$dda25f20$@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ansuel,

On 4/8/20 3:36 PM, ansuelsmth@gmail.com wrote:
>> PCIe driver
>>
>> Ansuel,
>>
>> On 4/2/20 3:11 PM, Ansuel Smith wrote:
>>> Aux and Ref clk are missing in pcie qcom driver.
>>> Add support in the driver to fix pcie inizialization in ipq806x.
>>>
>>> Fixes: 82a82383 PCI: qcom: Add Qualcomm PCIe controller driver
>>
>> this should be:
>>
>> Fixes: 82a823833f4e PCI: qcom: Add Qualcomm PCIe controller driver
>>
>> and add:
>>
>> Cc: stable@vger.kernel.org # v4.5+
>>
>> But, I wonder, as apq8064 shares the same ops_2_1_0 how it worked until
>> now. Something more I cannot find such clocks for apq8064, which means
>> that this patch will break it.
>>
>> One option is to use those new clocks only for ipq806x.
>>
> 
> How to add this new clocks only for ipq806x? Check the compatible and add
> them accordingly? 
> 

Yes, through of_device_is_compatible(). See how we done this in
qcom_pcie_get_resources_2_4_0.

I thought about second option though - encoder what clocks we have for
any SoC but if you take into that direction you have to change the whole
driver :)

Another option is to use clk_get_optional() for the clocks which you
have on ipq806x (and don't have on apq8064). Please research this one
first.

-- 
regards,
Stan
