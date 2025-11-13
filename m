Return-Path: <linux-pci+bounces-41134-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 07504C5923C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 18:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 51D994F2653
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 16:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701DC347BBA;
	Thu, 13 Nov 2025 16:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EllSJxDc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34A7339719;
	Thu, 13 Nov 2025 16:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051737; cv=none; b=fzWH2oeqb4vE0QuK7Jp0Z9LB9rz1JNb8GbNhf80reOCqJSdpP6Cl0vbdmFkv9xoDUgy4upJvdv6x+lUdemltgtZw2pBpVjE3c171xMweYfMQZZhXgYCMtclSoyefWY0LR3UH5cOfsq+k4H4dhRmP0dILlydGpP2/GuDvEDh3c+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051737; c=relaxed/simple;
	bh=7sbPr+OYyRHBar1nKJfkvEGRrRcDwW4T5/fLzZ8KSEo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=B61Gy1RyaAdsVO83EOgNJ/t2aAsoADXtSfRpyQ1q7IZ9Ma5aGvK8B3RXNYURrFJziu34YUtgre5A2VJSvgrwUAXv1f5zYhwfefAWh5WcQfuhn4Jck6EOtZpvDM14eSLfqDRnhoNHh0t44VH17/hOWG6HLp0+Qu8s02/9wFJ7Iqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EllSJxDc; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763051735; x=1794587735;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7sbPr+OYyRHBar1nKJfkvEGRrRcDwW4T5/fLzZ8KSEo=;
  b=EllSJxDc1De/hqVhnw/Z8XITHBdhpRfNAh5cUOiA7GsRL9EQ1vjSHvG7
   O1rUo0HXPlX7Vg0rHw9sosBjVAhYRhaquyV1pLPjgb4zLcyFgPLwjsfND
   Obub0PNA6mbh//YsaJzvXCHnxJHqXxWAaevrmeWTBLuJ0llA7RsVYwn/K
   JPhcyZBfyn7BPwsBzB2gJ5fbF0UT2kBY9QiRHdPj7XqadS/e9NmQuys4r
   DCDz/IQCN3u+SvwH8zMufWzNQCROQi8Fcpw3wZrho2hcSlovj6XmiW7M/
   1FvRsyT9C30nuQxwpMq5CQn9pwGrTZX+CebAN9X3seHbMpCQJbM551E1U
   w==;
X-CSE-ConnectionGUID: kELafbY9SGuVnPIIxajDww==
X-CSE-MsgGUID: IUq6GM66SSmR7ZT3rRf+9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="65044998"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="65044998"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 08:35:34 -0800
X-CSE-ConnectionGUID: 8fmo2khdT9W4Y07G+JXKdA==
X-CSE-MsgGUID: UwGyd1zXQbq2VfYt/HLLxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="220357168"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.164])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 08:35:30 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 13 Nov 2025 18:35:26 +0200 (EET)
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
Subject: Re: [PATCH 2/9] PCI/IOV: Adjust ->barsz[] when changing BAR size
In-Reply-To: <20251113162932.GA2285446@bhelgaas>
Message-ID: <fe9bd3af-51f6-c1af-9cdc-c78aee7aaef9@linux.intel.com>
References: <20251113162932.GA2285446@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1084105416-1763051726=:1464"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1084105416-1763051726=:1464
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 13 Nov 2025, Bjorn Helgaas wrote:

> On Tue, Oct 28, 2025 at 07:35:44PM +0200, Ilpo J=C3=A4rvinen wrote:
> > pci_rebar_set_size() adjusts BAR size for both normal and IOV BARs. The
> > struct pci_srvio keeps a cached copy of BAR size in unit of
> > resource_size_t in ->barsz[] ...
>=20
> Nit: s/pci_srvio/pci/sriov/  (fixed locally, FYI in case you post a v2)

I just posted v2 without seeing this first. :-(

I seem to never learn to type those letters in the correct order, I don't=
=20
know why I always keep typing them wrong.

> I'm not sure what "unit of resource_size_t" adds here, maybe could be
> removed to just say this?
>=20
>   struct pci_srvio keeps a cached copy of BAR size in ->barsz[] ...

Seems okay with me. I just had it there to differentiate from "BAR size"=20
which happens to often be the format directly compatible with field in the=
=20
capability.

--=20
 i.

--8323328-1084105416-1763051726=:1464--

