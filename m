Return-Path: <linux-pci+bounces-7775-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C56F38CD0CE
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 13:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0165A1C20CB0
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 11:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4075B80628;
	Thu, 23 May 2024 11:02:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D546C3BB21;
	Thu, 23 May 2024 11:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716462161; cv=none; b=oMhwCP43UC3FbzdjdmPZr1YQ6uLyJcXMZOuHWL3Jv8V++IZ2jGHiCpthVzVAMD2bvcIB8HDx4x/zZxrl+KmrIAXx1+jzoRXRQNFm6tYeAbUW+1x0TI8mEhIVLX4MW2FBxfjr6kGJTB0+VIY51tJ3cG97MdmKQr3vGn2JNHBePlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716462161; c=relaxed/simple;
	bh=Y++RLciD3ipTi4wP81sYlEWtvFzfWcwijReeMZc3xZ8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IRtxJFm8kbmPiLFWgB4bB4zYEAEzNLOMBRmwwqQkBo+xGq+GWooCb9elNNl2ZqhyoG1FZJHAEIZRQHWWHBdSuWcbwZ/7Hxj/u73IXvBWOPV15bj/2P0av57uOTyJWonYPwejoTSX32pZ/LGox3S2si+TxHSOl5GkjxroVhJwAvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VlQGW4561z6K9NH;
	Thu, 23 May 2024 19:01:39 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D118F140B2A;
	Thu, 23 May 2024 19:02:30 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 23 May
 2024 12:02:29 +0100
Date: Thu, 23 May 2024 12:02:26 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alistair Francis <alistair23@gmail.com>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, <lukas@wunner.de>,
	<alex.williamson@redhat.com>, <christian.koenig@amd.com>, <kch@nvidia.com>,
	<gregkh@linuxfoundation.org>, <logang@deltatee.com>,
	<linux-kernel@vger.kernel.org>, <chaitanyak@nvidia.com>,
	<rdunlap@infradead.org>, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v10 2/4] PCI/DOE: Rename Discovery Response Data Object
 Contents to type
Message-ID: <20240523120226.0000781b@Huawei.com>
In-Reply-To: <20240522101142.559733-2-alistair.francis@wdc.com>
References: <20240522101142.559733-1-alistair.francis@wdc.com>
	<20240522101142.559733-2-alistair.francis@wdc.com>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 22 May 2024 20:11:40 +1000
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

Other than the below query on it being a potentially breaking change
for userspace code this looks fine to me.

> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 94c00996e633..4fa1ec622177 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1146,7 +1146,7 @@
>  #define PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX		0x000000ff
>  #define PCI_DOE_DATA_OBJECT_DISC_REQ_3_VER		0x0000ff00
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID		0x0000ffff
> -#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
> +#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE		0x00ff0000

Safe to change a userspace header?  I've no idea if any external project
is using this define but probably shouldn't make this change or should
leave a compatibility define in place.

>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
>  
>  /* Compute Express Link (CXL r3.1, sec 8.1.5) */


