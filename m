Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5943725F6DD
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 11:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgIGJuX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 05:50:23 -0400
Received: from foss.arm.com ([217.140.110.172]:59148 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728369AbgIGJuT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Sep 2020 05:50:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6198930E;
        Mon,  7 Sep 2020 02:50:18 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1303E3F66E;
        Mon,  7 Sep 2020 02:50:16 -0700 (PDT)
Date:   Mon, 7 Sep 2020 10:50:14 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: no need to check return value of
 debugfs_create functions
Message-ID: <20200907095014.GE6428@e121166-lin.cambridge.arm.com>
References: <20200818133739.463193-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818133739.463193-1-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 18, 2020 at 03:37:39PM +0200, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Vidya Sagar <vidyas@nvidia.com>
> Cc: Andrew Murray <amurray@thegoodpenguin.co.uk>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 20 +++++------------
>  drivers/pci/controller/pci-tegra.c         | 25 +++++-----------------
>  2 files changed, 10 insertions(+), 35 deletions(-)

Applied to pci/tegra, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 70498689d0c0..87f8dd63df0a 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -699,23 +699,16 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
>  	dw_pcie_writel_dbi(pci, PORT_LOGIC_ACK_F_ASPM_CTRL, val);
>  }
>  
> -static int init_debugfs(struct tegra_pcie_dw *pcie)
> +static void init_debugfs(struct tegra_pcie_dw *pcie)
>  {
> -	struct dentry *d;
> -
> -	d = debugfs_create_devm_seqfile(pcie->dev, "aspm_state_cnt",
> -					pcie->debugfs, aspm_state_cnt);
> -	if (IS_ERR_OR_NULL(d))
> -		dev_err(pcie->dev,
> -			"Failed to create debugfs file \"aspm_state_cnt\"\n");
> -
> -	return 0;
> +	debugfs_create_devm_seqfile(pcie->dev, "aspm_state_cnt", pcie->debugfs,
> +				    aspm_state_cnt);
>  }
>  #else
>  static inline void disable_aspm_l12(struct tegra_pcie_dw *pcie) { return; }
>  static inline void disable_aspm_l11(struct tegra_pcie_dw *pcie) { return; }
>  static inline void init_host_aspm(struct tegra_pcie_dw *pcie) { return; }
> -static inline int init_debugfs(struct tegra_pcie_dw *pcie) { return 0; }
> +static inline void init_debugfs(struct tegra_pcie_dw *pcie) { return; }
>  #endif
>  
>  static void tegra_pcie_enable_system_interrupts(struct pcie_port *pp)
> @@ -1641,10 +1634,7 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
>  	}
>  
>  	pcie->debugfs = debugfs_create_dir(name, NULL);
> -	if (!pcie->debugfs)
> -		dev_err(dev, "Failed to create debugfs\n");
> -	else
> -		init_debugfs(pcie);
> +	init_debugfs(pcie);
>  
>  	return ret;
>  
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index c1d34353c29b..e1a6f9db36f7 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -2601,24 +2601,12 @@ static void tegra_pcie_debugfs_exit(struct tegra_pcie *pcie)
>  	pcie->debugfs = NULL;
>  }
>  
> -static int tegra_pcie_debugfs_init(struct tegra_pcie *pcie)
> +static void tegra_pcie_debugfs_init(struct tegra_pcie *pcie)
>  {
> -	struct dentry *file;
> -
>  	pcie->debugfs = debugfs_create_dir("pcie", NULL);
> -	if (!pcie->debugfs)
> -		return -ENOMEM;
> -
> -	file = debugfs_create_file("ports", S_IFREG | S_IRUGO, pcie->debugfs,
> -				   pcie, &tegra_pcie_ports_ops);
> -	if (!file)
> -		goto remove;
> -
> -	return 0;
>  
> -remove:
> -	tegra_pcie_debugfs_exit(pcie);
> -	return -ENOMEM;
> +	debugfs_create_file("ports", S_IFREG | S_IRUGO, pcie->debugfs, pcie,
> +			    &tegra_pcie_ports_ops);
>  }
>  
>  static int tegra_pcie_probe(struct platform_device *pdev)
> @@ -2672,11 +2660,8 @@ static int tegra_pcie_probe(struct platform_device *pdev)
>  		goto pm_runtime_put;
>  	}
>  
> -	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
> -		err = tegra_pcie_debugfs_init(pcie);
> -		if (err < 0)
> -			dev_err(dev, "failed to setup debugfs: %d\n", err);
> -	}
> +	if (IS_ENABLED(CONFIG_DEBUG_FS))
> +		tegra_pcie_debugfs_init(pcie);
>  
>  	return 0;
>  
> -- 
> 2.28.0
> 
