Return-Path: <linux-pci+bounces-17945-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3DC9E9736
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 14:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 594D02832E0
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 13:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A061A238E;
	Mon,  9 Dec 2024 13:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O4bpGBZw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ED9233129;
	Mon,  9 Dec 2024 13:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733751335; cv=none; b=tSANs5WTj5SZTyeJ+lWm4XeoTvBvU20n1MLtVjfq9qNajk2m5DMYAx50y43yZMyxv8ray8PgnHy5wuqCaVOk3eZKQYnXgq2a65rJl24/ow4DRSdH7QoF+K8LQ6GGKng6uN/VwP20qzKGigHfXfvNLGXrWFR7jJB4VgA44JzJ1zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733751335; c=relaxed/simple;
	bh=ZtH2U4428M+810NwKCQqHea/UigT8pV08ex00baSBZc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lHwihwGn1FwHZ+z3XJKyPD1Y/K7yR/fOH1xBcTwpuGfFpby2jvFuIhEM/UFVEPIugEs6lSqgahj4ifqHI+Y1O2aReq1VtSItxY3aG6Vrh7/++bQqDnQBdaY+tfbCHE9eHETavJkiGyJN+RIfgSGT4l1SAqJAUqbck4P9gEOPGcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O4bpGBZw; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733751333; x=1765287333;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZtH2U4428M+810NwKCQqHea/UigT8pV08ex00baSBZc=;
  b=O4bpGBZwVsObGnCVpRr70lwxdywomF52Wf+9w0WvFn64fdiO0vCDZs/k
   dCYjsjMJIrmne07TKeAVNNmXurWZdqu0pUH2Bc7vjN1GkHIxBUhiZf0E0
   LTTC5Ty3Xz6jHRNAYfTG2mpIDe4Kp+5NXxV7COzW/94wEohcpVbmg6R/U
   AipZ9lLZvD6JipRb/FzjWdkrUor+K0BQ1qE/waTGZ6WjRKHuxC2pv4LTp
   VDJCYnY1QNqD0WNGhUZvO3RXyuUufmzkafpogNZhFk2HGJsZ3yPqUtIPv
   OQlfHAnq4J1Y6ZKV5mx0mMf9zYRiBlPYJRu67XO5NUNK7AUpTGvZ1wvIc
   w==;
X-CSE-ConnectionGUID: 2gc6XfgCRZ2P2z9m3IUJ+A==
X-CSE-MsgGUID: K9HSRhhuSdqGEPf5QzbahA==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="51577495"
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="51577495"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 05:35:32 -0800
X-CSE-ConnectionGUID: d/2K0IIPSKqJlhxJB+wScw==
X-CSE-MsgGUID: UmTu2FZ9Sh2iQ8dNFGeDjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="94939683"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.121])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 05:35:28 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 9 Dec 2024 15:35:25 +0200 (EET)
To: Yazen Ghannam <yazen.ghannam@amd.com>
cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>, 
    Mario Limonciello <mario.limonciello@amd.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, Jean Delvare <jdelvare@suse.com>, 
    Guenter Roeck <linux@roeck-us.net>, Clemens Ladisch <clemens@ladisch.de>, 
    Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
    Hans de Goede <hdegoede@redhat.com>, 
    Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>, 
    Suma Hegde <suma.hegde@amd.com>, LKML <linux-kernel@vger.kernel.org>, 
    linux-edac@vger.kernel.org, linux-pci@vger.kernel.org, 
    linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 10/16] x86/amd_nb: Move SMN access code to a new
 amd_node driver
In-Reply-To: <20241206161210.163701-11-yazen.ghannam@amd.com>
Message-ID: <468a6024-0431-1fec-7f27-36e440070a3f@linux.intel.com>
References: <20241206161210.163701-1-yazen.ghannam@amd.com> <20241206161210.163701-11-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-15370924-1733751325=:938"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-15370924-1733751325=:938
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 6 Dec 2024, Yazen Ghannam wrote:

