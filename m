Return-Path: <linux-pci+bounces-36664-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFE2B91496
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 15:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12AAC163990
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 13:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F283081C8;
	Mon, 22 Sep 2025 13:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PFiSBkao"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4038C120;
	Mon, 22 Sep 2025 13:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546375; cv=none; b=VdFj1QUt7PhegrbSefE/PkaGJcREP33+LSki6OvjhmQdEtLXxpYMfehtVPuzIB+pZiGVzUvUXtWw0SU7ytuySDKDkZxvemC3kxrz4q6gbYa8VCNfn2v0eroChkhhtYGdEWVwiVhyhXDg3yL6ZSW1+1MLZyt6P4uKbreCQeMl78U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546375; c=relaxed/simple;
	bh=PKJNjqlXn1ulY21TbFD+0/bx79EDenH0jPVwLf94fRQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UANTzlYyWNOoH2Vble5GorOhKDtFkXQtI8O4cgf4/slq9Fw7yepeu74f3UmARl2aqVZhFDei7mM+8mw3Of2MJef986esHXJaOkSWKnh2yaC+ICMHTHyRZ1wzhx2q6DkHrAIe/ZpZS6qjr38pXwapDikxzAGpYCBBhXzbidKeYpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PFiSBkao; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758546373; x=1790082373;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=PKJNjqlXn1ulY21TbFD+0/bx79EDenH0jPVwLf94fRQ=;
  b=PFiSBkaoFISWCYXpxwz0oPZ97MQPM2kfu79BeabkQweUO1afzqlvgZcG
   qzC3s0mWxpWnzn/IDI8wN3oBonvNybA891ymlsNfu9lRJzl2EyIIC5GtK
   rdlGAzbgvoytspH4Qo5o/eSHN8gmp+85oCuiZf0aaYqJRtgidKrCofvMq
   Dwq6oHpU6jQG8BjmMg5wSr9gfQ4aJjnrB5KnyxiN8L5MG+Qwwsfuj759u
   q9ClangEoZwtCF/BcDW6PFPTSfMUs8VmudMUhGsxejeev3o+KkTiQGodv
   1NEFY4gym9szcH9zwk3AqHTMEi66nuIwlSh4N3D+3N/aawYv9Dy7frdol
   Q==;
X-CSE-ConnectionGUID: rZA383jORI67gcEV8G6B1g==
X-CSE-MsgGUID: D5YRYB8WSHuUo/RM0pVDNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11560"; a="64446649"
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="64446649"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 06:06:12 -0700
X-CSE-ConnectionGUID: nShyirHKRD67tlzgg/FT2A==
X-CSE-MsgGUID: tF+VjTRBTN2GnhpuTBXxZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="181620223"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.150])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 06:06:05 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 22 Sep 2025 16:06:00 +0300 (EEST)
To: Shuai Xue <xueshuai@linux.alibaba.com>
cc: rostedt@goodmis.org, Lukas Wunner <lukas@wunner.de>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
    helgaas@kernel.org, mattc@purestorage.com, Jonathan.Cameron@huawei.com, 
    bhelgaas@google.com, tony.luck@intel.com, bp@alien8.de, 
    mhiramat@kernel.org, mathieu.desnoyers@efficios.com, oleg@redhat.com, 
    naveen@kernel.org, davem@davemloft.net, anil.s.keshavamurthy@intel.com, 
    mark.rutland@arm.com, peterz@infradead.org, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v10 2/3] PCI: trace: Add a RAS tracepoint to monitor link
 speed changes
In-Reply-To: <20250920060117.866-3-xueshuai@linux.alibaba.com>
Message-ID: <74cc8672-8e21-41e6-1535-2c504d90bbe0@linux.intel.com>
References: <20250920060117.866-1-xueshuai@linux.alibaba.com> <20250920060117.866-3-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-869169199-1758546177=:981"
Content-ID: <f7c8ee4a-3cba-d1af-49f2-f02f07255b57@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-869169199-1758546177=:981
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <72eb1253-d5e1-82e3-6b40-8e1db7629aae@linux.intel.com>

