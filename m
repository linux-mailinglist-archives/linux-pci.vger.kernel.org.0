Return-Path: <linux-pci+bounces-21285-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EC9A32529
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 12:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A38571631F2
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 11:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48B3209F5A;
	Wed, 12 Feb 2025 11:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LE2dkoAq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11A22080F4
	for <linux-pci@vger.kernel.org>; Wed, 12 Feb 2025 11:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739360437; cv=none; b=DwvMdsdWi0lUV7piNxJb42G0l/GxWm4z/f+pH2t9RzD5wDWE/RbniNNUuURS9LfubndtGgBr1yaLUhLAi/UIIf2sUdhMoQRMqL/RyGRHKie6M74inky5TPDBw2aJ492aSQhA5AU6X0TiuioDjsnq5x+CMvOh6Ffb+2pjNpnvFRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739360437; c=relaxed/simple;
	bh=En9JDZzEdezc3b/6EnprRKRTsXxSVSObEw/J8XdytxY=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=TbNbpfS9dEqD9YH8f7/HQuxtundrFdDmZXl14POXhlkrkL/LIfBUuKKBdkQMHyclTYGm/0Q2c2U5OkSXr+E6wlEN12rR4yXuksgzghi3f+4xT2X97XtCzWE2hslivvWPBtiiamHAD6pLd0g571eVKqwkL0Ptm1eFqosZMVQPga4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=LE2dkoAq; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250212114027epoutp03248d8b5a48cae525c461c14b5960e3b0~jcxfMJF1f1272612726epoutp03N
	for <linux-pci@vger.kernel.org>; Wed, 12 Feb 2025 11:40:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250212114027epoutp03248d8b5a48cae525c461c14b5960e3b0~jcxfMJF1f1272612726epoutp03N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739360427;
	bh=47rC+cDSWxnZsJ/Xxu0r2au2i1us1XVUWjk0JmBECvU=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=LE2dkoAqV+XWySrrBBnKxPNyX254Vu0/+5UcLqECYLcO94yIxiwfUWer5BA6ANcb1
	 qYwmtF2ub5KoKPa6NcxkwsshslXkPU0yT2v1/wQTnyGr1qP1nTkMw5/W14EHX4MI+D
	 u1Dq7LT7lPCsPQqR554ZQYK1+evDUXT7JVMdTIuw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250212114026epcas5p343fbcece0bac46107a01dce5f66c5a8f~jcxekjC3-2831428314epcas5p3e;
	Wed, 12 Feb 2025 11:40:26 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4YtGZw3mHKz4x9Q1; Wed, 12 Feb
	2025 11:40:24 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D2.67.29212.8A88CA76; Wed, 12 Feb 2025 20:40:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250212113956epcas5p4f0215c1515290c6c6003298ce0aea412~jcxCrodh10757707577epcas5p4D;
	Wed, 12 Feb 2025 11:39:56 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250212113956epsmtrp16148100f518cafe6d9ccb61f616b1255~jcxCq2qNW0647406474epsmtrp1f;
	Wed, 12 Feb 2025 11:39:56 +0000 (GMT)
X-AuditID: b6c32a50-801fa7000000721c-25-67ac88a85eb3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	77.9A.18949.C888CA76; Wed, 12 Feb 2025 20:39:56 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250212113954epsmtip1eda5dae288761baa29e4417a9fad70e1~jcxA4xLsF1167611676epsmtip1C;
	Wed, 12 Feb 2025 11:39:54 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Hans Zhang'" <18255117159@163.com>, <jingoohan1@gmail.com>
Cc: <manivannan.sadhasivam@linaro.org>, <lpieralisi@kernel.org>,
	<kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
	<Frank.Li@nxp.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <rockswang7@gmail.com>
In-Reply-To: <20250206151343.26779-1-18255117159@163.com>
Subject: RE: [v2] PCI: dwc: Add the debugfs property to provide the LTSSM
 status of the PCIe link
