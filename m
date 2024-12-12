Return-Path: <linux-pci+bounces-18331-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC389EFB94
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 19:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6F516D230
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 18:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CED71891A8;
	Thu, 12 Dec 2024 18:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c/2eDDCN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA1017BB24;
	Thu, 12 Dec 2024 18:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029438; cv=none; b=F+/yqHI4rt/00CROuKOgQ4xLSA37SstOBFrw+K0xUfcZSXl7fzyK2tqN/i/DA1hjN0xWogW/uOhUMXq5zgf5jSck5/soLh4ebdzKrv83KD1ZQMWMPUEnQTHpYoHgknQ68QSy0SM1YAV8lTj8zAfMnA79Uz1EZXopfWFQsWuwPeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029438; c=relaxed/simple;
	bh=p9bA66pZOpKTZ3BG47197HY61HOlTBJKFfSf6XIO0NY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tSO232bUTLAQVBgUunvupdsHiLmenuYXlHtSenkaR7NQMbLTONaPUfrnLL3CDUaYZyeengqsrms1eJC+u0SGhwA+G92vhURS0pnZhVBL3VIZ/f9VnRdnU34Za58V0RRNagqsEBE1v3AxWSm7lGbrBOiyHo27t6wPSWd/FyLhTYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c/2eDDCN; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734029437; x=1765565437;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=p9bA66pZOpKTZ3BG47197HY61HOlTBJKFfSf6XIO0NY=;
  b=c/2eDDCN1Y0Uw8G3zTNmQ1eRrhdTS74Ay6TQoU666arCYx/6w935fDPR
   uppwVI4+Li8lmqsDIm8U8dX4Ph+Ri8PaCeEoPczAVIUrSqsJxjtZ9S14O
   2M/4HQ6CM9J/nqfOBwPyHPUkuKSzs5Dpu7sonH/8+CAq3GcZWkvAbsgCV
   vlHX0nDkAQ1D5gyXSLeOaO+timbMCtzQfQkqJehzlPTW11iVqQG0M4qgT
   45uK+vvCy9M7yHlJc0rCWcvzwfH72yYScxI4CKkhwetjDvjhY+L9CZU03
   tD9xLomuemK4wXvL1++DKuUCtT6WrXnmIhskBNfUSpFuPqioByxRD33a3
   w==;
X-CSE-ConnectionGUID: gl1ivLK0TJCFAqRotgHUkw==
X-CSE-MsgGUID: 2MHTZd/sSg2FI2deUpxlVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="44939421"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="44939421"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 10:50:36 -0800
X-CSE-ConnectionGUID: Pil/ZD2PR4yGZRBu7izqAA==
X-CSE-MsgGUID: +gIHjsm1RDWJolss8VKBoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="133689637"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.137])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 10:50:30 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 12 Dec 2024 20:50:26 +0200 (EET)
To: Yazen Ghannam <yazen.ghannam@amd.com>
cc: x86@kernel.org, tony.luck@intel.com, mario.limonciello@amd.com, 
    bhelgaas@google.com, jdelvare@suse.com, linux@roeck-us.net, 
    clemens@ladisch.de, Shyam-sundar.S-k@amd.com, 
    Hans de Goede <hdegoede@redhat.com>, naveenkrishna.chatradhi@amd.com, 
    suma.hegde@amd.com, LKML <linux-kernel@vger.kernel.org>, 
    linux-edac@vger.kernel.org, linux-pci@vger.kernel.org, 
    linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2.1] x86/amd_node, platform/x86/amd/hsmp: Have HSMP use
 SMN through AMD_NODE
