Return-Path: <linux-pci+bounces-40702-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E83C467A4
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 13:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240861882699
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 12:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BB430ACFB;
	Mon, 10 Nov 2025 12:06:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886FD306B00;
	Mon, 10 Nov 2025 12:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776418; cv=none; b=HyHr2I8y1e2B9qDbKagICP/oxZoE9dn18FoSE3A+71uAhpzN6umNPpKb/A6vnhy/4R5dWT4sye9lTNUe7tzFpfDYVh3t43Kw//SfYvOukJN25sfLfVfgIqJhWIUoLz/gpUncYlNyelnFY2NtSsTne2NixUgLISgal4bFTurHZEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776418; c=relaxed/simple;
	bh=DapSXJIGI5RjygyLazVd9YzJJIWHq9DQ9gkiGsc6Rp0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FgDcdn5da05gkUZLrctPfdSYyUdWYJuAtq2mAjIYmz9CphKahM0+lTEZw8aDwMxAxujbuMK5Hh3xJF/bJZ9op0gkEbyRWviHs0qs5C7u8xAh1a5YElHfOVJsf3SEW9LKMC3lUNwHH0Cw5S57ayQlgIyxw7iBGlJLSaPCUH5D5zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d4pKq3nGgzJ46Dk;
	Mon, 10 Nov 2025 20:06:23 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id B777A140257;
	Mon, 10 Nov 2025 20:06:52 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 10 Nov
 2025 12:06:51 +0000
Date: Mon, 10 Nov 2025 12:06:50 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux PM <linux-pm@vger.kernel.org>, Linux ACPI
	<linux-acpi@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, LKML
	<linux-kernel@vger.kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>, Frank
 Li <Frank.Li@nxp.com>, Dhruva Gole <d-gole@ti.com>, Dan Williams
	<dan.j.williams@intel.com>, Linux PCI <linux-pci@vger.kernel.org>, "Bjorn
 Helgaas" <helgaas@kernel.org>, Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v1 0/3] PM: runtime: Wrapper macros for usage counter
 guards
Message-ID: <20251110120650.00004de8@huawei.com>
In-Reply-To: <13883374.uLZWGnKmhe@rafael.j.wysocki>
References: <13883374.uLZWGnKmhe@rafael.j.wysocki>
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

On Fri, 07 Nov 2025 19:35:09 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> Hi All,
> 
> The runtime PM usage counter guards introduced recently:
> 
> https://lore.kernel.org/linux-pm/6196611.lOV4Wx5bFT@rafael.j.wysocki/
> 
> and then fixed:
> 
> https://lore.kernel.org/linux-pm/5943878.DvuYhMxLoT@rafael.j.wysocki/
> 
> should generally work, but using them feels sort of arcane and cryptic
> even though the underlying concept is relatively straightforward.
> 
> For this reason, runtime PM wrapper macros around ACQUIRE() and
> ACQUIRE_ERR() involving the new guards are introduced in this series
> (patch [1/3]) and then used in the code already using the guards (patches
> [2/3] and [3/3]) to make it look more straightforward.
> 
> Thanks!

It's an interesting trade off between completely hiding the magic variables
and verbosity.  The PM_RUNTIME_ACQUIRE_ERR smells like something we'd
expect to be using global state (given no parameters), but it is of
course just local with a magic name.  Will take a little getting
used to but then so does all this cleanup.h magic.  So on balance
I think this is a good change.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

