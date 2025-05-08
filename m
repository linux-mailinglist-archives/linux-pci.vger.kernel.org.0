Return-Path: <linux-pci+bounces-27433-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6619DAAF62F
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 11:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A01B41BC4DE9
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 09:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6354424468E;
	Thu,  8 May 2025 09:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JeSX2aYI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B504C23C517;
	Thu,  8 May 2025 09:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746694804; cv=none; b=DuavvVBCGxToZd32MvF32Vxadrf5aIfctkmMBpO9poWkdUlhqMKmB0Mq4/D3cenExLwpdjRaF5mNhFjpQChBFCGoOD5KiTHD7a7ApA+dA+hqCRrkMsU8ysfOrm4WVBUHLK0u6hjTeV/SyTE55+H3hsquX04DSZ/L5MmxfF/r27Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746694804; c=relaxed/simple;
	bh=AaeWpi+yydjjAMPRH8AVWiTo86051eamAp/lfybEBio=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QFPgJ0saWSHFGCUMQIbZFqXt5C9kvz5pfwjocNx5/ZTTz/NoJdqOvYxL+1jxce7WyWna23NEjZwSMRiLRi/p0AemOnIsX3Fy6kNGgE9Op8wl7nmRNBnMTkebpTCrWOIJYxL8gbyrddApkhgB4BKkRLGXZeWVE3YAYijySkJhg7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JeSX2aYI; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746694803; x=1778230803;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=AaeWpi+yydjjAMPRH8AVWiTo86051eamAp/lfybEBio=;
  b=JeSX2aYIaIA6yeLgSW9I4eYeLhCWqdCiDGo7gnnNA2ZfeoT9v7q2JokU
   Qg/YzBqFAy8QEAA5bQtQgEhk/7RY1gvBlersXM8X3hBJZaiDosnkcq+EX
   p0JKIUpT2IUG89oCZ+7znKBU7uiSwEmUZ5AK5kbdR+xKbeLSRoDJw0zdh
   O1i11Y5B2RxT7JzbSZLQ6wHrc5vqaEkpzJBc4RblTQVxNp3ZBG4+1/Ivj
   UfHMSlHHmfwDwklFHT6W4R8GTAm0kJgAGegoYleIpi+ZPLU0DuQiPFCVp
   JTchMNYPGqRpT1wZYbiHugT2HO+Nc+fjgdPQkSLI1Il0hdDE3nyn7dt8A
   w==;
X-CSE-ConnectionGUID: 5QZ+qf1IRUqDXWQxPVUP0Q==
X-CSE-MsgGUID: Dg6LD25/T6qds32myNC7kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="48628718"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="48628718"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 02:00:02 -0700
X-CSE-ConnectionGUID: YbfE/K9wQw+aMceyhwuuug==
X-CSE-MsgGUID: IrS8fQ0mRyOfaUDqt1MDWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="167164017"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.196])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 01:59:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 8 May 2025 11:59:56 +0300 (EEST)
To: "Paul E. McKenney" <paulmck@kernel.org>
cc: bhelgaas@google.com, linux-pci@vger.kernel.org, kernel-team@meta.com, 
    LKML <linux-kernel@vger.kernel.org>, sfr@canb.auug.org.au, 
    linux-next@vger.kernel.org
Subject: Re: [PATCH] PCI/bwctrl: Remove unused pcie_bwctrl_lbms_rwsem
In-Reply-To: <3840f086-91cf-4fec-8004-b272a21d86cf@paulmck-laptop>
Message-ID: <099859f7-6a27-ca1a-7e22-4facafc4b6c4@linux.intel.com>
References: <3840f086-91cf-4fec-8004-b272a21d86cf@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1810519414-1746694529=:922"
Content-ID: <178ae2f6-e5bf-ff7d-18f7-e740c101bee3@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1810519414-1746694529=:922
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <516b9215-2156-176f-cd2c-bed75f2e5277@linux.intel.com>

On Wed, 7 May 2025, Paul E. McKenney wrote:

> PCI/bwctrl: Remove unused pcie_bwctrl_lbms_rwsem
>=20
> Builds with CONFIG_PREEMPT_RT=3Dy get the following build error:
>=20
> drivers/pci/pcie/bwctrl.c:56:22: error: =E2=80=98pcie_bwctrl_lbms_rwsem=
=E2=80=99 defined but not used [-Werror=3Dunused-variable]
>=20
> Therefore, remove this unused variable.  Perhaps this should be folded
> into the commit shown below.
>=20
> Fixes: 0238f352a63a ("PCI/bwctrl: Replace lbms_count with PCI_LINK_LBMS_S=
EEN flag")
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: "Ilpo J=C3=A4rvinen" <ilpo.jarvinen@linux.intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: <linux-pci@vger.kernel.org>
>=20
> diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
> index fdafa20e4587d..841ab8725aff7 100644
> --- a/drivers/pci/pcie/bwctrl.c
> +++ b/drivers/pci/pcie/bwctrl.c
> @@ -53,7 +53,6 @@ struct pcie_bwctrl_data {
>   * (using just one rwsem triggers "possible recursive locking detected"
>   * warning).
>   */
> -static DECLARE_RWSEM(pcie_bwctrl_lbms_rwsem);
>  static DECLARE_RWSEM(pcie_bwctrl_setspeed_rwsem);
> =20
>  static bool pcie_valid_speed(enum pci_bus_speed speed)
>=20

I've a patch which removes not only the rwsem but also the comment details=
=20
related to it. I've just not sent it yet because lkp has been very cranky=
=20
recently to build test things in a reasonable time.

--=20
 i.
--8323328-1810519414-1746694529=:922--

