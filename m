Return-Path: <linux-pci+bounces-2950-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 573F1845EF5
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 18:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BEA81F2E93F
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 17:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32DA7C6EC;
	Thu,  1 Feb 2024 17:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QobJeH8D"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FD57C6D9;
	Thu,  1 Feb 2024 17:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810037; cv=none; b=El1EvXXggYEWuyBHx+Rhgm5b16quxtF2048rtXud22j2Tn4tE/DgjCjrvfXpFt0IoAMOXmMdBKXCISKrPbpOPguqRzHZhv46aoO3I9WtSs638Dl7/1axUKFrAqiH07xCrIV1ULZ1BOHlzp7fL88jQnbAJctm8FPux8g3lZyNevw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810037; c=relaxed/simple;
	bh=9EOnkhCzyYiI6zRhXrV/SeBRJIFsUA/4cCERx+sXZ3w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Mrs60nC2sld7LNwmFN0U7L63FE7mMdqgEfIrsHqMxPokhvAIzkYl9syLUoTUNzQutfQg3OEIQSWjoGGq3OTvZdpQIPM3veGqmREXkYgFMm2ULzi7JEp7aooGKWgKJPEbDDtbfDOVIbspQJdgK7CgLbp+QsJyvbVNx5Ef5liiyQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QobJeH8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7583C433C7;
	Thu,  1 Feb 2024 17:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706810037;
	bh=9EOnkhCzyYiI6zRhXrV/SeBRJIFsUA/4cCERx+sXZ3w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QobJeH8Dplg/9zLkUmbKPeEZ0oueAYIF9WhAIPCmHtB8S1ePwgS+V5+ADBrMP8p1/
	 N7l0WVYCA6TIZj0tVyab6lmAi3RG2QChkl08aFbzzF8i47YetxR/0fpDgkO2RznpNP
	 iRm7cwf0R8TwLzv7iSCMQ2Lxs3fi2aXekoeEGJeiA2PzFaD76pofKq/nzGub77Bvv4
	 UNO4KTFtfZ3BjmtLV6H/iI3azJkHPUcGZRG+6w+fHQWmvqOFscHcgLucPgd8PagiQL
	 GfiL8HeAlULf16zUVU1mQatGU3cFnOmLKqAEb7XW0HsLJSsy5aFnve7TTxD2dOq76b
	 ZYR6x+N5hWYpQ==
Date: Thu, 1 Feb 2024 11:53:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: bhelgaas@google.com, devicetree@vger.kernel.org,
	gustavo.pimentel@synopsys.com, imx@lists.linux.dev, kw@linux.com,
	leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
	lpieralisi@kernel.org, mani@kernel.org,
	manivannan.sadhasivam@linaro.org, minghuan.lian@nxp.com,
	mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
	shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: Re: [PATCH v12 2/3] PCI: dwc: Implement general suspend/resume
 functionality for L2/L3 transitions
Message-ID: <20240201175355.GA639928@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbvQB/X0kwFs7nAb@lizhi-Precision-Tower-5810>

On Thu, Feb 01, 2024 at 12:08:23PM -0500, Frank Li wrote:
> On Thu, Feb 01, 2024 at 10:50:25AM -0600, Bjorn Helgaas wrote:
> > On Mon, Aug 21, 2023 at 02:48:14PM -0400, Frank Li wrote:
> > > Introduce helper function dw_pcie_get_ltssm() to retrieve SMLH_LTSS_STATE.
> > > ...
> > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > index 615660640801..91d13f9b21b1 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > 
> > > @@ -364,6 +375,7 @@ struct dw_pcie_ops {
> > >  	void    (*write_dbi2)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
> > >  			      size_t size, u32 val);
> > >  	int	(*link_up)(struct dw_pcie *pcie);
> > > +	enum dw_pcie_ltssm (*get_ltssm)(struct dw_pcie *pcie);
> > 
> > This has already been applied as
> > https://git.kernel.org/linus/4774faf854f5 ("PCI: dwc: Implement
> > generic suspend/resume functionality"), but this .get_ltssm() pointer
> > doesn't seem to be used anywhere.  Should we remove it until we need
> > it?
> 
> Could you place hold on for a while? I am working on imx PCIe. One old
> imx6 may need it!
> 
> If not, I will submit patch to clean it. My new patches depend on
> 
> https://lore.kernel.org/imx/ZbJ+tFPn3aOYHCwf@lizhi-Precision-Tower-5810/T/#t
> 
> All already reviewed, could you please pick up these, so I can continue
> my futher work.
> 
> Another
> https://lore.kernel.org/imx/20240201-pme_msg-v2-0-6767052fe6a4@nxp.com/T/#t
> was under review.

OK.  I don't see .get_ltssm() used in that series either.  But if you
will need it soon, no point in removing it right now.

Bjorn

