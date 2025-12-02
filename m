Return-Path: <linux-pci+bounces-42538-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7937FC9D5C5
	for <lists+linux-pci@lfdr.de>; Wed, 03 Dec 2025 00:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B11A4E0223
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 23:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5982302CAE;
	Tue,  2 Dec 2025 23:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrCPifiT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797B43009FC;
	Tue,  2 Dec 2025 23:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764719079; cv=none; b=ELBWDMGViZEkUkbupTave+Zv2YlaED1H1TMeNfTBT6Vhb5dKWCejncLDbJf39BN+oM+gz4XIyI485O0FDE5VIUfL37CtWGb+KCgbO3KIWIyH6ZEAWqI1WIP1M315jKQG4KG9oAxE8C7FKxMii/dGwy0CltQ6bwimrZELluwLPRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764719079; c=relaxed/simple;
	bh=RPPsGXG/goo2TScWBKowvKavIkqW/P5ObuG8brhUpa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9gLv/pjgsyeBEWhk+CFsWrtyyEGffU0jalnNKEjpJHS1+bHVvlnsNdpeCXnwYdIrsXr9baOoMqKEQpxO48TaT1bNOH4ftOwaX+q2J4Bx8UoD/g3S+l52qZ5dnGP076GZ3VIaEIxyev7IgFX/ksbVm1VqrR4w1jcJcgnZZ1Pxzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrCPifiT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6BDC4CEF1;
	Tue,  2 Dec 2025 23:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764719079;
	bh=RPPsGXG/goo2TScWBKowvKavIkqW/P5ObuG8brhUpa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FrCPifiTxCVTM6AudIDNinw2f9F2ilywFu57kZaCe1EeWWFglTM1dG/nCw/0+UAEe
	 3SKvgVryRs3K68WE9m4jqu5Umye2Kj5i9ngKIb+Cv7kLn9dEtR5QiDzDa4hVQqZUq4
	 /nrndOUZ1O7aURCDgkdwTt6XuCkjs1avKOdrG1k8kkCwDTqVkQwd8OjqxlZkc/Oe7a
	 5F6iUJFs/locvAjADygjmIqncgfTa8cLcPOLLhSx48hrPMxG/lJll7Q7H/QhaBspuG
	 hWmERbMywbWBFpySJPHYuiPrxv58PmAHOBURqgD3HAQFXhgCsyxlWMm1kZJVH6m4PP
	 HRp1yFyJ2XoYw==
Date: Tue, 2 Dec 2025 16:44:35 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-pci@vger.kernel.org, linux-coco@lists.linux.dev,
	Jonathan.Cameron@huawei.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 1/8] drivers/virt: Drop VIRT_DRIVERS build dependency
Message-ID: <20251202234435.GA1692217@ax162>
References: <20251113021446.436830-1-dan.j.williams@intel.com>
 <20251113021446.436830-2-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113021446.436830-2-dan.j.williams@intel.com>

Hi Dan,

On Wed, Nov 12, 2025 at 06:14:39PM -0800, Dan Williams wrote:
> All of the objects in drivers/virt/ have their own configuration symbols to
> gate compilation. I.e. nothing gets added to the kernel with
> CONFIG_VIRT_DRIVERS=y in isolation.
> 
> Unconditionally descend into drivers/virt/ so that consumers do not need to
> add an additional CONFIG_VIRT_DRIVERS dependency.
> 
> Fix warnings of the form:
> 
>     Kconfig warnings: (for reference only)
>        WARNING: unmet direct dependencies detected for TSM
>        Depends on [n]: VIRT_DRIVERS [=n]
>        Selected by [y]:
>        - PCI_TSM [=y] && PCI [=y]

I can still trigger this warning on next-20251202, which contains this
change as commit 110c155e8a68 ("drivers/virt: Drop VIRT_DRIVERS build
dependency").

  $ git merge-base --is-ancestor 110c155e8a684d8b2423a72cfde147903881f765 HEAD
    echo $status
  0

  $ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux- clean defconfig

  $ scripts/config -e PCI_TSM

  $ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux- olddefconfig
  WARNING: unmet direct dependencies detected for TSM
    Depends on [n]: VIRT_DRIVERS [=n]
    Selected by [y]:
    - PCI_TSM [=y] && PCI [=y]

I would think you would need something like this avoid the problem but I
am not sure if it would be acceptable, hence just the report.

Cheers,
Nathan

diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index d8c848cf09a6..52eb7e4ba71f 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -47,6 +47,6 @@ source "drivers/virt/nitro_enclaves/Kconfig"
 
 source "drivers/virt/acrn/Kconfig"
 
-source "drivers/virt/coco/Kconfig"
-
 endif
+
+source "drivers/virt/coco/Kconfig"
diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
index bb0c6d6ddcc8..df1cfaf26c65 100644
--- a/drivers/virt/coco/Kconfig
+++ b/drivers/virt/coco/Kconfig
@@ -3,6 +3,7 @@
 # Confidential computing related collateral
 #
 
+if VIRT_DRIVERS
 source "drivers/virt/coco/efi_secret/Kconfig"
 
 source "drivers/virt/coco/pkvm-guest/Kconfig"
@@ -14,6 +15,7 @@ source "drivers/virt/coco/tdx-guest/Kconfig"
 source "drivers/virt/coco/arm-cca-guest/Kconfig"
 
 source "drivers/virt/coco/guest/Kconfig"
+endif
 
 config TSM
 	bool

