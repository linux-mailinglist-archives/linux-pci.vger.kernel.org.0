Return-Path: <linux-pci+bounces-38032-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E176BD8FA6
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 13:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 091BC4FD487
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 11:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFDB308F34;
	Tue, 14 Oct 2025 11:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gEU4ll0z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E93B30B516;
	Tue, 14 Oct 2025 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760440819; cv=none; b=X7dYAKgdVM7bR9bSiEmt0hG0qL/qAzJxyWl6+NvfmfXCaTpK+P8CgQSc3pty9gsaME8khDK+sbr+wPhqylu7BFlhlLCkIABp5Th6j7QJSo4wYsgdtQO7g/jIjLQtx0t9iMdHqcymSE9m4t/NYCVh13KECCbdSvAWU2ASH1SVDb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760440819; c=relaxed/simple;
	bh=kvMcNwOtUusFFRY1RzL3Brr02ntzT+T98eFD9Xd5Mm0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Nasgpk3WXDKxHo33/018LP2wpBSddISOwwqSRko+3jVVMcjoDxhksB+a4xeb46Q2Xl34NCTkwykJlJMg5s9vmtiboUsf4kwFnnyi5Kv5ij1IW4EBifz1nc23LNUl8oKl7Q+gyW15+xsza8f3CuGYtMpS7UYnD2Ppl8wauHfaX/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gEU4ll0z; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760440818; x=1791976818;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=kvMcNwOtUusFFRY1RzL3Brr02ntzT+T98eFD9Xd5Mm0=;
  b=gEU4ll0zP3MW7KsGCfxp1cg1vY/wKUgIY3yL1v76DPQyuWCOZTqQm7cu
   5oTAYOrEutf6kU/NAfy+U1rfuRs4cuRhaF4VWy2dqq0G5kIzi+uPn+0GR
   KITD/1+d1YS7N2PPp9Ryd5whm2hRo9pCxn+vyd4oQtToQ5wSVGs1D2t46
   NVgsH6iMvsHGtMXOSxUlIJNcZ8t7Xnr31AdrZf7gi1RYFfP41QfCWEIBh
   zQkr50MD6+xnYsm7M4lhViZgFgQSrl9h23S2Y1QJHRgtI+kouk12VhRPj
   aKMQEiXy2yc+glsud5W0ujuiI5c8lfvRDk1W+mmqATmsdpFW0b1pwjOHZ
   g==;
X-CSE-ConnectionGUID: X7QbSytARXGFWYhtl6Re/Q==
X-CSE-MsgGUID: xqV9rDZCRByui1ZhsJu5zQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="80035591"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="80035591"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 04:20:17 -0700
X-CSE-ConnectionGUID: dhNMvwYETwyk7aT+PC3RJw==
X-CSE-MsgGUID: zhQLlNvDQSOXnkX8pRc5sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="212477019"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.195])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 04:20:15 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 14 Oct 2025 14:20:11 +0300 (EEST)
To: Guenter Roeck <linux@roeck-us.net>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH 1/2] PCI: Setup bridge resources earlier
In-Reply-To: <df266709-a9b3-4fd8-af3a-c22eb3c9523a@roeck-us.net>
Message-ID: <b587595c-98f5-dd5a-31a2-6265bff1dc3a@linux.intel.com>
References: <20250924134228.1663-1-ilpo.jarvinen@linux.intel.com> <20250924134228.1663-2-ilpo.jarvinen@linux.intel.com> <df266709-a9b3-4fd8-af3a-c22eb3c9523a@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1380350465-1760431885=:925"
Content-ID: <34c8a03f-03d1-f48a-2b50-22202d7d51cf@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1380350465-1760431885=:925
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <dfb68ed0-92c9-e39b-cad7-6652b7b06feb@linux.intel.com>

