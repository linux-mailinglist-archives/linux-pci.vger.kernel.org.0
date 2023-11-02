Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEA37DF825
	for <lists+linux-pci@lfdr.de>; Thu,  2 Nov 2023 17:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377114AbjKBQ61 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Nov 2023 12:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377101AbjKBQ61 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Nov 2023 12:58:27 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF83F18E
        for <linux-pci@vger.kernel.org>; Thu,  2 Nov 2023 09:58:20 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b2b1af09c5so665658b6e.0
        for <linux-pci@vger.kernel.org>; Thu, 02 Nov 2023 09:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698944299; x=1699549099; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DfyS21pSAaN9Ul5DPXfGOsxbkU+EJCrhzTnYRsGJibU=;
        b=vYWJ6IGz5IiUWVcVOfopIIgzUrafHCoeoKUcwGX4ujQGvv/ctstHPGnqvsYG1BzbXy
         uTJ1L76cG8eawcblL/ksFM64CzBabkXyqE1tiAODx0lfzUa7/RKKARl97lzUFLI/YqsW
         qEPaSgwIXt3+PYRYLaco91rSMRk4q58GGRIu0Y+pHYRZ6856j5tCKgl6DBqm6udYbSTn
         /e0KZFAW/hcqUsNtOoLpU9O+1G6fa8cHKLBRhsAWEdm3uJBeoZDDDch8IGKyInQS7AAQ
         FUzIY2sJgmKAxSoo7MAM8EPP5+MYVK1UV+OVbUbafwq2iSzhCda5h7SxzH3pNb23jKXx
         P36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698944299; x=1699549099;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DfyS21pSAaN9Ul5DPXfGOsxbkU+EJCrhzTnYRsGJibU=;
        b=KJiHNrjFoFzXe3AgCRDdg2QOXeVxqmKQ3ehXIOnE2je3AGIfugdTCrpczAhYlxS0gz
         jQ9NdRJk85LuJuEOuGiGu22pcSvM0GFy7o4NYh8h/ayCZuUVofF3Dt2GwqPoZqdrw/PF
         GxwUteCm5pllmNYCiPCgjPmNgoO0m5+knw1BtvnfJvbSXeLHh3tE8IvUvzwf/x1lKl0x
         yEFWXRhfJu/ymRt12srT1CTNfhIBdX3UQV5wFX2+qtcLjwizqIekAdSaekL1TBtL77An
         C1JZ5ALaZ9d79E6MDStjwYk6qsYxP5am64DTkj1bbaTX0IwarII3aT//CIgDy5nHB9tT
         +lEQ==
X-Gm-Message-State: AOJu0Yy7DXNq2YMgpeiMTXtjGLhvu/zyKKXGIuaQ1iQ+Klo5+/xgpPhu
        6ieXUiQAzi3NpEUP7Oppg3zM0ryq/zRYWosSWw==
X-Google-Smtp-Source: AGHT+IGcPZMPmb6P3crHIYT6MoFFJH19w/pybMCanZfpyJq0eFqq7TsGozYLDzAec+P33O2PTiZXzg==
X-Received: by 2002:a05:6808:209f:b0:3ad:fe8d:dfae with SMTP id s31-20020a056808209f00b003adfe8ddfaemr20056494oiw.57.1698944298897;
        Thu, 02 Nov 2023 09:58:18 -0700 (PDT)
Received: from thinkpad ([117.217.189.228])
        by smtp.gmail.com with ESMTPSA id z26-20020a05620a08da00b0077263636a95sm89742qkz.93.2023.11.02.09.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 09:58:18 -0700 (PDT)
Date:   Thu, 2 Nov 2023 22:28:08 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     bhelgaas@google.com, imx@lists.linux.dev, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        lpieralisi@kernel.org, minghuan.Lian@nxp.com, mingkai.hu@nxp.com,
        robh@kernel.org, roy.zang@nxp.com
Subject: Re: [PATCH v3 1/4] PCI: layerscape: Add function pointer for
 exit_from_l2()
Message-ID: <20231102165808.GC20943@thinkpad>
References: <20231017193145.3198380-1-Frank.Li@nxp.com>
 <20231017193145.3198380-2-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231017193145.3198380-2-Frank.Li@nxp.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 17, 2023 at 03:31:42PM -0400, Frank Li wrote:
> Since difference SoCs require different sequence for exiting L2, let's add
> a separate "exit_from_l2()" callback. This callback can be used to execute
> SoC specific sequence.
> 

I missed the fact that this patch honors the return value of the callback (which
was ignored previously). So this should be added to the description as well.

> Signed-off-by: Frank Li <Frank.Li@nxp.com>

With that,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> 
> Notes:
>     Change from v2 to v3
>     - fixed according to mani's feedback
>       1. update commit message
>       2. move dw_pcie_host_ops to next patch
>       3. check return value from exit_from_l2()
>     Change from v1 to v2
>     - change subject 'a' to 'A'
>     
>     Change from v1 to v2
>     - change subject 'a' to 'A'
> 
>  drivers/pci/controller/dwc/pci-layerscape.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> index 37956e09c65bd..aea89926bcc4f 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> @@ -39,6 +39,7 @@
>  
>  struct ls_pcie_drvdata {
>  	const u32 pf_off;
> +	int (*exit_from_l2)(struct dw_pcie_rp *pp);
>  	bool pm_support;
>  };
>  
> @@ -125,7 +126,7 @@ static void ls_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
>  		dev_err(pcie->pci->dev, "PME_Turn_off timeout\n");
>  }
>  
> -static void ls_pcie_exit_from_l2(struct dw_pcie_rp *pp)
> +static int ls_pcie_exit_from_l2(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct ls_pcie *pcie = to_ls_pcie(pci);
> @@ -150,6 +151,8 @@ static void ls_pcie_exit_from_l2(struct dw_pcie_rp *pp)
>  				 10000);
>  	if (ret)
>  		dev_err(pcie->pci->dev, "L2 exit timeout\n");
> +
> +	return ret;
>  }
>  
>  static int ls_pcie_host_init(struct dw_pcie_rp *pp)
> @@ -180,6 +183,7 @@ static const struct ls_pcie_drvdata ls1021a_drvdata = {
>  static const struct ls_pcie_drvdata layerscape_drvdata = {
>  	.pf_off = 0xc0000,
>  	.pm_support = true,
> +	.exit_from_l2 = ls_pcie_exit_from_l2,
>  };
>  
>  static const struct of_device_id ls_pcie_of_match[] = {
> @@ -247,11 +251,14 @@ static int ls_pcie_suspend_noirq(struct device *dev)
>  static int ls_pcie_resume_noirq(struct device *dev)
>  {
>  	struct ls_pcie *pcie = dev_get_drvdata(dev);
> +	int ret;
>  
>  	if (!pcie->drvdata->pm_support)
>  		return 0;
>  
> -	ls_pcie_exit_from_l2(&pcie->pci->pp);
> +	ret = pcie->drvdata->exit_from_l2(&pcie->pci->pp);
> +	if (ret)
> +		return ret;
>  
>  	return dw_pcie_resume_noirq(pcie->pci);
>  }
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