Date: Wed, 12 Feb 2025 17:09:53 +0530
Message-ID: <000001db7d42$d6b56fd0$84204f70$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHezn9orZZmZ7guEAUISCCoyxgSeQGnFLeysy+ngCA=
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLJsWRmVeSWpSXmKPExsWy7bCmhu6KjjXpBm8aJC2utP9mt1jSlGHR
	9mUnk8WKLzPZLRp6frNaXN41h83i7LzjbBYtf1pYLO62dLJa/N+zg92iedoNJgduj8UrprB6
	7Jx1l91jwaZSj02rOtk87lzbw+bx5Mp0Jo+N73YweXzeJBfAEZVtk5GamJJapJCal5yfkpmX
	bqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0p5JCWWJOKVAoILG4WEnfzqYov7Qk
	VSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO+Pb4VbmgqclFdevTGVsYJyR
	1MXIwSEhYCKxvcOxi5GTQ0hgD6PE0vPlXYxcQPYnRomOextYIZxvjBKfv65jAqkCaVh/Zjoz
	RGIvo8TmD1egnBeMEo8vb2cHqWIT0JF4cuUPM4gtIuAgMbn/MBtIETNIUdPTo4wgCU4BS4mj
	7V/ZQGxhgWSJ27tawFawCKhKHF5yASzOC1Tz+sZPJghbUOLkzCcsIDazgLzE9rdzmCFOUpD4
	+XQZK8QyK4k9n6cxQdSISxz92QN2nYTACQ6Jt38fMUI0uEj8ePoK6h9hiVfHt7BD2FISL/vb
	oOx0iZWbZ0AtyJH4tnkJVL29xIErc1hAgccsoCmxfpc+RFhWYuqpdVB7+SR6fz+BKueV2DEP
	xlaW+PJ3DwuELSkx79hl1gmMSrOQvDYLyWuzkLwwC2HbAkaWVYxSqQXFuempyaYFhrp5qeXw
	GE/Oz93ECE7HWgE7GFdv+Kt3iJGJg/EQowQHs5IIr8nCFelCvCmJlVWpRfnxRaU5qcWHGE2B
	AT6RWUo0OR+YEfJK4g1NLA1MzMzMTCyNzQyVxHmbd7akCwmkJ5akZqemFqQWwfQxcXBKNTDJ
	iHT4rnngouxUF3Ay1rR++m2bhPu1F15E+vneMomzOuwl+TJyC/v5ay6HcuqW3DzuP19F5Vbv
	vZKc1YetnZdLuLsc29CubxRSxmO09mOQ5wtZY+Oo2e6Mh398cO9YuLGiQp9p6j+lSwW/Phzi
	4jGYlqP+LrCX/VDazdaUIx3yXMZ5f2c9iOyZ3jJls37Ntv6FaW9uHTePfjZRalfFbY+NB1re
	3Xpy8Mdk1so5t0Wv1+znVjIsDw1Zn2Iim/npv/OLhiOCcp4VswLbvnadTX04/dVDbq6Xn5vf
	dcoyGictjJhxfF/XR7dKprcKM8OTot/bJ70pYbCfcMvCTqes5VOkyebrVnOmaOfvDp2SG6rE
	UpyRaKjFXFScCACu6YVyUAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsWy7bCSnG5Px5p0g55rUhZX2n+zWyxpyrBo
	+7KTyWLFl5nsFg09v1ktLu+aw2Zxdt5xNouWPy0sFndbOlkt/u/ZwW7RPO0GkwO3x+IVU1g9
	ds66y+6xYFOpx6ZVnWwed67tYfN4cmU6k8fGdzuYPD5vkgvgiOKySUnNySxLLdK3S+DK+Ha4
	lbngaUnF9StTGRsYZyR1MXJySAiYSKw/M525i5GLQ0hgN6PEpXO/2SASkhKfL65jgrCFJVb+
	e84OUfSMUeJA8w+wIjYBHYknV/4wg9giAk4SZ198ZwIpYhb4xCgxv3UV1NguRokbO1aDdXAK
	WEocbf8KZgsLJEp8mLEWrJtFQFXi8JILYHFeoJrXN34yQdiCEidnPmHpYuQAmqon0baRESTM
	LCAvsf3tHGaI6xQkfj5dxgpxhJXEns/TmCBqxCWO/uxhnsAoPAvJpFkIk2YhmTQLSccCRpZV
	jJKpBcW56bnFhgVGeanlesWJucWleel6yfm5mxjBEamltYNxz6oPeocYmTgYDzFKcDArifCa
	LFyRLsSbklhZlVqUH19UmpNafIhRmoNFSZz32+veFCGB9MSS1OzU1ILUIpgsEwenVANTxz6+
	rx/82DkrRNgyp8Qcr+JYelEnrf5byMnXsv37njJ3Z7J96njrV+1ptt7JXX/pN0NdnVl76mYy
	atpJGrRHpavP1pilPunNrtxs5/PHjG7m3Hd4Y7vZm9lh7cWq4839WspTrlzbHs0rkaTsrPWx
	obEs1TC64riP2IxJL2X0V5++uW7D+n1LWs/ZlE20ZIpc2b6t6eVeiX9mPh3ph23/G/+fqcre
	e/J9tK9FmmxmVd2uDWLh29/eeLhuoVLNMx62aImpK5/fWll75s8uFo9VZ2siT776ulJoH9Ns
	CUtx2VztwE+PewIqFO0C75hv4J85l2m1yMXjDD9PVQZt2by592kml+HRqqbgaVVn2pKUWIoz
	Eg21mIuKEwEd7ZxbNwMAAA==
