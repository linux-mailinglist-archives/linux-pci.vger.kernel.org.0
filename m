Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F514C4F0D
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 20:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbiBYTop (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Feb 2022 14:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbiBYToi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Feb 2022 14:44:38 -0500
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08951A3600;
        Fri, 25 Feb 2022 11:44:05 -0800 (PST)
Received: by mail-oo1-f46.google.com with SMTP id s203-20020a4a3bd4000000b003191c2dcbe8so7724558oos.9;
        Fri, 25 Feb 2022 11:44:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tW4zPiKBcV7dGZmtEMwIis6F1TyhWjq1DmblCZrI9K8=;
        b=I3pTVYhCUx9PMm9HO5o5oWnZD0jMjnvOTZKNb4az7euweT5POwcDgltqvpXKv1KDQk
         Ug022ztb5mIb5SQRsARwHQ1WMFtozJ6OtvPKS9rCSm8uwLe9GydJpXGTmMFKg8nxutoI
         p5TRr+ApthKWgAAsiOhY+MtY6NlAukQdHYnVeMeAdjkwEo04PmRdLGGf5jdZKs7a+kYh
         +rtAeVkEJVuJPUaZdRkBcTYhsiKI1WK6RUUOOMHVMKk+4GnAY9QNRmQp9/3JKaPTGA0s
         H9NxEfnuDMPb8ZoSgLo4jN0/P2vbk3dIKSFO1v8t8aoSpUi2j5LVuEQvKjs2PNVOn3uq
         S3UQ==
X-Gm-Message-State: AOAM532iLvE82TsLdglAEusTUVZt9u0j57wS1YGd8ovMMrrjkXCoaVEY
        CzHR8bs5du4BSsmn5mj+dg==
X-Google-Smtp-Source: ABdhPJyrGxDdbmb/ikGgs7yq1wNO0QvuE+0EGbX09kP8eiqL24MZFxcrlDZeb3RdyrTjLul91B9b1A==
X-Received: by 2002:a05:6870:128c:b0:ce:c0c9:5ba with SMTP id 12-20020a056870128c00b000cec0c905bamr2174582oal.12.1645818244950;
        Fri, 25 Feb 2022 11:44:04 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j23-20020a056830241700b005af4acc68a5sm1532276ots.29.2022.02.25.11.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 11:44:04 -0800 (PST)
Received: (nullmailer pid 1313718 invoked by uid 1000);
        Fri, 25 Feb 2022 19:44:03 -0000
Date:   Fri, 25 Feb 2022 13:44:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     lorenzo.pieralisi@arm.com, bjorn.andersson@linaro.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, agross@kernel.org, svarbanov@mm-sol.com
Subject: Re: [PATCH 2/6] dt-bindings: phy: qcom,qmp: Add SM8150 PCIe PHY
 bindings
Message-ID: <Yhkxg1wjduMX22Mo@robh.at.kernel.org>
References: <20220223192946.473172-1-bhupesh.sharma@linaro.org>
 <20220223192946.473172-3-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223192946.473172-3-bhupesh.sharma@linaro.org>
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

On Thu, 24 Feb 2022 00:59:42 +0530, Bhupesh Sharma wrote:
> Add the following two PCIe PHYs found on SM8150, to the QMP binding:
> 
> QMP GEN3x1 PHY - 1 lane
> QMP GEN3x2 PHY - 2 lanes
> 
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
