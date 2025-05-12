Return-Path: <linux-pci+bounces-27596-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B84AB3EBE
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 19:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 264283B0F90
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 17:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD88F295DB5;
	Mon, 12 May 2025 17:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tx1zyBx2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354AA1E505;
	Mon, 12 May 2025 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747070041; cv=none; b=fGio/izrcmJQi4/oIrpMjwU7aQ1gDF9Dz2oZfUBT1C5J7G/m3kjHyYj4hHeJ230TifkMXsIpagCGwVX6THo6rrdjxPbtMXSvp5rBxK1t+4xMXSI/XK0PY5Zwo0nYof6WOZSM3pJKw6Fpx25dQ7orUP86vH6nHrt7QQZVAi4BfvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747070041; c=relaxed/simple;
	bh=z3oHVpjrI0fnUfjvO3LRVBDeAH0cw64BwvcMoerJOJk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=es7TQR1at5RZoQLQBpmXA9oeguOewIS51zkYgmGPAnn01Vn0qpFqwXpzX3BhYQUg6CkrswZpll02yEBGFUs5sm0asyGYaAzRULXZ+dA8dMz3/+BJpoXqr5utuYhBci9U3p+LJRcW6R58uR+j2TR4axg8vIqcOQTNJzLpgK3iBAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tx1zyBx2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747070039; x=1778606039;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=z3oHVpjrI0fnUfjvO3LRVBDeAH0cw64BwvcMoerJOJk=;
  b=Tx1zyBx29/d6WFKijOYB0VAEqdN6WK4EnJz7g2wzMVcFmcgQGkeOM5RE
   fEwpst3z80WmtifHZhdxW9b72y+DmyPadRo8Ti0LuoxRFdRJFZhwZCCsl
   z+8Cp70t0YALuy7gbu5EH19nigpVVoOzT2bi7xMkNlmuQPeidR9zhCrmB
   TLmzP3CdzWM9A4HvPtbvbk4+Xo76kFlvHdBTVwL1lg2SsRjhC5VwFK7pW
   uyxwx9FUjzKX76zl0DwEaEpZP9eFVvgQ0x3daQfzvzVmEhwhibX3TQPpp
   ojBOqhSMslxqXxCC7+HVFKL1EKz71KEUcN22aoipdtoP5dZtglxcwxtW0
   w==;
X-CSE-ConnectionGUID: PX3Xla6sTdiSfeW3n5jIZA==
X-CSE-MsgGUID: uB3L4qEuTpqbbjhHERrdFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="74274297"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="74274297"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 10:13:58 -0700
X-CSE-ConnectionGUID: m97y/jB4TOOiPs4duaN1Gg==
X-CSE-MsgGUID: a5Vz+Gg6RFiz7e67lZltOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="168355204"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.245])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 10:13:51 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 12 May 2025 20:13:47 +0300 (EEST)
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
cc: Shawn Anastasio <sanastasio@raptorengineering.com>, 
    linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
    Rob Herring <robh@kernel.o>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, 
    chaitanya chundru <quic_krichai@quicinc.com>, 
    Bjorn Andersson <andersson@kernel.org>, 
    Konrad Dybcio <konradybcio@kernel.org>, 
    cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>, 
    Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicnic.com, 
    amitk@kernel.org, devicetree@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org, 
    jorge.ramirez@oss.qualcomm.com, Dmitry Baryshkov <lumag@kernel.org>, 
    Timothy Pearson <tpearson@raptorengineering.com>
Subject: Re: [RESEND PATCH v6] PCI: PCI: Add pcie_link_is_active() to determine
 if the PCIe link is active
In-Reply-To: <9b662513-2c71-8829-3ec8-c789a919809a@oss.qualcomm.com>
Message-ID: <195d17db-6573-181f-a592-195f6fdbeee1@linux.intel.com>
References: <20250509180813.2200312-1-sanastasio@raptorengineering.com> <84ce803d-b9b6-0ae7-44fa-c793dca06421@linux.intel.com> <9b662513-2c71-8829-3ec8-c789a919809a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-620883656-1747070027=:929"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-620883656-1747070027=:929
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 12 May 2025, Krishna Chaitanya Chundru wrote:

>=20
>=20
> On 5/12/2025 5:20 PM, Ilpo J=C3=A4rvinen wrote:
> > On Fri, 9 May 2025, Shawn Anastasio wrote:
> >=20
> > In shortlog:
> >=20
> > PCI: PCI: ... -> PCI: ...
> >=20
> > > From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > >=20
> > > Date: Sat, 12 Apr 2025 07:19:56 +0530
> > >=20
> > > Introduce a common API to check if the PCIe link is active, replacing
> > > duplicate code in multiple locations.
> > >=20
> > > Signed-off-by: Krishna Chaitanya Chundru
> > > <krishna.chundru@oss.qualcomm.com>
> > > Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
> > > ---
> > > (Resent since git-send-email failed to detect the Subject field from =
the
> > > patch
> > > file previously -- apologies!)
> > >=20
> > > This is an updated patch pulled from Krishna's v5 series:
> > > https://patchwork.kernel.org/project/linux-pci/list/?series=3D952665
> > >=20
> > > The following changes to Krishna's v5 were made by me:
> > >    - Revert pcie_link_is_active return type back to int per Lukas' re=
view
> > >      comments
> > >    - Handle non-zero error returns at call site of the new function i=
n
> > >      pci.c/pci_bridge_wait_for_secondary_bus
> > >=20
> > >   drivers/pci/hotplug/pciehp.h      |  1 -
> > >   drivers/pci/hotplug/pciehp_ctrl.c |  2 +-
> > >   drivers/pci/hotplug/pciehp_hpc.c  | 33 +++-------------------------=
---
> > >   drivers/pci/pci.c                 | 26 +++++++++++++++++++++---
> > >   include/linux/pci.h               |  4 ++++
> > >   5 files changed, 31 insertions(+), 35 deletions(-)
> > >=20
> > > diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pcieh=
p.h
> > > index 273dd8c66f4e..acef728530e3 100644
> > > --- a/drivers/pci/hotplug/pciehp.h
> > > +++ b/drivers/pci/hotplug/pciehp.h
> > > @@ -186,7 +186,6 @@ int pciehp_query_power_fault(struct controller *c=
trl);
> > >   int pciehp_card_present(struct controller *ctrl);
> > >   int pciehp_card_present_or_link_active(struct controller *ctrl);
> > >   int pciehp_check_link_status(struct controller *ctrl);
> > > -int pciehp_check_link_active(struct controller *ctrl);
> > >   void pciehp_release_ctrl(struct controller *ctrl);
> > >=20
> > >   int pciehp_sysfs_enable_slot(struct hotplug_slot *hotplug_slot);
> > > diff --git a/drivers/pci/hotplug/pciehp_ctrl.c
> > > b/drivers/pci/hotplug/pciehp_ctrl.c
> > > index d603a7aa7483..4bb58ba1c766 100644
> > > --- a/drivers/pci/hotplug/pciehp_ctrl.c
> > > +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> > > @@ -260,7 +260,7 @@ void pciehp_handle_presence_or_link_change(struct
> > > controller *ctrl, u32 events)
> > >   =09/* Turn the slot on if it's occupied or link is up */
> > >   =09mutex_lock(&ctrl->state_lock);
> > >   =09present =3D pciehp_card_present(ctrl);
> > > -=09link_active =3D pciehp_check_link_active(ctrl);
> > > +=09link_active =3D pcie_link_is_active(ctrl->pcie->port);
> > >   =09if (present <=3D 0 && link_active <=3D 0) {
> > >   =09=09if (ctrl->state =3D=3D BLINKINGON_STATE) {
> > >   =09=09=09ctrl->state =3D OFF_STATE;
> > > diff --git a/drivers/pci/hotplug/pciehp_hpc.c
> > > b/drivers/pci/hotplug/pciehp_hpc.c
> > > index 8a09fb6083e2..278bc21d531d 100644
> > > --- a/drivers/pci/hotplug/pciehp_hpc.c
> > > +++ b/drivers/pci/hotplug/pciehp_hpc.c
> > > @@ -221,33 +221,6 @@ static void pcie_write_cmd_nowait(struct control=
ler
> > > *ctrl, u16 cmd, u16 mask)
> > >   =09pcie_do_write_cmd(ctrl, cmd, mask, false);
> > >   }
> > >=20
> > > -/**
> > > - * pciehp_check_link_active() - Is the link active
> > > - * @ctrl: PCIe hotplug controller
> > > - *
> > > - * Check whether the downstream link is currently active. Note it is
> > > - * possible that the card is removed immediately after this so the
> > > - * caller may need to take it into account.
> > > - *
> > > - * If the hotplug controller itself is not available anymore returns
> > > - * %-ENODEV.
> > > - */
> > > -int pciehp_check_link_active(struct controller *ctrl)
> > > -{
> > > -=09struct pci_dev *pdev =3D ctrl_dev(ctrl);
> > > -=09u16 lnk_status;
> > > -=09int ret;
> > > -
> > > -=09ret =3D pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_stat=
us);
> > > -=09if (ret =3D=3D PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(lnk=
_status))
> > > -=09=09return -ENODEV;
> > > -
> > > -=09ret =3D !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
> > > -=09ctrl_dbg(ctrl, "%s: lnk_status =3D %x\n", __func__, lnk_status);
> > > -
> > > -=09return ret;
> > > -}
> > > -
> > >   static bool pci_bus_check_dev(struct pci_bus *bus, int devfn)
> > >   {
> > >   =09u32 l;
> > > @@ -467,7 +440,7 @@ int pciehp_card_present_or_link_active(struct
> > > controller *ctrl)
> > >   =09if (ret)
> > >   =09=09return ret;
> > >=20
> > > -=09return pciehp_check_link_active(ctrl);
> > > +=09return pcie_link_is_active(ctrl_dev(ctrl));
> > >   }
> > >=20
> > >   int pciehp_query_power_fault(struct controller *ctrl)
> > > @@ -584,7 +557,7 @@ static void pciehp_ignore_dpc_link_change(struct
> > > controller *ctrl,
> > >   =09 * Synthesize it to ensure that it is acted on.
> > >   =09 */
> > >   =09down_read_nested(&ctrl->reset_lock, ctrl->depth);
> > > -=09if (!pciehp_check_link_active(ctrl))
> > > +=09if (!pcie_link_is_active(ctrl_dev(ctrl)))
> > >   =09=09pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
> > >   =09up_read(&ctrl->reset_lock);
> > >   }
> > > @@ -884,7 +857,7 @@ int pciehp_slot_reset(struct pcie_device *dev)
> > >   =09pcie_capability_write_word(dev->port, PCI_EXP_SLTSTA,
> > >   =09=09=09=09   PCI_EXP_SLTSTA_DLLSC);
> > >=20
> > > -=09if (!pciehp_check_link_active(ctrl))
> > > +=09if (!pcie_link_is_active(ctrl_dev(ctrl)))
> > >   =09=09pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
> > >=20
> > >   =09return 0;
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index e77d5b53c0ce..3bb8354b14bf 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -4926,7 +4926,6 @@ int pci_bridge_wait_for_secondary_bus(struct pc=
i_dev
> > > *dev, char *reset_type)
> > >   =09=09return 0;
> > >=20
> > >   =09if (pcie_get_speed_cap(dev) <=3D PCIE_SPEED_5_0GT) {
> > > -=09=09u16 status;
> > >=20
> > >   =09=09pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
> > >   =09=09msleep(delay);
> > > @@ -4942,8 +4941,7 @@ int pci_bridge_wait_for_secondary_bus(struct pc=
i_dev
> > > *dev, char *reset_type)
> > >   =09=09if (!dev->link_active_reporting)
> > >   =09=09=09return -ENOTTY;
> > >=20
> > > -=09=09pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &status);
> > > -=09=09if (!(status & PCI_EXP_LNKSTA_DLLLA))
> > > +=09=09if (pcie_link_is_active(dev) <=3D 0)
> > >   =09=09=09return -ENOTTY;
> > >=20
> > >   =09=09return pci_dev_wait(child, reset_type,
> > > @@ -6247,6 +6245,28 @@ void pcie_print_link_status(struct pci_dev *de=
v)
> > >   }
> > >   EXPORT_SYMBOL(pcie_print_link_status);
> > >=20
> > > +/**
> > > + * pcie_link_is_active() - Checks if the link is active or not
> > > + * @pdev: PCI device to query
> > > + *
> > > + * Check whether the link is active or not.
> > > + *
> > > + * Return: link state, or -ENODEV if the config read failes.
> >=20
> > "link state" is bit vague, it would be better to document the values
> > returned more precisely.
> >=20
> > > + */
> > > +int pcie_link_is_active(struct pci_dev *pdev)
> > > +{
> > > +=09u16 lnk_status;
> > > +=09int ret;
> > > +
> > > +=09ret =3D pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_stat=
us);
> > > +=09if (ret =3D=3D PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(lnk=
_status))
> > > +=09=09return -ENODEV;
> > > +
> > > +=09pci_dbg(pdev, "lnk_status =3D %x\n", lnk_status);
> > > +=09return !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
> > > +}
> > > +EXPORT_SYMBOL(pcie_link_is_active);
> > > +
> > >   /**
> > >    * pci_select_bars - Make BAR mask from the type of resource
> > >    * @dev: the PCI device for which BAR mask is made
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > index 51e2bd6405cd..a79a9919320c 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -1945,6 +1945,7 @@ pci_release_mem_regions(struct pci_dev *pdev)
> > >   =09=09=09    pci_select_bars(pdev, IORESOURCE_MEM));
> > >   }
> > >=20
> > > +int pcie_link_is_active(struct pci_dev *dev);
> >=20
> > Is this really needed in include/linux/pci.h, isn't drivers/pci/pci.h
> > enough (for pwrctrl in the Krishna's series)?
> >=20
> As this is generic functions, the endpoint drivers can also
> use this API to check if link is active or not in future.

Hi again,

Shouldn't the endpoint drivers use the generic RPM interfaces, not mess
with the Link state themselves? If Link is found to be up using this=20
function, how does that prove what's the state of the link the next=20
moment? To me this does not look like a very safe interface to be used by=
=20
the endpoint drivers.

--=20
 i.

--8323328-620883656-1747070027=:929--

