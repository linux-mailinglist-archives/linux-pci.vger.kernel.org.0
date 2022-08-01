Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1130586B7A
	for <lists+linux-pci@lfdr.de>; Mon,  1 Aug 2022 15:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiHANAH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Aug 2022 09:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiHANAG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Aug 2022 09:00:06 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1861A6
        for <linux-pci@vger.kernel.org>; Mon,  1 Aug 2022 06:00:05 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id h21-20020a17090aa89500b001f31a61b91dso12312955pjq.4
        for <linux-pci@vger.kernel.org>; Mon, 01 Aug 2022 06:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WMttnS6786b423fQsUol7xp6daZx9WIRE9Va6l8vCz0=;
        b=TdvGEzzjPigBTAV/dJ0yqMMPTywQkqPnT3xWMLzHjEKXbliDR63GJyDkApkmmAwGNV
         0QOM3frpgoyipK6QjQE/w6+DNROMdqo/6RyzqoT2KuVHdo8PyH4LevkBNfHOj1hxanAi
         uhyX68xf46SQmShSv4H9+l40m6ZCyhb4SnnrgY4dAKAExYDlsxdndWS26XPX6szWCUKr
         Y3Xn1E88jQb/V4e3mxA1aab0GiBTyv4l+qhNMIh4abQ1A+Ftgt7mr39HSCKzjYWKD+wU
         GzTcdCyVsLkK9j4rvuVsD5MqaYR+vERD0NFrYj3ltKwVNsYA2zb8ityKUieNxFucLt35
         CbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WMttnS6786b423fQsUol7xp6daZx9WIRE9Va6l8vCz0=;
        b=N7+9wCsMDp0bwkNCNZHOdOB9KOwD9CKDpU4qqxhL95sa0GS+oJjxOoK2SlC2yzjXDg
         LpYcVT3R87TBleBaOQxRgMBL75gFkDNzHw9r2cOJZllIrTRlyLdFNws/p8vQ0Go21wU9
         4m9MeZz3n9UwoaE92VNBzJIRTmDc3ZEn2vtadCe6np7OItZSFSgjpjLDlRw9q40NqnTV
         JIaDaHy5wxNAX59YtxH4iDX5gBn7vWjqZVi+umdK8VO0YPsNBwBJcnaNyov4jIyxKwRW
         syWjBbjFNKnBUT91VIgqeK08okDjnXbN0AoPsreSoJ5vbZ333yFhg8ngLuw9d6d9JJ6S
         XRew==
X-Gm-Message-State: ACgBeo07u7jt4xMiTTzUpSVeGh66vc8R3VyWitGWFy8ZLBVIuCfIBGDx
        ebRiMBsvLyA6x/MdzALS3GC8
X-Google-Smtp-Source: AA6agR5yiSZwGmqaUz5kg61unyw5YhM4CiMdmJiQOLhVV+ii1rYUbBGpG6ooO9+RQMoNvr56N3b0Ew==
X-Received: by 2002:a17:902:d487:b0:16d:8b0d:fd2e with SMTP id c7-20020a170902d48700b0016d8b0dfd2emr16755245plg.134.1659358804376;
        Mon, 01 Aug 2022 06:00:04 -0700 (PDT)
Received: from thinkpad ([117.217.185.73])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902ea1200b0016c28fbd7e5sm9768080plg.268.2022.08.01.05.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 06:00:04 -0700 (PDT)
Date:   Mon, 1 Aug 2022 18:29:49 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4 01/15] PCI: dwc: Add more verbose link-up
 message
Message-ID: <20220801125949.GA93763@thinkpad>
References: <20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru>
 <20220624143947.8991-2-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220624143947.8991-2-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 24, 2022 at 05:39:33PM +0300, Serge Semin wrote:
> Printing just "link up" isn't that much informative especially when it
> comes to working with the PCI Express bus. Even if the link is up, due to
> multiple reasons the bus performance can degrade to slower speeds or to
> narrower width than both Root Port and its partner is capable of. In that
> case it would be handy to know the link specifications as early as
> possible. So let's add a more verbose message to the busy-wait link-state
> method, which will contain the link speed generation and the PCIe bus
> width in case if the link up state is discovered. Otherwise an error will
> be printed to the system log.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> ---
> 
> Changelog v2:
> - Test the error condition first and return straight away if it comes true.
>   The typical return is better to be unindented (@Joe).
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 22 ++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index ce01187947c9..e66d16a86168 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -524,20 +524,30 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
>  
>  int dw_pcie_wait_for_link(struct dw_pcie *pci)
>  {
> +	u32 offset, val;
>  	int retries;
>  
>  	/* Check if the link is up or not */
>  	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
> -		if (dw_pcie_link_up(pci)) {
> -			dev_info(pci->dev, "Link up\n");
> -			return 0;
> -		}
> +		if (dw_pcie_link_up(pci))
> +			break;
> +
>  		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
>  	}
>  
> -	dev_info(pci->dev, "Phy link never came up\n");
> +	if (retries >= LINK_WAIT_MAX_RETRIES) {
> +		dev_err(pci->dev, "Phy link never came up\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
>  
> -	return -ETIMEDOUT;
> +	dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
> +		 FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
> +		 FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_wait_for_link);
>  
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
