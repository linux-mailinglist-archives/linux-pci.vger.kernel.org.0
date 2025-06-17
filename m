Return-Path: <linux-pci+bounces-29931-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88997ADCFF8
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 16:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B4A3A8953
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 14:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D3D2EF65D;
	Tue, 17 Jun 2025 14:26:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998EA2EF64C
	for <linux-pci@vger.kernel.org>; Tue, 17 Jun 2025 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750170415; cv=none; b=gkdwT4Xi8dzzZq1BS+P8N2ZlolrlICQGhSjwVfmJGbSl/OimtLh/DcrZFtSPW4dElnMtEGkkGFEhhH1FhgtOkXOCzcmHJ84uuBUm/6MnebtyQ2nAERgRxdYykp9fWGUoKRCFyauZcXTDjBdIOCID/D1JiXyowyBgrWi8vsCe8JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750170415; c=relaxed/simple;
	bh=gobYUNUFllNI01KDeRELpX66jEUTdqau1xfZDAOL8k0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=geh7xhAl3SZCrX2d6eKaRnhpKggqxl8wtobsvoIHpYV4Nt1kCkmls6C1yWjqmlfyF7Sx/ieYLn3ktBBUyrv3Qe05KomZEBUSfwypyAx53SEsscVTPTgEdeJUEftlCMjl9fJN1Dw0TM+QVK4lIY7SFAp7AbJWq3rW/J2U+tzzjm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bM8Jn247Dz6L5RW;
	Tue, 17 Jun 2025 22:24:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F38A1402FE;
	Tue, 17 Jun 2025 22:26:51 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 17 Jun
 2025 16:26:50 +0200
Date: Tue, 17 Jun 2025 15:26:48 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <lukas@wunner.de>, <aneesh.kumar@kernel.org>,
	<suzuki.poulose@arm.com>, <sameo@rivosinc.com>, <aik@amd.com>,
	<jgg@nvidia.com>, <zhiw@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, Xu
 Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v3 11/13] samples/devsec: Add sample IDE establishment
Message-ID: <20250617152648.00006e28@huawei.com>
In-Reply-To: <20250516054732.2055093-12-dan.j.williams@intel.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
	<20250516054732.2055093-12-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 15 May 2025 22:47:30 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Exercise common setup and teardown flows for a sample platform TSM
> driver that implements the TSM 'connect' and 'disconnect' flows.
> 
> This is both a template for platform specific implementations and a
> simple integration test for the PCI core infrastructure + ABI.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Trivial comment inline.

> index 7a8d33dc54c6..aa852ac1c16d 100644
> --- a/samples/devsec/tsm.c
> +++ b/samples/devsec/tsm.c

>  /*
>   * Reference consumer for a TSM driver "connect" operation callback. The
>   * low-level TSM driver understands details about the platform the PCI
> @@ -74,11 +79,81 @@ static void devsec_tsm_pci_remove(struct pci_tsm *tsm)
>   */
>  static int devsec_tsm_connect(struct pci_dev *pdev)
>  {
> -	return -ENXIO;
> +	struct pci_dev *rp = pcie_find_root_port(pdev);
> +	struct pci_ide *ide;
> +	int rc, stream_id;
> +
> +	stream_id =
> +		find_first_zero_bit(devsec_stream_ids, NR_TSM_STREAMS);

Ugly and it's under 80 chars on one line.


> +	if (stream_id == NR_TSM_STREAMS)
> +		return -EBUSY;

>  
>  static void devsec_tsm_disconnect(struct pci_dev *pdev)
>  {
> +	struct pci_dev *rp = pcie_find_root_port(pdev);
> +	struct pci_ide *ide;
> +	int i;
> +
> +	for_each_set_bit(i, devsec_stream_ids, NR_TSM_STREAMS)
> +		if (devsec_streams[i]->pdev == pdev)
> +			break;
> +
> +	if (i >= NR_TSM_STREAMS)
== NR_TSM_STREAMS 
not that it really matters but it can never be greater.

> +		return;
> +
> +	ide = devsec_streams[i];
> +	devsec_streams[i] = NULL;
> +	pci_ide_stream_disable(pdev, ide);
> +	tsm_ide_stream_unregister(ide);
> +	pci_ide_stream_teardown(rp, ide);
> +	pci_ide_stream_teardown(pdev, ide);
> +	pci_ide_stream_unregister(ide);
> +	pci_ide_stream_free(ide);
> +	clear_bit(i, devsec_stream_ids);
>  }
>  
>  static const struct pci_tsm_ops devsec_pci_ops = {


