Return-Path: <linux-pci+bounces-28099-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA49DABD702
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 13:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 512218A5E0F
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 11:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14966274FD0;
	Tue, 20 May 2025 11:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WAOmHb1T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A12B1DE2A8;
	Tue, 20 May 2025 11:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747741067; cv=none; b=hvpDhoE2myfgjXNiSrz7VcntediQNipnB/FY4K0I/ehcpOQGe747cGfjOtCur22kBa6UDkFJMdoUmuwofFa36Jrfj6wMZAZQbVtt5w3gUKSlc1dMTeAZpbPaHxYYEXs0Ndt8l1P/SduJwhrzS8VMnQAFVlf2c3Ql06lxz7v+EVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747741067; c=relaxed/simple;
	bh=JZT3t/IlAfusfoWxhMUxTHePqNlUTlsw8BDpHV7BHRY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gI0FGuRwNAKNvD2TxXwhhEkP5UoGN3MJn5OUXt9//tFUGZYnh4XDkRcGfcYwW2T+CSf1+b4dv3wmNzczDAuWGFFS+b1kDPw4IveBUStaUqWlqZmb1246muEaw9lvu0rgjeoyCqemH26wVlC4FtUARNhXi8WrE91p+0ZfRcNA7z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WAOmHb1T; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747741065; x=1779277065;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JZT3t/IlAfusfoWxhMUxTHePqNlUTlsw8BDpHV7BHRY=;
  b=WAOmHb1TnaphiDWt23/cAPs0+wtbLNdDr+K7Zqzhxn1ynceTeAGFdVIf
   9PFZIAIR0l9u/1BuQLWAIN1vJh6xBGrZLrmxDeUFcqJLn9PKqdnmR8LqX
   HFxpov9+Guxt3gy4xXVzMOxGnSuyYNiy9T/pxMXBXCLIMW1u1wQVoytPw
   0u1Sw/XMi3ZqaqLFc4LcSsVWwXGcUZd3TAiMHpKdHf6SgApL9emN1wH23
   HzuYEYpePuxDjamplyseek7Qk7HSc402+9kiDPwIgZEu8CyloleapSxBY
   U2bhE9EXtbe/n8wQLHTZltKOcYLnMtEeC4OOlXFQWQFguiws+GsN5J6tt
   A==;
X-CSE-ConnectionGUID: 9qnmyhAoQ6q6SsMfmV+EnA==
X-CSE-MsgGUID: qEBIwFFRQiOttVILqvEhIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49806342"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49806342"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 04:37:43 -0700
X-CSE-ConnectionGUID: ic4X7e+rTxqBQ4TxyRlWEg==
X-CSE-MsgGUID: 8feM2N1HTdic6OGIJoZD2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="140201921"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 04:37:36 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 20 May 2025 14:37:33 +0300 (EEST)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: linux-pci@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>, 
    Karolina Stolarek <karolina.stolarek@oracle.com>, 
    Martin Petersen <martin.petersen@oracle.com>, 
    Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
    Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
    Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, 
    Lukas Wunner <lukas@wunner.de>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    Sargun Dhillon <sargun@meta.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
    Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
    Oliver O'Halloran <oohall@gmail.com>, Kai-Heng Feng <kaihengf@nvidia.com>, 
    Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>, 
    Terry Bowman <terry.bowman@amd.com>, Shiju Jose <shiju.jose@huawei.com>, 
    Dave Jiang <dave.jiang@intel.com>, LKML <linux-kernel@vger.kernel.org>, 
    linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 12/16] PCI/AER: Make all pci_print_aer() log levels
 depend on error type
In-Reply-To: <20250519213603.1257897-13-helgaas@kernel.org>
Message-ID: <921fea13-9a28-9dc6-90c3-48498626f317@linux.intel.com>
References: <20250519213603.1257897-1-helgaas@kernel.org> <20250519213603.1257897-13-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1883428364-1747741053=:936"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1883428364-1747741053=:936
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 19 May 2025, Bjorn Helgaas wrote:

> From: Karolina Stolarek <karolina.stolarek@oracle.com>
>=20
> Some existing logs in pci_print_aer() log with error severity by default.
> Convert them to depend on error type (consistent with rest of AER logging=
).
>=20
> Link: https://lore.kernel.org/r/20250321015806.954866-3-pandoh@google.com
> Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pcie/aer.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 73b03a195b14..06a7dda20846 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -788,15 +788,21 @@ void pci_print_aer(struct pci_dev *dev, int aer_sev=
erity,
>  =09layer =3D AER_GET_LAYER_ERROR(aer_severity, status);
>  =09agent =3D AER_GET_AGENT(aer_severity, status);
> =20
> -=09pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
> +=09aer_printk(info.level, dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n",
> +=09=09   status, mask);
>  =09__aer_print_error(dev, &info);
> -=09pci_err(dev, "aer_layer=3D%s, aer_agent=3D%s\n",
> -=09=09aer_error_layer[layer], aer_agent_string[agent]);
> +=09aer_printk(info.level, dev, "aer_layer=3D%s, aer_agent=3D%s\n",
> +=09=09   aer_error_layer[layer], aer_agent_string[agent]);
> =20
>  =09if (aer_severity !=3D AER_CORRECTABLE)
> -=09=09pci_err(dev, "aer_uncor_severity: 0x%08x\n",
> -=09=09=09aer->uncor_severity);
> +=09=09aer_printk(info.level, dev, "aer_uncor_severity: 0x%08x\n",
> +=09=09=09   aer->uncor_severity);
> =20
> +=09/*
> +=09 * pcie_print_tlp_log() uses KERN_ERR, but we only call it when
> +=09 * tlp_header_valid is set, and info.level is always KERN_ERR in
> +=09 * that case.
> +=09 */
>  =09if (tlp_header_valid)
>  =09=09pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));

There's another similar callsite but only this has the comment added. I=20
was thinking if this call could be made from __aer_print_error(). There=20
would be small change in order of messages but I can't seem to decide if=20
it would be bad/good.

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>


>  }
>=20

--=20
 i.

--8323328-1883428364-1747741053=:936--

