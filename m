Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9BA7B07A4
	for <lists+linux-pci@lfdr.de>; Wed, 27 Sep 2023 17:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjI0PHB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Sep 2023 11:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjI0PHB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Sep 2023 11:07:01 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F042DF9
        for <linux-pci@vger.kernel.org>; Wed, 27 Sep 2023 08:06:59 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-503f39d3236so18411484e87.0
        for <linux-pci@vger.kernel.org>; Wed, 27 Sep 2023 08:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695827218; x=1696432018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gGcjx0T8d9ndkjDrFc6BSXcIE1q0YyUuM9qOom+Dsxo=;
        b=Lb1DFu0CDPBtlX9VyEMO69Gd0/wtNBGgoLEMqaXzwL2JMIl47sqlCUATjpI7wltjXL
         MELpALFE63vSE5DWq5uI1ugkWn6WRzrBFnHFPcZ7gqONHxWhRpD/QAKgg3dDxu2pk/tB
         fnToBlRPhfBh8YQtLmLf+FgD7BLSVBVTl8k7rgTO3+4LFyVjoZJb6dWdg5rqr+L/jPlb
         cMWlAVuZTd6kVLX/I5ubsbu4IiBR+RTf7EnyosTNK8IWuXkKC5Jt8A69HPIAbTlEnJLU
         MzJ4M0rHrn1oFf291FxL5EiVIgzJMt+ifk4Z1xHKLDro+8QMVWer6IGENGg+ReL4liad
         rUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695827218; x=1696432018;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gGcjx0T8d9ndkjDrFc6BSXcIE1q0YyUuM9qOom+Dsxo=;
        b=rCkWAKj+oJVX5AuSPaGISOR/TqNtBzYB9q2bRZDdTPiUliUYsdPY1QsabXkIMCvt5z
         KoC0J9sBKorBOyeFZxHgCGi/Y8kk3IaQ/sUfO1pW6O+NEbAwmNsOxoUXV0nu/t9FZYnF
         mwK4nx3FdpjTz5ERvuW0eeqsIP+/e4kkTrC7fbyjWTO3JAboPFdEF85NtZD6SFIR+pp7
         mZw1ykyteD0KSliHhCKvpQjhXqvlbfbVKE509Pxsb/bt8LcdLKQMm4Eok7r/t6kwAjkf
         x/yIcXjRQ12osqoXK0SgBMm7XVEC31Q8gSvAvfFwHHmq2cGq6ySSmQFyU98tsPRvMFNQ
         KIGg==
X-Gm-Message-State: AOJu0YxrS2aINb7nsT574tCbXT2i5oyIi8gIvtXxUbZ2s5+Zs7yUxqjC
        leZAaB3HzMeBUDFFgpbauHuiYg==
X-Google-Smtp-Source: AGHT+IGc+fYT4wq6gSYiJMfVSThddlYgdpMFxGS80Lq6V2WTmVtpBmq3S3/pkdIapX97XcpQ6v5AXg==
X-Received: by 2002:a05:6512:21c8:b0:500:be57:ce53 with SMTP id d8-20020a05651221c800b00500be57ce53mr1668929lft.42.1695827217984;
        Wed, 27 Sep 2023 08:06:57 -0700 (PDT)
Received: from [192.168.33.189] (178235177023.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.23])
        by smtp.gmail.com with ESMTPSA id j6-20020aa7ca46000000b0052889d090bfsm8354407edt.79.2023.09.27.08.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 08:06:57 -0700 (PDT)
Message-ID: <ea9374d9-34bc-4e9e-aba2-4ca50e5090f2@linaro.org>
Date:   Wed, 27 Sep 2023 17:06:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: qcom: Make use of QCOM_PCIE_LINK_SPEED_TO_BW()
 macro for encoding link speed
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lpieralisi@kernel.org, kw@linux.com
Cc:     andersson@kernel.org, bhelgaas@google.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, abel.vesa@linaro.org
References: <20230927145738.115843-1-manivannan.sadhasivam@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230927145738.115843-1-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 27.09.2023 16:57, Manivannan Sadhasivam wrote:
> Instead of hardcoding the link speed in MBps, let's make use of the
> existing QCOM_PCIE_LINK_SPEED_TO_BW() macro that does the encoding of the
> link speed for us.
> 
> This eliminates the need for a switch case in qcom_pcie_icc_update() and
> also works for future Gen speeds without any code modifications.
> 
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> 
> Changes in v2:
> 
> - Switched to QCOM_PCIE_LINK_SPEED_TO_BW() macro as per Bjorn's suggestion
>   https://lore.kernel.org/linux-pci/20230924160713.217086-1-manivannan.sadhasivam@linaro.org/
> 
>  drivers/pci/controller/dwc/pcie-qcom.c | 24 ++++++------------------
>  1 file changed, 6 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 297442c969b6..dce80d6dc88f 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -148,6 +148,9 @@
>  
>  #define QCOM_PCIE_CRC8_POLYNOMIAL		(BIT(2) | BIT(1) | BIT(0))
>  
> +#define QCOM_PCIE_LINK_SPEED_TO_BW(speed) \
> +		MBps_to_icc(PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]) / BITS_PER_BYTE)
Mbps_to_icc (lowercase b) is precisely that

Konrad
