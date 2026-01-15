Return-Path: <linux-pci+bounces-44940-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AED6CD24912
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 13:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAC4431B01BE
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 12:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D5F399A4C;
	Thu, 15 Jan 2026 12:30:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F55A399014;
	Thu, 15 Jan 2026 12:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768480248; cv=none; b=dzBhO40IGa1+Myn2H7HqrxJlq4m51bgVWKtauJ2IVt5JTGKHj0MuPJD63gorydPS2aWi7DMp2/3xFXcIijcCknWoJujAPtB6IG+To/3JXWFpkbnBcUTVstwue60SL9S+ucJ6XHeFQ6Vm7yiC+qckhdittNMSIRXGbNOqfbxAf68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768480248; c=relaxed/simple;
	bh=XD1C7nLYtN3BRri3KhA+iXZgfZrEpRuns13YxmLS+Ms=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tTaE5gWwIPY3TaIKhWYCgVnq88iVlPIfGjsIUagOYuzVwtLpTPwtp5xzAHDMolpJ2txRL+T6EyGkvLhn9cuGUIwYK4LPsvENGc44t0mNnU2s9XURH+rpDPp8KHmx1rzvd5WgmKY4wfTDRNJHNZgbVLGlTBi5TKgM52A9w0NMC40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dsMl80L4PzJ46bg;
	Thu, 15 Jan 2026 20:30:28 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 4E65340563;
	Thu, 15 Jan 2026 20:30:44 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 15 Jan
 2026 12:30:43 +0000
Date: Thu, 15 Jan 2026 12:30:42 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>, Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Marc Zyngier <maz@kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 4/6] irqchip/gic-v5: Add ACPI IRS probing
Message-ID: <20260115123042.000015ad@huawei.com>
In-Reply-To: <20260115-gicv5-host-acpi-v3-4-c13a9a150388@kernel.org>
References: <20260115-gicv5-host-acpi-v3-0-c13a9a150388@kernel.org>
	<20260115-gicv5-host-acpi-v3-4-c13a9a150388@kernel.org>
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

On Thu, 15 Jan 2026 10:50:50 +0100
Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:

> On ARM64 ACPI systems GICv5 IRSes are described in MADT sub-entries.
> 
> Add the required plumbing to parse MADT IRS firmware table entries and
> probe the IRS components in ACPI.
> 
> Augment the irqdomain_ops.translate() for PPI and SPI IRQs in order to
> provide support for their ACPI based firmware translation.
> 
> Implement an irqchip ACPI based callback to initialize the global GSI
> domain upon an MADT IRS detection.
> 
> The IRQCHIP_ACPI_DECLARE() entry in the top level GICv5 driver is only used
> to trigger the IRS probing (ie the global GSI domain is initialized once on
> the first call on multi-IRS systems); IRS probing takes place by calling
> acpi_table_parse_madt() in the IRS sub-driver, that probes all IRSes
> in sequence.
> 
> Add a new ACPI interrupt model so that it can be detected at runtime and
> distinguished from previous GIC architecture models.
> 
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
LGTM
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

