Return-Path: <linux-pci+bounces-26547-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB87A98D29
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 16:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 070A53AB6AF
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 14:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572E8279901;
	Wed, 23 Apr 2025 14:33:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC80149E17;
	Wed, 23 Apr 2025 14:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745418796; cv=none; b=mNheshvAlWdKncDN0yUdeRX536CIEbmLuhfdUOmo/qFQrJ92EjbPrSTCkjacKuckqC5+oCEH8w9LfT/xBRkqNl060VDVcgCS/Nu006vhk4XEii/T7ZCZvjz3iupGaFFpvQOfK02xFZVj9i29/3tX2EwtWH5jaf8gcYtYwi/VSjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745418796; c=relaxed/simple;
	bh=fu6098lFZ/qu32M1cciGKiqo7TuTW0yAqRpasxv511k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GHToQFqnZ74s1fdWj3PyZCPiyHCGqUK3RYsVfON24c3b7bI8cpWojsy/V3qT2v7tA+QUD166tuNrw8KpMOhYel5s/mD1LqX/xdiw/BJFifuq0DlRIGAvK1JnjRJPY1fa5ESwsuJArMuMXwScUGEtnmsJ43PeI5mgaHSdud9Gpr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZjM182jtvz6M4kt;
	Wed, 23 Apr 2025 22:29:00 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D990B14020B;
	Wed, 23 Apr 2025 22:33:09 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 23 Apr
 2025 16:33:09 +0200
Date: Wed, 23 Apr 2025 15:33:07 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v8 03/16] CXL/AER: Introduce Kfifo for forwarding CXL
 errors
Message-ID: <20250423153307.000074a7@huawei.com>
In-Reply-To: <20250327014717.2988633-4-terry.bowman@amd.com>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
	<20250327014717.2988633-4-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)


> +int cxl_create_prot_err_info(struct pci_dev *_pdev, int severity,
> +			     struct cxl_prot_error_info *err_info)
> +{
> +	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(_pdev);
> +	struct cxl_dev_state *cxlds;
> +
> +	if (!pdev || !err_info) {
> +		pr_warn_once("Error: parameter is NULL");
> +		return -ENODEV;
> +	}
> +
> +	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END)) {
> +		pci_warn_once(pdev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
> +		return -ENODEV;
> +	}
> +
> +	cxlds = pci_get_drvdata(pdev);
> +	struct device *dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
> +
> +	if (!dev)
> +		return -ENODEV;
> +
> +	*err_info = (struct cxl_prot_error_info){ 0 };
> +	err_info->ras_base = cxlds->regs.ras;
> +	err_info->severity = severity;
> +	err_info->pdev = pdev;
> +	err_info->dev = dev;

I missed this before but might as well do...

	*err_info = (struct cxl_prot_error_info) {
		.ras_base = cxlds->regs.ras,
		.severity = serverity,
	...
	};

> +
> +	return 0;
> +}

