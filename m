Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2E1285418
	for <lists+linux-pci@lfdr.de>; Tue,  6 Oct 2020 23:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbgJFVve (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Oct 2020 17:51:34 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33499 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgJFVve (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Oct 2020 17:51:34 -0400
Received: by mail-oi1-f196.google.com with SMTP id m7so269889oie.0;
        Tue, 06 Oct 2020 14:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HSjlV9vXsEqI/tzqQXY6XpsVV0yFMmuJUHJ5Q0D39J4=;
        b=czA/slhtAjZY96LReP0+vbvU7BisNDxQ88mOjIjxfAW6E7L9Ba3OCC1AX8xstwI8hC
         KpdYtPiI7ylHrO4Mraj2+BL8pUhLVRgF/2PiQxOwBh+EskkJGjfksCSd9sabaPHZ+AqH
         TbNzL4wwewQNZ4jHUrN2eymizZEXJ2Eq0OYjPV1hk6o74eaxr/MHruqFk9N+CUUhMnWU
         vB3Db6OwktRGwijwQ1x1WzXF4YNllPMDAPOet+leIqAUkj0Lx2cBWuGZLOaenr90EFIv
         orXYmHj63ZH8gXyDxte4fOBRxO6+P0Qi7DB+q4r1qk/Hga5Dcccbw/z4cI++px1jMgBt
         rSmQ==
X-Gm-Message-State: AOAM533Clgjl1rEQc034rHc8MSxqxbeHLwDnvP1QqlH4wbaubQYM69Z2
        DQhQLhlH4X8Cf9jzC4HFnQ==
X-Google-Smtp-Source: ABdhPJyNXya9Tp/JeF9A4NUgXVni16HrDTaMbUdqTwNbnl2DlgWIkQoAiY2A6ABHKyy2TT1XJGQsbg==
X-Received: by 2002:aca:e0d5:: with SMTP id x204mr198837oig.160.1602021093529;
        Tue, 06 Oct 2020 14:51:33 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v18sm195825ooq.11.2020.10.06.14.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 14:51:32 -0700 (PDT)
Received: (nullmailer pid 2912580 invoked by uid 1000);
        Tue, 06 Oct 2020 21:51:32 -0000
Date:   Tue, 6 Oct 2020 16:51:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     vkoul@kernel.org, devicetree@vger.kernel.org, bhelgaas@google.com,
        mgautam@codeaurora.org, agross@kernel.org, kishon@ti.com,
        bjorn.andersson@linaro.org, lorenzo.pieralisi@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        svarbanov@mm-sol.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 3/5] dt-bindings: pci: qcom: Document PCIe bindings
 for SM8250 SoC
Message-ID: <20201006215132.GA2912523@bogus>
References: <20201005093152.13489-1-manivannan.sadhasivam@linaro.org>
 <20201005093152.13489-4-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005093152.13489-4-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 05 Oct 2020 15:01:50 +0530, Manivannan Sadhasivam wrote:
> Document the PCIe DT bindings for SM8250 SoC. The PCIe IP is similar to
> the one used on SDM845, hence just add the compatible along with the
> optional "atu" register region.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
