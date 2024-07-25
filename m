Return-Path: <linux-pci+bounces-10761-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F74093BC00
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 07:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 611091C21560
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 05:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4871AACA;
	Thu, 25 Jul 2024 05:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vYdQpFJI"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFE6125B9;
	Thu, 25 Jul 2024 05:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721884847; cv=none; b=pBSteQ1SaR5Zv9nINcUQUEjNtVyJn3NLzSNMcR3dNHMnLqujtt08p6yEwq9+lIgFe0msjirXEV4CJpm+1WxwT6vVxmmu1RF5fYmXImDB+/WV40mk58Dm9SWH+q8QOaOxbGHK2duRXDgsPU5DSf5XovzaL7tcWF9VwahvpCe+/wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721884847; c=relaxed/simple;
	bh=i9h/wIIrsupTpQlvLzz2hR1ai4RTHZM884SqZi3N4j8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipayInwymUOGmNRmasOCVNmlxSOe2Tn5D1HpwewDXM1kUGR+bI19AZIDP+tjtffg+s8s4PaBaWYxCwxgkHEpzwdBib0xhtOVg4+NjtRBPy1rjNXvHgSWEXsR3GiNg+J+qReQbCSg6nE7RKyA0nFf6MQhnLJ8vFuuUef37/5zfuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vYdQpFJI; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46P5KFH8094186;
	Thu, 25 Jul 2024 00:20:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1721884815;
	bh=sVIXpPT1B6sTKWUwJ0lCN/4JH2C797gBeaG+hRk3Am8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=vYdQpFJIC9s4fr1BfRITGcIzmb3JfupyS4LHI/FNHTSymxsN0tfbXs4cJTVckjfmq
	 lU3woA1qQkWmuiSyWa2GYmCvMzE61ZYcqDUlcEA6sS4KatHUu85ImfuGNVd/BBuOlV
	 YzEbf4N6AuH4ynRsaMWY98VxOIZgPtlEQ4tb4E3M=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46P5KFNA063089
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Jul 2024 00:20:15 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Jul 2024 00:20:15 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Jul 2024 00:20:15 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46P5KDPX026939;
	Thu, 25 Jul 2024 00:20:14 -0500
Date: Thu, 25 Jul 2024 10:50:13 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <vigneshr@ti.com>, <kishon@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <stable@vger.kernel.org>, <ahalaney@redhat.com>, <srk@ti.com>
Subject: Re: [PATCH] PCI: j721e: Set .map_irq and .swizzle_irq to NULL
Message-ID: <69f8c45c-29b4-4090-8034-8c5a19efa4f8@ti.com>
References: <20240724065048.285838-1-s-vadapalli@ti.com>
 <20240724161916.GG3349@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240724161916.GG3349@thinkpad>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Wed, Jul 24, 2024 at 09:49:16PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Jul 24, 2024 at 12:20:48PM +0530, Siddharth Vadapalli wrote:
> > Since the configuration of Legacy Interrupts (INTx) is not supported, set
> > the .map_irq and .swizzle_irq callbacks to NULL. This fixes the error:
> >   of_irq_parse_pci: failed with rc=-22
> > due to the absence of Legacy Interrupts in the device-tree.
> > 
> 
> Do you really need to set 'swizzle_irq' to NULL? pci_assign_irq() will bail out
> if 'map_irq' is set to NULL.

While 'swizzle_irq' won't be invoked if 'map_irq' is NULL, having a
non-NULL 'swizzle_irq' (pci_common_swizzle in this case) with a NULL
'map_irq' seems inconsistent to me though the code-path may never invoke
it. Wouldn't a non-NULL 'swizzle_irq' imply that Legacy Interrupts are
supported, while a NULL 'map_irq' indicates that they aren't? Since they
are always described in pairs, whether it is in the initial commit that
added support for the Cadence PCIe Host controller (used by pci-j721e.c):
https://github.com/torvalds/linux/commit/1b79c5284439
OR the commit which moved the shared 'map_irq' and 'swizzle_irq' defaults
from all the host drivers into the common 'devm_of_pci_bridge_init()'
function:
https://github.com/torvalds/linux/commit/b64aa11eb2dd
I have set both of them to NULL for the sake of consistency.

Regards,
Siddharth.

