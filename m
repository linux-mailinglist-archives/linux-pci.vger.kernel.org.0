Return-Path: <linux-pci+bounces-19925-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF7AA12D1C
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 22:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0158F188587F
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 21:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02273161321;
	Wed, 15 Jan 2025 21:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0PId+TQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABDA1547C5;
	Wed, 15 Jan 2025 21:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736975032; cv=none; b=V6IfNzaZKfIzq60PUecAAWpQIS5QJh1zIfG+lXaEdlQRaaZF02EK+YN6oTR9GPTi8RuoeoYcTG6odBkZaTZVgDDg+CvgeE/ulRIi3oJDL1GdIgTo4erzCEmE2nd+LC6RaGpjG1SrD2WUKMUhH8HzxgeOrpA4O/WG7Eusx0SUYDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736975032; c=relaxed/simple;
	bh=lMRKm7H0y6lM7MZXaueOaWtWjQJWX5IPdelZRkGqKgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YhU7N9/OgI7Bt5HC7xUaYsypeJt74UnOIz7sb8rEO/ASqskdZnk4SBkEbJuvsGmvKE9HW9Pt1CRMd/wR1cGH7QhGIeoglFu7EnyMnE8jUi+M7AfIzKrmPS/UciB9j3D4+6RFg0kCw7xJWW6ZypfVNb4iVnGyDNbVQe42HdrPMzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0PId+TQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2121DC4CED1;
	Wed, 15 Jan 2025 21:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736975032;
	bh=lMRKm7H0y6lM7MZXaueOaWtWjQJWX5IPdelZRkGqKgQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=N0PId+TQjhUpdjhpfczwSij15PMiHrRf+5BLv7sVKxRrFlxIip1LtuZYwPDZhBE8o
	 ePXKBTp79CsJw+l/K4PRpaXKUbnDVEcOd8rveMlmmni8HRnALQdBfZ4cXzY06xxxxq
	 85hdesUoKWGVvioMoCW5WSy0eA6ZWRuoe/M3+3SVInq0uyvEmBGkn1Jf5vpn3WLGBK
	 9LK/Ri+GRZKkZ9lNKdgjlExkcQbj+gr0Qpxsl0/FoMWjyLpw5MOPQa8yO+uoeIE5kX
	 +EhHL7htroPfiydUoQTWzv8qqIYE6KRX1MPrnr4beJbSdmq3w0Kt8CE8ApUwj9Gzkf
	 xe6kF9EWddhdQ==
Date: Wed, 15 Jan 2025 15:03:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Frank Li <Frank.Li@nxp.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [pci:controller/imx6 2/2]
 drivers/pci/controller/dwc/pci-imx6.c:1116:11: warning: variable 'sid' is
 used uninitialized whenever 'if' condition is false
Message-ID: <20250115210350.GA552349@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202501151501.d4MgHDRq-lkp@intel.com>

On Wed, Jan 15, 2025 at 03:19:09PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/imx6
> head:   bc92494deb1c40f7336ca645c3815f19a5d0e2af
> commit: d02f7572cb39c962d0e432f57a267a844d164b4f [2/2] PCI: imx6: Add IOMMU and ITS MSI support for i.MX95
> config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250115/202501151501.d4MgHDRq-lkp@intel.com/config)
> compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250115/202501151501.d4MgHDRq-lkp@intel.com/reproduce)

Resolved as below (I also renamed this branch from pci/controller/imx6
to pci/controller/iommu-map because I added Marc's pcie-apple patches
on top):

> vim +1116 drivers/pci/controller/dwc/pci-imx6.c
> 
>   1035	
>   1036	static int imx_pcie_enable_device(struct pci_host_bridge *bridge,
>   1037					  struct pci_dev *pdev)
>   1038	{
>   1039		struct imx_pcie *imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bridge->sysdata));
>   1040		u32 sid_i, sid_m, rid = pci_dev_id(pdev);
>   1041		struct device_node *target;
>   1042		struct device *dev;
>   1043		int err_i, err_m;
>   1044		u32 sid;

I made this "u32 sid = 0;" to resolve this warning.

>   1046		dev = imx_pcie->pci->dev;
>   1047	
>   1048		target = NULL;
>   1049		err_i = of_map_id(dev->of_node, rid, "iommu-map", "iommu-map-mask",
>   1050				  &target, &sid_i);
>   1051		if (target) {
>   1052			of_node_put(target);
>   1053		} else {
>   1054			/*
>   1055			 * "target == NULL && err_i == 0" means RID out of map range.
>   1056			 * Use 1:1 map RID to streamID. Hardware can't support this
>   1057			 * because the streamID is only 6 bits
>   1058			 */
>   1059			err_i = -EINVAL;
>   1060		}
>   1061	
>   1062		target = NULL;
>   1063		err_m = of_map_id(dev->of_node, rid, "msi-map", "msi-map-mask",
>   1064				  &target, &sid_m);
>   1065	
>   1066		/*
>   1067		 *   err_m      target
>   1068		 *	0	NULL		RID out of range. Use 1:1 map RID to
>   1069		 *				streamID, Current hardware can't
>   1070		 *				support it, so return -EINVAL.
>   1071		 *      != 0    NULL		msi-map does not exist, use built-in MSI
>   1072		 *	0	!= NULL		Get correct streamID from RID
>   1073		 *	!= 0	!= NULL		Invalid combination
>   1074		 */
>   1075		if (!err_m && !target)
>   1076			return -EINVAL;
>   1077		else if (target)
>   1078			of_node_put(target); /* Find streamID map entry for RID in msi-map */
>   1079	
>   1080		/*
>   1081		 * msi-map        iommu-map
>   1082		 *   N                N            DWC MSI Ctrl
>   1083		 *   Y                Y            ITS + SMMU, require the same SID
>   1084		 *   Y                N            ITS
>   1085		 *   N                Y            DWC MSI Ctrl + SMMU
>   1086		 */
>   1087		if (err_i && err_m)
>   1088			return 0;
>   1089	
>   1090		if (!err_i && !err_m) {
>   1091			/*
>   1092			 *	    Glue Layer
>   1093			 *          <==========>
>   1094			 * ┌─────┐                  ┌──────────┐
>   1095			 * │ LUT │ 6-bit streamID   │          │
>   1096			 * │     │─────────────────►│  MSI     │
>   1097			 * └─────┘   2-bit ctrl ID  │          │
>   1098			 *             ┌───────────►│          │
>   1099			 *  (i.MX95)   │            │          │
>   1100			 *  00 PCIe0   │            │          │
>   1101			 *  01 ENETC   │            │          │
>   1102			 *  10 PCIe1   │            │          │
>   1103			 *             │            └──────────┘
>   1104			 * The MSI glue layer auto adds 2 bits controller ID ahead of
>   1105			 * streamID, so mask these 2 bits to get streamID. The
>   1106			 * IOMMU glue layer doesn't do that.
>   1107			 */
>   1108			if (sid_i != (sid_m & IMX95_SID_MASK)) {
>   1109				dev_err(dev, "iommu-map and msi-map entries mismatch!\n");
>   1110				return -EINVAL;
>   1111			}
>   1112		}
>   1113	
>   1114		if (!err_i)
>   1115			sid = sid_i;
> > 1116		else if (!err_m)
>   1117			sid = sid_m & IMX95_SID_MASK;
>   1118	
>   1119		return imx_pcie_add_lut(imx_pcie, rid, sid);
>   1120	}
>   1121	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

