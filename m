Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B7C56876C
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jul 2022 13:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbiGFLzh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jul 2022 07:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbiGFLzg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2022 07:55:36 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE1D2870D;
        Wed,  6 Jul 2022 04:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657108535; x=1688644535;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TBeCC6CuwXOAfe6GFkEG68qD/N/2tTfMoJl3F0H1S08=;
  b=d7LXPDfuXjOPnjPvOO2aHH9kUwYZ3sAyqQiiYRjVJ/F1Fb/8Pa2Rw1sS
   RSiVhY37vvNPrYSBlPc7AmcheH9zX0NwQzWB0xHguSOsX2Mm/Pd7j0A9V
   AKjARfs10tgoc2909yHdm0vFgCXv8Y7pVcMD7a1BpyVFhiujumasP7bdM
   c=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 06 Jul 2022 04:55:35 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 04:55:34 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 6 Jul 2022 04:55:33 -0700
Received: from [10.216.40.209] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 6 Jul 2022
 04:55:27 -0700
Message-ID: <9de4c3a0-eb95-f4e9-b828-2343241fff41@quicinc.com>
Date:   Wed, 6 Jul 2022 17:25:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 2/3] dt-bindings: pci: QCOM Adding sc7280 aggre0,
 aggre1 clocks
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mka@chromium.org>,
        <quic_vbadigan@quicinc.com>, <quic_hemantk@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_ramkri@quicinc.com>, <manivannan.sadhasivam@linaro.org>,
        <swboyd@chromium.org>, <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <1656062391-14567-1-git-send-email-quic_krichai@quicinc.com>
 <1656691899-21315-1-git-send-email-quic_krichai@quicinc.com>
 <1656691899-21315-3-git-send-email-quic_krichai@quicinc.com>
 <1fb5f0c6-ff72-b9ba-175a-b5197ed658a7@linaro.org>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <1fb5f0c6-ff72-b9ba-175a-b5197ed658a7@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 7/4/2022 1:54 PM, Krzysztof Kozlowski wrote:
> On 01/07/2022 18:11, Krishna chaitanya chundru wrote:
>> Adding aggre0 and aggre1 clock entries to PCIe node.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> index 0b69b12..8f29bdd 100644
>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> @@ -423,8 +423,8 @@ allOf:
>>       then:
>>         properties:
>>           clocks:
>> -          minItems: 11
>> -          maxItems: 11
>> +          minItems: 13
>> +          maxItems: 13
>>           clock-names:
>>             items:
>>               - const: pipe # PIPE clock
>> @@ -437,6 +437,8 @@ allOf:
>>               - const: bus_slave # Slave AXI clock
>>               - const: slave_q2a # Slave Q2A clock
>>               - const: tbu # PCIe TBU clock
>> +            - const: aggre0 # Aggre NoC PCIe CENTER SF AXI clock
>> +            - const: aggre1 # Aggre NoC PCIe1 AXI clock
> You ignored my comments from v1 - please don't. This is not accepted.
>
> Also, please do not send new versions of patchset as reply to some other
> threads. It's extremely confusing to find it under something else.
>
> Best regards,
> Krzysztof
Hi

Krzysztof,

Sorry for confusion created which replying this patch.

The only comment I got from v1 from you is to run make dtbs_check.

I ran that command I found the errors and fixed them and I ran the make dtbs_check again
before on v2 and made sure there are no errors.

Can you please tell me is there any steps I missed.

Thanks & Regards,
Krishna Chaitanya.

