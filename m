Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6527D7CDB20
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 13:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjJRL66 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 07:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjJRL6y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 07:58:54 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BA895;
        Wed, 18 Oct 2023 04:58:51 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-5079eed8bfbso6589686e87.1;
        Wed, 18 Oct 2023 04:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697630329; x=1698235129; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2HZjnaGwa5TvV5dl/sxySQcLOHk4EGrD00dll5PVeJA=;
        b=Lo3VHsSiB66SLdquW962+1d7evyV/+IIhgPRTgXKTCIlg5NwtVGo6dQs9hkyjik8kW
         nFz8AOSH55jrDPT+yjoh56RE6z7tOzAQ6Ndpwt4QKkvttq1jB9vPIuTRFMYCl00Tw0nH
         irrDtUqp5DGIQEOBHHvQUmQRxGypB3W+ZNAIj9FDoQw6KkmfHJr2pLJJx34x7Be2ziTh
         u4sQbZJtKMUutwxUVpkQsnqk+Bzyt90WAtRvcONYhlmnQCbXlwXgRYmUAIWpq94H3TUA
         1a5Di7N34q+OwzBrrmazi60xSLBcMuR/yVeSQfLSOU3CDTkNSddhDg7uciiIwQB101eZ
         JNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697630329; x=1698235129;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2HZjnaGwa5TvV5dl/sxySQcLOHk4EGrD00dll5PVeJA=;
        b=S0TL1E3PtoYLfSUmc5/5BETUWdE67C0Io/XBJW8pTEryY9l095yBFTLNJqSeJJhB2d
         Bo19CCS/HYrzhV8mHO6YZDhjkyJWWzC3OpjZ7dQO6tmNsVfxdPqTjXngr9GNZkdRmbNk
         30Id4tIP/ZGSQKPbA3BlefcvkoshiZf2Sb+YISGSFgIZxs77r2Y9OO3XmC8fOepXuIyi
         cGHfb65+O/Wgmuj+mMvpPsa/alFjatoXqojSYa1Ck/nseRIPffhtIk/kOSJvdgctG/W9
         1srSZz/MGAwjhZPpspavspw6/6x12vzF9f3H/yQNsxDL8VvxCFL3raZXboSZ1xJrE4Ph
         XWuA==
X-Gm-Message-State: AOJu0YyYJqEfEGJgkma7BAuVQs6/CtCKSqxJwTw8S15QTLDfrPMI9n2t
        HktG4cUfzUcNvpzIMOC5r3Q=
X-Google-Smtp-Source: AGHT+IGDRs6ujQYt61uHUyuK2nZPaUHqMKNTJs1USNR1zu9RKEbLV1M3xtEtAllA7nWWty8ovI/qTw==
X-Received: by 2002:ac2:528a:0:b0:507:9625:5fd3 with SMTP id q10-20020ac2528a000000b0050796255fd3mr3691084lfm.32.1697630329349;
        Wed, 18 Oct 2023 04:58:49 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id f13-20020a056512360d00b005007fc9ccccsm679059lfs.122.2023.10.18.04.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 04:58:48 -0700 (PDT)
Date:   Wed, 18 Oct 2023 14:58:46 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 2/7] PCI: dwc: Use FIELD_GET/PREP()
Message-ID: <3o4neokfqofk42zrx5t5su72qmdu2x62rq5u2ywfobqyyg23rc@aksd3afajhwr>
References: <20231018113254.17616-1-ilpo.jarvinen@linux.intel.com>
 <20231018113254.17616-3-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231018113254.17616-3-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 18, 2023 at 02:32:49PM +0300, Ilpo Järvinen wrote:
> Convert open-coded variants of PCI field access into FIELD_GET/PREP()
> to make the code easier to understand.
> 
> Add two missing defines into pci_regs.h. Logically, the Max No-Snoop
> Latency Register is a separate word sized register in the PCIe spec,
> but the pre-existing LTR defines in pci_regs.h with dword long values
> seem to consider the registers together (the same goes for the only
> user). Thus, follow the custom and make the new values also take both
> word long LTR registers as a joint dword register.