In-Reply-To: <20241212172711.1944927-1-yazen.ghannam@amd.com>
Message-ID: <65375593-f2e0-e03b-7e7f-ad8be58772d4@linux.intel.com>
References:  <20241212172711.1944927-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 12 Dec 2024, Yazen Ghannam wrote:

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
> 
> Notes:
>     Link:
>     https://lore.kernel.org/20241206161210.163701-15-yazen.ghannam@amd.com
>     
>     v2->v2.1:
>     * Include static_assert() and comment for sysfs attributes.
>     
>     v1->v2:
>     * Rebase on recent HSMP rework.
> 
>  arch/x86/include/asm/amd_nb.h         |  1 -
>  arch/x86/include/asm/amd_node.h       |  3 +++
>  arch/x86/kernel/amd_nb.c              |  1 -
>  arch/x86/kernel/amd_node.c            |  9 +++++++
>  drivers/platform/x86/amd/hsmp/Kconfig |  2 +-
>  drivers/platform/x86/amd/hsmp/acpi.c  |  7 +++---
>  drivers/platform/x86/amd/hsmp/hsmp.c  |  1 -
>  drivers/platform/x86/amd/hsmp/hsmp.h  |  3 ---
>  drivers/platform/x86/amd/hsmp/plat.c  | 35 +++++++++------------------
>  9 files changed, 28 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
> index 4c4efb93045e..adfa0854cf2d 100644
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
> diff --git a/arch/x86/include/asm/amd_node.h b/arch/x86/include/asm/amd_node.h
> index 113ad3e8ee40..5fe9c6537434 100644
> --- a/arch/x86/include/asm/amd_node.h
> +++ b/arch/x86/include/asm/amd_node.h
> @@ -33,4 +33,7 @@ static inline u16 amd_num_nodes(void)
>  int __must_check amd_smn_read(u16 node, u32 address, u32 *value);
>  int __must_check amd_smn_write(u16 node, u32 address, u32 value);
>  
> +/* Should only be used by the HSMP driver. */
> +int __must_check amd_smn_hsmp_rdwr(u16 node, u32 address, u32 *value, bool write);
> +
>  #endif /*_ASM_X86_AMD_NODE_H_*/
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index 2729e99806ec..3a20312062af 100644
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
> diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
> index d2ec7fd555c5..65045f223c10 100644
> --- a/arch/x86/kernel/amd_node.c
> +++ b/arch/x86/kernel/amd_node.c
> @@ -97,6 +97,9 @@ static DEFINE_MUTEX(smn_mutex);
>  #define SMN_INDEX_OFFSET	0x60
>  #define SMN_DATA_OFFSET		0x64
>  
> +#define HSMP_INDEX_OFFSET	0xc4
> +#define HSMP_DATA_OFFSET	0xc8
> +
>  /*
>   * SMN accesses may fail in ways that are difficult to detect here in the called
>   * functions amd_smn_read() and amd_smn_write(). Therefore, callers must do
> @@ -179,6 +182,12 @@ int __must_check amd_smn_write(u16 node, u32 address, u32 value)
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
> diff --git a/drivers/platform/x86/amd/hsmp/Kconfig b/drivers/platform/x86/amd/hsmp/Kconfig
> index 7d10d4462a45..d6f7a62d55b5 100644
> --- a/drivers/platform/x86/amd/hsmp/Kconfig
> +++ b/drivers/platform/x86/amd/hsmp/Kconfig
> @@ -7,7 +7,7 @@ config AMD_HSMP
>  	tristate
>  
>  menu "AMD HSMP Driver"
> -	depends on AMD_NB || COMPILE_TEST
> +	depends on AMD_NODE || COMPILE_TEST
>  
>  config AMD_HSMP_ACPI
>  	tristate "AMD HSMP ACPI device driver"
> diff --git a/drivers/platform/x86/amd/hsmp/acpi.c b/drivers/platform/x86/amd/hsmp/acpi.c
> index e981d45e1c12..28565ca78afd 100644
> --- a/drivers/platform/x86/amd/hsmp/acpi.c
> +++ b/drivers/platform/x86/amd/hsmp/acpi.c
> @@ -10,7 +10,6 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <asm/amd_hsmp.h>
> -#include <asm/amd_nb.h>
>  
>  #include <linux/acpi.h>
>  #include <linux/device.h>
> @@ -24,6 +23,8 @@
>  
>  #include <uapi/asm-generic/errno-base.h>
>  
> +#include <asm/amd_node.h>
> +
>  #include "hsmp.h"
>  
>  #define DRIVER_NAME		"amd_hsmp"
> @@ -321,8 +322,8 @@ static int hsmp_acpi_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	if (!hsmp_pdev->is_probed) {
> -		hsmp_pdev->num_sockets = amd_nb_num();
> -		if (hsmp_pdev->num_sockets == 0 || hsmp_pdev->num_sockets > MAX_AMD_SOCKETS)
> +		hsmp_pdev->num_sockets = amd_num_nodes();
> +		if (hsmp_pdev->num_sockets == 0 || hsmp_pdev->num_sockets > MAX_AMD_NUM_NODES)
>  			return -ENODEV;
>  
>  		hsmp_pdev->sock = devm_kcalloc(&pdev->dev, hsmp_pdev->num_sockets,
> diff --git a/drivers/platform/x86/amd/hsmp/hsmp.c b/drivers/platform/x86/amd/hsmp/hsmp.c
> index 227b4ad4a51a..e04c613ad5d6 100644
> --- a/drivers/platform/x86/amd/hsmp/hsmp.c
> +++ b/drivers/platform/x86/amd/hsmp/hsmp.c
> @@ -8,7 +8,6 @@
>   */
>  
>  #include <asm/amd_hsmp.h>
> -#include <asm/amd_nb.h>
>  
>  #include <linux/acpi.h>
>  #include <linux/delay.h>
> diff --git a/drivers/platform/x86/amd/hsmp/hsmp.h b/drivers/platform/x86/amd/hsmp/hsmp.h
> index e852f0a947e4..af8b21f821d6 100644
> --- a/drivers/platform/x86/amd/hsmp/hsmp.h
> +++ b/drivers/platform/x86/amd/hsmp/hsmp.h
> @@ -21,8 +21,6 @@
>  
>  #define HSMP_ATTR_GRP_NAME_SIZE	10
>  
> -#define MAX_AMD_SOCKETS 8
> -
>  #define HSMP_CDEV_NAME		"hsmp_cdev"
>  #define HSMP_DEVNODE_NAME	"hsmp"
>  
> @@ -41,7 +39,6 @@ struct hsmp_socket {
>  	void __iomem *virt_base_addr;
>  	struct semaphore hsmp_sem;
>  	char name[HSMP_ATTR_GRP_NAME_SIZE];
> -	struct pci_dev *root;
>  	struct device *dev;
>  	u16 sock_ind;
>  	int (*amd_hsmp_rdwr)(struct hsmp_socket *sock, u32 off, u32 *val, bool rw);
> diff --git a/drivers/platform/x86/amd/hsmp/plat.c b/drivers/platform/x86/amd/hsmp/plat.c
> index a61f815c9f80..32921092b0c8 100644
> --- a/drivers/platform/x86/amd/hsmp/plat.c
> +++ b/drivers/platform/x86/amd/hsmp/plat.c
> @@ -10,7 +10,6 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <asm/amd_hsmp.h>
> -#include <asm/amd_nb.h>
>  
>  #include <linux/device.h>
>  #include <linux/module.h>
> @@ -18,6 +17,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/sysfs.h>
>  
> +#include <asm/amd_node.h>
> +
>  #include "hsmp.h"
>  
>  #define DRIVER_NAME		"amd_hsmp"
> @@ -34,28 +35,12 @@
>  #define SMN_HSMP_MSG_RESP	0x0010980
>  #define SMN_HSMP_MSG_DATA	0x00109E0
>  
> -#define HSMP_INDEX_REG		0xc4
> -#define HSMP_DATA_REG		0xc8
> -
>  static struct hsmp_plat_device *hsmp_pdev;
>  
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
>  static ssize_t hsmp_metric_tbl_plat_read(struct file *filp, struct kobject *kobj,
> @@ -95,7 +80,12 @@ static umode_t hsmp_is_sock_attr_visible(struct kobject *kobj,
>   * Static array of 8 + 1(for NULL) elements is created below
>   * to create sysfs groups for sockets.
>   * is_bin_visible function is used to show / hide the necessary groups.
> + *
> + * Validate the maximum number against MAX_AMD_NUM_NODES. If this changes,
> + * then the attributes and groups below must be adjusted.
>   */
> +static_assert(MAX_AMD_NUM_NODES == 8);

Please also add the #include for it.

-- 
 i.

>  #define HSMP_BIN_ATTR(index, _list)					\
>  static struct bin_attribute attr##index = {				\
>  	.attr = { .name = HSMP_METRICS_TABLE_NAME, .mode = 0444},	\
> @@ -159,10 +149,7 @@ static int init_platform_device(struct device *dev)
>  	int ret, i;
>  
>  	for (i = 0; i < hsmp_pdev->num_sockets; i++) {
> -		if (!node_to_amd_nb(i))
> -			return -ENODEV;
>  		sock = &hsmp_pdev->sock[i];
> -		sock->root			= node_to_amd_nb(i)->root;
>  		sock->sock_ind			= i;
>  		sock->dev			= dev;
>  		sock->mbinfo.base_addr		= SMN_HSMP_BASE;
> @@ -305,11 +292,11 @@ static int __init hsmp_plt_init(void)
>  		return -ENOMEM;
>  
>  	/*
> -	 * amd_nb_num() returns number of SMN/DF interfaces present in the system
> +	 * amd_num_nodes() returns number of SMN/DF interfaces present in the system
>  	 * if we have N SMN/DF interfaces that ideally means N sockets
>  	 */
> -	hsmp_pdev->num_sockets = amd_nb_num();
> -	if (hsmp_pdev->num_sockets == 0 || hsmp_pdev->num_sockets > MAX_AMD_SOCKETS)
> +	hsmp_pdev->num_sockets = amd_num_nodes();
> +	if (hsmp_pdev->num_sockets == 0 || hsmp_pdev->num_sockets > MAX_AMD_NUM_NODES)
>  		return ret;
>  
>  	ret = platform_driver_register(&amd_hsmp_driver);
> 

