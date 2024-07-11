Return-Path: <linux-pci+bounces-10152-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1416E92E55B
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 13:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E73628106B
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 11:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FB715746D;
	Thu, 11 Jul 2024 11:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RykFNq37"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CB2156F5D;
	Thu, 11 Jul 2024 11:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720695928; cv=none; b=Q7GmBR2uMxhSd7j/uwTXYlY91vcEg4TdFYjGBwpmSV9NOFf7qxz0bLLSFleZ6ik9LoO0BdrW/jfhflLJDuIi1M2RCzQ7DQVS4GlX7OOjz/b8uinMP4Wqm3klUnINTzu1ZdB3rvf52eoaRfAddS687xSrK8HtV0f/DKLHlfzDoz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720695928; c=relaxed/simple;
	bh=JiYpCqAyIboDSFHKDduO+bx97bBcPjVtQTohMQc4QLg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=L5ngrluBZToEBDYRToVhycXKkNFBXdLl3RrT8MlzFIeqsKntc2k50hupsBWTt4kmKJqIwa6voB5jRVPnWUKKkETwyiQwWoS2X6uhEc2qgLfExMSsKqhqNczL7M2RLZy3vtCh6qlG7QChiSN/CVSIgTyLTWAtHISqDS5Ime5JN1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RykFNq37; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720695927; x=1752231927;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JiYpCqAyIboDSFHKDduO+bx97bBcPjVtQTohMQc4QLg=;
  b=RykFNq37X+FI/BEf2gD0MPqhSkcfJEvgtoQIZZ/jz5ukjaoBHl69Q7eQ
   7RIAgD3vaB7O+AM5t+mJNZfM9qXrC6AOE5zP+gJQVJ0StncK2wFwHS+q9
   F3WLVTZy/2gNbQdX4T8oF8jUcG+Bvd7z6+NcUyYibg0v9Jz5dbIdxmU02
   /kLSfHl/oC+z1robb9xA5YfHFiRdv2vjvdj8ZDb2Jn1drpVSHmg+06aot
   zCwpkgDJ49l8aX/A+cNSB/xnJCE+19pcI06Qk4maJoU6+qnFVTbTQrI9I
   WyJHuYojXyZ69VxSNv1/gvrEy/lX5CZJdX6/cFI2sDkJKjC7oEabJ1Y2v
   g==;
X-CSE-ConnectionGUID: lj9ksX5bSCeIK0dgmXnnXQ==
X-CSE-MsgGUID: 7pYko7BxS12k6/qc1l9DtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="40580182"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="40580182"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 04:05:27 -0700
X-CSE-ConnectionGUID: k3DNBoMrRN63B7vi2mAG0A==
X-CSE-MsgGUID: vycflJQMRyemJRMSn71qtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="53700819"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.127])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 04:05:23 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 11 Jul 2024 14:05:19 +0300 (EEST)
To: daire.mcnamara@microchip.com
cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    conor.dooley@microchip.com, lpieralisi@kernel.org, kw@linux.com, 
    robh@kernel.org, bhelgaas@google.com, LKML <linux-kernel@vger.kernel.org>, 
    linux-riscv@lists.infradead.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v7 2/3] PCI: microchip: Fix inbound address translation
 tables
In-Reply-To: <20240711102218.2895429-4-daire.mcnamara@microchip.com>
Message-ID: <b22a15d8-54d5-a8cf-717b-73c5af347755@linux.intel.com>
References: <20240711102218.2895429-2-daire.mcnamara@microchip.com> <20240711102218.2895429-4-daire.mcnamara@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1175667782-1720695919=:6262"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1175667782-1720695919=:6262
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 11 Jul 2024, daire.mcnamara@microchip.com wrote:

> From: Daire McNamara <daire.mcnamara@microchip.com>
>=20
> On Microchip PolarFire SoC the PCIe Root Port can be behind one of three
> general purpose Fabric Interface Controller (FIC) buses that encapsulates
> an AXI-S bus. Depending on which FIC(s) the Root Port is connected
> through to CPU space, and what address translation is done by that FIC,
> the Root Port driver's inbound address translation may vary.
>=20
> For all current supported designs and all future expected designs,
> inbound address translation done by a FIC on PolarFire SoC varies
> depending on whether PolarFire SoC in operating in coherent DMA mode or
> noncoherent DMA mode.
>=20
> The setup of the outbound address translation tables in the Root Port
> driver only needs to handle these two cases.
>=20
> Setup the inbound address translation tables to one of two address
> translations, depending on whether the rootport is being used with cohere=
nt
> DMA or noncoherent DMA.
>=20
> Fixes: 6f15a9c9f941 ("PCI: microchip: Add Microchip Polarfire PCIe contro=
ller driver")
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1175667782-1720695919=:6262--

