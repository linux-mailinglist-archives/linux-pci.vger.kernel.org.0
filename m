Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B096D6B2801
	for <lists+linux-pci@lfdr.de>; Thu,  9 Mar 2023 15:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjCIO5n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Mar 2023 09:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjCIO5X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2023 09:57:23 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF645DCBD
        for <linux-pci@vger.kernel.org>; Thu,  9 Mar 2023 06:53:46 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id x34so2396125pjj.0
        for <linux-pci@vger.kernel.org>; Thu, 09 Mar 2023 06:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678373619;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ajn0irKfODeu29T27vBEk3b6tZAzgItP9Y7adDy5FNY=;
        b=X51svFjqtC/TCcW6bPWDvW2nWe6HnqmaZdaU3RapG4c14StMzoHfQFaA6yVRuOcTYs
         SspI1wIlrYGHWdAL2eR0qZFqfF+0w9jqnCsbQgbckbCw9eiEVUcCI8icdSaDzMFUX7ZW
         Y7wQB1AfbittvehB0lglNiL6hJd/koqdQH/f0RHW6vDxrlSv0ubC1hW1yhht3C7c7nJn
         3aDwpRhMO+1v1AWYHLQKfwDa9p5OmawEsPvEnzIIo+5CYjGi3E7DdjuL+4tAZfe6YSxM
         h6gYNEd0lgNjTE3txJ+3P7FdgnaPMeAiEdrX69b62TcDo5SYHm+1Jhr+LUQoKKQy1DCH
         DntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678373619;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ajn0irKfODeu29T27vBEk3b6tZAzgItP9Y7adDy5FNY=;
        b=NIa6v/5vktGq7Q4ezbOTv6OI/MKJVtlMav+j7Ki4f5QT9jxjs8jIbhcju5PRlMhVKr
         z89irzACFA7YbeYKKQEjmTXIdrRvzqthyaxEwzxnLkaNqfW3WkUv9OYdrk24ge3rhiSP
         y2vSAv3KtX5ixQ3qEcAzqi+zMfIVF7kiU0xYqJMvdYLssuEw6cd8I8Vk+s8CVm+viW8I
         7dc+SM7bJFfY7rQFVg4yHCcveZMKOZK5rYmCIMbm87SWleYqMd7u5zn3gAYdDxSXx91U
         KFHPJoTKfLjrrnHw2vDpfSqfP0c06m1wAQVBcx6Ua3FjQoPScsyTKdCR0Pln398nANxX
         SEZQ==
X-Gm-Message-State: AO0yUKUVzfGrBcdOhaedgxGcGivJCKrWZRAySaekHMb1ffngQDO+ZTGi
        a8bv8MMbCtz4FckLsFdupf7c
X-Google-Smtp-Source: AK7set92yPbWSlSCHKtu9usIcTPG8eCz611nJqbZEe/CFsZ7limy7zblGDwjR3R+vpZ99bzTp9pDQQ==
X-Received: by 2002:a17:902:e5c2:b0:19c:d5c7:e3d5 with SMTP id u2-20020a170902e5c200b0019cd5c7e3d5mr27426127plf.65.1678373618860;
        Thu, 09 Mar 2023 06:53:38 -0800 (PST)
Received: from thinkpad ([27.111.75.67])
        by smtp.gmail.com with ESMTPSA id la15-20020a170902fa0f00b0019ee0ad15b4sm4566964plb.191.2023.03.09.06.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 06:53:38 -0800 (PST)
Date:   Thu, 9 Mar 2023 20:23:28 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 17/17] PCI: qcom: Expose link transition counts via
 debugfs
Message-ID: <20230309145328.GD5151@thinkpad>
References: <20230309085102.120977-1-manivannan.sadhasivam@linaro.org>
 <20230309085102.120977-18-manivannan.sadhasivam@linaro.org>
 <73269ad0-5662-519c-f6c0-e5e2f918cd4e@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73269ad0-5662-519c-f6c0-e5e2f918cd4e@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 09, 2023 at 05:21:38PM +0530, Sricharan Ramabadhran wrote:
