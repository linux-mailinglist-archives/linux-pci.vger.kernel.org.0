Return-Path: <linux-pci+bounces-39788-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD39C1F6AD
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 11:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6F7619C8393
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 10:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0947434E765;
	Thu, 30 Oct 2025 10:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="vvHYm9kH"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout02.his.huawei.com (sinmsgout02.his.huawei.com [119.8.177.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F70E1B424F;
	Thu, 30 Oct 2025 10:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761818427; cv=none; b=JI3hZay2lk7F+DHrB9KXXrmZf8e+R7FOTDkEuj49XBAe7TFpmfmzpOAngyNT7c+0YAzO+1rJGhVrYlrCY8Wq5BBJEa5UZ/H6a5JZZryd7CCuDruyMPL3m9osvAeGfNq3H7M1FDnupZEzpcB6QXfmGG7JSl7m+kPjwIAgNW9/kr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761818427; c=relaxed/simple;
	bh=+dOgH4jl1jXrMG8zo0qv/8UurKQ8NypvMmC9KsBYtXI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vESpSh44H9D8Th3sXEGFFv/4X+wcGRjzkmgItjYXqF/u+JRvmsQSVdrVSgPJfntJjREBuq0mNCFuQpQBZuHQxOL3pCM7U4h734/puauTpI8YpTDP2SCegF77Dr/1IFo3xGz/XDiazoz2pVZr6+Res5h3oaKP9C+0fHOfpgBOoXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=vvHYm9kH; arc=none smtp.client-ip=119.8.177.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qSau6eJl3xmVw0sFsM0etsPCxVTY/gsYAE9WqoWMfmQ=;
	b=vvHYm9kH+Tp1DeqjfsY0hrSvHgnTv0kBPAgZLNrMklHkAkY/Cil6c6Mr4H1SWXuKRkz+k2f/A
	VaB3pg9t9ZfUMGmB1loUnLKZhITtP9NmWXnaxCCFQRX6usKcwCkXSyvtJYMYhNFMq3I6c34tBsb
	zoawAQVAYu/PWqhmdIhhhuM=
Received: from frasgout.his.huawei.com (unknown [172.18.146.35])
	by sinmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4cy02V2ZKGz1vnxf;
	Thu, 30 Oct 2025 17:59:30 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cxzyv2B5lz6M4Vd;
	Thu, 30 Oct 2025 17:56:23 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 5B3E61402F9;
	Thu, 30 Oct 2025 18:00:15 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 30 Oct
 2025 10:00:14 +0000
Date: Thu, 30 Oct 2025 10:00:13 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
CC: <linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dan.j.williams@intel.com>, <aik@amd.com>, <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Steven Price
	<steven.price@arm.com>, Bjorn Helgaas <helgaas@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, Will Deacon
	<will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [PATCH RESEND v2 05/12] coco: host: arm64: Build and register
 RMM pdev descriptors
Message-ID: <20251030100013.00005225@huawei.com>
In-Reply-To: <yq5a3470eq2s.fsf@kernel.org>
References: <20251027095602.1154418-1-aneesh.kumar@kernel.org>
	<20251027095602.1154418-6-aneesh.kumar@kernel.org>
	<20251029173743.00006d48@huawei.com>
	<yq5a3470eq2s.fsf@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 30 Oct 2025 14:14:43 +0530
Aneesh Kumar K.V <aneesh.kumar@kernel.org> wrote:

> Jonathan Cameron <jonathan.cameron@huawei.com> writes:
> 
> > On Mon, 27 Oct 2025 15:25:55 +0530
> > "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:  
> 
> ...
> 
> >>  
> >> +int pdev_create(struct pci_dev *pdev);  
> > That is a very generic name to find in a header, even one buried deep in drivers.
> > I'd prefix it with somethin more specific rmi_pdev_create() or something like that.  
> 
> May be I can call this cca_pdev_create, because rmi_pdev_create()
> already exist.
Sure. Anything reasonable is fine for this.

J
> 
> -aneesh


