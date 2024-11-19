Return-Path: <linux-pci+bounces-17080-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E22C39D2D61
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 19:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D266AB3109C
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 17:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11F01D0E20;
	Tue, 19 Nov 2024 17:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l9MVG8Tn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068531D1309
	for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2024 17:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036458; cv=none; b=B25b7kf6ywfrfXo/mW0xmlgQ9jNOeybq+oSJFpsl7AF2jy9Q1E1/OWfq1suceaB7svSFhJRy6urVwSYSLTIurWnHgvGBKc++xB5U7oqQzHy2IZludcLCUxSjBZABiVZWFo2Dq2P6wSb3EUluWddxditXqy2Tyzh2JRfrgYe/EQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036458; c=relaxed/simple;
	bh=SX+ujNoDRD3mvlaICyLqqJRRt/GLi42jp2Aj0M3gNrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFYe4GmmBAg+RnXCmblpLgaZdoJG/vgqk9Te6oWj5ekw/KwhAWJUx285x9abXeQzgaYG8UIsgwXhINd8K/nI8OTk+yGPDVzvgn2bsEItU4NEVxdQXMwaV77zJu3kC8CY8ob2QdNrrKLkDmO1vkMPEcOqTCiM20dq1dmHYMHld84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l9MVG8Tn; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-72487ebd2f5so2744128b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2024 09:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732036456; x=1732641256; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JOPaWaZUHYjXPotZyfSD4LXFtM0q+jqcbxN+bmnPOLY=;
        b=l9MVG8TnjrXQ1gGymCtNRsYSJXBGFv46mgwgufueXuJC0wMiPynPVHUosdjyQJ/EMd
         oQNORPPHy71Sqbtmp7URxu2qFYOy4CS1mdLCBMHwkpGLyq4Z6DSdZVGWumXkEXlL9NPY
         dn1eEv1y9x6SaC/TrxP+PybGs8kweoepGHsG5aAUNI/zgijNrMId/f7zDTJ2urTwAwu1
         258MBzx7F77Byz/U7C7PB526zMV7qZrcknuj2WN2mgQECSxz69h2ecPqoFoZQZb1JW9o
         qVHT/5H84A8TQcKQvokSUTaHhLThuSgBuLuZHvyq2wM6FiPBqtzzqVo5zsAzOvhAzyxi
         8QaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732036456; x=1732641256;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JOPaWaZUHYjXPotZyfSD4LXFtM0q+jqcbxN+bmnPOLY=;
        b=Wu7Q03j2NuwJxU1dTI6RcttsI73t6dtMx/qWZ66+Ximvt1effppKH0H4UsqCV9GtpK
         3pCqseNt0U1EXbY6oS+fpf7mNM7+EGLzuVvIOfnI3bunky2rzaDEM4wNmAWWeYmYnNk1
         MSm9k9ofQfDS5ZGSdsLkIpyIZTzHuQQXznCoLa8OfgCAjQ3d+plffdQ9yW5x1S7OBD/K
         wZPtBSar3gYrEk2y49idxGzrHuADuqiTIqJOAVEg8AWH6JsS0e0cDaMRpNso6P5PXgQ6
         GTS88suZsyPGPciTEEjOyh6pFDEuGUSsW2kliXp+c08qCDEq+fsLvLw/ly/o39geac+F
         mE3A==
X-Forwarded-Encrypted: i=1; AJvYcCWLHJUjR6BR7/mi88Eg5tFciodWi0oiQT60yAs+GtIBZFU+Ghab3UiVw+mJl8ixIenjmyxI29WE6V4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJDlFfBM9LO3dxeXiRvvqg/35tdz250HMVRYBVJBWz7+V5WJwN
	TeUTkKro+Q3vZKurtyqIYgHFU20HgP0IWTWsG9MZx0/HTmPBeK5S+oXBTvCV7A==
X-Google-Smtp-Source: AGHT+IGeT3nxBKPZxsFv2Ced8vI6Xd2I6Y/xx+FKsDpYt9zHSCohV576pySs3XbRWfyd0k0/wHLdeQ==
X-Received: by 2002:a05:6a00:991:b0:71e:14c:8d31 with SMTP id d2e1a72fcca58-72476d4317cmr20377160b3a.16.1732036455951;
        Tue, 19 Nov 2024 09:14:15 -0800 (PST)
