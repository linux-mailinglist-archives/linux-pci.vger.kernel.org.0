Return-Path: <linux-pci+bounces-1933-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A852828986
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 16:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30DDC1C2458A
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 15:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7FA39FE8;
	Tue,  9 Jan 2024 15:58:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C0539FE5;
	Tue,  9 Jan 2024 15:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T8b9k1QFhz6K996;
	Tue,  9 Jan 2024 23:55:22 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C4D2F140135;
	Tue,  9 Jan 2024 23:57:56 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 9 Jan
 2024 15:57:56 +0000
Date: Tue, 9 Jan 2024 15:57:55 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: KobayashiDaisuke <kobayashi.da-06@fujitsu.com>
CC: <linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<y-goto@fujitsu.com>
Subject: Re: [RFC PATCH 0/3] lspci: Display cxl1.1 device link status
Message-ID: <20240109155755.0000087b@Huawei.com>
In-Reply-To: <20231220050738.178481-1-kobayashi.da-06@fujitsu.com>
References: <20231220050738.178481-1-kobayashi.da-06@fujitsu.com>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 20 Dec 2023 14:07:35 +0900
KobayashiDaisuke <kobayashi.da-06@fujitsu.com> wrote:

> Hello.
> 
> This patch series adds a feature to lspci that displays the link status
> of the CXL1.1 device.
> 
> CXL devices are extensions of PCIe. Therefore, from CXL2.0 onwards,
> the link status can be output in the same way as traditional PCIe.
> However, unlike devices from CXL2.0 onwards, CXL1.1 requires a
> different method to obtain the link status from traditional PCIe.
> This is because the link status of the CXL1.1 device is not mapped
> in the configuration space (as per cxl3.0 specification 8.1).
> Instead, the configuration space containing the link status is mapped
> to the memory mapped register region (as per cxl3.0 specification 8.2,
> Table 8-18). Therefore, the current lspci has a problem where it does
> not display the link status of the CXL1.1 device. 
> This patch solves these issues.
> 
> The method of acquisition is in the order of obtaining the device UID,
> obtaining the base address from CEDT, and then obtaining the link
> status from memory mapped register. Considered outputting with the cxl
> command due to the scope of the CXL specification, but devices from
> CXL2.0 onwards can be output in the same way as traditional PCIe.
> Therefore, it would be better to make the lspci command compatible with
> the CXL1.1 device for compatibility reasons.
> 
> I look forward to any comments you may have.
Yikes. 

My gut feeling is that you shouldn't need to do this level of hackery.

If we need this information to be exposed to tooling then we should
add support to the kernel to export it somewhere in sysfs and read that
directly.  Do we need it to be available in absence of the CXL driver
stack? 

Jonathan
> 
> KobayashiDaisuke (3):
>   Add function to display cxl1.1 device link status
>   Implement a function to get cxl1.1 device uid
>   Implement a function to get a RCRB Base address
> 
>  ls-caps.c | 216 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  lspci.h   |  35 +++++++++
>  2 files changed, 251 insertions(+)
> 


