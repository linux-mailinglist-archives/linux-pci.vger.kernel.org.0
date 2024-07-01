Return-Path: <linux-pci+bounces-9512-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6159D91DD90
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 13:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B8901C21137
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 11:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC1213AA35;
	Mon,  1 Jul 2024 11:09:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F1F13E022;
	Mon,  1 Jul 2024 11:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719832186; cv=none; b=cUDx4WjFtBurPjwsQVmIYOiZ6CmBld9MkqhvZkF0bk+ZE5NFGcjVOIQdSHDIrp42dmxlLaId69LXuqWtU7tbRM5mCGG8vgEmxVByNn7okrzItkCBKOlEvgkFak2L1MlCp7F6c7naKtANFG30A9StIgUMg2QXLCySQl/dEVJUjXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719832186; c=relaxed/simple;
	bh=IX+XA5uj0OK4F5RCJsG5Z4rg37XfVs0EJxNmkdceRO4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aHFHnmmXABuSAbbZ/j1eIXWDsWWaC4iMIuHnzFPx+JB0moCat8eMrhKuDpBWzcywdvRvdXWsv8ukVNyelmCxuV95oI4sNWrK92U8RTL4jQf21xlcSsEe4Q5sFKvfOQubavzntFB6Xp/N9HjsUJSPh4ysduXbmtFC5J09EGXgiso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WCNb82ctNz6JB7Y;
	Mon,  1 Jul 2024 19:09:08 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 06DB8140B2A;
	Mon,  1 Jul 2024 19:09:41 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 1 Jul
 2024 12:09:40 +0100
Date: Mon, 1 Jul 2024 12:09:39 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Shradha Todi <shradha.t@samsung.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<manivannan.sadhasivam@linaro.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<fancer.lancer@gmail.com>, <yoshihiro.shimoda.uh@renesas.com>,
	<conor.dooley@microchip.com>, <pankaj.dubey@samsung.com>,
	<gost.dev@samsung.com>
Subject: Re: [PATCH 2/3] PCI: debugfs: Add support for RASDES framework in
 DWC
Message-ID: <20240701120939.00002d76@Huawei.com>
In-Reply-To: <20240625093813.112555-3-shradha.t@samsung.com>
References: <20240625093813.112555-1-shradha.t@samsung.com>
	<CGME20240625094443epcas5p3093ac786a7d0f09de5a3bba17bbd4458@epcas5p3.samsung.com>
	<20240625093813.112555-3-shradha.t@samsung.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 25 Jun 2024 15:08:12 +0530
Shradha Todi <shradha.t@samsung.com> wrote:

> Add support to use the RASDES feature of DesignWare PCIe controller
> using debugfs entries.
>=20
> RASDES is a vendor specific extended PCIe capability which reads the
> current hardware internal state of PCIe device. Following primary
> features are provided to userspace via debugfs:
> - Debug registers
> - Error injection
> - Statistical counters
>=20
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>

A few minor things inline.

> +
> +struct rasdes_info {
> +	/* to store rasdes capability offset */
> +	u32 ras_cap;
> +	struct mutex dbg_mutex;

Add a comment on what data this mutex protects.

> +	struct dentry *rasdes;
> +};

> +struct err_inj {
Very generic name is likely to bite in future if similar
gets defined in a header. I'd at least prefix with dw_

> +	const char *name;
> +	/* values can be from group 0 - 6 */
> +	u32 err_inj_group;
> +	/* within each group there can be types */
> +	u32 err_inj_type;
> +	/* More details about the error */
> +	u32 err_inj_12_31;
> +};


