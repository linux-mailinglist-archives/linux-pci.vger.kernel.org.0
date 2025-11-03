Return-Path: <linux-pci+bounces-40106-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F021C2CAC2
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 16:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12CFB189B682
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 15:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE8730BF63;
	Mon,  3 Nov 2025 15:05:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E93D26F293
	for <linux-pci@vger.kernel.org>; Mon,  3 Nov 2025 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182307; cv=none; b=CDDylsyyDH8mQOncfZR3d+2jtbUOxklrtNMTmjcwJ0RO9YlGh6BAmm2Uq27ACYC4tklcV0TE9N7WoWnVCymRODqsvkocbuvAnMG3Vk5YuLgx/w2N3aY+8xeTv3s7WeJ3KsaKBj+gwQkC4dcUbi0ZYpsSkccqQNjDor2dscJn/9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182307; c=relaxed/simple;
	bh=QVAeBxh9G89DrR0x4+NBAoICK6ck3Dwq4ewfdkFSs9c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jhipY2VRx229L9QVz3NbCA6obUWwlDHQ1S1zLKvWkGsTf7+ElLgxIFJUsIjfieb417J+FqZsYToH2Du40vnlawtrv/hjpERQ+5qRwBoE2MQHkJsncY+jtfWj512h5cRzO8i+ATBJlbNhab9H28KUjo3uh1u+c7csu3EUR8WqDvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d0Zd80yZHzHnGjM;
	Mon,  3 Nov 2025 23:05:00 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id B74011402FB;
	Mon,  3 Nov 2025 23:05:01 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 3 Nov
 2025 15:05:01 +0000
Date: Mon, 3 Nov 2025 15:04:59 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-pci@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<gregkh@linuxfoundation.org>, <aik@amd.com>, <aneesh.kumar@kernel.org>,
	<yilun.xu@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>
Subject: Re: [PATCH v8 7/9] PCI/IDE: Add IDE establishment helpers
Message-ID: <20251103150459.00007104@huawei.com>
In-Reply-To: <20251031212902.2256310-8-dan.j.williams@intel.com>
References: <20251031212902.2256310-1-dan.j.williams@intel.com>
	<20251031212902.2256310-8-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 31 Oct 2025 14:28:59 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> There are two components to establishing an encrypted link, provisioning
> the stream in Partner Port config-space, and programming the keys into
> the link layer via IDE_KM (IDE Key Management). This new library,
> drivers/pci/ide.c, enables the former. IDE_KM, via a TSM low-level
> driver, is saved for later.
> 
> With the platform TSM implementations of SEV-TIO and TDX Connect in mind
> this library abstracts small differences in those implementations. For
> example, TDX Connect handles Root Port register setup while SEV-TIO
> expects System Software to update the Root Port registers. This is the
> rationale for fine-grained 'setup' + 'enable' verbs.
> 
> The other design detail for TSM-coordinated IDE establishment is that
> the TSM may manage allocation of Stream IDs, this is why the Stream ID
> value is passed in to pci_ide_stream_setup().
> 
> The flow is:
> 
> pci_ide_stream_alloc():
>     Allocate a Selective IDE Stream Register Block in each Partner Port
>     (Endpoint + Root Port), and reserve a host bridge / platform stream
>     slot. Gather Partner Port specific stream settings like Requester ID.
> 
> pci_ide_stream_register():
>     Publish the stream in sysfs after allocating a Stream ID. In the TSM
>     case the TSM allocates the Stream ID for the Partner Port pair.
> 
> pci_ide_stream_setup():
>     Program the stream settings to a Partner Port. Caller is responsible
>     for optionally calling this for the Root Port as well if the TSM
>     implementation requires it.
> 
> pci_ide_stream_enable():
>     Enable the stream after IDE_KM.
> 
> In support of system administrators auditing where platform, Root Port,
> and Endpoint IDE stream resources are being spent, the allocated stream
> is reflected as a symlink from the host bridge to the endpoint with the
> name:
> 
>     stream%d.%d.%d
> 
> Where the tuple of integers reflects the allocated platform, Root Port,
> and Endpoint stream index (Selective IDE Stream Register Block) values.
> 
> Thanks to Wu Hao for a draft implementation of this infrastructure.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

