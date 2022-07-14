Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA47574E99
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 15:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238985AbiGNNFr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 09:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238596AbiGNNFp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 09:05:45 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994634E848
        for <linux-pci@vger.kernel.org>; Thu, 14 Jul 2022 06:05:44 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id r9so2075223ljp.9
        for <linux-pci@vger.kernel.org>; Thu, 14 Jul 2022 06:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=u+3rknmtb2dZGdFRfj+HaAmrjmjmI4vZwsXBVfJYyoA=;
        b=sVGUiDjf0lNmV8joR1NFJJB73ewZQ7mfpDQ/NHORpp33c46ryiRzI5L+UTJP+rirVv
         RLGbciQ1diEymQa0jxdXJDXcxr10hC4Yl9iqHCuYpyXDu/8j1C23rwZNDawbpAKUl6X1
         QhFW/X7OifcXq8C/sXuY3Kd1fmKSgl6+8pgbrYYjJSsbwQLKG5eubgJ/xvwHbTmuZoA3
         DBFIfoMIM9IMZlbe0uNp0rUfmvmJi3FuDuPIVyUlZgT1mknXNNVwF+ZPRwB0SSUmg4fz
         RW6wgyGPbJzuBWNI/HjY2ER+znlWmW0BL663K/qaBtROGyl/yIW4tajNMfyjCSy6RhJS
         0Sfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=u+3rknmtb2dZGdFRfj+HaAmrjmjmI4vZwsXBVfJYyoA=;
        b=dx2yNjYXxjzwW9LDQ+LDt08y7w/Ln1Jm3jcmxC+w2C2rcTy7aNmFs8OuCf/uRDGR8z
         8HD1zdQmnmLD10n3b1XRGTIAcl5nnH0BsbMXCVSkp83Jlwr5qc4vInh0R3cNQERXPrCu
         9IcCoQ2WCqoBypx1AUkEiUIJTb/W7NjpG0qbFFduIJv3P0ZGu3TECRwHt5iTu3zOdd/J
         kodYZc3kShvswmM4mgXOGghfC15haj+UZqcw3msaOqQ/v61pom8V2tY8LagEF19b6aVG
         uyw6PlnKKSW54f7cmo7+NnZAKsC7DXuwsGnwP7RfqujTgjNAp9b9iaE0X4mqGeU8Rgej
         oavw==
X-Gm-Message-State: AJIora+fAqoVICiB6fEdYcbk3b+vOnpMdVty4oMInrOzbZuE5XnFM79P
        qzpI5AeSn0a2CwjqRb7qe+5XIg==
X-Google-Smtp-Source: AGRyM1utuosbogphj/pZJQ0Zu/oq61N+cuIDtO7V7ISXg8NE0sxYlKJ7AyfdosnfkcsEkXstj2yjjw==
X-Received: by 2002:a2e:9bd6:0:b0:25d:8712:64f6 with SMTP id w22-20020a2e9bd6000000b0025d871264f6mr4403216ljj.337.1657803942958;
        Thu, 14 Jul 2022 06:05:42 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u1-20020ac258c1000000b0047f943112e3sm350866lfo.285.2022.07.14.06.05.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 06:05:42 -0700 (PDT)
Message-ID: <9ef036db-2ac8-2723-93de-ac841d94ba51@linaro.org>
Date:   Thu, 14 Jul 2022 16:05:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] PCI: qcom: Add support for modular builds
Content-Language: en-GB
To:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220519094646.23009-1-johan+linaro@kernel.org>
 <cc7c90aa-6705-7493-2f58-5112f7d663a3@mm-sol.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <cc7c90aa-6705-7493-2f58-5112f7d663a3@mm-sol.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Stanimir,

On 14/07/2022 15:19, Stanimir Varbanov wrote:
> Hi Johan,
> 
> Please take a look why we made it built-in first [1].
> 
> If arguments there are still valid I don't see why to make it a module
> again.
> 
> [1] https://lkml.org/lkml/2016/8/24/694

It looks like there is a move to make all non-essential drivers 
buildable as modules. For example, the Kirin, dra7xx, Meson PCI 
controllers are now buildable as modules. So I think we can follow that 
and allow building the pcie-qcom as a module.

> 
> On 5/19/22 12:46, Johan Hovold wrote:
>> Allow the Qualcomm PCIe controller driver to be built as a module, which
>> is useful for multi-platform kernels as well as during development.
>>
>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>> ---
>>   drivers/pci/controller/dwc/Kconfig     |  2 +-
>>   drivers/pci/controller/dwc/pcie-qcom.c | 36 +++++++++++++++++++++++---
>>   2 files changed, 34 insertions(+), 4 deletions(-)
>>
> 
> 


-- 
With best wishes
Dmitry
