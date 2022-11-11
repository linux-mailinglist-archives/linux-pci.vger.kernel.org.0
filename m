Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E706254A5
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 08:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbiKKHw0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 02:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiKKHwZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 02:52:25 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6ED729A2
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 23:52:24 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id t10so3678228ljj.0
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 23:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UonFxrxEHNRT7dQxMfsoWgYCp7tQZ3VqigDYmxXre5c=;
        b=TxPMAsmgCgbOAblE6d4J8lIy6ZeOTnCPejWxIHJFagPwJyTRK3H0c0QBaX5M9lbzJc
         WabT1eLlN6Q2Cmi8C3SafG5czNJhlBTH7F1oT+Iu01HA6Rxcpa1FipXr7jtp9gG+p2mr
         7+Fv3H9pwd4Yvk85YlgdexoI8Q9Q4lVR7aY9PPrjRko4jiZ8RH50Wf6MzGU/pGLfgwb4
         Vv8ts8GUbC0l4a/qLFUGa7ZO19aSDRSlngIy+IN8CCua4exyr3iTptFLHrc1IgKaKyfc
         niGF0D5uE4JFqdLobmQ5qOWwPmYQvVu8HqcPD+SQz+/Vp70+yc1ZKykMCFAS91iG0U6f
         puOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UonFxrxEHNRT7dQxMfsoWgYCp7tQZ3VqigDYmxXre5c=;
        b=6mbgyEoWkqcAqfjHU34ZBwWGRQBZNWvBXEK+8Hw7ygpvKbB5n1sLYzrJxmGpt2v7rc
         64KMHhkwkI1sXVdisNQeVGaUqWDATouRCMVU2TGMmplpTuR7SxWYLfWLpv9B2JxQowKX
         zGAlfqwIe6QNUoUopQB2K7DhuPiPmq0+7dn4+oGgpuNy8tu7PogzDaJ0B4HI0QyH0Zcx
         OeZq5OOeUAmq32V0D6nj1ouWy/qnauWywrlUIb8dT58xfkZTm0qyAnOTlHZN+95Cum9k
         PBnRjP+A0zCLLrqKYQRr8xK2ft6aaSgn6bLyPMvCpVl68CmB0CHhPZ1XIO1LHBFRFbJR
         lLSQ==
X-Gm-Message-State: ANoB5pmo0kxSb7HUclzmbU7qJbStDWIEY1HAm1L9Gxohd4LiSidImEAA
        rqGZSqoyEQrauundEyJbQ2hiPQ==
X-Google-Smtp-Source: AA0mqf7cMlZsB6gTVcySqaEcRV+3CQR1r5YQapFjd7NQg3nNBtrG+k9wawSobMEb9qSy5NSOQ6Wksw==
X-Received: by 2002:a2e:9d85:0:b0:277:115a:1acb with SMTP id c5-20020a2e9d85000000b00277115a1acbmr297806ljj.350.1668153142652;
        Thu, 10 Nov 2022 23:52:22 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id o18-20020a2e0c52000000b00277351f7145sm257777ljd.105.2022.11.10.23.52.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 23:52:21 -0800 (PST)
Message-ID: <ff456d4f-44dd-b6d1-4a7f-170faeec68ab@linaro.org>
Date:   Fri, 11 Nov 2022 08:52:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 2/2] dt-bindings: PCI: xilinx-nwl: Convert to YAML
 schemas of Xilinx NWL PCIe Root Port Bridge
Content-Language: en-US
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     bhelgaas@google.com, michals@xilinx.com, robh+dt@kernel.org,
        nagaradhesh.yeleswarapu@amd.com, bharat.kumar.gogada@amd.com
References: <20221111053709.1474323-1-thippeswamy.havalige@amd.com>
 <20221111053709.1474323-2-thippeswamy.havalige@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221111053709.1474323-2-thippeswamy.havalige@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/11/2022 06:37, Thippeswamy Havalige wrote:
> Convert to YAML schemas for Xilinx NWL PCIe Root Port Bridge
> dt binding.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> ---
> changes in v6:
> Added maxItems to clocks property.

Where is the rest of the changelog? There were no changes between v1-v6?
> 
>  .../bindings/pci/xilinx-nwl-pcie.txt          |  73 ---------
>  .../bindings/pci/xlnx,nwl-pcie.yaml           | 149 ++++++++++++++++++


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

