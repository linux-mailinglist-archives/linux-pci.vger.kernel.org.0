Return-Path: <linux-pci+bounces-8984-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6642A90F07C
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 16:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DEF01F24EEA
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 14:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C501C6AF;
	Wed, 19 Jun 2024 14:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="atum2gs9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8E91B974
	for <linux-pci@vger.kernel.org>; Wed, 19 Jun 2024 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807334; cv=none; b=RTh+cVCmpXRswIh5bLElRCtdZNDlRDE4DYJcaISw+TnXazJqpkBT2LowLMaGdkMaQU5G5XAs6H+QBlsCOcah3tVuMBX4Pk7EBM3wIEI8KeDk/mmoXV/X3MmH7swf6Bw2O9tfbj98oh64HEAn+vBkUJ9pZ8Pk44q9SyJm1FPRr7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807334; c=relaxed/simple;
	bh=SRBJ9M5FnO+TnNAQ1MQVsnHItVJ0MY6edCaiY6rKcBM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hml21pGpuTdu9OxNjrYo26NPPjARtTkKUZiJLe2e9b8d0B5y83FYVZTDGNbxyA1O7h1qWn9V1sdYKxQYL9MQr76zR9/PHrh2pRqDA9sHlytZM2BBWE5MJkoynelPu9lS8bRpjFYNETGNfXIWjBNBnsANFvdfndonNJvcrcLO9YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=atum2gs9; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718807332; x=1750343332;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SRBJ9M5FnO+TnNAQ1MQVsnHItVJ0MY6edCaiY6rKcBM=;
  b=atum2gs9aD3BB6I8f8kMzycUSI1Q+XmLdckPxryZDSz6r5QghXYmnqJU
   elW0qpVxuT/Do18iwVVvXaDN6D3PxTCm7PfW/860GG6uG5aB6g1w8Nlzu
   OhKwBXKVwI/JwJBx8djTXdXSUnW91UUxkOfC9q+bDTc6d5IFyluhaf7yX
   zvMiW/soQFWILSIVwnFB/eAl8MV5umg8B2qFDh+Y5RnmKmv2gVI0XMPm4
   sleTyMGFlyOJ+Vft7Qodpq6bNDa53UjhRq0vyxZROBVXQMUEogyti6dfh
   w0C6xOJBS5jEbYjlF7iqRYpqGylex82OVlAaypEu62f5wwJXGRYkmYnjI
   w==;
X-CSE-ConnectionGUID: 35M/PjGcSqiY0FhaJpuw0Q==
X-CSE-MsgGUID: Qyyq1KtfSWG0soAxmh4PUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="12148824"
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="12148824"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 07:28:52 -0700
X-CSE-ConnectionGUID: eWJLsovWSjODipc7/RwU/g==
X-CSE-MsgGUID: Q3BTLC4FQ6WYo2s46rPXfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="42400756"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.246.1.223])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 07:28:48 -0700
Date: Wed, 19 Jun 2024 16:28:43 +0200
From: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: <linux-pci@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Bjorn
 Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Ilpo Jarvinen
 <ilpo.jarvinen@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, Keith
 Busch <kbusch@kernel.org>, Marek Behun <marek.behun@nic.cz>, Pavel Machek
 <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Stuart Hayes
 <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH v2 2/3] PCI/NPEM: Add Native PCIe Enclosure Management
 support
Message-ID: <20240619162843.0000311e@linux.intel.com>
In-Reply-To: <6656bb4654a65_16687294c0@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240528131940.16924-1-mariusz.tkaczyk@linux.intel.com>
	<20240528131940.16924-3-mariusz.tkaczyk@linux.intel.com>
	<6656bb4654a65_16687294c0@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 28 May 2024 22:21:10 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> > +
> > +	/*
> > +	 * For the case where a NPEM command has not completed immediately,
> > +	 * it is recommended that software not continuously =E2=80=9Cspin=E2=
=80=9D on
> > polling
> > +	 * the status register, but rather poll under interrupt at a
> > reduced
> > +	 * rate; for example at 10 ms intervals. =20
>=20
> I think the use of read_poll_timeout() obviates the need for this
> comment. I.e. read_poll_timeout() is self documenting.
>=20

This is not describing how read_poll_timeout works but why I need it at all.
I don't think that there is and ever will be a controller that needs a time=
 to
complete the NPEM request. From my experience this is immediate action. Thi=
s is
explanation why I have to keep it this way even if it has almost no sense :)

Mariusz

> > +	 *
> > +	 * PCIe r6.1 sec 6.28 "Implementation Note: Software Polling of
> > NPEM
> > +	 * Command Completed"
> > +	 */
> > +	ret =3D read_poll_timeout(npem_read_reg, ret_val,
> > +				ret_val || (cc_status &
> > PCI_NPEM_STATUS_CC),
> > +				10 * USEC_PER_MSEC, USEC_PER_SEC, false,
> > npem,
> > +				PCI_NPEM_STATUS, &cc_status);
> > +	if (ret)
> > +		return ret_val;

