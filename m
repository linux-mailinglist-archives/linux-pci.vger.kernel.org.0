Return-Path: <linux-pci+bounces-44184-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 855D4CFDB60
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 13:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8EC5F30090B4
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 12:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871D2224B0E;
	Wed,  7 Jan 2026 12:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJHojhVr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6350538DF9
	for <linux-pci@vger.kernel.org>; Wed,  7 Jan 2026 12:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767789674; cv=none; b=NCuaVJ9m/JYD+muMNydvpOkau7F6zVA94o5xa93r8rBe7Jka2Xqb7tZ+p3mzH9WPnganK9S1zMqUpHGruEP7eft/PDEL/To0nrwsMuQAbMjAodbvHAFkLS2EivXZGTlUzBpCPjMmTnh7DCfQTPf+pqlpzxrvTnCB7gKjNLgVX0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767789674; c=relaxed/simple;
	bh=UTs5Veazk1ZITIjNM5KDAfelv8hZDFcfNJN7rAkuzn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFIzDPrJI+90ufufbQtr7DBMd7EqiQR0YoA4YKpoz1XkJ8lcJGfiOoa6OzHPhpJUJSHAV4JieSZbMf0JZiaLmayHTo/74CTN3LSstxdlfO4ue4HNtdtkdUi2akhF2g7b8ndqveBGqB3a3P4CgSTTytf8L8LpwI60Ts+v0vsflNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJHojhVr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2485C4CEF7;
	Wed,  7 Jan 2026 12:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767789672;
	bh=UTs5Veazk1ZITIjNM5KDAfelv8hZDFcfNJN7rAkuzn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CJHojhVrkgGt4jMVSEjsVv5/ID/q8PZOsQ9E/GNvojzb1Qlit8XZV+ivPkkyBy8zJ
	 8ejXCMuE15KAjeQxQoWiCI3MJcU2xom1F9ODXo90WOxlkRENabcRpSPKr9NDXLGsil
	 qePFFlYuhkzFOx8xJmSwV7UhGNW5YbAEPOSsSZa7xKt2pMQ6OLZPkfKuS/GNsUzokv
	 iM98t9g9b5b1QvkoBh5alLItcI3GZsr/Xdau7Q3o+J+eCrSkOCCdsBLodH5CILHKi6
	 g/iNAknxhBiFciBNTvY2EcMPVFIjEcqEmN57VGiACvLDJGfJKDGxcF7X2nl+4177r4
	 lr1Ed3+cluo5g==
Date: Wed, 7 Jan 2026 18:11:06 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-rockchip@lists.infradead.org, Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: Add LTSSM tracing support to debugfs
Message-ID: <cudy2lfd7q7tujfivampgciziuho7izkpvmabj3qa2udvzkvfh@lw5vasqcrs6c>
References: <1767691119-28287-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1767691119-28287-1-git-send-email-shawn.lin@rock-chips.com>

On Tue, Jan 06, 2026 at 05:18:38PM +0800, Shawn Lin wrote:
> Some platforms may provide LTSSM trace functionality, recording historical
> LTSSM state transition information. This is very useful for debugging, such
> as when certain devices cannot be recognized. Add an ltssm_trace operation
> node in debugfs for platform which could provide these information to show
> the LTSSM history.
> 

Why don't you implement it as a tracepoint since you want to expose traces?

- Mani

> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>  .../controller/dwc/pcie-designware-debugfs.c  | 44 +++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h  |  6 +++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> index df98fee69892..569e8e078ef2 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> @@ -511,6 +511,38 @@ static int ltssm_status_open(struct inode *inode, struct file *file)
>  	return single_open(file, ltssm_status_show, inode->i_private);
>  }
>  
> +static struct dw_pcie_ltssm_history *dw_pcie_ltssm_trace(struct dw_pcie *pci)
> +{
> +	if (pci->ops && pci->ops->ltssm_trace)
> +		return pci->ops->ltssm_trace(pci);
> +
> +	return NULL;
> +}
> +
> +static int ltssm_trace_show(struct seq_file *s, void *v)
> +{
> +	struct dw_pcie *pci = s->private;
> +	struct dw_pcie_ltssm_history *history;
> +	enum dw_pcie_ltssm val;
> +	u32 loop;
> +
> +	history = dw_pcie_ltssm_trace(pci);
> +	if (!history)
> +		return 0;
> +
> +	for (loop = 0; loop < history->count; loop++) {
> +		val = history->states[loop];
> +		seq_printf(s, "%s (0x%02x)\n", ltssm_status_string(val), val);
> +	}
> +
> +	return 0;
> +}
> +
> +static int ltssm_trace_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, ltssm_trace_show, inode->i_private);
> +}
> +
>  #define dwc_debugfs_create(name)			\
>  debugfs_create_file(#name, 0644, rasdes_debug, pci,	\
>  			&dbg_ ## name ## _fops)
> @@ -552,6 +584,11 @@ static const struct file_operations dwc_pcie_ltssm_status_ops = {
>  	.read = seq_read,
>  };
>  
> +static const struct file_operations dwc_pcie_ltssm_trace_ops = {
> +	.open = ltssm_trace_open,
> +	.read = seq_read,
> +};
> +
>  static void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
>  {
>  	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
> @@ -644,6 +681,12 @@ static void dwc_pcie_ltssm_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
>  			    &dwc_pcie_ltssm_status_ops);
>  }
>  
> +static void dwc_pcie_ltssm_trace_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
> +{
> +	debugfs_create_file("ltssm_trace", 0444, dir, pci,
> +			    &dwc_pcie_ltssm_trace_ops);
> +}
> +
>  static int dw_pcie_ptm_check_capability(void *drvdata)
>  {
>  	struct dw_pcie *pci = drvdata;
> @@ -922,6 +965,7 @@ void dwc_pcie_debugfs_init(struct dw_pcie *pci, enum dw_pcie_device_mode mode)
>  			err);
>  
>  	dwc_pcie_ltssm_debugfs_init(pci, dir);
> +	dwc_pcie_ltssm_trace_debugfs_init(pci, dir);
>  
>  	pci->mode = mode;
>  	pci->ptm_debugfs = pcie_ptm_create_debugfs(pci->dev, pci,
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 5cd27f5739f1..0df18995b7fe 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -395,6 +395,11 @@ enum dw_pcie_ltssm {
>  	DW_PCIE_LTSSM_UNKNOWN = 0xFFFFFFFF,
>  };
>  
> +struct dw_pcie_ltssm_history {
> +    enum dw_pcie_ltssm *states;
> +    u32 count;
> +};
> +
>  struct dw_pcie_ob_atu_cfg {
>  	int index;
>  	int type;
> @@ -499,6 +504,7 @@ struct dw_pcie_ops {
>  			      size_t size, u32 val);
>  	bool	(*link_up)(struct dw_pcie *pcie);
>  	enum dw_pcie_ltssm (*get_ltssm)(struct dw_pcie *pcie);
> +	struct dw_pcie_ltssm_history * (*ltssm_trace)(struct dw_pcie *pcie);
>  	int	(*start_link)(struct dw_pcie *pcie);
>  	void	(*stop_link)(struct dw_pcie *pcie);
>  	int	(*assert_perst)(struct dw_pcie *pcie, bool assert);
> -- 
> 2.43.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