> 
> 
> On 3/9/2023 2:21 PM, Manivannan Sadhasivam wrote:
> > Qualcomm PCIe controllers have debug registers in the MHI region that
> > count PCIe link transitions. Expose them over debugfs to userspace to
> > help debug the low power issues.
> > 
> > Note that even though the registers are prefixed as PARF_, they don't
> > live under the "parf" register region. The register naming is following
> > the Qualcomm's internal documentation as like other registers.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >   drivers/pci/controller/dwc/pcie-qcom.c | 59 ++++++++++++++++++++++++++
> >   1 file changed, 59 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index e1180c84f0fa..6d9bde64c9e9 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -10,6 +10,7 @@
> >   #include <linux/clk.h>
> >   #include <linux/crc8.h>
> > +#include <linux/debugfs.h>
> >   #include <linux/delay.h>
> >   #include <linux/gpio/consumer.h>
> >   #include <linux/interconnect.h>
> > @@ -62,6 +63,13 @@
> >   #define AXI_MSTR_RESP_COMP_CTRL1		0x81c
> >   #define MISC_CONTROL_1_REG			0x8bc
> > +/* MHI registers */
> > +#define PARF_DEBUG_CNT_PM_LINKST_IN_L2		0xc04
> > +#define PARF_DEBUG_CNT_PM_LINKST_IN_L1		0xc0c
> > +#define PARF_DEBUG_CNT_PM_LINKST_IN_L0S		0xc10
> > +#define PARF_DEBUG_CNT_AUX_CLK_IN_L1SUB_L1	0xc84
> > +#define PARF_DEBUG_CNT_AUX_CLK_IN_L1SUB_L2	0xc88
> > +
> >   /* PARF_SYS_CTRL register fields */
> >   #define MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN	BIT(29)
> >   #define MST_WAKEUP_EN				BIT(13)
> > @@ -229,11 +237,13 @@ struct qcom_pcie {
> >   	struct dw_pcie *pci;
> >   	void __iomem *parf;			/* DT parf */
> >   	void __iomem *elbi;			/* DT elbi */
> > +	void __iomem *mhi;
> >   	union qcom_pcie_resources res;
> >   	struct phy *phy;
> >   	struct gpio_desc *reset;
> >   	struct icc_path *icc_mem;
> >   	const struct qcom_pcie_cfg *cfg;
> > +	struct dentry *debugfs;
> >   };
> >   #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> > @@ -1385,6 +1395,37 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
> >   	}
> >   }
> > +static int qcom_pcie_link_transition_count(struct seq_file *s, void *data)
> > +{
> > +	struct qcom_pcie *pcie = (struct qcom_pcie *)
> > +				     dev_get_drvdata(s->private);
> > +
> > +	seq_printf(s, "L0s transition count: %u\n",
> > +		   readl_relaxed(pcie->mhi + PARF_DEBUG_CNT_PM_LINKST_IN_L0S));
> > +
> > +	seq_printf(s, "L1 transition count: %u\n",
> > +		   readl_relaxed(pcie->mhi + PARF_DEBUG_CNT_PM_LINKST_IN_L1));
> > +
> > +	seq_printf(s, "L1.1 transition count: %u\n",
> > +		   readl_relaxed(pcie->mhi + PARF_DEBUG_CNT_AUX_CLK_IN_L1SUB_L1));
> > +
> > +	seq_printf(s, "L1.2 transition count: %u\n",
> > +		   readl_relaxed(pcie->mhi + PARF_DEBUG_CNT_AUX_CLK_IN_L1SUB_L2));
> > +
> > +	seq_printf(s, "L2 transition count: %u\n",
> > +		   readl_relaxed(pcie->mhi + PARF_DEBUG_CNT_PM_LINKST_IN_L2));
> > +
> > +	return 0;
> > +}
> > +
> > +static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
> > +{
> > +	struct dw_pcie *pci = pcie->pci;
> > +
> > +	debugfs_create_devm_seqfile(pci->dev, "link_transition_count", pcie->debugfs,
> > +				    qcom_pcie_link_transition_count);
> > +}
> > +
> >   static int qcom_pcie_probe(struct platform_device *pdev)
> >   {
> >   	struct device *dev = &pdev->dev;
> > @@ -1392,6 +1433,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
> >   	struct dw_pcie *pci;
> >   	struct qcom_pcie *pcie;
> >   	const struct qcom_pcie_cfg *pcie_cfg;
> > +	char *name;
> >   	int ret;
> >   	pcie_cfg = of_device_get_match_data(dev);
> > @@ -1439,6 +1481,12 @@ static int qcom_pcie_probe(struct platform_device *pdev)
> >   		goto err_pm_runtime_put;
> >   	}
> > +	pcie->mhi = devm_platform_ioremap_resource_byname(pdev, "mhi");
> > +	if (IS_ERR(pcie->mhi)) {
> > +		ret = PTR_ERR(pcie->mhi);
> > +		goto err_pm_runtime_put;
> > +	}
> > +
> 
>  Tested this series on ipq4019-ap.dk07.1-c1 board and the above hunk
>  breaks enumeration because there is no 'mhi' region. All the debug bits
>  used in the transition_count function is inside the PARF_STTS register
>  at offset 0x24 inside the PARF region.
> 

Ah, "mhi" is supposed to be optional, my bad. Will fix it in next revision.

>  Register: PCIE_0_PCIE20_PARF_PM_STTS | 0x80024
>  Offset:    0x24    Reset State:    0x00040000
> 

Hmm, is this register present on other IPQ/APQ SoCs?

> Bits    Field Name
> 31    LINK_REQ_RST_NOT
> 30    XMLH_LINK_UP
> 29    PM_DSTATE_0
> 0x0: D0
> 0x1: D3
> 28    PHYSTATUS
> 27:16    PM_DSTATE
> 15:12    PM_PME_EN
> 11    PHYCLK_REQ_N
> 10    L1SS_CLKREQN_OE
> 9    L1SS_CLKREQN_IN
> 8    PM_LINKST_IN_L1SUB
> 7    PM_LINKST_IN_L0S
> 6    PM_LINKST_L2_EXIT
> 5    PM_LINKST_IN_L2
> 4    PM_LINKST_IN_L1
> 3:0    PM_STATUS
> 
> Otherwise, with rest of the patches enumeration was fine.
> Tested with a pcie ethernet adapter.
> 

Thanks a lot for testing!

- Mani

> Regards,
>  Sricharan

-- 
மணிவண்ணன் சதாசிவம்
