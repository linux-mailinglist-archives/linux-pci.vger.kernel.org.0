Return-Path: <linux-pci+bounces-21440-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16815A35A7F
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 10:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05E9161551
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 09:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204A423F40D;
	Fri, 14 Feb 2025 09:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MRgDN+vm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HW9X1JV7"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6585120B20B;
	Fri, 14 Feb 2025 09:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739525942; cv=none; b=fNHq4Ryi928TBkXebuaFmk3SNwO5Vy/lyjI9y9kxTfYuwAp4HYtPlPAktP+UvSWPA7upnYv1fCqp1q27K6tsCZveis0EmBAxBiwuyxjFsEJUCNfstg4ZyR7AebeljFlR6Cp0sEbCJHX3yweIB78CB9rusefZXG1veEy3Tyg9QM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739525942; c=relaxed/simple;
	bh=9ijsm6HczVi5ThTYceuVfLfvKtxB6vu8r1DXvKU3eT4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=uFpTphxMUjtCR9JZgu3d2GghbznQ0JQa+U/qzezu2z5ieIGY7r5k16zMFU10dgZTftmY2nrGgcXpZn0MMz357fL69/O+4S8oAjDbKINOVBU3YNVUL30fmA46ai2YFzITCH5kbZtBAkQKHi4UFQ2udhjkl33oSp+ZRu460N6l3FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MRgDN+vm; dkim=fail (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HW9X1JV7 reason="signature verification failed"; arc=none smtp.client-ip=192.198.163.9; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=ylGJXpb+Bo8SVziuzHuBH78Q+ZTnsfQrMC8w/UlfR/I=;
	b=MRgDN+vmbXHc1Si0FGxPFbZA4tQL3M5f1RMe0D58x/3UBvkG4riMgf6DeqAfMu
	9naV+K3VEb+seX8wF/dP4eVTlllaZYl6mshvAQEX0e18rP1ExaUAmKe7hB9fEHaP
	5x0LnKBZXvYKFyCv2rWZEaE8wBmIGDQ3cUJfqbZy4WtNk=
Received: from os-l3a203-yehs1-dev01.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBHX9AYD69nO4JaMA--.38086S2;
	Fri, 14 Feb 2025 17:38:33 +0800 (CST)
From: Xiaochun Lee <lixiaochun.2888@163.com>
To: xiaocli@redhat.com,
	740797925@qq.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Igor Mammedov <imammedo@redhat.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 00/25] PCI: Resource fitting/assignment fixes and cleanups
Date: Fri, 14 Feb 2025 17:59:02 +0800
Message-Id: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 1.8.3.1
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9]) (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits)) (No client certificate requested) by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D46206F09; Mon, 16 Dec 2024 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=intel.com; i=@intel.com; q=dns/txt; s=Intel; t=1734371805; x=1765907805; h=from:to:cc:subject:date:message-id:mime-version: content-transfer-encoding; bh=YI6S04K1iTSvj1Cp/dFALikn59iuWUReV9PISgS7tbM=; b=HW9X1JV7+FfLVfK5qDkZGICNeNafmtTGUoDa882sBctqOoJosxyCvpjo vs2uwd/doc5KQb9OiA6dRqJRcltw6lKcg9tqd7qpJmkZ1OC00d9bGTOnu qU7qrePAbJdAiFA3QYfA8rmprKuyw4aZ7seDMUQzT21Qatl1KfrXJSI79 PSDJqZtAiq+NsV6LzkYUuVgz5NGVaCjcB0CH7C+7h+XLBNdtyeA3gQFuq CALYsDZwqQJyXs3J0PDwg4OMiq7FXJtl8s2VGAIxw/FOteEfDtnS3E8Yk wN8gepy0wxJB/1ualpuIfKoMTJJDlaf0fWG5RSBGRLL5NpzYRw2ZuRO3+ g==;
X-CSE-ConnectionGUID: rx0qJFnjSW+DeTuYoki4RA==
X-CSE-MsgGUID: 9LfrqKeBRAK+uYCLB+OydQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="45465699"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600";  d="scan'208";a="45465699"
Received: from orviesa006.jf.intel.com ([10.64.159.146]) by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:56:45 -0800
X-CSE-ConnectionGUID: VpnYpi5JRPSI+feKgInibg==
X-CSE-MsgGUID: 7k4hsoGrSvOr6eVD+2Atig==
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600";  d="scan'208";a="97309253"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29]) by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:56:42 -0800
X-Mailer: git-send-email 2.39.5
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHX9AYD69nO4JaMA--.38086S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFWkCr43XFyDKF43Ar43Jrb_yoW5ZrW3pr
	WfWw48tFWkJry7Jrs5Aw1xAFs3Xa1vy3y5JFyft3s3Za98ZFy2qrn5tayrX3y3GrWxCF1a
	vF4jvrn8uFWDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUeOJUUUUU=
