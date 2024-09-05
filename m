Return-Path: <linux-pci+bounces-12853-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 136BC96E128
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 19:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A09441F25010
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 17:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113F21A3A9B;
	Thu,  5 Sep 2024 17:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hulCOhoy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3B41A0717
	for <linux-pci@vger.kernel.org>; Thu,  5 Sep 2024 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725557699; cv=none; b=NGI/wPXBqEcBtolZlRdJgdKp65BGgkpl+J2jZgi+E+JkAZPXlQX2saOn1PybaM+7TR0hd2yGD2CqAHp9GPvt8I0dSTdC4zAaJ16heXYCzx3nMozEOpAhm9ZvZihtynh8cvsfedemDT5gjkCg69+RSpAvIm4FrvxznuN84UCaSfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725557699; c=relaxed/simple;
	bh=MI2LRc6AktxdTOVKQGnfpzkt/G3bqZJj+90kchL1ybM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zqm+z4MiTlM+ZA4BExb20RdgIacuryofQ7VYG4fxCx/INkNk1heoY7a6aAREYHCrYhGnnyf7/O1Deglq5Ys2lySIqlmBIJU8ckmRZ9/U0zRgUKI6kImE3r/PtsXZdPrhGmK1h00nr4+rvGDc1Q7pzZcSfE6YweojzJtjX3H4MjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hulCOhoy; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20573eb852aso14943775ad.1
        for <linux-pci@vger.kernel.org>; Thu, 05 Sep 2024 10:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725557697; x=1726162497; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eIgzal7ITyKn4Uu6UhwVaplHaAv3wUp9Qsoun/N+n+c=;
        b=hulCOhoyJCHBTWpZY3k0dfuTPeZGDEkSROIH4NWLDKyXdLv/1pK8Ku/SWLaIR6QLgp
         CcJzqECDc9oDWK9w95OmGKOKDDbPVue+SzU4QLtXHCzMr6/UiYM8dj+34YttIb75k8jj
         1AICwt+dhQPVN0vEY4EBN982S/jgVjMCErT+nyH9nvUo/atk8ZEkOws2qkdYaBXKbGjx
         J+sGiH924F+hVcjZ7Nzu7ldSVSKSHUhycocG2D8/I93BjABk67sGhTTCrevoF6IoqJQ6
         jRkXCuY7WKRbhn2ZJhPY36JTWoAHHS1wlnJC4lFy2D5CPUxiPU4dNwz3wkB2NfIsDu6I
         TyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725557697; x=1726162497;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eIgzal7ITyKn4Uu6UhwVaplHaAv3wUp9Qsoun/N+n+c=;
        b=fnfX68bgnlgoDccY2OzezcJygmAZykj4/b1Yawf5A/c3RH2cZFrJhUzu+aRWPlpvR6
         At7ebt4lRlb/0mhbjOMAO6INulNOoZVA9Sw7+hTiWwXS8hvsipLvQScBW2pnAePyvHSe
         W+8c/BzA4Ekp0aVwo3fPPGLs3bN1VgAgfWy+QTWPz+3Io9oxR+q2Yn9KkGehd6jiZGLB
         n3Wf3rAATrZEIVk+rqbFdU9FWZC3pUj2mI0yLxnAR0IXbmt6OChGxDx0Uj88/NNK7isP
         JuFUMtOzC8Qg8CDH8umAAv3epc7UupjSBBCnIwzQ47le8R2BZ4N1cklKJZfhtxmBqt24
         CEZg==
X-Forwarded-Encrypted: i=1; AJvYcCXezxPM6588Bdz0IIdA4oynchq5YBSGewKjWNSYUrkkCFoWMlqYJMkPE0gFkbJjnjVjPFQFhsLdYzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR3I+2Qq8O+jFJf+EronnkSc8+8ylUfBRauzI88wUjpcsDhO9+
	eZNr3HTenIthpkZBwsCb2tuabTT/t4c2n6jHHAXm4+ye5sM8ZuqBa4uRPSzJyQ==
X-Google-Smtp-Source: AGHT+IElFJh9mBN0d10CvX+yxAjA8cHTDsSZBmgENNb/EtffZEORF9F48GUK1FqLfVaqnR4xQfoX8Q==
X-Received: by 2002:a17:902:ea0a:b0:205:3475:63be with SMTP id d9443c01a7336-206eeb8c61amr497735ad.25.1725557696776;
        Thu, 05 Sep 2024 10:34:56 -0700 (PDT)
Received: from thinkpad ([120.60.52.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea69770sm30809955ad.277.2024.09.05.10.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 10:34:56 -0700 (PDT)
Date: Thu, 5 Sep 2024 23:04:37 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Chuanhua Lei <lchuanhua@maxlinear.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	abel.vesa@linaro.org, johan+linaro@kernel.org,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Subject: Re: [PATCH v6 3/4] PCI: qcom: Add equalization settings for 16.0 GT/s
Message-ID: <20240905173437.hm3hegv5zolaj7gj@thinkpad>
References: <20240904-pci-qcom-gen4-stability-v6-0-ec39f7ae3f62@linaro.org>
 <20240904-pci-qcom-gen4-stability-v6-3-ec39f7ae3f62@linaro.org>
 <ZtgqvXGgp2sWNg5O@hovoldconsulting.com>
 <20240905152742.4llkcjvvu3klmo6j@thinkpad>
 <Ztnb-GauC_8D8N-i@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ztnb-GauC_8D8N-i@hovoldconsulting.com>

On Thu, Sep 05, 2024 at 06:27:36PM +0200, Johan Hovold wrote:
> On Thu, Sep 05, 2024 at 08:57:42PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Sep 04, 2024 at 11:39:09AM +0200, Johan Hovold wrote:
> 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.h b/drivers/pci/controller/dwc/pcie-qcom-common.h
> > > > new file mode 100644
> > > > index 000000000000..259e04b7bdf9
> > > > --- /dev/null
> > > > +++ b/drivers/pci/controller/dwc/pcie-qcom-common.h
> > > > @@ -0,0 +1,8 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +/*
> > > > + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> > > > + */
> > > > +
> > > > +#include "pcie-designware.h"
> > > 
> > > You only need a forward declaration:
> > > 
> > > 	struct dw_pcie;
> > > 
> > > > +
> > > > +void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci);
> > > 
> > > Compile guard still missing.
> 
> Sorry, I meant to say *include* guard here.
>

Okay. I got confused initially.
  
> > Perhaps we can just get rid of the Kconfig entry and build it by default for
> > both RC and EP drivers? I don't see a value in building it as a separate module.
> > And we may also move more common code in the future.
> 
> It is already built by default for both drivers. I'm not sure what
> you're suggesting here.
> 

Right now it is selected by both drivers using a Kconfig symbol. But I'm
thinking of building it by default as below:

-obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
-obj-$(CONFIG_PCIE_QCOM_EP) += pcie-qcom-ep.o
+obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o pcie-qcom-common.o
+obj-$(CONFIG_PCIE_QCOM_EP) += pcie-qcom-ep.o pcie-qcom-common.o

A separate Kconfig symbol is not really needed here as this file contains common
code required by both the drivers.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