On Mon, 13 Oct 2025, Guenter Roeck wrote:
> On Wed, Sep 24, 2025 at 04:42:27PM +0300, Ilpo J=E4rvinen wrote:
> > Bridge windows are read twice from PCI Config Space, the first read is
> > made from pci_read_bridge_windows() which does not setup the device's
> > resources. It causes problems down the road as child resources of the
> > bridge cannot check whether they reside within the bridge window or
> > not.
> >=20
> > Setup the bridge windows already in pci_read_bridge_windows().
> >=20
> > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
>=20
> This patch causes some boot test failures for me. Specifically, booting
> alpha images from PCI through a PCI bridge fails. Reverting it fixes
> the problem.
>=20
> Bisect log attached for reference.
>=20
> Guenter
>=20
> ---
> # bad: [3a8660878839faadb4f1a6dd72c3179c1df56787] Linux 6.18-rc1
> # good: [e5f0a698b34ed76002dc5cff3804a61c80233a7a] Linux 6.17
> git bisect start 'HEAD' 'v6.17'
> # good: [58809f614e0e3f4e12b489bddf680bfeb31c0a20] Merge tag 'drm-next-20=
25-10-01' of https://gitlab.freedesktop.org/drm/kernel
> git bisect good 58809f614e0e3f4e12b489bddf680bfeb31c0a20
> # good: [bed0653fe2aacb0ca8196075cffc9e7062e74927] Merge tag 'iommu-updat=
es-v6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux
> git bisect good bed0653fe2aacb0ca8196075cffc9e7062e74927
> # good: [6a74422b9710e987c7d6b85a1ade7330b1e61626] Merge tag 'mips_6.18' =
of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux
> git bisect good 6a74422b9710e987c7d6b85a1ade7330b1e61626
> # bad: [522ba450b56fff29f868b1552bdc2965f55de7ed] Merge tag 'clk-for-linu=
s' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
> git bisect bad 522ba450b56fff29f868b1552bdc2965f55de7ed
> # bad: [256e3417065b2721f77bcd37331796b59483ef3b] Merge tag 'for-linus' o=
f git://git.kernel.org/pub/scm/virt/kvm/kvm
> git bisect bad 256e3417065b2721f77bcd37331796b59483ef3b
> # bad: [2f2c7254931f41b5736e3ba12aaa9ac1bbeeeb92] Merge tag 'pci-v6.18-ch=
anges' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci
> git bisect bad 2f2c7254931f41b5736e3ba12aaa9ac1bbeeeb92
> # bad: [531abff0fa53bc3a2f7f69b2693386eb6bda96e5] Merge branch 'pci/contr=
oller/qcom'
> git bisect bad 531abff0fa53bc3a2f7f69b2693386eb6bda96e5
> # bad: [fead6a0b15bf3b33dba877efec6b4e7b4cc4abc3] Merge branch 'pci/resou=
rce'
> git bisect bad fead6a0b15bf3b33dba877efec6b4e7b4cc4abc3
> # good: [0bb65e32495e6235a069b60e787140da99e9c122] Merge branch 'pci/p2pd=
ma'
> git bisect good 0bb65e32495e6235a069b60e787140da99e9c122
> # good: [ebe091ad81e1d3e5cbb1592ebc18175b5ca3d2bd] PCI: Use pbus_select_w=
indow_for_type() during IO window sizing
> git bisect good ebe091ad81e1d3e5cbb1592ebc18175b5ca3d2bd
> # good: [15c5867b0ae6a47914b45daf3b64e2d2aceb4ee5] PCI: Don't print stale=
 information about resource
> git bisect good 15c5867b0ae6a47914b45daf3b64e2d2aceb4ee5
> # good: [dc32e9346b26ba33e84ec3034a1e53a9733700f9] PCI/pwrctrl: Fix devic=
e leak at device stop
> git bisect good dc32e9346b26ba33e84ec3034a1e53a9733700f9
> # good: [4c5cd8d64172de3730056366dc61392a3f2f003a] Merge branch 'pci/pm'
> git bisect good 4c5cd8d64172de3730056366dc61392a3f2f003a
> # bad: [a43ac325c7cbbfe72bdf9178059b3ee9f5a2c7dd] PCI: Set up bridge reso=
urces earlier
> git bisect bad a43ac325c7cbbfe72bdf9178059b3ee9f5a2c7dd
> # first bad commit: [a43ac325c7cbbfe72bdf9178059b3ee9f5a2c7dd] PCI: Set u=
p bridge resources earlier

Hi,

Is it possible to get some logs from this (both good and bad would be=20
the best so comparing is possible)?

I'm going to send a revert for the commit a43ac325c7cb ("PCI: Set up=20
bridge resources earlier") today anyway because of another issue it caused
but as I'm planning to pursue the same change later, it would be useful to=
=20
understand what goes wrong here so I know what additional supporting work=
=20
is needed before coming back with this change.

--=20
 i.
--8323328-1380350465-1760431885=:925--

