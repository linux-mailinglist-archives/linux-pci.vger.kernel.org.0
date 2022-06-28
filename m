Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9B555D8F2
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343545AbiF1Gnm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 02:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236257AbiF1Gnl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 02:43:41 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D01D12ACE;
        Mon, 27 Jun 2022 23:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656398620; x=1687934620;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bjiMPtIDOxLn13ZNTZ0W8DPjgpykVkfABWg8ouNBT90=;
  b=KR3byVAfRVNn4apD8S5/2sp0N4TehYG8b37CyPgKeHM0m2SI6RllGSQG
   BZShG7XBVKeMTdI+TU+9OuHc/WviH8ySbF2A7BOHPsRwFDKCMUk8vZia9
   CuNanMhfw+TvjHoKiia7FsZKGkRxC6da0AH3IOZdrfMezqfEVLrXIVrUb
   M=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Jun 2022 23:43:40 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 23:43:39 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 27 Jun 2022 23:43:39 -0700
Received: from [10.216.62.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 27 Jun
 2022 23:43:32 -0700
Message-ID: <ac08061c-3e33-2263-27f9-f455d06f6ce8@quicinc.com>
Date:   Tue, 28 Jun 2022 12:13:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 2/3] dt-bindings: pci: QCOM sc7280 add missing clocks.
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_hemantk@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_ramkri@quicinc.com>,
        <manivannan.sadhasivam@linaro.org>, <swboyd@chromium.org>,
        <dmitry.baryshkov@linaro.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20220624165813.GA1541013@bhelgaas>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20220624165813.GA1541013@bhelgaas>
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


On 6/24/2022 10:28 PM, Bjorn Helgaas wrote:
> On Fri, Jun 24, 2022 at 02:49:50PM +0530, Krishna chaitanya chundru wrote:
>> Add missing clocks.
> When you revise this, please make your subject line match the history:
>
>    dt-bindings: PCI: qcom: Add schema for sc7280 chipset
>    dt-bindings: PCI: qcom: Specify reg-names explicitly
>    dt-bindings: PCI: qcom: Do not require resets on msm8996 platforms
>    dt-bindings: PCI: qcom: Convert to YAML
>
> So your subject line should be something like:
>
>    dt-bindings: PCI: qcom: Add sc7280 aggre0 and aggre1 clocks
>
> Please also include the names of the clocks you're adding in the
> commit log.  This will make the commit log history more specific and
> useful for future readers.
>
> This also applies to the other patches.
Thanks Bjorn, I will try to incorporate your comments in the next patch.
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> index 0b69b12..313b981 100644
>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> @@ -438,6 +438,8 @@ allOf:
>>               - const: slave_q2a # Slave Q2A clock
>>               - const: tbu # PCIe TBU clock
>>               - const: ddrss_sf_tbu # PCIe SF TBU clock
>> +            - const: aggre0 # Aggre NoC PCIE CENTER SF AXI clock
>> +            - const: aggre1 # Aggre NoC PCIe1 AXI clock
> I assume the stuff after "#" is comment and could thus be made
> consistent: s/PCIE/PCIe/, is "PCIe1" a typo for "PCIe" or different?
> Seems like weird/inconsistent capitalization in general ("CENTER"),
> but if you're matching language in a spec, please do that and ignore
> my comment :)
>
>>           resets:
>>             maxItems: 1
>>           reset-names:
>> -- 
>> 2.7.4
>>
