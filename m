Return-Path: <linux-pci+bounces-14090-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 943AB9969D4
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 14:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B5F1C20D4D
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 12:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B4B192B63;
	Wed,  9 Oct 2024 12:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="drtTTUov"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29C51922E5
	for <linux-pci@vger.kernel.org>; Wed,  9 Oct 2024 12:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728476461; cv=none; b=pi1T5tTP3C1Zgsi3OP4007mh5e611VhMh+TlZYqCaU4QXs5hL5JbeqNuSyjuThnFKXxO47055eiUHDzbVx6XzrUNRhPuYhXheAf/7Kq91ybV4lgg8finxeba3PbytTeeqUATnQCduaM+f4rlHRQ/SXuicUwRHKSobzgKxj7q5Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728476461; c=relaxed/simple;
	bh=WOFQsUPhUSlVsb35fHDoVefWrRNaDLZHzXX0Y4ymI8s=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=N/f5cPvh8R5SrTWqImJo44XcID7MLX8qx90O5LY6uWUzoTDqePKC9dmLyg5lK7mE7YEcS+Y4INVVmng93ZbWO2joBkr/HnWU+rBROdm3qLRit6VCKPcrDLCUqhtHgCPBvcq1EATqOc+yF1CHrc/eGuXSList/4/ZS9NRJT+l3UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=drtTTUov; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728476460; x=1760012460;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WOFQsUPhUSlVsb35fHDoVefWrRNaDLZHzXX0Y4ymI8s=;
  b=drtTTUovHpUg2ngIRSDugwdBpCSHOs1dktJoplYi5lmGybN+FfeMcI3F
   GRn2tF3TvLxQAcasgrkx91KoNOro3cTLS+Gy12a5BaEcQKFRpULV9HW4W
   HSNhA6Gpkv+3C4u0rqhksY34MUiBijxnbWvYCJ/GYc0+5WhvHarEZ53wp
   FVp4OO7e6HpiFzWYl6Dcpx8TlvnI7UatnLabRP74XQ8RNlalWrFIH2PBj
   JGvGfwF5+OqWqYxgWGuNAsUiwPqC84Xcjd3GREJL+dHKEWSySPLCsUl9c
   jTgOIOtRq/djEqGtnVpv1lFP8LLBRwcxp1QXH6M4dU8x9/ewJrCX9+EIJ
   g==;
X-CSE-ConnectionGUID: CUvZQTe/T2WlMgdamjNryA==
X-CSE-MsgGUID: ss63kIh8QpiJcgLVoSmRMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27219179"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="27219179"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 05:20:59 -0700
X-CSE-ConnectionGUID: W98HczXGRKyeyVtvIlB9hQ==
X-CSE-MsgGUID: LDxMNAEgQmGFvZLyUyVsWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="76681933"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.41])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 05:20:57 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 9 Oct 2024 15:20:53 +0300 (EEST)
To: Keith Busch <kbusch@meta.com>
cc: linux-pci@vger.kernel.org, bhelgaas@google.com, 
    Keith Busch <kbusch@kernel.org>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCHv2 5/5] pci: unexport pci_walk_bus_locked
In-Reply-To: <20240827192826.710031-6-kbusch@meta.com>
Message-ID: <e4b88c7f-17d1-2bf5-5e3a-3f077f130c1a@linux.intel.com>
References: <20240827192826.710031-1-kbusch@meta.com> <20240827192826.710031-6-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1562087914-1728476453=:930"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1562087914-1728476453=:930
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 27 Aug 2024, Keith Busch wrote:

> From: Keith Busch <kbusch@kernel.org>
>=20
> There's only one user of this, and it's internal, so no need to export
> it.
>=20
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/pci/bus.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 8491e9c7f0586..30620f3bb0e2d 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -435,7 +435,6 @@ void pci_walk_bus_locked(struct pci_bus *top, int (*c=
b)(struct pci_dev *, void *
> =20
>  =09__pci_walk_bus(top, cb, userdata);
>  }
> -EXPORT_SYMBOL_GPL(pci_walk_bus_locked);

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1562087914-1728476453=:930--

