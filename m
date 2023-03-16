Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB73A6BDC08
	for <lists+linux-pci@lfdr.de>; Thu, 16 Mar 2023 23:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjCPWvS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Mar 2023 18:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjCPWvR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Mar 2023 18:51:17 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E305C114;
        Thu, 16 Mar 2023 15:51:17 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id s7so1842532ilv.12;
        Thu, 16 Mar 2023 15:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679007076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlnFdcYO4ekRPeU0360YFofSqLK14iqQXYMHI5q7xd8=;
        b=NglyytJlR4FutV6p4icW5Fl/Ql0cB9iYv5eRUkJSX0z0gkSGdadtMzLWcDwJpIMIIO
         UljGiAVEEKWzwh09D+AaHVEHM/c/kwBA/pdm0GUrDzc9cLy9xIpkzDf5W1MuYlCNubf9
         1YsSeQNIbQRP8QvCWKyQR0aAzsl3KCAWGOC9KVHkB/MQBopgYfmW419rD2P1tl+ZHFfA
         PbwMRHbYNR6et+obOPJHovFdTGmq3nb0vdFD+oUckhAW8HHNnhYMqK21oM3YxsPLzFVd
         chqsIDvz5g5+AyT/q7CLcSs0bhNgMdL97fWFcHlWcMSeRGF2zv43U1iZT8XTavyXuyiY
         /kyw==
X-Gm-Message-State: AO0yUKXP6zgFfIBjnx1fhUE2dFdrDhiyhzJGUx8ewlqdLDKhuhsR2+d1
        sm5F7tjbHXtIcSIjg9TYXa3Oza9+Nw==
X-Google-Smtp-Source: AK7set/itDMXeIWLc2ZHs43kOtxpBf29sWKycrp4IhtK8Vuok3HiHScFGx4/jX7/MkCpS9tSNxln+A==
X-Received: by 2002:a05:6e02:504:b0:324:3ece:af5e with SMTP id d4-20020a056e02050400b003243eceaf5emr696781ils.0.1679007076499;
        Thu, 16 Mar 2023 15:51:16 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id i7-20020a05663815c700b00406147dad72sm166301jat.104.2023.03.16.15.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 15:51:15 -0700 (PDT)
Received: (nullmailer pid 4031144 invoked by uid 1000);
        Thu, 16 Mar 2023 22:51:14 -0000
Date:   Thu, 16 Mar 2023 17:51:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-kernel@vger.kernel.org, andersson@kernel.org,
        linux-phy@lists.infradead.org, krzysztof.kozlowski+dt@linaro.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org,
        devicetree@vger.kernel.org, vkoul@kernel.org, bhelgaas@google.com,
        kw@linux.com, kishon@kernel.org, linux-arm-msm@vger.kernel.org,
        konrad.dybcio@linaro.org
Subject: Re: [PATCH v3 02/13] dt-bindings: PCI: qcom: Add iommu-map properties
Message-ID: <167900707444.4031088.17252827146450649974.robh@kernel.org>
References: <20230308082424.140224-1-manivannan.sadhasivam@linaro.org>
 <20230308082424.140224-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308082424.140224-3-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Wed, 08 Mar 2023 13:54:13 +0530, Manivannan Sadhasivam wrote:
> Most of the PCIe controllers require iommu support to function properly.
> So let's add the "iommu-map" property that specifies the SMMU SID of the
> PCIe devices to the binding.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

