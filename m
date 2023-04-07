Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CE86DB1EB
	for <lists+linux-pci@lfdr.de>; Fri,  7 Apr 2023 19:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjDGRlM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Apr 2023 13:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjDGRk4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Apr 2023 13:40:56 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B82B755
        for <linux-pci@vger.kernel.org>; Fri,  7 Apr 2023 10:40:27 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1a2104d8b00so233995ad.1
        for <linux-pci@vger.kernel.org>; Fri, 07 Apr 2023 10:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680889206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UXdyG/RfpW67IAK948wzPl6enRAxhE2VH4M4A+6dxLY=;
        b=aJPtgnp01STnN8yZ3rHipVyVyZgjOzxzne2mzs6pTvXzp/G4hooxPtmYVr+/YFfusn
         xWjS367XvmxI+lSEj9tgNCitl894ECVtxCA0jj93itzczzCRzi6YKbjTzTJQWyp49Uyl
         7IKE7boHEaHc0DAW+UElwh/r37V6YtW8IJ0m1erKskA5eAMkMuKaQ3DH7ReeKw/Cwwdx
         Rqu2Vzs8zlizu2r8nyKXY4gh84Y/f85znniWFhZXIABRz1AWuOhqz++n7YQpc5zCeAet
         OmzM+HyNgXYpFhlnI1VLHeJm+1prkIJsXtkWUkn6F+rdMuJwTqUWaG6jfEZ8w23iTzZK
         TGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680889206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXdyG/RfpW67IAK948wzPl6enRAxhE2VH4M4A+6dxLY=;
        b=3P2umG7dZGtfI89wp6rSgGYnqtcximBXIzO1kIGUxXwXnC+/H8XGA5dvhaETkmuLVT
         GVZBeNns8mZHsf3DgK78+f/4TJtCIJq6pm7jV3HPxl44VehxUaAczezAvoLi5tyGki4k
         PFWqpDwfnDhBDYzbW1Ka/zazLOXWxgAI59CDPPF+DKlbrEJ4Y+cP6MjVQbwDMRY7GcRN
         oyYCdIz6au1TMiG3ZhwIw6DElQSb9VwbHsfXBmdI45tknuylqPvtA9l/nsD+0TpNLQXV
         Jl0V4uPpWMFsGQWIm7Z6OPF34xiMu/GPF/+8yCmCg9/95bdbSkmHusSiUiK7m1sFNfui
         iwTQ==
X-Gm-Message-State: AAQBX9dx0tTbhY0tqhNyklrCow393rhozx8HKl1UzzkP3SQZzJ1wGwMf
        6NRaYSNUPysYMHRz0Hc4ZTRx4qM0ioW7n/J0f9MczFrMCOBUIkY5argS9fGs9e14lKdwQSqrCDL
        hTGjUoJMXT5A=
X-Google-Smtp-Source: AKy350bCrPv0R25sh0l/+3mMQYp/fTicFhzU87P9GSWAwQ+DB1Rq+J/ESgOu/nn0jChK278GR5ZV4g==
X-Received: by 2002:a17:902:7b8b:b0:198:af4f:de07 with SMTP id w11-20020a1709027b8b00b00198af4fde07mr227612pll.7.1680889205786;
        Fri, 07 Apr 2023 10:40:05 -0700 (PDT)
Received: from google.com (13.65.82.34.bc.googleusercontent.com. [34.82.65.13])
        by smtp.gmail.com with ESMTPSA id w20-20020a17090a529400b002367325203fsm1374874pjh.50.2023.04.07.10.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 10:40:05 -0700 (PDT)
Date:   Fri, 7 Apr 2023 10:40:01 -0700
From:   William McVicker <willmcvicker@google.com>
To:     Ajay Agarwal <ajayagarwal@google.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sajid Dalvi <sdalvi@google.com>,
        Han Jingoo <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, kernel-team@android.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] PCI: dwc: Wait for link up only if link is started
Message-ID: <ZDBVcczqzte/0r4Q@google.com>
References: <ZC12lN9Cs0QlPhVh@lpieralisi>
 <20230405182753.GA3626483@bhelgaas>
 <ZC3Ev7qnUDdG0cFd@google.com>
 <ZC3Kw4AYiMKY7nCR@google.com>
 <ZC5Bfa2N0aWo0o0l@google.com>
 <ZC6Mov/wX4cbIiNG@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC6Mov/wX4cbIiNG@google.com>
X-ccpol: medium
X-Spam-Status: No, score=-14.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 04/06/2023, 'Ajay Agarwal' via kernel-team wrote:
> Here is my attempt at a patch which can satisfy all the requirements
> (Ideally, I did not want to use `pci->ops` in the host driver but I
> could not figure out any other way):
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
> b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 9952057c8819..39c7219ec7c9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -485,15 +485,18 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	if (ret)
>  		goto err_remove_edma;
>  
> -	if (!dw_pcie_link_up(pci)) {
> -		ret = dw_pcie_start_link(pci);
> +	ret = dw_pcie_start_link(pci);
> +	if (ret)
> +		goto err_remove_edma;
> +
> +	if (dw_pcie_link_up(pci)) {
> +		dw_pcie_print_link_status(pci);
> +	} else if (pci->ops && pci->ops->start_link) {
> +		ret = dw_pcie_wait_for_link(pci);
>  		if (ret)
> -			goto err_remove_edma;
> +			goto err_stop_link;
>  	}
>  
> -	/* Ignore errors, the link may come up later */
> -	dw_pcie_wait_for_link(pci);
> -
>  	bridge->sysdata = pp;
>  
>  	ret = pci_host_probe(bridge);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 53a16b8b6ac2..03748a8dffd3 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -644,9 +644,20 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index)
>  	dw_pcie_writel_atu(pci, dir, index, PCIE_ATU_REGION_CTRL2, 0);
>  }
>  
> -int dw_pcie_wait_for_link(struct dw_pcie *pci)
> +void dw_pcie_print_link_status(struct dw_pcie *pci)
>  {
>  	u32 offset, val;
> +
> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
> +
> +	dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
> +		 FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
> +		 FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
> +}
> +
> +int dw_pcie_wait_for_link(struct dw_pcie *pci)
> +{
>  	int retries;
>  
>  	/* Check if the link is up or not */
> @@ -662,12 +673,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>  		return -ETIMEDOUT;
>  	}
>  
> -	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> -	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
> -
> -	dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
> -		 FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
> -		 FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
> +	dw_pcie_print_link_status(pci);
>  
>  	return 0;
>  }
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 79713ce075cc..615660640801 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -429,6 +429,7 @@ void dw_pcie_setup(struct dw_pcie *pci);
>  void dw_pcie_iatu_detect(struct dw_pcie *pci);
>  int dw_pcie_edma_detect(struct dw_pcie *pci);
>  void dw_pcie_edma_remove(struct dw_pcie *pci);
> +void dw_pcie_print_link_status(struct dw_pcie *pci);
>  
>  static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
>  {
> 
> -- 
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> 

Thanks Ajay for the follow-up patch! I've tested it out on a Pixel 6 and
it's working as intended for me. Probing the PCIe RC device now only
take 0.02s vs ~1.02s. If others don't object, please send it as a v3
patch.

Thanks,
Will
