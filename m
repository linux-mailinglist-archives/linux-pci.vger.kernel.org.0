Return-Path: <linux-pci+bounces-22773-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2881DA4CA5B
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 18:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F64D189215D
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 17:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A723214A81;
	Mon,  3 Mar 2025 17:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/xymZAO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7538B1F4C83;
	Mon,  3 Mar 2025 17:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741024112; cv=none; b=VZ4lZRL8OYyfM8iRCvzYwv+Yf7A/sDn2kKR0GH7wYg/LaS/Jg5EgZxt3YNK55F0ivLYe8cOEjDjw772k6pxnt2uNtY6y0PaE7U4XN/W3f0yjL9HmheiS+PYgE5bMSyGf/gr6eG5iVA4tOJn4MFH/LbbkJdcXD7KPr8/w5AUiBWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741024112; c=relaxed/simple;
	bh=hBl1SA34t69342MAMDAQhPCtUn7lM7R+xds081nYH7Y=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nndWxz/uRtIvneFc9LkDB38Qm1t40ErgL+6H11lRqCOOHkJHih9zgemHAHzmT354et4l/T96ftCZEAumVPjkNhNaPYHEfrxxJMw420eu79g04QVE7ATHVEwPSIaOgjpbfEdcm0ZtqMLowrEjIrKZAIfYiTXcyVi2qWUrt6RUImc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/xymZAO; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2feb867849fso6150718a91.3;
        Mon, 03 Mar 2025 09:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741024110; x=1741628910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WmKXbHEtnA7BYynURcro/0mObW5wKzmiR29K1zakwMQ=;
        b=Z/xymZAOs2ewb1FnyCXhkAY3hODOnM9QniCq2+bOUIHhKkV/x63sYsCJVaff1gQj9y
         9w4qsRxoBq6g2Bda37hhWWDEbdVApq/D1numYA48D+5zWvdJjUUkNU+MIVgMrjVBHsEo
         jRK5N+ohz1KuiQRyRIwzX+DOQ+LQuoHMdy4w6u0BIbgig+uP3GmuL4h/xdLDXb8lXvCt
         DeFTLi5Q3qs7o0bqwS1ZpnsJ+rRG8yXn3bbazOkoXtg+ONI6TUDaunXprmx65rWRzGz1
         sRcpqiug/asZ9/J5lHlJ6eYeDU/wiibVvmEji9wgvnfi4qVvsdHpYy2sT9X8cbTHi2yX
         4sdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741024110; x=1741628910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmKXbHEtnA7BYynURcro/0mObW5wKzmiR29K1zakwMQ=;
        b=qKaRwbVQX0Yji6AVaXpgxti6knIp+ivSiaE+PdnGQhxKjjrvhlMwBFZaoByfC0S4rK
         AHZkAY5GrLT6VQuxKmr7N6FGH37aBbuOQKOQH09gU6Z4YHgL7PYoqoP7YuyuGnplsNtD
         rGspJtCCbU+L8izIKl3po9PsdtLNaUx8cvsy+83dfQrUCj7uv2gqtgIVUUYtcW3G9MRD
         wKR6ef961hdzp/bX2h/4GjPhQC7RXmYNO85OQ1BmxMMT385E0XJVrKDFDe4+HoEYP+h2
         W6loidTighXvJs41FFSi5lXijgzCp4iYUEzmpwVCD2RDLPd0JLMlz/ayiY2y9Fyd9o/5
         8zyw==
X-Forwarded-Encrypted: i=1; AJvYcCVDSpjvysOW1LYfSOa++Ndo+/VGbCNT8rx53UisFUEaR1/hF7m18VXC1Lj+6vaTAgz83kmscEq34pM=@vger.kernel.org, AJvYcCVSmZN/4HCMvIUd6UcL0H7t2mG96YcEvRPZPlK7taBcZbxA5Hkqr2APFE1bIPm82MOeFhlecTOdWxTCuFp89lskvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh6al6yhpVLsq0MoSBsAZ2SjenMoQg04LIcwADso2QNyjee9Uw
	UrDz/3/d+Va+FfX+TXtKxUO7hSraRZG2RdyvfeiLtqUyNZP88TKD
X-Gm-Gg: ASbGncuFmWDOTpnp3gB/V0s7di9n35C1JdGW1bEWStO58yIW22LltDR1daRyX9rat51
	cGWMryHr1FWnm90gviK4hSZ0t0ToZzkNbFPvEbptIgq0uY+KGs0QANEHM3vuxhO+T8OpyLkXknz
	hJAgwA9jL0Pydn2xKXUDXBi7ERr8JYUDF+Ckjk7bTTC0mYsxMdPYcQQMYsRgQLzrr5g4A8xh56Y
	4alf/GrPNrEQyNbZFFDlGLqP0/XDiGqNeC61nRJ3WdrJB5+3PcwD0xLWK/6gZhtHoYuBJkrGc0+
	5mGyUrFWdPpxo2+x+4tx1uhQ4jAoh8PoT9Fo3MrC