Received: from thinkpad ([36.255.17.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771229d2sm8316878b3a.80.2024.11.19.09.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 09:14:15 -0800 (PST)
Date: Tue, 19 Nov 2024 22:44:10 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Mayank Rana <quic_mrana@quicinc.com>
Cc: jingoohan1@gmail.com, will@kernel.org, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com, krzk@kernel.org,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_krichai@quicinc.com
Subject: Re: [PATCH v3 4/4] PCI: qcom: Add Qualcomm SA8255p based PCIe root
 complex functionality
Message-ID: <20241119171410.fdbjseaplah35n62@thinkpad>
References: <20241106221341.2218416-1-quic_mrana@quicinc.com>
 <20241106221341.2218416-5-quic_mrana@quicinc.com>
 <20241115112504.anaatuqitdvjubyx@thinkpad>
 <f039e0ca-7c80-4495-bc67-ddca62774447@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f039e0ca-7c80-4495-bc67-ddca62774447@quicinc.com>

On Fri, Nov 15, 2024 at 10:28:23AM -0800, Mayank Rana wrote:
> 
> 
> On 11/15/2024 3:25 AM, Manivannan Sadhasivam wrote:
> > On Wed, Nov 06, 2024 at 02:13:41PM -0800, Mayank Rana wrote:
> > > On SA8255p ride platform, PCIe root complex is firmware managed as well
> > > configured into ECAM compliant mode. This change adds functionality to
> > > enable resource management (system resource as well PCIe controller and
> > > PHY configuration) through firmware, and enumerating ECAM compliant root
> > > complex.
> > > 
> > > Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
> > > ---
> > >   drivers/pci/controller/dwc/Kconfig     |   1 +
> > >   drivers/pci/controller/dwc/pcie-qcom.c | 116 +++++++++++++++++++++++--
> > >   2 files changed, 108 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > > index b6d6778b0698..0fe76bd39d69 100644
> > > --- a/drivers/pci/controller/dwc/Kconfig
> > > +++ b/drivers/pci/controller/dwc/Kconfig
> > > @@ -275,6 +275,7 @@ config PCIE_QCOM
> > >   	select PCIE_DW_HOST
> > >   	select CRC8
> > >   	select PCIE_QCOM_COMMON
> > > +	select PCI_HOST_COMMON
> > >   	help
> > >   	  Say Y here to enable PCIe controller support on Qualcomm SoCs. The
> > >   	  PCIe controller uses the DesignWare core plus Qualcomm-specific
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index ef44a82be058..2cb74f902baf 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > @@ -21,7 +21,9 @@
> > >   #include <linux/limits.h>
> > >   #include <linux/init.h>
> > >   #include <linux/of.h>
> > > +#include <linux/of_pci.h>
> > >   #include <linux/pci.h>
> > > +#include <linux/pci-ecam.h>
> > >   #include <linux/pm_opp.h>
> > >   #include <linux/pm_runtime.h>
> > >   #include <linux/platform_device.h>
> > > @@ -254,10 +256,12 @@ struct qcom_pcie_ops {
> > >     * @ops: qcom PCIe ops structure
> > >     * @override_no_snoop: Override NO_SNOOP attribute in TLP to enable cache
> > >     * snooping
> > > +  * @firmware_managed: Set if PCIe root complex is firmware managed
> > 
> > ecam_compliant?
> I assume you mean to update as Set if ECAM compliant PCIe root complex is
> firmware manage
> > >     */
> > >   struct qcom_pcie_cfg {
> > >   	const struct qcom_pcie_ops *ops;
> > >   	bool override_no_snoop;
> > > +	bool firmware_managed;
> > >   	bool no_l0s;
> > >   };
> > > @@ -1415,6 +1419,10 @@ static const struct qcom_pcie_cfg cfg_sc8280xp = {
> > >   	.no_l0s = true,
> > >   };
> > > +static const struct qcom_pcie_cfg cfg_fw_managed = {
> > 
> > cfg_ecam?
> Putting more emphasize on fw_managed as don't want to conflict with new work
> in progress (krishna is working on it)
> to make Qualcomm PCIe root complex as ECAM compliant (non firmware managed
> one). are you OK with using cfg_ecam_fw_managed ?
> 

Ah, I completely missed that. Ignore my comments about renaming to ecam.

> > > +	.firmware_managed = true,
> > > +};
> > > +

[...]

> > > +		/* Parse and map our Configuration Space windows */
> > > +		cfg = gen_pci_init(dev, bridge, &pci_qcom_ecam_ops);
> > > +		if (IS_ERR(cfg)) {
> > > +			ret = PTR_ERR(cfg);
> > > +			goto err_pm_runtime_put;
> > > +		}
> > > +
> > > +		bridge->sysdata = cfg;
> > > +		bridge->ops = (struct pci_ops *)&pci_qcom_ecam_ops.pci_ops;
> > > +		bridge->msi_domain = true;
> > > +
> > > +		ret = pci_host_probe(bridge);
> > 
> > return pci_host_probe()...
> need to perform pm_runtime_put_sync() and pm_runtime_disable() in failure
> case.
> Hence checking error here and doing goto err_pm_runtime_put

Right. This one I overlooked.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

