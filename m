Return-Path: <linux-pci+bounces-44324-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A75F0D074CA
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 07:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B23133017124
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 06:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980FA27281D;
	Fri,  9 Jan 2026 06:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHHBBaP0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F19519309C;
	Fri,  9 Jan 2026 06:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767938542; cv=none; b=AC2lQPzKIWPRxvEQtY35drc9I+UhCHQTkhJpItUOu5H5znF6sB97f8orH2DghLqyXckNw+JPBD66ysLabdECsSm01wdDjEH+Ut3yxQOn45kL9g8Dv6L8CQ31Bo6G14aDfqza4AMxWL6D/Ul/mUtYWLbjRn49qmPKZxJ+Fsn1+7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767938542; c=relaxed/simple;
	bh=2ZwanXb3K+wdRbDyhjpQDRTpzVByn8xFIpP+xmyQH/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2jJpBjIuQJ88YS5LZzrjuTaRG0u0AYKYC2CcFdo37TCld/dqDEfYlTmxFQlHTL37YgO+yL3/dya3lPqHn4egcDMIYH7CM2l0HVkWZf5MGapoVQKy1733QR1GgSE5ikclvIx1xEvXxMlzsvjerwfPORVj4huoXPYv5udt6iitUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHHBBaP0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308DFC4CEF1;
	Fri,  9 Jan 2026 06:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767938542;
	bh=2ZwanXb3K+wdRbDyhjpQDRTpzVByn8xFIpP+xmyQH/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BHHBBaP0kYweSLXa2JXymudu2N5nQC3K5M6mXHNXKBn9jwMvH/rEQZpI23pKI7TqZ
	 F6nfATSP3l9vB5yYH3FarXk/C/s15MeuSoBxA+bFq06c29BcHIUHxUcJQjSjaVP+hl
	 YD5UJVmkmV/k4V6OUsqtKv9DXIRpWhAQ2VV2q7iz1nM7MDvqFZnEqAMRuKYKhTiyug
	 yc1xhsKG12JC0W2nInZHMd+FgcxTxbKQWT7IXI15AtNcysla4hcJ1QV59JYaHGJZeZ
	 u2x0HVwb2vBWcH1o8PnsiXcP8GvZVdvEWCxTw7Jntu2upnUNFqGGO6pnolwIu4UAjf
	 MjosRLVcWhtvg==
Date: Fri, 9 Jan 2026 11:32:12 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	linux-pm@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH v5 5/5] power: sequencing: Add the Power Sequencing
 driver for the PCIe M.2 connectors
Message-ID: <xd5uvfqcx3vcbcqerji556ejstmgvtci4chfzxclkzhizqmqxa@xusf2skt6xhh>
References: <20260107-pci-m2-v5-0-8173d8a72641@oss.qualcomm.com>
 <20260107-pci-m2-v5-5-8173d8a72641@oss.qualcomm.com>
 <CAMRc=Md9TQiSX-gFa5q--JgaGyQ2ky4mOwjSpdxHhvHAj-X5Qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Md9TQiSX-gFa5q--JgaGyQ2ky4mOwjSpdxHhvHAj-X5Qw@mail.gmail.com>

On Thu, Jan 08, 2026 at 01:15:12PM +0100, Bartosz Golaszewski wrote:
> On Wed, Jan 7, 2026 at 3:11 PM Manivannan Sadhasivam via B4 Relay
> <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
> >
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> >
> > This driver is used to control the PCIe M.2 connectors of different
> > Mechanical Keys attached to the host machines and supporting different
> > interfaces like PCIe/SATA, USB/UART etc...
> >
> > Currently, this driver supports only the Mechanical Key M connectors with
> > PCIe interface. The driver also only supports driving the mandatory 3.3v
> > and optional 1.8v power supplies. The optional signals of the Key M
> > connectors are not currently supported.
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> This looks good to me, though there are some nits I may fix when applying.
> 
> I'll pick it up for v7.0 once the bindings are reviewed.
> 

Ok. I'm expecting patch 1 to go through ATA tree, patch 2 through DT, and
patches 3,4 through PCI tree.

> > +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
> > @@ -0,0 +1,169 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > + * Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_graph.h>
> > +#include <linux/of_platform.h>
> 
> It looks like this is a leftover from previous versions and you no
> longer need it?
> 

Yeah.

> > +
> > +static void pwrseq_pcie_free_resources(void *data)
> > +{
> > +       struct pwrseq_pcie_m2_ctx *ctx = data;
> > +
> > +       regulator_bulk_free(ctx->num_vregs, ctx->regs);
> > +}
> 
> I would call it pwrseq_pcie_m2_free_regulators() if you don't mind.
> 

Sure. I indeed missed '_m2'.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

