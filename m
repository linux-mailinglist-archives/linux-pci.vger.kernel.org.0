Return-Path: <linux-pci+bounces-28861-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEC2ACC8DC
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 16:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 081FA3A6E0A
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 14:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30557239085;
	Tue,  3 Jun 2025 14:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NxE1XtCd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455B5238C34;
	Tue,  3 Jun 2025 14:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748960032; cv=none; b=ipbJucM+vs3ZtxhBMyTx13YH4EwIXE/ovxFQEcgWYYFuTWdyzEGm4tDQZ1LvsIiU4lfxn0jHTsfzcONZvg2v0zWYLPBZgW2ymFb36E7OcOX0Pbyw4ZEb4LLoRARvliawNUYU79gBQHb4dN3yr+gkrsZbgK+sYCB0agY9dxxlnxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748960032; c=relaxed/simple;
	bh=XpN9tvr9ot6DFEZ5vp9HcJjO/Ybh6K6FqbR+Hd8JsKo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cLdhZYL+BQNgIwqzjPMu4T6JZUZCuCAojcPJVkx+CSPigHVe3qvntvMM+yhqJnVMgXvgIbLGJHTRvjFXiT+T15uF0gKDcL5334gnESaLFystJCTw33a4dxsDVQTfFvVcIMWqcFnhA+lz4rWyhrSKYF1l74Z97iHMqKeDBzNueO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NxE1XtCd; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748960030; x=1780496030;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=XpN9tvr9ot6DFEZ5vp9HcJjO/Ybh6K6FqbR+Hd8JsKo=;
  b=NxE1XtCd5oFIlPY2C/i4rcHzsgjmRqXgyJlDqj9tWFnFoUV/ya3ELV++
   yfUA4PzTHFWBrAsoPjHOuUg/22x9B7P10BouK+lw1c4I66q1qUFVCObHS
   yJwqDXmbKGSDg9Yyu9CJOanKt5eIw/qqaSPPB9p5D32b2piUsocWpYXDJ
   V8VVsfajsktiZAUDEdZXed24zBEuDfNS75Vju02ajnmTpnolLHKVPAg1G
   7kw8E9Edza4I606FId//aioQYnznewaI1Ix8TbRCwBoa9ipZEMVosmazI
   XmjA1vzhYZIlUqPvbuJZjJeRzKwZmbKz2gSam2SFeXKrgQDHK1yd9jibV
   Q==;
X-CSE-ConnectionGUID: tLOvuGcQSp+ys6tVJQM4Sw==
X-CSE-MsgGUID: AnoCLZpCRkWZxBtKvHluKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="73533440"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="73533440"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 07:13:50 -0700
X-CSE-ConnectionGUID: mHCh+kHPT5i2t0EzTK7Onw==
X-CSE-MsgGUID: o/DAA1JqTxSrpvZel4xccw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="145199007"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.141])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 07:13:46 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 3 Jun 2025 17:13:42 +0300 (EEST)
To: Tudor Ambarus <tudor.ambarus@linaro.org>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    =?ISO-8859-2?Q?Micha=B3_Winiarski?= <michal.winiarski@intel.com>, 
    Igor Mammedov <imammedo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    William McVicker <willmcvicker@google.com>
Subject: Re: [PATCH 24/25] PCI: Perform reset_resource() and build fail list
 in sync
In-Reply-To: <c1c0bacd-7842-4e9e-aec4-66eb481aa43f@linaro.org>
Message-ID: <fc611a93-1f5f-a86d-f3ca-cb737ed5fa4a@linux.intel.com>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com> <20241216175632.4175-25-ilpo.jarvinen@linux.intel.com> <5f103643-5e1c-43c6-b8fe-9617d3b5447c@linaro.org> <8f281667-b4ef-9385-868f-93893b9d6611@linux.intel.com> <3a47fc82-dc21-46c3-873d-68e713304af3@linaro.org>
 <f6ee05f7-174b-76d4-3dbe-12473f676e4d@linux.intel.com> <867e47dc-9454-c00f-6d80-9718e5705480@linux.intel.com> <a56284a4-755d-4eb4-ba77-9ea30e18d08f@linaro.org> <7e882cfb-a35a-bab0-c333-76a4e79243b6@linux.intel.com> <f2d149c6-41a4-4a9a-9739-1ea1c4b06f4b@linaro.org>
 <19ccc09c-1d6b-930e-6ed6-398b34020ca1@linux.intel.com> <c1c0bacd-7842-4e9e-aec4-66eb481aa43f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1442673867-1748959943=:937"
Content-ID: <1acda035-065c-c402-bddf-95dc3e3e4932@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1442673867-1748959943=:937
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <0814a586-e99f-d077-ec9c-472d4cdfa367@linux.intel.com>

On Tue, 3 Jun 2025, Tudor Ambarus wrote:
> On 6/3/25 9:13 AM, Ilpo J=E4rvinen wrote:
> > So please test if this patch solves your problem:
>=20
> It fails in a different way, the bridge window resource never gets
> assigned with the proposed patch.

Is that a failure? I was expecting that to occur. It didn't assign=20
any resources into that bridge window.

If there's nothing to be assigned into the bridge window, the bridge=20
window itself is not created, that is the expected behavior (working as=20
designed). So you're comparing to the bridge window that was made too=20
large due to the disparity (and left unused, AFAICT).

It would be possible to put the condition inside the block which adds=20
the resource to the realloc_head, I initially put it there but then=20
decided to remove the disparity completely because why keep it if no=20
resource is going to be placed into the bridge window.

What's that class 0 device anyway? Why it has class 0?

> With the patch applied: https://termbin.com/h3w0
> With the blamed commit reverted: https://termbin.com/3rh6

--=20
 i.
--8323328-1442673867-1748959943=:937--