On Sat, 20 Sep 2025, Shuai Xue wrote:

> PCIe link speed degradation directly impacts system performance and
> often indicates hardware issues such as faulty devices, physical layer
> problems, or configuration errors.
>=20
> To this end, add a RAS tracepoint to monitor link speed changes,
> enabling proactive health checks and diagnostic analysis.
>=20
> The following output is generated when a device is hotplugged:
>=20
> $ echo 1 > /sys/kernel/debug/tracing/events/pci/pcie_link_event/enable
> $ cat /sys/kernel/debug/tracing/trace_pipe
>    irq/51-pciehp-88      [001] .....   381.545386: pcie_link_event: 0000:=
00:02.0 type:4, reason:4, cur_bus_speed:2.5 GT/s PCIe, max_bus_speed:16.0 G=
T/s PCIe, width:1, flit_mode:0, status:DLLLA
>=20
> Suggested-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Suggested-by: Matthew W Carlis <mattc@purestorage.com>
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>  drivers/pci/hotplug/pciehp_hpc.c |  3 +-
>  drivers/pci/pci.c                |  2 +-
>  drivers/pci/pci.h                | 22 +++++++++++--
>  drivers/pci/pcie/bwctrl.c        |  4 +--
>  drivers/pci/probe.c              |  9 +++--
>  include/linux/pci.h              |  1 +
>  include/trace/events/pci.h       | 56 ++++++++++++++++++++++++++++++++
>  7 files changed, 87 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pcieh=
p_hpc.c
> index bcc51b26d03d..ad5f28f6a8b1 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -320,7 +320,8 @@ int pciehp_check_link_status(struct controller *ctrl)
>  =09}
> =20
>  =09pcie_capability_read_word(pdev, PCI_EXP_LNKSTA2, &linksta2);
> -=09__pcie_update_link_speed(ctrl->pcie->port->subordinate, lnk_status, l=
inksta2);
> +=09__pcie_update_link_speed(ctrl->pcie->port->subordinate, PCIE_HOTPLUG,
> +=09=09=09=09 lnk_status, linksta2);
> =20
>  =09if (!found) {
>  =09=09ctrl_info(ctrl, "Slot(%s): No device found\n",
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b0f4d98036cd..96755ffd3841 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4749,7 +4749,7 @@ int pcie_retrain_link(struct pci_dev *pdev, bool us=
e_lt)
>  =09 * Link Speed.
>  =09 */
>  =09if (pdev->subordinate)
> -=09=09pcie_update_link_speed(pdev->subordinate);
> +=09=09pcie_update_link_speed(pdev->subordinate, PCIE_LINK_RETRAIN);
> =20
>  =09return rc;
>  }
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index b8d364545e7d..422406a0695c 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -3,6 +3,7 @@
>  #define DRIVERS_PCI_H
> =20
>  #include <linux/pci.h>
> +#include <trace/events/pci.h>
> =20
>  struct pcie_tlp_log;
> =20
> @@ -455,16 +456,31 @@ static inline int pcie_dev_speed_mbps(enum pci_bus_=
speed speed)
>  }
> =20
>  u8 pcie_get_supported_speeds(struct pci_dev *dev);
> -const char *pci_speed_string(enum pci_bus_speed speed);
>  void __pcie_print_link_status(struct pci_dev *dev, bool verbose);
>  void pcie_report_downtraining(struct pci_dev *dev);
> =20
> -static inline void __pcie_update_link_speed(struct pci_bus *bus, u16 lin=
ksta, u16 linksta2)
> +enum pcie_link_change_reason {
> +=09PCIE_LINK_RETRAIN,
> +=09PCIE_ADD_BUS,
> +=09PCIE_BWCTRL_ENABLE,
> +=09PCIE_BWCTRL_IRQ,
> +=09PCIE_HOTPLUG

Please use comma on any non-terminator entry so that adding to the list=20
later will not mess up diffs.

> +};
> +
> +static inline void __pcie_update_link_speed(struct pci_bus *bus,
> +=09=09=09=09=09    enum pcie_link_change_reason reason,
> +=09=09=09=09=09    u16 linksta, u16 linksta2)
>  {
>  =09bus->cur_bus_speed =3D pcie_link_speed[linksta & PCI_EXP_LNKSTA_CLS];
>  =09bus->flit_mode =3D (linksta2 & PCI_EXP_LNKSTA2_FLIT) ? 1 : 0;
> +
> +=09trace_pcie_link_event(bus,
> +=09=09=09     reason,
> +=09=09=09     FIELD_GET(PCI_EXP_LNKSTA_NLW, linksta),
> +=09=09=09     linksta & PCI_EXP_LNKSTA_LINK_STATUS_MASK);
>  }
> -void pcie_update_link_speed(struct pci_bus *bus);
> +
> +void pcie_update_link_speed(struct pci_bus *bus, enum pcie_link_change_r=
eason reason);
> =20
>  /* Single Root I/O Virtualization */
>  struct pci_sriov {
> diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
> index 36f939f23d34..32f1b30ecb84 100644
> --- a/drivers/pci/pcie/bwctrl.c
> +++ b/drivers/pci/pcie/bwctrl.c
> @@ -199,7 +199,7 @@ static void pcie_bwnotif_enable(struct pcie_device *s=
rv)
>  =09 * Update after enabling notifications & clearing status bits ensures
>  =09 * link speed is up to date.
>  =09 */
> -=09pcie_update_link_speed(port->subordinate);
> +=09pcie_update_link_speed(port->subordinate, PCIE_BWCTRL_ENABLE);
>  }
> =20
>  static void pcie_bwnotif_disable(struct pci_dev *port)
> @@ -234,7 +234,7 @@ static irqreturn_t pcie_bwnotif_irq(int irq, void *co=
ntext)
>  =09 * speed (inside pcie_update_link_speed()) after LBMS has been
>  =09 * cleared to avoid missing link speed changes.
>  =09 */
> -=09pcie_update_link_speed(port->subordinate);
> +=09pcie_update_link_speed(port->subordinate, PCIE_BWCTRL_IRQ);
> =20
>  =09return IRQ_HANDLED;
>  }
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index f41128f91ca7..c4cae2664156 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -21,6 +21,7 @@
>  #include <linux/irqdomain.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/bitfield.h>
> +#include <trace/events/pci.h>
>  #include "pci.h"
> =20
>  #define CARDBUS_LATENCY_TIMER=09176=09/* secondary latency timer */
> @@ -788,14 +789,16 @@ const char *pci_speed_string(enum pci_bus_speed spe=
ed)
>  }
>  EXPORT_SYMBOL_GPL(pci_speed_string);
> =20
> -void pcie_update_link_speed(struct pci_bus *bus)
> +void pcie_update_link_speed(struct pci_bus *bus,
> +=09=09=09    enum pcie_link_change_reason reason)
>  {
>  =09struct pci_dev *bridge =3D bus->self;
>  =09u16 linksta, linksta2;
> =20
>  =09pcie_capability_read_word(bridge, PCI_EXP_LNKSTA, &linksta);
>  =09pcie_capability_read_word(bridge, PCI_EXP_LNKSTA2, &linksta2);
> -=09__pcie_update_link_speed(bus, linksta, linksta2);
> +
> +=09__pcie_update_link_speed(bus, reason, linksta, linksta2);
>  }
>  EXPORT_SYMBOL_GPL(pcie_update_link_speed);
> =20
> @@ -882,7 +885,7 @@ static void pci_set_bus_speed(struct pci_bus *bus)
>  =09=09pcie_capability_read_dword(bridge, PCI_EXP_LNKCAP, &linkcap);
>  =09=09bus->max_bus_speed =3D pcie_link_speed[linkcap & PCI_EXP_LNKCAP_SL=
S];
> =20
> -=09=09pcie_update_link_speed(bus);
> +=09=09pcie_update_link_speed(bus, PCIE_ADD_BUS);
>  =09}
>  }
> =20
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 59876de13860..edd8a61ec44e 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -305,6 +305,7 @@ enum pci_bus_speed {
>  =09PCI_SPEED_UNKNOWN=09=09=3D 0xff,
>  };
> =20
> +const char *pci_speed_string(enum pci_bus_speed speed);
>  enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
>  enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
> =20
> diff --git a/include/trace/events/pci.h b/include/trace/events/pci.h
> index 208609492c06..78e651b95cb3 100644
> --- a/include/trace/events/pci.h
> +++ b/include/trace/events/pci.h
> @@ -57,6 +57,62 @@ TRACE_EVENT(pci_hp_event,
>  =09)
>  );
> =20
> +#define PCI_EXP_LNKSTA_LINK_STATUS_MASK (PCI_EXP_LNKSTA_LBMS | \
> +=09=09=09=09=09 PCI_EXP_LNKSTA_LABS | \
> +=09=09=09=09=09 PCI_EXP_LNKSTA_LT | \
> +=09=09=09=09=09 PCI_EXP_LNKSTA_DLLLA)

