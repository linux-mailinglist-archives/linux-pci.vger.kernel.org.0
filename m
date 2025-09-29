Return-Path: <linux-pci+bounces-37210-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA512BA9C0F
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 17:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64E703AD88C
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 15:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321F9306B08;
	Mon, 29 Sep 2025 15:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMtQQ9ko"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F102126F2BD;
	Mon, 29 Sep 2025 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759158270; cv=none; b=aXTVIwSTcNQr8/gA1gmld+AH810yKki5HY+pFgpp+6PfsLesMYx4q3Ryo08Xl12PV7f60pmx1c54sAofVppTs6nyXRoaRdcicjMugy5k+BfkMAZ+j4uJoi/kPRy4803fl+wlDhVMr0mLp0HCgkNdMfvUUMZqOigEX4Xn7e43qlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759158270; c=relaxed/simple;
	bh=WgLOirqnRuyUHkGKrX+OqYLUKjAVPYcz7Hc+OWcmhyk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dSnERQhl+3lcYhu4vKHDiwUaO4adOrogAL/GmMKLTPMKrjrga6FVVcXzuPqSSW+ySz4OR37+AtfYZYMYJryvvY576Y0dYoL+VI2z+UD3bdkka3f+yAyaiIvUJKEgY2Oxem+i8kwa+vWNgP6mrXKaBYtqMNVCMYA1RAsquONicrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMtQQ9ko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256D7C4CEF4;
	Mon, 29 Sep 2025 15:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759158268;
	bh=WgLOirqnRuyUHkGKrX+OqYLUKjAVPYcz7Hc+OWcmhyk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KMtQQ9koq4ya3jXNewcZz5hHqHUlZALafDT20H6VyPac1kR2ipc//bs4dPKZGiRCX
	 KoNdkcsuIexHTiM3gQdRiCgb+lIBYkz6Ig45lbRtZaYSittcKniqf9vyTS6MOPuB8F
	 UhklAWkuTyrAYh2t7ms2vle4v5Tqrwh03w6n7W4tjAVrUb3t5DAdfK4S8fkWiLprnE
	 YSQgrc+1+uVgNggUAfOK/wP7s5Nc0wA+pnJyM/9JcAbydcaLWkUQmDiwKnzvq8gZCP
	 Tc/XK68gyK4SUVZN+v2rwgO5ejI2P/H/dPdA12/kfRepjqsqOH7jOmH39uXXh2qRy/
	 od3BcG4ITAEAw==
Date: Mon, 29 Sep 2025 10:04:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Chris Li <chrisl@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 00/10] LUO: PCI subsystem (phase I)
Message-ID: <20250929150425.GA111624@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bAbB8YsheCwLi0ztY5LLWMyQ6He3sbYru697Ogq5+hR+Q@mail.gmail.com>

On Sat, Sep 27, 2025 at 02:05:38PM -0400, Pasha Tatashin wrote:
> Hi Bjorn,
> 
> My latest submission is the following:
> https://lore.kernel.org/all/20250807014442.3829950-1-pasha.tatashin@soleen.com/
> 
> And github repo is in cover letter:
> 
> https://github.com/googleprodkernel/linux-liveupdate/tree/luo/v3
> 
> It applies cleanly against the mainline without the first three
> patches, as they were already merged.

