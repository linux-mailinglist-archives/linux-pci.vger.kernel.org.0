Return-Path: <linux-pci+bounces-43575-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 237D6CD918E
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 12:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 907B130019CA
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 11:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5282F28EF;
	Tue, 23 Dec 2025 11:25:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5D52D3A80;
	Tue, 23 Dec 2025 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766489121; cv=none; b=uxj5t0/WvQEG3yvFWrVNQZe166IsYZNemqXhZ58n8XSS5gYIOtQd1gJxCQ2ELFfJV6oA6qUS1tiZrCbNMUoyePxCvgj3ZE2S1o9e5ga9kOTOZagXBtRHsypmQ+X71/0dlkXoRgt+gTdMV+bCoSkrWdnttWYkw+0GHMp3cfi3GXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766489121; c=relaxed/simple;
	bh=8FDWKxP8eWRtJEGwqk3ccO5WnewgwfMkz9+6EbDS6jY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TGy1VE+Kzu79DD6FQX89TtvFC4B0Q4d274p5xA5LG5b0JQq/Fg4GzQZ+twrohZrOqqD1+8GhJDbaP+gJZmLY4UQTNVHm+lrxe7hmexERIDrlpLgf69l+HB8n2uPHWrt4LLIJcnvYovaDV+bpHK5ykJMOTAVGTnN0M5FRjNsMzfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dbCMf61j0zJ46BG;
	Tue, 23 Dec 2025 19:24:30 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id DBE2F4056A;
	Tue, 23 Dec 2025 19:25:09 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 23 Dec
 2025 11:25:09 +0000
Date: Tue, 23 Dec 2025 11:25:07 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux ACPI <linux-acpi@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn
 Helgaas <helgaas@kernel.org>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Hans de Goede <hansg@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2.1 6/8] ACPI: bus: Rework the handling of \_SB._OSC
 platform features
Message-ID: <20251223112507.0000250d@huawei.com>
In-Reply-To: <1966378.CQOukoFCf9@rafael.j.wysocki>
References: <2413407.ElGaqSPkdT@rafael.j.wysocki>
	<1966378.CQOukoFCf9@rafael.j.wysocki>
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

On Mon, 22 Dec 2025 20:21:19 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Both acpi_bus_osc_negotiate_platform_control() and
> acpi_bus_osc_negotiate_usb_control() first call acpi_run_osc() to
> evaluate _OSC in "query mode", with OSC_QUERY_ENABLE set in the
> capabilities buffer, and then use the resultant feature mask as
> the input buffer for requesting control of those features by
> calling acpi_run_osc() to evaluate _OSC with OSC_QUERY_ENABLE clear.
> 
> This involves some code duplication and unnecessary memory
> allocations, so introduce a new helper function carrying out an
> _OSC handshake along the lines of the above description in a simpler
> way and update acpi_bus_osc_negotiate_platform_control() to use it.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

