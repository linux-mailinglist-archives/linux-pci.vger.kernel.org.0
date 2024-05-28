Return-Path: <linux-pci+bounces-7903-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DEE8D1DBD
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 15:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5220E1F23CFA
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 13:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446A016DEC7;
	Tue, 28 May 2024 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oD4AK6aQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D76B16F292
	for <linux-pci@vger.kernel.org>; Tue, 28 May 2024 13:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716904527; cv=none; b=OQ88+/JRgaVi5fE+abDOjGu/PEGLL6z1JxxwNDXAhh+G5/NponBuuE9LIsJahHR7s4eEeDAOsek86QOjVR9zgdJ/21q8XrcgXimsw4xVFZ72Nhcp/W7YLjV0OqS8ltL0fBWz2PlxOtYkF2pvbBTmfcYP8MXD6H4nhBDyJIbtSes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716904527; c=relaxed/simple;
	bh=umctaIWBymw2WO7zkjK7Kt8tz9CFqHaDGgq1vXK4hzs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Qm4RpdPUr0qFh8dE8eDDO3c48NtSVO8Y8VeH8eoIR0c1QigHB0QlBIrodIlgrnbK9VkaLaLG3u1bRfFGdK8L2EPqixL6jKc5EX4KufQk4UMFyfwTXValRR0KHrHNIeHCCjAQQBQeeJyzewcPoslpyUd3+Fd4TAyP7KzE9VpiQvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oD4AK6aQ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716904526; x=1748440526;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=umctaIWBymw2WO7zkjK7Kt8tz9CFqHaDGgq1vXK4hzs=;
  b=oD4AK6aQGXWr0oTpvmkCmQMUqM+OFXPZowp4ljyY28YrV3ZnhhV443QC
   VZks4hxfdl9s2CKOunI93gXkeeb74bGUDI54Xpas86ZygS+Qs4BVbj1Yo
   SJnjGmgrRs9UKfjSKYgOms5u01TRVwmj6xZh1HbGM2gl9Wxvoj5jq9hh3
   v14yp26rikWJfmDxR5s5+VCPdN78Qujbpm35dC39Ahuwg8cjBKJHiflcc
   npjGB5+9OuLBdMDDl+IFF+49+dCTCGL1QgDn9KV9SFyGCfdEQIHfpEEIT
   7gwkEicrB5OxiKtqxpkAy8olJAFM2TUhARvofYZYrIya/pyUtEra/8M9+
   w==;
X-CSE-ConnectionGUID: a6L0bBF/SQ+OX8gSCJ4LYw==
X-CSE-MsgGUID: djzl7q1DRH+dzTzwe6jhZA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="35764968"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="35764968"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 06:55:25 -0700
X-CSE-ConnectionGUID: xeq17GqRTEu4eJCIjsixhA==
X-CSE-MsgGUID: FGblbewCROykiRvD8eOP5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="35161364"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.144])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 06:55:20 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 28 May 2024 16:55:16 +0300 (EEST)
To: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
cc: linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    Dan Williams <dan.j.williams@intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Lukas Wunner <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>, 
    Marek Behun <marek.behun@nic.cz>, Pavel Machek <pavel@ucw.cz>, 
    Randy Dunlap <rdunlap@infradead.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH v2 2/3] PCI/NPEM: Add Native PCIe Enclosure Management
 support
In-Reply-To: <20240528131940.16924-3-mariusz.tkaczyk@linux.intel.com>
Message-ID: <3e4718ce-8371-93e2-b390-cc3b263f31df@linux.intel.com>
References: <20240528131940.16924-1-mariusz.tkaczyk@linux.intel.com> <20240528131940.16924-3-mariusz.tkaczyk@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1650766853-1716904516=:5869"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1650766853-1716904516=:5869
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 28 May 2024, Mariusz Tkaczyk wrote:

