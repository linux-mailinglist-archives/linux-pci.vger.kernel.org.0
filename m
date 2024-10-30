Return-Path: <linux-pci+bounces-15627-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CAD9B677D
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 16:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99BFF281ED1
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 15:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1F32194A4;
	Wed, 30 Oct 2024 15:14:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDBF218D7D;
	Wed, 30 Oct 2024 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730301254; cv=none; b=EoqMEOPYC1+wLJXbVIFQySkgEtMeEPnPSs+i3M9RP9q21wIAg1mVgmCOZgch0Flhz2qYO0Gq5Tbo26MBj1phdwu48nxRKcG9iMMQ77J/UzEsjPHEPIhezllaEadpfgXEbtV9tWn4f1XyksDrfjrOyE5SCVnAjBVITvsLIpIAK+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730301254; c=relaxed/simple;
	bh=ZmQNu2d+N/0t2jHPTpFE9ynfUCN3+h8ww7kE4zJqUI4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kl/5XEmYpR3htPDxguKtZUVB/SPC/HHSTdk7BLazldmjqMvRlkTX64hlYycPojsrvtUI3EdM9rJGgmxiFbsW33euX1d5Otdo/8qLb3A7gsr3qmO8FYRohBKcCA/AxY2HVQ6PZlI0VG48zqLVx6rYAkmD9gYL0pk3sP3Z8c2F+vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XdrBQ3P7wz6GDpd;
	Wed, 30 Oct 2024 23:09:18 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A7B9F140593;
	Wed, 30 Oct 2024 23:14:09 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Oct
 2024 16:14:08 +0100
Date: Wed, 30 Oct 2024 15:14:07 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v2 01/14] PCI/AER: Introduce 'struct cxl_err_handlers'
 and add to 'struct pci_driver'
Message-ID: <20241030151407.0000227c@Huawei.com>
In-Reply-To: <20241025210305.27499-2-terry.bowman@amd.com>
References: <20241025210305.27499-1-terry.bowman@amd.com>
	<20241025210305.27499-2-terry.bowman@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
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

On Fri, 25 Oct 2024 16:02:52 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> CXL.io provides PCIe like protocol error implementation, but CXL.io and
> PCIe have different handling requirements.
> 
> The PCIe AER service driver may attempt recovering PCIe devices with
> uncorrectable errors while recovery is not used for CXL.io. Recovery is not
> used in the CXL.io recovery because of the potential for corruption on
> what can be system memory.
> 
> Create pci_driver::cxl_err_handlers similar to pci_driver::error_handler.
> Create handlers for correctable and uncorrectable CXL.io error
> handling.
> 
> The CXL error handlers will be used in future patches adding CXL PCIe
> port protocol error handling.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

