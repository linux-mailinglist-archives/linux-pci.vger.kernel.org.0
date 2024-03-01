Return-Path: <linux-pci+bounces-4328-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB8A86E3B1
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 15:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECB88286B90
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 14:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CAF22324;
	Fri,  1 Mar 2024 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEr9Rad7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C847AEDB;
	Fri,  1 Mar 2024 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709304462; cv=none; b=TvHaXmKAL1mZmFhGsf90h03WCMNVEJDGfSALiUGGhgd7Mai+3fCQJORFjCuVUIYO8yZCS+L8QhYzvAiROl943zAjs+VYuNB9UqJ9tWsPJ6FdApFG9MJpb6hTn+DDYxSypTSHKV6D/XARQ6Xt6hPO/fniX4WHwIWXg9bVrYeo+U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709304462; c=relaxed/simple;
	bh=doXwc+HnpAdZ9CAsr12bsREMrG/H40nyaPLWjZvbd38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SS5Pkzun5spYSY2FBCwOwckvGuxsNNfsDem3pzZYVimk1bb0jzO/MGC591/GSxCaIL25rw/oXSuYyWel1K59SanMZS+RaU55ohxfsr4AZxhFiXK/SBSejWNV5AdTURLcbW6dPi+aHICKKt8irIEVxIDGFIXGEDaVF5/iPqt1lrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEr9Rad7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F06C433F1;
	Fri,  1 Mar 2024 14:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709304462;
	bh=doXwc+HnpAdZ9CAsr12bsREMrG/H40nyaPLWjZvbd38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fEr9Rad7yvcM2enzGLz1qYGqnObleMpmze27KBcxkkgN7/EPf03A68TYeGIXPZpjc
	 +gjUbeOb4tsoRRNxILFbYpOS2lZEuLYDcEuYpJmg/yITGuArNz3D4mF9JewcsP56MS
	 4cMFwmhBKPs8AKB14PuBEWyBFVTGhCGuXyYf1XTFyWrLus7Ir1xKusSLAcOACuB0vJ
	 dgmo+r59SQ6ufw5EOvRZynahUgFQI9wVXCPaOCDoNKiXTlAzyQJy7cBUVD3InHzdyw
	 H/F6IuhXLfSr0IvrqB0EE20uV+J+hmoUkuV9t1H6MJUKEk0e7417SMsniFS2+rQaOE
	 BUDzqUOGqJQbA==
Date: Fri, 1 Mar 2024 08:47:38 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: imx@lists.linux.dev, conor@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
	linux-kernel@vger.kernel.org, conor+dt@kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org,
	helgaas@kernel.org, bhelgaas@google.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/5] dt-bindings: pci: layerscape-pci: Convert to yaml
 format
Message-ID: <20240301144738.GA2110767-robh@kernel.org>
References: <20240228190321.580846-1-Frank.Li@nxp.com>
 <20240228190321.580846-2-Frank.Li@nxp.com>
 <170915420970.759733.12998246565079147606.robh@kernel.org>
 <ZeDCQezI2zj8bWBP@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeDCQezI2zj8bWBP@lizhi-Precision-Tower-5810>

On Thu, Feb 29, 2024 at 12:43:29PM -0500, Frank Li wrote:
> On Wed, Feb 28, 2024 at 03:03:31PM -0600, Rob Herring wrote:
> > 
> > On Wed, 28 Feb 2024 14:03:17 -0500, Frank Li wrote:
> > > Split layerscape-pci.txt into two yaml files: fsl,layerscape-pcie-ep.yaml
> > > and fsl,layerscape-pcie.yaml.
> > > yaml files contain the same content as the original txt file.
> > > 
> > > The subsequent commit will fix DTB_CHECK failure.
> > > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  .../bindings/pci/fsl,layerscape-pcie-ep.yaml  |  89 +++++++++++++
> > >  .../bindings/pci/fsl,layerscape-pcie.yaml     | 123 ++++++++++++++++++
> > >  .../bindings/pci/layerscape-pci.txt           |  79 -----------
> > >  3 files changed, 212 insertions(+), 79 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> > >  create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> > >  delete mode 100644 Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > > 
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> Please omit these errors. Bjorn require create a identical version as
> old txt file.
> 
> Origial txt will cause DTB_CHECK error. The problem will be fixed at next
> patches.

Nope. We can't have warnings. Please fix them in the conversion. Call 
out the changes in the commit message.

Rob

