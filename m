Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4CE6C598F
	for <lists+linux-pci@lfdr.de>; Wed, 22 Mar 2023 23:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjCVWq7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Mar 2023 18:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCVWq6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Mar 2023 18:46:58 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C32AF2D;
        Wed, 22 Mar 2023 15:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679525217; x=1711061217;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=HDQsZ+Zd2OeoFbQT7/pK+vspHsprO3oIK582aYdmdL8=;
  b=lsVkw+q7YSfnu1ao7bte5Hnc/pIPYh+nE6sDpgXA7k4jWj+IdQKUG29q
   Ep8lMxHQvWuHJjZFQHE2TB0v3diLAMAiQyp+X+0/POfjImugHXspCOUar
   i2gRep9aVb4WUwEi4dI1QNskA7Wf8ZaoNEbMQ9eU/djCVhrYRYmtm7C1A
   J3brVQFGDqUxZKhKM+21r+ghqQ6/HSLF1Q5q9v0SVjg/89k0q4FDdhLfw
   iXg0hXfVT4viRD6tN9tCYkfQBdNdjhrtzqZH/mi7VTbzCsnK8cvhrwQN1
   oVCOxnw/C8SxTG1Lavf5Rl4iDPzXe+F64qDXx1GSpVxPu3AjNaRRt3Z0z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="341706563"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="341706563"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 15:46:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="928002484"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="928002484"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 22 Mar 2023 15:46:55 -0700
Received: from anithaha-mobl1.amr.corp.intel.com (unknown [10.209.65.203])
        by linux.intel.com (Postfix) with ESMTP id AB9AC580CD3;
        Wed, 22 Mar 2023 15:46:55 -0700 (PDT)
Message-ID: <ab9bf3032ed46fc0586e089edc5aac6e71b331d8.camel@linux.intel.com>
Subject: Re: [Intel-gfx] [PATCH] PCI/ASPM: pci_enable_link_state: Add
 argument to acquire bus lock
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     ville.syrjala@linux.intel.com, nirmal.patel@linux.intel.com,
        jonathan.derrick@linux.dev, lorenzo.pieralisi@arm.com,
        hch@infradead.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, michael.a.bottini@intel.com,
        rafael@kernel.org, me@adhityamohan.in, linux-pci@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Wed, 22 Mar 2023 15:46:55 -0700
In-Reply-To: <20230322205702.GA2493123@bhelgaas>
References: <20230322205702.GA2493123@bhelgaas>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Wed, 2023-03-22 at 15:57 -0500, Bjorn Helgaas wrote:
> On Wed, Mar 22, 2023 at 03:45:01PM -0500, Bjorn Helgaas wrote:
> > Hi David,
> >=20
> > On Tue, Mar 21, 2023 at 04:38:49PM -0700, David E. Box wrote:
> > > The VMD driver calls pci_enabled_link_state as a callback from
> > > pci_bus_walk. Both will acquire the pci_bus_sem lock leading to a loc=
kdep
> > > warning. Add an argument to pci_enable_link_state to set whether the =
lock
> > > should be acquired. In the VMD driver, set the argument to false sinc=
e the
> > > lock will already be obtained by pci_bus_walk.
> > >=20
> > > Reported-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> > > Fixes: de82f60f9c86 ("PCI/ASPM: Add pci_enable_link_state()")
> >=20
> > This means "if your kernel includes de82f60f9c86, you probably want to
> > backport this fix to it."=C2=A0 But that's not the case here.=C2=A0 Thi=
s patch
> > is not fixing an issue with de82f60f9c86, so I don't think there's a
> > reason to include a "Fixes" line.
>=20
> Oops, sorry, forgot to engage brain before hitting "send".
>=20
> I think the "Fixes" line should reference f492edb40b54 ("PCI: vmd: Add
> quirk to configure PCIe ASPM and LTR") instead, since that's where the
> locking problem started.
>=20
> > This patch is adding functionality that is only needed by some other
> > patch, and it should be part of a series that also includes the patch
> > that uses it to make sure they go together.

Yeah this should have been two patches.

>=20
> And I see that the use *is* included in this patch.=C2=A0 But I don't
> really like this pattern:
>=20
> =C2=A0 vmd_probe
> =C2=A0=C2=A0=C2=A0 vmd_enable_domain
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vmd->bus =3D pci_create_root_bus(...);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_scan_child_bus(vmd->bus);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_walk_bus(vmd->bus, vmd_pm_enable_quirk=
, &features);
>=20
> because pci_walk_bus() makes locking complicated (as this issue shows)
> and it doesn't work for hot-added devices (I don't know if that's an
> issue for VMD, but the pattern gets copied to places where it *is*).
>=20
> Normally vmd_pm_enable_quirk() would be done by making it an actual
> DECLARE_PCI_FIXUP_HEADER() or DECLARE_PCI_FIXUP_FINAL(), so it would
> be called automatically by the PCI core when a new device is
> enumerated.=C2=A0 Would that work here?=C2=A0 If it would, I don't think =
you'd
> need to add the extra flag to pci_enable_link_state().

