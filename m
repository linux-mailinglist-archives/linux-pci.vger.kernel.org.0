Return-Path: <linux-pci+bounces-11424-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F9594A50C
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 12:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADC401C20915
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 10:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DEF1D365F;
	Wed,  7 Aug 2024 10:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="KhtYBZi6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142421D4163
	for <linux-pci@vger.kernel.org>; Wed,  7 Aug 2024 10:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723025172; cv=none; b=tGNpJTQngMl4Cctw4exgIGWAZW9Xyub1E6eSXNRcvw+Levp6U7rwpibzXZRO7W+MtyL7KvTp4KfwTuIigK+bILhkP32GF8GUdgFeD1J2uKJQ+klAaVmelKFS0zI6Ih4fPLSlls9tsy3LUwBHmNvBX2CzEXz6uZfNLlBEKtlLqfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723025172; c=relaxed/simple;
	bh=OIvfWBCj845l1BOTnI/Ibxra8K5B1QEVgn+VJJdfJWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SPPEP/ujeiHNT1r+iuMbvmc1QXFlzxmH6D9jlfyXXzOh233yEmFs8QgjOO+h5wmqKSZxv1PiL01MZswOckFo9Yj3zs7RNOCjaSEaACM1U/HkhahLcPuklC+Uxw2/HiEeFVpjSg2LVAY4qWJ+XlxbtDpI5T7y4cp+slai1lRmIms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=KhtYBZi6; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e026a2238d8so1437488276.0
        for <linux-pci@vger.kernel.org>; Wed, 07 Aug 2024 03:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1723025163; x=1723629963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+da92mzfgrEJFGuSfKJMf/2eci2Oh/4DDrOI58T4DY=;
        b=KhtYBZi6QbCqNdVTWwOiOx4zx6KkUnFSrBaC0F9EqTE6Ajfi4bYnIL68K2mpVpcca2
         wq21soX6E8/WcNVauiEcx6p7NSn/9Z/c4lSwNnbHmmCggn6ygOSWN9ljpXbzDi+BVFOx
         0g+NhCVMjuSA0mYvjI7/unDoquvIV+t27wyq1bb2bB5ts4k/kX1Yjgop3iHmphYX7yWG
         s0+WBG0PNzXplNrnGaEIQfLjbVR1EzEjVYWQMTJ/j3lEctuq2L/XqtP9r5oAaI5+xxRX
         QHS1XKpa/PfPVe5HiNj8nA5DtMHD22BO2tIp0Hhz/eZ1GyXY/iRmkEuzCcR+UfZjKJwz
         aRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723025163; x=1723629963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+da92mzfgrEJFGuSfKJMf/2eci2Oh/4DDrOI58T4DY=;
        b=i0g1s6ASbftGEAL4gzx6yHJtnU5qsn/VAccV9NkiaVnjXH8rL4imvfLCg8Ds7zwzyH
         +28VrALdMtrIPyF40AhUtIVqO4vshzQsOqC5Bj12XkecbU0hm5OBKL51xzevrkKfdxon
         F6XhnEy8swHNeq9U/vojmPhs16dENZZtLWXwBivlDcxIWBM5KNHD514yeyrYXX4F2CM9
         HiEi5pKXhIuUjz+Itw2QIeuDXWCF5o8ftXxAQ7reIJ/xPvMS6fBE5wC48RtNKPz5kYQ5
         +kFC7QJjIWkzG9UTrvbrAlXwdGZdXcel5BrQZ8LA/uD6lGF4hq7mcFtFKNKI/+WD1ISV
         LG5w==
X-Forwarded-Encrypted: i=1; AJvYcCV7r6uKI1BARRJCwc9HeOWkEq88vKBoevZlivGl/cRxNlditwRk7aJEdO75Tjv+JPwXthmw1w9opByUsX+thQYKaJEzV5B6cgO9
X-Gm-Message-State: AOJu0Yw+iYztZoMx4HhnawNIJhYR5QfTN6OArSTbx9hNQWEhRdTsR9Vi
	bvCN5hitw9seTPkIDsRcwgR8JKmB93xUNiw8JKqCyMyDOXjgOd4SCJDpjUE0nDJj3kdcBWHQLBf
	8F/wM9T5o+MWH1NMgQgaU5Pu9nWbEAPiBMqshaQ==
X-Google-Smtp-Source: AGHT+IFaM6K6WMjG5h2UsSlpCK1oJoQ5YCrCyZRQYINCHBzzAOrFR+1B/5tdhs8AFoZml5onMfQlHnC9w2sRNhu9r3Y=
X-Received: by 2002:a05:6902:100a:b0:e0b:d933:b6fa with SMTP id
 3f1490d57ef6-e0bde2b11e2mr21370832276.4.1723025163193; Wed, 07 Aug 2024
 03:06:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719075200.10717-2-jhp@endlessos.org> <20240719080255.10998-2-jhp@endlessos.org>
 <CAPpJ_edybLMtrN_gxP2h9Z-BuYH+RG-qRqMqgZM1oSVoW1sP5A@mail.gmail.com> <e37536a435630583398307682e1a9aadbabfb497.camel@linux.intel.com>
