Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F01147C9C7
	for <lists+linux-pci@lfdr.de>; Wed, 22 Dec 2021 00:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238025AbhLUXfQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Dec 2021 18:35:16 -0500
Received: from mail-qk1-f170.google.com ([209.85.222.170]:34530 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238006AbhLUXfP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Dec 2021 18:35:15 -0500
Received: by mail-qk1-f170.google.com with SMTP id b85so671943qkc.1;
        Tue, 21 Dec 2021 15:35:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qyanZg8s5W+8gtKaR/fQ6jVlMg3RFbNcdfj1FBUpzJQ=;
        b=DPVHK3eKQrymXoErnB8m5AhrpH7IRASf1UGpCud5hyfJO06v3CaKIuaT3tNHykBHzR
         MkQe54TvD5lnwm0PD5h+hINVjA08hqWNd7IGxAnjf7SE095JKJaaX26VL9Eu25uSFtA8
         lS1fgHmvVWCLcojeMa+ZJbaNPHsqs1u06a1iD5rripWwe2eL0xyyQDC4HZ70poqm7ofT
         tXRWmoXvaiZt7SoM+9FUIHLWg2RcTyNLYEskbrG9AwnJpERyNmfAL15+FsemD1U283NF
         KFryL/8crGcivMGkmzdCq59Yb5vwATspy/87z4A0aC85iFabSea8RfYv1s8iGaXMbbLy
         FTvw==
X-Gm-Message-State: AOAM530hN7CVXYvXKZhrm1pfVP8Kk8AQGbM87KfU+EUgsJvNNptOK6up
        SfxBP6Na75JINXhTTFGWuw==
X-Google-Smtp-Source: ABdhPJyTptN0ibMFOYgCQ8c+Nvty9jYcqWQQe8SaV4rLqX5MHk6Wc/d9/bxsLWY/7Ky6+nkDa/9Yqw==
X-Received: by 2002:a37:34c:: with SMTP id 73mr507439qkd.726.1640129714870;
        Tue, 21 Dec 2021 15:35:14 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id c22sm312771qtd.76.2021.12.21.15.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 15:35:14 -0800 (PST)
Received: (nullmailer pid 1725609 invoked by uid 1000);
        Tue, 21 Dec 2021 23:35:12 -0000
Date:   Tue, 21 Dec 2021 19:35:12 -0400
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-phy@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Andy Gross <agross@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 1/5] dt-bindings: pci: qcom: Document PCIe bindings
 for SM8450
Message-ID: <YcJksCyV11ssaRIF@robh.at.kernel.org>
References: <20211218141024.500952-1-dmitry.baryshkov@linaro.org>
 <20211218141024.500952-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211218141024.500952-2-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 18 Dec 2021 17:10:20 +0300, Dmitry Baryshkov wrote:
> Document the PCIe DT bindings for SM8450 SoC. The PCIe IP is similar
> to the one used on SM8250, however unlike SM8250, PCIe0 and PCIe1 use
> different set of clocks, so two compatible entries are required.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.txt     | 22 ++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