X-Google-Smtp-Source: AGHT+IHk7Hi95mZJV5rMYiwuC/J8v0hurAfh0yJTj+vgRhEnZZgJvNnI5Cjq+bi6h/usz4umguhtlw==
X-Received: by 2002:a17:90b:3a89:b0:2fe:8c4f:e7c4 with SMTP id 98e67ed59e1d1-2febab760a0mr22194123a91.15.1741024106330;
        Mon, 03 Mar 2025 09:48:26 -0800 (PST)
Received: from debian ([2607:fb90:8e63:c2b3:5405:c8bf:c1d1:41d5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825baa8csm11465771a91.14.2025.03.03.09.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 09:48:25 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 3 Mar 2025 09:48:19 -0800
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, manivannan.sadhasivam@linaro.org,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com,
	a.manzanares@samsung.com, pankaj.dubey@samsung.com,
	cassel@kernel.org, 18255117159@163.com, xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com, will@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v7 3/5] Add debugfs based silicon debug support in DWC
Message-ID: <Z8XrYxP_pZr6tFU8@debian>
References: <20250221131548.59616-1-shradha.t@samsung.com>
 <CGME20250221132035epcas5p47221a5198df9bf86020abcefdfded789@epcas5p4.samsung.com>
 <20250221131548.59616-4-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221131548.59616-4-shradha.t@samsung.com>

On Fri, Feb 21, 2025 at 06:45:46PM +0530, Shradha Todi wrote:
> Add support to provide silicon debug interface to userspace. This set
> of debug registers are part of the RASDES feature present in DesignWare
> PCIe controllers.
> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>

One comment inline.
> ---
>  Documentation/ABI/testing/debugfs-dwc-pcie    |  13 ++
>  drivers/pci/controller/dwc/Kconfig            |  10 +
>  drivers/pci/controller/dwc/Makefile           |   1 +
>  .../controller/dwc/pcie-designware-debugfs.c  | 176 ++++++++++++++++++
>  .../pci/controller/dwc/pcie-designware-ep.c   |   5 +
>  .../pci/controller/dwc/pcie-designware-host.c |   6 +
>  drivers/pci/controller/dwc/pcie-designware.c  |   6 +
>  drivers/pci/controller/dwc/pcie-designware.h  |  21 +++
>  include/linux/pcie-dwc.h                      |   2 +
>  9 files changed, 240 insertions(+)
>  create mode 100644 Documentation/ABI/testing/debugfs-dwc-pcie
>  create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.c
> 

...

> +
> +static void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
> +{
> +	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
> +
> +	mutex_destroy(&rinfo->reg_event_lock);
> +}
> +
> +static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
> +{
> +	struct dentry *rasdes_debug;
> +	struct dwc_pcie_rasdes_info *rasdes_info;
> +	struct device *dev = pci->dev;
> +	int ras_cap;
> +
> +	ras_cap = dw_pcie_find_rasdes_capability(pci);
> +	if (!ras_cap) {
> +		dev_dbg(dev, "no RASDES capability available\n");
> +		return -ENODEV;
> +	}
> +
> +	rasdes_info = devm_kzalloc(dev, sizeof(*rasdes_info), GFP_KERNEL);
> +	if (!rasdes_info)
> +		return -ENOMEM;
> +
> +	/* Create subdirectories for Debug, Error injection, Statistics */
> +	rasdes_debug = debugfs_create_dir("rasdes_debug", dir);
> +
> +	mutex_init(&rasdes_info->reg_event_lock);
> +	rasdes_info->ras_cap_offset = ras_cap;
> +	pci->debugfs->rasdes_info = rasdes_info;
> +
> +	/* Create debugfs files for Debug subdirectory */
> +	dwc_debugfs_create(lane_detect);
> +	dwc_debugfs_create(rx_valid);
> +
> +	return 0;
> +}
> +
> +void dwc_pcie_debugfs_deinit(struct dw_pcie *pci)
> +{
> +	dwc_pcie_rasdes_debugfs_deinit(pci);
> +	debugfs_remove_recursive(pci->debugfs->debug_dir);
> +}
> +
> +int dwc_pcie_debugfs_init(struct dw_pcie *pci)
> +{
> +	char dirname[DWC_DEBUGFS_BUF_MAX];
> +	struct device *dev = pci->dev;
> +	struct debugfs_info *debugfs;
> +	struct dentry *dir;
> +	int ret;
> +
> +	/* Create main directory for each platform driver */
> +	snprintf(dirname, DWC_DEBUGFS_BUF_MAX, "dwc_pcie_%s", dev_name(dev));
> +	dir = debugfs_create_dir(dirname, NULL);
> +	debugfs = devm_kzalloc(dev, sizeof(*debugfs), GFP_KERNEL);
> +	if (!debugfs)
> +		return -ENOMEM;
> +
> +	debugfs->debug_dir = dir;
> +	pci->debugfs = debugfs;
> +	ret = dwc_pcie_rasdes_debugfs_init(pci, dir);
> +	if (ret)
> +		dev_dbg(dev, "RASDES debugfs init failed\n");

What will happen if ret != 0? still return 0? 

Fan
> +
> +	return 0;
> +}
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 72418160e658..f9d7f3f989ad 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -814,6 +814,7 @@ void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
> +	dwc_pcie_debugfs_deinit(pci);
>  	dw_pcie_edma_remove(pci);
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_ep_cleanup);
> @@ -989,6 +990,10 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
>  
>  	dw_pcie_ep_init_non_sticky_registers(pci);
>  
> +	ret = dwc_pcie_debugfs_init(pci);
> +	if (ret)
> +		goto err_remove_edma;
> +
>  	return 0;
>  
>  err_remove_edma:
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index ffaded8f2df7..2081e8c72d12 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -548,6 +548,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	if (pp->ops->post_init)
>  		pp->ops->post_init(pp);
>  
> +	ret = dwc_pcie_debugfs_init(pci);
> +	if (ret)
> +		goto err_stop_link;
> +
>  	return 0;
>  
>  err_stop_link:
> @@ -572,6 +576,8 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  
> +	dwc_pcie_debugfs_deinit(pci);
> +
>  	pci_stop_root_bus(pp->bridge->bus);
>  	pci_remove_root_bus(pp->bridge->bus);
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index a7c0671c6715..3d1d95d9e380 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -323,6 +323,12 @@ static u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci,
>  	return 0;
>  }
>  
> +u16 dw_pcie_find_rasdes_capability(struct dw_pcie *pci)
> +{
> +	return dw_pcie_find_vsec_capability(pci, dwc_pcie_rasdes_vsec_ids);
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_find_rasdes_capability);
> +
>  int dw_pcie_read(void __iomem *addr, int size, u32 *val)
>  {
>  	if (!IS_ALIGNED((uintptr_t)addr, size)) {
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 501d9ddfea16..7f9807d4e5de 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -437,6 +437,11 @@ struct dw_pcie_ops {
>  	void	(*stop_link)(struct dw_pcie *pcie);
>  };
>  
> +struct debugfs_info {
> +	struct dentry		*debug_dir;
> +	void			*rasdes_info;
> +};
> +
>  struct dw_pcie {
>  	struct device		*dev;
>  	void __iomem		*dbi_base;
> @@ -465,6 +470,7 @@ struct dw_pcie {
>  	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
>  	struct gpio_desc		*pe_rst;
>  	bool			suspended;
> +	struct debugfs_info	*debugfs;
>  };
>  
>  #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
> @@ -478,6 +484,7 @@ void dw_pcie_version_detect(struct dw_pcie *pci);
>  
>  u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
>  u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap);
> +u16 dw_pcie_find_rasdes_capability(struct dw_pcie *pci);
>  
>  int dw_pcie_read(void __iomem *addr, int size, u32 *val);
>  int dw_pcie_write(void __iomem *addr, int size, u32 val);
> @@ -806,4 +813,18 @@ dw_pcie_ep_get_func_from_ep(struct dw_pcie_ep *ep, u8 func_no)
>  	return NULL;
>  }
>  #endif
> +
> +#ifdef CONFIG_PCIE_DW_DEBUGFS
> +int dwc_pcie_debugfs_init(struct dw_pcie *pci);
> +void dwc_pcie_debugfs_deinit(struct dw_pcie *pci);
> +#else
> +static inline int dwc_pcie_debugfs_init(struct dw_pcie *pci)
> +{
> +	return 0;
> +}
> +static inline void dwc_pcie_debugfs_deinit(struct dw_pcie *pci)
> +{
> +}
> +#endif
> +
>  #endif /* _PCIE_DESIGNWARE_H */
> diff --git a/include/linux/pcie-dwc.h b/include/linux/pcie-dwc.h
> index 40f3545731c8..6436e7fadc75 100644
> --- a/include/linux/pcie-dwc.h
> +++ b/include/linux/pcie-dwc.h
> @@ -28,6 +28,8 @@ static const struct dwc_pcie_vsec_id dwc_pcie_rasdes_vsec_ids[] = {
>  	  .vsec_id = 0x02, .vsec_rev = 0x4 },
>  	{ .vendor_id = PCI_VENDOR_ID_QCOM,
>  	  .vsec_id = 0x02, .vsec_rev = 0x4 },
> +	{ .vendor_id = PCI_VENDOR_ID_SAMSUNG,
> +	  .vsec_id = 0x02, .vsec_rev = 0x4 },
>  	{} /* terminator */
>  };
>  
> -- 
> 2.17.1
> 

