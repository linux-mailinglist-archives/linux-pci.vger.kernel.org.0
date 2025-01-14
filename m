Return-Path: <linux-pci+bounces-19797-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE31A115A6
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 00:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE88C3A3808
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 23:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D2C21423A;
	Tue, 14 Jan 2025 23:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZF2esIB/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C994414883C;
	Tue, 14 Jan 2025 23:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736898663; cv=none; b=lLnRgZTG9tyJ12kJwkFHl7T39slHB06ZkH6FJUCuNJi+6b7irdbT8+QxioXlQlR+ivUajTDHylDQNGvigNO7wF6SKie7daCNV/lk5PIX0CICiokaXTR4J1ngPaFLgETp9iBMJH+nkQlWeale1SlXNqc9nvps/9nYYzI7idirJds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736898663; c=relaxed/simple;
	bh=waaozwHAhhKkmwVx8uOafsSyb6MsS7BcvNldbx4m4EY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HXGmg/Mx7HWFfYK8DePKrTx0nbnHeV+rHd81yTvTlB/tXTkPLqt8sniaXSYUT9pALdsxQHwpcPIQke1966CAN27KQFWCLwbtFmOYLH+e75coJ1OimISqduHJRE+KU0ec151oGvOCBDz3Dg9nn5fxB4v/Iwdl64m2Thb5s8EMW9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZF2esIB/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3208EC4CEDD;
	Tue, 14 Jan 2025 23:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736898663;
	bh=waaozwHAhhKkmwVx8uOafsSyb6MsS7BcvNldbx4m4EY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZF2esIB/dzyq+77rWYSifyTfLbdQOyk1S3D9YVYg9k2RbSXQDbUvF8gQtrfq+3WXt
	 A1wXQVGuWpj9JGv4XuN8aNZI1Ri7NnxCl3UHOFNfhDtLInO2ed29YYmvN5VxsEcHRP
	 xVOKsSh2jbKGRiEob8USkGuCLs/EQx9I5JdptDzEbOAbaf7jQxqHvG0FuI0Horoda2
	 mlPymWepIVjtRduF3YodcSt7xuJ1Dho/LWNk/QR6hCv2gpEwB++TgSHdK5zU7DF8JA
	 rCjxZS/QzvpB8B2c/nW/9ulMjH3l/B0N3aRP/NLKEs/NYcpolZZJVZsAtPpAt3WAoO
	 pAJqPWi6o1VpQ==
Date: Tue, 14 Jan 2025 17:51:01 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lukas Wunner <lukas@wunner.de>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v9 0/8] PCI: Consolidate TLP Log reading and printing
Message-ID: <20250114235101.GA507662@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250114170840.1633-1-ilpo.jarvinen@linux.intel.com>

On Tue, Jan 14, 2025 at 07:08:32PM +0200, Ilpo Järvinen wrote:
> This series has the remaining patches of the AER & DPC TLP Log handling
> consolidation and now includes a few minor improvements to the earlier
> accepted TLP Logging code.
> 
> v9:
> - Added patch to define header logging register sizes.
> 
> v8:
> - Added missing parameter to kerneldoc.
> - Dropped last patch due to conflict with the pci_printk() cleanup
>   series (will move the patch into that series).
> 
> v7:
> - Explain in commit message reasoning why eetlp_prefix_max stores Max
>   End-End TLP Prefixes value instead of limiting it by the bridge/RP
>   imposed limits
> - Take account TLP Prefix Log Present flag.
> - Align PCI_ERR_CAP_* flags in pci_regs.h
> - Add EE_PREFIX_STR define to be able to take its sizeof() for output
>   char[] sizing.
> 
> v6:
> - Preserve "AER:"/"DPC:" prefix on the printed TLP line
> - New patch to add "AER:" also  on other lines of the AER error dump
> 
> v5:
> - Fix build with AER=y and DPC=n
> - Match kerneldoc and function parameter name
> 
> v4:
> - Added patches:
> 	- Remove EXPORT of pcie_read_tlp_log()
> 	- Moved code to pcie/tlp.c and build only with AER enabled
> 	- Match variables in prototype and function
> 	- int -> unsigned int conversion
> 	- eetlp_prefix_max into own patch
> - struct pcie_tlp_log param consistently called "log" within tlp.c
> - Moved function prototypes into drivers/pci/pci.h
> - Describe AER/DPC differences more clearly in one commit message
> 
> v3:
> - Small rewording in a commit message
> 
> v2:
> - Don't add EXPORT()s
> - Don't include igxbe changes
> - Don't use pr_cont() as it's incompatible with pci_err() and according
>   to Andy Shevchenko should not be used in the first place
> 
> 
> Ilpo Järvinen (8):
>   PCI: Don't expose pcie_read_tlp_log() outside of PCI subsystem
>   PCI: Move TLP Log handling to own file
>   PCI: Add defines for TLP Header/Prefix log sizes
>   PCI: Make pcie_read_tlp_log() signature same
>   PCI: Use unsigned int i in pcie_read_tlp_log()
>   PCI: Store # of supported End-End TLP Prefixes
>   PCI: Add TLP Prefix reading into pcie_read_tlp_log()
>   PCI: Create helper to print TLP Header and Prefix Log
> 
>  drivers/pci/ats.c             |   2 +-
>  drivers/pci/pci.c             |  28 ---------
>  drivers/pci/pci.h             |   9 +++
>  drivers/pci/pcie/Makefile     |   2 +-
>  drivers/pci/pcie/aer.c        |  15 ++---
>  drivers/pci/pcie/dpc.c        |  22 +++----
>  drivers/pci/pcie/tlp.c        | 115 ++++++++++++++++++++++++++++++++++
>  drivers/pci/probe.c           |  14 +++--
>  drivers/pci/quirks.c          |   6 +-
>  include/linux/aer.h           |  12 +++-
>  include/linux/pci.h           |   2 +-
>  include/uapi/linux/pci_regs.h |  11 ++--
>  12 files changed, 172 insertions(+), 66 deletions(-)
>  create mode 100644 drivers/pci/pcie/tlp.c

Applied to pci/err for v6.14, thanks!