Nice work. Thanks! Could you also have a look at
drivers/pci/controller/dwc/pcie-designware.c
?
It contains two open-coded patterns:
(bar << 8) - FIELD_PREP()
next_cap_ptr = (reg & 0xff00) >> 8; - FIELD_GET().
next_cap_ptr = (reg & 0x00ff); - FIELD_GET().
At least the later two statements concern the generic PCIe capability CSR.

-Serge(y)


> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 7 ++++---
>  drivers/pci/controller/dwc/pcie-tegra194.c      | 5 ++---
>  include/uapi/linux/pci_regs.h                   | 2 ++
>  3 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index f9182f8d552f..20bef1436bfb 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -6,6 +6,7 @@
>   * Author: Kishon Vijay Abraham I <kishon@ti.com>
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  
> @@ -334,7 +335,7 @@ static int dw_pcie_ep_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
>  	if (!(val & PCI_MSI_FLAGS_ENABLE))
>  		return -EINVAL;
>  
> -	val = (val & PCI_MSI_FLAGS_QSIZE) >> 4;
> +	val = FIELD_GET(PCI_MSI_FLAGS_QSIZE, val);
>  
>  	return val;
>  }
> @@ -357,7 +358,7 @@ static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	reg = ep_func->msi_cap + func_offset + PCI_MSI_FLAGS;
>  	val = dw_pcie_readw_dbi(pci, reg);
>  	val &= ~PCI_MSI_FLAGS_QMASK;
> -	val |= (interrupts << 1) & PCI_MSI_FLAGS_QMASK;
> +	val |= FIELD_PREP(PCI_MSI_FLAGS_QMASK, interrupts);
>  	dw_pcie_dbi_ro_wr_en(pci);
>  	dw_pcie_writew_dbi(pci, reg, val);
>  	dw_pcie_dbi_ro_wr_dis(pci);
> @@ -584,7 +585,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  
>  	reg = ep_func->msix_cap + func_offset + PCI_MSIX_TABLE;
>  	tbl_offset = dw_pcie_readl_dbi(pci, reg);
> -	bir = (tbl_offset & PCI_MSIX_TABLE_BIR);
> +	bir = FIELD_GET(PCI_MSIX_TABLE_BIR, tbl_offset);
>  	tbl_offset &= PCI_MSIX_TABLE_OFFSET;
>  
>  	msix_tbl = ep->epf_bar[bir]->addr + tbl_offset;
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 248cd9347e8f..12d5ab2f5219 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -126,7 +126,6 @@
>  
>  #define APPL_LTR_MSG_1				0xC4
>  #define LTR_MSG_REQ				BIT(15)
> -#define LTR_MST_NO_SNOOP_SHIFT			16
>  
>  #define APPL_LTR_MSG_2				0xC8
>  #define APPL_LTR_MSG_2_LTR_MSG_REQ_STATE	BIT(3)
> @@ -496,8 +495,8 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
>  		ktime_t timeout;
>  
>  		/* 110us for both snoop and no-snoop */
> -		val = 110 | (2 << PCI_LTR_SCALE_SHIFT) | LTR_MSG_REQ;
> -		val |= (val << LTR_MST_NO_SNOOP_SHIFT);
> +		val = 110 | FIELD_PREP(PCI_LTR_SCALE_SHIFT, 2) | LTR_MSG_REQ;
> +		val |= FIELD_PREP(PCI_LTR_NOSNOOP_VALUE, val);
>  		appl_writel(pcie, val, APPL_LTR_MSG_1);
>  
>  		/* Send LTR upstream */
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index e5f558d96493..495f0ae4ecd5 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -975,6 +975,8 @@
>  #define  PCI_LTR_VALUE_MASK	0x000003ff
>  #define  PCI_LTR_SCALE_MASK	0x00001c00
>  #define  PCI_LTR_SCALE_SHIFT	10
> +#define  PCI_LTR_NOSNOOP_VALUE	0x03ff0000 /* Max No-Snoop Latency Value */
> +#define  PCI_LTR_NOSNOOP_SCALE	0x1c000000 /* Scale for Max Value */
>  #define PCI_EXT_CAP_LTR_SIZEOF	8
>  
>  /* Access Control Service */
> -- 
> 2.30.2
> 
