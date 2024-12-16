Return-Path: <linux-pci+bounces-18512-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D494D9F3511
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 16:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03ED41889283
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 15:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D722484A5E;
	Mon, 16 Dec 2024 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KI3ENP0+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAAC148FF0
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 15:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734364523; cv=none; b=nRnOLr9JulTa08hPKWgvjXPPbmUjq7H9fFFy1SJ7hRNjr/kitGl29czrCDikHT40Yi7P2vZCw7W/it9QITNGuEPprEgz9HRGpPO5odzFcHXj/r0t+AlcQ7gSnRcWysM4isiCj/ZOaVI3HRU7nrVv2IubzSbR4dpW4fraTZP2C8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734364523; c=relaxed/simple;
	bh=DhMQ81JiQIUHP4I1dckoQnLgcr2me1VWvzaca1SA/es=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Lb0QS0hGXuT8l2xK4V305KyrOeW5VdkROU8A2cEPqDpFwg2zlsACJrkD8fxYOKu2Sa9IzdDciwdRGjz58L0ZGXHTNabo89iLKyX0EJe3jf1XxLdUKfHW6eGDn5WcLmePlsa76SaI6qSxQ7Kuc0l3OD9cBPTtw1XAkptfbbmb+wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KI3ENP0+; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734364522; x=1765900522;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=DhMQ81JiQIUHP4I1dckoQnLgcr2me1VWvzaca1SA/es=;
  b=KI3ENP0+I5uQIh7EjnRWDtKVEeNBiO79ESoKVPBICTzrtmqIYA3QOi5m
   Q/KcQbm7TV6WArrMPEPCmhZYIk6MvyTFH6/u0MHqmD6dBIUTVFBnaycjg
   zwiy+40lUEfMEQVSlScEmjxCsuQUjJCjRdZebOgq4yZ5rxH96BPto38wj
   wfdpdLsGl1P5neKEHTEaMPrCEUxXSFdpBoEVTJ8cH1AQcB86odqEJbhSg
   S/RmzVnP2Bii4tNe3/mAWAVJqAxKHf+IwtXRY+FZMqVeSjZR+M4N+AVgJ
   4+YayvritZLoQ23tmfnGA9eYWVuiPzmjy0ZqAFu/NOksOC04aqV8yTZjH
   g==;
X-CSE-ConnectionGUID: qjGYPjWkQOyUvG6bGk+HAA==
X-CSE-MsgGUID: /YdwEDwMR+26OoprI8Jz2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="52168752"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="52168752"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 07:55:21 -0800
X-CSE-ConnectionGUID: p6ZTJrjFRvy96s3/ZPAVGA==
X-CSE-MsgGUID: aV3eWowAQQaR436cinJRMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120495195"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 07:55:20 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 16 Dec 2024 17:55:16 +0200 (EET)
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
    Niklas Schnelle <niks@kernel.org>
Subject: Re: [PATCH] PCI: Update code comment on PCI_EXP_LNKCAP_SLS for PCIe
 r3.0
In-Reply-To: <ceb8f672fa834c96b7287b7f74fb60b166be109e.1734338101.git.lukas@wunner.de>
Message-ID: <49c29ad2-bc6f-0213-2fa0-562d00c0a546@linux.intel.com>
References: <ceb8f672fa834c96b7287b7f74fb60b166be109e.1734338101.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-147570352-1734364490=:941"
Content-ID: <e3fb4c8f-c3a0-090c-62a3-df1e13e13142@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-147570352-1734364490=:941
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <81887081-4815-c8f7-3878-c1ed254b0b09@linux.intel.com>

On Mon, 16 Dec 2024, Lukas Wunner wrote:

> Niklas notes that the code comment on the PCI_EXP_LNKCAP_SLS macro is
> outdated as it reflects the meaning of the field prior to PCIe r3.0.
> Update it to avoid confusion.
>=20
> Reported-by: Niklas Schnelle <niks@kernel.org>
> Closes: https://lore.kernel.org/r/70829798889c6d779ca0f6cd3260a765780d136=
9.camel@kernel.org/
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  include/uapi/linux/pci_regs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.=
h
> index 1601c7e..521a04e 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -533,7 +533,7 @@
>  #define  PCI_EXP_DEVSTA_TRPND=090x0020=09/* Transactions Pending */
>  #define PCI_CAP_EXP_RC_ENDPOINT_SIZEOF_V1=0912=09/* v1 endpoints without=
 link end here */
>  #define PCI_EXP_LNKCAP=09=090x0c=09/* Link Capabilities */
> -#define  PCI_EXP_LNKCAP_SLS=090x0000000f /* Supported Link Speeds */
> +#define  PCI_EXP_LNKCAP_SLS=090x0000000f /* Max Link Speed (prior to PCI=
e r3.0: Supported Link Speeds */
>  #define  PCI_EXP_LNKCAP_SLS_2_5GB 0x00000001 /* LNKCAP2 SLS Vector bit 0=
 */
>  #define  PCI_EXP_LNKCAP_SLS_5_0GB 0x00000002 /* LNKCAP2 SLS Vector bit 1=
 */
>  #define  PCI_EXP_LNKCAP_SLS_8_0GB 0x00000003 /* LNKCAP2 SLS Vector bit 2=
 */

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.
--8323328-147570352-1734364490=:941--

