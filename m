Return-Path: <linux-pci+bounces-36044-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC80B55433
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 17:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9547A05A8C
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 15:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0A030649E;
	Fri, 12 Sep 2025 15:55:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12D730103C;
	Fri, 12 Sep 2025 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692547; cv=none; b=M3hYFkM2kojAuIlO9PbsFHLqWDf8IMkKBULmqU6trG+Mh6cRqj0gwfU+m9sGTnZzJjiFlpmOqAoCC5EKMMovB3WMjtubF0wIKokNhTe/DCS+pqjsdbnoNWZETpAVMfSsofExXahNBl1lLpEMr+PJbV/YJPNgtsjHqOP6z1lvbig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692547; c=relaxed/simple;
	bh=ip4v+tHAi+eiUNKRXZp2C+ox2YheamuxyFJeTs6f0Jg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b251hg8ogcvA2bChNbO98wQsZjDDkudg+CwS/EL0dQ8BLpaF1S7oDvXWb3NjTKO/i5zEI0Gwjum4NmlTxEO7PkSAUEHgYP6ePHhTeyBGGjh6z/6lPS+iT3OMru72NJAmE4SdZFpzyNLOEdAo1d1ddo6XNn2zYQH1W4yxLVUhkzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cNf8X6bKwz6M57R;
	Fri, 12 Sep 2025 23:53:00 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7D1561402EA;
	Fri, 12 Sep 2025 23:55:42 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 12 Sep
 2025 17:55:42 +0200
Date: Fri, 12 Sep 2025 16:55:41 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 13/16] cxl/core, PCI: PCIe portdrv: Add CXL timeout
 range programming
Message-ID: <20250912165541.00004594@huawei.com>
In-Reply-To: <20250730214718.10679-14-Benjamin.Cheatham@amd.com>
References: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
	<20250730214718.10679-14-Benjamin.Cheatham@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 30 Jul 2025 16:47:15 -0500
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> Add functions to enable programming the CXL.mem transaction timeout
> range, if supported. Add a sysfs attribute to the "cxl_isolation" group
> to allow programming the timeout from userspace.
> 
> The attribute can take either the CXL spec-defined hex value for the
> associated timeout range (CXL 3.2 8.2.4.24.2 field 3:0) or a
> string with the range. The range string is formatted as the range letter
> in uppercase or lowercase, with an optional "2" to specify the second
> range in the aforementioned spec ref.
> 
> For example, to program the port with a timeout of 65ms to 210ms (range B)
> the following strings could be specified: "b2"/"B2". Picking the first
> portion of range B (16ms to 55ms) would be: "b"/"B".
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>

This needs some ABI Docs.
The spec is exceedingly weird, so working out a sensible way to present
it to userspace will be a challenge. I vaguely recall the weird timing
description is from some other spec.  Any idea where and if there is existing 
ABI for that?

> diff --git a/drivers/pci/pcie/cxl_isolation.c b/drivers/pci/pcie/cxl_isolation.c
> index 9d2ad14810e8..107201b5843f 100644
> --- a/drivers/pci/pcie/cxl_isolation.c
> +++ b/drivers/pci/pcie/cxl_isolation.c

> +static ssize_t timeout_range_show(struct device *dev,
> +				  struct device_attribute *attr, char * buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct cxl_port *port;
> +	u32 ctrl, val;
> +
> +	struct cxl_dport **dport __free(kfree) =
> +		kzalloc(sizeof(*dport), GFP_KERNEL);
> +	if (!dport)
> +		return -ENOMEM;
> +
> +	port = cxl_find_pcie_rp(pdev, dport);
> +	if (!port || !(*dport))
> +		return -ENODEV;
> +
> +	if (!(*dport)->regs.isolation)

Same issue with reference leak as in previous patch.

> +		return -ENXIO;
> +
> +	ctrl = readl((*dport)->regs.isolation + CXL_ISOLATION_CTRL_OFFSET);
> +	put_device(&port->dev);
> +
> +	val = FIELD_GET(CXL_ISOLATION_CTRL_MEM_TIME_MASK, ctrl);
> +	for (int i = 0; i < ARRAY_SIZE(ranges); i++)
> +		if (ranges[i].val == val)
> +			return sysfs_emit(buf, "%s\n", ranges[i].str);
> +
> +	return -ENXIO;
> +}
> +DEVICE_ATTR_RW(timeout_range);


