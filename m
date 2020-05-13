Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDFB1D11AB
	for <lists+linux-pci@lfdr.de>; Wed, 13 May 2020 13:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730892AbgEMLn0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 May 2020 07:43:26 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:33783 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730865AbgEMLn0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 May 2020 07:43:26 -0400
Received: from [192.168.1.2] (212-5-158-106.ip.btc-net.bg [212.5.158.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 9C99ECF91;
        Wed, 13 May 2020 14:43:22 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1589370203; bh=SfnCIB+8RFBof4rOiXKZEaO1H4Zs48OzWFikIfT1iwQ=;
        h=Subject:To:Cc:From:Date:From;
        b=TG2XL/Lz+6wKPzf06k6uckSQT66ndTZ1r1+kKU7cOezGqpnPjSF26SMuR02fm/M+z
         gwN2M1aaB1stRmsmmmGRGdrmvS3Sdycjc5/r0MOSzPkvgby3hl79aeF7JlDzIybZq5
         +vlWZrLULb0105fVqQpL/230Zp0eGCTCIl1oMm2rw7QUJGV4XJLwNEon4QwdRXdoP+
         VDE6otKk9QjNaoMaoWnpaNOmW38mXTtqz+aM9gxjNzKcgwL8DbrwAEUD1Le9NKmNBs
         NkCjPEYfa2+wEpX8EUffhfbT1OS9RMT2rFXja3EJZ1xL0HBBH0i0JChMhW7+la+qJO
         p5XGs0TOaKsMQ==
Subject: Re: R: [PATCH v3 08/11] devicetree: bindings: pci: document PARF
 params bindings
To:     Rob Herring <robh@kernel.org>, ansuelsmth@gmail.com
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
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <99f42001-0f41-5e63-f6ad-2e744ec86d36@mm-sol.com>
Date:   Wed, 13 May 2020 14:43:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200512154544.GA823@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/12/20 6:45 PM, Rob Herring wrote:
> On Thu, May 07, 2020 at 09:34:35PM +0200, ansuelsmth@gmail.com wrote:
>>> On Fri, May 01, 2020 at 12:06:15AM +0200, Ansuel Smith wrote:
>>>> It is now supported the editing of Tx De-Emphasis, Tx Swing and
>>>> Rx equalization params on ipq8064. Document this new optional params.
>>>>
>>>> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
>>>> ---
>>>>  .../devicetree/bindings/pci/qcom,pcie.txt     | 36 +++++++++++++++++++
>>>>  1 file changed, 36 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>>> b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>>>> index 6efcef040741..8cc5aea8a1da 100644
>>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>>>> @@ -254,6 +254,42 @@
>>>>  			- "perst-gpios"	PCIe endpoint reset signal line
>>>>  			- "wake-gpios"	PCIe endpoint wake signal line
>>>>
>>>> +- qcom,tx-deemph-gen1:
>>>> +	Usage: optional (available for ipq/apq8064)
>>>> +	Value type: <u32>
>>>> +	Definition: Gen1 De-emphasis value.
>>>> +		    For ipq806x should be set to 24.
>>>
>>> Unless these need to be tuned per board, then the compatible string for
>>> ipq806x should imply all these settings.
>>>
>>
>> It was requested by v2 to make this settings tunable. These don't change are
>> all the same for every ipq806x SoC. The original implementation had this 
>> value hardcoded for ipq806x. Should I restore this and drop this patch?
> 
> Yes, please.

I still think that the values for tx deemph and tx swing should be
tunable. But I can live with them in the driver if they not break
support for apq8064.

The default values in the registers for apq8064 and ipq806x are:

			default		your change
TX_DEEMPH_GEN1		21		24
TX_DEEMPH_GEN2_3_5DB	21		24
TX_DEEMPH_GEN2_6DB	32		34

TX_SWING_FULL		121		120
TX_SWING_LOW		121		120

So until now (without your change) apq8064 worked with default values.

> 
> Rob
> 

-- 
regards,
Stan
