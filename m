Return-Path: <linux-pci+bounces-43043-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 658A1CBDBDF
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 13:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D02A301A35D
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 12:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9105314A8E;
	Mon, 15 Dec 2025 12:09:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CD5223DFB;
	Mon, 15 Dec 2025 12:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765800568; cv=none; b=OMmYaXtwje0zlxG7C2yx+WijqZOE0mSSrsIwXM0ovYcVK+q0bdbYQcmvRasj1NehZeC+gpBhur/vBiuy/tQgD3q+gdqqabA4cN2lSlvD/QhYnsPKN+tCBPG/UA3YcO5ijGTQ0MDnNn+cBwUIPUya6c/wS+u4b6rvtx53Y7bTMLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765800568; c=relaxed/simple;
	bh=0MfGChpR6j4AOMXxkx+98Bx6kdYsc2bJRrAYJi9JleA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJtTkW4NcA323OFDjQMVgAUHIbQpguzkiQxs6IbOYhK1UmkDKrQfIor/BYsYqlEzbLcu1P8mWgAMu7ISdO+hfwd5ZXkr3PqfA+UTk+mRAd60/Cggy3J7gWTeCRZlgGj4XErQRIb6bxwEPEP82UBMmhKtTSOpDLvx6UDgEwh1E64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dVJkj6kwgzHnGch;
	Mon, 15 Dec 2025 20:09:01 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 2A85440577;
	Mon, 15 Dec 2025 20:09:23 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 15 Dec
 2025 12:09:22 +0000
Date: Mon, 15 Dec 2025 12:09:21 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
	<alison.schofield@intel.com>, <terry.bowman@amd.com>,
	<alejandro.lucero-palau@amd.com>, <linux-pci@vger.kernel.org>, Alejandro
 Lucero <alucerop@amd.com>
Subject: Re: [PATCH 3/6] cxl/port: Arrange for always synchronous endpoint
 attach
Message-ID: <20251215120921.00005875@huawei.com>
In-Reply-To: <20251204022136.2573521-4-dan.j.williams@intel.com>
References: <20251204022136.2573521-1-dan.j.williams@intel.com>
	<20251204022136.2573521-4-dan.j.williams@intel.com>
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

On Wed,  3 Dec 2025 18:21:33 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Make it so that upon return from devm_cxl_add_endpoint() that
> cxl_mem_probe() can assume that the endpoint has had a chance to complete
> cxl_port_probe().  I.e. cxl_port module loading has completed prior to
> device registration.
> 
> Delete the MODULE_SOFTDEP() as it is not sufficient for this purpose, but a
> hard link-time dependency is reliable. Specifically MODULE_SOFTDEP() does
> not guarantee that the module loading has completed prior to the completion
> of the current module's init.
> 
> Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

