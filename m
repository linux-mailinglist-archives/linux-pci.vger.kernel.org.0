Return-Path: <linux-pci+bounces-41088-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E97EBC5756A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 13:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A87DD4E41F7
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 12:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7969434B69C;
	Thu, 13 Nov 2025 12:10:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8788834D38A
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763035846; cv=none; b=SWhcUtEo7nQAUG+cI+cKZ7075VR+N8hBlqumAwFGtZyDBzcwX9exOv8k8/bJAzR54T7dmA1arhhmUkASvB0byWXE6Rr7t6zk3Assyp8wX6OE2Ypd5l0CJzQMNSfjIHjoFvzbKVgMh8YVZ9oaGItevG8wunX4OFYy+//qqtU9yu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763035846; c=relaxed/simple;
	bh=lakeWmHgrc2U9tY8RiNTC8pnxxL49rH34SFqxnVfQrQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mKEvV7ydpEu6n9oJbGrW45uDVxdGN0tD3mNJVP3FFjtZ3l+aOGmDF3AYqa2XM3D88vRNSkJXWGKMILsJeZm9QC/0GEtdd4XTN6pbWFo11vhdEhtgwdgrP9Qiarw4qS2faaoWqQYHFyU0cx5DXPvlB5fzmMw6p3QpUL6s6vYBIEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d6fH10JTdzHnGjs;
	Thu, 13 Nov 2025 20:10:21 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 05EAD1401DC;
	Thu, 13 Nov 2025 20:10:42 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 13 Nov
 2025 12:10:41 +0000
Date: Thu, 13 Nov 2025 12:10:39 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-pci@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<bhelgaas@google.com>, <aneesh.kumar@kernel.org>, <yilun.xu@linux.intel.com>,
	<aik@amd.com>, Lukas Wunner <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH 6/6] PCI/TSM: Add 'dsm' and 'bound' attributes for
 dependent functions
Message-ID: <20251113121039.000039ab@huawei.com>
In-Reply-To: <20251105040055.2832866-7-dan.j.williams@intel.com>
References: <20251105040055.2832866-1-dan.j.williams@intel.com>
	<20251105040055.2832866-7-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue,  4 Nov 2025 20:00:55 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> PCI/TSM sysfs for physical function 0 devices, i.e. the "DSM" (Device
> Security Manager), contains the 'connect' and 'disconnect' attributes.
> After a successful 'connect' operation the DSM, its dependent functions
> (SR-IOV virtual functions, non-zero multi-functions, or downstream
> endpoints of a switch DSM) are candidates for being transitioned into a
> TDISP (TEE Device Interface Security Protocol) operational state, via
> pci_tsm_bind(). At present sysfs is blind to which devices are capable of
> TDISP operation and it is ambiguous which functions are serviced by which
> DSMs.
> 
> Add a 'dsm' attribute to identify a function's DSM device, and add a
> 'bound' attribute to identify when a function has entered a TDISP
> operational state.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Xu Yilun <yilun.xu@linux.intel.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Repeat of tag from v1. It was only patch I tagged in that version
so no problem that you missed it, or forgot to say why you dropped
it intentionally.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>



