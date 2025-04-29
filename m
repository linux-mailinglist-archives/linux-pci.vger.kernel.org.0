Return-Path: <linux-pci+bounces-27008-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62820AA1030
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 17:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D7A17E9A4
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 15:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF7821A931;
	Tue, 29 Apr 2025 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fRyfNvU+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF4E86353;
	Tue, 29 Apr 2025 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745939888; cv=none; b=aRVFlNdLJZGkBSlOS7QpqAurScwK0vpiOQPm7+gY9Vf2fx1Ocxeed3OGrY+m7/C4TZWz/e/NDzS6fJOFniEWMHgZYlU6fxsfV5EhK0WZPGgZiIe+3aNfik9AepjPJZkwIQf2Cse/Oec7Wh4hGXD41LL0FQLxZzgBBnREfWQ/Sxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745939888; c=relaxed/simple;
	bh=eecOB+yza2VBlUNFUBMvCXQCeauh9eBhljBtJcKms6k=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ioysM9AL+/oqYe/gToIo68iMg39yV3pFW0NAQCOJ6c/0vUeywKgbnDv1hF5k3y3mszuJWhJfRXv0S8qfkRENhbbTfnFzdnOpqQdIgQta6cBi+paTVfAQw9SX6Sh69c42yhq8QP/DTS1wbdgWMhBWeJ5T7iNCVKhu4t49lIMt6jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fRyfNvU+; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745939887; x=1777475887;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=eecOB+yza2VBlUNFUBMvCXQCeauh9eBhljBtJcKms6k=;
  b=fRyfNvU+Ec2BCGTLms55eh2n+VkfjA5v1AAqzctlnT+U6GgYm5xLcDQo
   XJHSzyYz4OryoY87CDYRwu28NifTnsYBbimjSh6Gag6e0/Pu9CGRshRox
   OncBk5gbL9hX97x1QCRy3rii+ljh+JF1n+Lfo5tLr8zDKvl3VV+FqFN7R
   +BiP+DmfVB3cs25Y35WoWtlnF1I0ciaPnsavrj0gcPMTKa+sp3BpmliNY
   nVimxgc72Jv10/JIbIR/V6wuKBgihUWjrPHalODd8y9LIEa/yP70yNwL7
   04+wWpVxiGnNCVv9SLhASmKPsSsW5OGxR6DFHM4LEgLYgW6ihzTTSSIj4
   Q==;
X-CSE-ConnectionGUID: pAUSJRGqT5qf4ZCNXCsFwQ==
X-CSE-MsgGUID: Ov3JY70jRSCtFoS9i4uK7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="64983260"
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; 
   d="scan'208";a="64983260"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 08:18:05 -0700
X-CSE-ConnectionGUID: js3vkXVfS8+l3LLV9MNaUQ==
X-CSE-MsgGUID: pW26e30nQzOP1v0/eOzgaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; 
   d="scan'208";a="138659653"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.205])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 08:18:01 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 29 Apr 2025 18:17:57 +0300 (EEST)
To: Hans Zhang <18255117159@163.com>
cc: lpieralisi@kernel.org, bhelgaas@google.com, 
    manivannan.sadhasivam@linaro.org, kw@linux.com, cassel@kernel.org, 
    robh@kernel.org, jingoohan1@gmail.com, thomas.richard@bootlin.com, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 2/6] PCI: Clean up __pci_find_next_cap_ttl()
 readability
In-Reply-To: <20250429125036.88060-3-18255117159@163.com>
Message-ID: <66cdb108-80f5-fe7c-329b-8c60caf55b64@linux.intel.com>
References: <20250429125036.88060-1-18255117159@163.com> <20250429125036.88060-3-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 29 Apr 2025, Hans Zhang wrote:

> Refactor the __pci_find_next_cap_ttl() to improve code clarity:
> - Replace magic number 0x40 with PCI_STD_HEADER_SIZEOF.
> - Use ALIGN_DOWN() for position alignment instead of manual bitmask.
> - Extract PCI capability fields via FIELD_GET() with standardized masks.
> - Add necessary headers (linux/align.h, uapi/linux/pci_regs.h).
> 
> The changes are purely non-functional cleanups, ensuring behavior remains
> identical to the original implementation.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
> Changes since v9:
> - None
> 
> Changes since v8:
> - Split into patch 1/6, patch 2/6.
> - The
>  drivers/pci/pci.c             | 10 ++++++----
>  include/uapi/linux/pci_regs.h |  2 ++
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 4d7c9f64ea24..1c29e8f20cb5 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -9,6 +9,7 @@
>   */
>  
>  #include <linux/acpi.h>
> +#include <linux/align.h>
>  #include <linux/kernel.h>
>  #include <linux/delay.h>
>  #include <linux/dmi.h>
> @@ -30,6 +31,7 @@
>  #include <asm/dma.h>
>  #include <linux/aer.h>
>  #include <linux/bitfield.h>
> +#include <uapi/linux/pci_regs.h>

linux/pci.h will pull this in through <uapi/linux/pci.h> so you don't need 
to add it (basically anywhere).

>  #include "pci.h"
>  
>  DEFINE_MUTEX(pci_slot_mutex);
> @@ -432,17 +434,17 @@ static u8 __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
>  	pci_bus_read_config_byte(bus, devfn, pos, &pos);
>  
>  	while ((*ttl)--) {
> -		if (pos < 0x40)
> +		if (pos < PCI_STD_HEADER_SIZEOF)
>  			break;
> -		pos &= ~3;
> +		pos = ALIGN_DOWN(pos, 4);
>  		pci_bus_read_config_word(bus, devfn, pos, &ent);
>  
> -		id = ent & 0xff;
> +		id = FIELD_GET(PCI_CAP_ID_MASK, ent);
>  		if (id == 0xff)
>  			break;
>  		if (id == cap)
>  			return pos;
> -		pos = (ent >> 8);
> +		pos = FIELD_GET(PCI_CAP_LIST_NEXT_MASK, ent);
>  	}
>  	return 0;
>  }
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index ba326710f9c8..b59179e1210a 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -206,6 +206,8 @@
>  /* 0x48-0x7f reserved */
>  
>  /* Capability lists */
> +#define PCI_CAP_ID_MASK		0x00ff
> +#define PCI_CAP_LIST_NEXT_MASK	0xff00

Consider adding a comment after the value as is done for most  defines in 
this file.

>  
>  #define PCI_CAP_LIST_ID		0	/* Capability ID */
>  #define  PCI_CAP_ID_PM		0x01	/* Power Management */
> 

-- 
 i.


