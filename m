Return-Path: <linux-pci+bounces-43439-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 775D1CD1502
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 19:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F7F03110036
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 18:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC67E357A3F;
	Fri, 19 Dec 2025 17:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GlZhnrB6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7069357A35;
	Fri, 19 Dec 2025 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766166469; cv=none; b=T0mLQmzJVeZWG3XCWZI4jD+/8QsVPBPv9DP4Zp5704VzCuVhk0PhB9hd0/BssELtAXUG8aauSzKzCTqXj9P6/Is6HeNmzD+NOBfUzutfRt5hxKG8rlDYRVKbJSFCYebb9Nl3euHIeNC6X/C/HpmEOcsU0ZT9A3LmUsvQESd+ilU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766166469; c=relaxed/simple;
	bh=gSpqzcuKKji4Govcux/91VkzNrIKrAQW4sLagXAioSQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WJz3j8WMPhlxHUvGBwebWvN7352/bkabehezZqTSwen+gHP5bZjGrq2sLF4KHjg1J7gkSmBchrRgZZO5nAKLAFXbZnvH8oT/W0fudQdp5w34Y1CSngpinU+pW3+ZJr5DbudOva8LbLQ2sELlJ4/W5oKd7fdGK7DRRkKDntW7f+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GlZhnrB6; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766166468; x=1797702468;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gSpqzcuKKji4Govcux/91VkzNrIKrAQW4sLagXAioSQ=;
  b=GlZhnrB6np512DZ4ttgcQLlRLreOAIfTeLWO+H+ue1QZ9fW9ZT6BkTqm
   lIpnrJpVYezI8RsxFZiAnng+B1frEfJnKweEXvyTO/lPi38YAH38EAHde
   37zhrNkmcN4ZT2q9aXt13qsnMGd+7kamykS6kxkmWwTguC0iILopbx0wH
   hiCV+s9q97lx4ypwvDcabjQFOhPCT3MMd1sJtg+LPS4YcIbiThWBpM5Qs
   Mx4BVzrLzP8VsvkqC+oj/hN1GRz5nCuF/lbpehGEM5/XeNiY4BoUes8KY
   y5XQXP2RDAyOdfdmkMmU/oUqsmOEDu/fi7fUAnZVbtH0t+KfeY2E1CbJh
   A==;
X-CSE-ConnectionGUID: VvfzSoJ7SEuiS/tyuOTOgA==
X-CSE-MsgGUID: I0bEsJZlR/et3FY8aG2hiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="78764727"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="78764727"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:47:46 -0800
X-CSE-ConnectionGUID: J6f2dk2FRQO0898s4uVbMA==
X-CSE-MsgGUID: 0JbOyDfFQGK6D3gGnbbBLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="198067574"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:47:44 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 19 Dec 2025 19:47:40 +0200 (EET)
To: Dan Williams <dan.j.williams@intel.com>, 
    Jonathan Cameron <jonathan.cameron@huawei.com>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    Dominik Brodowski <linux@dominikbrodowski.net>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 14/23] resource: Mark res given to resource_assigned()
 as const
In-Reply-To: <20251219174036.16738-15-ilpo.jarvinen@linux.intel.com>
Message-ID: <d122e9cc-74bf-e233-824e-3aa4f2c7e199@linux.intel.com>
References: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com> <20251219174036.16738-15-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-365012398-1766166460=:987"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-365012398-1766166460=:987
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 19 Dec 2025, Ilpo J=C3=A4rvinen wrote:

> The caller may hold a const struct resource which will trigger an
> unnecessary warning when calling resource_assigned() as it will not
> modify res in anyway.
>=20
> Mark resource_assigned()'s struct resource *res parameter const to
> avoid the compiler warning.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

An afterthought right after sending, I should have Cc'ed Dan & Jonathan=20
to this so adding them now.

--=20
 i.


> ---
>  include/linux/ioport.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 9afa30f9346f..60ca6a49839c 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -338,7 +338,7 @@ static inline bool resource_union(const struct resour=
ce *r1, const struct resour
>   * Check if this resource is added to a resource tree or detached. Calle=
r is
>   * responsible for not racing assignment.
>   */
> -static inline bool resource_assigned(struct resource *res)
> +static inline bool resource_assigned(const struct resource *res)
>  {
>  =09return res->parent;
>  }
>=20
--8323328-365012398-1766166460=:987--

