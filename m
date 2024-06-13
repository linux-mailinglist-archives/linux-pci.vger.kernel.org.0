Return-Path: <linux-pci+bounces-8751-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D48907A3D
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 19:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1823B20C7C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 17:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAF11428EF;
	Thu, 13 Jun 2024 17:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOA86mQv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3516F06A;
	Thu, 13 Jun 2024 17:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718301093; cv=none; b=FSCeN9bA5pdmkABwmKfFz2yissGmjHWIuS2IQwoeaksOjp6xlJtK/o0ETZAxIbsyTDO5rvHILxPJwV5zqxOukwErIB2fobKA8TVQm8hAx8U6HLlS/xykTB2kQdZhQMxREogQboTcph1u6dYPdxcOdI2WoE0R0Aho+X4JC0XZXi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718301093; c=relaxed/simple;
	bh=dpzc2Mg4UDlix6hhecAybuhuyjOozyNL1r16dty6Svc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwHTMKDgYdFqRLPdjRUuoGhZzOpP0GlaZ+CQmAlsOH9KDboMcFQ6oHde17f4YAXgH8ZBagt00NGofXK8UN8sWx2deowCQHueFvcqrcLME4pZHAZYC6119on2oOkmD4YVF1PFTHXzQdeQpYsdIfajtXhuWYQWp7+geA9o1Ypq71c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOA86mQv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05956C2BBFC;
	Thu, 13 Jun 2024 17:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718301093;
	bh=dpzc2Mg4UDlix6hhecAybuhuyjOozyNL1r16dty6Svc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JOA86mQviTY+2IFDcqJXhpG/d91NUuIsexZRRn+MfSZI4w1sSfJHMLjJThJBrPxMu
	 ewfcpAV8a/CG8m2pgYVVgboRNL866Bv3faG2DA2XsiIsPy7VRz+rALcDo0bumaEKwQ
	 j9vaNzlmdv+6ii/ZBBEvg0XKFZhhbQdRajs1PkqbHvEhMjD9a6rTxHBpokD/L6/Ruo
	 3j8q+yPe/kIngwv8O8FXIoe4xPoXQ0Kd70b3o6KuTXXI2006L8I5pllOaJq7KN9348
	 s98l0m6kqjY3bhxvRM8l6n/tE3s4UTpT6gn/aeMdPV56N+QDB5egSw486KR9uibtOn
	 5Gkb2vMe1+gHw==
Date: Thu, 13 Jun 2024 11:51:31 -0600
From: Rob Herring <robh@kernel.org>
To: matthew.gerlach@linux.intel.com
Cc: Bjorn Helgaas <helgaas@kernel.org>, lpieralisi@kernel.org, kw@linux.com,
	bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, joyce.ooi@intel.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] PCI: altera: support dt binding update
Message-ID: <20240613175131.GA2070202-robh@kernel.org>
References: <20240611170410.GA989554@bhelgaas>
 <alpine.DEB.2.22.394.2406120744350.662691@sj-4150-psse-sw-opae-dev2>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2406120744350.662691@sj-4150-psse-sw-opae-dev2>

On Wed, Jun 12, 2024 at 08:12:05AM -0700, matthew.gerlach@linux.intel.com wrote:
> 
> 
> On Tue, 11 Jun 2024, Bjorn Helgaas wrote:
> 
> > On Tue, Jun 11, 2024 at 11:35:25AM -0500, matthew.gerlach@linux.intel.com wrote:
> > > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > 
> > > Add support for the device tree binding update. As part of
> > > converting the binding document from text to yaml, with schema
> > > validation, a device tree subnode was added to properly map
> > > legacy interrupts. Maintain backward compatibility with previous binding.
> > 
> > If something was *added* to the binding, I think it would be helpful
> > to split that into two patches: (1) convert to YAML with zero
> > functional changes, (2) add the new stuff.  Adding something at the
> > same time as changing the format makes it hard to review.

The policy for conversions is changes to match reality are fine, just 
need to be noted in the commit message. That generally implies no driver 
or dts changes which is not the case here. 

> Thanks for feedback. It was during the conversion to YAML that a problem
> with the original binding was discovered. As Rob Herring pointed out in
> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240513205913.313592-1-matthew.gerlach@linux.intel.com/
> 
> "Making the PCI host the interrupt parent didn't even work in the kernel
>  until somewhat recently (maybe a few years now). That's why a bunch of PCI
>  hosts have an interrupt-controller child node."
> 
> This was an attempt to fix the problem. I can resubmit a conversion to YAML
> with zero functional changes.

I wasn't suggesting you fix it. Just something I noticed looking at 
the other issue. If no one noticed or cared, why bother? It should work 
fine for recent kernels.

Rob