X-CM-SenderInfo: 5ol0xtprfk30aosymmi6rwjhhfrp/1tbioAvyQGetuKzg-wABsZ

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

> Hi all,
> 
> This series focuses on PCI resource fitting and assignment algorithms.
> I've further changes in works to enable handling resizable BARs better
> during resource fitting built on top of these, but that's still WIP and
> this series seems way too large as is to have more stuff included.
> 
> First there are small tweaks and fixes to the relaxed tail alignment
> code and applying the lessons learned to other similar cases. They are
> sort of independent of the rest. Then a large set of pure cleanups and
> refactoring that are not intended to make any functional changes.
> Finally, starting from "PCI: Extend enable to check for any optional
> resource" are again patches that aim to make behavioral changes to fix
> bridge window sizing to consider expansion ROM as an optional resource
> (to fix a remove/rescan cycle issue) and improve resource fitting
> algorithm in general.
> 
> The series includes one of the change from Michał Winiarski
> <michal.winiarski@intel.com> as these changes also touch the same IOV
> checks.
> 
> Please let me know if you'd prefer me to order the changes differently
> or split it into smaller chunks.
> 
> 
> I've extensively tested this series over the hosts in our lab which
> have quite heterogeneous PCI setup each. There were no losses of any
> important resource. Without pci=realloc, there's some churn in which of
> the disabled expansion ROMs gets a scarce memory space assigned (with
> pci=realloc, they are all assigned large enough bridge window).
> 
> 
> Ilpo Järvinen (24):
>   PCI: Remove add_align overwrite unrelated to size0
>   PCI: size0 is unrelated to add_align
>   PCI: Simplify size1 assignment logic
>   PCI: Optional bridge window size too may need relaxing
>   PCI: Fix old_size lower bound in calculate_iosize() too
>   PCI: Use SZ_* instead of literals in setup-bus.c
>   PCI: resource_set_range/size() conversions
>   PCI: Check resource_size() separately
>   PCI: Add pci_resource_num() helper
>   PCI: Add dev & res local variables to resource assignment funcs
>   PCI: Converge return paths in __assign_resources_sorted()
>   PCI: Refactor pdev_sort_resources() & __dev_sort_resources()
>   PCI: Use while loop and break instead of gotos
>   PCI: Rename retval to ret
>   PCI: Consolidate assignment loop next round preparation
>   PCI: Remove wrong comment from pci_reassign_resource()
>   PCI: Add restore_dev_resource()
>   PCI: Extend enable to check for any optional resource
>   PCI: Always have realloc_head in __assign_resources_sorted()
>   PCI: Indicate optional resource assignment failures
>   PCI: Add debug print when releasing resources before retry
>   PCI: Use res->parent to check is resource is assigned
>   PCI: Perform reset_resource() and build fail list in sync
>   PCI: Rework optional resource handling
> 
> Michał Winiarski (1):
>   PCI: Add a helper to identify IOV resources
> 
>  drivers/pci/pci.h       |  44 +++-
>  drivers/pci/setup-bus.c | 566 +++++++++++++++++++++++-----------------
>  drivers/pci/setup-res.c |   8 +-
>  3 files changed, 364 insertions(+), 254 deletions(-)
> 
Tested-by: Xiaochun XC17 Li <lixc17@lenovo.com>
> -- 
> 2.39.5



