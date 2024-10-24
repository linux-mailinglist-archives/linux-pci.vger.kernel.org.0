Return-Path: <linux-pci+bounces-15196-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A589AE637
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 15:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DF82B22FB1
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 13:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1370B1E1A35;
	Thu, 24 Oct 2024 13:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T68BxWLG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B6B1DEFE9;
	Thu, 24 Oct 2024 13:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729776248; cv=none; b=uZS8OG6zTLsFHcO5SZBW4vqCVlwEtpbN8jMduQfU3FrwSlCRjyIHkj+Bs4LwfurgS6BAWWlMCWDp7pkSfmKGnhnJ9Fa2+4GyUnLEVZo2FXwwiBeuczIczjYpsUadPblItJYCbkabqbcFLTHOTc7HofYRiOqGF8nh516VoWwR0/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729776248; c=relaxed/simple;
	bh=NeuoC9MTC9njOycNZWvXAlTKIYyLsuUeJR6TpOD4vhI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=q6DTTCgDWaNm9F2QZ+fVyhVUXBumB5X9l4MCI2F/hzBFibgEiP9EBUpnV8w1hFXmjpoeTvSEVwTAaGKj4D+X1aDP/m1RJI3ZxcZT+KXhbl9/Y5TDy6LUYmhcDhIHTsV/EyJAuxkmxBgkyDZozQMQ/pYs3kZZyBxeTlLz4kFbR+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T68BxWLG; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729776246; x=1761312246;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NeuoC9MTC9njOycNZWvXAlTKIYyLsuUeJR6TpOD4vhI=;
  b=T68BxWLGWZpcZ+k89YWGtf/W+hnEcM4lSFNAO9Dwf6WqKDcON/aZ69Md
   yu78nILFGeZCuBwoHlpjIX0FJFvec2QswNQSryA4hg3QDbSw5Kn8o77Ew
   Ao9WJ+LF/b1OrO1B69WzX+LaTLXCMfawClhr9xe1y3PyoaJdNs/y9xvHI
   SsNnCjMSjYJNf1QDLLruS9Ge1NzwCwCRIuri3v+3un2Uhqz23F+VrVcke
   PxwXmV9cSzE5waZHyRbmUZlhW5ZM31AW5cxGqbD6gZohlsn/Kl5SMiid3
   Pj8aLN/v94L8WdvJmeldtKIHMM4KHBpZHvfQ0R63mTQ8Jb3M9ynYYT7QR
   Q==;
X-CSE-ConnectionGUID: L4asPT50RqeeCTs9gX2LmQ==
X-CSE-MsgGUID: ngmH9gqsSWe6KsjwFPTuPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29507590"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="29507590"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 06:24:06 -0700
X-CSE-ConnectionGUID: 6u3OCSzuSd6YgvP5NDAIRQ==
X-CSE-MsgGUID: HmDwd8NMS8+AubuzZCnB3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="85375663"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.193])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 06:24:00 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 24 Oct 2024 16:23:55 +0300 (EEST)
To: Yazen Ghannam <yazen.ghannam@amd.com>
cc: linux-edac@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com, 
    john.allen@amd.com, mario.limonciello@amd.com, bhelgaas@google.com, 
    Shyam-sundar.S-k@amd.com, richard.gong@amd.com, jdelvare@suse.com, 
    linux@roeck-us.net, clemens@ladisch.de, 
    Hans de Goede <hdegoede@redhat.com>, linux-pci@vger.kernel.org, 
    linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
    naveenkrishna.chatradhi@amd.com, carlos.bilbao.osdev@gmail.com
Subject: Re: [PATCH 14/16] x86/amd_smn, platform/x86/amd/hsmp: Have HSMP use
 SMN
In-Reply-To: <20241023172150.659002-15-yazen.ghannam@amd.com>
Message-ID: <2797ecc5-935d-21a2-bb43-273a7eae3a12@linux.intel.com>
References: <20241023172150.659002-1-yazen.ghannam@amd.com> <20241023172150.659002-15-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 23 Oct 2024, Yazen Ghannam wrote:

