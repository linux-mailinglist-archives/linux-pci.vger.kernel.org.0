Return-Path: <linux-pci+bounces-3594-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC00D857DAB
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 14:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350DE288793
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 13:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B15E129A6F;
	Fri, 16 Feb 2024 13:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hiwXAz7C"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EFB1B966;
	Fri, 16 Feb 2024 13:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708090130; cv=none; b=Z8jmMxXP+8Z+3maGbugKThkdcBkwzpZ6gb+MxT3BDtH4Huhf/VSpmZX7/rT+h6QAY3JjCwUhiMsP7juNqNt2Sli4cK1DabA0WhHPf0/8KrvYTvWMs3RhzK+oap2ZRsOqRZrKFuAszJqCJGEvjaiHJDHpRMNFzZQe/fvuWta5rOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708090130; c=relaxed/simple;
	bh=oNwPBpuoEDBJRr8Y1RXJ7zxW3hizZaGgzKTjVXJJj5U=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JTtEBsmZecQrnJkwo8oOBcb+zM2tr4S7P2XO47OCnbwXD3fIvZj5Sxpw1HzI26rxhP2pPN/TPQ7iRCrnCIhsxBG1L8UVAflKINu3qAeYTJyfM73ZtTHdJiW+QqW+ZNVkfR5gfIuCeWTjxLzUPePrWW80nj4zporqJmW9nuT0dq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hiwXAz7C; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708090129; x=1739626129;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=oNwPBpuoEDBJRr8Y1RXJ7zxW3hizZaGgzKTjVXJJj5U=;
  b=hiwXAz7ClFl9X+U90XMvI2EQdJwcVwN6aDAPIID8w9Hj6rAOiGtxwUFL
   a78Mcnp30KhFd+Man6vRftPYTo9ItG56hS49YV8+FXmV/cjzjYyTT5GaV
   EOktC5PZPNEgHoZbduEs5XgQ3OWr7AFWK9fT3PyYp06YmHDxd5d2uYroA
   g6L6/cW1RXDFoXKP6hzhgjRMKpcB9vXajwU+I8c0ly/A4oynrQbI48yeF
   zHNA/LKeBaCKYhbfv8AeIN8mHJCSIhhMcybJgUfFjiwinQ0QF2iv/ieFi
   S8gLo7wr48AqQLIMMBco6kog+qv0KFQu+jjSHcnJBTUudfrhJH1Pq9yWD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2087954"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="2087954"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 05:28:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="34876144"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.248.234])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 05:28:45 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 16 Feb 2024 15:28:40 +0200 (EET)
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/1] PCI: Cleanup link activation wait logic
In-Reply-To: <alpine.DEB.2.21.2402021359450.15781@angie.orcam.me.uk>
Message-ID: <ce73f41a-b529-726f-ee4e-9d0e0cee3320@linux.intel.com>
References: <20240202134108.4096-1-ilpo.jarvinen@linux.intel.com> <alpine.DEB.2.21.2402021359450.15781@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1104822449-1708087900=:1097"
Content-ID: <8aebecf1-b380-ec81-f4e1-9ba90a0d18f8@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1104822449-1708087900=:1097
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <5bb50767-a43a-884b-8c39-8442de383a68@linux.intel.com>

On Fri, 2 Feb 2024, Maciej W. Rozycki wrote:

> On Fri, 2 Feb 2024, Ilpo J=E4rvinen wrote:
>=20
> > 1. Change pcie_failed_link_retrain() to return true only if link was
> >    retrained successfully due to the Target Speed quirk. If there is no
> >    LBMS set, return false instead of true because no retraining was
> >    even attempted. This seems correct considering expectations of both
> >    callers of pcie_failed_link_retrain().
>=20
>  You change the logic here in that the second conditional isn't run if th=
e=20
> first has not.  This is wrong, unclamping is not supposed to rely on LBMS=
=2E=20
> It is supposed to be always run and any failure has to be reported too, a=
s=20
> a retraining error.

Now that (I think) I fully understand the intent of the second=20
condition/block one additional question occurred to me.

How is the 2nd condition even supposed to work in the current place when=20
firmware has pre-arranged the 2.5GT/s resctriction? Wouldn't the link come=
=20
up fine in that case and the quirk code is not called at all since the=20
link came up successfully?


Yet another thing in this quirk code I don't like is how it can leaves the=
=20
target speed to 2.5GT/s when the quirk fails to get the link working=20
(which actually does happen in the disconnection cases because DLLLA won't=
=20
be set so the target speed will not be restored).


--=20
 i.
--8323328-1104822449-1708087900=:1097--

