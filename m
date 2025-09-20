Return-Path: <linux-pci+bounces-36575-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB0DB8C3B4
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 10:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3C011BC240D
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 08:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DCD27603C;
	Sat, 20 Sep 2025 08:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Oq/cyC6x"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537A61E9B1C;
	Sat, 20 Sep 2025 08:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758355786; cv=none; b=QM2OW1KOqdU19b+6I6IsFJ+HvbDZTFzA0RJPnLF+4AcRGIbGMNprRFyZK/mprLUvxT817konCyOmnmQvV6hlDIWadPeg3i7RakEMHHO4/XK6yCP8Vvlal7gAcWs0qVvqwStgcPMfNS5u9AC0LwKWapHLeovyqvs9Fc1g4Xnuw3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758355786; c=relaxed/simple;
	bh=6YIlnQGfJtK4b/34oDcJxMdzbkn4VAuRMiy6KSr0M8I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBQsgtxEcehHcGS3isNGT8+kOorEcLDUlkfyfAKfafnAWLn4LHHmAdVrUqcU7k4Iq9RU2vp2xeWy5Ze80nNgmCrq2FmfuMaufdCzLISYl1i6GZi6c/XwE3HGbNSLmp2+kEF3uX3QHYSmh1HAsS8VBlKK7dgKjj/Fi29dDv65raE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Oq/cyC6x; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58K89O51389660;
	Sat, 20 Sep 2025 03:09:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758355764;
	bh=tK7KqxjdZLBASzeM34EVBqx8HWtcYbb8JxjopxX43w0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Oq/cyC6x3/uAqlrNORZUalQdytMXrSoiZ+MJZeKSuwy+EFCoNxiu+1WR8bPvmjVLd
	 5Il7K5dPlB0p8okENOu+NzN5FRO5M4wqK69k+cxGzu422Hxgf6hTU1LlEZAYGrvHp+
	 U9vNUKZIF0Je4nUKTm4VOflejILv6fVy/5rmr9no=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58K89O0N3499538
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Sat, 20 Sep 2025 03:09:24 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sat, 20
 Sep 2025 03:09:24 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 20 Sep 2025 03:09:23 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58K89MDc3568350;
	Sat, 20 Sep 2025 03:09:23 -0500
Date: Sat, 20 Sep 2025 13:39:22 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lpieralisi@kernel.org>,
        <kwilczynski@kernel.org>, <robh@kernel.org>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <christian.bruel@foss.st.com>,
        <qiang.yu@oss.qualcomm.com>, <mayank.rana@oss.qualcomm.com>,
        <thippeswamy.havalige@amd.com>, <shradha.t@samsung.com>,
        <quic_schintav@quicinc.com>, <inochiama@gmail.com>,
        <cassel@kernel.org>, <kishon@kernel.org>,
        <sergio.paracuellos@gmail.com>, <18255117159@163.com>,
        <rongqianfeng@vivo.com>, <jirislaby@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH v2 09/10] PCI: keystone: Exit ks_pcie_probe() for the
 default switch-case of "mode"
Message-ID: <3f3b2f06-64a3-4e6d-9fa9-c3412b1ca710@ti.com>
References: <20250912122356.3326888-1-s-vadapalli@ti.com>
 <20250912122356.3326888-10-s-vadapalli@ti.com>
 <lo2zv3nxek57s3h4hwv2ujzophdx2ubfuam4gqmo5h77t2g4jo@447qpc7a4ub3>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <lo2zv3nxek57s3h4hwv2ujzophdx2ubfuam4gqmo5h77t2g4jo@447qpc7a4ub3>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sat, Sep 20, 2025 at 12:06:46AM +0530, Manivannan Sadhasivam wrote:
> On Fri, Sep 12, 2025 at 05:46:20PM +0530, Siddharth Vadapalli wrote:
> > In ks_pcie_probe(), the switch-case for the "mode" is used to configure
> > the PCIe Controller for either Root-Complex or Endpoint mode of operation.
> > Prior to the switch-case statement for "mode" an invalid mode will result
> > in probe failure only if "dw_pcie_ver_is_ge(pci, 480A)" is true, which
> > is the case for the AM654 platform. On the other hand, when that is not
> > the case, "ks_pcie_set_mode()" will be invoked, which does not validate
> > the mode. As a result, it is possible for the switch-case statement for
> > "mode" to receive an invalid mode. Currently, an error message is displayed
> > in the "default" case where "mode" is neither "DW_PCIE_RC_TYPE" nor
> > "DW_PCIE_EP_TYPE", but the probe succeeds. However, since the configuration
> > required for Root-Complex and Endpoint mode have not been performed, the
> > Controller is not operational.
> > 
> > Fix this by exiting "ks_pcie_probe()" with the return value of "-EINVAL"
> > in addition to displaying the existing error message.
> > 
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> 
> Fixes tag? And probably CC stable since the controller seems to be not
> operations without this fix.

While I had mentioned the rationale for not including the 'Fixes tag' in
the v1 patch below the tearline, I forgot to add it in this patch. I will
quote the same below:

    NOTE: A "Fixes" tag is ommitted on purpose since the fix is not crucial:
    1. It doesn't fix a crash or any fatal error
    2. It doesn't enable controller functionality by fixing the issue

    Therefore, the patch may not be worth backporting.

Prior to this patch, the probe succeeded and the controller was
unusable. Post this patch, the probe will fail and the controller is
still unusable. Behavior is identical from a usability perspective but
the user is aware of the issue since the probe fails.

> 
> - Mani
> 
> > ---
> > 
> > v1: https://lore.kernel.org/r/20250903124505.365913-11-s-vadapalli@ti.com/
> > No changes since v1.
> > 
> >  drivers/pci/controller/dwc/pci-keystone.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> > index 2da9feaaf9ee..e85942b4f6be 100644
> > --- a/drivers/pci/controller/dwc/pci-keystone.c
> > +++ b/drivers/pci/controller/dwc/pci-keystone.c
> > @@ -1414,6 +1414,8 @@ static int ks_pcie_probe(struct platform_device *pdev)
> >  		break;
> >  	default:
> >  		dev_err(dev, "INVALID device type %d\n", mode);
> > +		ret = -EINVAL;
> > +		goto err_get_sync;
> >  	}
> >  
> >  	ks_pcie_enable_error_irq(ks_pcie);

Regards,
Siddharth.

