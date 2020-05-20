Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1AB1DAF92
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 12:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgETKCA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 06:02:00 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:47008 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgETKCA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 May 2020 06:02:00 -0400
Received: from [192.168.1.4] (212-5-158-12.ip.btc-net.bg [212.5.158.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 90A62CFEB;
        Wed, 20 May 2020 13:01:57 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1589968918; bh=DzcUAhFL6G6Vzz7vTvgr6Z/dAJBJLJKn2F3Wqs3Pvzo=;
        h=Subject:To:Cc:From:Date:From;
        b=E0onSRN5ou33/t/JrfYkn/kTvcKP3EdES429TX7TYKkOGaqg/2jk0NJFlz6/t9qIe
         +8l2DqFT36DdjVm0Zm0te3gQh4cZCUTgMra5XppOYwsnwQQi4qykoQtZXAQvj/97c6
         AA9lGia5yEOlDUBqZOfPgL1uSOuiWtt4Brq1vMgHK5wzAQGkdErBX6QrQzN9hdYt0R
         JbBwp0Fa/No29c1jstjT4fyRTKVt6QUktBYsBoFHdfBLd/3XpCgCf+71q8to4XcIuo
         +Jvy4Geib5IGjUkmou+R8LjWvUM2d8LjMicd9Cm3QnkUBK0BffKZ46vuyoJsNNtgmu
         2hXlM0KaDbkiQ==
Subject: Re: R: R: [PATCH v3 08/11] devicetree: bindings: pci: document PARF
 params bindings
To:     ansuelsmth@gmail.com, 'Rob Herring' <robh@kernel.org>
Cc:     'Bjorn Andersson' <bjorn.andersson@linaro.org>,
        'Andy Gross' <agross@kernel.org>,
        'Bjorn Helgaas' <bhelgaas@google.com>,
        'Mark Rutland' <mark.rutland@arm.com>,
        'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>,
        'Andrew Murray' <amurray@thegoodpenguin.co.uk>,
        'Philipp Zabel' <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200430220619.3169-1-ansuelsmth@gmail.com>
 <20200430220619.3169-9-ansuelsmth@gmail.com> <20200507181044.GA15159@bogus>
 <062301d624a6$8be610d0$a3b23270$@gmail.com> <20200512154544.GA823@bogus>
 <99f42001-0f41-5e63-f6ad-2e744ec86d36@mm-sol.com>
 <02e001d62925$dca9e9a0$95fdbce0$@gmail.com>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <72c588ec-5dd3-6c8a-5ebf-1e01bf2fa96a@mm-sol.com>
Date:   Wed, 20 May 2020 13:01:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <02e001d62925$dca9e9a0$95fdbce0$@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 5/13/20 3:56 PM, ansuelsmth@gmail.com wrote:
>> On 5/12/20 6:45 PM, Rob Herring wrote:
>>> On Thu, May 07, 2020 at 09:34:35PM +0200, ansuelsmth@gmail.com
>> wrote:
>>>>> On Fri, May 01, 2020 at 12:06:15AM +0200, Ansuel Smith wrote:
>>>>>> It is now supported the editing of Tx De-Emphasis, Tx Swing and
>>>>>> Rx equalization params on ipq8064. Document this new optional
>> params.
>>>>>>
>>>>>> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
>>>>>> ---
>>>>>>  .../devicetree/bindings/pci/qcom,pcie.txt     | 36
>> +++++++++++++++++++
>>>>>>  1 file changed, 36 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>>>>> b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>>>>>> index 6efcef040741..8cc5aea8a1da 100644
>>>>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>>>>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>>>>>> @@ -254,6 +254,42 @@
>>>>>>  			- "perst-gpios"	PCIe endpoint reset signal line
>>>>>>  			- "wake-gpios"	PCIe endpoint wake signal line
>>>>>>
>>>>>> +- qcom,tx-deemph-gen1:
>>>>>> +	Usage: optional (available for ipq/apq8064)
>>>>>> +	Value type: <u32>
>>>>>> +	Definition: Gen1 De-emphasis value.
>>>>>> +		    For ipq806x should be set to 24.
>>>>>
>>>>> Unless these need to be tuned per board, then the compatible string
>> for
>>>>> ipq806x should imply all these settings.
>>>>>
>>>>
>>>> It was requested by v2 to make this settings tunable. These don't change
>> are
>>>> all the same for every ipq806x SoC. The original implementation had this
>>>> value hardcoded for ipq806x. Should I restore this and drop this patch?
>>>
>>> Yes, please.
>>
>> I still think that the values for tx deemph and tx swing should be
>> tunable. But I can live with them in the driver if they not break
>> support for apq8064.
>>
>> The default values in the registers for apq8064 and ipq806x are:
>>
>> 			default		your change
>> TX_DEEMPH_GEN1		21		24
>> TX_DEEMPH_GEN2_3_5DB	21		24
>> TX_DEEMPH_GEN2_6DB	32		34
>>
>> TX_SWING_FULL		121		120
>> TX_SWING_LOW		121		120
>>
>> So until now (without your change) apq8064 worked with default values.
>>
> 
> I will limit this to ipq8064(-v2) if this could be a problem.

I guess you can do it that way, but if new board appear in the future
with slightly different parameters (for example deemph_gen1 = 23 and so
on) do we need to add another compatible for that? At the end we will
have compatibles per board but not per SoC. :(

-- 
regards,
Stan
