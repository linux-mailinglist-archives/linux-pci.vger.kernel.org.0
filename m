Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBEB7283DC
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jun 2023 17:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236952AbjFHPmP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jun 2023 11:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236694AbjFHPmO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jun 2023 11:42:14 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC1F26BF
        for <linux-pci@vger.kernel.org>; Thu,  8 Jun 2023 08:42:13 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-65242634690so494322b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 08 Jun 2023 08:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686238933; x=1688830933;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3+rKvrAD/3nB2Hd54+Q6FhE04OWPXzOgHlJeP4uTSYI=;
        b=EW/FEZ1hRNriBFCYTSUYpdyPARm5xrJF7p1xRkAq83W3FeD5hEjd7PdvLMr6Bsk8ax
         d4gl1hEcJVl3FI8+o/OKhqyGNfDWNL5JBBl5kZceFrh7PcbSq6Nzf2gZR6lmUDx+3g1F
         yoOf20mC0MSZ4RH04jW4FxTH+2YHdp6IcKlFEPoK896I2W8Hc5hM3HYO/qiGnBXx6O3Q
         TIAzSNETwdeGiljphhUaMTHZ6LFJ/JQXGfYrRQrmeW82Y4pTOOpjvkFXSlZQ8PvKTIUs
         zwZLHChmK7brJu9o9A+K5dujaVkUElnA/Yuby4hFZKuB7oG60tQJ2yBw/QQhd9O9pg/U
         ioYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686238933; x=1688830933;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3+rKvrAD/3nB2Hd54+Q6FhE04OWPXzOgHlJeP4uTSYI=;
        b=Pq3fCMmMBiNoTxl7+fOxNfpNGMauzYRZ8wvr6/ZLIf9N9V0ZYW79RYjqXAxMwJLr54
         +9eJGSxw0GiqW7Ly6aAFuYml8hX1ah8c/ptdPquDMp5IleCwnH3kaViFXUyBeGy5ux2G
         CW0h4AZJxoByJa0EnRj22/rcqYnSfZxL+MctxZFta0NztXXs5wZ6XY407+p7ZYAEdOH0
         cHgfkwYiTJbRBeW/NVIE3x03iQ0rPAFOD7PqciFThmWojKDjfSMSugtty5AhK7LPQwFl
         clll9CamGcDbb5YS9RoK1MJovJXrsQECcq9oLngJfcOQPu6OyRu2mQv1UqF9BCs3fZg5
         ZDog==
X-Gm-Message-State: AC+VfDz6aPgCjVbysK6iakEvrfYtkTsJ4GKqtzvVX8DiUtiDhuajdws6
        BnpJCiJRue/hgYdXPjA2m9Xl
X-Google-Smtp-Source: ACHHUZ45EfcovmCH6MJOJnFO9JOWnolDTC/51ybxq4NN+brr8ImWPVqwLSrTA4MMnvdD3XGrzuY0/g==
X-Received: by 2002:a05:6a20:3d03:b0:114:7637:3451 with SMTP id y3-20020a056a203d0300b0011476373451mr5498027pzi.37.1686238932752;
        Thu, 08 Jun 2023 08:42:12 -0700 (PDT)
Received: from thinkpad ([117.202.186.138])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d50400b001ae0a4b1d3fsm1601927plg.153.2023.06.08.08.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 08:42:12 -0700 (PDT)
Date:   Thu, 8 Jun 2023 21:12:06 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     tjoseph@cadence.com, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, nadeem@cadence.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, vigneshr@ti.com, srk@ti.com,
        nm@ti.com
Subject: Re: [PATCH v3] PCI: cadence: Fix Gen2 Link Retraining process
Message-ID: <20230608154206.GI5672@thinkpad>
References: <20230607091427.852473-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230607091427.852473-1-s-vadapalli@ti.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 07, 2023 at 02:44:27PM +0530, Siddharth Vadapalli wrote:
> The Link Retraining process is initiated to account for the Gen2 defect in
> the Cadence PCIe controller in J721E SoC. The errata corresponding to this
> is i2085, documented at:
> https://www.ti.com/lit/er/sprz455c/sprz455c.pdf
> 
> The existing workaround implemented for the errata waits for the Data Link
> initialization to complete and assumes that the link retraining process
> at the Physical Layer has completed. However, it is possible that the
> Physical Layer training might be ongoing as indicated by the
> PCI_EXP_LNKSTA_LT bit in the PCI_EXP_LNKSTA register.
> 
> Fix the existing workaround, to ensure that the Physical Layer training
> has also completed, in addition to the Data Link initialization.
> 

cdns_pcie_host_wait_for_link() function is called even for the non-quirky cases
as well, so does this patch. But if your patch is only targeting the link
retraining case, you should move the logic to cdns_pcie_retrain().


> Fixes: 4740b969aaf5 ("PCI: cadence: Retrain Link to work around Gen2 training defect")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
> 
> Hello,
> 
> This patch is based on linux-next tagged next-20230606.
> 
> v2:
> https://lore.kernel.org/r/20230315070800.1615527-1-s-vadapalli@ti.com/
> Changes since v2:
> - Merge the cdns_pcie_host_training_complete() function with the
>   cdns_pcie_host_wait_for_link() function, as suggested by Bjorn
>   for the v2 patch.
> - Add dev_err() to notify when Link Training fails, since this is a
>   fatal error and proceeding from this point will almost always crash
>   the kernel.
> 
> v1:
> https://lore.kernel.org/r/20230102075656.260333-1-s-vadapalli@ti.com/
> Changes since v1:
> - Collect Reviewed-by tag from Vignesh Raghavendra.
> - Rebase on next-20230315.
> 
> Regards,
> Siddharth.
> 
>  .../controller/cadence/pcie-cadence-host.c    | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index 940c7dd701d6..70a5f581ff4f 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -12,6 +12,8 @@
>  
>  #include "pcie-cadence.h"
>  
> +#define LINK_RETRAIN_TIMEOUT HZ
> +
>  static u64 bar_max_size[] = {
>  	[RP_BAR0] = _ULL(128 * SZ_2G),
>  	[RP_BAR1] = SZ_2G,
> @@ -80,8 +82,26 @@ static struct pci_ops cdns_pcie_host_ops = {
>  static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
>  {
>  	struct device *dev = pcie->dev;
> +	unsigned long end_jiffies;
> +	u16 link_status;
>  	int retries;
>  
> +	/* Wait for link training to complete */
> +	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
> +	do {
> +		link_status = cdns_pcie_rp_readw(pcie, CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_LNKSTA);
> +		if (!(link_status & PCI_EXP_LNKSTA_LT))
> +			break;
> +		usleep_range(0, 1000);
> +	} while (time_before(jiffies, end_jiffies));
> +
> +	if (!(link_status & PCI_EXP_LNKSTA_LT)) {
> +		dev_info(dev, "Link training complete\n");

This info is not needed.

> +	} else {
> +		dev_err(dev, "Fatal! Link training incomplete\n");

This could be, "Link retraining incomplete".

- Mani

> +		return -ETIMEDOUT;
> +	}
> +
>  	/* Check if the link is up or not */
>  	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
>  		if (cdns_pcie_link_up(pcie)) {
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
