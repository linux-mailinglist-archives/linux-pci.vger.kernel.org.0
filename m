Return-Path: <linux-pci+bounces-7214-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59F18BF7C8
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 09:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93A2D28550E
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 07:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2340B3613C;
	Wed,  8 May 2024 07:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G86IK9I3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F00228383;
	Wed,  8 May 2024 07:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154917; cv=none; b=F4FOreH9Cr6PwYB2wha3byneUTfm+eIK9III7+C4JkknnI3iSBsKTapp0AIiIJ44OX3OktXN53YZmUkFrLs3ZaMe/8qlOVlYMLiYIFqK5SPmoZh8zGWeNNI+edhD50YT3dmol4zlXYu7YOsyaROqKS5sVl+Q6UCW5Wq8XoiD0vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154917; c=relaxed/simple;
	bh=YrROZEGTXJ5Na3vZ1OgfXZMfsvJsndhnGWoVmoGD1fE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YB68aZs39s0JU423lRJvSt74ziLjyKFPlmvgPMAU9i60aSYUzzABBbU0Z0NMBTdEk457UvQp45X1xKMXkz/OKRwirKjeqxn/1DYgUyBEp2iydhh2gr62Zk54cbEXjbK3jU/tQQxxckCM9GEXqgSbI9cBVn9PsLrxh1fOhrE3jQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G86IK9I3; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715154916; x=1746690916;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=YrROZEGTXJ5Na3vZ1OgfXZMfsvJsndhnGWoVmoGD1fE=;
  b=G86IK9I30KZcdNT7/Yz5mvE8urgzlawIHbC15mRM4uNqrkVGcEFKs7Ka
   FpvCofZdtHpf5wV2MpyU3p11Qw56QfJtYvqqQlO2hzYyC83FX/GQFzOdn
   3l7APYocoXyMPd3qYZDptInnmJf10+xJLd4Zyo3DDFKiQ2ojJLdwVXmCP
   J5foiqP5/acsgua6w932hhfCB0zJvCMiznv056IFAuiTXm0ZPIfJ3eqa0
   Sl//EesSmJv61zUeU7joAx2xAAkgrCeTgNViSc1Bqxf6hw0PZ8TwoGls2
   5T1okcPCBmnaoudVfh9TyW1NVKGjOR2fdotHFayTLwIs8Op3zYX3gnmVz
   g==;
X-CSE-ConnectionGUID: 5HeRvp3ATHKLvwfxgWGwlg==
X-CSE-MsgGUID: 3tVgoquiSqKjAFHsu5V7zQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="10867375"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="10867375"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 00:55:15 -0700
X-CSE-ConnectionGUID: nIvYSU2mSQKcdsyUT5oGzw==
X-CSE-MsgGUID: kqiuqbQCTcSp8uQkIlFagQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="33494143"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.80])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 00:55:12 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 8 May 2024 10:55:07 +0300 (EEST)
To: "Dr. David Alan Gilbert" <linux@treblig.org>
cc: bhelgaas@google.com, dave.hansen@linux.intel.com, x86@kernel.org, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86: ce4100: Remove unused struct 'sim_reg_op'
In-Reply-To: <20240507232348.46677-1-linux@treblig.org>
Message-ID: <8a3efad2-8e65-5ba4-573c-4fb041bf675b@linux.intel.com>
References: <20240507232348.46677-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1989487649-1715154864=:3164"
Content-ID: <cab851e2-067e-3290-0970-8adbffef36a3@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1989487649-1715154864=:3164
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <4773f2f7-b4b1-5e0f-d133-313ae9fbffb4@linux.intel.com>

On Wed, 8 May 2024, linux@treblig.org wrote:

> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>=20
> struct 'sim_reg_op' doesn't look like it was ever used.
> Remove it.
>=20
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  arch/x86/pci/ce4100.c | 6 ------
>  1 file changed, 6 deletions(-)
>=20
> diff --git a/arch/x86/pci/ce4100.c b/arch/x86/pci/ce4100.c
> index 87313701f069e..f5dbd25651e0f 100644
> --- a/arch/x86/pci/ce4100.c
> +++ b/arch/x86/pci/ce4100.c
> @@ -35,12 +35,6 @@ struct sim_dev_reg {
>  =09struct sim_reg sim_reg;
>  };
> =20
> -struct sim_reg_op {
> -=09void (*init)(struct sim_dev_reg *reg);
> -=09void (*read)(struct sim_dev_reg *reg, u32 value);
> -=09void (*write)(struct sim_dev_reg *reg, u32 value);
> -};
> -

Thanks.

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.
--8323328-1989487649-1715154864=:3164--

