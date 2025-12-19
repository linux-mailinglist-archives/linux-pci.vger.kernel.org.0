Return-Path: <linux-pci+bounces-43396-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2136CCFEEB
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 13:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59764300A29A
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 12:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A10E2FFFB6;
	Fri, 19 Dec 2025 12:58:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B99C15ECD7;
	Fri, 19 Dec 2025 12:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766149119; cv=none; b=iS2x0bWcwRfYX2txAE4+fFpZh0h91uRIWXlV45KZOEggOE/sjdHatY+zPf4ReQQPIQEml+hItXW48EY7ds/KbJfmTpqdaAdg1QIwsIjJe0SJL0ZgJXPWotRVBgxK9hzo6/PbsSJKR5DV+JZjW5fM97XdQTx540uebJIKL6JEi2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766149119; c=relaxed/simple;
	bh=fIVOwnuHTK+Y/ExrdOsKw072LmBxpI0Yd+tQ8VZFfiQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jC1WT7OiFLj4EjzmWTB/PdP76pVdKh4M0ditCNYdojqgE+9ePVYHioVN6V7znLLg0365LrhW7sxJTStwO3+Y806XnSI/yCsisNooeMfCmfUEdMt1q5LNVtDdAkGw4NBKn2s3UfoXyYoxMUtFeyH6lkQXBNLKqE4RzZ9tBLnXMfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dXndM2dBWzJ4685;
	Fri, 19 Dec 2025 20:57:59 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 029CC40570;
	Fri, 19 Dec 2025 20:58:32 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 19 Dec
 2025 12:58:31 +0000
Date: Fri, 19 Dec 2025 12:58:30 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux ACPI <linux-acpi@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn
 Helgaas <helgaas@kernel.org>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Hans de Goede <hansg@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v1 7/8] ACPI: bus: Adjust feature mask creation for
 \_SB._OSC
Message-ID: <20251219125830.00006819@huawei.com>
In-Reply-To: <9564052.CDJkKcVGEf@rafael.j.wysocki>
References: <5049211.GXAFRqVoOG@rafael.j.wysocki>
	<9564052.CDJkKcVGEf@rafael.j.wysocki>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 18 Dec 2025 21:41:42 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The feature mask creation for \_SB._OSC platform features is messy
> and hard to follow, so clean it up and make all of the CPPC-related
> features depend on CONFIG_ACPI_CPPC_LIB as they will not work if it
> is not set anyway.
> 
> Also make acpi_bus_osc_negotiate_platform_control() print a message
> including a bit mask representing the features for which control has
> been granted.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Nice.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