Not sure what I'm missing.  I've tried various things but none apply
cleanly:

  $ git remote add luo https://github.com/googleprodkernel/linux-liveupdate.git
  $ git fetch luo
  From https://github.com/googleprodkernel/linux-liveupdate
   * [new branch]                hack_pci_pf_stub_demo -> luo/hack_pci_pf_stub_demo
   * [new branch]                iommu/rfc-v1          -> luo/iommu/rfc-v1
   * [new branch]                kho/v5                -> luo/kho/v5
   * [new branch]                kho/v6                -> luo/kho/v6
   * [new branch]                kho/v7                -> luo/kho/v7
   * [new branch]                kho/v8                -> luo/kho/v8
   * [new branch]                lucx/v1               -> luo/lucx/v1
   * [new branch]                luo/kho-v8            -> luo/luo/kho-v8
   * [new branch]                luo/memfd-v0.1        -> luo/luo/memfd-v0.1
   * [new branch]                luo/rfc-v1            -> luo/luo/rfc-v1
   * [new branch]                luo/rfc-v2            -> luo/luo/rfc-v2
   * [new branch]                luo/v1                -> luo/luo/v1
   * [new branch]                luo/v2                -> luo/luo/v2
   * [new branch]                luo/v3                -> luo/luo/v3
   * [new branch]                luo/v4                -> luo/luo/v4
   * [new branch]                master                -> luo/master

  $ b4 am -om/ https://lore.kernel.org/r/20250916-luo-pci-v2-0-c494053c3c08@kernel.org
  Grabbing thread from lore.kernel.org/all/20250916-luo-pci-v2-0-c494053c3c08@kernel.org/t.mbox.gz
  Analyzing 13 messages in the thread
  Looking for additional code-review trailers on lore.kernel.org
  Checking attestation on all messages, may take a moment...
  ---
    ✓ [PATCH v2 1/10] PCI/LUO: Register with Liveupdate Orchestrator
    ✓ [PATCH v2 2/10] PCI/LUO: Create requested liveupdate device list
    ✓ [PATCH v2 3/10] PCI/LUO: Forward prepare()/freeze()/cancel() callbacks to driver
    ✓ [PATCH v2 4/10] PCI/LUO: Restore state at PCI enumeration
    ✓ [PATCH v2 5/10] PCI/LUO: Forward finish callbacks to drivers
    ✓ [PATCH v2 6/10] PCI/LUO: Save and restore driver name
    ✓ [PATCH v2 7/10] PCI/LUO: Add liveupdate to pcieport driver
    ✓ [PATCH v2 8/10] PCI/LUO: Add pci_liveupdate_get_driver_data()
    ✓ [PATCH v2 9/10] PCI/LUO: Avoid write to bus master at boot
    ✓ [PATCH v2 10/10] PCI: pci-lu-stub: Add a stub driver for Live Update testing
    ---
    ✓ Signed: DKIM/kernel.org
  ---
  Total patches: 10
  ---
  Cover: m/v2_20250916_chrisl_luo_pci_subsystem_phase_i.cover
   Link: https://lore.kernel.org/r/20250916-luo-pci-v2-0-c494053c3c08@kernel.org
   Base: base-commit 9ab803064e3d1be9673d2829785a69fd0578b24e not known, ignoring
   Base: not specified
	 git am m/v2_20250916_chrisl_luo_pci_subsystem_phase_i.mbx

  $ git checkout -b wip/2509-chris-luo-pci-v2 luo/luo/rfc-v2; git am m/v2_20250916_chrisl_luo_pci_subsystem_phase_i.mbx
  Updating files: 100% (21294/21294), done.
  branch 'wip/2509-chris-luo-pci-v2' set up to track 'luo/luo/rfc-v2'.
  Switched to a new branch 'wip/2509-chris-luo-pci-v2'
  Applying: PCI/LUO: Register with Liveupdate Orchestrator
  Applying: PCI/LUO: Create requested liveupdate device list
  Applying: PCI/LUO: Forward prepare()/freeze()/cancel() callbacks to driver
  Applying: PCI/LUO: Restore state at PCI enumeration
  Applying: PCI/LUO: Forward finish callbacks to drivers
  Applying: PCI/LUO: Save and restore driver name
  error: patch failed: drivers/pci/probe.c:2714
  error: drivers/pci/probe.c: patch does not apply
  Patch failed at 0006 PCI/LUO: Save and restore driver name
  hint: Use 'git am --show-current-patch=diff' to see the failed patch
  When you have resolved this problem, run "git am --continue".
  If you prefer to skip this patch, run "git am --skip" instead.
  To restore the original branch and stop patching, run "git am --abort".

  $ git checkout -b wip/2509-chris-luo-pci-v2 luo/luo/v2; git am m/v2_20250916_chrisl_luo_pci_subsystem_phase_i.mbx
  Updating files: 100% (12217/12217), done.
  branch 'wip/2509-chris-luo-pci-v2' set up to track 'luo/luo/v2'.
  Switched to a new branch 'wip/2509-chris-luo-pci-v2'
  Applying: PCI/LUO: Register with Liveupdate Orchestrator
  error: patch failed: MAINTAINERS:14014
  error: MAINTAINERS: patch does not apply
  Patch failed at 0001 PCI/LUO: Register with Liveupdate Orchestrator
  hint: Use 'git am --show-current-patch=diff' to see the failed patch
  When you have resolved this problem, run "git am --continue".
  If you prefer to skip this patch, run "git am --skip" instead.
  To restore the original branch and stop patching, run "git am --abort".

  $ git checkout -b wip/2509-chris-luo-pci-v2 luo/luo/v3; git am m/v2_20250916_chrisl_luo_pci_subsystem_phase_i.mbx
  branch 'wip/2509-chris-luo-pci-v2' set up to track 'luo/luo/v3'.
  Switched to a new branch 'wip/2509-chris-luo-pci-v2'
  Applying: PCI/LUO: Register with Liveupdate Orchestrator
  error: patch failed: MAINTAINERS:14014
  error: MAINTAINERS: patch does not apply
  Patch failed at 0001 PCI/LUO: Register with Liveupdate Orchestrator
  hint: Use 'git am --show-current-patch=diff' to see the failed patch
  When you have resolved this problem, run "git am --continue".
  If you prefer to skip this patch, run "git am --skip" instead.
  To restore the original branch and stop patching, run "git am --abort".


