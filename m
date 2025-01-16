Return-Path: <linux-pci+bounces-19970-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75352A13BE5
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 15:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B28C3AAB05
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 14:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC0D1F37CE;
	Thu, 16 Jan 2025 14:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f99JsM5h"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E856922A817;
	Thu, 16 Jan 2025 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737036778; cv=none; b=rpdjOtYqVtTYcCOuZyNUXr8jtURm4b9jBS8r1KmDSXQYlrwrjlPwrzrkV/0PTlHpo6UjCOs/oWwy+2j42RpXc+khMjHjXdFh7U4M1exVrQ/OIShnMI7ca+wKGe5hVD5b4hJXU97WEz/29dC5sEaq3OdsP05f+c+dBcksAxMoSfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737036778; c=relaxed/simple;
	bh=uCwwKPMOxYFbzkt1iiBRqc6nmCmYbMBQ8yaaejOw+oA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=F446fzUeSkfp3AwAvDyFFNCWcDlzJKgRhSvM70jPu+eq9ST6ok37S4JQK1hW50T3n1iz5AnxrJzFqzUAdyYa8nn5P0If+6zz6QvwBGC2DIKGyV9+mtLRD7AUCzfbYCgLFpgbLGzvb736jXrx4nMKZcyA5O39fszgBgsCa5yKZ20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f99JsM5h; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737036776; x=1768572776;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=uCwwKPMOxYFbzkt1iiBRqc6nmCmYbMBQ8yaaejOw+oA=;
  b=f99JsM5h13xYAh25PJXmqovf+vohlmiEIAYY9pmuE646NMiH0xZQF2Y1
   qVimuBIYEO6Ug6Mof35xlmKQBkLZNqSZ3/x19mM7TUI8po0amzqPEYPMY
   dRRlIds4Rq0vrdLD0+02p7yTbJIAqAnb98mhtaoQRF8TH7oeyHif3o7SY
   55Blfp2xBlfNZlc6c13Y1UX+cyV0hPJ7S7qPQYaKEeAb1s+stxD0Nb2Tk
   Jv0MvdNdtViX955WGuZGplATV4ZrAIoHMwn7CB9YoEuexMKaeeuO07a/w
   aUGA3Efpf4Vla/hVVwUlC9quX/5T1gK1yyeMPERbXgAGFvmZl3PjtISqP
   A==;
X-CSE-ConnectionGUID: E/hLzFfLSl6Bt9I1i1TrhA==
X-CSE-MsgGUID: YS1EeSytSVKoNIFKk7epeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="59901140"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="59901140"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 06:12:56 -0800
X-CSE-ConnectionGUID: 9DiDb9FkSrK4f2vf8xwQEA==
X-CSE-MsgGUID: JIT9QbZUSiuKuaOuIloD2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="105263461"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.116])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 06:12:52 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 16 Jan 2025 16:12:48 +0200 (EET)
To: Jiwei Sun <sjiwei@163.com>
cc: macro@orcam.me.uk, bhelgaas@google.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, helgaas@kernel.org, 
    Lukas Wunner <lukas@wunner.de>, ahuang12@lenovo.com, sunjw10@lenovo.com, 
    jiwei.sun.bj@qq.com, sunjw10@outlook.com
Subject: Re: [PATCH v2 2/2] PCI: reread the Link Control 2 Register before
 using
In-Reply-To: <20250115134154.9220-3-sjiwei@163.com>
Message-ID: <4df1849e-c56e-b889-8807-437aab637112@linux.intel.com>
References: <20250115134154.9220-1-sjiwei@163.com> <20250115134154.9220-3-sjiwei@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1153817558-1737035729=:933"
Content-ID: <4570a7bc-d6d8-0ac7-5da8-8ccb60165468@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1153817558-1737035729=:933
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <59ce13bd-3f26-93a8-fcf5-9db6666153ab@linux.intel.com>

On Wed, 15 Jan 2025, Jiwei Sun wrote:

> From: Jiwei Sun <sunjw10@lenovo.com>
>=20
> Since commit de9a6c8d5dbf ("PCI/bwctrl: Add pcie_set_target_speed() to se=
t
> PCIe Link Speed"), the local variable "lnkctl2" is not changed after
> reading from PCI_EXP_LNKCTL2 in the pcie_failed_link_retrain(). It might
> cause that the removing 2.5GT/s downstream link speed restriction codes
> are not executed.
>=20
> Reread the Link Control 2 Register before using.
>=20
> Fixes: de9a6c8d5dbf ("PCI/bwctrl: Add pcie_set_target_speed() to set PCIe=
 Link Speed")
> Suggested-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Jiwei Sun <sunjw10@lenovo.com>
> ---
>  drivers/pci/quirks.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 76f4df75b08a..02d2e16672a8 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -123,6 +123,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
>  =09=09=09return ret;
>  =09=09}
> =20
> +=09=09pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
>  =09=09pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
>  =09}

I started to wonder if there would be a better way to fix this. If I've=20
understood Maciej's intent correctly, there are two cases when the 2nd=20
step (the one lifting the 2.5GT/s restriction) should be used:

1) TLS is 2.5GT/s at the entry to the quirk and it's an ASMedia switch.

2) If the quirk lowered TLS to 2.5GT/s and the link became up fine=20
because of that. This also currently checks for ASMedia but in the v1 you=
=20
also proposed to change that. We know it works in some cases with ASMedia=
=20
but are unsure what happens with other switches.

In the case 2, we don't need to check TLS since the function itself asked=
=20
TLS to be lowered which did not return an error, so we know the speed was=
=20
lowered so why spend time on rereading the register? A simple local=20
variable could convey the same information.

In case 1, I don't think ASMedia check should be removed. It was about a=20
case where FW has a workaround to lower the speed (IIRC). If Link Speed is=
=20
2.5GT/s at entry but it's not ASMedia switch, there's no 2.5GT/s=20
restriction to lift.


As a general comment abouth your test case, I don't think this Target=20
Speed quirk really is compatible with your test case. The quirk makes=20
assumption that the Link Up/Down status changes are because of the changes=
=20
the quirk made itself but your rapid add/remove test alters the=20
environment, which produces unrelated Link Up/Down status changes that get=
=20
picked up by the quirk (a false signal).

--=20
 i.
--8323328-1153817558-1737035729=:933--

