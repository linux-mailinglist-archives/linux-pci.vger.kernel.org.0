Return-Path: <linux-pci+bounces-8404-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 186EA8FF070
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 17:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F661F24DA4
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 15:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959271991DF;
	Thu,  6 Jun 2024 15:12:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CDA1991BF;
	Thu,  6 Jun 2024 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717686720; cv=none; b=p/CfxL8XEoWyNBATZ2y0n26oLdvACcSf1uaVqh14JLMAExQx1nlZDegf+ulwQKBTmEL7sZt6zqnI/73cP0M5gul0jew9DtjAeNBnzJTxsILpe2FjunaFjkGc+tW+/AwzDZ1lUoG09dICSvOq4oj9lVJxUwVgWsu88kCn3zmcelk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717686720; c=relaxed/simple;
	bh=FL7dzVJTWju/vujUHStPMmmvgFpIKHy88JtBSJ8gQe0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dz9YxvWOH84uBIdw5VHNqevAz43OkK7DGLcdyqF13F+9L6zgYWBSHWac6cMqOjh26YQLYukLFORSoT4xVPWNNzqoO7nyr+DzwT27RX+ywJf6smAZrSZZYV01RKZ/ANEpjXtMPN3vnCeSldupF+/cnfjWluI38U4nid3hAgfq1UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vw73S6W3Xz6K5sn;
	Thu,  6 Jun 2024 23:07:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 6F1991402C7;
	Thu,  6 Jun 2024 23:11:56 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 6 Jun
 2024 16:11:55 +0100
Date: Thu, 6 Jun 2024 16:11:54 +0100
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
Subject: Re: [PATCH v4 3/3] PCI/AER: Clear UNCOR_STATUS bits that might be
 ANFE
Message-ID: <20240606161154.00002605@Huawei.com>
In-Reply-To: <20240509084833.2147767-4-zhenzhong.duan@intel.com>
References: <20240509084833.2147767-1-zhenzhong.duan@intel.com>
	<20240509084833.2147767-4-zhenzhong.duan@intel.com>
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

On Thu,  9 May 2024 16:48:33 +0800
Zhenzhong Duan <zhenzhong.duan@intel.com> wrote:

> When processing an ANFE, ideally both correctable error(CE) status and
> uncorrectable error(UE) status should be cleared. However, there is no
> way to fully identify the UE associated with ANFE. Even worse, Non-Fatal
> Error(NFE) may set the same UE status bit as ANFE. Treating an ANFE as
> NFE will bring some issues, i.e., breaking softwore probing; treating
> NFE as ANFE will make us ignoring some UEs which need active recover
> operation. To avoid clearing UEs that are not ANFE by accident, the
> most conservative route is taken here: If any of the NFE Detected bits
> is set in Device Status, do not touch UE status, they should be cleared
> later by the UE handler. Otherwise, a specific set of UEs that may be
> raised as ANFE according to the PCIe specification will be cleared if
> their corresponding severity is Non-Fatal.
> 
> For instance, previously when kernel receives an ANFE with Poisoned TLP
> in OS native AER mode, only status of CE will be reported and cleared:
> 
>   AER: Correctable error message received from 0000:b7:02.0
>   PCIe Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
>     device [8086:0db0] error status/mask=00002000/00000000
>      [13] NonFatalErr
> 
> If the kernel receives a Malformed TLP after that, two UEs will be
> reported, which is unexpected. Malformed TLP Header is lost since
> the previous ANFE gated the TLP header logs:
> 
>   PCIe Bus Error: severity="Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
>     device [8086:0db0] error status/mask=00041000/00180020
>      [12] TLP                    (First)
>      [18] MalfTLP
> 
> Now, for the same scenario, both CE status and related UE status will be
> reported and cleared after ANFE:
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

This is nasty enough though that it would benefit from more review
if possible.  

Thanks for all the detailed explanations in the patch descriptions,
that made it less painful than it might have been.

Jonathan



