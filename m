Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F2177E16B
	for <lists+linux-pci@lfdr.de>; Wed, 16 Aug 2023 14:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245083AbjHPMXM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 08:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245155AbjHPMWu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 08:22:50 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2172D5B
        for <linux-pci@vger.kernel.org>; Wed, 16 Aug 2023 05:22:24 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe82ac3ab4so9729063e87.1
        for <linux-pci@vger.kernel.org>; Wed, 16 Aug 2023 05:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692188543; x=1692793343;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6SVPI9u/mcgbeuFPm8+cRABDPuzkfsOkgYL/geOPsqA=;
        b=fKUrvIBIXc7qYGyW2qRezMNsy2BzcC/BIje4Wd/pGZ1GT7whw98uEvNJZyz39vcF0r
         bJfiPsIvxzeHdw4QgR9ZoKGDwb8HV0l1k7Hl0acZntx+etje3ExV1SeDBmjKnZXfjEzA
         jh18lyAkr1Dpfbhp682dYo1bz4nIjrpXRJ/hvs5nJO6c8hCVbZq2wMTB1vERT8EdRsrh
         mSOTbDGNfLEfIUOuYTOSrXGnCl2G1KHtJJrT4BFUGeAx3PyS4m79u2YavxSnXpvdkHvY
         YoIAAnFBEeOYO7omILd6Mw/qaOx18wumSbL4iPaKqzHfqH+hfF+KWjeWuhN/i+dNj+fi
         NrbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692188543; x=1692793343;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6SVPI9u/mcgbeuFPm8+cRABDPuzkfsOkgYL/geOPsqA=;
        b=EdCb4ylMkc35fzKYHOrf0vDxVlBFnvDfg4no9pQAl8GyNoITWzucfXyEpBBNs/119J
         u5DRoTK9CUSfESZ6Aa8xc/Jy7o6ijW03GtWGocdzujTRRrZMQeUIHlZKyMFckq1BRkto
         i8fdP4EXuStQXi9RvsmpoApsGcrTyakY3FOo+ruODNe+bKI7HwAJF2N1z34w4poXdYcs
         raTOWDt10e+MDt9EKkqz8gw7/kwe2t8CFqxcHCffAlAoYgFjUidKkYB1MR8DQMZIBg6m
         DZgngAM5EK/LAC/DMapdTaOW0tjqsa5Hv9PChlAAOFdcfX5QyTDApWfCcYc3lGXTOl4d
         DZKw==
X-Gm-Message-State: AOJu0YyfS+HS10rCOxxntjHejvyIkYsmTaQkj/+gbEArZuOyiZ332BqU
        GpymH2ItbOf6jYT8Sl6aJFs6yQ==
X-Google-Smtp-Source: AGHT+IFhGfy/vcTxgmHaLK2R36JKCtTnwfYbD5wD2riaRXetSdjzCBkFDJkO4ZucnZhPeQSw4cDj6A==
X-Received: by 2002:a05:6512:473:b0:4fb:780d:2a49 with SMTP id x19-20020a056512047300b004fb780d2a49mr1469833lfd.5.1692188542987;
        Wed, 16 Aug 2023 05:22:22 -0700 (PDT)
Received: from [192.168.1.101] (abxi8.neoplus.adsl.tpnet.pl. [83.9.2.8])
        by smtp.gmail.com with ESMTPSA id c11-20020ac2530b000000b004fe0fead9e2sm536419lfh.165.2023.08.16.05.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 05:22:22 -0700 (PDT)
Message-ID: <0e111aaa-705b-4ae5-a07b-32691f01cc31@linaro.org>
Date:   Wed, 16 Aug 2023 14:22:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] arm64: dts: qcom: sm8450: Add opp table support to
 PCIe
Content-Language: en-US
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     manivannan.sadhasivam@linaro.org, helgaas@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, quic_parass@quicinc.com,
        krzysztof.kozlowski@linaro.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <1692102408-7010-1-git-send-email-quic_krichai@quicinc.com>
 <1692102408-7010-3-git-send-email-quic_krichai@quicinc.com>
 <dc14acb4-9fe8-4b3b-a9da-7f7915de4d5c@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <dc14acb4-9fe8-4b3b-a9da-7f7915de4d5c@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 16.08.2023 09:05, Pavan Kondeti wrote:
> On Tue, Aug 15, 2023 at 05:56:47PM +0530, Krishna chaitanya chundru wrote:
>> PCIe needs to choose the appropriate performance state of RPMH power
>> domain based upon the PCIe gen speed.
>>
>> So, let's add the OPP table support to specify RPMH performance states.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 47 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 47 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> index 595533a..681ea9c 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> @@ -381,6 +381,49 @@
>>  		};
>>  	};
>>  
>> +	pcie0_opp_table: opp-table-pcie0 {
>> +		compatible = "operating-points-v2";
>> +
>> +		opp-2500000 {
>> +			opp-hz = /bits/ 64 <2500000>;
>> +			opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
>> +		};
>> +
>> +		opp-5000000 {
>> +			opp-hz = /bits/ 64 <5000000>;
>> +			opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
>> +		};
>> +
>> +		opp-8000000 {
>> +			opp-hz = /bits/ 64 <8000000>;
>> +			opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
>> +		};
>> +	};
>> +
>> +	pcie1_opp_table: opp-table-pcie1 {
>> +		compatible = "operating-points-v2";
>> +
>> +		opp-2500000 {
>> +			opp-hz = /bits/ 64 <2500000>;
>> +			opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
>> +		};
>> +
>> +		opp-5000000 {
>> +			opp-hz = /bits/ 64 <5000000>;
>> +			opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
>> +		};
>> +
>> +		opp-8000000 {
>> +			opp-hz = /bits/ 64 <8000000>;
>> +			opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
>> +		};
>> +
>> +		opp-16000000 {
>> +			opp-hz = /bits/ 64 <16000000>;
>> +			opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
>> +		};
>> +	};
>> +
> 
> Should not we using required-opps property to pass the
> rpmhpd_opp_xxx phandle so that when this OPP is selected based on your
> clock rate, the appropriate OPP (voltage) would be selected on the RPMH side?
Yes, opp-level is for opp providers.

Konrad
