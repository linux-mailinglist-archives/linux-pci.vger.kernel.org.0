Return-Path: <linux-pci+bounces-28788-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D44AACA8CA
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 07:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECB931781AB
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 05:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA7114885B;
	Mon,  2 Jun 2025 05:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PvWliMUS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FA05695;
	Mon,  2 Jun 2025 05:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748841054; cv=none; b=oOZmZMfMAg5JgnzWIYgpA6c9L8KmPl9FeQjY9JlX33xLzqp0biGtsYKGvtNipHNpmPEnfLrDZBE33RWcHp1+w/nAh/gcpKFnHkifTCQAeLXvfurPLqHfjyf16eniEocoi8+LbRs4AXKtXxH0rFHo0AKYciaFZHPLbBwXqXYCh0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748841054; c=relaxed/simple;
	bh=fxDosPY8Wny75hKwXSp7HiD2ycgAdMQx1mnEg0e7Xco=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LAA9xatP8Ppwplogz1Sio1Skf91eZUwYmzznW2kP41DZJiyzIGP2fBLDA/yL7xcHZNW1Kz0uKzXC9ZG4a1Kx0dFUqfpwUog9wH5/Ymb+noc/oziAs1qKiyEaLAkstCv14A416c2r7Nn20AxGQEQbJEhanQuQ0jbZH7Qf4UB3eks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PvWliMUS; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748841052; x=1780377052;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fxDosPY8Wny75hKwXSp7HiD2ycgAdMQx1mnEg0e7Xco=;
  b=PvWliMUSA3lGVmY1/4f8QFrjQxu963ILr4lXLPS+GJHjsYnqXyC40D7y
   omPrY0tnHcBDQOiyJgcOmpfNRrT0csNWjoxf2ki4ro8AutWv2N9bUbp5O
   iPk7PJ2EXk8khvXDjVpV+0gay54szolJDR90Fq3Iz70bXHVmACseRXDi/
   mfmohLDDYXpHZZDKduAGQs37PbUuHjxlNBBWSxwQHchK2o0GLUKeWjrZO
   WKjFM4pt487+KJoWxBe7EyaOjs9beoBhYKEoh9u1quK+BJgcdecOAtsXG
   navSoSb+ItaM3qFc2bgosWsSsiaeAsoQCt4xX4BbDEEW1G3UMQXHxnxIs
   A==;
X-CSE-ConnectionGUID: FX9W3Kn9Q9mc0zL4t69Akw==
X-CSE-MsgGUID: BkCCyqZiQOmUZbXFAq2vYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11450"; a="68396905"
X-IronPort-AV: E=Sophos;i="6.16,202,1744095600"; 
   d="scan'208";a="68396905"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2025 22:10:51 -0700
X-CSE-ConnectionGUID: cCOHNwErSH+NtylyeCcbaQ==
X-CSE-MsgGUID: b99YSdCfQQO4vQ0vfIUCVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,202,1744095600"; 
   d="scan'208";a="181622455"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.134])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2025 22:10:46 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 2 Jun 2025 08:10:42 +0300 (EEST)
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
cc: Dan Williams <dan.j.williams@intel.com>, Lukas Wunner <lukas@wunner.de>, 
    Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
    Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
    Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
    "H. Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] PCI: Add Extended Tag + MRRS quirk for Xeon 6
In-Reply-To: <xwcoamcgyprdiru3z3qyamqxjmolis23vps4axzkpesgjrag4p@wnp63ospijyw>
Message-ID: <45809733-1e02-0109-a929-3cdd6c960646@linux.intel.com>
References: <20250422130207.3124-1-ilpo.jarvinen@linux.intel.com> <xwcoamcgyprdiru3z3qyamqxjmolis23vps4axzkpesgjrag4p@wnp63ospijyw>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1642513350-1748841042=:1085"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1642513350-1748841042=:1085
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 1 Jun 2025, Manivannan Sadhasivam wrote:

> On Tue, Apr 22, 2025 at 04:02:07PM +0300, Ilpo J=C3=A4rvinen wrote:
> > When bifurcated to x2, Xeon 6 Root Port performance is sensitive to the
> > configuration of Extended Tags, Max Read Request Size (MRRS), and 10-Bi=
t
> > Tag Requester (note: there is currently no 10-Bit Tag support in the
> > kernel). While those can be configured to the recommended values by FW,
> > kernel may decide to overwrite the initial values.
> >=20
> > Unfortunately, there is no mechanism for FW to indicate OS which parts
> > of PCIe configuration should not be altered. Thus, the only option is
> > to add such logic into the kernel as quirks.
> >=20
> > There is a pre-existing quirk flag to disable Extended Tags. Depending
> > on CONFIG_PCIE_BUS_* setting, MRRS may be overwritten by what the
> > kernel thinks is the best for performance (the largest supported
> > value), resulting in performance degradation instead with these Root
> > Ports. (There would have been a pre-existing quirk to disallow
> > increasing MRRS but it is not identical to rejecting >128B MRRS.)
> >=20
> > Add a quirk that disallows enabling Extended Tags and setting MRRS
> > larger than 128B for devices under Xeon 6 Root Ports if the Root Port i=
s
> > bifurcated to x2. Reject >128B MRRS only when it is going to be written
> > by the kernel (this assumes FW configured a good initial value for MRRS
> > in case the kernel is not touching MRRS at all).
> >=20
> > It was first attempted to always write MRRS when the quirk is needed
> > (always overwrite the initial value). That turned out to be quite
> > invasive change, however, given the complexity of the initial setup
> > callchain and various stages returning early when they decide no change=
s
> > are necessary, requiring override each. As such, the initial value for
> > MRRS is now left into the hands of FW.
> >=20
> > Link: https://cdrdv2.intel.com/v1/dl/getContent/837176
> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >=20
> > v2:
> > - Explain in changelog why FW cannot solve this on its own
> > - Moved the quirk under arch/x86/pci/
> > - Don't NULL check value from pci_find_host_bridge()
> > - Added comment above the quirk about the performance degradation
> > - Removed all setup chain 128B quirk overrides expect for MRRS write
> >   itself (assumes a sane initial value is set by FW)
> >=20
> >  arch/x86/pci/fixup.c | 30 ++++++++++++++++++++++++++++++
> >  drivers/pci/pci.c    | 15 ++++++++-------
> >  include/linux/pci.h  |  1 +
> >  3 files changed, 39 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> > index efefeb82ab61..aa9617bc4b55 100644
> > --- a/arch/x86/pci/fixup.c
> > +++ b/arch/x86/pci/fixup.c
> > @@ -294,6 +294,36 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,=09PCI=
_DEVICE_ID_INTEL_MCH_PB1,=09pcie_r
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,=09PCI_DEVICE_ID_INTEL_MCH=
_PC,=09pcie_rootport_aspm_quirk);
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,=09PCI_DEVICE_ID_INTEL_MCH=
_PC1,=09pcie_rootport_aspm_quirk);
> > =20
> > +/*
> > + * PCIe devices underneath Xeon6 PCIe Root Port bifurcated to 2x have =
slower
> > + * performance with Extended Tags and MRRS > 128B. Workaround the perf=
ormance
> > + * problems by disabling Extended Tags and limiting MRRS to 128B.
> > + *
> > + * https://cdrdv2.intel.com/v1/dl/getContent/837176
> > + */
> > +static void quirk_pcie2x_no_tags_no_mrrs(struct pci_dev *pdev)
> > +{
> > +=09struct pci_host_bridge *bridge =3D pci_find_host_bridge(pdev->bus);
> > +=09u32 linkcap;
> > +
> > +=09pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &linkcap);
> > +=09if (FIELD_GET(PCI_EXP_LNKCAP_MLW, linkcap) !=3D 0x2)
> > +=09=09return;
> > +
> > +=09bridge->no_ext_tags =3D 1;
> > +=09bridge->only_128b_mrrs =3D 1;
>=20
> My 2 cents here. Wouldn't it work if you hardcode MRRS to 128 in PCI_EXP_=
DEVCTL
> here and then set pci_host_bridge::no_inc_mrrs to 1? This would avoid
> introducing an extra flag and also serve the same purpose.

Hi Mani,

Thanks for the suggestion but it won't work because this is the Root Port.=
=20
The devices underneath it need this setting so we cannot set them to 128B=
=20
reliable here (is there anything that guarantees those devices have been=20
enumerated at this point?).

I've v3 already prepared which uses the enable device hook as suggested by=
=20
Lukas. I'll send it soon.

--=20
 i.

--8323328-1642513350-1748841042=:1085--

