Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041AC6E81E8
	for <lists+linux-pci@lfdr.de>; Wed, 19 Apr 2023 21:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjDST3V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Apr 2023 15:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjDST3U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Apr 2023 15:29:20 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0024132
        for <linux-pci@vger.kernel.org>; Wed, 19 Apr 2023 12:29:18 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1a652700c36so226245ad.0
        for <linux-pci@vger.kernel.org>; Wed, 19 Apr 2023 12:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681932558; x=1684524558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IGsM6giMJ8jEMRE16CRgLycYEggEEJdPAU7brk8BtS0=;
        b=3pPZRlDEPaqyX7DR39qGhZwgQFFV32xBdFhiM7hNLwha7KGAeM7WTwuK9N5tbkm3UR
         +VdHnwxaRos73xvmoZD4tDFhc31Ha0WTt7eTzxSzdCb53ny6Czq+B8ySlqgLq1W+jmx0
         JPbSJPdimFGZ7HNMiCgOvk4MSTjXqFQpmBh2al00FzP54uqsddji8QHlvCk7YYx5jmdg
         n8RjJ9l1xlczREsabn6rSd1h+LqcOsK+HieWMfXNYLSCXuF6Te3cwYXffh+WErrJLI9q
         3C9b0jUYyGyNzrCmb9PBEPRpweM/W5OhJAvH9KSkjPlizo8dYfJ3HGxj+jQpaROl7ygZ
         Ux+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681932558; x=1684524558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGsM6giMJ8jEMRE16CRgLycYEggEEJdPAU7brk8BtS0=;
        b=BIDb6cpRFXRWpUU82UNaGV/najUMpjLLd/SfAxKHRj2/3T3/kLfZZPsD35HDNTUWsO
         kWMb3s2i+G37MKTyCw9j8qPLoYNpeZOwsV3227LekSRJ69oFQVmqwTGaGDq9L5sOAmiQ
         oYwpbSNYRY0LKcb0CQfPmlhsTd1wlHZVJ0cSXAGnFFveoWcmUSf9M2+lhz6MUNRKBokO
         /l1QPCWTAmYPNC6xXY+uQwU2OyP5/PHAs8OE9JvUrtsUl3KlEGDtUCZtyEsLkhwoM+xp
         0fkQgwCpT1EUtlEAk2DdssB2ncqBsQAaDPDWgtL97AiQ9359e07GOgBWGS98wXHJIX/P
         zC2A==
X-Gm-Message-State: AAQBX9eTUzFYAyRuAjEtLn0pov+SEaCeT6XErtI6NQAFJSsvrClZxv/9
        y5QY4y4+gAmNoxuyQBi85pYOauqyifPYzIUi8Gz+jmMRafKJ1rQwH9FPmdoDIpoO4hmeNO9dlyU
        7aq1OtWtJjCc=
X-Google-Smtp-Source: AKy350aFY3iDR/NUpn8mtVaPoGjOA/1RnbaaaNJo7ZL9aw0YdlPFPZ+JLOpGjHzNg3YqrAko2WANAg==
X-Received: by 2002:a17:902:e752:b0:1a6:42f0:e575 with SMTP id p18-20020a170902e75200b001a642f0e575mr31479plf.5.1681932558191;
        Wed, 19 Apr 2023 12:29:18 -0700 (PDT)
Received: from google.com (13.65.82.34.bc.googleusercontent.com. [34.82.65.13])
        by smtp.gmail.com with ESMTPSA id p11-20020a170902a40b00b001a240f053aasm918792plq.180.2023.04.19.12.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 12:29:17 -0700 (PDT)
Date:   Wed, 19 Apr 2023 12:29:14 -0700
From:   William McVicker <willmcvicker@google.com>
To:     Ajay Agarwal <ajayagarwal@google.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Nikhil Devshatwar <nikhilnd@google.com>,
        Manu Gautam <manugautam@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sajid Dalvi <sdalvi@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4] PCI: dwc: Wait for link up only if link is started
Message-ID: <ZEBBCg3DEhytqnMb@google.com>
References: <20230412093425.3659088-1-ajayagarwal@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412093425.3659088-1-ajayagarwal@google.com>
X-ccpol: medium
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 04/12/2023, Ajay Agarwal wrote:
> In dw_pcie_host_init() regardless of whether the link has been
> started or not, the code waits for the link to come up. Even in
> cases where start_link() is not defined the code ends up spinning
> in a loop for 1 second. Since in some systems dw_pcie_host_init()
> gets called during probe, this one second loop for each pcie
> interface instance ends up extending the boot time.
> 
> Wait for the link up in only if the start_link() is defined.
> 
> Signed-off-by: Sajid Dalvi <sdalvi@google.com>
> Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> ---
> Changelog since v3:
> - Run dw_pcie_start_link() only if link is not already up
> 
> Changelog since v2:
> - Wait for the link up if start_link() is really defined.
> - Print the link status if the link is up on init.
> 
>  .../pci/controller/dwc/pcie-designware-host.c | 13 ++++++++----
>  drivers/pci/controller/dwc/pcie-designware.c  | 20 ++++++++++++-------
>  drivers/pci/controller/dwc/pcie-designware.h  |  1 +
>  3 files changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 9952057c8819..cf61733bf78d 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -485,14 +485,19 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	if (ret)
>  		goto err_remove_edma;
>  
> -	if (!dw_pcie_link_up(pci)) {
> +	if (dw_pcie_link_up(pci)) {
> +		dw_pcie_print_link_status(pci);
> +	} else {
>  		ret = dw_pcie_start_link(pci);
>  		if (ret)
>  			goto err_remove_edma;
> -	}
>  
> -	/* Ignore errors, the link may come up later */
> -	dw_pcie_wait_for_link(pci);
> +		if (pci->ops && pci->ops->start_link) {
> +			ret = dw_pcie_wait_for_link(pci);
> +			if (ret)
> +				goto err_stop_link;
> +		}
> +	}
>  
>  	bridge->sysdata = pp;
>  
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
> -- 
> 2.40.0.577.gac1e443424-goog
> 

Thanks for sending this patch Ajay! I tested this on my Pixel 6 with 6.3-rc1.
I verified the PCIe RC probes without the 1s delay in dw_pcie_wait_for_link().
Feel free to include

Tested-by: Will McVicker <willmcvicker@google.com>
