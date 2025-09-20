Return-Path: <linux-pci+bounces-36578-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C99F5B8C3DF
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 10:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CE601C01BDB
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 08:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D394A277CBC;
	Sat, 20 Sep 2025 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIkeUZwy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF0134BA47;
	Sat, 20 Sep 2025 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758356865; cv=none; b=Qs0AJhYq9QhPKEnK1GhbUNp0cHEUF5NeoHD52lBDWTOSIpmqQ2DuzCeKhCneshF1yxTj1zer/fsYDHuXBRtDnGaHiLADZJ+Nxm5+kddgkTh2ZaYxlYbpY0HH/sD0kK85N+4k6KoY7e6N0Y/qrVtSCs2/7mItWhQTC7bQzvPaGww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758356865; c=relaxed/simple;
	bh=xjORWEb9AB9K4GuQONrEhOQ9HcO3RWCcAWlzmCE1C4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upwZIFjK69SuOpxiEZ0cd9deuWH/tHphgPA7ytmXNk2kXhJFeXAM/wIQRlr5aAbpLcoRkMSz4IFOf3qExOOWPn52Y+i9YdYdN9MN/3eTmD7g/XRhdlLwNxdUHw4G2ogzucPD77qdDSOfrYcksnetxPeo8re3+5cv4YM41GrCp8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIkeUZwy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C218C4CEF9;
	Sat, 20 Sep 2025 08:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758356865;
	bh=xjORWEb9AB9K4GuQONrEhOQ9HcO3RWCcAWlzmCE1C4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eIkeUZwyORBFSxxN8Pc4oIVfJ8oaglOfKFEVHkSUgIk2mE9cW6ISS1nMYB7l/mTzx
	 NsE1jNdLrdFXId15b7wHf0WS6LJPTouXO/Ymr6zWcUUPcjUsCkZ9DIfRv1vzEZ+6Js
	 rh2Me3hOQAbwlh65urfgT/sHEGeCgyaGprQw+PffJzoD3QaHpCyGBFZ0N7/Bse1hbj
	 klqnPSRNhw6lwvlK06+WmDWwCf5OQnKTOGcSL7j3fZ5NHTd9LBdBCGu/xlvjFGPPns
	 oouiGgye8+Zyz9jM+b43AVsVXIID/XvVLwq9yZRH76rTRCvcaug3JrPZHJ7zUYw9bC
	 aeJcv9AXR2xuQ==
Date: Sat, 20 Sep 2025 13:57:34 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, jingoohan1@gmail.com, christian.bruel@foss.st.com, 
	qiang.yu@oss.qualcomm.com, mayank.rana@oss.qualcomm.com, thippeswamy.havalige@amd.com, 
	shradha.t@samsung.com, quic_schintav@quicinc.com, inochiama@gmail.com, 
	cassel@kernel.org, kishon@kernel.org, sergio.paracuellos@gmail.com, 
	18255117159@163.com, rongqianfeng@vivo.com, jirislaby@kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH v2 09/10] PCI: keystone: Exit ks_pcie_probe() for the
 default switch-case of "mode"
Message-ID: <jgw5f33ptz6dutffxaid4kxnllsdyanqy5obsotn3bmhxibxdt@2zzlh7mbfoi2>
References: <20250912122356.3326888-1-s-vadapalli@ti.com>
 <20250912122356.3326888-10-s-vadapalli@ti.com>
 <lo2zv3nxek57s3h4hwv2ujzophdx2ubfuam4gqmo5h77t2g4jo@447qpc7a4ub3>
 <3f3b2f06-64a3-4e6d-9fa9-c3412b1ca710@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f3b2f06-64a3-4e6d-9fa9-c3412b1ca710@ti.com>

On Sat, Sep 20, 2025 at 01:39:22PM +0530, Siddharth Vadapalli wrote:
> On Sat, Sep 20, 2025 at 12:06:46AM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Sep 12, 2025 at 05:46:20PM +0530, Siddharth Vadapalli wrote:
> > > In ks_pcie_probe(), the switch-case for the "mode" is used to configure
> > > the PCIe Controller for either Root-Complex or Endpoint mode of operation.
> > > Prior to the switch-case statement for "mode" an invalid mode will result
> > > in probe failure only if "dw_pcie_ver_is_ge(pci, 480A)" is true, which
> > > is the case for the AM654 platform. On the other hand, when that is not
> > > the case, "ks_pcie_set_mode()" will be invoked, which does not validate
> > > the mode. As a result, it is possible for the switch-case statement for
> > > "mode" to receive an invalid mode. Currently, an error message is displayed
> > > in the "default" case where "mode" is neither "DW_PCIE_RC_TYPE" nor
> > > "DW_PCIE_EP_TYPE", but the probe succeeds. However, since the configuration
> > > required for Root-Complex and Endpoint mode have not been performed, the
> > > Controller is not operational.
> > > 
> > > Fix this by exiting "ks_pcie_probe()" with the return value of "-EINVAL"
> > > in addition to displaying the existing error message.
> > > 
> > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > 
> > Fixes tag? And probably CC stable since the controller seems to be not
> > operations without this fix.
> 
> While I had mentioned the rationale for not including the 'Fixes tag' in
> the v1 patch below the tearline, I forgot to add it in this patch. I will
> quote the same below:
> 
>     NOTE: A "Fixes" tag is ommitted on purpose since the fix is not crucial:
>     1. It doesn't fix a crash or any fatal error
>     2. It doesn't enable controller functionality by fixing the issue
> 

Fixes tag should be added irrespective of the cruciality of the bug.

>     Therefore, the patch may not be worth backporting.
> 

Agree with this though.

> Prior to this patch, the probe succeeded and the controller was
> unusable. Post this patch, the probe will fail and the controller is
> still unusable. Behavior is identical from a usability perspective but
> the user is aware of the issue since the probe fails.
> 

Ok. I think the description could reworded to make it more clear. The actual
issue is that the default case lacks setting the errno, leading to probe
success. But the addition of ks_pcie_set_mode() and others seem to cause little
bit confusion.

- Mani

> > 
> > - Mani
> > 
> > > ---
> > > 
> > > v1: https://lore.kernel.org/r/20250903124505.365913-11-s-vadapalli@ti.com/
> > > No changes since v1.
> > > 
> > >  drivers/pci/controller/dwc/pci-keystone.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> > > index 2da9feaaf9ee..e85942b4f6be 100644
> > > --- a/drivers/pci/controller/dwc/pci-keystone.c
> > > +++ b/drivers/pci/controller/dwc/pci-keystone.c
> > > @@ -1414,6 +1414,8 @@ static int ks_pcie_probe(struct platform_device *pdev)
> > >  		break;
> > >  	default:
> > >  		dev_err(dev, "INVALID device type %d\n", mode);
> > > +		ret = -EINVAL;
> > > +		goto err_get_sync;
> > >  	}
> > >  
> > >  	ks_pcie_enable_error_irq(ks_pcie);
> 
> Regards,
> Siddharth.

-- 
மணிவண்ணன் சதாசிவம்

