Return-Path: <linux-pci+bounces-36282-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F9EB59EF1
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 19:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC53D173731
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 17:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B430426F28C;
	Tue, 16 Sep 2025 17:10:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ADB3016F1
	for <linux-pci@vger.kernel.org>; Tue, 16 Sep 2025 17:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758042619; cv=none; b=Qdu18FCeKiigrrEWL5yb0Gn4Ne4KexiBYu5yes5aOLGIyEo8bmh/GR6+eLHhIZhILm/JGD0BU8pcYIVQLNXtaLvD+OFZwhgZn1yc8y5QobfnZ+VbBUczpAcXiTVYTBZ+AIUj1v7Dm29reA6MH03/b59Pk6gRL/Wq7ehLBNvXcn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758042619; c=relaxed/simple;
	bh=2XfpTJubQl+ljBf+rXrwQKhz/e6SXyeEvNSNPzIRgLw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i0xoiVVzlJN+8YS9lKuhPIn6l4PGcE36MuP4/nr7WmSMbafrSZDDc+97H42QpVYYPuPymstpQwS5ZcQBXny7UEeKvrw/MzEf0h6FNuRU72SCda58ss2aNLHagCTWZciBCXtHDX3JMfMaLleK5piw7zkDmoL/cxu/rZO+DRHRDSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cR7f35NrLz6L4xL;
	Wed, 17 Sep 2025 01:08:43 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 51394140137;
	Wed, 17 Sep 2025 01:10:14 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 16 Sep
 2025 19:10:13 +0200
Date: Tue, 16 Sep 2025 18:10:12 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <bhelgaas@google.com>,
	<yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>, <aik@amd.com>
Subject: Re: [PATCH 5/7] PCI/TSM: Add Device Security (TVM Guest) operations
 support
Message-ID: <20250916181012.000049fa@huawei.com>
In-Reply-To: <20250827035259.1356758-6-dan.j.williams@intel.com>
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
	<20250827035259.1356758-6-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)


One trivial thing noticed on a first scan through.

>  Documentation/ABI/testing/sysfs-bus-pci   |  46 ++-
>  Documentation/ABI/testing/sysfs-class-tsm |  19 ++
>  drivers/pci/Kconfig                       |   2 +
>  drivers/pci/tsm.c                         | 358 +++++++++++++++++++++-
>  drivers/virt/coco/tsm-core.c              |  41 +++
>  include/linux/device.h                    |   1 +
>  include/linux/pci-tsm.h                   |  25 +-
>  7 files changed, 482 insertions(+), 10 deletions(-)

> +
> +What:		/sys/bus/pci/devices/.../tsm/lock
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(RW) Write the name of a TSM (TEE Security Manager) device from
> +		/sys/class/tsm to this file to request that TSM lock th device

th device device -> the device.?

> +		device. This puts the device in a state where it can not accept
> +		or issue secure memory cycles (T=1 in the PCIe TLP), and





