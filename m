Return-Path: <linux-pci+bounces-43576-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6976CD919D
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 12:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3100C3013ED7
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 11:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E142315D3E;
	Tue, 23 Dec 2025 11:26:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F250254849;
	Tue, 23 Dec 2025 11:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766489214; cv=none; b=GdrZP44yNuuTKWhBYoEjiryM8tq2ODoG0Qk3DXxzS69DxWHFiBjS0Ma9SmI6PbP+OTkKP8QAAoXqprIZHnC8FLj36B0aQ+BETsUWM9u4gRsWXovU84YH4aU64SGsgLpk49Ry92UWewr3WX8rixKjTjvORUEynyAIpMlqOiabJwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766489214; c=relaxed/simple;
	bh=YAztgDJrl6wqsESBIkkwg17QjpI28XmLeNMHs05+amU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KOr0DmflgY2RENn7yaKdxesNraeX/Ot8rKQjhsQ+N+fp875JUhz+JEWvG/c9DfGImn2QYNJ8Kfcqc8M+uT5XvBrkZrDce0T7aBz4J3HJ8qeGwrrDiQhymGXrz6SAjJlIBdVg05SA5F/8r0v6p+EPW185bxh+Pcy6VNDZz8OSAXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dbCPc3k3XzHnGdn;
	Tue, 23 Dec 2025 19:26:12 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 6793140086;
	Tue, 23 Dec 2025 19:26:49 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 23 Dec
 2025 11:26:48 +0000
Date: Tue, 23 Dec 2025 11:26:47 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux ACPI <linux-acpi@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn
 Helgaas <helgaas@kernel.org>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Hans de Goede <hansg@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2.1 7/8] ACPI: bus: Adjust feature mask creation for
 \_SB._OSC
Message-ID: <20251223112647.00001ebf@huawei.com>
In-Reply-To: <4495088.ejJDZkT8p0@rafael.j.wysocki>
References: <2413407.ElGaqSPkdT@rafael.j.wysocki>
	<4495088.ejJDZkT8p0@rafael.j.wysocki>
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

On Mon, 22 Dec 2025 20:23:29 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The feature mask creation for \_SB._OSC is messy and hard to follow,
> so clean it up and make all of the CPPC-related features depend on
> CONFIG_ACPI_CPPC_LIB as they will not work if it is not set anyway.
> 
> Also make acpi_bus_osc_negotiate_platform_control() print a message
> including a bit mask representig the features for which control has
> been granted.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
> 
> v1 -> v2.1:
>    * Print one more message including the initial feature mask before processing.
>    * Add R-by from Jonathan (assuming it still applies).
FWIW the extra message makes sense to me. So RB definitely still applies.

