Return-Path: <linux-pci+bounces-33127-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89610B150D6
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 18:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD3B18A0381
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 16:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E024D199934;
	Tue, 29 Jul 2025 16:07:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020E7293469;
	Tue, 29 Jul 2025 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753805223; cv=none; b=gbFhKYRaHHrPHWVGSo2x2AFi+ieNi0Y5ZRPPcNi694LjzTRqI0uwklArzVJdTE5wgcTI+/9TEfymTSNcv6kc9+FZN9jryy8zNqhlLFLbA0yO0GR0i+NLNMVwSlZIy8XDhGq0/BfweE+Yaj83whr03sfSNtj3GzFHGqBz65kvTP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753805223; c=relaxed/simple;
	bh=NPEcovrwDo43N0AHF4g6DbPS5QsdPMou8/qukFuHUdE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zn/bmSVVM/mSc+mWWIISyWu3jhZzESwxcgaC+hzy1ZKcBOMkYHW3KgjL1rMZf/r1K2xnajnJc6QNVYJjiH/9CVi/8fZ1QQs1CpV328s+1XrJ0N9Af00YZInkszlp4D6WCRXXqCvciGI4D8qiuBtka+F2q02V1wCyFraFmHzUM+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bs0Yd20w7z6H8fN;
	Wed, 30 Jul 2025 00:05:25 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0130F1402F4;
	Wed, 30 Jul 2025 00:07:00 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 29 Jul
 2025 18:06:59 +0200
Date: Tue, 29 Jul 2025 17:06:57 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Aneesh
 Kumar K.V <aneesh.kumar@kernel.org>
Subject: Re: [PATCH v4 10/10] samples/devsec: Add sample IDE establishment
Message-ID: <20250729170657.00005638@huawei.com>
In-Reply-To: <20250717183358.1332417-11-dan.j.williams@intel.com>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
	<20250717183358.1332417-11-dan.j.williams@intel.com>
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

On Thu, 17 Jul 2025 11:33:58 -0700
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
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
One really trivial comment inline.

> diff --git a/samples/devsec/tsm.c b/samples/devsec/tsm.c
> index a4705212a7e4..b93396ca0c92 100644
> --- a/samples/devsec/tsm.c
> +++ b/samples/devsec/tsm.c


>  
>  static void devsec_tsm_disconnect(struct pci_dev *pdev)
>  {
> +	struct pci_ide *ide;
> +	unsigned long i;
> +
> +	for_each_set_bit(i, devsec_stream_ids, NR_TSM_STREAMS)
> +		if (devsec_streams[i]->pdev == pdev)
> +			break;
> +
> +	if (i >= NR_TSM_STREAMS)

pet irritation - why imply cases that can't occur.

	if (i == NR_TSM_STREAMS)

> +		return;
> +
> +	ide = devsec_streams[i];
> +	devsec_streams[i] = NULL;
> +	pci_ide_stream_release(ide);
> +	clear_bit(i, devsec_stream_ids);
>  }
>  
>  static struct pci_tsm_ops devsec_pci_ops = {


