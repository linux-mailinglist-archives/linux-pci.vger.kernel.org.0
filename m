Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C2C46BD8C
	for <lists+linux-pci@lfdr.de>; Tue,  7 Dec 2021 15:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237524AbhLGO2Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 09:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbhLGO2Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Dec 2021 09:28:25 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B749EC061746
        for <linux-pci@vger.kernel.org>; Tue,  7 Dec 2021 06:24:54 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id 7so27950975oip.12
        for <linux-pci@vger.kernel.org>; Tue, 07 Dec 2021 06:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vfUP7dJBnmi/OcEPVE2ezJwiVV1EUyQRW+Qu6djHyYk=;
        b=cKbadL6aJ141eWrYwPOtTIb0RT1sCruIZCJFoP3Mp+GlRexPjDyuc8ORvvqpOGPI1c
         l0Q/5hwYs4n0G1leCMsw87+GWF6OZpHgo8YIyepUw/4rHrx+431NSShPxQ4XY3okTLa8
         HwSnvvrIrkX0keGoEVQdundcorMDqQ27ophbgoPuODQ2JZlnfAXNkeajGQs8hTBaOEE+
         tfNVXSTRb1khLmksktzI+A1fCA7nAeKuYnBaiDuAC7lDS6fudXxOnBhurhdFC+dbdupb
         HrktztM6Z/tJsuUKo9lz9L63DiAo+6AKFnLGh/Kh9yS9pjnT0scMalVf0onw8bQ6HQ8C
         /3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vfUP7dJBnmi/OcEPVE2ezJwiVV1EUyQRW+Qu6djHyYk=;
        b=EHCmOiuxZoLYDNKZ7hLIp1UER9xtyKYtNwXT8eL08es4rHVyz8N5Gam0iVF5ncnNTf
         fQrblhhL+YyRRncz+6R0x3A0WQzvXjQ6ikHMCb/7mpBSBGUZC5XvLCWvOjUqlrkZkzOx
         XAXYfR0/hQZyqE7LykgG+FcAoLoQ4sOEcusky5Dh1+9XqS0aOAWF6dE3qI8VeM1l9QvB
         kwGgFyRgIaLeu1j75eitdCydXBqg4fLJwf111cKlgw1Q4PhnuTV6Gr/4FSKtvorSOWLM
         FDHtcLe2pYkR+bQn+fZpagc4OXbLR+x/6Cy+l59ZRyap+M0f61mYK0BZ+Jx40NN0j5Nn
         9zOQ==
X-Gm-Message-State: AOAM530Ts9ol7gB2DxxTcVf2ZzYkX0VvqJth+d/ruViUlVelYG/QqR0+
        qNbRWaRJp3p6SC2+ynWwlkVA5w==
X-Google-Smtp-Source: ABdhPJydN+P5ZwkGLoLxJVSNSXypXum05RxX0N3o4pvwaY6rUeQx4TwAfDK8+ATcN4/uje330Luq4A==
X-Received: by 2002:a05:6808:150d:: with SMTP id u13mr5398185oiw.155.1638887094092;
        Tue, 07 Dec 2021 06:24:54 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id e26sm2672959oog.46.2021.12.07.06.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 06:24:53 -0800 (PST)
Date:   Tue, 7 Dec 2021 06:26:18 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v1 02/10] dt-bindings: phy: qcom,qmp: Add SM8450 PCIe PHY
 bindings
Message-ID: <Ya9vCkillZqKc6o2@ripper>
References: <20211202141726.1796793-1-dmitry.baryshkov@linaro.org>
 <20211202141726.1796793-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202141726.1796793-3-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu 02 Dec 06:17 PST 2021, Dmitry Baryshkov wrote:

> There are two different PCIe PHYs on SM8450, one having one lane and
> another with two lanes. Add DT bindings for the first one. Support for
> second PCIe host and PHY will be submitted separately.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> index c59bbca9a900..d18075cb2b5d 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> @@ -50,6 +50,7 @@ properties:
>        - qcom,sm8350-qmp-ufs-phy
>        - qcom,sm8350-qmp-usb3-phy
>        - qcom,sm8350-qmp-usb3-uni-phy
> +      - qcom,sm8450-qmp-gen3x1-pcie-phy
>        - qcom,sm8450-qmp-ufs-phy
>        - qcom,sdx55-qmp-pcie-phy
>        - qcom,sdx55-qmp-usb3-uni-phy
> @@ -333,6 +334,7 @@ allOf:
>                - qcom,sm8250-qmp-gen3x1-pcie-phy
>                - qcom,sm8250-qmp-gen3x2-pcie-phy
>                - qcom,sm8250-qmp-modem-pcie-phy
> +              - qcom,sm8450-qmp-gen3x1-pcie-phy
>      then:
>        properties:
>          clocks:
> -- 
> 2.33.0
> 
