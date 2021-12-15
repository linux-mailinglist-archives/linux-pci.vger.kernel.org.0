Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D834764AF
	for <lists+linux-pci@lfdr.de>; Wed, 15 Dec 2021 22:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhLOVho (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Dec 2021 16:37:44 -0500
Received: from mail-oo1-f53.google.com ([209.85.161.53]:36431 "EHLO
        mail-oo1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhLOVhn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Dec 2021 16:37:43 -0500
Received: by mail-oo1-f53.google.com with SMTP id g11-20020a4a754b000000b002c679a02b18so6310587oof.3;
        Wed, 15 Dec 2021 13:37:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7ztWRpd0FY6iKQ7NWAfXJktIdvCg42gZ0zgIm9BLYH8=;
        b=6KRqtm7dqDpPhwfa6NlEgwUoQhHUkPWb8eHDNhZTjBUgO0/Mom/LWAlIYVofifEEm2
         YRd44/eIdvz7v2LcgvzOOIshGo/WzVmdPsGbZIGm0Ft6ve+JsaSn84gMrlvHCmoP3eJf
         9S32hbPVK5X7CPM48clyXggTLVN92jeftSTV13rZMNhZr9zx1pc0JNpTJeIGvE+3GHbB
         t6VHYCFvUvfbkDU556pVzLrJYSk9AVOEq+igt3PNzsrtqjAjvyTrDMiYZF2sc2pvgkpf
         PplCxSgPLpxta4PIIYpyfr++VKfwl2N6UOja5GANLi6584pf39dMDEkdtPbqkAZtmv5x
         bckw==
X-Gm-Message-State: AOAM532BGp3xX/3qofOC0ZqCLoQz3LshjTn8NOvFnK0SbXH7LCxWMp17
        d8M9RZSG4HWhJirRoZnhgQ==
X-Google-Smtp-Source: ABdhPJxpCkrFLmOfCFQlTCLdJXSpNZUQUIngwMEwYrg97vjoo8t+JhDBR7ihep3lXctKWI328MCdqQ==
X-Received: by 2002:a4a:430b:: with SMTP id k11mr4815836ooj.69.1639604263102;
        Wed, 15 Dec 2021 13:37:43 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x16sm684193otq.47.2021.12.15.13.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 13:37:42 -0800 (PST)
Received: (nullmailer pid 1883612 invoked by uid 1000);
        Wed, 15 Dec 2021 21:37:41 -0000
Date:   Wed, 15 Dec 2021 15:37:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v4 02/10] dt-bindings: phy: qcom,qmp: Add SM8450 PCIe PHY
 bindings
Message-ID: <YbpgJdXG/EJRNj49@robh.at.kernel.org>
References: <20211214225846.2043361-1-dmitry.baryshkov@linaro.org>
 <20211214225846.2043361-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214225846.2043361-3-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 15 Dec 2021 01:58:38 +0300, Dmitry Baryshkov wrote:
> There are two different PCIe PHYs on SM8450, one having one lane and
> another with two lanes. Add DT bindings for the first one. Support for
> second PCIe host and PHY will be submitted separately.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
