Return-Path: <linux-pci+bounces-7111-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029FB8BCDF9
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 14:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33F831C237E4
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 12:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF95CE570;
	Mon,  6 May 2024 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UsbqeFpy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE4A79E4;
	Mon,  6 May 2024 12:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714998624; cv=none; b=a1T09alsP3JazXI6RHbNz2a1aqfD69y4mWq/n41Ud7KEauDX+fIucgAeOeiHa07yngW2p+l7xm/4pM6XqlwA7EdxwVX9WZs21dz3UUpPMjfev8Wkeb/UM9TwCbHI+X29IQ5tQyEPAVzbO4W5cQcp+3c8Opd3P4tixbdl+3PgCVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714998624; c=relaxed/simple;
	bh=c/w6oDfxGpNulUHSEeO1wtt/g7mJwXCklSr6D+lrmzE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=N5B6/6J7QkeAIBPlD9CUZBtQiu45f4zzKP+hix+3zIrIn7kiXc4O652uNzm/ijDmwBttIUE1M+MNlWZKGeHOl2AA6VDmHFltWQE/xdz6IFfEXg/ADV1aUOVcjWr97XvR40WyYmeHGhgmCJRSkUPjBBoUkZVaYXE7ufRCsusclqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UsbqeFpy; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714998623; x=1746534623;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=c/w6oDfxGpNulUHSEeO1wtt/g7mJwXCklSr6D+lrmzE=;
  b=UsbqeFpyIcVNmZpfQxfaeQLQztG3AuEziPMSAgqr8+mGLLUXK1pd9QGC
   dg3vUGSHF25MQC5a8B6YqW+nQ3HE/3B73AXlCFX/d35WoxQvdvOXC9/rk
   hQ6FjsvUEjZ3VbcYWfSEiU5NFIIoMDDniSkqjEO+pO0B1WtjFafujMssj
   39yPkyySF1FLzElNKxZXhqMvKn/CqXKvXXqFwIEwFhBGydfheIwK9+CUI
   iE7AcBsdp8Cp08GX3RURbWX9RazBIYrfhs4kvPiWCSivV29NrHSwh4vGC
   lJOwh324wefWbc3GPqZKtXp45j07LTLYYIeOOicwwV13BPvnRqC89GX1y
   g==;
X-CSE-ConnectionGUID: UcCkrZ3hS9aiLiTLwKA/rA==
X-CSE-MsgGUID: a9IjOYdsSmGSI1afB+rAfg==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10900766"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="10900766"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 05:30:22 -0700
X-CSE-ConnectionGUID: yq1AatXqQCW7RV9dETfBMQ==
X-CSE-MsgGUID: E3JmPibJQDKTJVhIwIqw5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="65601028"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.68])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 05:30:17 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 6 May 2024 15:30:11 +0300 (EEST)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Igor Mammedov <imammedo@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Andy Shevchenko <andriy.shevchenko@intel.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/7] resource: Rename find_resource() to
 find_empty_resource_slot()
In-Reply-To: <20240503204910.GA1602543@bhelgaas>
Message-ID: <1dbfc6c4-eeb1-92c1-3371-1b0afa5683ad@linux.intel.com>
References: <20240503204910.GA1602543@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-665360433-1714998611=:1111"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-665360433-1714998611=:1111
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 3 May 2024, Bjorn Helgaas wrote:

> On Thu, Dec 28, 2023 at 06:57:02PM +0200, Ilpo J=C3=A4rvinen wrote:
> > Rename find_resource() to find_empty_resource_slot() to better describe
> > what the functions does. This is a preparation for exposing it beyond
> > resource.c which is needed by PCI core. Also rename the __ variant to
> > match the names.
>=20
> I wonder if "find_resource_space()" or "find_available_resource()"
> would be better than "_slot"?
>=20
> "Slot" *is* already used a few times in kernel/resource.c, but in most
> cases I think it refers to a "resource", and find_resource() basically
> returns a filled-in struct resource.
>=20
> And of course "slot" suggests something entirely different in the PCI
> context.

I picked up it from the existing usage but I've no strong opinion on=20
this so I'll just rework the series to not add more "slot" wording into=20
there.

--=20
 i.
--8323328-665360433-1714998611=:1111--

