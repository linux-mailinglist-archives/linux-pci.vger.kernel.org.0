Return-Path: <linux-pci+bounces-41838-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AB19CC76F74
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 03:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 805974E2E8C
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 02:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7325421D3F0;
	Fri, 21 Nov 2025 02:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="u40LWVUi"
X-Original-To: linux-pci@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0300E1D90DF;
	Fri, 21 Nov 2025 02:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763691139; cv=none; b=OGDvUUqrgu6BcNmqW8r8MJdJx2VgagDK1udCZm+cdBcBKpwHu6YyUybtUUHFz+vnZWuXY1dH22CMWg2LKm/8T8QUI57IDvtmDFRbpZMKBjXJ7VCYPG7IkSep+p+lAuxBiDzi/vu69nLq5xxP07IYhuRDNAtDwojdIa4nZPX/HlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763691139; c=relaxed/simple;
	bh=28zSO7faFMnLP1FNYaX8OsVzFnZungykRRcFeBRL80M=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=sVC6AitL88XwnG14+8XAmYe382H3eR6gWq8etJVlqD/NhviE9chkDcBPCNvAPNg36wTQyorSQm7l5m6kLEWf8PYGh6vOuJvSNeZsT1/wDy6RpCPgEKKrnLEdUExdAwk4F4RXPsBp6cQppcmBFFOxnkk0wCUZMr8PINx2l0FIHS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=u40LWVUi; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=AQS3TZ1si/Ig2wkymXClxgNNI6FTrzeWsHMvwkBCMDg=;
	b=u40LWVUiaHDsbCA01CQYv9znHEwW+kbk7n9CJMnawfy/JqQjuFN1zeEfE52OVPOa1JJU3VvGc
	Af+Zmtn2UuTu37GoOwE5H7E42FZK4NDiMyUtsrwLKtr/EaNCO2dnV7B16f6EPBKaPAC+txl34X2
	rkqy9fpgxCj50OJgmLhLopc=
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dCJbV65TDznTWW;
	Fri, 21 Nov 2025 10:10:46 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C164140119;
	Fri, 21 Nov 2025 10:12:13 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 21 Nov 2025 10:12:11 +0800
Subject: Re: [PATCH 3/6 v7] acpi/ghes: Make GHES select ACPI_APEI_PCIEAER
To: Jonathan Cameron <jonathan.cameron@huawei.com>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>
CC: <linux-cxl@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Borislav Petkov
	<bp@alien8.de>, Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai Xue
	<xueshuai@linux.alibaba.com>, Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, Mahesh J Salgaonkar
	<mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-pci@vger.kernel.org>
References: <20251104182446.863422-1-fabio.m.de.francesco@linux.intel.com>
 <20251104182446.863422-4-fabio.m.de.francesco@linux.intel.com>
 <20251111154220.00004767@huawei.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <19155ced-8702-71f9-6eba-4dbfdc7c88ad@huawei.com>
Date: Fri, 21 Nov 2025 10:12:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251111154220.00004767@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/11/11 23:42, Jonathan Cameron wrote:
> On Tue,  4 Nov 2025 19:22:34 +0100
> "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com> wrote:
> 
>> GHES handles the PCI Express Error Section and also the Compute Express
>> Link (CXL) Protocol Error Section. Two of its functions depend on the
>> APEI PCIe AER logging/recovering support (ACPI_APEI_PCIEAER).
>>
>> Make GHES select ACPI_APEI_PCIEAER and remove the conditional
>> compilation from the body of two static functions that handle the CPER
>> Error Sections mentioned above.
> 
> Hi Fabio,
> 
> I'm not seeing a justification here for the change and there may be
> APEI platforms without PCI support.  So is this just to simplify things or
> is there a functional reason that it is necessary?

I have the same worry, embedded system with ACPI support may don't have
PCI. And for APEI, AER is one of the error type and optional.

Thanks
Hanjun

