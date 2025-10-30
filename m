Return-Path: <linux-pci+bounces-39802-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B25C1FC43
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 12:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D4F53AB01D
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 11:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3B32405E1;
	Thu, 30 Oct 2025 11:16:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1664C6C
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 11:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761822962; cv=none; b=XeHXwoKt7HfjvSM/CBKLuySsW1LmYZhcA25Ab51fG4N+t/Ewmma3vayNJtnQ6tWp2N/6Aqm/XRd6TQPJPS4aVURJifwACgpDT64k+wvrAFGJV8nfIWnSC/f0c0ywXVfqLYmdo2oUEj+/2k6o1aJ0SHQPxgIh4lreD+DvplrbWFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761822962; c=relaxed/simple;
	bh=DR15C7NxbfAWRyga0iph0sdKhc8xcN9dnBFkhMMKUSA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OqnudCe/MFQJlh4F7C2XUxHJZsq/PrIUomuVvDfA3CoQrM/nDRe/SHlykrnm92htEIn+I1y0hyqy501KndkjUsI0aRwlDeb0L2220xbxqvSgfSmWYEyxLSDctSBmy9hPAWR8f/mY7vPeBiOZKlOijorPED5x2e9PgujGx4SP+wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cy1hb60L1z67cQ8;
	Thu, 30 Oct 2025 19:14:07 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 087BF14038F;
	Thu, 30 Oct 2025 19:15:57 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 30 Oct
 2025 11:15:56 +0000
Date: Thu, 30 Oct 2025 11:15:55 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<xin@zytor.com>, <chao.gao@intel.com>, Zhenzhong Duan
	<zhenzhong.duan@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [RFC PATCH 19/27] coco/tdx-host: Add a helper to exchange SPDM
 messages through DOE
Message-ID: <20251030111555.00000d8f@huawei.com>
In-Reply-To: <20250919142237.418648-20-dan.j.williams@intel.com>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
	<20250919142237.418648-20-dan.j.williams@intel.com>
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

On Fri, 19 Sep 2025 07:22:28 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> From: Zhenzhong Duan <zhenzhong.duan@intel.com>
> 
> TDX host uses this function to exchange TDX Module encrypted data with
> devices via SPDM. It is unfortunate that TDX passes raw DOE frames with
> headers included and the PCI DOE core wants payloads separated from
> headers.
> 
> This conversion code is about the same amount of work as teaching the PCI
> DOE driver to support raw frames. Unless and until another raw frame use
> case shows up, just do this conversion in the TDX TSM driver.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

LGTM and finally a bit I know enough about for a tag to make sense :)
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

