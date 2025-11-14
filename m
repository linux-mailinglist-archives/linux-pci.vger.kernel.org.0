Return-Path: <linux-pci+bounces-41232-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EADAC5C98A
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 11:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC31A4F81AE
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 10:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7263101DB;
	Fri, 14 Nov 2025 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJgSYbtM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8889C3101D0
	for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763115818; cv=none; b=cV66446JwIoXb7siCl5H3IJ9DUbmVRQc/5PdVjW47pljLLBwzJ7rcXTo3j6YS9Yje9IId/DRBR2A0/dId++A9x0sWtkXOByI3XUw6SUKqufLSuSQDNRJJI20OvdkFY9GGD4P2TKXNFVkH6tenMbPy1SaRVYX0gyq/Np/PqNuqpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763115818; c=relaxed/simple;
	bh=YnG92EV9kpTkl72/R9gDttnCzchCLwopduJMWqx4/AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZGHszxn+FE3NTs0/DAc7Drq4pcdsauiUJuHipgYowk9yS1b8K6A4jtJ7JJvkuBqLfgPVJK8pQF1o4ZgLT2+ILZyxVnCN9EdfLrvlVtG7/D6BDI/mI7Ui4sIBxSeo7aAn58Jak6TUHLRdqow0onbuDt8H8BoBbaOrS/53sUbfnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJgSYbtM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0328C16AAE;
	Fri, 14 Nov 2025 10:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763115818;
	bh=YnG92EV9kpTkl72/R9gDttnCzchCLwopduJMWqx4/AY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vJgSYbtMDMtmuYPZv86Ven8us4qMRbO6prXqEHPuB3I2gX4B8rD4VtQNOAKfMBcj5
	 ObznjR+hUxg7ZCgVskGWFlpD+LZD6RIz/HuIUrX3JkRZlw+HD6ONmHy68v6/rfj+wR
	 8/wE1G7LNxXMcoq2qMdive32UMdoxVXlp1kOKNtplHLFSl1jq1XE1DoeJVkNFMDtKh
	 7GhM/jz01qtFz0yUXnVX6wciyod64xv5TH7hye89YKmF840NZs6pY2hYElq408N2L9
	 KjvXoexDRMZ0tjMmn6VQaSf6l1xpXPklQ/xGTKVqZ/rKutVtZJQUTEfhDDPrZZCJRZ
	 fE7LmkXOD7Bmw==
Date: Fri, 14 Nov 2025 15:53:26 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Fix wrong PORT_LOGIC_LTSSM_STATE_MASK
 definition
Message-ID: <r7fljgvkezpnwvgnvdzz3s3tvxorkouubaop3sdb2ipwizhxil@wpfxzvy4ymcs>
References: <1763102197-130089-1-git-send-email-shawn.lin@rock-chips.com>
 <cmwjx6qbv57lhpedwpb7o2y2sn3mccf7pbdwtj6kdajoorawhs@fxdgr27cgg7q>
 <cdb79e0e-60ee-4206-8e2a-922ad36e27ea@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cdb79e0e-60ee-4206-8e2a-922ad36e27ea@rock-chips.com>

On Fri, Nov 14, 2025 at 03:47:15PM +0800, Shawn Lin wrote:
> Hi Mani
> 
> 在 2025/11/14 星期五 15:35, Manivannan Sadhasivam 写道:
> > On Fri, Nov 14, 2025 at 02:36:37PM +0800, Shawn Lin wrote:
> > > Per DesignWare Cores PCI Express Controller Register Descriptions,
> > > section 1.34.11, PL_DEBUG0_OFF is the value on cxpl_debug_info[31:0].
> > > 
> > > Per DesignWare Cores PCI Express Controller Databook, section 5.50,
> > > SII: Debug Signals, cxpl_debug_info[63:0] says:
> > > "[5:0] smlh_ltssm_state: LTSSM current state. Encoding is same as the dedicated
> > > smlh_ltssm_state output."
> > > 
> > > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > 
> > No fixes tag?
> 
> I was thinking it actually didn't casue any problem since the ltssm from
> dwc core didn't need the sixth bit. So I didn't know if it worths a
> backport if I add a fixes tag. But if it does, then :)
> 

Fixes tag needs to be added for a 'fix' irrespective of the backport.
Backporting is something stable team does and it is not always guaranteed if you
do not CC the stable list.

> Fixes: 23fe5bd4be90 ("PCI: keystone: Cleanup ks_pcie_link_up()")
> 

Thanks!

- Mani

> > 
> > - Mani
> > 
> > > ---
> > >   drivers/pci/controller/dwc/pcie-designware.h | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > index e995f692a1ec..24bfa5231923 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > @@ -97,7 +97,7 @@
> > >   #define PORT_LANE_SKEW_INSERT_MASK	GENMASK(23, 0)
> > >   #define PCIE_PORT_DEBUG0		0x728
> > > -#define PORT_LOGIC_LTSSM_STATE_MASK	0x1f
> > > +#define PORT_LOGIC_LTSSM_STATE_MASK	0x3f
> > >   #define PORT_LOGIC_LTSSM_STATE_L0	0x11
> > >   #define PCIE_PORT_DEBUG1		0x72C
> > >   #define PCIE_PORT_DEBUG1_LINK_UP		BIT(4)
> > > -- 
> > > 2.43.0
> > > 
> > > 
> > 
> 

-- 
மணிவண்ணன் சதாசிவம்

