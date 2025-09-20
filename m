Return-Path: <linux-pci+bounces-36577-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5C4B8C3C7
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 10:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3C1F7ACABF
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 08:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09D72773DF;
	Sat, 20 Sep 2025 08:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fz2O/AsZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96492227EA4;
	Sat, 20 Sep 2025 08:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758356056; cv=none; b=f/lwzJsJCm/i0Eg6jFSUdeE2zwF9lUMxsMi7gPiH6O83/9cbS+gK04pYWE7bVRtwp1k6zMLQgfOqxVkwpLz+KIOKzW1XjfajybdvIh4W3YoFhrBhioLPISuSTCyLlto+U2AKAx2SG14Y8i38g4QsClUF/PmghBbBKShrFAIDHec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758356056; c=relaxed/simple;
	bh=H9jVzceHhz7BCuWrEcBBzKxp5SLS2ZXomJMfy40j+D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hv5WEGgEPj9ENpj3SbSYkyJ4RVpkunKXg7hEOrOFdGvULkiciathLgk7OVB/I4c1l3cNMI7LEGSNOLVeRsC00rQqhZxcYT/h33wpGozjQ21B7Is7e0m7ybdzC9niMJLhgPIJOyzqKhNhUeAin/7Qba1CvsI/FyA7JHLLI6XxezY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fz2O/AsZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919AFC4CEEB;
	Sat, 20 Sep 2025 08:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758356054;
	bh=H9jVzceHhz7BCuWrEcBBzKxp5SLS2ZXomJMfy40j+D0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fz2O/AsZ6wRO0snZvJPxpyl7bfliCTrVg+OSrWu+uBqQiLuFyLiaz6+DVE0UGnXSa
	 BbXA5jDLYtLPPrDIC2XYv5fuNmtGIhp3aaUMFfVUtsIYlPkb2YbfOZYf+8RwgU0xBn
	 YLl0XbUeu7LrsxiXN7u6WSb91IRLsJlXIE35t5RJCZVYdoIfBLyBBFj3r5nse6wN44
	 qtvupiZLaTIGx7DZsdOdovNSrq0QNMI9yU8cpnqDPECwlYk3r2zotVBMoe24gM/w/M
	 DO8Iqyke3vY/ajeEbkO7pUS+adOagfbLQwf/mWkQR1PSqF1ja3GVylGopCGmUJFEvN
	 WJuatdlh9pRFQ==
Date: Sat, 20 Sep 2025 13:44:02 +0530
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
Subject: Re: [PATCH v2 05/10] PCI: keystone: Add ks_pcie_free_msi_irq()
 helper for cleanup
Message-ID: <ouj2ksyccliaolyq7icceltcmnvadvtckonrck3bawrufuhct6@bda2xxpp66dg>
References: <20250912122356.3326888-1-s-vadapalli@ti.com>
 <20250912122356.3326888-6-s-vadapalli@ti.com>
 <rbyukvvhzoch4p54usbrjpjlhd6qknhp2er6gfxhcj5lxpgrqh@5wnwiijn2g5f>
 <cbcb0183-1fbd-4815-948b-3c380491c8db@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cbcb0183-1fbd-4815-948b-3c380491c8db@ti.com>

On Sat, Sep 20, 2025 at 01:34:15PM +0530, Siddharth Vadapalli wrote:
> On Sat, Sep 20, 2025 at 12:02:34AM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Sep 12, 2025 at 05:46:16PM +0530, Siddharth Vadapalli wrote:
> > > Introduce the helper function ks_pcie_free_msi_irq() which will undo the
> > > configuration performed by the ks_pcie_config_msi_irq() function. This will
> > > be required for implementing a future helper function to undo the
> > > configuration performed by the ks_pcie_host_init() function.
> > > 
> > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > ---
> > > 
> > > v1: https://lore.kernel.org/r/20250903124505.365913-6-s-vadapalli@ti.com/
> > > No changes since v1.
> > > 
> > >  drivers/pci/controller/dwc/pci-keystone.c | 25 +++++++++++++++++++++++
> > >  1 file changed, 25 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> > > index d03e95bf7d54..81c3686688c0 100644
> > > --- a/drivers/pci/controller/dwc/pci-keystone.c
> > > +++ b/drivers/pci/controller/dwc/pci-keystone.c
> > > @@ -666,6 +666,31 @@ static void ks_pcie_intx_irq_handler(struct irq_desc *desc)
> > >  	chained_irq_exit(chip, desc);
> > >  }
> > >  
> > > +static void ks_pcie_free_msi_irq(struct keystone_pcie *ks_pcie)
> > > +{
> > > +	struct device_node *np = ks_pcie->np;
> > > +	struct device_node *intc_np;
> > > +	int irq_count, irq, i;
> > > +
> > > +	if (!IS_ENABLED(CONFIG_PCI_MSI))
> > 
> > Isn't the CONFIG_PCI_KEYSTONE_HOST always depend on PCI_MSI?
> 
> The reason I added the check is that it exists in 'ks_pcie_config_msi_irq()'.
> But I realize now that it should be removed from
> 'ks_pcie_config_msi_irq()' as well. Since I had written the above
> function with the objective of undoing the changes done by
> 'ks_pcie_config_msi_irq()', the 'config check' was retained since the
> changes should be undone only if they were executed by
> 'ks_pcie_config_msi_irq()'. I will drop the check in the v3 series and
> will also post a separate patch to drop if from 'ks_pcie_config_msi_irq()'
> if that is acceptable. Please let me know.
> 

Sounds good to me.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

