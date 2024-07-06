Return-Path: <linux-pci+bounces-9873-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7532992915C
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jul 2024 08:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A451C21809
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jul 2024 06:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6EB1BC53;
	Sat,  6 Jul 2024 06:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VUVvQQaE"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA1117BD3;
	Sat,  6 Jul 2024 06:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720248290; cv=none; b=KvCb08YQjSuI2xgihSi+cySnPlBwQVVrsbYzNOavgyiIDGAxeHIgrVwOuWG/M1kkQamItpXfkBdN5LrZ5abLjVYrci2IxgvxuYCAZpSF7orGLzyarTKYVNj0rDLFaQUmxZEEytr8MA8Ei2EO+JlhPEs3UfX9MvDaWCeLlxtiKLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720248290; c=relaxed/simple;
	bh=NH0U8SYMXqcCSrXZ7qu6VT16yVW+2MZ7RLvA2Zodprg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6Azp8bgDE60bk4tcr6dCjeIkW+8uVIllkGykaJesjrGz4Ee90DlBtJ3hXZyMahvhyJYy4n4cN9yMzR/PIpArFUd1wxDB7p4YA8vHV6aLaRuwTta+HpVzVN3J2Q8/DlFK0YCRLSuNPa1zQY4SF++M4fJLEezBNWZClwamAs1s0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VUVvQQaE; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4666iFk8071877;
	Sat, 6 Jul 2024 01:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720248255;
	bh=qYoP9culH6ZxGxGoSntIgBVMnx2ZLL7C0Z7bcNlrEfY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=VUVvQQaEWs2FXOiJayzv62yXOQtE+NILGMyD9icXubuakt6GyqqkCgo7pJBIs+F1Z
	 /hlfr+pYwhw/HUESI10cWv99ZAkH3L4LtfVS+l+CnxfJHK1exInVmW68F/QY4d+Scl
	 UweOR31QJP+f0KhUBHdiT/sldL/k22LgKkBoLwek=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4666iFsQ009824
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 6 Jul 2024 01:44:15 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 6
 Jul 2024 01:44:14 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 6 Jul 2024 01:44:14 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4666iDda074785;
	Sat, 6 Jul 2024 01:44:14 -0500
Date: Sat, 6 Jul 2024 12:14:13 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Siddharth
 Vadapalli <s-vadapalli@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas
	<bhelgaas@google.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v1 0/2] PCI: ti: k3: Fix TI J721E PERST# polarity
Message-ID: <2def13f4-aea3-466c-9f8c-1e44694eeb4a@ti.com>
References: <20240703100036.17896-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240703100036.17896-1-francesco@dolcini.it>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Wed, Jul 03, 2024 at 12:00:34PM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Fix PCIe PERST# signal polarity in TI J721E used on TI K3 machines.
> 
> PCIe PERST# needs to be de-asserted for PCIe to work, however, the driver is
> doing the opposite and the device tree files are defining the signal with the
> wrong polarity to cope with that. Fix both the driver and the affected DT
> files.

For the series,

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Since DT and driver patches go to different subsystems, both patches need
to go in simultaneously to avoid making devices non-functional if one of
the patches gets applied but the other one doesn't.

Regards,
Siddharth.

