Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4987F52EB4A
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 13:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243134AbiETL5L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 May 2022 07:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346192AbiETL5K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2022 07:57:10 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02863A72C
        for <linux-pci@vger.kernel.org>; Fri, 20 May 2022 04:57:08 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id p4so12516155lfg.4
        for <linux-pci@vger.kernel.org>; Fri, 20 May 2022 04:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aQO1V+ULbK6HnLmRz4+dAgX1ZelMK6DTrDB9rKPDBdE=;
        b=R4gIgyE0Fq1KL0ppCpOZ2WD3L5sHb2LSBkzt2ZkK7fn9FWWRRJYb1l21cKw255gOeL
         sr4EH+8X9osZcXkxMppwl3Jp60NAmzbnJqabzjM6scxrgZ0Uv/Ocs1pt7diyFmmjni9K
         zPq+d8LQdRnuu/BaMaWmbn3iQUOaiG8yAhpJ8mrYjikNOJf3prgo/ebynzqZcNcpfvt2
         uNOR6U41iIO9+s94fZVq9uF5zzqeDjc3WfQ56CZ8rM39peTXDOgPx/AlIfxVNWrFPHPv
         uknuvFPqhCNRkjaz6dQOwfDRij0sw42di9tjol6WTRqGkqAoBShHVnL4FHbEH97EeSNw
         1SFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aQO1V+ULbK6HnLmRz4+dAgX1ZelMK6DTrDB9rKPDBdE=;
        b=SQFTaB0IqA9uW1gLVxdXPRCgNDK6eecANSTNf4WpeIPoliCJYpryP3usCb0tBYo+zI
         +JKXkvmdq8RrbOMmAF8Ggy15LuUbIqVW/QYLxR0zA8FTv2PjKXvvR2A+MK+nKNAk94r6
         eG12hFJBNH4aB9p4ZlwVsYuDPdXFmEg33Ae3gMZR+SVVc6ip+eDoegUPZPcow3qioIBJ
         o+aFQ+AcMlCyaw76TTGV/mDgAmc5AHw2wzE8xQp0FX0A8d+nXyeqKzfOK/C1fPFfsjqh
         Fq2j9Pp9CbpbYAZkb3iEbwQfu0qOt1PN+5avhGUy12YkRlpPZ12m4v791IUA25jGrLoy
         cZLw==
X-Gm-Message-State: AOAM533gr8NAmH1r1BFgpsxYNQPQvIEN8DE+mEmtuJYPB9zmxj3vLkdo
        y8kewdSjyW/OdNhGNzuuUzk74w==
X-Google-Smtp-Source: ABdhPJwd3jijwcn2oENRbeAT+r07YHuDaxXCLuOmUpfHl3mvJ3znj36PI72Ylv4takJNsdxEAgAubw==
X-Received: by 2002:a05:6512:32c7:b0:471:f727:7e20 with SMTP id f7-20020a05651232c700b00471f7277e20mr6984576lfg.281.1653047827317;
        Fri, 20 May 2022 04:57:07 -0700 (PDT)
Received: from ?IPV6:2001:470:dd84:abc0::8a5? ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id 21-20020ac24835000000b0047255d210e9sm636324lft.24.2022.05.20.04.57.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 04:57:06 -0700 (PDT)
Message-ID: <581f8459-38c3-a18e-ea58-b81b9bf430dd@linaro.org>
Date:   Fri, 20 May 2022 14:57:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v10 02/10] PCI: dwc: Propagate error from
 dma_mapping_error()
Content-Language: en-GB
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
References: <20220513172622.2968887-1-dmitry.baryshkov@linaro.org>
 <20220513172622.2968887-3-dmitry.baryshkov@linaro.org>
 <YoS80vek6UrN1XbG@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <YoS80vek6UrN1XbG@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 18/05/2022 12:30, Johan Hovold wrote:
> On Fri, May 13, 2022 at 08:26:14PM +0300, Dmitry Baryshkov wrote:
>> If dma mapping fails, dma_mapping_error() will return an error.
>> Propagate it to the dw_pcie_host_init() return value rather than
>> incorrectly returning 0 in this case.
>>
>> Fixes: 07940c369a6b ("PCI: dwc: Fix MSI page leakage in suspend/resume")
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   drivers/pci/controller/dwc/pcie-designware-host.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index 2fa86f32d964..a9a31e9e7b6e 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -396,8 +396,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
>>   						      sizeof(pp->msi_msg),
>>   						      DMA_FROM_DEVICE,
>>   						      DMA_ATTR_SKIP_CPU_SYNC);
>> -			if (dma_mapping_error(pci->dev, pp->msi_data)) {
>> -				dev_err(pci->dev, "Failed to map MSI data\n");
>> +			ret = dma_mapping_error(pci->dev, pp->msi_data);
>> +			if (ret) {
>> +				dev_err(pci->dev, "Failed to map MSI data: %d\n", ret);
>>   				pp->msi_data = 0;
>>   				goto err_free_msi;
>>   			}
> 
> This has already been fixed by commit 88557685cd72 ("PCI: dwc: Fix
> setting error return on MSI DMA mapping failure"), which prevents the
> series from applying cleanly.

Ack, will rebase and send.

> 
> Johan


-- 
With best wishes
Dmitry
