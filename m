Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1CF2D5222
	for <lists+linux-pci@lfdr.de>; Thu, 10 Dec 2020 04:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbgLJD4P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Dec 2020 22:56:15 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44528 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729955AbgLJD4P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Dec 2020 22:56:15 -0500
Received: by mail-ot1-f67.google.com with SMTP id f16so3642030otl.11;
        Wed, 09 Dec 2020 19:55:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qr+wzuJ7ydwlrmhP6J6rkRHatC32lcTNUeqcfXwmgQ8=;
        b=HJv7/VULkdDp34/dzG5Gs14fv6O0qAsF0e7JMMK9Z4CvLLWtZH+pzvM6uefVv/e7Ep
         Uah3ENwQeDcxMW4v7MA/LAZ9/gz3y1SdniXxdtT0pRQUmRzOXuHEg1/Fk1DGGK9Uc/Up
         jAlFFHeRGAgQ0DPvt+9gnz76zSSs+uuW3VUooRpWUKDCcgdCpTyTHzxzyr8ThPE4GSvp
         Z/Gx2wS2sAEo/k3tICY5NXAqhb3jfAvkyvGSBUt3h+7yddvtpSjV79JLi5h4rknLgpEu
         GABqEqhjFosmAM1Smhg3410+bnEcb6NI3tNFqgZgSnwirUOL+V3SNazUGx37YdqldkB0
         j0UQ==
X-Gm-Message-State: AOAM531QobQV7DSzYmmKU8X/jw3Rcq691bn8pc+gGY9aAqtqZVJsmdIV
        hOh0UDMsYwaaIfdom4O26Q==
X-Google-Smtp-Source: ABdhPJzNRqTw1h/KkQ6wsIl+T/KGaMjeJHdP9NAj4W7z31GSrDX3rNtguIPzqjQfJkTN15NLxO30Pw==
X-Received: by 2002:a05:6830:114e:: with SMTP id x14mr4411126otq.253.1607572534547;
        Wed, 09 Dec 2020 19:55:34 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k10sm834672otn.71.2020.12.09.19.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 19:55:33 -0800 (PST)
Received: (nullmailer pid 1632474 invoked by uid 1000);
        Thu, 10 Dec 2020 03:55:32 -0000
Date:   Wed, 9 Dec 2020 21:55:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-pci@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/3] dt-bindings: pci: qcom: Document ddrss_sf_tbu clock
 for sm8250
Message-ID: <20201210035532.GA1632444@robh.at.kernel.org>
References: <20201208004613.1472278-1-dmitry.baryshkov@linaro.org>
 <20201208004613.1472278-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208004613.1472278-2-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 08 Dec 2020 03:46:11 +0300, Dmitry Baryshkov wrote:
> On SM8250 additional clock is required for PCIe devices to access NOC.
> Document this clock in devicetree bindings.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
