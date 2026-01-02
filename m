Return-Path: <linux-pci+bounces-43931-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A80C9CEE702
	for <lists+linux-pci@lfdr.de>; Fri, 02 Jan 2026 12:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE0353000932
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jan 2026 11:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D422F0C48;
	Fri,  2 Jan 2026 11:57:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E915B2EC09B;
	Fri,  2 Jan 2026 11:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767355020; cv=none; b=L9MK4qBITBK34LD9I95mN93fqEIa+A7W314oAoDqwWwou0wywzM2Z8dOLwuKA4+VKKNL6zVeDYJ7j1xuXi+M32nzGcNFxwLHH/9XRn1yPso/5t2ZDnyQowwNpQ7NbhnCmt+ghR7tcFiwZS4sn21IEyHP+ijaVD7Xic5Qpw3iJac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767355020; c=relaxed/simple;
	bh=W1MRgIFZb+sXlokt40e9WqCJbxhWIGkQEC8U7O9cie0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WTAhDl6MPM/dfP+IYaixxOWtYWiMJ16gVkHuKFdR5MaIbz8hFenSI/o2Ou/45qWIPfKJXivQZYW7K1MEdSJHEurbji+Y8iEmu3xPOHY6XZinXsy1e1+X6dFZhDzMrT7Cd9VF3OZaqNb1EH4PRPdYaot+BzsX5JBlchMF8hKTOtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4djMbM4LfdzJ468k;
	Fri,  2 Jan 2026 19:55:59 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 06D7840086;
	Fri,  2 Jan 2026 19:56:55 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 2 Jan
 2026 11:56:54 +0000
Date: Fri, 2 Jan 2026 11:56:53 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux ACPI <linux-acpi@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, "Zhang
 Rui" <rui.zhang@intel.com>, Chen Yu <yu.c.chen@intel.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Linux PCI <linux-pci@vger.kernel.org>,
	Alex Hung <alexhung@gmail.com>, Hans de Goede <hansg@kernel.org>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<platform-driver-x86@vger.kernel.org>, AceLan Kao <acelan.kao@canonical.com>
Subject: Re: [PATCH v1] ACPI: scan: Use resource_type() for resource type
 checking
Message-ID: <20260102115653.000027f0@huawei.com>
In-Reply-To: <12814730.O9o76ZdvQC@rafael.j.wysocki>
References: <12814730.O9o76ZdvQC@rafael.j.wysocki>
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
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 30 Dec 2025 10:57:34 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> To follow a well-established existing pattern, use resource_type() for
> resource type checking in acpi_scan_claim_resources().
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>



