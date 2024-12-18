Return-Path: <linux-pci+bounces-18698-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D049F6819
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 15:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3F9C1891D5A
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 14:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7867773446;
	Wed, 18 Dec 2024 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fysBgAoE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD350219ED;
	Wed, 18 Dec 2024 14:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734531567; cv=none; b=MkHdsJ81QrgHLCiUR4E0ibRLCStKL1MlvasEjPIYK3aMHjqCAnUE3aQD65t0mU6UDvLAVcXBM6rwe2QWtRUofXwK1mVXVkHHyHgv+opNQvWfEWTLT0vobKkbQrI7+fHpdqX+MHtiLWEwC0BHEgIIsJmdEsDTf1vjK5EWWmANO6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734531567; c=relaxed/simple;
	bh=Z5WBtuq8IpWY2gvtk2eWY2Gj8JVQZP6Grrn0KdAbvyQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NBcN90LyecVxZlQSCBHL0jeycimEh2Aj3WmeVwh2P38PAuDCnpKxqCHd5wkyBEzREeDNeFa+B6t2jT8N2W65d1x6u4LJDZtAAHMnDTnJ9PR24btotH5Mo6CFuKqxKztVAiZwuXtml28jBBP/LCaQusihlZcDE90qI2h9M21fbSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fysBgAoE; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734531565; x=1766067565;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Z5WBtuq8IpWY2gvtk2eWY2Gj8JVQZP6Grrn0KdAbvyQ=;
  b=fysBgAoEcva4k8x1VhKxj4OWZoQQ5wFq4+ArnJP42wbJFsAn5BbGZzT4
   gEMiJ9WtTDFkWocx5zcnfyfVEIYuYCgueOEgYQgErAIS+LNbnFg0s2TkR
   lLAGV24mnHfeX8E8z3jRsHD+v0L363WviRl0w3L8QNMyZPcSOfdR3m/95
   gvF8H8kaRMvRIIIXM2D2Ic7ZbTzBmlcvPHyZlweWoXCWei4Ad76uvz5GF
   DqkIl1s2R3d8cNP4aqL4Vawt1St9Y5oqLZ1AxATh2zFg1Lx7lIrgUapHi
   c23BxoIO+46U4rjxpfP2eEvo4T+ijF+6nUWq8yGw0n2X/yfqQCWiKx/F+
   g==;
X-CSE-ConnectionGUID: LgrqBh2QSC2tHReDsttueg==
X-CSE-MsgGUID: 1mQRYZoKTOSdXd8rAcjFWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="35160434"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="35160434"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 06:15:41 -0800
X-CSE-ConnectionGUID: sS4IyDwZRY+BvFIZsokNBQ==
X-CSE-MsgGUID: ClKekbI7Q4eNVN9F77pgtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="98444925"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.138])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 06:15:37 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 18 Dec 2024 16:15:34 +0200 (EET)
To: Yazen Ghannam <yazen.ghannam@amd.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Lukas Wunner <lukas@wunner.de>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
    Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 8/8] PCI/AER: Add prefixes to printouts
In-Reply-To: <20241217215545.GB1121691@yaz-khff2.amd.com>
Message-ID: <4f5e8d07-d459-7a8e-844e-6f1b432763fe@linux.intel.com>
References: <20241217135358.9345-1-ilpo.jarvinen@linux.intel.com> <20241217135358.9345-9-ilpo.jarvinen@linux.intel.com> <20241217215545.GB1121691@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-497339427-1734531334=:939"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-497339427-1734531334=:939
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 17 Dec 2024, Yazen Ghannam wrote:

> On Tue, Dec 17, 2024 at 03:53:58PM +0200, Ilpo J=E4rvinen wrote:
> > Only part of the AER diagnostic printouts use "AER:" prefix because
> > they use low-level pci_printk() directly to allow selecting level.
> >=20
> > Add "AER:" prefix to lines that are printed with pci_printk().
>=20
> Can we please include the "HW_ERR" prefix also? IMO, it would make the
> kernel messages more consistent if all hardware error info had it.

While I'm not against your suggestion, it doesn't belong into this patch=20
as there are other lines beyond those touched in this patch that would=20
need to have HW_ERR as well.

I think I'll just drop this patch from this series and move it into the=20
pci_printk() series to avoid the inter-series conflict. Adding the HW_ERR=
=20
change would conflict badly with Karolina Stolarek's series so I'm not=20
sure if I want to pursue that change at this point (it's only my todo=20
list so it won't get forgotten).

--=20
 i.

--8323328-497339427-1734531334=:939--