> The HSMP interface is just an SMN interface with different offsets.
> 
> Define an HSMP wrapper in the SMN code and have the HSMP platform driver
> use that rather than a local solution.
> 
> Also, remove the "root" member from AMD_NB, since there are no more
> users of it.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  arch/x86/include/asm/amd_nb.h    |  1 -
>  arch/x86/include/asm/amd_smn.h   |  3 +++
>  arch/x86/kernel/amd_nb.c         |  1 -
>  arch/x86/kernel/amd_smn.c        |  9 +++++++++
>  drivers/platform/x86/amd/Kconfig |  2 +-
>  drivers/platform/x86/amd/hsmp.c  | 32 +++++---------------------------
>  6 files changed, 18 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
> index 55c03d3495bc..cbe31e316e39 100644
> --- a/arch/x86/include/asm/amd_nb.h
> +++ b/arch/x86/include/asm/amd_nb.h
> @@ -27,7 +27,6 @@ struct amd_l3_cache {
>  };
>  
>  struct amd_northbridge {
> -	struct pci_dev *root;
>  	struct pci_dev *misc;
>  	struct pci_dev *link;
>  	struct amd_l3_cache l3_cache;
> diff --git a/arch/x86/include/asm/amd_smn.h b/arch/x86/include/asm/amd_smn.h
> index 6850de69f863..f0eb12859c42 100644
> --- a/arch/x86/include/asm/amd_smn.h
> +++ b/arch/x86/include/asm/amd_smn.h
> @@ -8,4 +8,7 @@
>  int __must_check amd_smn_read(u16 node, u32 address, u32 *value);
>  int __must_check amd_smn_write(u16 node, u32 address, u32 value);
>  
> +/* Should only be used by the HSMP driver. */
> +int __must_check amd_smn_hsmp_rdwr(u16 node, u32 address, u32 *value, bool write);
> +
>  #endif /* _ASM_X86_AMD_SMN_H */
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index 10cdeddeda02..4c22317a6dfe 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -73,7 +73,6 @@ static int amd_cache_northbridges(void)
>  	amd_northbridges.nb = nb;
>  
>  	for (i = 0; i < amd_northbridges.num; i++) {
> -		node_to_amd_nb(i)->root = amd_node_get_root(i);
>  		node_to_amd_nb(i)->misc = amd_node_get_func(i, 3);
>  		node_to_amd_nb(i)->link = amd_node_get_func(i, 4);
>  	}
> diff --git a/arch/x86/kernel/amd_smn.c b/arch/x86/kernel/amd_smn.c
> index 997fd3edd9c0..527dda8e3a2b 100644
> --- a/arch/x86/kernel/amd_smn.c
> +++ b/arch/x86/kernel/amd_smn.c
> @@ -18,6 +18,9 @@ static DEFINE_MUTEX(smn_mutex);
>  #define SMN_INDEX_OFFSET	0x60
>  #define SMN_DATA_OFFSET		0x64
>  
> +#define HSMP_INDEX_OFFSET	0xc4
> +#define HSMP_DATA_OFFSET	0xc8
> +
>  /*
>   * SMN accesses may fail in ways that are difficult to detect here in the called
>   * functions amd_smn_read() and amd_smn_write(). Therefore, callers must do
> @@ -100,6 +103,12 @@ int __must_check amd_smn_write(u16 node, u32 address, u32 value)
>  }
>  EXPORT_SYMBOL_GPL(amd_smn_write);
>  
> +int __must_check amd_smn_hsmp_rdwr(u16 node, u32 address, u32 *value, bool write)
> +{
> +	return __amd_smn_rw(HSMP_INDEX_OFFSET, HSMP_DATA_OFFSET, node, address, value, write);
> +}
> +EXPORT_SYMBOL_GPL(amd_smn_hsmp_rdwr);
> +
>  static int amd_cache_roots(void)
>  {
>  	u16 node, num_nodes = amd_num_nodes();
> diff --git a/drivers/platform/x86/amd/Kconfig b/drivers/platform/x86/amd/Kconfig
> index f88682d36447..e100b315c62b 100644
> --- a/drivers/platform/x86/amd/Kconfig
> +++ b/drivers/platform/x86/amd/Kconfig
> @@ -8,7 +8,7 @@ source "drivers/platform/x86/amd/pmc/Kconfig"
>  
>  config AMD_HSMP
>  	tristate "AMD HSMP Driver"
> -	depends on AMD_NB && X86_64 && ACPI
> +	depends on AMD_SMN && X86_64 && ACPI
>  	help
>  	  The driver provides a way for user space tools to monitor and manage
>  	  system management functionality on EPYC server CPUs from AMD.
> diff --git a/drivers/platform/x86/amd/hsmp.c b/drivers/platform/x86/amd/hsmp.c
> index 8fcf38eed7f0..544efb0255c0 100644
> --- a/drivers/platform/x86/amd/hsmp.c
> +++ b/drivers/platform/x86/amd/hsmp.c

FYI, there has been major restructuring done for this driver in 
pdx86/for-next.

-- 
 i.

> @@ -10,7 +10,7 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <asm/amd_hsmp.h>
> -#include <asm/amd_nb.h>
> +#include <asm/amd_smn.h>
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/miscdevice.h>
> @@ -48,9 +48,6 @@
>  #define SMN_HSMP_MSG_RESP	0x0010980
>  #define SMN_HSMP_MSG_DATA	0x00109E0
>  
> -#define HSMP_INDEX_REG		0xc4
> -#define HSMP_DATA_REG		0xc8
> -
>  #define HSMP_CDEV_NAME		"hsmp_cdev"
>  #define HSMP_DEVNODE_NAME	"hsmp"
>  #define HSMP_METRICS_TABLE_NAME	"metrics_bin"
> @@ -62,8 +59,6 @@
>  #define MSG_ARGOFF_STR		"MsgArgOffset"
>  #define MSG_RESPOFF_STR		"MsgRspOffset"
>  
> -#define MAX_AMD_SOCKETS 8
> -
>  struct hsmp_mbaddr_info {
>  	u32 base_addr;
>  	u32 msg_id_off;
> @@ -79,7 +74,6 @@ struct hsmp_socket {
>  	void __iomem *virt_base_addr;
>  	struct semaphore hsmp_sem;
>  	char name[HSMP_ATTR_GRP_NAME_SIZE];
> -	struct pci_dev *root;
>  	struct device *dev;
>  	u16 sock_ind;
>  };
> @@ -98,20 +92,7 @@ static struct hsmp_plat_device plat_dev;
>  static int amd_hsmp_pci_rdwr(struct hsmp_socket *sock, u32 offset,
>  			     u32 *value, bool write)
>  {
> -	int ret;
> -
> -	if (!sock->root)
> -		return -ENODEV;
> -
> -	ret = pci_write_config_dword(sock->root, HSMP_INDEX_REG,
> -				     sock->mbinfo.base_addr + offset);
> -	if (ret)
> -		return ret;
> -
> -	ret = (write ? pci_write_config_dword(sock->root, HSMP_DATA_REG, *value)
> -		     : pci_read_config_dword(sock->root, HSMP_DATA_REG, value));
> -
> -	return ret;
> +	return amd_smn_hsmp_rdwr(sock->sock_ind, sock->mbinfo.base_addr + offset, value, write);
>  }
>  
>  static void amd_hsmp_acpi_rdwr(struct hsmp_socket *sock, u32 offset,
> @@ -749,10 +730,7 @@ static int init_platform_device(struct device *dev)
>  	int ret, i;
>  
>  	for (i = 0; i < plat_dev.num_sockets; i++) {
> -		if (!node_to_amd_nb(i))
> -			return -ENODEV;
>  		sock = &plat_dev.sock[i];
> -		sock->root			= node_to_amd_nb(i)->root;
>  		sock->sock_ind			= i;
>  		sock->dev			= dev;
>  		sock->mbinfo.base_addr		= SMN_HSMP_BASE;
> @@ -946,11 +924,11 @@ static int __init hsmp_plt_init(void)
>  	int ret = -ENODEV;
>  
>  	/*
> -	 * amd_nb_num() returns number of SMN/DF interfaces present in the system
> +	 * amd_num_nodes() returns number of SMN/DF interfaces present in the system
>  	 * if we have N SMN/DF interfaces that ideally means N sockets
>  	 */
> -	plat_dev.num_sockets = amd_nb_num();
> -	if (plat_dev.num_sockets == 0 || plat_dev.num_sockets > MAX_AMD_SOCKETS)
> +	plat_dev.num_sockets = amd_num_nodes();
> +	if (plat_dev.num_sockets == 0 || plat_dev.num_sockets > MAX_AMD_NUM_NODES)
>  		return ret;
>  
>  	ret = platform_driver_register(&amd_hsmp_driver);
> 