> Native PCIe Enclosure Management (NPEM, PCIe r6.1 sec 6.28) allows
> managing LED in storage enclosures. NPEM is indication oriented
> and it does not give direct access to LED. Although each of
> the indications *could* represent an individual LED, multiple
> indications could also be represented as a single,
> multi-color LED or a single LED blinking in a specific interval.
> The specification leaves that open.
>=20
> Each enabled indication (capability register bit on) is represented as a
> ledclass_dev which can be controlled through sysfs. For every ledclass
> device only 2 brightness states are allowed: LED_ON (1) or LED_OFF (0).
> It is corresponding to NPEM control register (Indication bit on/off).
>=20
> Ledclass devices appear in sysfs as child devices (subdirectory) of PCI
> device which has an NPEM Extended Capability and indication is enabled
> in NPEM capability register. For example, these are leds created for
> pcieport "10000:02:05.0" on my setup:
>=20
> leds/
> =E2=94=9C=E2=94=80=E2=94=80 10000:02:05.0:enclosure:fail
> =E2=94=9C=E2=94=80=E2=94=80 10000:02:05.0:enclosure:locate
> =E2=94=9C=E2=94=80=E2=94=80 10000:02:05.0:enclosure:ok
> =E2=94=94=E2=94=80=E2=94=80 10000:02:05.0:enclosure:rebuild
>=20
> They can be also found in "/sys/class/leds" directory. Parent PCIe device
> bdf is used to guarantee uniqueness across leds subsystem.
>=20
> To enable/disable fail indication "brightness" file can be edited:
> echo 1 > ./leds/10000:02:05.0:enclosure:fail/brightness
> echo 0 > ./leds/10000:02:05.0:enclosure:fail/brightness
>=20
> PCIe r6.1, sec 7.9.19.2 defines the possible indications.
>=20
> Multiple indications for same parent PCIe device can conflict and
> hardware may update them when processing new request. To avoid issues,
> driver refresh all indications by reading back control register.
>=20
> Driver is projected to be exclusive NPEM extended capability manager.
> It waits up to 1 second after imposing new request, it doesn't verify if
> controller is busy before write, assuming that mutex lock gives protectio=
n
> from concurrent updates. Driver is not registered if _DSM LED management
> is available.
>=20
> NPEM is a PCIe extended capability so it should be registered in
> pcie_init_capabilities() but it is not possible due to LED dependency.
> Parent pci_device must be added earlier for led_classdev_register()
> to be successful. NPEM does not require configuration on kernel side, it
> is safe to register LED devices later.
>=20
> Link: https://members.pcisig.com/wg/PCI-SIG/document/19849 [1]
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
> ---
>  drivers/pci/Kconfig           |   9 +
>  drivers/pci/Makefile          |   1 +
>  drivers/pci/npem.c            | 410 ++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h             |   8 +
>  drivers/pci/probe.c           |   2 +
>  drivers/pci/remove.c          |   2 +
>  include/linux/pci.h           |   3 +
>  include/uapi/linux/pci_regs.h |  34 +++
>  8 files changed, 469 insertions(+)
>  create mode 100644 drivers/pci/npem.c
>=20
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index d35001589d88..e696e69ad516 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -143,6 +143,15 @@ config PCI_IOV
> =20
>  =09  If unsure, say N.
> =20
> +config PCI_NPEM
> +=09bool "Native PCIe Enclosure Management"
> +=09depends on LEDS_CLASS=3Dy
> +=09help
> +=09  Support for Native PCIe Enclosure Management. It allows managing LE=
D
> +=09  indications in storage enclosures. Enclosure must support following
> +=09  indications: OK, Locate, Fail, Rebuild, other indications are
> +=09  optional.
> +
>  config PCI_PRI
>  =09bool "PCI PRI support"
>  =09select PCI_ATS
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 175302036890..cd5f655d4be9 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_XEN_PCIDEV_FRONTEND) +=3D xen-pcifront.o
>  obj-$(CONFIG_VGA_ARB)=09=09+=3D vgaarb.o
>  obj-$(CONFIG_PCI_DOE)=09=09+=3D doe.o
>  obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) +=3D of_property.o
> +obj-$(CONFIG_PCI_NPEM)=09=09+=3D npem.o
> =20
>  # Endpoint library must be initialized before its users
>  obj-$(CONFIG_PCI_ENDPOINT)=09+=3D endpoint/
> diff --git a/drivers/pci/npem.c b/drivers/pci/npem.c
> new file mode 100644
> index 000000000000..a76a2044dab2
> --- /dev/null
> +++ b/drivers/pci/npem.c
> @@ -0,0 +1,410 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCIe Enclosure management driver created for LED interfaces based on
> + * indications. It says *what indications* blink but does not specify *h=
ow*
> + * they blink - it is hardware defined.
> + *
> + * The driver name refers to Native PCIe Enclosure Management. It is
> + * first indication oriented standard with specification.
> + *
> + * Native PCIe Enclosure Management (NPEM)
> + *=09PCIe Base Specification r6.1 sec 6.28
> + *=09PCIe Base Specification r6.1 sec 7.9.19
> + *
> + * Copyright (c) 2023-2024 Intel Corporation
> + *=09Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/bitops.h>
> +#include <linux/errno.h>
> +#include <linux/iopoll.h>
> +#include <linux/leds.h>
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +#include <linux/pci_regs.h>
> +#include <linux/types.h>
> +#include <linux/uleds.h>
> +
> +#include "pci.h"
> +
> +struct indication {
> +=09u32 bit;
> +=09const char *name;
> +};
> +
> +static const struct indication npem_indications[] =3D {
> +=09{PCI_NPEM_IND_OK,=09"enclosure:ok"},
> +=09{PCI_NPEM_IND_LOCATE,=09"enclosure:locate"},
> +=09{PCI_NPEM_IND_FAIL,=09"enclosure:fail"},
> +=09{PCI_NPEM_IND_REBUILD,=09"enclosure:rebuild"},
> +=09{PCI_NPEM_IND_PFA,=09"enclosure:pfa"},
> +=09{PCI_NPEM_IND_HOTSPARE,=09"enclosure:hotspare"},
> +=09{PCI_NPEM_IND_ICA,=09"enclosure:ica"},
> +=09{PCI_NPEM_IND_IFA,=09"enclosure:ifa"},
> +=09{PCI_NPEM_IND_IDT,=09"enclosure:idt"},
> +=09{PCI_NPEM_IND_DISABLED,=09"enclosure:disabled"},
> +=09{PCI_NPEM_IND_SPEC_0,=09"enclosure:specific_0"},
> +=09{PCI_NPEM_IND_SPEC_1,=09"enclosure:specific_1"},
> +=09{PCI_NPEM_IND_SPEC_2,=09"enclosure:specific_2"},
> +=09{PCI_NPEM_IND_SPEC_3,=09"enclosure:specific_3"},
> +=09{PCI_NPEM_IND_SPEC_4,=09"enclosure:specific_4"},
> +=09{PCI_NPEM_IND_SPEC_5,=09"enclosure:specific_5"},
> +=09{PCI_NPEM_IND_SPEC_6,=09"enclosure:specific_6"},
> +=09{PCI_NPEM_IND_SPEC_7,=09"enclosure:specific_7"},
> +=09{0,=09=09=09NULL}
> +};
> +
> +#define for_each_indication(ind, inds) \
> +=09for (ind =3D inds; ind->bit; ind++)
> +
> +/* To avoid confusion, do not keep any special bits in indications */
> +static u32 reg_to_indications(u32 caps, const struct indication *inds)
> +{
> +=09const struct indication *ind;
> +=09u32 supported_indications =3D 0;
> +
> +=09for_each_indication(ind, inds)
> +=09=09supported_indications |=3D ind->bit;
> +
> +=09return caps & supported_indications;
> +}
> +
> +/**
> + * struct npem_led - LED details
> + * @indication: indication details
> + * @npem: npem device
> + * @name: LED name
> + * @led: LED device
> + */
> +struct npem_led {
> +=09const struct indication *indication;
> +=09struct npem *npem;
> +=09char name[LED_MAX_NAME_SIZE];
> +=09struct led_classdev led;
> +};
> +
> +/**
> + * struct npem_ops - backend specific callbacks
> + * @inds: supported indications array
> + * @get_active_indications: get active indications
> + *=09npem: npem device
> + *=09buf: response buffer
> + * @set_active_indications: set new indications
> + *=09npem: npem device
> + *=09val: bit mask to set
> + *
> + * Handle communication with hardware. set_active_indications updates
> + * npem->active_indications.
> + */
> +struct npem_ops {
> +=09const struct indication *inds;
> +=09int (*get_active_indications)(struct npem *npem, u32 *buf);
> +=09int (*set_active_indications)(struct npem *npem, u32 val);
> +};
> +
> +/**
> + * struct npem - NPEM device properties
> + * @dev: PCIe device this driver is attached to
> + * @ops: Backend specific callbacks
> + * @npem_lock: to keep concurrent updates serialized
> + * @pos: NPEM capability offset (only relevant for NPEM direct register =
access,
> + *=09 not DSM access method)
> + * @supported_indications: bit mask of supported indications
> + *=09=09=09   non-indication and reserved bits are cleared
> + * @active_indications: bit mask of active indications
> + *=09=09=09non-indication and reserved bits are cleared
> + * @led_cnt: Supported LEDs count
> + * @leds: supported LEDs
> + */
> +struct npem {
> +=09struct pci_dev *dev;
> +=09const struct npem_ops *ops;
> +=09struct mutex npem_lock;
> +=09u16 pos;
> +=09u32 supported_indications;
> +=09u32 active_indications;
> +=09int led_cnt;
> +=09struct npem_led leds[];
> +};
> +
> +static int npem_read_reg(struct npem *npem, u16 reg, u32 *val)
> +{
> +=09int ret =3D pci_read_config_dword(npem->dev, npem->pos + reg, val);
> +
> +=09return pcibios_err_to_errno(ret);
> +}
> +
> +static int npem_write_ctrl(struct npem *npem, u32 reg)
> +{
> +=09int pos =3D npem->pos + PCI_NPEM_CTRL;
> +=09int ret =3D pci_write_config_dword(npem->dev, pos, reg);
> +
> +=09return pcibios_err_to_errno(ret);
> +}
> +
> +static int npem_get_active_indications(struct npem *npem, u32 *buf)
> +{
> +=09int ret;
> +
> +=09ret =3D npem_read_reg(npem, PCI_NPEM_CTRL, buf);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09/* If PCI_NPEM_CTRL_ENABLE is not set then no indication should blink=
 */
> +=09if (!(*buf & PCI_NPEM_CTRL_ENABLE))
> +=09=09*buf =3D 0;
> +
> +=09/* Filter out not supported indications in response */
> +=09*buf &=3D npem->supported_indications;
> +=09return 0;
> +}
> +
> +static int npem_set_active_indications(struct npem *npem, u32 val)
> +{
> +=09int ret, ret_val;
> +=09u32 cc_status;
> +
> +=09lockdep_assert_held(&npem->npem_lock);
> +
> +=09/* This bit is always required */
> +=09val |=3D PCI_NPEM_CTRL_ENABLE;
> +=09ret =3D npem_write_ctrl(npem, val);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09/*
> +=09 * For the case where a NPEM command has not completed immediately,
> +=09 * it is recommended that software not continuously =E2=80=9Cspin=E2=
=80=9D on polling
> +=09 * the status register, but rather poll under interrupt at a reduced
> +=09 * rate; for example at 10 ms intervals.
> +=09 *
> +=09 * PCIe r6.1 sec 6.28 "Implementation Note: Software Polling of NPEM
> +=09 * Command Completed"
> +=09 */
> +=09ret =3D read_poll_timeout(npem_read_reg, ret_val,
> +=09=09=09=09ret_val || (cc_status & PCI_NPEM_STATUS_CC),
> +=09=09=09=0910 * USEC_PER_MSEC, USEC_PER_SEC, false, npem,
> +=09=09=09=09PCI_NPEM_STATUS, &cc_status);
> +=09if (ret)
> +=09=09return ret_val;
> +
> +=09/*
> +=09 * All writes to control register, including writes that do not chang=
e
> +=09 * the register value, are NPEM commands and should eventually result
> +=09 * in a command completion indication in the NPEM Status Register.
> +=09 *
> +=09 * PCIe Base Specification r6.1 sec 7.9.19.3
> +=09 *
> +=09 * Register may not be updated, or other conflicting bits may be
> +=09 * cleared. Spec is not strict here. Read NPEM Control register after
> +=09 * write to keep cache in-sync.
> +=09 */
> +=09return npem_get_active_indications(npem, &npem->active_indications);
> +}
> +
> +static const struct npem_ops npem_ops =3D {
> +=09.inds =3D npem_indications,
> +=09.get_active_indications =3D npem_get_active_indications,
> +=09.set_active_indications =3D npem_set_active_indications,
> +};
> +
> +#define DSM_GUID GUID_INIT(0x5d524d9d, 0xfff9, 0x4d4b,  0x8c, 0xb7, 0x74=
, 0x7e,\
> +=09=09=09   0xd5, 0x1e, 0x19, 0x4d)
> +#define GET_SUPPORTED_STATES_DSM=09BIT(1)
> +#define GET_STATE_DSM=09=09=09BIT(2)
> +#define SET_STATE_DSM=09=09=09BIT(3)
> +
> +static const guid_t dsm_guid =3D DSM_GUID;
> +
> +static bool npem_has_dsm(struct pci_dev *pdev)
> +{
> +=09acpi_handle handle;
> +
> +=09handle =3D ACPI_HANDLE(&pdev->dev);
> +=09if (!handle)
> +=09=09return false;
> +
> +=09return acpi_check_dsm(handle, &dsm_guid, 0x1, GET_SUPPORTED_STATES_DS=
M |
> +=09=09=09      GET_STATE_DSM | SET_STATE_DSM);
> +}
> +
> +/*
> + * This function does not use ops->get_active_indications().
> + * It returns cached value, npem->npem_lock is held and it is safe.
> + */
> +static enum led_brightness brightness_get(struct led_classdev *led)
> +{
> +=09struct npem_led *nled =3D container_of(led, struct npem_led, led);
> +=09struct npem *npem =3D nled->npem;
> +=09int ret, val =3D LED_OFF;
> +
> +=09ret =3D mutex_lock_interruptible(&npem->npem_lock);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09if (npem->active_indications & nled->indication->bit)
> +=09=09val =3D LED_ON;
> +
> +=09mutex_unlock(&npem->npem_lock);
> +
> +=09return val;
> +}
> +
> +static int brightness_set(struct led_classdev *led,
> +=09=09=09  enum led_brightness brightness)
> +{
> +=09struct npem_led *nled =3D container_of(led, struct npem_led, led);
> +=09struct npem *npem =3D nled->npem;
> +=09u32 indications;
> +=09int ret;
> +
> +=09ret =3D mutex_lock_interruptible(&npem->npem_lock);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09if (brightness =3D=3D LED_OFF)
> +=09=09indications =3D npem->active_indications & ~(nled->indication->bit=
);
> +=09else
> +=09=09indications =3D npem->active_indications | nled->indication->bit;
> +
> +=09ret =3D npem->ops->set_active_indications(npem, indications);
> +
> +=09mutex_unlock(&npem->npem_lock);
> +=09return ret;
> +}
> +
> +static void npem_free(struct npem *npem)
> +{
> +=09struct npem_led *nled;
> +=09int cnt;
> +
> +=09for (cnt =3D 0; cnt < npem->led_cnt; cnt++) {
> +=09=09nled =3D &npem->leds[cnt];
> +
> +=09=09if (nled->name[0])
> +=09=09=09led_classdev_unregister(&nled->led);
> +=09}
> +
> +=09mutex_destroy(&npem->npem_lock);
> +=09kfree(npem);
> +}
> +
> +static int pci_npem_set_led_classdev(struct npem *npem, struct npem_led =
*nled)
> +{
> +=09struct led_classdev *led =3D &nled->led;
> +=09struct led_init_data init_data =3D {};
> +=09char *name =3D nled->name;
> +=09int ret;
> +
> +=09init_data.devicename =3D pci_name(npem->dev);
> +=09init_data.default_label =3D nled->indication->name;
> +
> +=09ret =3D led_compose_name(&npem->dev->dev, &init_data, name);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09led->name =3D name;
> +=09led->brightness_set_blocking =3D brightness_set;
> +=09led->brightness_get =3D brightness_get;
> +=09led->max_brightness =3D LED_ON;
> +=09led->default_trigger =3D "none";
> +=09led->flags =3D 0;
> +
> +=09ret =3D led_classdev_register(&npem->dev->dev, led);
> +=09if (ret)
> +=09=09/* Clear the name to indicate that it is not registered. */
> +=09=09name[0] =3D 0;
> +=09return ret;
> +}
> +
> +static int pci_npem_init(struct pci_dev *dev, const struct npem_ops *ops=
,
> +=09=09=09 int pos, u32 caps)
> +{
> +=09u32 supported =3D reg_to_indications(caps, ops->inds);
> +=09int supported_cnt =3D hweight32(supported);
> +=09const struct indication *indication;
> +=09struct npem_led *nled;
> +=09struct npem *npem;
> +=09int led_idx =3D 0;
> +=09u32 active;
> +=09int ret;
> +
> +=09npem =3D kzalloc(struct_size(npem, leds, supported_cnt), GFP_KERNEL);
> +
> +=09if (!npem)
> +=09=09return -ENOMEM;

Don't leave empty line between func and it's error handling.

> +
> +=09npem->supported_indications =3D supported;
> +=09npem->led_cnt =3D supported_cnt;
> +=09npem->pos =3D pos;
> +=09npem->dev =3D dev;
> +=09npem->ops =3D ops;
> +
> +=09ret =3D ops->get_active_indications(npem, &active);
> +=09if (ret) {
> +=09=09npem_free(npem);

Just call kfree() directly here. As is, you're calling mutex_destroy()=20
before mutex_init().

> +=09=09return -EACCES;
> +=09}
> +
> +=09npem->active_indications =3D reg_to_indications(active, ops->inds);
> +
> +=09/*
> +=09 * Do not take npem->npem_lock, get_brightness() is called on
> +=09 * registration path.
> +=09 */
> +=09mutex_init(&npem->npem_lock);
> +
> +=09for_each_indication(indication, npem_indications) {
> +=09=09if ((npem->supported_indications & indication->bit) =3D=3D 0)

if (!(...))

> +=09=09=09/* Do not register unsupported indication */

This sounds quite obvious comment, I'd drop it.

> +=09=09=09continue;
> +
> +=09=09nled =3D &npem->leds[led_idx++];
> +=09=09nled->indication =3D indication;
> +=09=09nled->npem =3D npem;
> +
> +=09=09ret =3D pci_npem_set_led_classdev(npem, nled);
> +=09=09if (ret) {
> +=09=09=09npem_free(npem);
> +=09=09=09return ret;
> +=09=09}
> +=09}
> +
> +=09dev->npem =3D npem;
> +=09return 0;
> +}
> +
> +void pci_npem_remove(struct pci_dev *dev)
> +{
> +=09if (dev->npem)
> +=09=09npem_free(dev->npem);
> +}
> +
> +void pci_npem_create(struct pci_dev *dev)
> +{
> +=09const struct npem_ops *ops =3D &npem_ops;
> +=09int pos =3D 0, ret;
> +=09u32 cap;
> +
> +=09if (!npem_has_dsm(dev)) {
> +=09=09pos =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_NPEM);
> +=09=09if (pos =3D=3D 0)
> +=09=09=09return;
> +
> +=09=09if (pci_read_config_dword(dev, pos + PCI_NPEM_CAP, &cap) !=3D 0 ||
> +=09=09    (cap & PCI_NPEM_CAP_CAPABLE) =3D=3D 0)
> +=09=09=09return;
> +=09} else {
> +=09=09/*
> +=09=09 * OS should use the DSM for LED control if it is available
> +=09=09 * PCI Firmware Spec r3.3 sec 4.7.
> +=09=09 */
> +=09=09return;
> +=09}
> +
> +=09ret =3D pci_npem_init(dev, ops, pos, cap);
> +=09if (ret)
> +=09=09pci_err(dev, "Failed to register PCIe Enclosure Management driver,=
 err: %d\n",
> +=09=09=09ret);
> +}
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index fd44565c4756..9dea8c7353ab 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -333,6 +333,14 @@ static inline void pci_doe_destroy(struct pci_dev *p=
dev) { }
>  static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
>  #endif
> =20
> +#ifdef CONFIG_PCI_NPEM
> +void pci_npem_create(struct pci_dev *dev);
> +void pci_npem_remove(struct pci_dev *dev);
> +#else
> +static inline void pci_npem_create(struct pci_dev *dev) { }
> +static inline void pci_npem_remove(struct pci_dev *dev) { }
> +#endif
> +
>  /**
>   * pci_dev_set_io_state - Set the new error state if possible.
>   *
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 8e696e547565..b8ea6353e27a 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2582,6 +2582,8 @@ void pci_device_add(struct pci_dev *dev, struct pci=
_bus *bus)
>  =09dev->match_driver =3D false;
>  =09ret =3D device_add(&dev->dev);
>  =09WARN_ON(ret < 0);
> +
> +=09pci_npem_create(dev);
>  }
> =20
>  struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index d749ea8250d6..1436f9cf1fea 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -33,6 +33,8 @@ static void pci_destroy_dev(struct pci_dev *dev)
>  =09if (!dev->dev.kobj.parent)
>  =09=09return;
> =20
> +=09pci_npem_remove(dev);
> +
>  =09device_del(&dev->dev);
> =20
>  =09down_write(&pci_bus_sem);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index fb004fd4e889..c327c2dd4527 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -517,6 +517,9 @@ struct pci_dev {
>  #endif
>  #ifdef CONFIG_PCI_DOE
>  =09struct xarray=09doe_mbs;=09/* Data Object Exchange mailboxes */
> +#endif
> +#ifdef CONFIG_PCI_NPEM
> +=09struct npem=09*npem;=09=09/* Native PCIe Enclosure Management */
>  #endif
>  =09u16=09=09acs_cap;=09/* ACS Capability offset */
>  =09phys_addr_t=09rom;=09=09/* Physical address if not from BAR */
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.=
h
> index 94c00996e633..97e8b7ed9998 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -740,6 +740,7 @@
>  #define PCI_EXT_CAP_ID_DVSEC=090x23=09/* Designated Vendor-Specific */
>  #define PCI_EXT_CAP_ID_DLF=090x25=09/* Data Link Feature */
>  #define PCI_EXT_CAP_ID_PL_16GT=090x26=09/* Physical Layer 16.0 GT/s */
> +#define PCI_EXT_CAP_ID_NPEM=090x29=09/* Native PCIe Enclosure Management=
 */
