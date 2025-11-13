Return-Path: <linux-pci+bounces-41084-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE12C5743B
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 12:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 822344E0454
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 11:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C8227B34E;
	Thu, 13 Nov 2025 11:49:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0AD336EE5
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 11:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763034541; cv=none; b=sWYKKDxf24xaclF0+skOBFmY79NaEPYN2ONZYFdxnA7l7032xDweiyGnYvN8+nIfnpxkwlwNmAXJ0kUU3Vh+4eurv1rC7HbBwj5/TdRZD3yypXk2z2vMCHGpJiJzVrtT69VF/wA5kk8V2hoiXN/+iMcPdQMn5sHfz7HkTULx+IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763034541; c=relaxed/simple;
	bh=a2g0IjUt34kU2RpiF+4FLlDER1grl/YUd6l7/XC5sj8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IxIDyzcBR/t1i7CMjI0hXKCO6VkKLwfJPFZRp6DaP+dHmlfey/l6//hRjcVK5imDFq35M1IEyfBVyzgdTJL33hG8KWyYi6362SkC0XXk2pZ2kywVkm04No2CBzxcbduI+Uzgb9zqNfd9EACPn/0oaa7R30QmLRN4tkBFsdO/OAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d6dnf4kSJzJ46Zp;
	Thu, 13 Nov 2025 19:48:22 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id B02341402F5;
	Thu, 13 Nov 2025 19:48:56 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 13 Nov
 2025 11:48:56 +0000
Date: Thu, 13 Nov 2025 11:48:54 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-pci@vger.kernel.org>, <linux-coco@lists.linux.dev>, Xu Yilun
	<yilun.xu@linux.intel.com>, Aneesh Kumar K.V <aneesh.kumar@kernel.org>, Arto
 Merilainen <amerilainen@nvidia.com>
Subject: Re: [PATCH v2 4/8] PCI/IDE: Add Address Association Register setup
 for downstream MMIO
Message-ID: <20251113114854.00005520@huawei.com>
In-Reply-To: <20251113021446.436830-5-dan.j.williams@intel.com>
References: <20251113021446.436830-1-dan.j.williams@intel.com>
	<20251113021446.436830-5-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 12 Nov 2025 18:14:42 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> From: Xu Yilun <yilun.xu@linux.intel.com>
> 
> The address ranges for downstream Address Association Registers need to
> cover memory addresses for all functions (PFs/VFs/downstream devices)
> managed by a Device Security Manager (DSM). The proposed solution is get
> the memory (32-bit only) range and prefetchable-memory (64-bit capable)
> range from the immediate ancestor downstream port (either the direct-attach
> RP or deepest switch port when switch attached).
> 
> Similar to RID association, address associations will be set by default if
> hardware sets 'Number of Address Association Register Blocks' in the
> 'Selective IDE Stream Capability Register' to a non-zero value. TSM drivers
> can opt-out of the settings by zero'ing out unwanted / unsupported address
> ranges. E.g. TDX Connect only supports prefetachable (64-bit capable)
> memory ranges for the Address Association setting.
> 
> If the immediate downstream port provides both a memory range and
> prefetchable-memory range, but the IDE partner port only provides 1 Address
> Association Register block then the TSM driver can pick which range to
> associate, or let the PCI core prioritize memory.
> 
> Note, the Address Association Register setup for upstream requests is still
> uncertain so is not included.
> 
> Co-developed-by: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> Co-developed-by: Arto Merilainen <amerilainen@nvidia.com>
> Signed-off-by: Arto Merilainen <amerilainen@nvidia.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
This addressed only comment I was expecting to result in changes in v1, so
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

