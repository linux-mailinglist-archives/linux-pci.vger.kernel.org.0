Return-Path: <linux-pci+bounces-44938-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E56FD246A8
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 13:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAAC63032FDD
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 12:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5974D352925;
	Thu, 15 Jan 2026 12:18:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7472B2AF1D;
	Thu, 15 Jan 2026 12:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768479483; cv=none; b=qLucCHayRXLHLRSIZEPfQ/Kh6XbMJQX5ZExYt4Z7fUWJD1TVvCCaJTDAkx5dQf7qksEqiOaVp4Qb8yZzbo7WSyunD7T5UGE3Ij8i0Vusjia9o4SaOtkWynk/+jnFM1FCTAdmsI1WWLCqfAS+JxGqf0FwTH5bihqvNIHEVmUqYRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768479483; c=relaxed/simple;
	bh=dYkWFxXwrm9vjdpfPtBK2KQBt6BSbEQw2lrbm7HrrB4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VVJXlm0AXbbJTGcP8l8Nikby8wZTPo3iSDwOYwziHrw0ggsjzFz3AumbMQ/MLYrRovGuFCvbnDrYFu6GwFtkk8wbd2z7QESCFpXc3vf0mdkpi5oKIrn0umSmwhwe6cok0YHZwytfYG72+IB4mL0vOiZkWejtxlKVrwxW/W5bESg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dsMSC4c9LzHnH7D;
	Thu, 15 Jan 2026 20:17:31 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 8029340563;
	Thu, 15 Jan 2026 20:17:53 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 15 Jan
 2026 12:17:52 +0000
Date: Thu, 15 Jan 2026 12:17:51 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>, Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Marc Zyngier <maz@kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 1/6] irqdomain: Add parent field to struct
 irqchip_fwid
Message-ID: <20260115121751.00004b9f@huawei.com>
In-Reply-To: <20260115-gicv5-host-acpi-v3-1-c13a9a150388@kernel.org>
References: <20260115-gicv5-host-acpi-v3-0-c13a9a150388@kernel.org>
	<20260115-gicv5-host-acpi-v3-1-c13a9a150388@kernel.org>
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

On Thu, 15 Jan 2026 10:50:47 +0100
Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:

> The GICv5 driver IRQ domain hierarchy requires adding a parent field to
> struct irqchip_fwid so that core code can reference a fwnode_handle parent
> for a given fwnode.
> 
> Add a parent field to struct irqchip_fwid and update the related kernel API
> functions to initialize and handle it.
> 
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


