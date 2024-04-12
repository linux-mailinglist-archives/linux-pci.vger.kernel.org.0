Return-Path: <linux-pci+bounces-6192-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 066028A3526
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 19:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA8D288B3E
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 17:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD13614D70F;
	Fri, 12 Apr 2024 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hBpdQpOP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE3D14C596;
	Fri, 12 Apr 2024 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712944318; cv=none; b=J8B2FFPwhLM4mxQosKDVmXiO756uj6d7hvNztZbJzgtKIc3mJx5YdRGwFjWxTgiSiNPyc0yM59DhvGvIG29/wPqnoG5Ci0pkc/Lg4Ln2wOENTgwXYu6l6N2tnDsuTryib2i0126TefLMYSMxZ9Hp3+qOD6lrtWcsOiXDf70JyNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712944318; c=relaxed/simple;
	bh=/lEuS/E7cqgtce5zjplbZPn/g1CG7srY/ywTw28hZP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZtvFzamloDoiecefLaY7wr/fDArsG7twE5i+yZiJuunbgDOVhF2SioxqAffxfivCHXZVkPXx9a40l/Wf5nRmzuIYCrH5iNDkq/d4GrEiS2MM5mpD+AKUP6jjFugDITn1T6FNbqVdv2d1FGZRARccgYQ9vcjt9BioITfN1G7vis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hBpdQpOP; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712944317; x=1744480317;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/lEuS/E7cqgtce5zjplbZPn/g1CG7srY/ywTw28hZP4=;
  b=hBpdQpOPyGNC/hTnGMm0rhGBkyKLfdmOfsiYU65M8l/mJuvqrr/8/b92
   YrsqFqolGmf8Bowb0C9eDwltgTq1EBfDIgndBMUj1pDsGI3dw6Du0vqWZ
   v4glCFcmf2j0CvJyYTo6R/8RnXjdZDnXpkEKhHjpd57SUHs+EOA5xbl7g
   BFagQ288FNh1j2dw9klOFQ5HqwKxdrL7OHfdBHq51hkQ/HNFftgY9eIuG
   KrTM4fzb81TamIw4sgcm9YYpOLwheOiqKbBriZsL1wBbhemitSPg0nR8j
   SudIZNw0eWE8JcTzfYvoEi7yXFy11W/+nS8YIbTnPQ9K0JsVhDa15eF8I
   g==;
X-CSE-ConnectionGUID: vGlwnIciRYmw15K/svAM2Q==
X-CSE-MsgGUID: kLyVtZgmSbaNXE0vUOi3Rw==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="12199729"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="12199729"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 10:51:56 -0700
X-CSE-ConnectionGUID: FGd5+Cl8Q7SvwZlk+ibSEg==
X-CSE-MsgGUID: m7b0yhK+TE+8bPkB7irrig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="25846746"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.34.215]) ([10.212.34.215])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 10:51:55 -0700
Message-ID: <c4e473bc-aa4e-4cb2-aca2-e96a75386a7a@intel.com>
Date: Fri, 12 Apr 2024 10:51:54 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] cxl/pci: Add sysfs attribute for CXL 1.1 device
 link status
To: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>,
 kobayashi.da-06@jp.fujitsu.com, linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com, linux-pci@vger.kernel.org, mj@ucw.cz,
 dan.j.williams@intel.com
References: <20240412070715.16160-1-kobayashi.da-06@fujitsu.com>
 <20240412070715.16160-3-kobayashi.da-06@fujitsu.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240412070715.16160-3-kobayashi.da-06@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/12/24 12:07 AM, Kobayashi,Daisuke wrote:
> Add sysfs attribute for CXL 1.1 device link status to the cxl pci device.
> 
> In CXL1.1, the link status of the device is included in the RCRB mapped to
> the memory mapped register area. Critically, that arrangement makes the
> link status and control registers invisible to existing PCI user tooling.
> 
> Export those registers via sysfs with the expectation that PCI user
> tooling will alternatively look for these sysfs files when attempting to
> access to these CXL 1.1 endpoints registers.
> 
> Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>

