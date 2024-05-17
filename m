Return-Path: <linux-pci+bounces-7637-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 748268C8D1C
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 21:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 135121F25549
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 19:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32561140E2F;
	Fri, 17 May 2024 19:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZWM6OZe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B0513DDA7;
	Fri, 17 May 2024 19:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715975781; cv=none; b=KLla4/lcOZl4X1O8eKfD3CNIbyFtF+FgPN73dCO7+dmAN59VIydBu+5Gjl5H6+RZYpb0NGeTNZ4oTXl+EHNNr9DueRXAnCKOrOtNbkks+4kS+79ohFQP6rzCCoby2/i61Pujrj6utaDtGmkYm6F8u31CjkxtemHYN9tsG9A5gfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715975781; c=relaxed/simple;
	bh=UaEwLNDI/F1sBxJ3RwcgRvRUx7I1X5xXKiEo/tzV6VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmYsskwpf7ro60BnYbg9YLbDExJLActwrUMH31bcgWIt7mw/+EIPeCJizB6IqF6LOlTqkQuNolCbNEjCo9RzNy/MVKTPxWKhdPpPX7mq9H16TxjWdgxMC9cjbdkLljXzh/KL6UkLw1z551fi+bDkgQWH5c5yoCVfFpwrhGBiCFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZWM6OZe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F4FC2BD10;
	Fri, 17 May 2024 19:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715975780;
	bh=UaEwLNDI/F1sBxJ3RwcgRvRUx7I1X5xXKiEo/tzV6VM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AZWM6OZeNDHjyVVepDhp8KznJhQYj2Uvtk0jSAobwd2cNW7rfxMsWruuqiPq04ZmJ
	 yYjVXho7bVxguyzTDqh/O04WtPcbXb0fqn/TealYaXPgG4zM9DiU02/VV3JC69W/v5
	 xGF7MKv5DuJP/zLUAoPT2Qm4+r+a47F3v/+SeMtMdWYA1egsGvmULBGqud1qlVEqj9
	 VMNYu2+zgLNNyVJfm8Rl5zo6AjGJ1Y0p2XfKQpCdrbADQ/pyzVb1bghtz203NCgEm7
	 lk05leXVDbLEjjuKyft0pBXd2GeLuuT6zMRKvJ7K2Om8gZNGFSB5UhdchbuEA/eFtZ
	 /rRAvGV+/3y4A==
Date: Fri, 17 May 2024 14:56:19 -0500
From: Rob Herring <robh@kernel.org>
To: matthew.gerlach@linux.intel.com
Cc: linux-kernel@vger.kernel.org, conor+dt@kernel.org,
	lpieralisi@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5] dt-bindings: PCI: altera: Convert to YAML
Message-ID: <20240517195619.GA2851135-robh@kernel.org>
References: <20240513205913.313592-1-matthew.gerlach@linux.intel.com>
 <171563836233.3319279.14962600621083837198.robh@kernel.org>
 <20240514131750.GA1214311-robh@kernel.org>
 <alpine.DEB.2.22.394.2405141044470.540832@sj-4150-psse-sw-opae-dev2>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2405141044470.540832@sj-4150-psse-sw-opae-dev2>

On Tue, May 14, 2024 at 11:30:05AM -0700, matthew.gerlach@linux.intel.com wrote:
> 
> 
> On Tue, 14 May 2024, Rob Herring wrote:
> 
> > > > 
> > > 
> > > My bot found errors running 'make dt_binding_check' on your patch:
> > > 
> > > yamllint warnings/errors:
> > > 
> > > dtschema/dtc warnings/errors:
> > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/altr,pcie-root-port.example.dtb: pcie@c00000000: interrupt-map: [[0, 0, 0, 1, 2, 1, 0, 0, 0], [2, 2, 2, 0, 0, 0, 3, 2, 3], [0, 0, 0, 4, 2, 4]] is too short
> > > 	from schema $id: http://devicetree.org/schemas/altr,pcie-root-port.yaml#
> > 
> > You need 3 address cells after the phandles since the interrupt parent
> > has 3 address cells.
> 
> Thanks for the extra explanation. Adding 3 address cells of 0 made the
> warning go away.
> 
> > 
> > What does your actual DT contain and do interrupts work because
> > interrupts never would have worked I think? Making the PCI host the
> > interrupt parent didn't even work in the kernel until somewhat recently
> > (maybe a few years now). That's why a bunch of PCI hosts have an
> > interrupt-controller child node.
> 
> The following DT snippet comes from
> https://www.rocketboards.org/foswiki/Projects/Stratix10PCIeRootPortWithMSI
> 
> The Linux kernel version is 4.14.130-ltsi. Would the use of the msi-parent
> node make everything work?

Possibly? I would think MSIs are preferred and almost anything should 
support MSIs now.

Rob

