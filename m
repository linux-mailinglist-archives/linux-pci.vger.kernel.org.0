Return-Path: <linux-pci+bounces-36042-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC79B553B9
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 17:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DACB7B64EAC
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 15:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB4D30F54D;
	Fri, 12 Sep 2025 15:33:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEB03115BE;
	Fri, 12 Sep 2025 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691235; cv=none; b=bX+l/Qw324G2UGR2ND2BRkLqpcpm2Z1yMo6QMuvx/S2T3uAz/QY9ShANhGFMv/TrI7yzT7TEU5BUei+/vFR7q7jji2AKpezdtUF4qm/hbn3/2WIHF+F2kb/8VZaNbroy1VPIfJVA79fKsIVs89g9toOe3XGJ2r99XmJFkWSr2d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691235; c=relaxed/simple;
	bh=Yf6gphKjYSoORScCnkQ+lf2y5m/zepnTYR1+L9G6++M=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CMO1l/KlkAV0M0KHRAJkFd/uhpg+TwD10YTFiLsQ7801OrmvQ3KCKxJh9SCEotyOmHw61LY0eQSNsLtXuPhQaRwqm/EIQRZ9RInjJYlvZTQSRUkUGZI3NE3BkFKbzCxh/C6vT5mLw/mGd+YY4E9TIkSyv+hgQntGTUR1HwxtacE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cNdhv418Cz6D8cf;
	Fri, 12 Sep 2025 23:32:31 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0A3861402EA;
	Fri, 12 Sep 2025 23:33:50 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 12 Sep
 2025 17:33:49 +0200
Date: Fri, 12 Sep 2025 16:33:48 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 12/16] PCI: PCIe portdrv: Add cxl_isolation sysfs
 attributes
Message-ID: <20250912163348.00004d1b@huawei.com>
In-Reply-To: <20250730214718.10679-13-Benjamin.Cheatham@amd.com>
References: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
	<20250730214718.10679-13-Benjamin.Cheatham@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 30 Jul 2025 16:47:14 -0500
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> Add sysfs attributes to enable/disable CXL isolation and transaction
> timeout. The intended use for these attributes is to disable isolation
> and/or timeout as part of device maintenance or hotplug.
> 
> The attributes are added under a new "cxl_isolation" group on the PCIe
> Root Port device.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
Comments below apply in quite a few of these functions, I just
picked one example to talk about.

Thanks,

Jonathan

> diff --git a/drivers/pci/pcie/cxl_isolation.c b/drivers/pci/pcie/cxl_isolation.c
> index 5a56a327b599..9d2ad14810e8 100644
> --- a/drivers/pci/pcie/cxl_isolation.c
> +++ b/drivers/pci/pcie/cxl_isolation.c



> +static ssize_t timeout_ctrl_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct cxl_port *port;
> +	u32 ctrl;
> +
> +	struct cxl_dport **dport __free(kfree) =
> +		kzalloc(sizeof(*dport), GFP_KERNEL);
> +	if (!dport)
> +		return -ENOMEM;
> +
> +	port = cxl_find_pcie_rp(pdev, dport);
	struct cxl_port *port __free(put_cxl_port) = cxl_find_pcie_rp();

Same for other cases above.


> +	if (!port || !(*dport))

leaks device reference if port is set and dport isn't.

> +		return -ENODEV;
> +
> +	if (!(*dport)->regs.isolation)
leaks device reference.
> +		return -ENXIO;
> +
> +	ctrl = readl((*dport)->regs.isolation + CXL_ISOLATION_CTRL_OFFSET);
> +	put_device(&port->dev);

and no need to do this by hand.

> +
> +	return sysfs_emit(buf, "%lu\n",
> +			  FIELD_GET(CXL_ISOLATION_CTRL_MEM_TIME_ENABLE, ctrl));
> +}
> +DEVICE_ATTR_RW(timeout_ctrl);
> +
> +static struct attribute *isolation_attrs[] = {
> +	&dev_attr_timeout_ctrl.attr,
> +	&dev_attr_isolation_ctrl.attr,
> +	NULL,
My favorite trivial comment :) No need for that trailing comma.
> +};




