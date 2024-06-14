Return-Path: <linux-pci+bounces-8791-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6C79086B2
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 10:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73BD21F2200E
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 08:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F4419147C;
	Fri, 14 Jun 2024 08:47:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C062E19146E;
	Fri, 14 Jun 2024 08:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718354869; cv=none; b=sIFgnPOySaFm1rWhntuzoVXnQNrFRJdCqa4yeTxX9h4S79zzcsRjbiMCh02FsCCbKeMc6zWS9ZFubEfGUIlpKZwcfnn11zCXrlTtgD2O26m2Wv7gnH7V6prKFjeUe5Kp4XcV1bbY73WxFBcPTiUkoX1wNz1TdMgain8HOX+/a/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718354869; c=relaxed/simple;
	bh=45f3NbSIjn/AbSbJ9u8PJRS3iAtOubXIiVFHoomkPuk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pSZekUt5+xsWN4hlLAQQfogowJfMiBjuc5KdB5IgiE3gFQnOm4TxHzwMWmAqg6vWoVHmoUyvvRLTeeVi5gnUagtCxrq4Ue7a9ITYI2FfEgQdlePnpQ2QseNL+cwXmSBCqdM5MogId9pPGYnQuDIuUPfyfJn+19deAfHjxfbw1ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W0tFl74xPz67G9n;
	Fri, 14 Jun 2024 16:47:39 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 04755140B54;
	Fri, 14 Jun 2024 16:47:44 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Jun
 2024 09:47:43 +0100
Date: Fri, 14 Jun 2024 09:47:42 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alistair Francis <alistair23@gmail.com>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, <lukas@wunner.de>,
	<alex.williamson@redhat.com>, <christian.koenig@amd.com>, <kch@nvidia.com>,
	<gregkh@linuxfoundation.org>, <logang@deltatee.com>,
	<linux-kernel@vger.kernel.org>, <chaitanyak@nvidia.com>,
	<rdunlap@infradead.org>, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v11 2/4] PCI/DOE: Rename Discovery Response Data Object
 Contents to type
Message-ID: <20240614094742.00000189@Huawei.com>
In-Reply-To: <20240614001244.925401-2-alistair.francis@wdc.com>
References: <20240614001244.925401-1-alistair.francis@wdc.com>
	<20240614001244.925401-2-alistair.francis@wdc.com>
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
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 14 Jun 2024 10:12:42 +1000
Alistair Francis <alistair23@gmail.com> wrote:

> PCIe r6.1 (which was published July 24) describes a "Vendor ID", a
> "Data Object Type" and "Next Index" as the fields in the DOE
> Discovery Response Data Object. The DOE driver currently uses
> both the terms type and prot for the second element.
> 
> This patch renames all uses of the DOE Discovery Response Data Object
> to use type as the second element of the object header, instead of
> type/prot as it currently is.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Completely trivial suggestion below

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 94c00996e633..ca692a3e1e5e 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1146,9 +1146,12 @@
>  #define PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX		0x000000ff
>  #define PCI_DOE_DATA_OBJECT_DISC_REQ_3_VER		0x0000ff00
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID		0x0000ffff
> -#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
> +#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE		0x00ff0000
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
>  
> +/* Deprecated old name, replaced with PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE */
> +#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000

I don't care that much, but could make one define just use the other
so the code makes it explicit that this is just a rename.

> +
>  /* Compute Express Link (CXL r3.1, sec 8.1.5) */
>  #define PCI_DVSEC_CXL_PORT				3
>  #define PCI_DVSEC_CXL_PORT_CTL				0x0c


