Return-Path: <linux-pci+bounces-43384-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB00FCCFC83
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 13:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A678301338F
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 12:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269B133F397;
	Fri, 19 Dec 2025 12:26:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277142D061D;
	Fri, 19 Dec 2025 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766147188; cv=none; b=LH4iJC5s3TZVsj11pvx0d3wnM6AUFc0ctrJj2X0u6KcvvuRMZzVN8sjbFiJHMF3nrTzxDbJACmBGML/O7SOe7+BDKTgn1vUFV18cE3HgGPhbMTlR10pLdtPQ0GABQUKj12o3PMJJ32QSyM4vPgwbYTYnjBAEhmRiAiRCgR3Dau0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766147188; c=relaxed/simple;
	bh=FVTqb8USUxk2i4GkkIGGu4WeITUNyws2HsmMu4s8mzg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DYxLmzHWKD1YRhAHabcRh7yCe0NbKjcRssaAKZpm+oQVQ2AjUfOW44ZDfXu3mPBSbLkHTLRzK2nYBpoU9lXjo2akAhBZPsuEDzl+hh6Uqeu0L/LDPj2w/db1qG1CpxYaWjQtcB0ZHbalbLMFamxT3Vm2uxnHkoiv++ztHv9tDZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dXmwF4ZLkzJ46BV;
	Fri, 19 Dec 2025 20:25:49 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 3A29940569;
	Fri, 19 Dec 2025 20:26:22 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 19 Dec
 2025 12:26:21 +0000
Date: Fri, 19 Dec 2025 12:26:20 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux ACPI <linux-acpi@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn
 Helgaas <helgaas@kernel.org>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Hans de Goede <hansg@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v1 1/8] ACPI: bus: Fix handling of _OSC errors in
 acpi_run_osc()
Message-ID: <20251219122620.00002049@huawei.com>
In-Reply-To: <2261695.irdbgypaU6@rafael.j.wysocki>
References: <5049211.GXAFRqVoOG@rafael.j.wysocki>
	<2261695.irdbgypaU6@rafael.j.wysocki>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 18 Dec 2025 21:34:26 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The handling of _OSC errors in acpi_run_osc() is inconsistent.

I wonder if this would be easier to follow with a brief statement
of why we threat OSC_CAPABILITIES_MASK_ERROR as an error in the first
place for non query cases?  It took me a brief think and spec read
to figure that out, but maybe more coffee needed.

> 
> For example, if OSC_CAPABILITIES_MASK_ERROR is set in the return buffer
> and OSC_QUERY_ENABLE is set in the capabilities buffer, all of the
> _OSC errors will be ignored even though some of them indicate that
> _OSC evaluation has failed.  However, if OSC_QUERY_ENABLE is not set in
> the capabilities buffer, all _OSC errors will be reported, but the error
> value returned by acpi_run_osc() depends on whether or not
> OSC_CAPABILITIES_MASK_ERROR is set in the return buffer.
> 
> Adress this by making acpi_run_osc() clear OSC_CAPABILITIES_MASK_ERROR
> in the return buffer if OSC_QUERY_ENABLE is set in the capabilities
> buffer and then check if any other _OSC errors have been returned.  Also
> make it use the same error return value for all _OSC errors and print
> a message for OSC_CAPABILITIES_MASK_ERROR like for the other error
> types.
> 
> Moreover, make acpi_run_osc() only take the defined _OSC error bits into
> account when checking _OSC errors.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Changes look good to me.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