It should work. I'll test the change.

David

>=20
> > > Link: https://lore.kernel.org/linux-pci/ZBjko%2FifunIwsK2v@intel.com/
> > > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > > ---
> > > =C2=A0drivers/pci/controller/vmd.c | 2 +-
> > > =C2=A0drivers/pci/pcie/aspm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 9 +++++=
+---
> > > =C2=A0include/linux/pci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 5 +++--
> > > =C2=A03 files changed, 10 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vm=
d.c
> > > index 990630ec57c6..45aa35744eae 100644
> > > --- a/drivers/pci/controller/vmd.c
> > > +++ b/drivers/pci/controller/vmd.c
> > > @@ -737,7 +737,7 @@ static int vmd_pm_enable_quirk(struct pci_dev *pd=
ev,
> > > void *userdata)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!(features & VMD_=
FEAT_BIOS_PM_QUIRK))
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > > =C2=A0
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pci_enable_link_state(pdev=
, PCIE_LINK_STATE_ALL);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pci_enable_link_state(pdev=
, PCIE_LINK_STATE_ALL, false);
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pos =3D pci_find_ext_=
capability(pdev, PCI_EXT_CAP_ID_LTR);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!pos)
> > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > index 66d7514ca111..5b5a600bb864 100644
> > > --- a/drivers/pci/pcie/aspm.c
> > > +++ b/drivers/pci/pcie/aspm.c
> > > @@ -1147,8 +1147,9 @@ EXPORT_SYMBOL(pci_disable_link_state);
> > > =C2=A0 *
> > > =C2=A0 * @pdev: PCI device
> > > =C2=A0 * @state: Mask of ASPM link states to enable
> > > + * @sem: Boolean to acquire/release pci_bus_sem
> > > =C2=A0 */
> > > -int pci_enable_link_state(struct pci_dev *pdev, int state)
> > > +int pci_enable_link_state(struct pci_dev *pdev, int state, bool sem)
> > > =C2=A0{
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct pcie_link_stat=
e *link =3D pcie_aspm_get_link(pdev);
> > > =C2=A0
> > > @@ -1165,7 +1166,8 @@ int pci_enable_link_state(struct pci_dev *pdev,=
 int
> > > state)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EPERM;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > =C2=A0
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0down_read(&pci_bus_sem);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (sem)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0down_read(&pci_bus_sem);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&aspm_lock=
);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0link->aspm_default =
=3D 0;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (state & PCIE_LINK=
_STATE_L0S)
> > > @@ -1186,7 +1188,8 @@ int pci_enable_link_state(struct pci_dev *pdev,=
 int
> > > state)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0link->clkpm_default =
=3D (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pcie_set_clkpm(link, =
policy_to_clkpm_state(link));
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(&aspm_lo=
ck);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0up_read(&pci_bus_sem);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (sem)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0up_read(&pci_bus_sem);
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > > =C2=A0}
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > index fafd8020c6d7..a6f9f24b39fd 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -1707,7 +1707,7 @@ extern bool pcie_ports_native;
> > > =C2=A0#ifdef CONFIG_PCIEASPM
> > > =C2=A0int pci_disable_link_state(struct pci_dev *pdev, int state);
> > > =C2=A0int pci_disable_link_state_locked(struct pci_dev *pdev, int sta=
te);
> > > -int pci_enable_link_state(struct pci_dev *pdev, int state);
> > > +int pci_enable_link_state(struct pci_dev *pdev, int state, bool sem)=
;
> > > =C2=A0void pcie_no_aspm(void);
> > > =C2=A0bool pcie_aspm_support_enabled(void);
> > > =C2=A0bool pcie_aspm_enabled(struct pci_dev *pdev);
> > > @@ -1716,7 +1716,8 @@ static inline int pci_disable_link_state(struct
> > > pci_dev *pdev, int state)
> > > =C2=A0{ return 0; }
> > > =C2=A0static inline int pci_disable_link_state_locked(struct pci_dev =
*pdev, int
> > > state)
> > > =C2=A0{ return 0; }
> > > -static inline int pci_enable_link_state(struct pci_dev *pdev, int st=
ate)
> > > +static inline int
> > > +pci_enable_link_state(struct pci_dev *pdev, int state, bool sem)
> > > =C2=A0{ return 0; }
> > > =C2=A0static inline void pcie_no_aspm(void) { }
> > > =C2=A0static inline bool pcie_aspm_support_enabled(void) { return fal=
se; }
> > > --=20
> > > 2.34.1
> > >=20