This looks fragile because of the headers, I don't think there anything=20
that pulls these required defines within this header itself (so it only=20
works because the .c files have the pci.h include before it so that that=20
the defines from uapi side will be include).

If it's allowed for these files, you should include uapi/linux/pci_regs.h.

> +
> +#define LNKSTA_FLAGS=09=09=09=09=09\
> +=09{ PCI_EXP_LNKSTA_LT,=09"LT"},=09=09=09\
> +=09{ PCI_EXP_LNKSTA_DLLLA,=09"DLLLA"},=09=09\
> +=09{ PCI_EXP_LNKSTA_LBMS,=09"LBMS"},=09=09\
> +=09{ PCI_EXP_LNKSTA_LABS,=09"LABS"}
> +
> +TRACE_EVENT(pcie_link_event,
> +
> +=09TP_PROTO(struct pci_bus *bus,
> +=09=09  unsigned int reason,
> +=09=09  unsigned int width,
> +=09=09  unsigned int status
> +=09=09),
> +
> +=09TP_ARGS(bus, reason, width, status),
> +
> +=09TP_STRUCT__entry(
> +=09=09__string(=09port_name,=09pci_name(bus->self))
> +=09=09__field(=09unsigned int,=09type=09=09)
> +=09=09__field(=09unsigned int,=09reason=09=09)
> +=09=09__field(=09unsigned int,=09cur_bus_speed=09)
> +=09=09__field(=09unsigned int,=09max_bus_speed=09)
> +=09=09__field(=09unsigned int,=09width=09=09)
> +=09=09__field(=09unsigned int,=09flit_mode=09)
> +=09=09__field(=09unsigned int,=09link_status=09)
> +=09),
> +
> +=09TP_fast_assign(
> +=09=09__assign_str(port_name);
> +=09=09__entry->type=09=09=09=3D pci_pcie_type(bus->self);
> +=09=09__entry->reason=09=09=09=3D reason;
> +=09=09__entry->cur_bus_speed=09=09=3D bus->cur_bus_speed;
> +=09=09__entry->max_bus_speed=09=09=3D bus->max_bus_speed;
> +=09=09__entry->width=09=09=09=3D width;
> +=09=09__entry->flit_mode=09=09=3D bus->flit_mode;
> +=09=09__entry->link_status=09=09=3D status;
> +=09),
> +
> +=09TP_printk("%s type:%d, reason:%d, cur_bus_speed:%s, max_bus_speed:%s,=
 width:%u, flit_mode:%u, status:%s\n",
> +=09=09__get_str(port_name),
> +=09=09__entry->type,
> +=09=09__entry->reason,
> +=09=09pci_speed_string(__entry->cur_bus_speed),
> +=09=09pci_speed_string(__entry->max_bus_speed),
> +=09=09__entry->width,
> +=09=09__entry->flit_mode,
> +=09=09__print_flags((unsigned long)__entry->link_status, "|",
> +=09=09=09=09LNKSTA_FLAGS)
> +=09)
> +);
> +
>  #endif /* _TRACE_HW_EVENT_PCI_H */
> =20
>  /* This part must be outside protection */
>=20

--=20
 i.
--8323328-869169199-1758546177=:981--

