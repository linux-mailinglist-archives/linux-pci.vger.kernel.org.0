Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E6D26D02B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 02:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgIQAsB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 20:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgIQAsA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Sep 2020 20:48:00 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4420AC06178C
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2020 17:39:42 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id n61so303352ota.10
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2020 17:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qnQdbtqxCDTIqKqOna77dN+ZLQyEkOzOK58YwCfa3H0=;
        b=XBAadIW9bVAGcIfHj9raEdIjBWaRKYLD5ma49V74gb5amE/rxRwD89ELv8aJK5GhCF
         g1V25+4dqH1vN3CXRDMj0Cp2+YXyDxcXTFX3mum5Mws9Tdj6d9KpshqpiQfJoW87E12v
         iy2hdSvA4fm0U+tImJWAFOwoE04Qt1KzTZXbkGLU4IuttxOh0fp9voDy4ewqGNVrYqIO
         6Zx26upjeuOiz1MaDt9bS1g/oR3eRrp5DYc24ayXEJI904gH/TBAsy5YsaZLDqKOMkDA
         ACHMb3MYiUK8xyn5/jcZbEZ5UYahXAWyu5UWRg33iZUp1JgnSiTl1gp90GDwEhUpPnXa
         gzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qnQdbtqxCDTIqKqOna77dN+ZLQyEkOzOK58YwCfa3H0=;
        b=j1UWiwyq7BTYPSYey4Yf7QZ+gsrg6yX44nMKsEVkdRIu6MPYWVZqbZN9BC/KPYppWq
         kDnQ7SZTh1HPDXSGTTdGG+bQTSTl5+VE+F+QJwFjSIYVvPjtwccp829HCSpiAHuXvpIq
         Kv9mAT17gwsJSq/i56l98OPhRpFw9fk/mc3j4cIjZUckZ7+gzLgX84h3tkPSFp3Oq2O1
         pKUWt9kA/vEaJH8W/WMgoR97p6HKdJ1+oXCFMye46a+G9GuRXiRm3aqlDcKP/F6DNnCu
         9Fz03WJA9rR28hxOrKute++zoZmTM3rS1mB/6bsheWJsb4XER/IBGm+avDwKOppXBUAK
         pLeg==
X-Gm-Message-State: AOAM533yj6bpsb5LIeN2CQrKzxcBEWwGmcfzgyAhrxOStOHFeaxWGcku
        KtHKKWyg7ddK4FllEIC8a3ifwA==
X-Google-Smtp-Source: ABdhPJzYgxc/qCjtDcdsd3TwLr0HUaOJpA8OKmX8Hc2wBd9RfexwmyUmEf463C3CLCZQpPADunp2YQ==
X-Received: by 2002:a9d:335:: with SMTP id 50mr3923676otv.90.1600303181463;
        Wed, 16 Sep 2020 17:39:41 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:7cad:6eff:fec8:37e4])
        by smtp.gmail.com with ESMTPSA id u2sm10507631oig.48.2020.09.16.17.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 17:39:40 -0700 (PDT)
Date:   Wed, 16 Sep 2020 19:39:37 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     agross@kernel.org, kishon@ti.com, vkoul@kernel.org,
        robh@kernel.org, svarbanov@mm-sol.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgautam@codeaurora.org, devicetree@vger.kernel.org,
        Jonathan Marek <jonathan@marek.ca>
Subject: Re: [PATCH 5/5] pci: controller: dwc: qcom: Harcode PCIe config SID
Message-ID: <20200917003937.GI1893@yoga>
References: <20200916132000.1850-1-manivannan.sadhasivam@linaro.org>
 <20200916132000.1850-6-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916132000.1850-6-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed 16 Sep 08:20 CDT 2020, Manivannan Sadhasivam wrote:

> Hardcode the PCIe config SID table value. This is needed to avoid random
> MHI failure observed during reboot on SM8250.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> [mani: stripped out unnecessary settings and ported for upstream]
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index ca8ad354e09d..50748016ce96 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -57,6 +57,7 @@
>  #define PCIE20_PARF_SID_OFFSET			0x234
>  #define PCIE20_PARF_BDF_TRANSLATE_CFG		0x24C
>  #define PCIE20_PARF_DEVICE_TYPE			0x1000
> +#define PCIE20_PARF_BDF_TO_SID_TABLE_N		0x2000
>  
>  #define PCIE20_ELBI_SYS_CTRL			0x04
>  #define PCIE20_ELBI_SYS_CTRL_LT_ENABLE		BIT(0)
> @@ -1290,6 +1291,9 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
>  	if (ret)
>  		goto err;
>  
> +	writel(0x0, pcie->parf + PCIE20_PARF_BDF_TO_SID_TABLE_N);
> +	writel(0x01000100, pcie->parf + PCIE20_PARF_BDF_TO_SID_TABLE_N + 0x054);

This needs to be properly implemented.

The mechanism at hand is responsible for mapping BDFs by the means of a
BDF->SID hash table.  Per the downstream kernel the hash is 256 entries
of 32 bits registers.  The slot is selected by taking the crc8() of the
BDF (in big endian) and in that slot encode the BDF in the upper 16
bits, followed by the SID (relative to the first SID of the controller)
in the next 8 and finally the index of the next entry in cases of
collisions.

Also like the downstream kernel you can extract this information from
the iommu-map property. But note that the last cell in the iommu-map is
"length", not mask as in the typical iommus property - so you would need
to install "length" entries in the hash table, for each iommu-map.



Finally, this was first introduced in SM8150, so it can not be done
unconditionally in qcom_pcie_host_init(). The previous hardware used a
different mechanism for configuring this information.

Regards,
Bjorn

> +
>  	return 0;
>  err:
>  	qcom_ep_reset_assert(pcie);
> -- 
> 2.17.1
> 
