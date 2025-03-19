Return-Path: <linux-pci+bounces-24070-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4FDA6850B
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 07:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA13519C4F0B
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 06:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA42207DE2;
	Wed, 19 Mar 2025 06:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FECVW/wH"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CEC36B;
	Wed, 19 Mar 2025 06:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742365570; cv=none; b=SvaGK3BZm4bdT/wgG9ubivqG+ahZzYJCKWN1O6/RiqyTWaKb6wwf9KcMczFiLhpoakZi1xMjEOHyOTbqgosg4o9vRuI+aBdUB+J0653iqaAiXTCrvY/YwZ2KzjBXhJ5R/KUK0mKtsrIEK9kkT1GHVOJbSpweIgbbtiVFMgAUDeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742365570; c=relaxed/simple;
	bh=U6SArNBHWS1YYTHhdyr6Rup9vaUAqNexq3y6l+RSFV8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMYDJpWAipFWEg6rdRpd9kixnpipkl2kNTf3b5U6b6JzPX0D2wGbktVWUDR9n8mSUqi0Y4ZQCS2XL75SMLEukCloo2imMAQV5fExk+QT2ak3Ej8uhW8BHTS79tIFuf/qxz41zYicPmYDeIXibsd/gh1FkbnftOUPypxoz4bD7XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FECVW/wH; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52J6PaLY2867113
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 01:25:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1742365536;
	bh=wv/JMa59iPeha8ecw51y5UYHYXQ3yaH9RGx+mD3DOpc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=FECVW/wHrZKI1FDW/kX1vkt0dr8LLLpKGdETf309/1kTHOrO4GqcSoKZGBnf6O5gw
	 ozqbDvJ08pOS3xeoh8sJtJhMtqpRSm1fCwC3EDKPIZtXpFxRgk2b51Zb531APUBGBi
	 E7axGjYlhdUY9fsgS3CxQGia9KMipVgWSETY4HHU=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52J6PaWK000874
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 19 Mar 2025 01:25:36 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Mar 2025 01:25:35 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Mar 2025 01:25:36 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52J6PZnl106908;
	Wed, 19 Mar 2025 01:25:35 -0500
Date: Wed, 19 Mar 2025 11:55:34 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Peter Chen <peter.chen@cixtech.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <vigneshr@ti.com>, <kishon@kernel.org>,
        <cassel@kernel.org>, <wojciech.jasko-EXT@continental-corporation.com>,
        <thomas.richard@bootlin.com>, <bwawrzyn@cisco.com>,
        <linux-pci@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>
Subject: Re: [PATCH 0/4] Loadable Module support for PCIe Cadence and J721E
Message-ID: <20250319062534.ollh3s5t7znf5zqs@uda0492258>
References: <20250307103128.3287497-1-s-vadapalli@ti.com>
 <Z9pffxeXHVOsoi4O@nchen-desktop>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z9pffxeXHVOsoi4O@nchen-desktop>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Wed, Mar 19, 2025 at 02:09:03PM +0800, Peter Chen wrote:

Hello Peter,

> On 25-03-07 16:01:24, Siddharth Vadapalli wrote:
> > EXTERNAL EMAIL
> >
> > Hello,
> >
> > This series enables support to build the PCIe Cadence Controller drivers
> > and the PCI J721E Application/Wrapper/Glue driver as Loadable Kernel
> > Modules. The motivation for this series is that PCIe is not a necessity
> > for booting the SoC, due to which it doesn't have to be a built-in
> > module. Additionally, the defconfig doesn't enable the PCIe Cadence
> > Controller drivers and the PCI J721E driver, due to which PCIe is not
> > supported by default. Enabling the configs as of now (i.e. without this
> > series) will result in built-in drivers i.e. a bloated Linux Image for
> > everyone who doesn't have the PCIe Controller.
> 
> If the user doesn't enable PCIe controller device through DTS/ACPI,
> that's doesn't matter.

The Linux Image for arm64 systems built using:
arch/arm64/configs/defconfig
will not have support for the Cadence PCIe Controller and the PCIe J721e
driver, because these configs aren't enabled.

> 
> > @@ -209,6 +209,12 @@ CONFIG_NFC=m
> >  CONFIG_NFC_NCI=m
> >  CONFIG_NFC_S3FWRN5_I2C=m
> >  CONFIG_PCI=y
> > +CONFIG_PCI_J721E=m
> > +CONFIG_PCI_J721E_HOST=m
> > +CONFIG_PCI_J721E_EP=m
> > +CONFIG_PCIE_CADENCE=m
> > +CONFIG_PCIE_CADENCE_HOST=m
> > +CONFIG_PCIE_CADENCE_EP=m
> 
> The common Cadence configuration will be select if the glue layer's
> configuration is select according to Kconfig.
> 
> Please do not set common configuration as module, some user may need
> it as build-in like dw's. Considering the situation, the rootfs is at
> NVMe.

The common configuration at the moment is "DISABLED" i.e. no support for
the Cadence Controller at all. Which "user" are you referring to? This
series was introduced since having the drivers built-in was pushed back at:
https://lore.kernel.org/linux-arm-kernel/20250122145822.4ewsmkk6ztbeejzf@slashing/

Regards,
Siddharth.

