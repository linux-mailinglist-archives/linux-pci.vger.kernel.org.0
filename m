Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC7426CF0D
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 00:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgIPWpu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 18:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgIPWpr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Sep 2020 18:45:47 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533A4C061788
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2020 15:45:47 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id o8so126253otl.4
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2020 15:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mSPBN6R1sa+s+aXjb7bLc56lTmvRIEa3Tj0pNL1DtAs=;
        b=Xyr66PPEDJ2lFdT1dZgEBP7yEoadnPkYbN2OeOWbUjE051q2HkIHFh2DY8Z0MZe6rR
         Z+xXrgXrQtkqVs2JUo039Lstewge9fiTWYW3zFy0c5ynnVisMotuE2fCxMSskz/ON0wt
         jfeV+IRhzMyXg0ckLRz/r2ChSXRhtwsCsjLxwIqYgEk1XnckrTTd7/RnTsFIfVi+qwJZ
         S+LOSriDUUu7yzbGXYFQ55l/Q0+zvAvA63NoEMDTjYoqJmqu+Axhdg7HEz9ujJ1Mbt+k
         ef9N+MmkdeybRs4009fkUu3460b0XWVVnC4udkVC/IUhIcOJDHf0b9WIl9FBOTMSM4+9
         LxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mSPBN6R1sa+s+aXjb7bLc56lTmvRIEa3Tj0pNL1DtAs=;
        b=mn8BrWX65Tso9wB3U4Ih803wU+TSwNIDgg4QTqvylE8KJBNv6vq+vGYbsoiN9Xhopo
         hlfi0CiXTP+cNROhghxrTXyFxFnYY0H8/TyskJZhGe+yk2nh7ZzOSnfYA4e5/KFmrESw
         chHw0JNfV7Gv3eeVJPGlJiygmnugCEVMmqOK7x2bTHIo6M0kqqaYmYd7+A/vmLp+wfWg
         vG0vHpC3F3/q0wjPhYe0JA0x5G0Sy2avzNTHnmC96I+3CXFPI2UbSTemrrpHvPZyaO9W
         rhUXEzCJke6jLEGMCeHZYfVg9DnGt8I0RaSugjuhKxQxAseV/Ap/L+1p07RFZCQCePpX
         qwJw==
X-Gm-Message-State: AOAM533w29nugUAzCeaRlKf/w+FrkZ/CYdabRLNMlxFBxXXQM732XjVY
        4MfReWL4SMMyy+gZfobauK3eZw==
X-Google-Smtp-Source: ABdhPJxm0s45AtmEZVAKj5PYYYbpECFzxiWfua7H6FDMJJAeMl76CZ0dlEyNMoQn+qRQtUFYQhiRng==
X-Received: by 2002:a9d:6219:: with SMTP id g25mr18071407otj.58.1600296346467;
        Wed, 16 Sep 2020 15:45:46 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:7cad:6eff:fec8:37e4])
        by smtp.gmail.com with ESMTPSA id c34sm9253888otb.69.2020.09.16.15.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 15:45:45 -0700 (PDT)
Date:   Wed, 16 Sep 2020 17:45:41 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     agross@kernel.org, kishon@ti.com, vkoul@kernel.org,
        robh@kernel.org, svarbanov@mm-sol.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgautam@codeaurora.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: phy: qcom,qmp: Document SM8250 PCIe PHY
 bindings
Message-ID: <20200916224541.GF1893@yoga>
References: <20200916132000.1850-1-manivannan.sadhasivam@linaro.org>
 <20200916132000.1850-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916132000.1850-2-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed 16 Sep 08:19 CDT 2020, Manivannan Sadhasivam wrote:

> Document the DT bindings of below PCIe PHY versions used on SM8250:
> 
> QMP GEN3x1 PHY - 1 lane
> QMP GEN3x2 PHY - 2 lanes
> QMP Modem PHY - 2 lanes

How about something like "Add the three PCIe PHYs found in SM8250 to the
QMP binding"?

> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> index 185cdea9cf81..69b67f79075c 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> @@ -31,6 +31,9 @@ properties:
>        - qcom,sdm845-qmp-usb3-uni-phy
>        - qcom,sm8150-qmp-ufs-phy
>        - qcom,sm8250-qmp-ufs-phy
> +      - qcom,qcom,sm8250-qmp-gen3x1-pcie-phy
> +      - qcom,qcom,sm8250-qmp-gen3x2-pcie-phy
> +      - qcom,qcom,sm8250-qmp-modem-pcie-phy

One "qcom," should be enough.

>  
>    reg:
>      items:
> @@ -259,6 +262,8 @@ allOf:
>              enum:
>                - qcom,sdm845-qhp-pcie-phy
>                - qcom,sdm845-qmp-pcie-phy
> +              - qcom,sm8250-qhp-pcie-phy
> +              - qcom,sm8250-qmp-pcie-phy

Adjust these.

Regards,
Bjorn

>      then:
>        properties:
>          clocks:
> -- 
> 2.17.1
> 