In-Reply-To: <e37536a435630583398307682e1a9aadbabfb497.camel@linux.intel.com>
From: Jian-Hong Pan <jhp@endlessos.org>
Date: Wed, 7 Aug 2024 18:05:27 +0800
Message-ID: <CAPpJ_eeATLdcnH9CWpvJM_9juV5ok+OEYysTit_HparqBpQ3CQ@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] PCI/ASPM: Fix L1.2 parameters when enable link state
To: david.e.box@linux.intel.com
Cc: Bjorn Helgaas <helgaas@kernel.org>, Johan Hovold <johan@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Nirmal Patel <nirmal.patel@linux.intel.com>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, 
	Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

David E. Box <david.e.box@linux.intel.com> =E6=96=BC 2024=E5=B9=B48=E6=9C=
=886=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=884:26=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Hi Jian-Hong,
>
> On Fri, 2024-08-02 at 16:24 +0800, Jian-Hong Pan wrote:
> > Jian-Hong Pan <jhp@endlessos.org> =E6=96=BC 2024=E5=B9=B47=E6=9C=8819=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:04=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >
> > > Currently, when enable link's L1.2 features with __pci_enable_link_st=
ate(),
> > > it configs the link directly without ensuring related L1.2 parameters=
, such
> > > as T_POWER_ON, Common_Mode_Restore_Time, and LTR_L1.2_THRESHOLD have =
been
> > > programmed.
> > >
> > > This leads the link's L1.2 between PCIe Root Port and child device ge=
ts
> > > wrong configs when a caller tries to enabled it.
> > >
> > > Here is a failed example on ASUS B1400CEAE with enabled VMD:
> > >
> > > 10000:e0:06.0 PCI bridge: Intel Corporation 11th Gen Core Processor P=
CIe
> > > Controller (rev 01) (prog-if 00 [Normal decode])
> > >     ...
> > >     Capabilities: [200 v1] L1 PM Substates
> > >         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> > > L1_PM_Substates+
> > >                   PortCommonModeRestoreTime=3D45us PortTPowerOnTime=
=3D50us
> > >         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > >                    T_CommonMode=3D45us LTR1.2_Threshold=3D101376ns
> > >         L1SubCtl2: T_PwrOn=3D50us
> > >
> > > 10000:e1:00.0 Non-Volatile memory controller: Sandisk Corp WD Blue SN=
550
> > > NVMe SSD (rev 01) (prog-if 02 [NVM Express])
> > >     ...
> > >     Capabilities: [900 v1] L1 PM Substates
> > >         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > > L1_PM_Substates+
> > >                   PortCommonModeRestoreTime=3D32us PortTPowerOnTime=
=3D10us
> > >         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > >                    T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
> > >         L1SubCtl2: T_PwrOn=3D10us
> > >
> > > According to "PCIe r6.0, sec 5.5.4", before enabling ASPM L1.2 on the=
 PCIe