> From: Mario Limonciello <mario.limonciello@amd.com>
>=20
> SMN access was bolted into amd_nb mostly as convenience.  This has
> limitations though that require incurring tech debt to keep it working.
>=20
> Move SMN access to the newly introduced AMD Node driver.
>=20
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>=20
> Notes:
>     Link:
>     https://lore.kernel.org/20241023172150.659002-11-yazen.ghannam@amd.co=
m
>    =20
>     v1->v2:
>     * Move code to AMD_NODE rather than create a new compilation unit.
>=20
>  MAINTAINERS                          |  1 +
>  arch/x86/include/asm/amd_nb.h        |  3 -
>  arch/x86/include/asm/amd_node.h      |  3 +
>  arch/x86/kernel/amd_nb.c             | 89 ---------------------------
>  arch/x86/kernel/amd_node.c           | 90 ++++++++++++++++++++++++++++
>  arch/x86/pci/fixup.c                 |  4 +-
>  drivers/edac/Kconfig                 |  1 +
>  drivers/edac/amd64_edac.c            |  1 +
>  drivers/hwmon/Kconfig                |  2 +-
>  drivers/hwmon/k10temp.c              |  2 +-
>  drivers/platform/x86/amd/pmc/Kconfig |  2 +-
>  drivers/platform/x86/amd/pmc/pmc.c   |  3 +-
>  drivers/platform/x86/amd/pmf/Kconfig |  2 +-
>  drivers/platform/x86/amd/pmf/core.c  |  2 +-

For pdx86,

Acked-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--
 i.


