Return-Path: <linux-pci+bounces-39759-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 14029C1EF5E
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 09:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B584C34C263
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 08:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F198334C09;
	Thu, 30 Oct 2025 08:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BY4x66L9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09D118A6DB;
	Thu, 30 Oct 2025 08:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761812560; cv=none; b=pedxTaBcgW89Ibez2RDWATYR7yfywVBr8oUUDJ7Ife5UxXuTDGAYgEQXXNm4yDFaJ6vCUiWu1C8+Zr7g8+CmggIirUOJMJcaK60NHcUSP/Y6fZcWnVmHu1oLGeyilB2Q79JhjWTSSIdrk62rCMwQ6h6y+/+BvMK/3FeXmVjXoQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761812560; c=relaxed/simple;
	bh=X1qoRbeR7cH7A76OaU8ea24X2x456u+mQGXe5BlwdDI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=r8lvyY0qzmbc9857gy3Egw7MV58d38Hg4O5vCajb0cCvvfvwS+JeQ5S7NU0bajxZXWNveWKNmZ1cxvzggYRgcPzR1E87lLao0dTYr4akMa12q+xE6Lsz4S7gsFTJoR9kadusSUhyhmIpa435/Rleyc/6Ej7mEDvnVo2zCqdycno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BY4x66L9; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761812559; x=1793348559;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=X1qoRbeR7cH7A76OaU8ea24X2x456u+mQGXe5BlwdDI=;
  b=BY4x66L9o23UZG3GDt6qR998UqhTBZiYyXgNTlETjtGY/qCcTx+i5Y2O
   70zAJvZWKZDpDrr4iN97g6D93koH3zgExkjdttlyhNFFKnuD+pHxoQLET
   8Dpn7hb2XpwCqolq8KRPY9Bgb8fY4rpTB3cZBpZ7q8J6q7ePVDHceXV08
   J1U1EtL2y59/DorfW7RFgQldBdoZ1RWjy4gMUzbCrmNvb6oiTAkUDtTa0
   KEk8WOjja+1THFCzs5swSvHxNY8zO27mDMeG9hQGA3WF5YIIqdXhJFh9l
   RGROhirSd3mWckssippbBdwoMiphLdBUuYQA3v9AXQlZRxrCJXzV2Gxpy
   w==;
X-CSE-ConnectionGUID: ynJ/Uc79StSa5fJAJ+hVAw==
X-CSE-MsgGUID: FM0RlI1mQR6TigXQG0MGTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="63979939"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="63979939"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 01:22:38 -0700
X-CSE-ConnectionGUID: xR/MoA+3SYyESYupl8VUhw==
X-CSE-MsgGUID: X50HDf1BT5eqFcsooueXiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="216745465"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.175])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 01:22:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 30 Oct 2025 10:22:27 +0200 (EET)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
    Simon Richter <Simon.Richter@hogyros.de>, 
    Lucas De Marchi <lucas.demarchi@intel.com>, 
    Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
    Bjorn Helgaas <bhelgaas@google.com>, David Airlie <airlied@gmail.com>, 
    dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
    intel-xe@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>, 
    Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
    linux-pci@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
    Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tursulin@ursulin.net>, 
    =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
    =?ISO-8859-15?Q?Thomas_Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, 
    =?ISO-8859-2?Q?Micha=B3_Winiarski?= <michal.winiarski@intel.com>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/9] PCI: Prevent resource tree corruption when BAR resize
 fails
In-Reply-To: <20251029233644.GA1604285@bhelgaas>
Message-ID: <d697c9e1-580e-6449-796c-a3f5198e0934@linux.intel.com>
References: <20251029233644.GA1604285@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-87365863-1761812347=:975"
Content-ID: <cc63bc64-2c9d-bc3a-0105-b36ea9a88737@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-87365863-1761812347=:975
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <b1bb7069-a25e-dcfe-65de-9b3ae8fc20b4@linux.intel.com>

On Wed, 29 Oct 2025, Bjorn Helgaas wrote:

> On Tue, Oct 28, 2025 at 07:35:43PM +0200, Ilpo J=E4rvinen wrote:
> > pbus_reassign_bridge_resources() saves bridge windows into the saved
> > list before attempting to adjust resource assignments to perform a BAR
> > resize operation. If resource adjustments cannot be completed fully,
> > rollback is attempted by restoring the resource from the saved list.
>=20
> > Fixes: 8bb705e3e79d ("PCI: Add pci_resize_resource() for resizing BARs"=
)
> > Reported-by: Simon Richter <Simon.Richter@hogyros.de>
> > Reported-by: Alex Benn=E9e <alex.bennee@linaro.org>
>=20
> If these reports were public, can we include lore URLs for them?
>=20
> Same question for [PATCH 5/9] PCI: Fix restoring BARs on BAR resize
> rollback path.
>=20
> I put these all on pci/resource for build testing.  I assume we'll
> tweak these based on testing reports and sorting out the pci/rebar
> conflicts.

Thanks, the links will come in v2 along with fixing a few things found by=
=20
more extensive tests by LKP. E.g., it seems clang thinks guard() cannot be=
=20
used here because goto jumps over it (auto variable initialization gets=20
skipped so it's kind of understandable limitation).

--=20
 i.
--8323328-87365863-1761812347=:975--

