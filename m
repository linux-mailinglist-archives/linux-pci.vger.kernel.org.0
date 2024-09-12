Return-Path: <linux-pci+bounces-13079-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1C897665D
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 12:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD73D1C22552
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 10:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D55919F417;
	Thu, 12 Sep 2024 10:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="h21ds/VH"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284DB19F11E;
	Thu, 12 Sep 2024 10:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726135632; cv=none; b=KjcrORI+6c3+VfnE9I4pI80c82alqNv7Z4/EBgQV+yX/uGNdfpH93SPSimbSKEQ+E8TbSO5ZE127EPYpoK8yuDP21j1jVO2UEbotozrkjka9G/ANeLS+JUSNgHkfs5ZnJUrIBXBTeotxDUtbg7MsW7xUVFXiXtYkfPuSeC3h87c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726135632; c=relaxed/simple;
	bh=EJCGgwOHi77U8FIKfss4VuvUdqHqZz530jawwjimG2E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ssy2LHoQJ8iOsqbS6i1BcZA5NkcceCKRqGN+jUl7G9a8g2oGPToMrRLlD4NPLw4Br/5P2NtmQzAsUXeLeGaTkXe/T7t2PIDJEKfKTbykZI+LA6P4dowEMllpTXi2u3g6bAppPsjkYe+iNnHOJVN2nW44G08C27L4JgxetqZL5Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=h21ds/VH; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726135630; x=1757671630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EJCGgwOHi77U8FIKfss4VuvUdqHqZz530jawwjimG2E=;
  b=h21ds/VHwnbgTCNTooYYfPdGQbGlo0bx+2psOEzZi/y4Mr9EEv2QZqlN
   5UBDAwB31SYJLlPM9Fh58UB9vH5wITD39s4WeAwNSPsV191VR8fDl3O6/
   XE/NsLZLhWMtVSowo+rUWuMbx7YYTyzxt9/rzz32dlUJs52E7growl7Au
   JfoXllroykfJwhVYtesy/Whg8nM3vlsDsAT4z+wxdpR/6nDKvjLtG99af
   b4vW5fZv5H53gSe2Cnsi9R8F9H9TwBe9r1YCh0GQd0jsUa9eIGYuBcHxg
   fhLad/j+xMhIpMf42FclAfSWfTe9UnH8KmONEb1jzoLgVUIlAt0BaHr7L
   w==;
X-CSE-ConnectionGUID: awTA+CbwSDixD6oej565Sw==
X-CSE-MsgGUID: IsO8H+kRQHu3hyeZG9YDLQ==
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="asc'?scan'208";a="199122536"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Sep 2024 03:07:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 12 Sep 2024 03:06:28 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 12 Sep 2024 03:06:26 -0700
Date: Thu, 12 Sep 2024 11:05:53 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Minda Chen <minda.chen@starfivetech.com>
CC: "daire.mcnamara@microchip.com" <daire.mcnamara@microchip.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v9 2/3] PCI: microchip: Fix inbound address translation
 tables
Message-ID: <20240912-volumes-endowment-fe086922b7fb@wendy>
References: <20240823122717.1159133-1-daire.mcnamara@microchip.com>
 <20240823122717.1159133-3-daire.mcnamara@microchip.com>
 <SHXPR01MB08632D4FA056118612EA675AE6642@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vvHfXKRD49Gr5X7v"
Content-Disposition: inline
In-Reply-To: <SHXPR01MB08632D4FA056118612EA675AE6642@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>

--vvHfXKRD49Gr5X7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 12, 2024 at 09:49:38AM +0000, Minda Chen wrote:
> > From: Daire McNamara <daire.mcnamara@microchip.com>

Please trim unrelated content.

> Hi Daire
>   Could you please CC Kevin to this patch-set e-mail list? Thanks.

FWIW, he could get the series at
https://lore.kernel.org/all/20240823122717.1159133-1-daire.mcnamara@microchip.com/
and reply (if he sees fit) by downloading the mbox file from there.

Cheers,
Conor.

--vvHfXKRD49Gr5X7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuK9AQAKCRB4tDGHoIJi
0oRBAP9NuJLmcBaWRm34X+5yqIgA1dObMoxcaYKAHulHXLQLEAEAx3UXAVlXSIYs
GeqX7abkP2vR6fVEBHEWrMscpDqTfgU=
=Hs/l
-----END PGP SIGNATURE-----

--vvHfXKRD49Gr5X7v--