Minor nit. Maybe arrange the variable declaration in reverse xmas tree format. Otherwise LGTM.

> ---
>  drivers/cxl/pci.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 2ff361e756d6..b2d8198ab532 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -786,6 +786,103 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  	return 0;
>  }
>  
> +static ssize_t rcd_link_cap_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_port *port;
> +	struct cxl_dport *dport;
> +	struct cxl_dev_state *cxlds = dev_get_drvdata(dev);
> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> +	struct device *endpoint_parent;
> +
> +	port = cxl_mem_find_port(cxlmd, &dport);
> +	if (!port)
> +		return -EINVAL;
> +
> +	endpoint_parent = port->uport_dev;
> +	if (!endpoint_parent)
> +		return -ENXIO;
> +
> +	guard(device)(endpoint_parent);
> +	if (!endpoint_parent->driver)
> +		return -ENXIO;
> +
> +	return sysfs_emit(buf, "%x\n", dport->rcrb.rcd_lnkcap);
> +}
> +static DEVICE_ATTR_RO(rcd_link_cap);
> +
> +static ssize_t rcd_link_ctrl_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_port *port;
> +	struct cxl_dport *dport;
> +	struct cxl_dev_state *cxlds = dev_get_drvdata(dev);
> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> +	struct device *endpoint_parent;
> +
> +	port = cxl_mem_find_port(cxlmd, &dport);
> +	if (!port)
> +		return -EINVAL;
> +
> +	endpoint_parent = port->uport_dev;
> +	if (!endpoint_parent)
> +		return -ENXIO;
> +
> +	guard(device)(endpoint_parent);
> +	if (!endpoint_parent->driver)
> +		return -ENXIO;
> +
> +	return sysfs_emit(buf, "%x\n", dport->rcrb.rcd_lnkctrl);
> +}
> +static DEVICE_ATTR_RO(rcd_link_ctrl);
> +
> +static ssize_t rcd_link_status_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_port *port;
> +	struct cxl_dport *dport;
> +	struct cxl_dev_state *cxlds = dev_get_drvdata(dev);
> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> +	struct device *endpoint_parent;
> +
> +	port = cxl_mem_find_port(cxlmd, &dport);
> +	if (!port)
> +		return -EINVAL;
> +
> +	endpoint_parent = port->uport_dev;
> +	if (!endpoint_parent)
> +		return -ENXIO;
> +
> +	guard(device)(endpoint_parent);
> +	if (!endpoint_parent->driver)
> +		return -ENXIO;
> +
> +	return sysfs_emit(buf, "%x\n", dport->rcrb.rcd_lnkstatus);
> +}
> +static DEVICE_ATTR_RO(rcd_link_status);
> +
> +static struct attribute *cxl_rcd_attrs[] = {
> +		&dev_attr_rcd_link_cap.attr,
> +		&dev_attr_rcd_link_ctrl.attr,
> +		&dev_attr_rcd_link_status.attr,
> +		NULL
> +};
> +
> +static umode_t cxl_rcd_visible(struct kobject *kobj,
> +					  struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (is_cxl_restricted(pdev))
> +		return a->mode;
> +
> +	return 0;
> +}
> +
> +static struct attribute_group cxl_rcd_group = {
> +		.attrs = cxl_rcd_attrs,
> +		.is_visible = cxl_rcd_visible,
> +};
> +__ATTRIBUTE_GROUPS(cxl_rcd);
> +
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> @@ -969,6 +1066,7 @@ static struct pci_driver cxl_pci_driver = {
>  	.id_table		= cxl_mem_pci_tbl,
>  	.probe			= cxl_pci_probe,
>  	.err_handler		= &cxl_error_handlers,
> +	.dev_groups		= cxl_rcd_groups,
>  	.driver	= {
>  		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
>  	},