>  #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
>  #define PCI_EXT_CAP_ID_DOE=090x2E=09/* Data Object Exchange */
>  #define PCI_EXT_CAP_ID_MAX=09PCI_EXT_CAP_ID_DOE
> @@ -1121,6 +1122,39 @@
>  #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_MASK=09=090x000000F0
>  #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_SHIFT=094
> =20
> +/* Native PCIe Enclosure Management */
> +#define PCI_NPEM_CAP=090x04 /* NPEM capability register */
> +#define=09 PCI_NPEM_CAP_CAPABLE=09=090x00000001 /* NPEM Capable */
> +
> +#define PCI_NPEM_CTRL=090x08 /* NPEM control register */
> +#define=09 PCI_NPEM_CTRL_ENABLE=09=090x00000001 /* NPEM Enable */

I think the rest of the bits would belong here or after=20
PCI_NPEM_CAP_CAPABLE.

> +#define PCI_NPEM_STATUS=090x0c /* NPEM status register */
> +#define=09 PCI_NPEM_STATUS_CC=09=090x00000001 /* NPEM Command completed =
*/
> +/*
> + * Native PCIe Enclosure Management indication bits and Reset command bi=
t
> + * are corresponding for capability and control registers.
> + */
> +#define  PCI_NPEM_CMD_RESET=09=090x00000002 /* NPEM Reset Command */
> +#define  PCI_NPEM_IND_OK=09=090x00000004 /* NPEM indication OK */
> +#define  PCI_NPEM_IND_LOCATE=09=090x00000008 /* NPEM indication Locate *=
/
> +#define  PCI_NPEM_IND_FAIL=09=090x00000010 /* NPEM indication Fail */
> +#define  PCI_NPEM_IND_REBUILD=09=090x00000020 /* NPEM indication Rebuild=
 */
