Return-Path: <linux-pci+bounces-4524-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 584748721DA
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 15:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DA8F1F23DC6
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 14:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE47186ACA;
	Tue,  5 Mar 2024 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/B/UAeC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA905C609;
	Tue,  5 Mar 2024 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709649999; cv=none; b=HccajnIkRdDJr8oaC9dOGYCoYnd7EPoKWsI5hBMfC2UVeo7AREhPNZsN1TBPFvpJr/QoZb4m7sL7db4Lss85zxX0CfnywFEutcNEV94FLuOrfcT/WV+VHfp2xS08GUXljp0YIBnxzIDpi3UQEHc9GVU/TL9nHyid0ARE57o490M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709649999; c=relaxed/simple;
	bh=WJiYuuI2+nv3lSds/JbSKGWH4EVNi2cWoaQGbieuCIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PE74qAlHLws0Rd+ePbL48z9k/SNFpFR839EVoCd2QUA+apG+siJW/+ykgEJzwzSmmNjgwercRJ37lMqnqhr7Y7ZSBsn7skr81+utmaECGi9Rce9YHCwHP0INawggOPGj39Ou4hMqgx9yuS/2HzsSNrUqyemo7ylA0nWxvk1KcHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/B/UAeC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9C6C433F1;
	Tue,  5 Mar 2024 14:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709649999;
	bh=WJiYuuI2+nv3lSds/JbSKGWH4EVNi2cWoaQGbieuCIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b/B/UAeCzYTXgnmNHaKP17apwu86PKj497uhXC36u3SPUk6cpB2i3gzWla5Sd6WLl
	 6YHkmiNg+8OjmSbvS5uQw04m3NANmbz1T/76Zi5ul+qUbbDrMRIyBTDR7vaIvCJv2g
	 8HAWhGmlvbpxVQi9qmwSszVXMxuQBPueqjWFo8XHHdoVbIYgDk8CHX8QB/npij4TwB
	 8j3Af7v/akufMBZ/jwJ7A695x9WnqBHorQAhchf4WQKGrMHDMZBN9NqGh+NbHG0eHs
	 R1fhI4U69exRWogS4/doxg9EkjG/C7zC3LL4ystVtIQ02zGSKkZ/iBzjd3skUyD5A/
	 Lr+JkW7gwAarg==
Date: Tue, 5 Mar 2024 08:46:36 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: conor@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, helgaas@kernel.org, imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: pci: layerscape-pci: Convert to yaml
 format
Message-ID: <20240305144636.GB3310214-robh@kernel.org>
References: <20240301162741.765524-1-Frank.Li@nxp.com>
 <20240301162741.765524-2-Frank.Li@nxp.com>
 <20240304173204.GA777171-robh@kernel.org>
 <ZeYJHLpHb0UGv8S+@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeYJHLpHb0UGv8S+@lizhi-Precision-Tower-5810>

On Mon, Mar 04, 2024 at 12:47:08PM -0500, Frank Li wrote:
> On Mon, Mar 04, 2024 at 11:32:04AM -0600, Rob Herring wrote:
> > On Fri, Mar 01, 2024 at 11:27:39AM -0500, Frank Li wrote:
> > > Split layerscape-pci.txt into two yaml files: fsl,layerscape-pcie-ep.yaml
> > > and fsl,layerscape-pcie.yaml.
> > > yaml files contain the same content as the original txt file.
> > > 
> > > Do below changes to pass dtb_binding check:
> > > - Remove dma-coherent and fsl,pcie-scfg because not every SOC need it.
> > 
> > You mean 'remove from required' right? Because they are still here.
> > 
> > > - Set unevaluatedProperties to true in fsl,layerscape-pcie.yaml.
> > 
> > Sorry, but that's not acceptable either. You need the $ref's in this 
> > patch.
> 
> 
> Rob:
> 
> If I squash this 3 patches, it will match most your comments. And will back
> to my previous v3's patches, 
> https://lore.kernel.org/imx/20240214194145.2669744-1-Frank.Li@nxp.com/

Plus our review comments I hope...

> 
> Bjorn Helgaas suggest split to patches:
> https://lore.kernel.org/imx/20240226210842.GA211190@bhelgaas/
> 
> First one will be equal to origial txt, then add change base on that.
> 
> I need a clear direction before I continue on this.

Bjorn's suggestion doesn't work. I think it was confused in that you 
said you were 'adding' things. You aren't adding things, just fixing 
things to make the validation pass.

If you want to split things, you could add reg and/or interrupt names to 
the common schema first. And then add Layerscape schemas. But don't add 
things you turn around and remove in the very next patch. I think 
Krzysztof told you the very same thing.

Rob

