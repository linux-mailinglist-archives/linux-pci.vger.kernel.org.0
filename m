Return-Path: <linux-pci+bounces-5617-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5571C89712B
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 15:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794181C2797A
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 13:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BE814882B;
	Wed,  3 Apr 2024 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gU/enAze"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113F81487DD
	for <linux-pci@vger.kernel.org>; Wed,  3 Apr 2024 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712151146; cv=none; b=Qh1ROAeMgvNNlGQ4hleaSySPehib7Oomewaxs3W7e3Py1bp3bElj/t5wmvOqLVPO+ytiUwh7MdikaRUCSB1RCstTYEWLAPHXfWh90eambuypTCecjvWd+wMqVf7aneN/45V5moMF/cJdIG8XJSxu5wlP81gZhrQ6tYEBVUWB3Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712151146; c=relaxed/simple;
	bh=cSygu0lTdsE1mYb8kt8PaIRN/34pMtkOoObkW9tu3zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCNC1CbIj1Gc6vB5c4a82DUAv8aUVvqSHDF5/F4TWcl1XnxCuBZdt/C58dlxBETVOEdT0YNNMMMv9ClH8a3d5V18WwtGbsZ2wrRhKZYp3drv3vvO3DYH0slLnwJ4NLxL1m1fp03mjV6f8A4XjqWpPOoaKth2fKv7JoUDFSULt/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gU/enAze; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e7425a6714so5236984b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 03 Apr 2024 06:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712151143; x=1712755943; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VgGe+WrjXHejFLqdWYYFDfvaGlNX9pe3wGgL1xVORjQ=;
        b=gU/enAzegUlw0ZbyaOL3nGUPyIx37Tyh5PD7JY191UEN/H+JYvhFkNN4fPQ1rBtsC7
         sX5rlTsAxwEzcRvAxkUSg6dEuwDgjLGUPwSfYm/Ig8D04zAlQ6pQPh/TmAIZF+LiN3r2
         F7spliMW1kHKgKVybhC20rnxosGoYmEhI8uhi3QUNqoV3lRf1Tj/2ReDoHwK3LbxcEtN
         jnwqKs3jXFcMst4k0MMFC47v9jFTwo3Fgx8Apu74FMLZqEuq0iKthSXoygF8XdSewz9+
         9KlE8Mc7zGCjtrB9YgvT2fGC38cFbVoF76BpRxx95ojWrGPVASSgV40jyFHVT7MxKL89
         LyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712151143; x=1712755943;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VgGe+WrjXHejFLqdWYYFDfvaGlNX9pe3wGgL1xVORjQ=;
        b=Far1BAfwiCwg+oxHjbdttbgi2/NQ5w2bg++wafpLIjYPfKPJNyQhi4D5kL7BvhT5x0
         otCD0YO2gfenQpr1GL2PGyGujdVHReEnx4/GRP366dwoX8N+EUBgV3B2nnsoqBjkyCo1
         nJep6cg1N6lWL1WIH44+Pi5g9VHbyQKE8rBzxsVDB3ScILs52PtS2SUE6y5YUK5jiSHQ
         pgPBVm4RTmeK95JoD2u9s7nOm/ND0cxKrCCJaIKK+FIQFAoWFqLop8MYrHv03y9iPEJZ
         6QnLtjVXoYHYeG5dSjUZR0ysX6a43sxDCIgvZE6grXAfZy6q2k4BmDapzPYy7/YELWem
         +w3w==
X-Forwarded-Encrypted: i=1; AJvYcCVixuqRad/D1+4VeTViq65hiweEHZfffVtGkdcR1eyghJ2cfAk1sg2wzecFr1hXbH4J8ylTrbYpd6tqXFBBPZ4j7JUonJ36XIHY
X-Gm-Message-State: AOJu0YyPeNtKqNN9HFxHwhguL55K+eOdV7BZ88IAYaENdpmFMYFKnT9T
	2Q8Hf0G5Gj0t1pC6x/hGibQzy3OvgdY8Q0/ZlyLfVgE9BVSGwM7vP7CYtXBePg==
X-Google-Smtp-Source: AGHT+IHd+nfXICNi5snDJqZSl05Xq7tsxxzc7MHxPup9L3i8nMVEIlDZk9E2mY6SCWVq0UJ0c/68VQ==
X-Received: by 2002:a05:6a21:2d8c:b0:1a7:2d39:51cf with SMTP id ty12-20020a056a212d8c00b001a72d3951cfmr1429986pzb.26.1712151143220;
        Wed, 03 Apr 2024 06:32:23 -0700 (PDT)
