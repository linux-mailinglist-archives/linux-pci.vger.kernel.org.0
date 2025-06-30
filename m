Return-Path: <linux-pci+bounces-31108-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F46AEE862
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 22:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13BFE3E085C
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 20:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4064828CF7B;
	Mon, 30 Jun 2025 20:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRKll4E7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1541519994F;
	Mon, 30 Jun 2025 20:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751315925; cv=none; b=ODNThrlPAEvb0BCkT7K8LTi/Tn4iEftV6m7gkVinGfPpPFsLivlS05gjD1Ox+FLuaN6F+VS35wbQZBcuhAj3oigZPByRD6xemXxhGJUMdwe8mSOAxjgJpwI9fnXaVJ6II9L+oZbiJw7frhJE2A/GvWhQWv2a+qcpBgcLvOXxA4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751315925; c=relaxed/simple;
	bh=XYkZf1uMyBfIfltqMZolFcCg6zKSSnCN+/47K55FwyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JDJZcie4kRX0nWEtIhtRqoenM0I116cS45ejSdcXYsVBdOJzE6rUDAvfbwieShePKW5/YJyjuoSUevsklRWanyQ5sEYU+C5QpIQOgO6shwnYph0Pu5VgZVxt83RHWsRT8FANTHpdSa22mEM+lmIstOx94jvC1EcuTLkwoNfAD+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRKll4E7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C9DC4CEEB;
	Mon, 30 Jun 2025 20:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751315923;
	bh=XYkZf1uMyBfIfltqMZolFcCg6zKSSnCN+/47K55FwyQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eRKll4E7P1ZrnP4A58ghK/O+UMnVJylHbzbQQ7ASS2mMNcZD8nWhiaI1+8iwWyPUC
	 UVxXbSiy7FQBEA4rVtPP1zpGdR0To/DtDu5+PVioyrKcjkh3L7rp9sYMpVFFpjXDsV
	 nc00Z/67cYvN6kdbWqwRA1xTXZRkmnRxDzjqhKYModhtMoxar7mjW4+PNMpsMIm0FE
	 3/XmyOoBOkJSnxw/GsDht6IGd92C/PbUHe/a9opZyIfpRkeMMv+JrP2ArocPBHoKWt
	 MxX94I2Lg5zn+xkEQBuWMhPzYenMz/Pv/mHR6a5jPr3K1N9LNAFMFwt9x8XfnFOgbi
	 gtFF/9puAr79Q==
Date: Mon, 30 Jun 2025 15:38:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] PCI: endpoint: pci-epf-vntb: Allow BAR assignment
 via configfs
Message-ID: <20250630203842.GA1800194@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603-pci-vntb-bar-mapping-v2-3-fc685a22ad28@baylibre.com>

On Tue, Jun 03, 2025 at 07:03:40PM +0200, Jerome Brunet wrote:
> The current BAR configuration for the PCI vNTB endpoint function allocates
> BARs in order, which lacks flexibility and does not account for
> platform-specific quirks. This is problematic on Renesas platforms, where
> BAR_4 is a fixed 256B region that ends up being used for MW1, despite being
> better suited for doorbells.
> 
> Add new configfs attributes to allow users to specify arbitrary BAR
> assignments. If no configuration is provided, the driver retains its
> original behavior of sequential BAR allocation, preserving compatibility
> with existing userspace setups.
> 
> This enables use cases such as assigning BAR_2 for MW1 and using the
> limited BAR_4 for doorbells on Renesas platforms.

Is there any documentation for how to use this new feature?

> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 131 ++++++++++++++++++++++++--
>  1 file changed, 124 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 2198282a80a40774047502a37f0288ca396bdb0e..7475d87659b1c70aa41b0999eabfa661f4ceed39 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -73,6 +73,8 @@ enum epf_ntb_bar {
>  	BAR_MW1,
>  	BAR_MW2,
>  	BAR_MW3,
> +	BAR_MW4,
> +	VNTB_BAR_NUM,
>  };
>  
>  /*
> @@ -132,7 +134,7 @@ struct epf_ntb {
>  	bool linkup;
>  	u32 spad_size;
>  
> -	enum pci_barno epf_ntb_bar[6];
> +	enum pci_barno epf_ntb_bar[VNTB_BAR_NUM];
>  
>  	struct epf_ntb_ctrl *reg;
>  
> @@ -654,6 +656,62 @@ static void epf_ntb_epc_destroy(struct epf_ntb *ntb)
>  	pci_epc_put(ntb->epf->epc);
>  }
>  
> +
> +/**
> + * epf_ntb_is_bar_used() - Check if a bar is used in the ntb configuration
> + * @ntb: NTB device that facilitates communication between HOST and VHOST
> + * @barno: Checked bar number
> + *
> + * Returns: true if used, false if free.
> + */
> +static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
> +				enum pci_barno barno)
> +{
> +	int i;
> +
> +	for (i = 0; i < VNTB_BAR_NUM; i++) {
> +		if (ntb->epf_ntb_bar[i] == barno)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +/**
> + * epf_ntb_find_bar() - Assign BAR number when no configuration is provided
> + * @epc_features: The features provided by the EPC specific to this EPF
> + * @ntb: NTB device that facilitates communication between HOST and VHOST
> + * @barno: Bar start index
> + *
> + * When the BAR configuration was not provided through the userspace
> + * configuration, automatically assign BAR as it has been historically
> + * done by this endpoint function.
> + *
> + * Returns: the BAR number found, if any. -1 otherwise
> + */
> +static int epf_ntb_find_bar(struct epf_ntb *ntb,
> +			    const struct pci_epc_features *epc_features,
> +			    enum epf_ntb_bar bar,
> +			    enum pci_barno barno)
> +{
> +	while (ntb->epf_ntb_bar[bar] < 0) {
> +		barno = pci_epc_get_next_free_bar(epc_features, barno);
> +		if (barno < 0)
> +			break; /* No more BAR available */
> +
> +		/*
> +		 * Verify if the BAR found is not already assigned
> +		 * through the provided configuration
> +		 */
> +		if (!epf_ntb_is_bar_used(ntb, barno))
> +			ntb->epf_ntb_bar[bar] = barno;
> +
> +		barno += 1;
> +	}
> +
> +	return barno;
> +}
> +
>  /**
>   * epf_ntb_init_epc_bar() - Identify BARs to be used for each of the NTB
>   * constructs (scratchpad region, doorbell, memorywindow)
> @@ -676,23 +734,21 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
>  	epc_features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no);
>  
>  	/* These are required BARs which are mandatory for NTB functionality */
> -	for (bar = BAR_CONFIG; bar <= BAR_MW1; bar++, barno++) {
> -		barno = pci_epc_get_next_free_bar(epc_features, barno);
> +	for (bar = BAR_CONFIG; bar <= BAR_MW1; bar++) {
> +		barno = epf_ntb_find_bar(ntb, epc_features, bar, barno);
>  		if (barno < 0) {
>  			dev_err(dev, "Fail to get NTB function BAR\n");
>  			return -EINVAL;
>  		}
> -		ntb->epf_ntb_bar[bar] = barno;
>  	}
>  
>  	/* These are optional BARs which don't impact NTB functionality */
> -	for (bar = BAR_MW1, i = 1; i < num_mws; bar++, barno++, i++) {
> -		barno = pci_epc_get_next_free_bar(epc_features, barno);
> +	for (bar = BAR_MW1, i = 1; i < num_mws; bar++, i++) {
> +		barno = epf_ntb_find_bar(ntb, epc_features, bar, barno);
>  		if (barno < 0) {
>  			ntb->num_mws = i;
>  			dev_dbg(dev, "BAR not available for > MW%d\n", i + 1);
>  		}
> -		ntb->epf_ntb_bar[bar] = barno;
>  	}
>  
>  	return 0;
> @@ -860,6 +916,37 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
>  	return len;							\
>  }
>  
> +#define EPF_NTB_BAR_R(_name, _id)					\
> +	static ssize_t epf_ntb_##_name##_show(struct config_item *item,	\
> +					      char *page)		\
> +	{								\
> +		struct config_group *group = to_config_group(item);	\
> +		struct epf_ntb *ntb = to_epf_ntb(group);		\
> +									\
> +		return sprintf(page, "%d\n", ntb->epf_ntb_bar[_id]);	\
> +	}
> +
> +#define EPF_NTB_BAR_W(_name, _id)					\
> +	static ssize_t epf_ntb_##_name##_store(struct config_item *item, \
> +					       const char *page, size_t len) \
> +	{								\
> +	struct config_group *group = to_config_group(item);		\
> +	struct epf_ntb *ntb = to_epf_ntb(group);			\
> +	int val;							\
> +	int ret;							\
> +									\
> +	ret = kstrtoint(page, 0, &val);					\
> +	if (ret)							\
> +		return ret;						\
> +									\
> +	if (val < NO_BAR || val > BAR_5)				\
> +		return -EINVAL;						\
> +									\
> +	ntb->epf_ntb_bar[_id] = val;					\
> +									\
> +	return len;							\
> +	}
> +
>  static ssize_t epf_ntb_num_mws_store(struct config_item *item,
>  				     const char *page, size_t len)
>  {
> @@ -899,6 +986,18 @@ EPF_NTB_MW_R(mw3)
>  EPF_NTB_MW_W(mw3)
>  EPF_NTB_MW_R(mw4)
>  EPF_NTB_MW_W(mw4)
> +EPF_NTB_BAR_R(ctrl_bar, BAR_CONFIG)
> +EPF_NTB_BAR_W(ctrl_bar, BAR_CONFIG)
> +EPF_NTB_BAR_R(db_bar, BAR_DB)
> +EPF_NTB_BAR_W(db_bar, BAR_DB)
> +EPF_NTB_BAR_R(mw1_bar, BAR_MW1)
> +EPF_NTB_BAR_W(mw1_bar, BAR_MW1)
> +EPF_NTB_BAR_R(mw2_bar, BAR_MW1)
> +EPF_NTB_BAR_W(mw2_bar, BAR_MW1)
> +EPF_NTB_BAR_R(mw3_bar, BAR_MW3)
> +EPF_NTB_BAR_W(mw3_bar, BAR_MW3)
> +EPF_NTB_BAR_R(mw4_bar, BAR_MW4)
> +EPF_NTB_BAR_W(mw4_bar, BAR_MW4)
>  
>  CONFIGFS_ATTR(epf_ntb_, spad_count);
>  CONFIGFS_ATTR(epf_ntb_, db_count);
> @@ -910,6 +1009,12 @@ CONFIGFS_ATTR(epf_ntb_, mw4);
>  CONFIGFS_ATTR(epf_ntb_, vbus_number);
>  CONFIGFS_ATTR(epf_ntb_, vntb_pid);
>  CONFIGFS_ATTR(epf_ntb_, vntb_vid);
> +CONFIGFS_ATTR(epf_ntb_, ctrl_bar);
> +CONFIGFS_ATTR(epf_ntb_, db_bar);
> +CONFIGFS_ATTR(epf_ntb_, mw1_bar);
> +CONFIGFS_ATTR(epf_ntb_, mw2_bar);
> +CONFIGFS_ATTR(epf_ntb_, mw3_bar);
> +CONFIGFS_ATTR(epf_ntb_, mw4_bar);
>  
>  static struct configfs_attribute *epf_ntb_attrs[] = {
>  	&epf_ntb_attr_spad_count,
> @@ -922,6 +1027,12 @@ static struct configfs_attribute *epf_ntb_attrs[] = {
>  	&epf_ntb_attr_vbus_number,
>  	&epf_ntb_attr_vntb_pid,
>  	&epf_ntb_attr_vntb_vid,
> +	&epf_ntb_attr_ctrl_bar,
> +	&epf_ntb_attr_db_bar,
> +	&epf_ntb_attr_mw1_bar,
> +	&epf_ntb_attr_mw2_bar,
> +	&epf_ntb_attr_mw3_bar,
> +	&epf_ntb_attr_mw4_bar,
>  	NULL,
>  };
>  
> @@ -1379,6 +1490,7 @@ static int epf_ntb_probe(struct pci_epf *epf,
>  {
>  	struct epf_ntb *ntb;
>  	struct device *dev;
> +	int i;
>  
>  	dev = &epf->dev;
>  
> @@ -1389,6 +1501,11 @@ static int epf_ntb_probe(struct pci_epf *epf,
>  	epf->header = &epf_ntb_header;
>  	ntb->epf = epf;
>  	ntb->vbus_number = 0xff;
> +
> +	/* Initially, no bar is assigned */
> +	for (i = 0; i < VNTB_BAR_NUM; i++)
> +		ntb->epf_ntb_bar[i] = NO_BAR;
> +
>  	epf_set_drvdata(epf, ntb);
>  
>  	dev_info(dev, "pci-ep epf driver loaded\n");
> 
> -- 
> 2.47.2
> 