>  drivers/ras/amd/atl/Kconfig          |  1 +
>  drivers/ras/amd/atl/internal.h       |  1 +
>  16 files changed, 107 insertions(+), 100 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d7617f196bda..ca383cb1539f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1122,6 +1122,7 @@ S:=09Supported
>  F:=09drivers/i2c/busses/i2c-amd-asf-plat.c
> =20
>  AMD NODE DRIVER
> +M:=09Mario Limonciello <mario.limonciello@amd.com>
>  M:=09Yazen Ghannam <yazen.ghannam@amd.com>
>  L:=09linux-kernel@vger.kernel.org
>  S:=09Supported
> diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.=
h
> index 066dc3801430..4c4efb93045e 100644
> --- a/arch/x86/include/asm/amd_nb.h
> +++ b/arch/x86/include/asm/amd_nb.h
> @@ -21,9 +21,6 @@ extern int amd_numa_init(void);
>  extern int amd_get_subcaches(int);
>  extern int amd_set_subcaches(int, unsigned long);
> =20
> -int __must_check amd_smn_read(u16 node, u32 address, u32 *value);
> -int __must_check amd_smn_write(u16 node, u32 address, u32 value);
> -
>  struct amd_l3_cache {
>  =09unsigned indices;
>  =09u8=09 subcaches[4];
> diff --git a/arch/x86/include/asm/amd_node.h b/arch/x86/include/asm/amd_n=
ode.h
> index 419a0ad13ef2..113ad3e8ee40 100644
> --- a/arch/x86/include/asm/amd_node.h
> +++ b/arch/x86/include/asm/amd_node.h
> @@ -30,4 +30,7 @@ static inline u16 amd_num_nodes(void)
>  =09return topology_amd_nodes_per_pkg() * topology_max_packages();
>  }
> =20
> +int __must_check amd_smn_read(u16 node, u32 address, u32 *value);
> +int __must_check amd_smn_write(u16 node, u32 address, u32 value);
> +
>  #endif /*_ASM_X86_AMD_NODE_H_*/
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index 2ad67efe9032..2729e99806ec 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -15,9 +15,6 @@
>  #include <linux/pci_ids.h>
>  #include <asm/amd_nb.h>
> =20
> -/* Protect the PCI config register pairs used for SMN. */
> -static DEFINE_MUTEX(smn_mutex);
> -
>  static u32 *flush_words;
> =20
>  static const struct pci_device_id amd_nb_misc_ids[] =3D {
> @@ -59,92 +56,6 @@ struct amd_northbridge *node_to_amd_nb(int node)
>  }
>  EXPORT_SYMBOL_GPL(node_to_amd_nb);
> =20
> -/*
> - * SMN accesses may fail in ways that are difficult to detect here in th=
e called
> - * functions amd_smn_read() and amd_smn_write(). Therefore, callers must=
 do
> - * their own checking based on what behavior they expect.
> - *
> - * For SMN reads, the returned value may be zero if the register is Read=
-as-Zero.
> - * Or it may be a "PCI Error Response", e.g. all 0xFFs. The "PCI Error R=
esponse"
> - * can be checked here, and a proper error code can be returned.
> - *
> - * But the Read-as-Zero response cannot be verified here. A value of 0 m=
ay be
> - * correct in some cases, so callers must check that this correct is for=
 the
> - * register/fields they need.
> - *
> - * For SMN writes, success can be determined through a "write and read b=
ack"
> - * However, this is not robust when done here.
> - *
> - * Possible issues:
> - *
> - * 1) Bits that are "Write-1-to-Clear". In this case, the read value sho=
uld
> - *    *not* match the write value.
> - *
> - * 2) Bits that are "Read-as-Zero"/"Writes-Ignored". This information ca=
nnot be
> - *    known here.
> - *
> - * 3) Bits that are "Reserved / Set to 1". Ditto above.
> - *
> - * Callers of amd_smn_write() should do the "write and read back" check
> - * themselves, if needed.
> - *
> - * For #1, they can see if their target bits got cleared.
> - *
> - * For #2 and #3, they can check if their target bits got set as intende=
d.
> - *
> - * This matches what is done for RDMSR/WRMSR. As long as there's no #GP,=
 then
> - * the operation is considered a success, and the caller does their own
> - * checking.
> - */
> -static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
> -{
> -=09struct pci_dev *root;
> -=09int err =3D -ENODEV;
> -
> -=09if (node >=3D amd_northbridges.num)
> -=09=09goto out;
> -
> -=09root =3D node_to_amd_nb(node)->root;
> -=09if (!root)
> -=09=09goto out;
> -
> -=09mutex_lock(&smn_mutex);
> -
> -=09err =3D pci_write_config_dword(root, 0x60, address);
> -=09if (err) {
> -=09=09pr_warn("Error programming SMN address 0x%x.\n", address);
> -=09=09goto out_unlock;
> -=09}
> -
> -=09err =3D (write ? pci_write_config_dword(root, 0x64, *value)
> -=09=09     : pci_read_config_dword(root, 0x64, value));
> -
> -out_unlock:
> -=09mutex_unlock(&smn_mutex);
> -
> -out:
> -=09return err;
> -}
> -
> -int __must_check amd_smn_read(u16 node, u32 address, u32 *value)
> -{
> -=09int err =3D __amd_smn_rw(node, address, value, false);
> -
> -=09if (PCI_POSSIBLE_ERROR(*value)) {
> -=09=09err =3D -ENODEV;
> -=09=09*value =3D 0;
> -=09}
> -
> -=09return err;
> -}
> -EXPORT_SYMBOL_GPL(amd_smn_read);
> -
> -int __must_check amd_smn_write(u16 node, u32 address, u32 value)
> -{
> -=09return __amd_smn_rw(node, address, &value, true);
> -}
> -EXPORT_SYMBOL_GPL(amd_smn_write);
> -
>  static int amd_cache_northbridges(void)
>  {
>  =09struct amd_northbridge *nb;
> diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
> index 4eea8c7d8090..95e5ca0acc90 100644
> --- a/arch/x86/kernel/amd_node.c
> +++ b/arch/x86/kernel/amd_node.c
> @@ -8,6 +8,7 @@
>   * Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
>   */
> =20
> +#include <asm/amd_nb.h>
>  #include <asm/amd_node.h>
> =20
>  /*
> @@ -88,3 +89,92 @@ struct pci_dev *amd_node_get_root(u16 node)
>  =09pci_dbg(root, "is root for AMD node %u\n", node);
>  =09return root;
>  }
> +
> +/* Protect the PCI config register pairs used for SMN. */
> +static DEFINE_MUTEX(smn_mutex);
> +
> +/*
> + * SMN accesses may fail in ways that are difficult to detect here in th=
e called
> + * functions amd_smn_read() and amd_smn_write(). Therefore, callers must=
 do
> + * their own checking based on what behavior they expect.
> + *
> + * For SMN reads, the returned value may be zero if the register is Read=
-as-Zero.
> + * Or it may be a "PCI Error Response", e.g. all 0xFFs. The "PCI Error R=
esponse"
> + * can be checked here, and a proper error code can be returned.
> + *
> + * But the Read-as-Zero response cannot be verified here. A value of 0 m=
ay be
> + * correct in some cases, so callers must check that this correct is for=
 the
> + * register/fields they need.
> + *
> + * For SMN writes, success can be determined through a "write and read b=
ack"
> + * However, this is not robust when done here.
> + *
> + * Possible issues:
> + *
> + * 1) Bits that are "Write-1-to-Clear". In this case, the read value sho=
uld
> + *    *not* match the write value.
> + *
> + * 2) Bits that are "Read-as-Zero"/"Writes-Ignored". This information ca=
nnot be
> + *    known here.
> + *
> + * 3) Bits that are "Reserved / Set to 1". Ditto above.
> + *
> + * Callers of amd_smn_write() should do the "write and read back" check
> + * themselves, if needed.
> + *
> + * For #1, they can see if their target bits got cleared.
> + *
> + * For #2 and #3, they can check if their target bits got set as intende=
d.
> + *
> + * This matches what is done for RDMSR/WRMSR. As long as there's no #GP,=
 then
> + * the operation is considered a success, and the caller does their own
> + * checking.
> + */
> +static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
> +{
> +=09struct pci_dev *root;
> +=09int err =3D -ENODEV;
> +
> +=09if (node >=3D amd_nb_num())
> +=09=09goto out;
> +
> +=09root =3D node_to_amd_nb(node)->root;
> +=09if (!root)
> +=09=09goto out;
> +
> +=09mutex_lock(&smn_mutex);
> +
> +=09err =3D pci_write_config_dword(root, 0x60, address);
> +=09if (err) {
> +=09=09pr_warn("Error programming SMN address 0x%x.\n", address);
> +=09=09goto out_unlock;
> +=09}
> +
> +=09err =3D (write ? pci_write_config_dword(root, 0x64, *value)
> +=09=09     : pci_read_config_dword(root, 0x64, value));
> +
> +out_unlock:
> +=09mutex_unlock(&smn_mutex);
> +
> +out:
> +=09return err;
> +}
> +
> +int __must_check amd_smn_read(u16 node, u32 address, u32 *value)
> +{
> +=09int err =3D __amd_smn_rw(node, address, value, false);
> +
> +=09if (PCI_POSSIBLE_ERROR(*value)) {
> +=09=09err =3D -ENODEV;
> +=09=09*value =3D 0;
> +=09}
> +
> +=09return err;
> +}
> +EXPORT_SYMBOL_GPL(amd_smn_read);
> +
> +int __must_check amd_smn_write(u16 node, u32 address, u32 value)
> +{
> +=09return __amd_smn_rw(node, address, &value, true);
> +}
> +EXPORT_SYMBOL_GPL(amd_smn_write);
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index 0681ecfe3430..592fb9d97e77 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -9,7 +9,7 @@
>  #include <linux/pci.h>
>  #include <linux/suspend.h>
>  #include <linux/vgaarb.h>
> -#include <asm/amd_nb.h>
> +#include <asm/amd_node.h>
>  #include <asm/hpet.h>
>  #include <asm/pci_x86.h>
> =20
> @@ -828,7 +828,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7910, rs=
690_fix_64bit_dma);
> =20
>  #endif
> =20
> -#ifdef CONFIG_AMD_NB
> +#ifdef CONFIG_AMD_NODE
> =20
>  #define AMD_15B8_RCC_DEV2_EPF0_STRAP2                                  0=
x10136008
>  #define AMD_15B8_RCC_DEV2_EPF0_STRAP2_NO_SOFT_RESET_DEV2_F0_MASK       0=
x00000080L
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 06f7b43a6f78..cb97d7bdae31 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -78,6 +78,7 @@ config EDAC_GHES
>  config EDAC_AMD64
>  =09tristate "AMD64 (Opteron, Athlon64)"
>  =09depends on AMD_NB && EDAC_DECODE_MCE
> +=09depends on AMD_NODE
>  =09imply AMD_ATL
>  =09help
>  =09  Support for error detection and correction of DRAM ECC errors on
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index ddfbdb66b794..29465088639c 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -2,6 +2,7 @@
>  #include <linux/ras.h>
>  #include "amd64_edac.h"
>  #include <asm/amd_nb.h>
> +#include <asm/amd_node.h>
> =20
>  static struct edac_pci_ctl_info *pci_ctl;
> =20
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index dd376602f3f1..ea13ea482a63 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -324,7 +324,7 @@ config SENSORS_K8TEMP
> =20
>  config SENSORS_K10TEMP
>  =09tristate "AMD Family 10h+ temperature sensor"
> -=09depends on X86 && PCI && AMD_NB
> +=09depends on X86 && PCI && AMD_NODE
>  =09help
>  =09  If you say yes here you get support for the temperature
>  =09  sensor(s) inside your CPU. Supported are later revisions of
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index cefa8cd184c8..d0b4cc9a5011 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -20,7 +20,7 @@
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/pci_ids.h>
> -#include <asm/amd_nb.h>
> +#include <asm/amd_node.h>
>  #include <asm/processor.h>
> =20
>  MODULE_DESCRIPTION("AMD Family 10h+ CPU core temperature monitor");
> diff --git a/drivers/platform/x86/amd/pmc/Kconfig b/drivers/platform/x86/=
amd/pmc/Kconfig
> index 94f9563d8be7..eeffdafd686e 100644
> --- a/drivers/platform/x86/amd/pmc/Kconfig
> +++ b/drivers/platform/x86/amd/pmc/Kconfig
> @@ -5,7 +5,7 @@
> =20
>  config AMD_PMC
>  =09tristate "AMD SoC PMC driver"
> -=09depends on ACPI && PCI && RTC_CLASS && AMD_NB
> +=09depends on ACPI && PCI && RTC_CLASS && AMD_NODE
>  =09depends on SUSPEND
>  =09select SERIO
>  =09help
> diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/am=
d/pmc/pmc.c
> index 26b878ee5191..941b7753dd78 100644
> --- a/drivers/platform/x86/amd/pmc/pmc.c
> +++ b/drivers/platform/x86/amd/pmc/pmc.c
> @@ -10,7 +10,6 @@
> =20
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> =20
> -#include <asm/amd_nb.h>
>  #include <linux/acpi.h>
>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
> @@ -28,6 +27,8 @@
>  #include <linux/seq_file.h>
>  #include <linux/uaccess.h>
> =20
> +#include <asm/amd_node.h>
> +
>  #include "pmc.h"
> =20
>  /* SMU communication registers */
> diff --git a/drivers/platform/x86/amd/pmf/Kconfig b/drivers/platform/x86/=
amd/pmf/Kconfig
> index 99d67cdbd91e..25b8f7ae3abd 100644
> --- a/drivers/platform/x86/amd/pmf/Kconfig
> +++ b/drivers/platform/x86/amd/pmf/Kconfig
> @@ -7,7 +7,7 @@ config AMD_PMF
>  =09tristate "AMD Platform Management Framework"
>  =09depends on ACPI && PCI
>  =09depends on POWER_SUPPLY
> -=09depends on AMD_NB
> +=09depends on AMD_NODE
>  =09select ACPI_PLATFORM_PROFILE
>  =09depends on TEE && AMDTEE
>  =09depends on AMD_SFH_HID
> diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/a=
md/pmf/core.c
> index 06a97c533cb8..7f88f3121cf5 100644
> --- a/drivers/platform/x86/amd/pmf/core.c
> +++ b/drivers/platform/x86/amd/pmf/core.c
> @@ -8,13 +8,13 @@
>   * Author: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>   */
> =20
> -#include <asm/amd_nb.h>
>  #include <linux/debugfs.h>
>  #include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
>  #include <linux/power_supply.h>
> +#include <asm/amd_node.h>
>  #include "pmf.h"
> =20
>  /* PMF-SMU communication registers */
> diff --git a/drivers/ras/amd/atl/Kconfig b/drivers/ras/amd/atl/Kconfig
> index 551680073e43..6e03942cd7da 100644
> --- a/drivers/ras/amd/atl/Kconfig
> +++ b/drivers/ras/amd/atl/Kconfig
> @@ -10,6 +10,7 @@
>  config AMD_ATL
>  =09tristate "AMD Address Translation Library"
>  =09depends on AMD_NB && X86_64 && RAS
> +=09depends on AMD_NODE
>  =09depends on MEMORY_FAILURE
>  =09default N
>  =09help
> diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/interna=
l.h
> index 143d04c779a8..f9be26d25348 100644
> --- a/drivers/ras/amd/atl/internal.h
> +++ b/drivers/ras/amd/atl/internal.h
> @@ -18,6 +18,7 @@
>  #include <linux/ras.h>
> =20
>  #include <asm/amd_nb.h>
> +#include <asm/amd_node.h>
> =20
>  #include "reg_fields.h"
> =20
>=20
--8323328-15370924-1733751325=:938--