Received: from thinkpad ([103.28.246.48])
        by smtp.gmail.com with ESMTPSA id gs5-20020a056a004d8500b006eb3c2bde43sm6479798pfb.205.2024.04.03.06.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 06:32:22 -0700 (PDT)
Date: Wed, 3 Apr 2024 19:02:17 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 10/10] PCI: qcom: Implement shutdown() callback to
 properly reset the endpoint devices
Message-ID: <20240403133217.GK25309@thinkpad>
References: <20240401-pci-epf-rework-v2-0-970dbe90b99d@linaro.org>
 <20240401-pci-epf-rework-v2-10-970dbe90b99d@linaro.org>
 <ZgvpnqdjQ39JMRiV@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZgvpnqdjQ39JMRiV@ryzen>

On Tue, Apr 02, 2024 at 01:18:54PM +0200, Niklas Cassel wrote:
> On Mon, Apr 01, 2024 at 09:20:36PM +0530, Manivannan Sadhasivam wrote:
> > PCIe host controller drivers are supposed to properly reset the endpoint
> > devices during host shutdown/reboot. Currently, Qcom driver doesn't do
> > anything during host shutdown/reboot, resulting in both PERST# and refclk
> > getting disabled at the same time. This prevents the endpoint device
> > firmware to properly reset the state machine. Because, if the refclk is
> > cutoff immediately along with PERST#, access to device specific registers
> > within the endpoint will result in a firmware crash.
> > 
> > To address this issue, let's call qcom_pcie_host_deinit() inside the
> > shutdown callback, that asserts PERST# and then cuts off the refclk with a
> > delay of 1ms, thus allowing the endpoint device firmware to properly
> > cleanup the state machine.
> 
> Hm... a QCOM EP device could be attached to any of the PCIe RC drivers that
> we have in the kernel, so it seems a bit weird to fix this problem by
> patching the QCOM RC driver only.
> 
> Which DBI call is it that causes this problem during perst assert on EP side?
> 
> I assume that it is pci-epf-test:deinit() callback that calls
> pci_epc_clear_bar(), which calls dw_pcie_ep_clear_bar(), which will both:
> -clear local data structures, e.g.
> ep->epf_bar[bar] = NULL;
> ep->bar_to_atu[bar] = 0;
> 
> but also call:
> __dw_pcie_ep_reset_bar()
> dw_pcie_disable_atu()
> 
> 
> Do we perhaps need to redesign the .deinit EPF callback?
> 
> Considering that we know that .deinit() will only be called on platforms
> where there will be a fundamental core reset, I guess we could do something
> like introduce a __dw_pcie_ep_clear_bar() which will only clear the local
> data structures. (It might not need to do any DBI writes, since the
> fundamental core reset should have reset all values.)
> 
> Or perhaps instead of letting pci_epf_test_epc_deinit() call
> pci_epf_test_clear_bar()/__pci_epf_test_clear_bar() directly, perhaps let
> pci_epf_test_epc_deinit() call add a .deinit()/.cleanup() defined in the
> EPC driver.
> 
> This EPC .deinit()/.cleanup() callback would then only clear the
> local data structures (no DBI writes...).
> 
> Something like that?
> 

It is not just about the EPF test driver. A function driver may need to do many
things to properly reset the state machine. Like in the case of MHI driver, it
needs to reset channel state, mask interrupts etc... and all requires writing to
some registers. So certainly there should be some time before cutting off the
refclk.

On x86 host machines, I can see that there is enough time before the host cuts
off the refclk.

But it is unfortunate that the PCIe spec didn't define it though.

- Mani

> 
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 14772edcf0d3..b2803978c0ad 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -1655,6 +1655,13 @@ static int qcom_pcie_resume_noirq(struct device *dev)
> >  	return 0;
> >  }
> >  
> > +static void qcom_pcie_shutdown(struct platform_device *pdev)
> > +{
> > +	struct qcom_pcie *pcie = platform_get_drvdata(pdev);
> > +
> > +	qcom_pcie_host_deinit(&pcie->pci->pp);
> > +}
> > +
> >  static const struct of_device_id qcom_pcie_match[] = {
> >  	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
> >  	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
> > @@ -1708,5 +1715,6 @@ static struct platform_driver qcom_pcie_driver = {
> >  		.pm = &qcom_pcie_pm_ops,
> >  		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> >  	},
> > +	.shutdown = qcom_pcie_shutdown,
> >  };
> >  builtin_platform_driver(qcom_pcie_driver);
> > 
> > -- 
> > 2.25.1
> > 

-- 
மணிவண்ணன் சதாசிவம்

