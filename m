Return-Path: <linux-pci+bounces-7889-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1665A8D18FA
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 12:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EC0FB26485
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 10:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F2F16C458;
	Tue, 28 May 2024 10:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PYEomHgR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31C516C455;
	Tue, 28 May 2024 10:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716893650; cv=none; b=PzTbpYuISXGD55SiArdUB3gx0cN/6VRXM0jGu4H6U4nFLIYSgvsvmCatBuBsi0QLb9Q323KJzBeB+w9m2q/uscTYhMGkppTXw7E5we/p6JIhK+3bJv3D/Ltn15OtlJ1XyPIOGMpdkR5qWGO/+EKG2xqcIwFHWXSNKIPXS/1kQd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716893650; c=relaxed/simple;
	bh=hY2IyF5VkKUnCRNoEiTmp1zbBUsXZq3aH2g9Jh6R51Q=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tsdGaAZhQcls/+NsVpnI05QTfVwg7oVRI+UCsXK6c6/kpXG4woTU/uxFguOWYo4kzUEinGE8NVPXTMwkILOlcb2EtPnRNbzgnB+56g2ioZSZUJI6ZKEzzNmU4L9AFZ+m0ox2PqsygGgKQbzdrQfpRCQUD4am015vM5SW7K/J5DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PYEomHgR; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716893649; x=1748429649;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=hY2IyF5VkKUnCRNoEiTmp1zbBUsXZq3aH2g9Jh6R51Q=;
  b=PYEomHgRHsNgh1SljttYL7HVV0yZfDQf/P0KH2mrZ6yW6RJyNvLUI0P3
   EptQnq64CfcV0/dftx20yWTDVuEf4onKxNeUd+6GsGaRNK6JX83x/rgFJ
   QFITkZ5IdHhLg1v2tiXFUbLRGndpluRjvUjdQYAh1XGvBFVYr0lBobwhY
   uPFZHie0Iw8DZD2aE3tcfn4dGEcyaBScu5NfazJCi4GcORdDf3xvL0ZAj
   WeimUJvO5Ox9iwBhC9mzhg6O5ZcfyP3WJNL0VTetBSENnHkQyfTBGg4SW
   W878hYv9klLUy3PTIvVLeaj8se6YuYGbjUyR2WiUB6oP+H948dnl96Gfc
   w==;
X-CSE-ConnectionGUID: H0x1fhldS5m+ZiKvdJ8Cww==
X-CSE-MsgGUID: jzRfvlc/RieaKOgk0OG3DQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13002696"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="13002696"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 03:54:08 -0700
X-CSE-ConnectionGUID: UNCRf7SlSyaz0Q8mmkl4CQ==
X-CSE-MsgGUID: KjNuWBEBSz+0OXvc+v0qUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="39473828"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.144])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 03:54:05 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 28 May 2024 13:54:01 +0300 (EEST)
To: Bitao Hu <yaoma@linux.alibaba.com>
cc: Lukas Wunner <lukas@wunner.de>, bhelgaas@google.com, 
    weirongguang@kylinos.cn, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, kanie@linux.alibaba.com
Subject: Re: [PATCHv2] PCI: pciehp: Use appropriate conditions to check the
 hotplug controller status
In-Reply-To: <20240528064200.87762-1-yaoma@linux.alibaba.com>
Message-ID: <d9529e4c-05eb-d6eb-c8b7-248fd21338d1@linux.intel.com>
References: <20240524063023.77148-1-yaoma@linux.alibaba.com> <20240528064200.87762-1-yaoma@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1602990161-1716893227=:5869"
Content-ID: <6bf27e0d-15c0-dfee-137d-3a1869110431@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1602990161-1716893227=:5869
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <c828c09a-3bf8-6b1b-92bc-35225c1f25c7@linux.intel.com>

On Tue, 28 May 2024, Bitao Hu wrote:

> "present" and "link_active" can be 1 if the status is ready, and 0 if
> it is not. Both of them can be -ENODEV if reading the config space
> of the hotplug port failed. That's typically the case if the hotplug
> port itself was hot-removed. Therefore, this situation can occur:
> pciehp_card_present() may return 1 and pciehp_check_link_active()
> may return -ENODEV because the hotplug port was hot-removed in-between
> the two function calls. In that case we'll emit both "Card present"
> *and* "Link Up" since both 1 and -ENODEV are considered "true". This
> is not the expected behavior. Those messages should be emited when
> "present" and "link_active" are positive.
>=20
> Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>

Thanks for updaring the description.

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.


> ---
> v1 -> v2:
> 1. Explain the rationale of the code change in the commit message
> more clearly.
> 2. Add the "Reviewed-by" tag of Lukas.
> ---
>  drivers/pci/hotplug/pciehp_ctrl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pcie=
hp_ctrl.c
> index dcdbfcf404dd..6adfdbb70150 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -276,10 +276,10 @@ void pciehp_handle_presence_or_link_change(struct c=
ontroller *ctrl, u32 events)
>  =09case OFF_STATE:
>  =09=09ctrl->state =3D POWERON_STATE;
>  =09=09mutex_unlock(&ctrl->state_lock);
> -=09=09if (present)
> +=09=09if (present > 0)
>  =09=09=09ctrl_info(ctrl, "Slot(%s): Card present\n",
>  =09=09=09=09  slot_name(ctrl));
> -=09=09if (link_active)
> +=09=09if (link_active > 0)
>  =09=09=09ctrl_info(ctrl, "Slot(%s): Link Up\n",
>  =09=09=09=09  slot_name(ctrl));
>  =09=09ctrl->request_result =3D pciehp_enable_slot(ctrl);
>=20
--8323328-1602990161-1716893227=:5869--

