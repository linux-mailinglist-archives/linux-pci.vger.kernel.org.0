Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8BA47C7C8
	for <lists+linux-pci@lfdr.de>; Tue, 21 Dec 2021 20:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241910AbhLUTwV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Dec 2021 14:52:21 -0500
Received: from mail-qk1-f176.google.com ([209.85.222.176]:42911 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbhLUTwV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Dec 2021 14:52:21 -0500
Received: by mail-qk1-f176.google.com with SMTP id g28so113346qkk.9;
        Tue, 21 Dec 2021 11:52:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6KTbJr72rRr9PgymTip4M6pAs/zMxShgqIUpXjW532I=;
        b=YJvbynnGw+WcziAymS+HeHh4FN45U8uAkxdaI6inqFfariffat5ac9XRZ6msuBEvJV
         02R9SVoOgTwWVFCCBDQKFJkJiszghCfkHl0Iii2DLtv9r2ivaplxg0uHrxWQKi3UfZ0Z
         VaPefxKkz74mQIYw7fBEbGRP0rHgLPYRbgLwHajrAHBusAdpx6U1exhi+ERqlIz94JRE
         D8LrqImwN6EYuhZJyl462gKvuYCuec/xghVYvb/f+/p9CudWhmpSexqYxzm2O86tnnvR
         1Mjhbn6eZmUVgvk1tytf0Q7QwFof1NJvC5AXtFiT9YJVG2dq0fq0SFkAuSHIKXjXnIb/
         Nwtw==
X-Gm-Message-State: AOAM53089g9SPk2DLaDKaSIqhJa6RS4+WJSr6A8D5ZgsLJoAQTr6mDFp
        S94uLkIfhDWsLUB0tOBtWA==
X-Google-Smtp-Source: ABdhPJx3zZgrKOC/ikoGYyvjxr1YgqwCwXRo6Ficx2kO1hnoC7oIyz8VeuqxfzQ5mhKv/fqOVX9jkQ==
X-Received: by 2002:a05:620a:b47:: with SMTP id x7mr2289893qkg.174.1640116340667;
        Tue, 21 Dec 2021 11:52:20 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id 8sm18888546qtz.28.2021.12.21.11.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 11:52:19 -0800 (PST)
Received: (nullmailer pid 1640609 invoked by uid 1000);
        Tue, 21 Dec 2021 19:52:17 -0000
Date:   Tue, 21 Dec 2021 15:52:17 -0400
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v5 1/5] dt-bindings: pci: qcom: Document PCIe bindings
 for SM8450
Message-ID: <YcIwcUzYCq1v4Kfs@robh.at.kernel.org>
References: <20211218141024.500952-1-dmitry.baryshkov@linaro.org>
 <20211218141024.500952-2-dmitry.baryshkov@linaro.org>
 <YcHr0/W0QqRlj1Ji@robh.at.kernel.org>
 <CAA8EJpr1wfW2CLSjBjJdMhhgBmcnMRkx=x5SAC_4LDQCHw1_qA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpr1wfW2CLSjBjJdMhhgBmcnMRkx=x5SAC_4LDQCHw1_qA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 21, 2021 at 06:43:31PM +0300, Dmitry Baryshkov wrote:
> On Tue, 21 Dec 2021 at 17:59, Rob Herring <robh@kernel.org> wrote:
> >
> > On Sat, Dec 18, 2021 at 05:10:20PM +0300, Dmitry Baryshkov wrote:
> > > Document the PCIe DT bindings for SM8450 SoC. The PCIe IP is similar
> > > to the one used on SM8250, however unlike SM8250, PCIe0 and PCIe1 use
> > > different set of clocks, so two compatible entries are required.
> > >
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > >  .../devicetree/bindings/pci/qcom,pcie.txt     | 22 ++++++++++++++++++-
> > >  1 file changed, 21 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> > > index a0ae024c2d0c..0adb56d5645e 100644
> > > --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> > > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> > > @@ -15,6 +15,8 @@
> > >                       - "qcom,pcie-sc8180x" for sc8180x
> > >                       - "qcom,pcie-sdm845" for sdm845
> > >                       - "qcom,pcie-sm8250" for sm8250
> > > +                     - "qcom,pcie-sm8450-pcie0" for PCIe0 on sm8450
> > > +                     - "qcom,pcie-sm8450-pcie1" for PCIe1 on sm8450
> >
> > What's the difference between the two?
> 
> Clocks used by these hosts. Quoting the definition:
> 
> +                     - "aggre0"      Aggre NoC PCIe0 AXI clock, only
> for sm8450-pcie0
> +                     - "aggre1"      Aggre NoC PCIe1 AXI clock
> 
> aggre1 is used by both pcie0 and pcie1, while aggre0 is used only by pcie0.

That doesn't really seem like you need a different compatible for that. 
Do you need to handle them differently? It seems like abuse of clocks 
putting bus/interconnect clocks here, but sadly that's all too common.

Rob
