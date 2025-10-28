Return-Path: <linux-pci+bounces-39496-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4221BC1301D
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 06:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5B1B4E0F11
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 05:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBD4245021;
	Tue, 28 Oct 2025 05:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKIkt7/t"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD6F2AD3D;
	Tue, 28 Oct 2025 05:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761630402; cv=none; b=NXe73usk56Y3JK9NQ1WytHfanw9jVCPoiOO/swCPUOVSd3dZ+CXEOYfPwP8QduYdanZgnk+YoQbmpdOhHiI0iTrU+yNeZw7akHlnxEcU+FWS8kJCDc0XTN+5Hgg4M/VUitKe0hbjmugzSNBl/1m5RRCGoGkO5RSowNRZUAQIS0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761630402; c=relaxed/simple;
	bh=GIhQbgstKqKNQsX/bs0Wtz1Bd+P3U6ihgvZLbC5Zffk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOGLSgb0RdKeleMAyHjNXDDdDaOmE+V8OMeSCdxE6bpjpMxRT+Eh2UAbyqA1cxiAneOnfstdK90MK6iGmEtdH3H04b9N09xQg9QIkl+gtyN2vtMh50/F/9vFpQdSo3eEtOSw5U3GCBXVN1eSju4rtjVGMTt5o3OnUKHuE+4xD3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKIkt7/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9E3C4CEE7;
	Tue, 28 Oct 2025 05:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761630402;
	bh=GIhQbgstKqKNQsX/bs0Wtz1Bd+P3U6ihgvZLbC5Zffk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SKIkt7/tnQBjx1ozQ6sp7zdz8KisgToH5jMgNOiVLFpVvd8vpHFRVxzjwDhOa2Jr7
	 6vrGO9AkZZdDTdEw8iunpiu6Xm/Itn/uSiHd6p86nTwsdHX78rlWIPGvXnO1XHteC9
	 Nb/lLYeM0G7korAuDwRe3PJ+XGDyoHO5VPp75QoUXYuT4YmF024DDE3JgG7BJuSoOp
	 6qvSuRYZWJOo4OlPhTDcfvLjTBGY4jIaxGq2vxrcINr4Mw+a8stNwG/svOE52cAcZa
	 Fb6aRzCajsje6BiH744MAOwebTEgTE5EWSwyzbOAjeuoMhyRDAvgD6fC+eoRfHU6yq
	 HSGnr5z4IOO7g==
Date: Tue, 28 Oct 2025 11:16:29 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Vitor Soares <ivitro@gmail.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Vitor Soares <vitor.soares@toradex.com>, 
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] PCI: j721e: Add support for optional regulator
 supplies
Message-ID: <5ogtnqbf32fy4rprcsthip5byl4dtgybsys2ur3ph6mc77q7po@apfcl7olp4zj>
References: <20251014112553.398845-1-ivitro@gmail.com>
 <20251014112553.398845-3-ivitro@gmail.com>
 <p3l2p2raecqqkpdjswiddkthpxzvhm3rl4cw56y2epgcxfiwbb@gsieef3yqvpk>
 <91e8f4346a677a2ea46a210d7422adb99e70b3be.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91e8f4346a677a2ea46a210d7422adb99e70b3be.camel@gmail.com>

On Mon, Oct 27, 2025 at 08:24:12PM +0000, Vitor Soares wrote:
> Hello Mani,
> 
> Thank you for the feedback.
> 
> On Tue, 2025-10-21 at 07:36 +0530, Manivannan Sadhasivam wrote:
> > On Tue, Oct 14, 2025 at 12:25:49PM +0100, Vitor Soares wrote:
> > > From: Vitor Soares <vitor.soares@toradex.com>
> > > 
> > > Some boards require external regulators to power PCIe endpoints.
> > > Add support for optional 1.5V, 3.3V, and 12V supplies, which may be
> > > defined in the device tree as vpcie1v5-supply, vpcie3v3-supply, and
> > > vpcie12v-supply.
> > > 
> > > Use devm_regulator_get_enable_optional() to obtain and enable each
> > > supply, so it will be automatically disabled when the driver is
> > > removed.
> > > 
> > > Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> > > ---
> > >  drivers/pci/controller/cadence/pci-j721e.c | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/cadence/pci-j721e.c
> > > b/drivers/pci/controller/cadence/pci-j721e.c
> > > index 5bc5ab20aa6d..f29ce2aef04e 100644
> > > --- a/drivers/pci/controller/cadence/pci-j721e.c
> > > +++ b/drivers/pci/controller/cadence/pci-j721e.c
> > > @@ -21,6 +21,7 @@
> > >  #include <linux/platform_device.h>
> > >  #include <linux/pm_runtime.h>
> > >  #include <linux/regmap.h>
> > > +#include <linux/regulator/consumer.h>
> > >  
> > >  #include "../../pci.h"
> > >  #include "pcie-cadence.h"
> > > @@ -467,6 +468,10 @@ static const struct of_device_id of_j721e_pcie_match[]
> > > = {
> > >  };
> > >  MODULE_DEVICE_TABLE(of, of_j721e_pcie_match);
> > >  
> > > +static const char * const j721e_pcie_supplies[] = {
> > > +       "vpcie12v", "vpcie3v3", "vpcie1v5"
> > > +};
> > 
> > Please don't hardcode the supplies in driver. The DT binding should make sure
> > the relevant supplies are passed (including the optional ones). Just use
> > of_regulator_bulk_get_all() to acquire all the passed supplies.
> > 
> > - Mani
> > 
> 
> I checked the bulk regulator APIs as suggested and of_regulator_bulk_get_all()
> does handle optional supplies correctly, however it is not a managed function
> and doesn't enable the  regulators automatically.
> 
> To use of_regulator_bulk_get_all(), I would need to:
> - Manually enable regulators with regulator_bulk_enable()
> - Add cleanup/disable logic in remove path
> - Handle error cleanup path manually
> 
> This would actually make the code more complex and error-prone compared to the
> current approach using devm_regulator_get_enable_optional(), which provides
> managed cleanup and automatic enable for optional supplies.
> 
> I also checked devm_regulator_bulk_get_enable(), it treats all supplies as
> required and needs the supplies name as well.
> 
> Unless there is a devm_regulator_bulk_get_optional_enable() API I'm not aware
> of, the current per-supply approach is the standard kernel pattern for this use
> case. Would you still prefer the bulk approach despite these limitations?
> 

Fine then. If you do not have a reason to manualy turn off/on the supplies
(during suspend/resume), then it might be better to use
devm_regulator_get_enable_optional() for now.

I'd love to add the managed version of of_regulator_bulk_get_all(), but I guess
Mark wouldn't want it.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

