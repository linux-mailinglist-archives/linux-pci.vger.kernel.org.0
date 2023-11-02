Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B8E7DF8DE
	for <lists+linux-pci@lfdr.de>; Thu,  2 Nov 2023 18:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbjKBRjT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Nov 2023 13:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbjKBRjS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Nov 2023 13:39:18 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA341AD
        for <linux-pci@vger.kernel.org>; Thu,  2 Nov 2023 10:39:11 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7789577b53fso66239485a.3
        for <linux-pci@vger.kernel.org>; Thu, 02 Nov 2023 10:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698946751; x=1699551551; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yE6hYq/1M2NiVA4RY0gsdXB7HPtKFRVy440CKIJ1q9I=;
        b=fjlgh+E8Uy45zhCM02rVK7r5JVPU8mV21NaHmBCbwY6blWAA66pnFB627r4rzrit4p
         BQaGzaP5gKDTH+N4CqpmXRBmwwfl7pRVtvNxgr52hRfthUcLD/bBBLZs2vdbNDrJAY17
         vPbsLVEXQC1Hg9d93fROLa+56y8BIRduBCxil17pnHRh7f9A4Cungj9K4SHcfmwai0yX
         PvVWhW95X5SAhlqs25ZdPy9gutEuCHbzjWs7jayc43PIFthR+Z+DHLNgFgQcyzLdaBYd
         yZjj2n6wjOD2NtGvpGEPeSvyn7LGXuPqfM3Q0mDjS78WqgNLC+q+dbjCoSHFQSaAZSd3
         QGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698946751; x=1699551551;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yE6hYq/1M2NiVA4RY0gsdXB7HPtKFRVy440CKIJ1q9I=;
        b=qgas5U2It/Z3bkv4fCNznOJLSIae33e3ZuAKqsgnQJG7M1Mn7ILHXtzqbNzuD8aTvw
         D5kFN6yBKJbHlmyDqV7ZyIDXZlc6k8dSRMDLUZFCAdMkxxrPlw4pt8MQdk4Q8qKdpogw
         ohSRLe+kgClH3weOIbqWWJbxgGA1PYRvK6pEPUi6By+byT10jtN8/0cXSLeyk995Rk6R
         /m3xvy+pJx7RL7dEi0/alMuVqZiTPqE93l6LD+DBOpEPMSkUzADMj0hp1KJ3elpw77b7
         XTcxPMVEbgKMWKBhK0PKaXiJu4gPcd5gx0Yj541WdMFvIbPqLzr+iZ8sDpiPahKn4X8C
         jkxA==
X-Gm-Message-State: AOJu0YxRvHTJNowMfPnyxghCgV/ukHhAjqmUQxdRgFQyIxT6ztRVtua+
        ocb6+MIOsko0INZ6f/KWdW3I
X-Google-Smtp-Source: AGHT+IGJE7PRlsHRJBiWTBzJ7qskCfmYJqaSK0LlSGhhJCTuiYGeWOKAeIpbrsnv82Z6K6JfC4NtgA==
X-Received: by 2002:a05:620a:2045:b0:779:d143:c1a7 with SMTP id d5-20020a05620a204500b00779d143c1a7mr18609776qka.26.1698946750692;
        Thu, 02 Nov 2023 10:39:10 -0700 (PDT)
Received: from thinkpad ([117.217.189.228])
        by smtp.gmail.com with ESMTPSA id bk2-20020a05620a1a0200b0076e672f535asm127918qkb.57.2023.11.02.10.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 10:39:10 -0700 (PDT)
Date:   Thu, 2 Nov 2023 23:09:00 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     bhelgaas@google.com, imx@lists.linux.dev, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        lpieralisi@kernel.org, minghuan.Lian@nxp.com, mingkai.hu@nxp.com,
        robh@kernel.org, roy.zang@nxp.com
Subject: Re: [PATCH v3 4/4] PCI: layerscape: Add suspend/resume for ls1043a
Message-ID: <20231102173900.GF20943@thinkpad>
References: <20231017193145.3198380-1-Frank.Li@nxp.com>
 <20231017193145.3198380-5-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231017193145.3198380-5-Frank.Li@nxp.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 17, 2023 at 03:31:45PM -0400, Frank Li wrote:
> ls1043a add suspend/resume support.
> Implement ls1043a_pcie_send_turnoff_msg() to send PME_Turn_Off message.
> Implement ls1043a_pcie_exit_from_l2() to exit from L2 state.
> 

Please use the suggestion I gave in patch 2/4.

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Change from v2 to v3
>     - Remove ls_pcie_lut_readl(writel) function
>     
>     Change from v1 to v2
>     - Update subject 'a' to 'A'
> 
>  drivers/pci/controller/dwc/pci-layerscape.c | 86 ++++++++++++++++++++-
>  1 file changed, 85 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> index 4b663b20d8612..9656224960b0c 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> @@ -41,6 +41,15 @@
>  #define SCFG_PEXSFTRSTCR	0x190
>  #define PEXSR(idx)		BIT(idx)
>  
> +/* LS1043A PEX PME control register */
> +#define SCFG_PEXPMECR		0x144
> +#define PEXPME(idx)		BIT(31 - (idx) * 4)
> +
> +/* LS1043A PEX LUT debug register */
> +#define LS_PCIE_LDBG	0x7fc
> +#define LDBG_SR		BIT(30)
> +#define LDBG_WE		BIT(31)
> +
>  #define PCIE_IATU_NUM		6
>  
>  #define LS_PCIE_DRV_SCFG	BIT(0)
> @@ -227,6 +236,68 @@ static int ls1021a_pcie_exit_from_l2(struct dw_pcie_rp *pp)
>  	return 0;
>  }
>  
> +static void ls1043a_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct ls_pcie *pcie = to_ls_pcie(pci);
> +	u32 val;
> +
> +	if (!pcie->scfg) {
> +		dev_dbg(pcie->pci->dev, "SYSCFG is NULL\n");
> +		return;
> +	}

Why scfg is optional for this SoC and not for the other one added in patch 2/4?

> +
> +	/* Send Turn_off message */
> +	regmap_read(pcie->scfg, SCFG_PEXPMECR, &val);
> +	val |= PEXPME(pcie->index);
> +	regmap_write(pcie->scfg, SCFG_PEXPMECR, val);
> +

In my previous review, I asked you to use a common function and just pass the
offsets, as the sequence is same for both the SoCs. But you ignored it :/

> +	/*
> +	 * There is no specific register to check for PME_To_Ack from endpoint.
> +	 * So on the safe side, wait for PCIE_PME_TO_L2_TIMEOUT_US.
> +	 */
> +	mdelay(PCIE_PME_TO_L2_TIMEOUT_US/1000);
> +
> +	/*
> +	 * Layerscape hardware reference manual recommends clearing the PMXMTTURNOFF bit
> +	 * to complete the PME_Turn_Off handshake.
> +	 */
> +	regmap_read(pcie->scfg, SCFG_PEXPMECR, &val);
> +	val &= ~PEXPME(pcie->index);
> +	regmap_write(pcie->scfg, SCFG_PEXPMECR, val);
> +}
> +
> +static int ls1043a_pcie_exit_from_l2(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct ls_pcie *pcie = to_ls_pcie(pci);
> +	u32 val;
> +
> +	/*
> +	 * Only way let PEX module exit L2 is do a software reset.

Same comment applies as patch 2/4.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