> +#define  PCI_NPEM_IND_PFA=09=090x00000040 /* NPEM indication Predicted F=
ailure Analysis */
> +#define  PCI_NPEM_IND_HOTSPARE=09=090x00000080 /* NPEM indication Hot Sp=
are */
> +#define  PCI_NPEM_IND_ICA=09=090x00000100 /* NPEM indication In Critical=
 Array */
> +#define  PCI_NPEM_IND_IFA=09=090x00000200 /* NPEM indication In Failed A=
rray */
> +#define  PCI_NPEM_IND_IDT=09=090x00000400 /* NPEM indication Invalid Dev=
ice Type */
> +#define  PCI_NPEM_IND_DISABLED=09=090x00000800 /* NPEM indication Disabl=
ed */

> +#define  PCI_NPEM_IND_SPEC_0=09=090x00800000
> +#define  PCI_NPEM_IND_SPEC_1=09=090x01000000
> +#define  PCI_NPEM_IND_SPEC_2=09=090x02000000
> +#define  PCI_NPEM_IND_SPEC_3=09=090x04000000
> +#define  PCI_NPEM_IND_SPEC_4=09=090x08000000
> +#define  PCI_NPEM_IND_SPEC_5=09=090x10000000
> +#define  PCI_NPEM_IND_SPEC_6=09=090x20000000
> +#define  PCI_NPEM_IND_SPEC_7=09=090x40000000

Are these off-by-one, shouldn't that field go all the way to the last bit=
=20
which is 0x80000000 (the field is 31:24)??

--=20
 i.

--8323328-1650766853-1716904516=:5869--

