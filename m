Return-Path: <linux-pci+bounces-27597-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF91AB3EF1
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 19:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637431798C2
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 17:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B15296D1B;
	Mon, 12 May 2025 17:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kYD56jQm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFF2245022;
	Mon, 12 May 2025 17:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747070674; cv=none; b=KrGJ4ZaT8j2xpzQ8LhOgzpoT3Qnd88ZnA63htG1g7NHqSCculYo4c+kpjJvRCYvPraP2zTqSlzei+4jVZQT7neZkmcyMJRrL75ZHVtWB0VZl7g4wUjfMZlpM7l4VxQFvmjlJ1rYeEEIvzOu07nkhQLDUD2agBTWk+Vk1NgHC95g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747070674; c=relaxed/simple;
	bh=fvqm9UukaJY45MoeW/r6bqeWb4V8Jy/aWysEofEGPSY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mmQ44FDorJIaPNs3ofA5FjGHW97jMsqREkCjceWgzW7qrotk1kCMjqL9/7xdvw6uWYneeoUNN/vnbdMhHkBauAAZw1RQiE8RehkCoK4T4toUneB161kPtSdlvHosnFQboyAIuWgHPyuuskiPiUTdgB1koBDWfsuyZXQQ27IieYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kYD56jQm; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747070673; x=1778606673;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fvqm9UukaJY45MoeW/r6bqeWb4V8Jy/aWysEofEGPSY=;
  b=kYD56jQmd6y/2jILpwimr+BQ4s27jguxYmvYbPcWyK794J7ffioVQVDW
   nuv8j2rnrN80SQFGtFDfNuAiyRIfjHcLGKwyfR+YCbsTK7liwT1t34yf4
   fTlxfJ7C25kmmqKqtVKZl1h2qaDWN4b3S7EvPhBZgw9rI+AOkdzqCoxQb
   G6D0pezqpHRnwnOerRcDtQHLZXS3j0fPVIRMKinAW+13eNFR41OZs+nHR
   1QZjI6C9hC7PseTxyPmGk+BslolynCeqGh+/3zdARXrjsKjDgMIuZL0WO
   eGxtd29zhcnChuGgzf9XsMsf/NmdXAXb1UwqaPR3EBis5bBHiRiEBSA5E
   Q==;
X-CSE-ConnectionGUID: 5ikx0whdRr+Pn2ONwIdkaw==
X-CSE-MsgGUID: gyq7m2KLSN6RKYwjmAlpSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="59110124"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="59110124"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 10:24:32 -0700
X-CSE-ConnectionGUID: PLI4ih0aSru2pqaYXhUVhw==
X-CSE-MsgGUID: Fpl4D6+WRVis0d/EJ4i8ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="137369767"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.245])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 10:24:23 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 12 May 2025 20:24:20 +0300 (EEST)
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
    Shawn Anastasio <sanastasio@raptorengineering.com>
cc: linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
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
In-Reply-To: <195d17db-6573-181f-a592-195f6fdbeee1@linux.intel.com>
Message-ID: <ffaa3bc3-b8b4-6962-40d6-6d4784a47c19@linux.intel.com>
References: <20250509180813.2200312-1-sanastasio@raptorengineering.com> <84ce803d-b9b6-0ae7-44fa-c793dca06421@linux.intel.com> <9b662513-2c71-8829-3ec8-c789a919809a@oss.qualcomm.com> <195d17db-6573-181f-a592-195f6fdbeee1@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1874773260-1747070660=:929"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1874773260-1747070660=:929
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 12 May 2025, Ilpo J=C3=A4rvinen wrote:

> On Mon, 12 May 2025, Krishna Chaitanya Chundru wrote:
>=20
> >=20
> >=20
> > On 5/12/2025 5:20 PM, Ilpo J=C3=A4rvinen wrote:
> > > On Fri, 9 May 2025, Shawn Anastasio wrote:
> > >=20
> > > In shortlog:
> > >=20
> > > PCI: PCI: ... -> PCI: ...
> > >=20
> > > > From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > > >=20
> > > > Date: Sat, 12 Apr 2025 07:19:56 +0530
> > > >=20
> > > > Introduce a common API to check if the PCIe link is active, replaci=
ng
> > > > duplicate code in multiple locations.
> > > >=20
> > > > Signed-off-by: Krishna Chaitanya Chundru
> > > > <krishna.chundru@oss.qualcomm.com>
> > > > Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
> > > > ---
> > > > (Resent since git-send-email failed to detect the Subject field fro=
m the
> > > > patch
> > > > file previously -- apologies!)
> > > >=20
> > > > This is an updated patch pulled from Krishna's v5 series:
> > > > https://patchwork.kernel.org/project/linux-pci/list/?series=3D95266=
5
> > > >=20
> > > > The following changes to Krishna's v5 were made by me:
> > > >    - Revert pcie_link_is_active return type back to int per Lukas' =
review
> > > >      comments
> > > >    - Handle non-zero error returns at call site of the new function=
 in
