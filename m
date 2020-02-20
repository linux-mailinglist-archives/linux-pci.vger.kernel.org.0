Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 739681664CA
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2020 18:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgBTR2l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Feb 2020 12:28:41 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38570 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgBTR2l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Feb 2020 12:28:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id e8so5565665wrm.5
        for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2020 09:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yg7V2Kitryz7uYVlNn64dGZz3YZSbyjf9HbgWJJRDAs=;
        b=CmcyeEBOB0TBNIvz/p5XwnAlafyqGrCgVEgvaMgTdOyuEONJXLWP2BuiWcL4WTxOud
         aUmSx7qqn2snU2zgLbXE/a66nZ3j+UuSMi6wHwMi4skzKVGsuRninJFjVqkPpPvuleLN
         8oPei3Ks+Bok6gh12rhXHBfAPK68q+J3FZYwlmxH1pT4bAB8lri9bhSDZ9SJzQdSiaTS
         ZP/lWL+rjHiKe5nRyh/+DBhzVnRap+ng90tFDcMfJDiN90TXG4QRa9gYT0too8nHBeRy
         1bX7b/t+H2/IYLVuJNZLgSYdBe1IGb/tJnbQF1UMxedMk6fr0hWAmTyry39gpCbWcW80
         Oigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yg7V2Kitryz7uYVlNn64dGZz3YZSbyjf9HbgWJJRDAs=;
        b=WUY6tSaq7tNlZqG8cDtiMs3pXXRUSpO8naFMq7PmNAcGrLaEFWQSdxJEIiBEKbaOBI
         v2XLsSzMPA6FPGe6+aDOpctx38HUVYsm2Drh3eeb99UjeJAABpPD1n/JJRjE6p/7Va+R
         3uKloDikI3fVTJCArlAgE0rwchUSlsK4kAmcTRsvX6KxiuzdXjim2nqdC4ppZ0q/Qxje
         KE3Wx1eFyE1jF3JQS0OK6uF/3fP3r/SXchsZswQJoIwC1bFj6MFliZK1LlXcmQCUoQiD
         xp1T07s+eynlm6r/WPo6qLIDlSiHT8pdqUlY78mo6AdLKlOImyanbcuYV3YXsKBoHhL5
         6pNA==
X-Gm-Message-State: APjAAAUbrOfhKL//Q9eXYw5c2vIFbqPuIKeb0cgGsWNd7Nz5cBIPRr5K
        0vs932Xz5pfUxT1N9077Lwwhug==
X-Google-Smtp-Source: APXvYqzcciySjNsv1+b17UtCc7Fw4uKQANx0Sd40ea91V7lOrEtBQbKyOMSjPgOQOSdAmaRoO3SEBQ==
X-Received: by 2002:adf:ed09:: with SMTP id a9mr44518842wro.350.1582219719426;
        Thu, 20 Feb 2020 09:28:39 -0800 (PST)
Received: from big-machine ([2a00:23c5:dd80:8400:98d8:49e6:cdcc:25df])
        by smtp.gmail.com with ESMTPSA id 2sm252807wrq.31.2020.02.20.09.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 09:28:38 -0800 (PST)
Date:   Thu, 20 Feb 2020 17:28:37 +0000
From:   Andrew Murray <amurray@thegoodpenguin.co.uk>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, andrew.murray@arm.com,
        arnd@arndb.de, mark.rutland@arm.com, l.subrahmanya@mobiveil.co.in,
        shawnguo@kernel.org, m.karthikeyan@mobiveil.co.in,
        leoyang.li@nxp.com, lorenzo.pieralisi@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, Mingkai.Hu@nxp.com,
        Minghuan.Lian@nxp.com, Xiaowei.Bao@nxp.com
Subject: Re: [PATCHv10 07/13] PCI: mobiveil: Allow mobiveil_host_init() to be
 used to re-init host
Message-ID: <20200220172837.GH19388@big-machine>
References: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
 <20200213040644.45858-8-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213040644.45858-8-Zhiqiang.Hou@nxp.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 13, 2020 at 12:06:38PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Allow the mobiveil_host_init() function to be used to re-init
> host controller's PAB and GPEX CSR register block, as NXP
> integrated Mobiveil IP has to reset and then re-init the PAB
> and GPEX CSR registers upon hot-reset.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>

Reviewed-by: Andrew Murray <amurray@thegoodpenguin.co.uk>

> ---
> V10:
>  - Refined the subject and change log.
> 
>  .../controller/mobiveil/pcie-mobiveil-host.c  | 19 ++++++++++++-------
>  .../pci/controller/mobiveil/pcie-mobiveil.h   |  1 +
>  2 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> index 53ab8412a1de..44dd641fede3 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> @@ -221,18 +221,23 @@ static void mobiveil_pcie_enable_msi(struct mobiveil_pcie *pcie)
>  	writel_relaxed(1, pcie->apb_csr_base + MSI_ENABLE_OFFSET);
>  }
>  
> -static int mobiveil_host_init(struct mobiveil_pcie *pcie)
> +int mobiveil_host_init(struct mobiveil_pcie *pcie, bool reinit)
>  {
>  	struct mobiveil_root_port *rp = &pcie->rp;
>  	struct pci_host_bridge *bridge = rp->bridge;
>  	u32 value, pab_ctrl, type;
>  	struct resource_entry *win;
>  
> -	/* setup bus numbers */
> -	value = mobiveil_csr_readl(pcie, PCI_PRIMARY_BUS);
> -	value &= 0xff000000;
> -	value |= 0x00ff0100;
> -	mobiveil_csr_writel(pcie, value, PCI_PRIMARY_BUS);
> +	pcie->ib_wins_configured = 0;
> +	pcie->ob_wins_configured = 0;
> +
> +	if (!reinit) {
> +		/* setup bus numbers */
> +		value = mobiveil_csr_readl(pcie, PCI_PRIMARY_BUS);
> +		value &= 0xff000000;
> +		value |= 0x00ff0100;
> +		mobiveil_csr_writel(pcie, value, PCI_PRIMARY_BUS);
> +	}
>  
>  	/*
>  	 * program Bus Master Enable Bit in Command Register in PAB Config
> @@ -576,7 +581,7 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
>  	 * configure all inbound and outbound windows and prepare the RC for
>  	 * config access
>  	 */
> -	ret = mobiveil_host_init(pcie);
> +	ret = mobiveil_host_init(pcie, false);
>  	if (ret) {
>  		dev_err(dev, "Failed to initialize host\n");
>  		return ret;
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> index 346bf79a581b..623c5f0c4441 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> @@ -166,6 +166,7 @@ struct mobiveil_pcie {
>  };
>  
>  int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie);
> +int mobiveil_host_init(struct mobiveil_pcie *pcie, bool reinit);
>  bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie);
>  int mobiveil_bringup_link(struct mobiveil_pcie *pcie);
>  void program_ob_windows(struct mobiveil_pcie *pcie, int win_num, u64 cpu_addr,
> -- 
> 2.17.1
> 
