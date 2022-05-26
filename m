Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BE2535518
	for <lists+linux-pci@lfdr.de>; Thu, 26 May 2022 22:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236629AbiEZUxJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 May 2022 16:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbiEZUxI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 May 2022 16:53:08 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0392367D1E;
        Thu, 26 May 2022 13:53:08 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-f16a3e0529so3641968fac.2;
        Thu, 26 May 2022 13:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pc1NE8k39pHbtINYaHG41r5I5vQP7cYj1pZbQZyEc5A=;
        b=dLXOTaZXl3uaoy+D4ovE5Vqv2dhWHvBDl31glpQZb96L4TwaEdbLgUkS1vIe9wKqCG
         tHc6vh4t21eapdegkkjMXqf0guyiMGwugnZxYiX9UkWQJ0A78PSQrUpPi73A3JoTiIOo
         E1ZWxLI7zlFMUepuW2BTyQC/tc6fSeNNpb0rtqgruzryLrwM70PyFPyNPpg1uzyhH9Rk
         8H2TGU6Fm53fRz7I/Pmwiv5HRDingNtqNx9vQTEI55t1mtG4vWdX/OtSGL9qgLfKtF2R
         OL0x7MyCRG161zzJJ/HZCMTGmxYEyxjwzsCWLM9iNTVHS6/mTDQM+G13Ej/d/2vNI7mm
         l9Vg==
X-Gm-Message-State: AOAM531n5TwoGW7qgLgA2CQSdIWFcswfIpH/azjy7ePZSYdOeZDacS+a
        iTcw0+lOZ9vf9BjDUEtCSRyIMxAaYw==
X-Google-Smtp-Source: ABdhPJwsNwYmZovbeLT/mlyxE9TxQhyDCMg+nsKKnuLDMaufWVf24gyTr7Jb6zt4qTS97ACRK01edQ==
X-Received: by 2002:a05:6870:339a:b0:f2:d065:be1f with SMTP id w26-20020a056870339a00b000f2d065be1fmr2276522oae.69.1653598387346;
        Thu, 26 May 2022 13:53:07 -0700 (PDT)
Received: from robh.at.kernel.org (rrcs-192-154-179-37.sw.biz.rr.com. [192.154.179.37])
        by smtp.gmail.com with ESMTPSA id v1-20020a056830090100b00605fd407259sm1057769ott.3.2022.05.26.13.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:53:06 -0700 (PDT)
Received: (nullmailer pid 244609 invoked by uid 1000);
        Thu, 26 May 2022 20:53:04 -0000
Date:   Thu, 26 May 2022 15:53:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Add support for modular builds
Message-ID: <20220526205304.GK54904-robh@kernel.org>
References: <20220519094646.23009-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519094646.23009-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 19, 2022 at 11:46:46AM +0200, Johan Hovold wrote:
> Allow the Qualcomm PCIe controller driver to be built as a module, which
> is useful for multi-platform kernels as well as during development.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/pci/controller/dwc/Kconfig     |  2 +-
>  drivers/pci/controller/dwc/pcie-qcom.c | 36 +++++++++++++++++++++++---
>  2 files changed, 34 insertions(+), 4 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
