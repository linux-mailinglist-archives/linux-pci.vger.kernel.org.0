Return-Path: <linux-pci+bounces-38980-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C4EBFB4A4
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 12:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 62F3F4F5BD0
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 10:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE5D3101B8;
	Wed, 22 Oct 2025 10:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DBogCluX"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9855312810;
	Wed, 22 Oct 2025 10:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127445; cv=none; b=uJdFMRUxpNy/avBmaE8dC0ZEtgujVOmIXeJwXWrJe/KJYZ8zTkuuCIY0hcMRksC5j20VThTPVxe2PFKmOR12hfbkGlyw/mCRqm8qB/3TSG4dFe9gcxC611ujKvNCXCBh0GzCQR3CXxIH6G85UeUHvinuF+3Glp5CKiEeYKK4IJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127445; c=relaxed/simple;
	bh=udzxeQrk4E6qAUdQvhTLThRFQurxZu1L87hIsq/P/dQ=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F2Q8lPp95wOzPaoVtGZ9J92lpp7dKj34n2jrzzmaRj4vr517tReJE4fU+ZI7uk79fQZNfshPMjLFuNTZoUeS5J9MRoYMWvlMQrqzgYGGsmPIqDao+M8SFNZNPRBZT3vhtYzIjnpudZ0Ke9L60wZi2xA1YkyCQv1Xwe4eu4DhZmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DBogCluX; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59MA3loZ1388280;
	Wed, 22 Oct 2025 05:03:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761127427;
	bh=V2E3bKUWqxt43xxDaSyCeVMDOuZW8i9NfudoceglB0M=;
	h=Subject:From:To:CC:Date:In-Reply-To:References;
	b=DBogCluXGB8JAxOJTLHi7+2AjNjNIo/R+ZPgLaOPa6hklMc9hKD2mHRZfwRB74yrF
	 uEyWxX5y5q5dtGL7RSyH9wu4Iv7NWV3idhxfejZkwz87aw/Zf3YRUmedSmxw1ntZHH
	 vToasDgKSGLxccUKNuJAyXEkc+tHSizw8c92vXCQ=
Received: from DFLE203.ent.ti.com (dfle203.ent.ti.com [10.64.6.61])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59MA3lqW2270139
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 Oct 2025 05:03:47 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 05:03:46 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 22 Oct 2025 05:03:46 -0500
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59MA3f4s1039878;
	Wed, 22 Oct 2025 05:03:42 -0500
Message-ID: <1d9ba815214ba97e2a9a6d091661cf59ae22c7ca.camel@ti.com>
Subject: Re: [PATCH 2/2] PCI: keystone: Remove the __init macro for the
 ks_pcie_host_init() callback
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <cassel@kernel.org>,
        <kishon@kernel.org>, <sergio.paracuellos@gmail.com>,
        <18255117159@163.com>, <jirislaby@kernel.org>, <m-karicheri2@ti.com>,
        <santosh.shilimkar@ti.com>, <stable@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Date: Wed, 22 Oct 2025 15:33:50 +0530
In-Reply-To: <20251002143627.GA267439@bhelgaas>
References: <20251002143627.GA267439@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Thu, 2025-10-02 at 09:36 -0500, Bjorn Helgaas wrote:

Hello Bjorn,

> On Fri, Sep 12, 2025 at 03:37:59PM +0530, Siddharth Vadapalli wrote:
> > The ks_pcie_host_init() callback registered by the driver is invoked by
> > dw_pcie_host_init(). Since the driver probe is not guaranteed to finish
> > before the kernel initialization phase, the memory associated with
> > ks_pcie_host_init() may already be freed by free_initmem().
> >=20
> > It is observed in practice that the print associated with free_initmem(=
)
> > which is:
> > 	"Freeing unused kernel memory: ..."
> > is displayed before the driver is probed, following which an exception =
is
> > triggered when ks_pcie_host_init() is invoked which looks like:
> >=20
> > 	Unable to handle kernel paging request at virtual address ...
> > 	Mem abort info:
> > 	...
> > 	pc : ks_pcie_host_init+0x0/0x540
> > 	lr : dw_pcie_host_init+0x170/0x498
> > 	...
> > 	ks_pcie_host_init+0x0/0x540 (P)
> > 	ks_pcie_probe+0x728/0x84c
> > 	platform_probe+0x5c/0x98
> > 	really_probe+0xbc/0x29c
> > 	__driver_probe_device+0x78/0x12c
> > 	driver_probe_device+0xd8/0x15c
> > 	...
> >=20
> > Fix this by removing the "__init" macro associated with the
> > ks_pcie_host_init() callback and the ks_pcie_init_id() function that it
> > internally invokes.
> >=20
> > Fixes: 0c4ffcfe1fbc ("PCI: keystone: Add TI Keystone PCIe driver")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>=20
> I dropped this from pci/controller/keystone because of the resulting
> section mismatch:
>=20
>   https://lore.kernel.org/r/202510010726.GPljD7FR-lkp@intel.com
>=20
> ks_pcie_host_init() calls hook_fault_code(), which is __init, so we
> can't make ks_pcie_host_init() non-__init.
>=20
> Both are bad problems, but there's no point in just swapping one
> problem for a different one.

Since this patch is required only for the case where the driver supports
being built as a loadable module, I have reworked on the patch and have
squashed it into patch 4 of the following series:
https://lore.kernel.org/r/20251022095724.997218-5-s-vadapalli@ti.com/
The implementation above ensures that 'hook_fault_code()' is placed within
an '__init' function while the '__init' keywords can safely be removed from
the remaining functions. Please review and let me know.

Regards,
Siddharth.

