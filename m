Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE1D1D166A
	for <lists+linux-pci@lfdr.de>; Wed, 13 May 2020 15:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388478AbgEMNtT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 May 2020 09:49:19 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:45375 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388095AbgEMNtS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 May 2020 09:49:18 -0400
Received: from [192.168.1.2] (212-5-158-106.ip.btc-net.bg [212.5.158.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 98D7ACFDC;
        Wed, 13 May 2020 16:49:13 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1589377754; bh=MPuMCjwAK4ickFvEAphG1V4j7sZJqS/FOfNLWab/sXY=;
        h=Subject:To:Cc:From:Date:From;
        b=jW7AnQalVZhBRrCArUUEHXqkzTpbf89eh/IqpUobGlDwwvMUGRc25od3FH3/E6Wz4
         FxWYcdIsD5Bspw+tenmZdUDFeoHMj3Gtj58jpi10n9FnTgWcwYNVt2N+r6nAPGem6e
         4B1Lf0CO3RrR/ZzrTJ4e7q4jr9WFv27HZ3P8dDEZd6ExSMdY8kKLizwyCYTsLUBhvh
         K8PDLra+t6pxilv/ZaiIgq797KaSt4I8i6bvK0anHcKGrsRahHjhq88Bsuh1hwaFhi
         myYfx9JHkkAUhk85REV/NHhKpRHs6F+i3HPtuRXwwEnAQ1Op7sQVSYmaPKZkv1JGlc
         e+It4iaLsf1iw==
Subject: Re: R: [PATCH v3 09/11] PCI: qcom: add ipq8064 rev2 variant and set
 tx term offset
To:     ansuelsmth@gmail.com,
        'Bjorn Andersson' <bjorn.andersson@linaro.org>
Cc:     'Sham Muthayyan' <smuthayy@codeaurora.org>,
        'Andy Gross' <agross@kernel.org>,
        'Bjorn Helgaas' <bhelgaas@google.com>,
        'Rob Herring' <robh+dt@kernel.org>,
        'Mark Rutland' <mark.rutland@arm.com>,
        'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>,
        'Andrew Murray' <amurray@thegoodpenguin.co.uk>,
        'Philipp Zabel' <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200430220619.3169-1-ansuelsmth@gmail.com>
 <20200430220619.3169-10-ansuelsmth@gmail.com>
 <3dc89ec6-d550-9402-1a4a-ca0c6f1e1fb9@mm-sol.com>
 <02df01d62925$acd160a0$067421e0$@gmail.com>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <37ddf6ac-43c8-f2f1-ce53-e0959084b77c@mm-sol.com>
Date:   Wed, 13 May 2020 16:49:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <02df01d62925$acd160a0$067421e0$@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/13/20 3:54 PM, ansuelsmth@gmail.com wrote:
>> Hi Ansuel,
>>
>> On 5/1/20 1:06 AM, Ansuel Smith wrote:
>>> From: Sham Muthayyan <smuthayy@codeaurora.org>
>>>
>>> Add tx term offset support to pcie qcom driver need in some revision of
>>> the ipq806x SoC.
>>> Ipq8064 have tx term offset set to 7.
>>> Ipq8064-v2 revision and ipq8065 have the tx term offset set to 0.
>>>
>>> Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
>>> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
>>> ---
>>>  drivers/pci/controller/dwc/pcie-qcom.c | 15 +++++++++++++++
>>>  1 file changed, 15 insertions(+)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c
>> b/drivers/pci/controller/dwc/pcie-qcom.c
>>> index da8058fd1925..372d2c8508b5 100644
>>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>>> @@ -45,6 +45,9 @@
>>>  #define PCIE_CAP_CPL_TIMEOUT_DISABLE		0x10
>>>
>>>  #define PCIE20_PARF_PHY_CTRL			0x40
>>> +#define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	GENMASK(12,
>> 16)
>>
>> The mask definition is not correct. Should be GENMASK(20, 16)
>>
>>> +#define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		((x) << 16)
>>> +
>>>  #define PCIE20_PARF_PHY_REFCLK			0x4C
>>>  #define PHY_REFCLK_SSP_EN			BIT(16)
>>>  #define PHY_REFCLK_USE_PAD			BIT(12)
>>> @@ -118,6 +121,7 @@ struct qcom_pcie_resources_2_1_0 {
>>>  	u32 tx_swing_full;
>>>  	u32 tx_swing_low;
>>>  	u32 rx0_eq;
>>> +	u8 phy_tx0_term_offset;
>>>  };
>>>
>>>  struct qcom_pcie_resources_1_0_0 {
>>> @@ -318,6 +322,11 @@ static int
>> qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
>>>  	if (IS_ERR(res->ext_reset))
>>>  		return PTR_ERR(res->ext_reset);
>>>
>>> +	if (of_device_is_compatible(dev->of_node, "qcom,pcie-ipq8064"))
>>> +		res->phy_tx0_term_offset = 7;
>>
>> Before your change the phy_tx0_term_offser was 0 for apq8064, but here
>> you change it to 7, why?
>>
> 
> apq8064 board should use qcom,pcie-apq8064 right? This should be set to 0
> only with pcie-ipq8064 compatible. Tell me if I'm wrong.

Sorry, my fault. I read the compatible check above as apq8064 but it is ipq.

-- 
regards,
Stan
