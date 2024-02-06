Return-Path: <linux-pci+bounces-3177-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA3284BF2A
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 22:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2543B1F2517E
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 21:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CFF1B94D;
	Tue,  6 Feb 2024 21:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kg7PyCXe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11D21B94C;
	Tue,  6 Feb 2024 21:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707254734; cv=none; b=pj+W58G/nTpUVqyffG0xUo9Dk/h3QWlvmIAWQEi7FrDqv+2jjFMxtt3+R4e5uzB+fdk7/ht3dGmFMpHVRqor5gMgTBqA2/9ic+G01Q7flT0daWWXWD74ZcUMYEI78EBqC98tyEH4iXvfVTIQRo75btYBEo4PvLy6HOTStRX3NgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707254734; c=relaxed/simple;
	bh=Syy1MLZwGxTTCjGzcJtKt49dnx/gi9kybwgAMuY3iWo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q4kjKJBMhpxmNxD9kc6FRTJUvBeQTZapg416o3GU8vObFDQXwD41Fk6tFbK9oqiF4ZNoysLmuMr+1VpPZz7egygREQjLe5Sl+zuockzfqp/lLXzmNtG7Sj2sHIWGL+HPKBVR1vL9D3o61PBGsKXEe0EuMOD/ugbP9sXgT0ElZDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kg7PyCXe; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707254732; x=1738790732;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Syy1MLZwGxTTCjGzcJtKt49dnx/gi9kybwgAMuY3iWo=;
  b=kg7PyCXe/255fWSgoAtewt12SeuRM/EOtLRCZLnwh44YWYlzTJO0nCMv
   5MneCe4TLBFT4QelaAkjeeuEKSO5fuWZze0OYsxwhucUVoXY/YF3g3G9C
   8GCKmv5SeLlQWjgD9AO73Tp4jGTBzhgQ+RB28PTp3YQS3j0qRnvfFL7hG
   2Uzwhbrlz8eIQu7HLjLKTMN7ALM0Y7YJQyH8slpMjmDH8asq5RNLsR9vw
   hjNw9lOapEXFV5p2SlCkA+WpaMtoc9fmChFLYcXAa6ly98dZLztlvAgep
   AlkIa+zDK/ryYRZWilW78z8jGiAV3CskJDcnRflC99zmyZ2TY1rsFcxt3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="11432748"
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="11432748"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 13:25:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="5765875"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 13:25:30 -0800
Received: from dbhadrax-mobl5.amr.corp.intel.com (unknown [10.255.229.168])
	by linux.intel.com (Postfix) with ESMTP id AFF27580DB9;
	Tue,  6 Feb 2024 13:25:29 -0800 (PST)
Message-ID: <9cfc65c594deef33f24b60a66b7c78c742da7203.camel@linux.intel.com>
Subject: Re: [PATCH v2] PCI: vmd: Enable PCI PM's L1 substates of remapped
 PCIe Root Port and NVMe
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Bjorn Helgaas <helgaas@kernel.org>, puranjay12@gmail.com
Cc: Jian-Hong Pan <jhp@endlessos.org>, Johan Hovold <johan@kernel.org>, Mika
 Westerberg <mika.westerberg@linux.intel.com>, Damien Le Moal
 <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, Nirmal Patel
 <nirmal.patel@linux.intel.com>, Jonathan Derrick
 <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux@endlessos.org
Date: Tue, 06 Feb 2024 13:25:29 -0800
In-Reply-To: <02938148545933dc9865ddbc5551e3e8a579d57e.camel@linux.intel.com>
References: <20240205224215.GA829734@bhelgaas>
	 <02938148545933dc9865ddbc5551e3e8a579d57e.camel@linux.intel.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Adding Puranjay

On Mon, 2024-02-05 at 15:05 -0800, David E. Box wrote:
> On Mon, 2024-02-05 at 16:42 -0600, Bjorn Helgaas wrote:
> > On Mon, Feb 05, 2024 at 11:37:16AM -0800, David E. Box wrote:
> > > On Fri, 2024-02-02 at 18:05 -0600, Bjorn Helgaas wrote:
> > > > On Fri, Feb 02, 2024 at 03:11:12PM +0800, Jian-Hong Pan wrote:
> > > ...
> >=20
> > > > > @@ -775,6 +773,14 @@ static int vmd_pm_enable_quirk(struct pci_de=
v
> > > > > *pdev,
> > > > > void *userdata)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pci_write_config_=
dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT,
> > > > > ltr_reg);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pci_info(pdev, "V=
MD: Default LTR value set by driver\n");
> > > >=20
> > > > You're not changing this part, and I don't understand exactly how L=
TR
> > > > works, but it makes me a little bit queasy to read "set the LTR val=
ue
> > > > to the maximum required to allow the deepest power management
> > > > savings" and then we set the max snoop values to a fixed constant.
> > > >=20
> > > > I don't think the goal is to "allow the deepest power savings"; I
> > > > think it's to enable L1.2 *when the device has enough buffering to
> > > > absorb L1.2 entry/exit latencies*.
> > > >=20
> > > > The spec (PCIe r6.0, sec 7.8.2.2) says "Software should set this to
> > > > the platform's maximum supported latency or less," so it seems like
> > > > that value must be platform-dependent, not fixed.
> > > >=20
> > > > And I assume the "_DSM for Latency Tolerance Reporting" is part of =
the
> > > > way to get those platform-dependent values, but Linux doesn't actua=
lly
> > > > use that yet.
> > >=20
> > > This may indeed be the best way but we need to double check with our
> > > BIOS folks.=C2=A0 AFAIK BIOS writes the LTR values directly so there
> > > hasn't been a need to use this _DSM. But under VMD the ports are
> > > hidden from BIOS which is why we added it here. I've brought up the
> > > question internally to find out how Windows handles the DSM and to
> > > get a recommendation from our firmware leads.
> >=20
> > We want Linux to be able to program LTR itself, don't we?=C2=A0 We
> > shouldn't have to rely on firmware to do it.=C2=A0 If Linux can't do
> > it, hot-added devices aren't going to be able to use L1.2, right?
>=20
> Agreed. We just want to make sure we are not conflicting with what BIOS m=
ay be
> doing.

So the feedback is to run the _DSM and just overwrite any BIOS values. Look=
ing
up the _DSM I saw there was an attempt to upstream this 4 years ago [1]. I'=
m not
sure why the effort stalled but we can pick up this work again.

https://patchwork.kernel.org/project/linux-pci/patch/20201015080311.7811-1-=
puranjay12@gmail.com/