> +
> +int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci)
> +{
> +	struct device *dev =3D pci->dev;
> +	int ras_cap;
> +	struct rasdes_info *dump_info;
> +	char dirname[DWC_DEBUGFS_MAX];
> +	struct dentry *dir, *rasdes_debug, *rasdes_err_inj;
> +	struct dentry *rasdes_event_counter, *rasdes_events;
> +	int i;

Perhaps combine with int ras_cap above.

=46rom a quick look, I think this can get called from resume paths
as well as initial setup which doesn't look like a safe thing to do.
imx6_pcie_resume_irq()
dw_pcie_setup_rc()
dw_pcie_setup()
dwc_pcie_rasdes_debugfs_init()


> +	struct rasdes_priv *priv_tmp;
> +
> +	ras_cap =3D dw_pcie_find_vsec_capability(pci, DW_PCIE_RAS_DES_CAP);
> +	if (!ras_cap) {
> +		dev_err(dev, "No RASDES capability available\n");
> +		return -ENODEV;
> +	}
> +
> +	dump_info =3D devm_kzalloc(dev, sizeof(*dump_info), GFP_KERNEL);
> +	if (!dump_info)
> +		return -ENOMEM;
> +
> +	/* Create main directory for each platform driver */
> +	sprintf(dirname, "pcie_dwc_%s", dev_name(dev));

dev_name could in theory be huge.  I'd use snprintf() and check the
result as more obviously correct.

> +	dir =3D debugfs_create_dir(dirname, NULL);

Check for errors in all these.

> +
> +	/* Create subdirectories for Debug, Error injection, Statistics */
> +	rasdes_debug =3D debugfs_create_dir("rasdes_debug", dir);
> +	rasdes_err_inj =3D debugfs_create_dir("rasdes_err_inj", dir);
> +	rasdes_event_counter =3D debugfs_create_dir("rasdes_event_counter", dir=
);
> +
> +	mutex_init(&dump_info->dbg_mutex);
> +	dump_info->ras_cap =3D ras_cap;
> +	dump_info->rasdes =3D dir;
> +	pci->dump_info =3D dump_info;
> +
> +	/* Create debugfs files for Debug subdirectory */
> +	dwc_debugfs_create(lane_detect);
> +	dwc_debugfs_create(rx_valid);
> +
> +	/* Create debugfs files for Error injection subdirectory */
> +	for (i =3D 0; i < ARRAY_SIZE(err_inj_list); i++) {
> +		priv_tmp =3D devm_kzalloc(dev, sizeof(*priv_tmp), GFP_KERNEL);
> +		if (!priv_tmp)
> +			goto err;
> +
> +		priv_tmp->idx =3D i;
> +		priv_tmp->pci =3D pci;
> +		debugfs_create_file(err_inj_list[i].name, 0200,
> +				    rasdes_err_inj, priv_tmp, &err_inj_ops);
> +	}
> +
> +	/* Create debugfs files for Statistical counter subdirectory */
> +	for (i =3D 0; i < ARRAY_SIZE(event_counters); i++) {
> +		priv_tmp =3D devm_kzalloc(dev, sizeof(*priv_tmp), GFP_KERNEL);
> +		if (!priv_tmp)
> +			goto err;
> +
> +		priv_tmp->idx =3D i;
> +		priv_tmp->pci =3D pci;
> +		rasdes_events =3D debugfs_create_dir(event_counters[i].name,
> +						   rasdes_event_counter);
> +		if (event_counters[i].group_no =3D=3D 0) {
> +			debugfs_create_file("lane_select", 0644, rasdes_events,
> +					    priv_tmp, &cnt_lane_ops);
> +		}
> +		debugfs_create_file("counter_value", 0444, rasdes_events, priv_tmp,
> +				    &cnt_val_ops);
> +		debugfs_create_file("counter_enable", 0644, rasdes_events, priv_tmp,
> +				    &cnt_en_ops);
> +	}
> +
> +	return 0;
> +err:
> +	dwc_pcie_rasdes_debugfs_deinit(pci);
> +	return -ENOMEM;
> +}
> diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.h b/drive=
rs/pci/controller/dwc/pcie-designware-debugfs.h
> new file mode 100644
> index 000000000000..e69de29bb2d1
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/c=
ontroller/dwc/pcie-designware.h
> index 77686957a30d..9fa9f33e4ddb 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -223,6 +223,8 @@
> =20
>  #define PCIE_RAS_DES_EVENT_COUNTER_DATA		0xc
> =20
> +#define DW_PCIE_RAS_DES_CAP			0x2

I'd be tempted to try and name that in a fashion that makes it clear it
is a vsec capability ID.  Currently it sounds like a top level
capability ID.

> +
>  /*
>   * The default address offset between dbi_base and atu_base. Root contro=
ller
>   * drivers are not required to initialize atu_base if the offset matches=
 this
> @@ -410,6 +412,7 @@ struct dw_pcie {
>  	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
>  	struct gpio_desc		*pe_rst;
>  	bool			suspended;
> +	void			*dump_info;
>  };