X-CMS-MailID: 20250212113956epcas5p4f0215c1515290c6c6003298ce0aea412
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250206151446epcas5p43a35270da73181b97deb628ff49f3ddd
References: <CGME20250206151446epcas5p43a35270da73181b97deb628ff49f3ddd@epcas5p4.samsung.com>
	<20250206151343.26779-1-18255117159@163.com>



> -----Original Message-----
> From: Hans Zhang <18255117159@163.com>
> Sent: 06 February 2025 20:44
> To: jingoohan1@gmail.com; shradha.t@samsung.com
> Cc: manivannan.sadhasivam@linaro.org; lpieralisi@kernel.org; kw@linux.com; robh@kernel.org; bhelgaas@google.com;
> Frank.Li@nxp.com; linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; rockswang7@gmail.com; Hans Zhang
> <18255117159@163.com>
> Subject: [v2] PCI: dwc: Add the debugfs property to provide the LTSSM status of the PCIe link
> 
> Add the debugfs property to provide a view of the current link's LTSSM status from the root port device.
> 
>   /sys/kernel/debug/dwc_pcie_<dev>/ltssm_status
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
> Changes since v1:
> https://lore.kernel.org/linux-pci/20250123071326.1810751-1-18255117159@163.com/
> 
> - Do not place into sysfs node as recommended by maintainer. Shradha-based patch
>   is put into debugfs.
> - Submissions based on the following patches:
> https://patchwork.kernel.org/project/linux-pci/patch/20250121111421.35437-2-shradha.t@samsung.com/
> https://patchwork.kernel.org/project/linux-pci/patch/20250121111421.35437-3-shradha.t@samsung.com/
> https://patchwork.kernel.org/project/linux-pci/patch/20250121111421.35437-4-shradha.t@samsung.com/
> https://patchwork.kernel.org/project/linux-pci/patch/20250121111421.35437-5-shradha.t@samsung.com/
> ---
>  Documentation/ABI/testing/debugfs-dwc-pcie    |  6 ++
>  .../controller/dwc/pcie-designware-debugfs.c  | 70 ++++++++++++++++---
>  .../pci/controller/dwc/pcie-designware-ep.c   |  4 +-
>  .../pci/controller/dwc/pcie-designware-host.c | 54 +++++++++++++-  drivers/pci/controller/dwc/pcie-designware.h  | 43
> ++++++++++--
>  5 files changed, 159 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/debugfs-dwc-pcie b/Documentation/ABI/testing/debugfs-dwc-pcie
> index d3f84f46b400..bf0116012175 100644
> --- a/Documentation/ABI/testing/debugfs-dwc-pcie
> +++ b/Documentation/ABI/testing/debugfs-dwc-pcie
> @@ -142,3 +142,9 @@ Description:	(RW) Some lanes in the event list are lane specific events. These i
>  		events 1) - 11) and 34) - 35).
>  		Write lane number for which counter needs to be enabled/disabled/dumped.
>  		Read will return the current selected lane number. Lane0 is selected by default.
> +
> +What:		/sys/kernel/debug/dwc_pcie_<dev>/ltssm_status
> +Date:		February 2025
> +Contact:	Hans Zhang <18255117159@163.com>
> +Description:	(RO) Read will return the current value of the PCIe link status raw value and
> +		string status.
> diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> index 5d883b13be84..ddfb854aa684 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> @@ -465,7 +465,7 @@ static const struct file_operations dwc_pcie_counter_value_ops = {
>  	.read = counter_value_read,
>  };
> 
> -void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
> +static void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
>  {
>  	struct dwc_pcie_rasdes_info *rinfo = pci->rasdes_info;
> 
> @@ -473,13 +473,12 @@ void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
>  	mutex_destroy(&rinfo->reg_lock);
>  }
> 
> -int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci)
> +static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct
> +dentry *dir)
>  {
> -	struct dentry *dir, *rasdes_debug, *rasdes_err_inj, *rasdes_event_counter, *rasdes_events;
> +	struct dentry *rasdes_debug, *rasdes_err_inj, *rasdes_event_counter,
> +*rasdes_events;
>  	struct dwc_pcie_rasdes_info *rasdes_info;
>  	struct dwc_pcie_rasdes_priv *priv_tmp;
>  	const struct dwc_pcie_vendor_id *vid;
> -	char dirname[DWC_DEBUGFS_BUF_MAX];
>  	struct device *dev = pci->dev;
>  	int ras_cap, i, ret;
> 
> @@ -498,12 +497,6 @@ int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci)
>  	if (!rasdes_info)
>  		return -ENOMEM;
> 
> -	/* Create main directory for each platform driver */
> -	snprintf(dirname, DWC_DEBUGFS_BUF_MAX, "dwc_pcie_%s", dev_name(dev));
> -	dir = debugfs_create_dir(dirname, NULL);
> -	if (IS_ERR(dir))
> -		return PTR_ERR(dir);
> -
>  	/* Create subdirectories for Debug, Error injection, Statistics */
>  	rasdes_debug = debugfs_create_dir("rasdes_debug", dir);
>  	rasdes_err_inj = debugfs_create_dir("rasdes_err_inj", dir); @@ -559,3 +552,60 @@ int dwc_pcie_rasdes_debugfs_init(struct
> dw_pcie *pci)
>  	dwc_pcie_rasdes_debugfs_deinit(pci);
>  	return ret;
>  }
> +
> +static int dwc_pcie_ltssm_status_show(struct seq_file *s, void *v) {
> +	struct dw_pcie *pci = s->private;
> +	enum dw_pcie_ltssm val;
> +
> +	val = dw_pcie_get_ltssm(pci);
> +	seq_printf(s, "%s (0x%02x)\n", dw_ltssm_sts_string(val), val);
> +
> +	return 0;
> +}
> +
> +static int dwc_pcie_ltssm_status_open(struct inode *inode, struct file
> +*file) {
> +	return single_open(file, dwc_pcie_ltssm_status_show,
> +inode->i_private); }
> +
> +static const struct file_operations dwc_pcie_ltssm_status_ops = {
> +	.open = dwc_pcie_ltssm_status_open,
> +	.read = seq_read,
> +};
> +
> +static void dwc_pcie_ltssm_debugfs_init(struct dw_pcie *pci, struct
> +dentry *dir) {
> +	debugfs_create_file("ltssm_status", 0444, dir, pci,
> +			    &dwc_pcie_ltssm_status_ops);
> +}
> +
> +void dwc_pcie_debugfs_deinit(struct dw_pcie *pci) {
> +	dwc_pcie_rasdes_debugfs_deinit(pci);
> +	debugfs_remove_recursive(pci->debugfs);
> +}
> +
> +int dwc_pcie_debugfs_init(struct dw_pcie *pci) {
> +	char dirname[DWC_DEBUGFS_BUF_MAX];
> +	struct device *dev = pci->dev;
> +	struct dentry *dir;
> +	int ret;
> +
> +	/* Create main directory for each platform driver */
> +	snprintf(dirname, DWC_DEBUGFS_BUF_MAX, "dwc_pcie_%s", dev_name(dev));
> +	dir = debugfs_create_dir(dirname, NULL);
> +	if (IS_ERR(dir))
> +		return PTR_ERR(dir);
> +
> +	pci->debugfs = dir;
> +	ret = dwc_pcie_rasdes_debugfs_init(pci, dir);
> +	if (ret)
> +		dev_dbg(dev, "rasdes debugfs init failed\n");
> +
> +	dwc_pcie_ltssm_debugfs_init(pci, dir);
> +
> +	return 0;
> +}
> +
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 84b5f27a2c69..a87a714bb472 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -642,7 +642,7 @@ void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep)  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> 
> -	dwc_pcie_rasdes_debugfs_deinit(pci);
> +	dwc_pcie_debugfs_deinit(pci);
>  	dw_pcie_edma_remove(pci);
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_ep_cleanup);
> @@ -814,7 +814,7 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
> 
>  	dw_pcie_ep_init_non_sticky_registers(pci);
> 
> -	ret = dwc_pcie_rasdes_debugfs_init(pci);
> +	ret = dwc_pcie_debugfs_init(pci);
>  	if (ret)
>  		goto err_remove_edma;
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 1cd282f70830..a271dcd260c5 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -418,6 +418,56 @@ static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
>  	}
>  }
> 
> +char *dw_ltssm_sts_string(enum dw_pcie_ltssm ltssm) {
> +	char *str;
> +
> +	switch (ltssm) {
> +#define DW_PCIE_LTSSM_NAME(n) case n: str = #n; break
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DETECT_QUIET);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DETECT_ACT);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_POLL_ACTIVE);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_POLL_COMPLIANCE);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_POLL_CONFIG);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_PRE_DETECT_QUIET);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DETECT_WAIT);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_LINKWD_START);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_LINKWD_ACEPT);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_LANENUM_WAI);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_LANENUM_ACEPT);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_COMPLETE);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_IDLE);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_LOCK);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_SPEED);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_RCVRCFG);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_IDLE);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L0);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L0S);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L123_SEND_EIDLE);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L1_IDLE);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L2_IDLE);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L2_WAKE);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DISABLED_ENTRY);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DISABLED_IDLE);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DISABLED);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_LPBK_ENTRY);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_LPBK_ACTIVE);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_LPBK_EXIT);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_LPBK_EXIT_TIMEOUT);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_HOT_RESET_ENTRY);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_HOT_RESET);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ0);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ1);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ2);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ3);
> +	default:
> +		str = "DW_PCIE_LTSSM_UNKNOWN";
> +		break;
> +	}
> +
> +	return str + strlen("DW_PCIE_LTSSM_"); }
> +
>  int dw_pcie_host_init(struct dw_pcie_rp *pp)  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp); @@ -524,7 +574,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	if (ret)
>  		goto err_remove_edma;
> 
> -	ret = dwc_pcie_rasdes_debugfs_init(pci);
> +	ret = dwc_pcie_debugfs_init(pci);
>  	if (ret)
>  		goto err_remove_edma;
> 
> @@ -575,7 +625,7 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
> 
>  	dw_pcie_stop_link(pci);
> 
> -	dwc_pcie_rasdes_debugfs_deinit(pci);
> +	dwc_pcie_debugfs_deinit(pci);
> 
>  	dw_pcie_edma_remove(pci);
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 8d5dc22f06f7..a3c2d2b6284b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -330,8 +330,40 @@ enum dw_pcie_ltssm {
>  	/* Need to align with PCIE_PORT_DEBUG0 bits 0:5 */
>  	DW_PCIE_LTSSM_DETECT_QUIET = 0x0,
>  	DW_PCIE_LTSSM_DETECT_ACT = 0x1,
> +	DW_PCIE_LTSSM_POLL_ACTIVE = 0x2,
> +	DW_PCIE_LTSSM_POLL_COMPLIANCE = 0x3,
> +	DW_PCIE_LTSSM_POLL_CONFIG = 0x4,
> +	DW_PCIE_LTSSM_PRE_DETECT_QUIET = 0x5,
> +	DW_PCIE_LTSSM_DETECT_WAIT = 0x6,
> +	DW_PCIE_LTSSM_CFG_LINKWD_START = 0x7,
> +	DW_PCIE_LTSSM_CFG_LINKWD_ACEPT = 0x8,
> +	DW_PCIE_LTSSM_CFG_LANENUM_WAI = 0x9,
> +	DW_PCIE_LTSSM_CFG_LANENUM_ACEPT = 0xa,
> +	DW_PCIE_LTSSM_CFG_COMPLETE = 0xb,
> +	DW_PCIE_LTSSM_CFG_IDLE = 0xc,
> +	DW_PCIE_LTSSM_RCVRY_LOCK = 0xd,
> +	DW_PCIE_LTSSM_RCVRY_SPEED = 0xe,
> +	DW_PCIE_LTSSM_RCVRY_RCVRCFG = 0xf,
> +	DW_PCIE_LTSSM_RCVRY_IDLE = 0x10,
>  	DW_PCIE_LTSSM_L0 = 0x11,
> +	DW_PCIE_LTSSM_L0S = 0x12,
> +	DW_PCIE_LTSSM_L123_SEND_EIDLE = 0x13,
> +	DW_PCIE_LTSSM_L1_IDLE = 0x14,
>  	DW_PCIE_LTSSM_L2_IDLE = 0x15,
> +	DW_PCIE_LTSSM_L2_WAKE = 0x16,
> +	DW_PCIE_LTSSM_DISABLED_ENTRY = 0x17,
> +	DW_PCIE_LTSSM_DISABLED_IDLE = 0x18,
> +	DW_PCIE_LTSSM_DISABLED = 0x19,
> +	DW_PCIE_LTSSM_LPBK_ENTRY = 0x1a,
> +	DW_PCIE_LTSSM_LPBK_ACTIVE = 0x1b,
> +	DW_PCIE_LTSSM_LPBK_EXIT = 0x1c,
> +	DW_PCIE_LTSSM_LPBK_EXIT_TIMEOUT = 0x1d,
> +	DW_PCIE_LTSSM_HOT_RESET_ENTRY = 0x1e,
> +	DW_PCIE_LTSSM_HOT_RESET = 0x1f,
> +	DW_PCIE_LTSSM_RCVRY_EQ0 = 0x20,
> +	DW_PCIE_LTSSM_RCVRY_EQ1 = 0x21,
> +	DW_PCIE_LTSSM_RCVRY_EQ2 = 0x22,
> +	DW_PCIE_LTSSM_RCVRY_EQ3 = 0x23,
> 
>  	DW_PCIE_LTSSM_UNKNOWN = 0xFFFFFFFF,
>  };
> @@ -463,6 +495,7 @@ struct dw_pcie {
>  	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
>  	struct gpio_desc		*pe_rst;
>  	bool			suspended;
> +	struct dentry		*debugfs;

This pointer to main directory dentry is already present as rasdes_dir in struct dwc_pcie_rasdes_info.
So struct dentry *debugfs is duplicating it.

We have a few options to solve this:
1. Remove struct dentry *rasdes_dir from dwc_pcie_rasdes_info and continue to have 2 pointers exposed
in struct dw_pcie.

struct dwc_pcie_rasdes_info {
        u32 ras_cap_offset;
        struct mutex reg_lock;
};
struct dw_pcie {
       .
       .
       struct dentry           *debugfs;
        void                    *rasdes_info;
 };

2. Change rasdes_info to debugfs info:

struct dwc_pcie_rasdes_info {
        u32 ras_cap_offset;
        struct mutex reg_lock;
};
struct dwc_pcie_debugfs_info {
        struct dwc_pcie_rasdes_info *rinfo;
        struct dentry           *debugfs;
};
struct dw_pcie {
       .
       .
        void                    *debugfs_info;
 };

3. Let ras related info get initialized to 0 even when rasdes cap is not present:

struct dwc_pcie_debugfs_info {
        u32 ras_cap_offset;
        struct mutex reg_lock;
        struct dentry *debugfs;
};
struct dw_pcie {
       .
       .
        void                    *debugfs_info;
 };

I think option 2 would be the best, though it will need a bit of changes in my files. What do you suggest?

>  	void			*rasdes_info;
>  };
> 
> @@ -679,6 +712,8 @@ static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
>  	return (enum dw_pcie_ltssm)FIELD_GET(PORT_LOGIC_LTSSM_STATE_MASK, val);  }
> 
> +char *dw_ltssm_sts_string(enum dw_pcie_ltssm ltssm);
> +
>  #ifdef CONFIG_PCIE_DW_HOST
>  irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp);  int dw_pcie_setup_rc(struct dw_pcie_rp *pp); @@ -799,14 +834,14 @@
> dw_pcie_ep_get_func_from_ep(struct dw_pcie_ep *ep, u8 func_no)  #endif
> 
>  #ifdef CONFIG_PCIE_DW_DEBUGFS
> -int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci); -void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci);
> +int dwc_pcie_debugfs_init(struct dw_pcie *pci); void
> +dwc_pcie_debugfs_deinit(struct dw_pcie *pci);
>  #else
> -static inline int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci)
> +static inline int dwc_pcie_debugfs_init(struct dw_pcie *pci)
>  {
>  	return 0;
>  }
> -static inline void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
> +static inline void dwc_pcie_debugfs_deinit(struct dw_pcie *pci)
>  {
>  }
>  #endif
> 
> base-commit: 7004a2e46d1693848370809aa3d9c340a209edbb
> prerequisite-patch-id: 6e5987e85df22c4d3859d21765617055faca96a1
> prerequisite-patch-id: 200b28aafcac3933da9feffce2381a2a9b4a6243
> prerequisite-patch-id: faf05c564e8d6a7b78ea4aaac3a02abcad53fe27
> prerequisite-patch-id: 8b199e3e1baa2eafa59ad45640db1f34992bcb32
> --
> 2.25.1



