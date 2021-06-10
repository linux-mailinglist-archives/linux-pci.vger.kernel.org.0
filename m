Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D0D3A36B5
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jun 2021 23:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhFJVzX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Jun 2021 17:55:23 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:35468 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhFJVzW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Jun 2021 17:55:22 -0400
Received: by mail-pg1-f171.google.com with SMTP id o9so838710pgd.2;
        Thu, 10 Jun 2021 14:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iEZb1HAGunNhdY/5Q0B2TV+VUw7SSqmOp3IfiC1KV6w=;
        b=LlM0EbxyzOdNSgxyKNDPYtwDG1WVHV+v4fouU3DbziOjdnCFbtqXLM7cBPaqmHn/wY
         zQrUE1e6OaFw6hcH0WXCkqqRxcukL3q3bzaCOTTqfBRCiYcmu03tF2nbNubikt92uekU
         o3vVJgH0RGd7biDy05iNc6pqv2cdGIwToCXOtACVtx0zSuKs7biRJzGjaALlyKHbPm6/
         uQ685VztdDyalme+cY9E6FAM8r81704fyMvE6Kz/KRLt9E+fFt/Qk+eT2LUJNhXAketD
         jAW9uloYiRJtQr1YXyIBnnyRJmw69R3cLbvNIsHr+3oOY5dDHSOnpEyT4TTbBfUJbnS/
         BcOw==
X-Gm-Message-State: AOAM531yJYGQ0hsuUnP8uxb5UR1U2kh7K0j7Bn3tI9aVm0LNJXV53mvr
        Z5TmPRvPZNOiF4OmSlc1M7gGZRzaVQ==
X-Google-Smtp-Source: ABdhPJw2uSITGPgILdhT5spNIAo7woiW7K/FwcK/RX8wK9+o6A5ugRaagkUTjKfKG++E54w8NU8sRw==
X-Received: by 2002:a63:e316:: with SMTP id f22mr470463pgh.100.1623361993434;
        Thu, 10 Jun 2021 14:53:13 -0700 (PDT)
Received: from robh.at.kernel.org ([208.184.162.218])
        by smtp.gmail.com with ESMTPSA id h8sm3326621pjf.7.2021.06.10.14.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 14:53:11 -0700 (PDT)
Received: (nullmailer pid 2435399 invoked by uid 1000);
        Thu, 10 Jun 2021 21:46:48 -0000
Date:   Thu, 10 Jun 2021 16:46:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: pci: Add devicetree binding for
 Qualcomm PCIe EP controller
Message-ID: <20210610214648.GA2407603@robh.at.kernel.org>
References: <20210603103814.95177-1-manivannan.sadhasivam@linaro.org>
 <20210603103814.95177-2-manivannan.sadhasivam@linaro.org>
 <YLw9de/J7h5KZtHu@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLw9de/J7h5KZtHu@builder.lan>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jun 05, 2021 at 10:13:57PM -0500, Bjorn Andersson wrote:
> On Thu 03 Jun 05:38 CDT 2021, Manivannan Sadhasivam wrote:
> 
> > Add devicetree binding for Qualcomm PCIe EP controller used in platforms
> > like SDX55. The EP controller is based on the Designware core with
> > Qualcomm specific wrappers.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  .../devicetree/bindings/pci/qcom,pcie-ep.yaml | 144 ++++++++++++++++++
> >  1 file changed, 144 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> > new file mode 100644
> > index 000000000000..3e357cb03a5c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> > @@ -0,0 +1,144 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/qcom,pcie-ep.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm PCIe Endpoint Controller binding
> > +
> > +maintainers:
> > +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > +
> > +allOf:
> > +  - $ref: "pci-ep.yaml#"
> > +
> > +properties:
> > +  compatible:
> > +    const: qcom,sdx55-pcie-ep
> 
> The binding looks good, but this is going to cause us an inevitable
> warning as we'd have to describe the controller twice (rc + ep) in the
> sdx55.dtsi.
> 
> @Rob, what do you suggest we do about this, because it's the same
> problem currently responsible for hundreds of warnings in the case of
> GENI (where each node is duplicated for different functions).

What determines the mode? Assuming it is fixed for a platform, can't you 
just have 2 .dtsi files and include the right one. The SoC file could 
have the common h/w specific parts (clks, resets, etc.) as those 
shouldn't really be different depending on the mode. IIRC, some PCI 
bindings do this by design (meaning there's only one definition).

Rob
