Return-Path: <linux-pci+bounces-33125-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC604B15067
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 17:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0B0544765
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 15:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF4F294A16;
	Tue, 29 Jul 2025 15:47:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062A1293C5A;
	Tue, 29 Jul 2025 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753804071; cv=none; b=TiCYB/sZk4PjlXmP7UCs0aiYhhjkC3mdk3QjcWU/YX6UFHvl5DKGAZgd5tUgSbQKInIdhTOLIA2ddTMVLYQog2tfnIBtSpoDxyycqYvFpVgZCFGYgq6eAcXnLgIqdxzIoc/EPOM323re+iab3yQ3OUVpHnUn0o/D15lWfC58dLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753804071; c=relaxed/simple;
	bh=uGRMRCj20czLxiDkFZxyVp8jFrQzLQNLA8NZyCpiVl4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gJHk//JWMVJI94P4YWke3dw6ylTxQwaX/TAU+Pt+c2VJGjEwuUmmHtpmlSUZywxU7gPWHJ0i4dK8F+Hi5IjNugaYwZ76ovcou14Lg5Geek0NWORf7HAv5rXxE5cT0Ly9Ca+Zd7PCSOuud38WzfLKrCUWjzdCRjPu0DuVZHkGjE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bs07S71gTz6H7WG;
	Tue, 29 Jul 2025 23:46:12 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A5689140372;
	Tue, 29 Jul 2025 23:47:47 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 29 Jul
 2025 17:47:46 +0200
Date: Tue, 29 Jul 2025 16:47:45 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yi lun
	<yilun.xu@linux.intel.com>
Subject: Re: [PATCH v4 08/10] PCI/IDE: Report available IDE streams
Message-ID: <20250729164745.000079ab@huawei.com>
In-Reply-To: <20250717183358.1332417-9-dan.j.williams@intel.com>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
	<20250717183358.1332417-9-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 17 Jul 2025 11:33:56 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> The limited number of link-encryption (IDE) streams that a given set of
> host bridges supports is a platform specific detail. Provide
> pci_ide_init_nr_streams() as a generic facility for either platform TSM
> drivers, or PCI core native IDE, to report the number available streams.
> After invoking pci_ide_init_nr_streams() an "available_secure_streams"
> attribute appears in PCI host bridge sysfs to convey that count.
> 
> Introduce a device-type, @pci_host_bridge_type, now that both a release
> method and sysfs attribute groups are being specified for all 'struct
> pci_host_bridge' instances.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Xu Yi lun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
LGTM

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


