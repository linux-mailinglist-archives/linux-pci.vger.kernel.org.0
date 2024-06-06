Return-Path: <linux-pci+bounces-8403-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 518D08FF09E
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 17:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3473BB3162C
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 15:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403A319E7C7;
	Thu,  6 Jun 2024 15:07:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FE8195998;
	Thu,  6 Jun 2024 15:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717686455; cv=none; b=oXiD/VONpARzno6Txs59lu0jbjniTAMhhk6Sel/zeN8O1CBB8r6f1hw9nZVrAzcS6CUggpEQU1NEUei72quJaUvPV9U1HouAWR2M2zcGMncIp7YFaHRgi38hz2KBzmbiYNhq9mu0EbEmChdZImom/7LTi7IVQLbNR47G8K0rRZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717686455; c=relaxed/simple;
	bh=LD+ZIHVdpN0UkwnyUN7mX7hW2dTrOXB2jexOGkTsgas=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=clE1sMRNRqBe9xDOF+9wJMShTVcALd2uKX2gG1IKprKVOyGab/wJe+WVuVIPzkMWvDNX7OODBJoeZONFpYegV8DVWlQEOrc8g+W5zjD5zJO8i3r/IGkACg5yp+aDIMKt5/y+0zkL2zQLPheaFMsBPdWu49pkUFsRAfOTnW50NXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vw72J3cP4z67l0C;
	Thu,  6 Jun 2024 23:06:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 17898140B67;
	Thu,  6 Jun 2024 23:07:29 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 6 Jun
 2024 16:07:28 +0100
Date: Thu, 6 Jun 2024 16:07:27 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
CC: <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-acpi@vger.kernel.org>, <rafael@kernel.org>, <lenb@kernel.org>,
	<james.morse@arm.com>, <tony.luck@intel.com>, <bp@alien8.de>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <bhelgaas@google.com>,
	<helgaas@kernel.org>, <mahesh@linux.ibm.com>, <oohall@gmail.com>,
	<linmiaohe@huawei.com>, <shiju.jose@huawei.com>, <adam.c.preble@intel.com>,
	<lukas@wunner.de>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<erwin.tsaur@intel.com>, <sathyanarayanan.kuppuswamy@intel.com>,
	<dan.j.williams@intel.com>, <feiting.wanyan@intel.com>,
	<yudong.wang@intel.com>, <chao.p.peng@intel.com>,
	<qingshun.wang@linux.intel.com>
Subject: Re: [PATCH v4 2/3] PCI/AER: Print UNCOR_STATUS bits that might be
 ANFE
Message-ID: <20240606160727.000044a6@Huawei.com>
In-Reply-To: <20240509084833.2147767-3-zhenzhong.duan@intel.com>
References: <20240509084833.2147767-1-zhenzhong.duan@intel.com>
	<20240509084833.2147767-3-zhenzhong.duan@intel.com>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu,  9 May 2024 16:48:32 +0800
Zhenzhong Duan <zhenzhong.duan@intel.com> wrote:

> When an Advisory Non-Fatal error(ANFE) triggers, both correctable error(CE)
> status and ANFE related uncorrectable error(UE) status will be printed:
> 
>   AER: Correctable error message received from 0000:b7:02.0
>   PCIe Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
>     device [8086:0db0] error status/mask=00002000/00000000
>      [13] NonFatalErr
>     Uncorrectable errors that may cause Advisory Non-Fatal:
>      [18] TLP
> 
> Tested-by: Yudong Wang <yudong.wang@intel.com>
> Co-developed-by: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
> Signed-off-by: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