> > > >      pci.c/pci_bridge_wait_for_secondary_bus
> > > >=20
> > > >   drivers/pci/hotplug/pciehp.h      |  1 -
> > > >   drivers/pci/hotplug/pciehp_ctrl.c |  2 +-
> > > >   drivers/pci/hotplug/pciehp_hpc.c  | 33 +++-----------------------=
-----
> > > >   drivers/pci/pci.c                 | 26 +++++++++++++++++++++---
> > > >   include/linux/pci.h               |  4 ++++
> > > >   5 files changed, 31 insertions(+), 35 deletions(-)
> > > >=20
> > > > diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pci=
ehp.h
> > > > index 273dd8c66f4e..acef728530e3 100644
> > > > --- a/drivers/pci/hotplug/pciehp.h
> > > > +++ b/drivers/pci/hotplug/pciehp.h
> > > > @@ -186,7 +186,6 @@ int pciehp_query_power_fault(struct controller =
*ctrl);
> > > >   int pciehp_card_present(struct controller *ctrl);
> > > >   int pciehp_card_present_or_link_active(struct controller *ctrl);
> > > >   int pciehp_check_link_status(struct controller *ctrl);
> > > > -int pciehp_check_link_active(struct controller *ctrl);
> > > >   void pciehp_release_ctrl(struct controller *ctrl);
> > > >=20
> > > >   int pciehp_sysfs_enable_slot(struct hotplug_slot *hotplug_slot);
> > > > diff --git a/drivers/pci/hotplug/pciehp_ctrl.c
> > > > b/drivers/pci/hotplug/pciehp_ctrl.c
> > > > index d603a7aa7483..4bb58ba1c766 100644
> > > > --- a/drivers/pci/hotplug/pciehp_ctrl.c
> > > > +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> > > > @@ -260,7 +260,7 @@ void pciehp_handle_presence_or_link_change(stru=
ct
> > > > controller *ctrl, u32 events)
> > > >   =09/* Turn the slot on if it's occupied or link is up */
> > > >   =09mutex_lock(&ctrl->state_lock);
> > > >   =09present =3D pciehp_card_present(ctrl);
> > > > -=09link_active =3D pciehp_check_link_active(ctrl);
> > > > +=09link_active =3D pcie_link_is_active(ctrl->pcie->port);
> > > >   =09if (present <=3D 0 && link_active <=3D 0) {
> > > >   =09=09if (ctrl->state =3D=3D BLINKINGON_STATE) {
> > > >   =09=09=09ctrl->state =3D OFF_STATE;
> > > > diff --git a/drivers/pci/hotplug/pciehp_hpc.c
> > > > b/drivers/pci/hotplug/pciehp_hpc.c
> > > > index 8a09fb6083e2..278bc21d531d 100644
> > > > --- a/drivers/pci/hotplug/pciehp_hpc.c
> > > > +++ b/drivers/pci/hotplug/pciehp_hpc.c
> > > > @@ -221,33 +221,6 @@ static void pcie_write_cmd_nowait(struct contr=
oller
> > > > *ctrl, u16 cmd, u16 mask)
> > > >   =09pcie_do_write_cmd(ctrl, cmd, mask, false);
> > > >   }
> > > >=20
> > > > -/**
> > > > - * pciehp_check_link_active() - Is the link active
> > > > - * @ctrl: PCIe hotplug controller
> > > > - *
> > > > - * Check whether the downstream link is currently active. Note it =
is
> > > > - * possible that the card is removed immediately after this so the
> > > > - * caller may need to take it into account.
> > > > - *
> > > > - * If the hotplug controller itself is not available anymore retur=
ns
> > > > - * %-ENODEV.
> > > > - */
> > > > -int pciehp_check_link_active(struct controller *ctrl)
> > > > -{
> > > > -=09struct pci_dev *pdev =3D ctrl_dev(ctrl);
> > > > -=09u16 lnk_status;
> > > > -=09int ret;
> > > > -
> > > > -=09ret =3D pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_st=
atus);
> > > > -=09if (ret =3D=3D PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(l=
nk_status))
> > > > -=09=09return -ENODEV;
> > > > -
> > > > -=09ret =3D !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
> > > > -=09ctrl_dbg(ctrl, "%s: lnk_status =3D %x\n", __func__, lnk_status)=
;
> > > > -
> > > > -=09return ret;
> > > > -}
> > > > -
> > > >   static bool pci_bus_check_dev(struct pci_bus *bus, int devfn)
> > > >   {
> > > >   =09u32 l;
> > > > @@ -467,7 +440,7 @@ int pciehp_card_present_or_link_active(struct
> > > > controller *ctrl)
> > > >   =09if (ret)
> > > >   =09=09return ret;
> > > >=20
> > > > -=09return pciehp_check_link_active(ctrl);
> > > > +=09return pcie_link_is_active(ctrl_dev(ctrl));
> > > >   }
> > > >=20
> > > >   int pciehp_query_power_fault(struct controller *ctrl)
> > > > @@ -584,7 +557,7 @@ static void pciehp_ignore_dpc_link_change(struc=
t
> > > > controller *ctrl,
> > > >   =09 * Synthesize it to ensure that it is acted on.
> > > >   =09 */
> > > >   =09down_read_nested(&ctrl->reset_lock, ctrl->depth);
> > > > -=09if (!pciehp_check_link_active(ctrl))
> > > > +=09if (!pcie_link_is_active(ctrl_dev(ctrl)))
> > > >   =09=09pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
> > > >   =09up_read(&ctrl->reset_lock);
> > > >   }
> > > > @@ -884,7 +857,7 @@ int pciehp_slot_reset(struct pcie_device *dev)
> > > >   =09pcie_capability_write_word(dev->port, PCI_EXP_SLTSTA,
> > > >   =09=09=09=09   PCI_EXP_SLTSTA_DLLSC);
> > > >=20
> > > > -=09if (!pciehp_check_link_active(ctrl))
> > > > +=09if (!pcie_link_is_active(ctrl_dev(ctrl)))
> > > >   =09=09pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
> > > >=20
> > > >   =09return 0;
> > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > index e77d5b53c0ce..3bb8354b14bf 100644
> > > > --- a/drivers/pci/pci.c
> > > > +++ b/drivers/pci/pci.c
> > > > @@ -4926,7 +4926,6 @@ int pci_bridge_wait_for_secondary_bus(struct =
pci_dev
> > > > *dev, char *reset_type)
> > > >   =09=09return 0;
> > > >=20
> > > >   =09if (pcie_get_speed_cap(dev) <=3D PCIE_SPEED_5_0GT) {
> > > > -=09=09u16 status;
> > > >=20
> > > >   =09=09pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
> > > >   =09=09msleep(delay);
> > > > @@ -4942,8 +4941,7 @@ int pci_bridge_wait_for_secondary_bus(struct =
pci_dev
> > > > *dev, char *reset_type)
> > > >   =09=09if (!dev->link_active_reporting)
> > > >   =09=09=09return -ENOTTY;
> > > >=20
> > > > -=09=09pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &status);
> > > > -=09=09if (!(status & PCI_EXP_LNKSTA_DLLLA))
> > > > +=09=09if (pcie_link_is_active(dev) <=3D 0)
> > > >   =09=09=09return -ENOTTY;
> > > >=20
> > > >   =09=09return pci_dev_wait(child, reset_type,
> > > > @@ -6247,6 +6245,28 @@ void pcie_print_link_status(struct pci_dev *=
dev)
> > > >   }
> > > >   EXPORT_SYMBOL(pcie_print_link_status);
> > > >=20
> > > > +/**
> > > > + * pcie_link_is_active() - Checks if the link is active or not
> > > > + * @pdev: PCI device to query
> > > > + *
> > > > + * Check whether the link is active or not.
> > > > + *
> > > > + * Return: link state, or -ENODEV if the config read failes.
> > >=20
> > > "link state" is bit vague, it would be better to document the values
> > > returned more precisely.
> > >=20
> > > > + */
> > > > +int pcie_link_is_active(struct pci_dev *pdev)
> > > > +{
> > > > +=09u16 lnk_status;
> > > > +=09int ret;
> > > > +
> > > > +=09ret =3D pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_st=
atus);
> > > > +=09if (ret =3D=3D PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(l=
nk_status))
> > > > +=09=09return -ENODEV;
> > > > +
> > > > +=09pci_dbg(pdev, "lnk_status =3D %x\n", lnk_status);
> > > > +=09return !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
> > > > +}
> > > > +EXPORT_SYMBOL(pcie_link_is_active);
> > > > +
> > > >   /**
> > > >    * pci_select_bars - Make BAR mask from the type of resource
> > > >    * @dev: the PCI device for which BAR mask is made
> > > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > > index 51e2bd6405cd..a79a9919320c 100644
> > > > --- a/include/linux/pci.h
> > > > +++ b/include/linux/pci.h
> > > > @@ -1945,6 +1945,7 @@ pci_release_mem_regions(struct pci_dev *pdev)
> > > >   =09=09=09    pci_select_bars(pdev, IORESOURCE_MEM));
> > > >   }
> > > >=20
> > > > +int pcie_link_is_active(struct pci_dev *dev);
> > >=20
> > > Is this really needed in include/linux/pci.h, isn't drivers/pci/pci.h
> > > enough (for pwrctrl in the Krishna's series)?
> > >=20
> > As this is generic functions, the endpoint drivers can also
> > use this API to check if link is active or not in future.
>=20
> Hi again,
>=20
> Shouldn't the endpoint drivers use the generic RPM interfaces, not mess
> with the Link state themselves? If Link is found to be up using this=20
> function, how does that prove what's the state of the link the next=20
> moment? To me this does not look like a very safe interface to be used by=
=20
> the endpoint drivers.

Now I even noticed that little detail got removed from the kerneldoc while=
=20
moving the function. Why?

--=20
 i.

--8323328-1874773260-1747070660=:929--

