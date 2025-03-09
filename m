Return-Path: <linux-pci+bounces-23198-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6BCA58051
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 03:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6EA83AA70F
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 02:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55EAC2FA;
	Sun,  9 Mar 2025 02:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DZD6WF0F"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B197E29B0;
	Sun,  9 Mar 2025 02:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741487955; cv=none; b=bOFNCCCW4u2szKmPnrNQ+bCkMTS1uU7godbubzL6hT32PxPPMC2+5rdMMJEfMEUZrBW+6a2hN5sB5I/gT6TgFlErDhFtAohp7P6X/btmfwXfOJMlPHSF5ctyHz6ICLsh8PoZibEYyJyx0IkjBeCmKHao6MCAnTWBuPO3D86091g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741487955; c=relaxed/simple;
	bh=UJasqy5JbugTN9l6LuKDna9yZBWsmyaJYNLnfmnYuCc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkddTmiU31Hf7YkuwftQ00yMUezGxZOrsrfJYGUgHA1V80hly0BOYtfRn20L//nw0fRkGpx219c4VBS+C4dVc/ynExIDDmaAKNEbTq2i0VgK6X+p/+5uDg99YNESqCAtlK+OJpylluIwibqRP2tsTtTFWV9Q69ibRq9b2b5IbBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DZD6WF0F; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5292cfeo076920
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 8 Mar 2025 20:38:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741487921;
	bh=pJVN+AQ19yCWW6/96Nn8te8YLXyUbINan32HfKWJ2rw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=DZD6WF0FCmYGN4JVRnzFtpupgSKLc8DD8koKWyH6GphB6CwhRnxeXUN5Hs1kbE8gg
	 0Fw/9oQb87uWdb3tuDSY+Ze3HGk5dxMA8oGIqNc2Ldv8bzub820smjosJEXfXXiipl
	 A9bvmBTiI19jxJ+n7KGMn6ch/1uL559+zv7zSPpg=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5292cf0B059943
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 8 Mar 2025 20:38:41 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 8
 Mar 2025 20:38:40 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 8 Mar 2025 20:38:40 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5292cdPF057956;
	Sat, 8 Mar 2025 20:38:40 -0600
Date: Sun, 9 Mar 2025 08:08:39 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Hans Zhang <18255117159@163.com>
CC: <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <bwawrzyn@cisco.com>, <s-vadapalli@ti.com>,
        <thomas.richard@bootlin.com>,
        <wojciech.jasko-EXT@continental-corporation.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [v2] PCI: cadence: Add configuration space capability search API
Message-ID: <20250309023839.2cakdpmsbzn6pm7g@uda0492258>
References: <20250308133903.322216-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250308133903.322216-1-18255117159@163.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sat, Mar 08, 2025 at 09:39:03PM +0800, Hans Zhang wrote:
> Add configuration space capability search API using struct cdns_pcie*
> pointer.
> 
> The offset address of capability or extended capability designed by
> different SOC design companies may not be the same. Therefore, a flexible
> public API is required to find the offset address of a capability or
> extended capability in the configuration space.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
> Changes since v1:
> https://lore.kernel.org/linux-pci/20250123070935.1810110-1-18255117159@163.com
> 
> - Added calling the new API in PCI-Cadence ep.c.
> - Add a commit message reason for adding the API.

In reply to your v1 patch, you have mentioned the following:
"Our controller driver currently has no plans for upstream and needs to
wait for notification from the boss."
at:
https://lore.kernel.org/linux-pci/fcfd4827-4d9e-4bcd-b1d0-8f9e349a6be7@163.com/

Since you have posted this patch, does it mean that you will be
upstreaming your driver as well? If not, we still end up in the same
situation as earlier where the Upstream Linux has APIs to support a
Downstream driver.

Bjorn indicated the above already at:
https://lore.kernel.org/linux-pci/20250123170831.GA1226684@bhelgaas/
and you did agree to do so. But this patch has no reference to the
upstream driver series which shall be making use of the APIs in this
patch.

Regards,
Siddharth.

