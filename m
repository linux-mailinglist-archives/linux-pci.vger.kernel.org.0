Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134984E6A08
	for <lists+linux-pci@lfdr.de>; Thu, 24 Mar 2022 21:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353730AbiCXUyV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Mar 2022 16:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355935AbiCXUxt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2022 16:53:49 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20903DA7E;
        Thu, 24 Mar 2022 13:52:17 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id i11-20020a9d4a8b000000b005cda3b9754aso4144040otf.12;
        Thu, 24 Mar 2022 13:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/QLDLUATu/B8KBKI55+l5jEhcVbVbLC4t+4Lo997I00=;
        b=MlBBMOHIwE5WwdmDBTna/Fq8uas9VzSGTHwBF1Op95D5rNgmRHR27Na3ak/JBmBbGQ
         vr7RzXgy49lBs5KWLqmS8TtUQ2mRHVZJ5oaQWNnswyA5AQGqX9yA616OvCfk4gQ7yJ8/
         Xj/4Kb6hPXBy28ge0LmCc5V50Q8IifesHjrjMU4DogKBmo/r5B/jFscBepSjYC6YNeIB
         LkqqVXqmXKLXYIq4MffW5xrKRXgeTLLOOIQx7hAZDneGBj9JEhMnfJQ9/BgHN5S+Dfgz
         PDc6g5906uipRBC79KLufVqTyto7aHUlbrqYqrQZK2ADmgbZPnR1QUfxqLMkUsuDxkb5
         ow+w==
X-Gm-Message-State: AOAM530kuK8ZkNCoPTj528mI7f67kDTEgqGSgDmsFxXjGqfM96a+IWoL
        obCodq90BC9nLecaBrNgWI0I/3PIvQ==
X-Google-Smtp-Source: ABdhPJyFYhwTUm0TKaf6Pqx5DO+afqZXoNMWQT+r4f5yxTAUoTRetq4GNXbRCl2dY1di+ow83NKRAA==
X-Received: by 2002:a9d:7f95:0:b0:5cd:b19f:2c3a with SMTP id t21-20020a9d7f95000000b005cdb19f2c3amr2403965otp.272.1648155136961;
        Thu, 24 Mar 2022 13:52:16 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g105-20020a9d12f2000000b005c961f9e119sm1793184otg.35.2022.03.24.13.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 13:52:16 -0700 (PDT)
Received: (nullmailer pid 2553596 invoked by uid 1000);
        Thu, 24 Mar 2022 20:52:15 -0000
Date:   Thu, 24 Mar 2022 15:52:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, bhupesh.linux@gmail.com,
        lorenzo.pieralisi@arm.com, agross@kernel.org,
        bjorn.andersson@linaro.org, svarbanov@mm-sol.com,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v3 5/7] PCI: qcom: Add SM8150 SoC support
Message-ID: <YjzZ/zfhSDlFzP7G@robh.at.kernel.org>
References: <20220302203045.184500-1-bhupesh.sharma@linaro.org>
 <20220302203045.184500-6-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302203045.184500-6-bhupesh.sharma@linaro.org>
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

On Thu, Mar 03, 2022 at 02:00:43AM +0530, Bhupesh Sharma wrote:
> The PCIe IP (rev 1.5.0) on SM8150 SoC is similar to the one used on
> SM8250. Hence the support is added reusing the members of ops_1_9_0.
> 
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
