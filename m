Return-Path: <linux-pci+bounces-39454-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D66C9C0F9A8
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 18:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E8EF426E66
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 17:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E772C08B1;
	Mon, 27 Oct 2025 17:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMSByuf1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA4F533D6;
	Mon, 27 Oct 2025 17:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761585417; cv=none; b=AAr+qKBeiA9kBGFAlDhrVN9Fb5LVQETg/CQCVYiW5ecN1zzLA+7+wFXMGxNs2BjtAKGNrCteTn9n6SiF+koAq7788VTRPQm1NyjGnmX/hDtKLXVc0lx/kXxeIBfknAVC4kdt2Aqo4tMxe2gm02nfEaCdLim6M3YYLVLT8WvXdFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761585417; c=relaxed/simple;
	bh=K1bFME1YwxBWeHwosnw8XIUjA72KfTmc5TM047ROWSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggriOsGNjndY1XgfkbJGp2JkO+WU1Z32BR7HdQFgDivWryHlFta60xFf3P9HP8WrVgxiYuYAw7LJ+JM/NYFdh5qHGlZaBLXAM//7+9yVOIrRsDArK4OLh9R6+K5xOPNxnakIRUS7wQzi/qMZIxwNsmx5MEPJ6gj6oPmQe33cRwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMSByuf1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28CD2C4CEF1;
	Mon, 27 Oct 2025 17:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761585417;
	bh=K1bFME1YwxBWeHwosnw8XIUjA72KfTmc5TM047ROWSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DMSByuf1XXLf6Au6aUnYfG8bCLuACMGK+V/EGr2eAht+Ze7wXl3t+5PQgFt5rNvOA
	 QcSEdmGF48Bc8LvQIXi35kcAzQmWAlDaQKyTNIJerMIco/ojAxMHIyePWfLgYKDUyv
	 16cylK7lbdQemQb5e+rbyfSCU1IGPhEIAW6jV3D5ke868yQ4gNVNT02wETLIxTh803
	 gfixUVu/j5iMM+UCcwQHF/TEvHaEU6k1QSXr+JZ+poh9xObE43MTugOy9ueeFV4/DO
	 HrD+cmM4GtL7wiW3EUdHOqPjDDrUj+fI1VsAvH3zBjVa47AlL+d6ylQbx0cuSphZ+p
	 fmaZO7/UmR5eA==
Date: Mon, 27 Oct 2025 22:46:47 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>, Shuan He <heshuan@bytedance.com>
Subject: Re: [PATCH] PCI/sysfs: enforce single creation of sysfs entry for
 pdev
Message-ID: <nst6vubi5f4izjlxahspirg2agar5szmfczfknhiyzb36srfo7@uyzu4k52eoyt>
References: <20251013223720.8157-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251013223720.8157-1-ansuelsmth@gmail.com>

On Tue, Oct 14, 2025 at 12:37:16AM +0200, Christian Marangi wrote:

+ Krzysztof Wilczyński, Shuan He (since they were involved in similar discussion
before)

> In some specific scenario it's possible that the
> pci_create_resource_files() gets called multiple times and the created
> entry actually gets wrongly deleted with extreme case of having a NULL
> pointer dereference when the PCI is removed.
> 
> This mainly happen due to bad timing where the PCI bus is adding PCI
> devices and at the same time the sysfs code is adding the entry causing
> double execution of the pci_create_resource_files function and kernel
> WARNING.
> 
> To be more precise there is a race between the late_initcall of
> pci-sysfs with pci_sysfs_init and PCI bus.c pci_bus_add_device that also
> call pci_create_sysfs_dev_files.
> 
> With correct amount of ""luck"" (or better say bad luck)
> pci_create_sysfs_dev_files in bus.c might be called with pci_sysfs_init
> is executing the loop.
> 
> This has been reported multiple times and on multiple system, like imx6
> system, ipq806x systems...
> 

Yes. More recently on the RISC-V platform:
https://lore.kernel.org/linux-pci/20250702155112.40124-1-heshuan@bytedance.com/

> To address this, imlement multiple improvement to the implementation:
> 1. Add a bool to pci_dev to flag when sysfs entry are created
>    (sysfs_init)
> 2. Implement a simple completion to wait pci_sysfs_init execution.
> 3. Permit additional call of pci_create_sysfs_dev_files only after
>    pci_sysfs_init has finished.
> 
> With such logic in place, we address al kind of timing problem with
> minimal change to any driver.
> 

We do have the same issue with pci_proc_attach_device() as well. I submitted a
dumb series [1] that removed both pci_create_sysfs_dev_files() and
pci_proc_attach_device() calls from their _init() calls, but I was pointed out
that they are required for PCI_ROM_RESOURCE.

Then it was suggested that making the sysfs resource files static would be
the proper solution (not sure what's about proc). Krzysztof had some work on
this topic earlier and had plans to revive it, but I guess he didn't get much
time so far.

Krzysztof, if you do not mind, could you please share your previous work so that
someone else can try to extend it if you are busy?

- Mani

[1] https://lore.kernel.org/linux-pci/20250723111124.13694-1-manivannan.sadhasivam@oss.qualcomm.com

-- 
மணிவண்ணன் சதாசிவம்

