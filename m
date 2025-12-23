Return-Path: <linux-pci+bounces-43572-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7605CD90CD
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 12:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 90A433019C6B
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 11:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D4F32E14F;
	Tue, 23 Dec 2025 11:13:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5309632E745;
	Tue, 23 Dec 2025 11:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766488417; cv=none; b=imyGKTh4jex2F+ejyl36fygUaOak4V2KJQfaAwVVPEB/fJiBmF6yZqjZKlBjASRWW5Ql58CfXN1lMUUY8ODWYe/4CvmWvLd3JT8iNbUKeXJtdh0LcfT4uswxxQ5DAQ6DoNXxsyPURkzCPEL4mkbk4bOvDF4hJqSkqL7REdpDBgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766488417; c=relaxed/simple;
	bh=WARTkQz92TkxQ7Y+D6ruxXARKII0Tb4sH0NPAw6FH60=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=elPkNfbBatd7pIX2gaEkay/9m+PhMs+2WrxIjFdoalobw/Qnnsve+HlonaZ502Ip/KSqQJGn6SUNky6dFt1uXJxzD3DRg4fIFq1fdyZgS79Ui/Kq90Jany8m0tThAUtRigV4pYgeHo5AR5/KMDK2I+B1pSYRq2wgrkFZKsgNXT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dbC6J39hRzHnHDj;
	Tue, 23 Dec 2025 19:12:56 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 4FFE440571;
	Tue, 23 Dec 2025 19:13:33 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 23 Dec
 2025 11:13:32 +0000
Date: Tue, 23 Dec 2025 11:13:31 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux ACPI <linux-acpi@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn
 Helgaas <helgaas@kernel.org>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Hans de Goede <hansg@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2.1 2/8] ACPI: bus: Rework printing debug messages on
 _OSC errors
Message-ID: <20251223111331.000054da@huawei.com>
In-Reply-To: <10794028.nUPlyArG6x@rafael.j.wysocki>
References: <2413407.ElGaqSPkdT@rafael.j.wysocki>
	<10794028.nUPlyArG6x@rafael.j.wysocki>
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

On Mon, 22 Dec 2025 20:11:08 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Instead of using one function, acpi_print_osc_error(), for printing a
> debug message and dumping the _OSC request data in one go, use
> acpi_handle_debug() directly for printing messages and a separate
> function called acpi_dump_osc_data() for dumping the _OSC request data
> before printing one or more of them.
> 
> This avoids
>  * dumping _OSC request data multiple times when there are
>    multiple error bits set in the return buffer,
>  * wrapping message lines on terminals with 80 character line width,
>  * mixing up unrelated messages by printing full lines only,
> and generally helps to make the messages easier to parse.
> 
> Also, use %pUL for UUID printing instead of printing UUIDs as strings
> and include the revision number into the dumped _OSC request data.
> 
> This is how the debug printout looks like when the
> OSC_REQUEST_ERROR and OSC_INVALID_REVISION_ERROR bits
> are set in the return buffer before the change:
> 
>  ACPI: \_SB_: ACPI: (0811B06E-4A27-44F9-8D60-3CBBC22E7B48): _OSC request failed
>  ACPI: _OSC request data:
>  ACPI:  1
>  ACPI:  2e7eff
>  ACPI: 
>  ACPI: \_SB_: ACPI: (0811B06E-4A27-44F9-8D60-3CBBC22E7B48): _OSC invalid revision
>  ACPI: _OSC request data:
>  ACPI:  1
>  ACPI:  2e7eff
>  ACPI:
> 
> and this is how it is going to look like afterward:
> 
>  ACPI: \_SB_: ACPI: _OSC: UUID: 0811B06E-4A27-44F9-8D60-3CBBC22E7B48, rev: 1
>  ACPI: \_SB_: ACPI: _OSC: capabilities DWORD 0: [00000001]
>  ACPI: \_SB_: ACPI: _OSC: capabilities DWORD 1: [002e7eff]
>  ACPI: \_SB_: ACPI: _OSC: request failed
>  ACPI: \_SB_: ACPI: _OSC: invalid revision
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

