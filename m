Return-Path: <linux-pci+bounces-8868-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C2690AE3A
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 14:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2C89B22220
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 12:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91398197556;
	Mon, 17 Jun 2024 12:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G6nYcwtt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AlFAfYvC"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0078197553;
	Mon, 17 Jun 2024 12:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718628733; cv=none; b=aHuffqrJa5FRikdpdSGnDs7XeuddYnjWIRCefgi/yf1cWpFHHuomjUG7BL1XlKyPxB4qZd7nXt2nwQveaJO9Vk4ubtVt8RiggLDbMQYahunUzYpBcCnlgbcZG79XE/XX3AFymCB+r9Y4hDwVacz1ecq1aha84Rcr0WHzeqIAhJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718628733; c=relaxed/simple;
	bh=D9BQZd2LGXwlOr+YJaZ8ew/Asb6dMyVeeVqmzSzvkT4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VK1W+wLqb4v1zkwiuqXlxlGdgR8TMRltQIXXRZ3Nf+Jsrh+z0i2O4+yiG3CY/KpsQBtRhM2DyjPGg28M55Iyf1FCPvg+5Vs37wk+r1NpkxFHF0HdIEW1lsS2I6dMtSvLBVJk2pFwKmlwlj7MJVNexzulgtkQQP5oW5S3AUYbiFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G6nYcwtt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AlFAfYvC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718628724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=19qM+3bC9IjzpcT4GLOy0AdQrrp4B3Guy2WZKGWUKCs=;
	b=G6nYcwtt0mhaDuEz7D965JCkNOeu58+rguak4oBaNfg4r7LM/acg2xDVIoVeftI1T4MxpV
	ACivdbcm/hmN2Yu7wFdvpXLmkI8hnMLM01ES2j/0RrbH1nom1i4f7BffGyzhz+3xyvgMJx
	dWQNNDWtVj4Q9I2wg8Jr05dqNvp/bXdgmAhR/g5vOqj2g33FST6PjZCqdu/nLaUGxN7FjM
	jk5mV1+W0EmKHwQjA8+92+ZfvYaTgtDigz0OgNbx6NAco17UBX7HBtz2U62uIusElGjgz3
	Y0TdFGM659tpsL8kjYvAD1ugWT8cbzbXLGg2Yz+LKRty2OUa6eOMAUP2zYvbqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718628724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=19qM+3bC9IjzpcT4GLOy0AdQrrp4B3Guy2WZKGWUKCs=;
	b=AlFAfYvCXQ7h+o3wd68KVSlPn6D2rLSUFw7og3Zo8KfDThkMqkCIKNS7FSmiMhSIMav69q
	GqS6NgOGyXRLA1Ag==
To: Bjorn Helgaas <helgaas@kernel.org>, Shivamurthy Shastri
 <shivamurthy.shastri@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, maz@kernel.org, anna-maria@linutronix.de,
 shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
 bhelgaas@google.com, rdunlap@infradead.org, vidyas@nvidia.com,
 ilpo.jarvinen@linux.intel.com, apatel@ventanamicro.com,
 kevin.tian@intel.com, nipun.gupta@amd.com, den@valinux.co.jp,
 andrew@lunn.ch, gregory.clement@bootlin.com,
 sebastian.hesselbarth@gmail.com, gregkh@linuxfoundation.org,
 rafael@kernel.org, alex.williamson@redhat.com, will@kernel.org,
 lorenzo.pieralisi@arm.com, jgg@mellanox.com, ammarfaizi2@gnuweeb.org,
 robin.murphy@arm.com, lpieralisi@kernel.org, nm@ti.com, kristo@kernel.org,
 vkoul@kernel.org, okaya@kernel.org, agross@kernel.org,
 andersson@kernel.org, mark.rutland@arm.com,
 shameerali.kolothum.thodi@huawei.com, yuzenghui@huawei.com
Subject: Re: [PATCH v3 03/24] PCI/MSI: Provide MSI_FLAG_PCI_MSI_MASK_PARENT
In-Reply-To: <20240614160942.GA1114672@bhelgaas>
References: <20240614160942.GA1114672@bhelgaas>
Date: Mon, 17 Jun 2024 14:52:03 +0200
Message-ID: <87sexbu3yk.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jun 14 2024 at 11:09, Bjorn Helgaas wrote:
> On Fri, Jun 14, 2024 at 12:23:42PM +0200, Shivamurthy Shastri wrote:
>> Most ARM(64) PCI/MSI domains mask and unmask in the parent domain after or
>> before the PCI mask/unmask operation takes place. So there are more than a
>> dozen of the same wrapper implementation all over the place.
>
> Is this an opportunity to clean up all these wrappers?  If you could
> mention an example or two here, maybe somebody would be motivated to
> come back and simplify the existing wrappers to take advantage of this
> new flag?

The wrappers go away once the relevant MSI implementations are converted
over to the new scheme/

See patch 7 for an example: its_[un]mask_msi_irq() are gone.

Thanks,

        tglx


