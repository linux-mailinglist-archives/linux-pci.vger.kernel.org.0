Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A414827AC72
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 13:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgI1LKG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 07:10:06 -0400
Received: from foss.arm.com ([217.140.110.172]:49468 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgI1LKF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Sep 2020 07:10:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A24FC31B;
        Mon, 28 Sep 2020 04:10:04 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8142E3F6CF;
        Mon, 28 Sep 2020 04:10:03 -0700 (PDT)
Date:   Mon, 28 Sep 2020 12:09:57 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] PCI: tegra: convert to use DEFINE_SEQ_ATTRIBUTE
 macro
Message-ID: <20200928110957.GA13256@e121166-lin.cambridge.arm.com>
References: <20200916025025.3992783-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916025025.3992783-1-liushixin2@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 16, 2020 at 10:50:25AM +0800, Liu Shixin wrote:
> Use DEFINE_SEQ_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 28 +++-------------------------
>  1 file changed, 3 insertions(+), 25 deletions(-)

Applied to pci/tegra, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index c1d34353c29b..556c30a718f0 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -2564,36 +2564,14 @@ static int tegra_pcie_ports_seq_show(struct seq_file *s, void *v)
>  	return 0;
>  }
>  
> -static const struct seq_operations tegra_pcie_ports_seq_ops = {
> +static const struct seq_operations tegra_pcie_ports_sops = {
>  	.start = tegra_pcie_ports_seq_start,
>  	.next = tegra_pcie_ports_seq_next,
>  	.stop = tegra_pcie_ports_seq_stop,
>  	.show = tegra_pcie_ports_seq_show,
>  };
>  
> -static int tegra_pcie_ports_open(struct inode *inode, struct file *file)
> -{
> -	struct tegra_pcie *pcie = inode->i_private;
> -	struct seq_file *s;
> -	int err;
> -
> -	err = seq_open(file, &tegra_pcie_ports_seq_ops);
> -	if (err)
> -		return err;
> -
> -	s = file->private_data;
> -	s->private = pcie;
> -
> -	return 0;
> -}
> -
> -static const struct file_operations tegra_pcie_ports_ops = {
> -	.owner = THIS_MODULE,
> -	.open = tegra_pcie_ports_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = seq_release,
> -};
> +DEFINE_SEQ_ATTRIBUTE(tegra_pcie_ports);
>  
>  static void tegra_pcie_debugfs_exit(struct tegra_pcie *pcie)
>  {
> @@ -2610,7 +2588,7 @@ static int tegra_pcie_debugfs_init(struct tegra_pcie *pcie)
>  		return -ENOMEM;
>  
>  	file = debugfs_create_file("ports", S_IFREG | S_IRUGO, pcie->debugfs,
> -				   pcie, &tegra_pcie_ports_ops);
> +				   pcie, &tegra_pcie_ports_fops);
>  	if (!file)
>  		goto remove;
>  
> -- 
> 2.25.1
> 
