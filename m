Return-Path: <linux-pci+bounces-41086-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78928C57525
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 13:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62F683BB12D
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 12:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4053396E4;
	Thu, 13 Nov 2025 12:01:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158CB333739
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 12:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763035278; cv=none; b=De6iVp/+w1Wsumr6uepzeOQ8Gm1sE1zuJFVWFhsJPkhXj98CmCxwDNK4c8fUgm3DFekQxsob+YvBRxvLjPlni1C+b33wQN37Nn6mxu4WhjP57RqeMdgi0HYlKfC586BoeT5Vgij1PuzVaRwOAeZN0ikBVqyNFXyO8VRIc3tnEfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763035278; c=relaxed/simple;
	bh=gacEDftiIMGyzbxhh8SGGBhPfu8wzY0ZgZrVRGdjfr0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nxrtNU3W8vEnIFlnUoaZdMuPZEqWItQ2PBjV8PcoDhO/0t7GQN3iCIw4REcGikEwo18HND/7F3IqrTEE2YJ3DYcAIqX2+TYq0AIvQCcK37MO+rnwdhsq42rHEa7qIC80QS0DB0fwHVvvtCE3VRRbui12HdQ1nSrrrSgupyWCOO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d6f3q4FKlzJ46pd;
	Thu, 13 Nov 2025 20:00:39 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id A7DCB1402F5;
	Thu, 13 Nov 2025 20:01:13 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 13 Nov
 2025 12:01:13 +0000
Date: Thu, 13 Nov 2025 12:01:11 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-pci@vger.kernel.org>, <linux-coco@lists.linux.dev>, Xu Yilun
	<yilun.xu@linux.intel.com>, Aneesh Kumar K.V <aneesh.kumar@kernel.org>
Subject: Re: [PATCH v2 6/8] PCI/TSM: Add pci_tsm_bind() helper for
 instantiating TDIs
Message-ID: <20251113120111.000038a0@huawei.com>
In-Reply-To: <20251113021446.436830-7-dan.j.williams@intel.com>
References: <20251113021446.436830-1-dan.j.williams@intel.com>
	<20251113021446.436830-7-dan.j.williams@intel.com>
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

On Wed, 12 Nov 2025 18:14:44 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> After a PCIe device has established a secure link and session between a TEE
> Security Manager (TSM) and its local Device Security Manager (DSM), the
> device or its subfunctions are candidates to be bound to a private memory
> context, a TVM. A PCIe device function interface assigned to a TVM is a TEE
> Device Interface (TDI).
> 
> The pci_tsm_bind() requests the low-level TSM driver to associate the
> device with private MMIO and private IOMMU context resources of a given TVM
> represented by a @kvm argument. A device in the bound state corresponds to
> the TDISP protocol LOCKED state and awaits validation by the TVM. It is a
> 'struct pci_tsm_link_ops' operation because, similar to IDE establishment,
> it involves host side resource establishment and context setup on behalf of
> the guest. It is also expected to be performed lazily to allow for
> operation of the device in non-confidential "shared" context for pre-lock
> configuration.
> 
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
LGTM to me so
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
though I would like to here from Aneesh on whether the v1 discussion
answered all questions expressed.

