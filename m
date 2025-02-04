Return-Path: <linux-pci+bounces-20691-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C6EA26E0E
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 10:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9031165F33
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 09:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38C9206F37;
	Tue,  4 Feb 2025 09:20:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CF2206F02;
	Tue,  4 Feb 2025 09:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738660814; cv=none; b=n4L2JUOlV8q/JqrgKOgt/nJIU8Bq5eiMAOVgvSQ+1wavyQ0zPvziDlsCpll9S7IhM3uQU7DfRa6HvZ1tjefLtm02T6vj9MfRV7gNcunUFSyTbkC5XpYd/I1xQ2jkV5NtZ5lH/1H/2CrMe1C2I8AUFhle6i/9K6KhS83KvhZuazs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738660814; c=relaxed/simple;
	bh=BFGsbaTSvbMUMC4bFEn2tx2w2G4O/Nh9tSKKhTzYN7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/dJhF7TlLoLvPXOUjXlbWHmmiINuuMsDUonZdexqr3vTEV8R1nrwz5lMqdkt28b6T8unt6fmUROSTKscHsTQEbB6uX0V1JQ0C0tEZhyeHLOwKfiX+Ck3SeWdrkND/P78dzXlPSq0myfrJannkYuMJlC2pvYR7wsYn2W+ExX6SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 1D38F100FBF8B;
	Tue,  4 Feb 2025 10:14:11 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E2D10495661; Tue,  4 Feb 2025 10:14:10 +0100 (CET)
Date: Tue, 4 Feb 2025 10:14:10 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <Jonthan.Cameron@huawei.com>,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: Disable PCIE hotplug interrupts early when msi
 is disabled
Message-ID: <Z6HaYkIKLXji_EO7@wunner.de>
References: <20250204053758.6025-1-feng.tang@linux.alibaba.com>
 <20250204053758.6025-2-feng.tang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204053758.6025-2-feng.tang@linux.alibaba.com>

On Tue, Feb 04, 2025 at 01:37:58PM +0800, Feng Tang wrote:
> There was a irq storm bug when testing "pci=nomsi" case, and the root
> cause is: 'nomsi' will disable MSI and let devices and root ports use
> legacy INTX inerrupt, and likely make several devices/ports share one
> interrupt. In the failure case, BIOS doesn't disable the PCIE hotplug
> interrupts, and  actually asserts the command-complete interrupt.
> As MSI is disabled, ACPI initialization code will not enumerate root
> port's PCIE hotplug capability, and pciehp service driver wont' be
> enabled for the root port to handle that interrupt, later on when it is
> shared and enabled by other device driver like NVME or NIC, the "nobody
> care irq storm" happens.
> 
> So disable the pcie hotplug CCIE/HPIE interrupt in early boot phase when
> MSI is not enbaled.

So I think this issue should go away if disabling the interrupt
by portdrv is no longer conditional on

  (pcie_ports_native || host->native_pcie_hotplug)

like I've just proposed here:

  https://lore.kernel.org/r/Z6HYuBDP6uvE1Sf4@wunner.de/

... in which case this patch won't be necessary.  Can you confirm that?

You can split the change I've proposed into two patches if you like.

Thanks,

Lukas

