Return-Path: <linux-pci+bounces-12845-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 670BE96DF93
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 18:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C4B284BFA
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 16:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EF71A00EC;
	Thu,  5 Sep 2024 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1QvJ8nx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFD73C099;
	Thu,  5 Sep 2024 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725553639; cv=none; b=tfV1WGLgGkw2w+IavdQ7r/A9x43ZaBFwX/HDyMlens1e2uesvIk7LcxYFpzN81AfGUmk4scTNW+pOOOOmgGhJ8v9EcB4YwzpbDjiyv1ESt0qTB7nu+6RfqlMnt814iLcjH7xCQSRvQyeNad0+0hQRrtcbzVccL/ziJnlUXp+HEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725553639; c=relaxed/simple;
	bh=deLukwfDk5TXdfNYzDpqI2Ea9Akv/6QBWcJKsEUcqbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYMfaUNAIoTPuPmNy1jJStAv3JrXa7CkzeDM1pOI7A42R4uZaFLo2qZ5HCJyT7x0GyFwHlKcD1tSelGmocuTr8FnF5/WQQ8z4YQZIi4W/GETGn9Hjqhqy+hWYDGsy22jrRC/ewr8mAkZYwMNOZCJlmg5gmF+sOBCjCW0KRcgAYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1QvJ8nx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A050C4CEC3;
	Thu,  5 Sep 2024 16:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725553639;
	bh=deLukwfDk5TXdfNYzDpqI2Ea9Akv/6QBWcJKsEUcqbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L1QvJ8nx/Tf5NJHNuRa9X6OyfxMtpvc0DCoebrrYQWZRIrk+ACkBOzB0BmCE9weAo
	 sp1HXD+v4yHNM5hPTjx8LnlbseC8LaCAmRQ8860tF6jtKVd5AZEWcSOGYfW4l8MVEP
	 TR07dTnlEBmoUvQF56aEEgI9HFLfAKpvxSs0EdjlJtZCOPAEM371s1LqbZosLM0Yue
	 gzbEdr6ELyKLr11VyBNHbHvd9H4xiWCSpry1jZORRkv+LH0X0CZBAVLRusGmr3XNGt
	 NiEkqVBDLPvxlp2fVufUqBj3bA7GU9vCcahXG22ij7+4huYwAXXc/J7AurdMZnzTKc
	 cdo1IocbMiXEQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1smFKa-000000005KC-44Ar;
	Thu, 05 Sep 2024 18:27:37 +0200
Date: Thu, 5 Sep 2024 18:27:36 +0200
From: Johan Hovold <johan@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
Message-ID: <Ztnb-GauC_8D8N-i@hovoldconsulting.com>
References: <20240904-pci-qcom-gen4-stability-v6-0-ec39f7ae3f62@linaro.org>
 <20240904-pci-qcom-gen4-stability-v6-3-ec39f7ae3f62@linaro.org>
 <ZtgqvXGgp2sWNg5O@hovoldconsulting.com>
 <20240905152742.4llkcjvvu3klmo6j@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905152742.4llkcjvvu3klmo6j@thinkpad>

On Thu, Sep 05, 2024 at 08:57:42PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Sep 04, 2024 at 11:39:09AM +0200, Johan Hovold wrote:

> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.h b/drivers/pci/controller/dwc/pcie-qcom-common.h
> > > new file mode 100644
> > > index 000000000000..259e04b7bdf9
> > > --- /dev/null
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom-common.h
> > > @@ -0,0 +1,8 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> > > + */
> > > +
> > > +#include "pcie-designware.h"
> > 
> > You only need a forward declaration:
> > 
> > 	struct dw_pcie;
> > 
> > > +
> > > +void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci);
> > 
> > Compile guard still missing.

Sorry, I meant to say *include* guard here.
 
> Perhaps we can just get rid of the Kconfig entry and build it by default for
> both RC and EP drivers? I don't see a value in building it as a separate module.
> And we may also move more common code in the future.

It is already built by default for both drivers. I'm not sure what
you're suggesting here.

Johan

