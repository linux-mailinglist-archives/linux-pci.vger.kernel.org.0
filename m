Return-Path: <linux-pci+bounces-5243-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE8788DA47
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 10:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FDEF1C22DCE
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 09:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B39328DDC;
	Wed, 27 Mar 2024 09:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mN+OaX8U"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654361F606;
	Wed, 27 Mar 2024 09:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711531896; cv=none; b=S/9hRkvPqYiabb4U+bPa7lRBlvYd9UUGbiJc1KF5ZkBs5UFY71DiZJWGgAkwerFUj+MpSLxwthABOJNyjXzwrRELQu5eIASqizkJU0hox8Kz9N2XW1UDKHZ5A4sA2HzntG9cGaNA/Ieq6UG6/pKfLqe2C/Tok17qy6HK+rqfbPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711531896; c=relaxed/simple;
	bh=LmzTj529SWaNQnWYqmZUkRoDPnws9jyPAxQhRljdGYg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDNtRtbWOht2W+okBFSI5Vut+AJ/WdIEP5DxRwhwjrfnHSLCq0LGgJ8mdQ6yN9mBV2N8hDmrMXubhZY8W6v57YRjF8GTAGOWyH4S/SQcpbXHH1Lu00JTz8HzmH3GJY96Pb2monvoDOFgTcTDLEyhl7KQa5+loAkkd09p3PXN+WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mN+OaX8U; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42R9VApg033380;
	Wed, 27 Mar 2024 04:31:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711531870;
	bh=mFIeq2rRiY8WqXVke/uUYNI4+SZR1gOPxX20+WHNUgU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=mN+OaX8UTonabTD9IAYNcXY0ilJxstmnMW6DJjXgo23+OYXMoo/1cMTC7MVlPz4WN
	 DzSNuLBzlgtZak4XZLAaxhSURxCUFLQpO0pGgkUzV+8jPn8AhC92sF3pR0wsAjrqP+
	 Ts0XdYfn2FLlPlIZ0T/jIpNRpXtXm+b3GklR098I=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42R9VA1f067486
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 27 Mar 2024 04:31:10 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Mar 2024 04:31:10 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Mar 2024 04:31:10 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42R9V9Hj001289;
	Wed, 27 Mar 2024 04:31:09 -0500
Date: Wed, 27 Mar 2024 15:01:08 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <manivannan.sadhasivam@linaro.org>, <fancer.lancer@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <cassel@kernel.org>,
        <dlemoal@kernel.org>, <yoshihiro.shimoda.uh@renesas.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH v6] PCI: keystone: Fix pci_ops for AM654x SoC
Message-ID: <49077b26-9ca3-4ef7-8b25-8c58adf95f5d@ti.com>
References: <20240326144258.2404433-1-s-vadapalli@ti.com>
 <20240326232403.GA1502764@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240326232403.GA1502764@bhelgaas>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Tue, Mar 26, 2024 at 06:24:03PM -0500, Bjorn Helgaas wrote:
> On Tue, Mar 26, 2024 at 08:12:58PM +0530, Siddharth Vadapalli wrote:
> > In the process of converting .scan_bus() callbacks to .add_bus(), the
> > ks_pcie_v3_65_scan_bus() function was changed to ks_pcie_v3_65_add_bus().
> > The .scan_bus() method belonged to ks_pcie_host_ops which was specific
> > to controller version 3.65a, while the .add_bus() method had been added
> > to ks_pcie_ops which is shared between the controller versions 3.65a and
> > 4.90a. Neither the older ks_pcie_v3_65_scan_bus() method, nor the newer
> > ks_pcie_v3_65_add_bus() method is applicable to the controller version
> > 4.90a which is present in AM654x SoCs.
> > 
> > Thus, as a fix, move the contents of "ks_pcie_v3_65_add_bus()" to the
> > .msi_init callback "ks_pcie_msi_host_init()" which is specific to the
> > 3.65a controller. Also, move the definitions of ks_pcie_set_dbi_mode()
> > and ks_pcie_clear_dbi_mode() above ks_pcie_msi_host_init() in order to
> > avoid forward declaration.
> 
> If it's possible to split this into two patches (one that strictly
> *moves* the code without otherwise changing it, and another that makes
> the actual fix), it would be easier to review the fix.  It's a pain to
> have to compare the code in the old location with that in the new
> location.

Sure. I will do so and post the v7 patch.

Regards,
Siddharth.

