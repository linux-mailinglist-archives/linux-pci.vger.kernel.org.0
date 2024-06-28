Return-Path: <linux-pci+bounces-9399-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5049E91BAB1
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 11:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D9A1C20BAE
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 09:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6944214B956;
	Fri, 28 Jun 2024 09:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kyzpMQb9"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0729C7E766;
	Fri, 28 Jun 2024 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565493; cv=none; b=ohbM1JxHsMf8gLiF6Bh/X32vkOBrmcWE4tLma7kvxUONsGl/SP+bFXNTcAHGlR49YEzfoSA0Gr1jCH6rV2MpSKDE6O12uzRouBrsiGCk0WYTrGfRaqSOxQBefmS0d6hW9hszuOoIUt4CiSavCUYD8xB9ozssIaYx3HOJsiFo4HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565493; c=relaxed/simple;
	bh=U3+DfGDqFokDiR/y2k4xxkXE0EkMHAg60CIsaw1oG54=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkXzueRjylOBf/7ZbFTpO1kXs0ZMWtQEpoMRX1NBIfQKZ/RpA5wQUiyLaMKrYbZGvVctVzH3qjcgvu0aD9oBdWmM35WspD34p8gD/84eOiz5M8L5oy8ULs5G41CNBMU6AEEk9mDZTQPedkLpSk1o3Rq+DtXyTIm6lz2GPDEbXus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kyzpMQb9; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1719565491; x=1751101491;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=U3+DfGDqFokDiR/y2k4xxkXE0EkMHAg60CIsaw1oG54=;
  b=kyzpMQb9owWbwKSCRA6z6YK3fTz/aaVZNNCNsBnc0BFlKrximrTOZC6M
   5bRaNH5/hu+bQhlmvZ/V7/t3cDAL3FbVUrUWyZ4AGzyhTuLVmfh2LDsuQ
   hAG2R2K8Qpi4m5a4qN000xKlZ6UJw/Ri6qqiQxmmvXxRjwXrFK25yKKBM
   fw1Zbi/oyktNt51+NhSQcOx16wQfYofL/TiEXTguymoF6d/82t8MU64bg
   Ke+ntB8Cm8JqNeqUIhhTKAgvreKG9dxmF1CXRWrrMx00VMcF9KvoZmXLh
   j1x/MG+4ruR9d/NAYz2kD+PdKy4tplirbXML5Fe8m+nuPoPMA69hYP4C7
   g==;
X-CSE-ConnectionGUID: wfCG7+eBT9GlpV5sQJBFkA==
X-CSE-MsgGUID: deir/aDGSFCkzcqL2B9BEA==
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="196014078"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2024 02:04:50 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 28 Jun 2024 02:04:38 -0700
Received: from daire-X570 (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 28 Jun 2024 02:04:36 -0700
Date: Fri, 28 Jun 2024 10:04:36 +0100
From: Daire McNamara <daire.mcnamara@microchip.com>
To: Conor Dooley <conor@kernel.org>
CC: <linux-pci@vger.kernel.org>, Conor Dooley <conor.dooley@microchip.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v2 0/2] PCI: microchip: support using either instance 1
 or 2
Message-ID: <Zn58pDsX5YZL/pTD@daire-X570>
References: <20240612-outfield-gummy-388a36d95100@spud>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240612-outfield-gummy-388a36d95100@spud>

With the proviso of fixing the axi_/apb_ nit

Acked-by: Daire McNamara <daire.mcnamara@microchip.com>

On Wed, Jun 12, 2024 at 11:57:54AM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The current driver and binding for PolarFire SoC's PCI controller assume
> that the root port instance in use is instance 1. The second reg
> property constitutes the region encompassing both "control" and "bridge"
> registers for both instances. In the driver, a fixed offset is applied to
> find the base addresses for instance 1's "control" and "bridge"
> registers. The BeagleV Fire uses root port instance 2, so something must
> be done so that software can differentiate. This series splits the
> second reg property in two, with dedicated "control" and "bridge"
> entries so that either instance can be used.
> 
> Cheers,
> Conor.
> 
> v2:
> - try the new reg format before the old one to avoid warnings in the
>   new case
> - reword $subject for 2/2
> 
> CC: Daire McNamara <daire.mcnamara@microchip.com>
> CC: Lorenzo Pieralisi <lpieralisi@kernel.org>
> CC: Krzysztof Wilczyński <kw@linux.com>
> CC: Rob Herring <robh@kernel.org>
> CC: Bjorn Helgaas <bhelgaas@google.com>
> CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
> CC: Conor Dooley <conor+dt@kernel.org>
> CC: linux-pci@vger.kernel.org
> CC: devicetree@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> CC: linux-riscv@lists.infradead.org
> 
> Conor Dooley (2):
>   dt-bindings: PCI: microchip,pcie-host: fix reg properties
>   PCI: microchip: rework reg region handing to support using either
>     instance 1 or 2
> 
>  .../bindings/pci/microchip,pcie-host.yaml     |  10 +-
>  drivers/pci/controller/pcie-microchip-host.c  | 155 +++++++++---------
>  2 files changed, 79 insertions(+), 86 deletions(-)
> 
> -- 
> 2.43.0
> 
> 