> > > Root Port and the child NVMe, they should be programmed with the same
> > > LTR1.2_Threshold value. However, they have different values in this c=
ase.
> > >
> > > Invoke aspm_calc_l12_info() to program the L1.2 parameters properly b=
efore
> > > enable L1.2 bits of L1 PM Substates Control Register in
> > > __pci_enable_link_state().
> > >
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218394
> > > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > > ---
> > > v2:
> > > - Prepare the PCIe LTR parameters before enable L1 Substates
> > >
> > > v3:
> > > - Only enable supported features for the L1 Substates part
> > >
> > > v4:
> > > - Focus on fixing L1.2 parameters, instead of re-initializing whole L=
1SS
> > >
> > > v5:
> > > - Fix typo and commit message
> > > - Split introducing aspm_get_l1ss_cap() to "PCI/ASPM: Introduce
> > >   aspm_get_l1ss_cap()"
> > >
> > > v6:
> > > - Skipped
> > >
> > > v7:
> > > - Pick back and rebase on the new version kernel
> > > - Drop the link state flag check. And, always config link state's tim=
ing
> > >   parameters
> > >
> > > v8:
> > > - Because pcie_aspm_get_link() might return the link as NULL, move
> > >   getting the link's parent and child devices after check the link is
> > >   not NULL. This avoids NULL memory access.
> > >
> > >  drivers/pci/pcie/aspm.c | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > >
> > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > index 5db1044c9895..55ff1d26fcea 100644
> > > --- a/drivers/pci/pcie/aspm.c
> > > +++ b/drivers/pci/pcie/aspm.c
> > > @@ -1411,9 +1411,15 @@ EXPORT_SYMBOL(pci_disable_link_state);
> > >  static int __pci_enable_link_state(struct pci_dev *pdev, int state, =
bool
> > > locked)
> > >  {
> > >         struct pcie_link_state *link =3D pcie_aspm_get_link(pdev);
> > > +       u32 parent_l1ss_cap, child_l1ss_cap;
> > > +       struct pci_dev *parent, *child;
> > >
> > >         if (!link)
> > >                 return -EINVAL;
> > > +
> > > +       parent =3D link->pdev;
> > > +       child =3D link->downstream;
> > > +
> > >         /*
> > >          * A driver requested that ASPM be enabled on this device, bu=
t
> > >          * if we don't have permission to manage ASPM (e.g., on ACPI
> > > @@ -1428,6 +1434,15 @@ static int __pci_enable_link_state(struct pci_=
dev
> > > *pdev, int state, bool locked)
> > >         if (!locked)
> > >                 down_read(&pci_bus_sem);
> > >         mutex_lock(&aspm_lock);
> > > +       /*
> > > +        * Ensure L1.2 parameters: Common_Mode_Restore_Times, T_POWER=
_ON and
> > > +        * LTR_L1.2_THRESHOLD are programmed properly before enable b=
its for
> > > +        * L1.2, per PCIe r6.0, sec 5.5.4.
> > > +        */
> > > +       parent_l1ss_cap =3D aspm_get_l1ss_cap(parent);
> > > +       child_l1ss_cap =3D aspm_get_l1ss_cap(child);
> > > +       aspm_calc_l12_info(link, parent_l1ss_cap, child_l1ss_cap);
>
> I still don't think this is the place to recalculate the L1.2 parameters
> especially when know the calculation was done but was cleared by
> pci_bus_reset(). Can't we just do a pci_save/restore_state() before/after
> pci_bus_reset() in vmd.c?

I have not thought pci_save/restore_state() around pci_bus_reset()
before.  It is an interesting direction.

So, I prepare modification below for test.  Include "[PATCH v8 1/4]
PCI: vmd: Set PCI devices to D0 before enable PCI PM's L1 substates",
too.  Then, both the PCIe bridge and the PCIe device have the same
LTR_L1.2_THRESHOLD 101376ns as expected.

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index bbf4a47e7b31..6b8dd4f30127 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -727,6 +727,18 @@ static void vmd_copy_host_bridge_flags(struct
pci_host_bridge *root_bridge,
        vmd_bridge->native_dpc =3D root_bridge->native_dpc;
 }

+static int vmd_pci_save_state(struct pci_dev *pdev, void *userdata)
+{
+       pci_save_state(pdev);
+       return 0;
+}
+
+static int vmd_pci_restore_state(struct pci_dev *pdev, void *userdata)
+{
+       pci_restore_state(pdev);
+       return 0;
+}
+
 /*
  * Enable ASPM and LTR settings on devices that aren't configured by BIOS.
  */
@@ -927,6 +939,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd,
unsigned long features)
        pci_scan_child_bus(vmd->bus);
        vmd_domain_reset(vmd);

+       pci_walk_bus(vmd->bus, vmd_pci_save_state, NULL);
        /* When Intel VMD is enabled, the OS does not discover the Root Por=
ts
         * owned by Intel VMD within the MMCFG space. pci_reset_bus() appli=
es
         * a reset to the parent of the PCI device supplied as argument. Th=
is
@@ -945,6 +958,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd,
unsigned long features)
                        break;
                }
        }
+       pci_walk_bus(vmd->bus, vmd_pci_restore_state, NULL);

        pci_assign_unassigned_bus_resources(vmd->bus);


Jian-Hong Pan

> > > +
> > >         link->aspm_default =3D pci_calc_aspm_enable_mask(state);
> > >         pcie_config_aspm_link(link, policy_to_aspm_state(link));
> > >
> > > --
> > > 2.45.2
> > >
> >
> > Hi Nirmal and Paul,
> >
> > It will be great to have your review here.
> >
> > I had tried to "set the threshold value in vmd_pm_enable_quirk()"
> > directly as Paul said [1].  However, it still needs to get the PCIe
> > link from the PCIe device to set the threshold value.
> > And, pci_enable_link_state_locked() gets the link. Then, it will be
> > great to calculate and programm L1 sub-states' parameters properly
> > before configuring the link's ASPM there.
> >
> > [1]:
> > https://lore.kernel.org/linux-kernel/20240624081108.10143-2-jhp@endless=
os.org/T/#mc467498213fe1a6116985c04d714dae378976124
> >
> > Jian-Hong Pan
>

