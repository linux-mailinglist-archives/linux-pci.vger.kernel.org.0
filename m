Return-Path: <linux-pci+bounces-40378-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F72C373A2
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 18:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0AFF3B433A
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 17:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3565233BBD5;
	Wed,  5 Nov 2025 17:54:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30023358AA
	for <linux-pci@vger.kernel.org>; Wed,  5 Nov 2025 17:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762365245; cv=none; b=RG1fQIo+dDrluprYl0PnoRF+AABjfOB4XUU1oKvGC5A3BppUwpZnBeTfDZCSrx+0L7g4HuFJzFX9TeThLLKj3tP3zqk9oDDAz0M7KlGkL5vHd2kA912lblX0VyMMV8OSSNdnRoKIquZZNe2FEnUbMWNefpU2jmowWOM1dCPNOBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762365245; c=relaxed/simple;
	bh=sbAYrCTxcLlU+6uPVv81XjpY0bvwWEU5Z/q0Cgw17oc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B6dV8nQ1VkdfjJA0CJpIGyYABJz7Gtn11/Tjpcva9TjdePZ6TIIAtKatBELJrA5Qbf8CoZjf+al2awA8+kYHbEO7fo1zgZnj9yQTii+Zh9KWYI+EaaFO96TASExFMtXwOSsC45WeBikJ2PbJzNgx9Mmkb0I36BlorZcn/idI71M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d1tH61l0tzHnGgk;
	Thu,  6 Nov 2025 01:53:54 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id F214714020A;
	Thu,  6 Nov 2025 01:53:59 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 5 Nov
 2025 17:53:59 +0000
Date: Wed, 5 Nov 2025 17:53:57 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-pci@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<bhelgaas@google.com>, <aneesh.kumar@kernel.org>, <yilun.xu@linux.intel.com>,
	<aik@amd.com>, Lukas Wunner <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH 6/6] PCI/TSM: Add 'dsm' and 'bound' attributes for
 dependent functions
Message-ID: <20251105175357.00006355@huawei.com>
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

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>




