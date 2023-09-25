Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C7F7AD613
	for <lists+linux-pci@lfdr.de>; Mon, 25 Sep 2023 12:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjIYKfE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Sep 2023 06:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjIYKfE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Sep 2023 06:35:04 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389E0A3
        for <linux-pci@vger.kernel.org>; Mon, 25 Sep 2023 03:34:57 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9ad8bf9bfabso764940666b.3
        for <linux-pci@vger.kernel.org>; Mon, 25 Sep 2023 03:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695638095; x=1696242895; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QeiscEmudwX6iiv93Ap/+0Zo6O9kpRXW1Uvz3CHutP8=;
        b=jSkc+fCfLAsecscoLI9FBb97bcdHrzluVoezWRD9ytOAEMmqAm+/cYRV0pVLc3cxQf
         iHos+aTmOnGinypCVd8kEvk7GVz25f+0jfOZ4T1ivhq0qNwQSELO3oDqVi8LaIuhRfW6
         FcgaX3OkLA+jBdSHc7ZdRKVgd/RXXhDLeyspeO0B8qLjCHckfVTrwRXGd8Wga8lkPYa7
         tsb9LsoPl/CLeowOfdrMdDRoy+NbEm9Sgqv4IThG/cKYjR9gwr2M6szt/Hec7qHiq6ur
         PMfwtn9XQRPS3P4+IFwBoRpi6cTuQTTl1riaV8SMyACdPBaMmYqbPSKMzzS+tOJImxQa
         miXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695638095; x=1696242895;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QeiscEmudwX6iiv93Ap/+0Zo6O9kpRXW1Uvz3CHutP8=;
        b=mCm1ug9uDblrWV8OxNNVMwPRPfDZIiFDsfUHQ5eUDc/De5wbpYi1VBYYr8ca9YF2L0
         oBRK9fCFM8SX9aTx/e1MzxWwu+AN4kglB8EvrUhRsDEiqA2xOk4a6y6pNrhCwmI+tEV8
         4K/PCdpdP7eS0xYikFtkoMJ7bPSiD4qUc2M8b4UocLZaOLvHpWcUOB2avRNEPlvusBzh
         TVvdDahS2ywN6dLZsbsCFiWOpKA31mvtHF7YcULPO7xRvp/NuYMdIqt0A3J9m8qPfu1Q
         OzOzs1n7GiDi/fdnFMzyVs0UbTS6hJ9WHwecP2IyjJtPpOB5VkcvsdALSfyE5N2nZThM
         f/JQ==
X-Gm-Message-State: AOJu0YySUtb4H2xb9BUi4FlTW0szQNb63yPCbzql1W304AyAnu5lc0Yp
        EUCFDp8Kd+S3/T1yRwb7YaxEWQ==
X-Google-Smtp-Source: AGHT+IGdzJ6S3kHEtt5ckQm/BFopsVoBenSBgYO4j82KZW7pQYgzunIacFQVVb6Aw/MiRKZqZq16pg==
X-Received: by 2002:a17:907:77c7:b0:9ae:5a9f:6aa0 with SMTP id kz7-20020a17090777c700b009ae5a9f6aa0mr5178905ejc.33.1695638095705;
        Mon, 25 Sep 2023 03:34:55 -0700 (PDT)
Received: from [192.168.101.165] (178235177023.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.23])
        by smtp.gmail.com with ESMTPSA id g13-20020a170906594d00b009a1b857e3a5sm6120674ejr.54.2023.09.25.03.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 03:34:55 -0700 (PDT)
Message-ID: <18635bed-b7e3-4acb-b176-cd9f87a35c7f@linaro.org>
Date:   Mon, 25 Sep 2023 12:34:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: qcom: Add interconnect bandwidth for PCIe Gen4
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lpieralisi@kernel.org, kw@linux.com, andersson@kernel.org,
        bhelgaas@google.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230924160713.217086-1-manivannan.sadhasivam@linaro.org>
 <f49d0543-17bb-4105-9cdf-3df8c116481a@linaro.org>
 <ZRFiD3EXwZI/B8JB@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ZRFiD3EXwZI/B8JB@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 25.09.2023 12:33, Abel Vesa wrote:
> On 23-09-25 10:57:47, Konrad Dybcio wrote:
>> On 24.09.2023 18:07, Manivannan Sadhasivam wrote:
>>> PCIe Gen4 supports the interconnect bandwidth of 1969 MBps. So let's add
>>> the bandwidth support in the driver. Otherwise, the default bandwidth of
>>> 985 MBps will be used.
>>>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>> ---
>>>  drivers/pci/controller/dwc/pcie-qcom.c | 7 +++++--
>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>>> index 297442c969b6..6853123f92c1 100644
>>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>>> @@ -1384,11 +1384,14 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
>>>  	case 2:
>>>  		bw = MBps_to_icc(500);
>>>  		break;
>>> +	case 3:
>>> +		bw = MBps_to_icc(985);
>>> +		break;
>>>  	default:
>>>  		WARN_ON_ONCE(1);
>>>  		fallthrough;
>>> -	case 3:
>>> -		bw = MBps_to_icc(985);
>>> +	case 4:
>>> +		bw = MBps_to_icc(1969);
>>>  		break;
>> Are you adding case 4 under `default`? That looks.. bizzare..
> 
> That's intentional. You want it to use 1969MBps if there is a different
> gen value. AFAIU.
Gah right, then the commit message is wrong.

Konrad
