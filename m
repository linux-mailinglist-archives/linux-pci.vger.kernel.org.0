Return-Path: <linux-pci+bounces-22216-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FE3A425B1
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 16:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F72E7A5286
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 15:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E527F7FC;
	Mon, 24 Feb 2025 15:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n1SBL4Bk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3F814A627
	for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 15:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740409754; cv=none; b=AaQuRISue3r6kqW2OGIxrAAWp1f8MQu64+OmHWIk8sVVltHuBR3kfwoopidF52G7Jp7h1DbLGra+1oyiEGQIBacv45AC9S38u3S4Chbw1wG5f9yzP9g5vmHw3VRriNQSnxxxc28GizO7myLK6Ybn0oWUmDw0b28Gw3rMs8hlsMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740409754; c=relaxed/simple;
	bh=teA/QyB9G8gXwhLH3zP+xGQ54exGKVu3YN7D2G56rSs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mBG9QhAjeHBqr0tiHF97v7XJiwkdYnyZ01S7p5mJNP6jiEfIHAOqO6Eggg93ZKS+MhqN7N/oyAe/xfXwKllzY6fMKC2u5tHUvCzMwZLMPgJrozd/ztCXulTPJvxvlZODbvDwxI88UYtC+MQuPd1g5assY3du/Vd9fj+kFEp6pkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n1SBL4Bk; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740409753; x=1771945753;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=teA/QyB9G8gXwhLH3zP+xGQ54exGKVu3YN7D2G56rSs=;
  b=n1SBL4Bk+1IjYCBCW2wGyob6c24OzXtGuIJE2WzI4gwQu6jLbii6CXMq
   dzttQKqlZFUk+Nlj0eQ1+aG87xEwFbRjDUSx4qq5sN9RX6I2wn1Y4d01O
   Z8zap4s9E4RBkbgAPiv5TZBedBm1WCeFkYdb/P8V0hRaqYStcNYvvxvZz
   cnZdZGYdkJJqLTF4D2OjTTiR1ghkLPrsSJOOn/1QvU2lf7xv4nTIH0HeV
   /fm/LHHTLWD9zW3XQSE5kJU2Oc8xzQjJomEVJQTX5q0WcxhCBH4q/TCjJ
   RDsWqPhHz2bBcdNtVEGCZuA2zXgsBcX5anYid7MCspV3rhm+zwZBv0qjB
   g==;
X-CSE-ConnectionGUID: p0iYI2dSSg2+bxKpTOoTEw==
X-CSE-MsgGUID: /3kQ1glfShugdawOq22w2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="41046137"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="41046137"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 07:09:12 -0800
X-CSE-ConnectionGUID: 506Ri49zShGuvjXlY0xy0g==
X-CSE-MsgGUID: cLlFKEdmTUW4vfWeDUcPCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="116063257"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.233])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 07:09:09 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 24 Feb 2025 17:09:05 +0200 (EET)
To: Dan Williams <dan.j.williams@intel.com>
cc: Bjorn Helgaas <helgaas@kernel.org>, linux-coco@lists.linux.dev, 
    Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>, 
    Samuel Ortiz <sameo@rivosinc.com>, Alexey Kardashevskiy <aik@amd.com>, 
    Xu Yilun <yilun.xu@linux.intel.com>, linux-pci@vger.kernel.org, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 07/11] PCI: Add PCIe Device 3 Extended Capability
 enumeration
In-Reply-To: <67b9172eb5eca_2d2c294b4@dwillia2-xfh.jf.intel.com.notmuch>
Message-ID: <83d1985d-a843-1d9f-840d-226f68de7d1f@linux.intel.com>
References: <20241210192140.GA3079633@bhelgaas> <c7fce545-e369-0dba-fbbe-3d90b67e5cfb@linux.intel.com> <67b9172eb5eca_2d2c294b4@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-555201434-1740397993=:933"
Content-ID: <d216cc3e-054c-7388-1d0b-e5c64f0265d3@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-555201434-1740397993=:933
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <10884278-66bf-981b-6832-b3420b9f1bdd@linux.intel.com>

On Fri, 21 Feb 2025, Dan Williams wrote:
> Ilpo J=E4rvinen wrote:
> > On Tue, 10 Dec 2024, Bjorn Helgaas wrote:
> >=20
> > > On Thu, Dec 05, 2024 at 02:23:56PM -0800, Dan Williams wrote:
> > > > PCIe 6.2 Section 7.7.9 Device 3 Extended Capability Structure,
> > > > enumerates new link capabilities and status added for Gen 6 devices=
=2E One
> > > > of the link details enumerated in that register block is the "Segme=
nt
> > > > Captured" status in the Device Status 3 register. That status is
> > > > relevant for enabling IDE (Integrity & Data Encryption) whereby
> > > > Selective IDE streams can be limited to a given requester id range
> > > > within a given segment.
> > >=20
> > > s/requester id/Requester ID/ to match spec usage
> > >=20
> > > > +++ b/include/uapi/linux/pci_regs.h
> > > > @@ -749,6 +749,7 @@
> > > >  #define PCI_EXT_CAP_ID_NPEM=090x29=09/* Native PCIe Enclosure Mana=
gement */
> > > >  #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/=
s */
> > > >  #define PCI_EXT_CAP_ID_DOE=090x2E=09/* Data Object Exchange */
> > > > +#define PCI_EXT_CAP_ID_DEV3=090x2F=09/* Device 3 Capability/Contro=
l/Status */
> > >=20
> > > It doesn't look like lspci knows about this; is there something in
> > > progress to add that?
> > >=20
> > > https://git.kernel.org/pub/scm/utils/pciutils/pciutils.git/tree/lib/h=
eader.h?id=3Dv3.13.0#n257
> >=20
> > Hi,
> >=20
> > I've two patches lying around that add a few Flit mode related fields=
=20
> > and Dev3 into lspci, although the latter patch doesn't exactly have all=
=20
> > the fields from Dev3 but at least it would be a good start for many=20
> > things.
> >=20
> > I think I'll just post them as is and see where it goes.
>=20
> Oh, good to hear (the dangers of replying to patch feedback in response
> order unfortunately means I missed this in my earlier reply). Please
> copy me on those patches so I can keep track of that discussion.

Hi Dan,

I've seemingly Cc'ed you back then:

https://lore.kernel.org/linux-pci/20241211134840.3375-1-ilpo.jarvinen@linux=
=2Eintel.com/

(Np of not noticing, we do get way too much email to pick up everything.)

=2E..There has been no discussion about it though.

--=20
 i.
--8323328-555201434-1740397993=:933--

