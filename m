Return-Path: <linux-pci+bounces-7121-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8770C8BD096
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 16:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F891C20E6F
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 14:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300B91534FC;
	Mon,  6 May 2024 14:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cN6LDqTR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782EF153512;
	Mon,  6 May 2024 14:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715006723; cv=none; b=bbYL+5FIa8PYNtlLDBp/RIlIA0JHDbti4wFkdTV6QtpYXbWFlz0OhyhXa5qOyzTgmNWjPZVWUyX1uVLjDu1v/p2d70Nb6tS3cyzexQf/8sC1kmxuhExzazE2/OWz+h8LOd7tWIRx1SCIDwg2EjNQrZBY8xW2kpkhViUAX6qmKEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715006723; c=relaxed/simple;
	bh=qqPt7Wt7gYvZOnYBUvmkMGDflLZVCnnovZFb11ykGlc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mTRy1lwNnQAC+WV7IudMbjQ2Kbwq8Q6CiwTVCcfVxMBzriPoWpA1peFf2QFFUvoocsfYzfaHl0XLrL7l97W2AleXFcgO54/biQMGu6vZWSbLRpx3qxt1zwAlQz85iZunklpgYmPrTXq/TcnPGkwNel7NR5xRmYud4PutR/igulM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cN6LDqTR; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715006721; x=1746542721;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qqPt7Wt7gYvZOnYBUvmkMGDflLZVCnnovZFb11ykGlc=;
  b=cN6LDqTRjfASwhXbl7ZCmTVUGqdgFuVo2xfUTyouF2G4nP12DjFaAZF4
   UZJN0o+Ey9appAXzMTdc+PHM5stBXHXFdT1nBws/eWUHd7llbXcdse0zf
   /2aV2HwLMmOtCg+cr3rJKhgEOSgT8gw/7RoTOawvsytqd8N2/S+6ILW3B
   8ODVIk6vS5QsJmHUqfVCjDJyAayDQMF1XDO3LwjdY7bz8SDLUR/Dhz+df
   GSQD7Z+ZkFgV4ee3n5y+dGGaEnCwlDfvrSj580cFauYRP+YLSqpdQGCx6
   VGMfILYpxaeFQL+qELy7LlymBdDW4B2XfWlWqXeXtp00m2QYXYjwNLZa0
   g==;
X-CSE-ConnectionGUID: le1S7EXtSVqElWiC0g7MrQ==
X-CSE-MsgGUID: DuGJc6QfQpmiolRUmg6xxg==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="33260549"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="33260549"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 07:45:03 -0700
X-CSE-ConnectionGUID: jPYMcEo7SUur/4ZIDivb+w==
X-CSE-MsgGUID: G5TNy78UT2K8v2ENday/Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="28579550"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.68])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 07:45:02 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 6 May 2024 17:44:57 +0300 (EEST)
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI/ASPM: Fix a typo in ASPM restoring logic
In-Reply-To: <20240506051602.1990743-1-kai.heng.feng@canonical.com>
Message-ID: <c74f0256-1453-3b91-d5a7-d797a0c2da90@linux.intel.com>
References: <20240506051602.1990743-1-kai.heng.feng@canonical.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-470952821-1715006697=:1111"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-470952821-1715006697=:1111
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 6 May 2024, Kai-Heng Feng wrote:

> There's a typo that makes parent device uses child LNKCTL value and vice
> versa. This causes Micron NVMe to trigger a reboot upon system resume.
>=20
> Correct the typo to fix the issue.
>=20
> Fixes: 64dbb2d70744 ("PCI/ASPM: Disable L1 before configuring L1 Substate=
s")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/pci/pcie/aspm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 2428d278e015..47761c7ef267 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -177,8 +177,8 @@ void pci_restore_aspm_l1ss_state(struct pci_dev *pdev=
)
>  =09/* Restore L0s/L1 if they were enabled */
>  =09if (FIELD_GET(PCI_EXP_LNKCTL_ASPMC, clnkctl) ||
>  =09    FIELD_GET(PCI_EXP_LNKCTL_ASPMC, plnkctl)) {
> -=09=09pcie_capability_write_word(parent, PCI_EXP_LNKCTL, clnkctl);
> -=09=09pcie_capability_write_word(pdev, PCI_EXP_LNKCTL, plnkctl);
> +=09=09pcie_capability_write_word(parent, PCI_EXP_LNKCTL, plnkctl);
> +=09=09pcie_capability_write_word(pdev, PCI_EXP_LNKCTL, clnkctl);

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-470952821-1715006697=:1111--

