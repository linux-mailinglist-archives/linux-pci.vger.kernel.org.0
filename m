Return-Path: <linux-pci+bounces-9916-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3447E929F2B
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 11:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C49B6B207C3
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 09:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829ED53362;
	Mon,  8 Jul 2024 09:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nD71evyH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2C83F9F9;
	Mon,  8 Jul 2024 09:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720431398; cv=none; b=jGE8Gw/EfdITj11g2ZlS6mgAP+lBrhnJCUrJZn493gj5eR4qJpeBZaNe+U3NxrbA7+U7Um9W2CPMx2YJVxoiHVCnqePKMHknKQAC7OwMOMh4568pWcPx5h+hsjDErTAAC8mJmdqRo/9FsllKH+EtnCJ88ODd9DF9Kz7/qIdJnuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720431398; c=relaxed/simple;
	bh=Xiw5vB0052Gl+ZR1KcxMzIPi0K4sjO2ctTIPiltoYm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyXlfywUWzohuYRbpDjo56TGSS0uMjE4pAM6jBUkwGpqNtJPLT7axR2bFP9n6qqKz6K5A4mkM3Ycwh+uqqcc/tRiqNRuLF+uOJ4NcmEcJjA05Gtwe/ML1B/OmWq8fMcnPAfjHOwF8/qTfFANk2/fynpEjIwg3Ly7t55WShzJSDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nD71evyH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69F8C116B1;
	Mon,  8 Jul 2024 09:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720431397;
	bh=Xiw5vB0052Gl+ZR1KcxMzIPi0K4sjO2ctTIPiltoYm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nD71evyHcTYyqnKhYOjZ2rvE1kNbKK4fnjwv9H9/q4Gl4v77btpI0VPjF5Axl9uxQ
	 zf6kWsNDkwMq3R/ag7pDQ3aQnkKN6QAosSO/GatB5xms1cHhBP9NfbM4sFW7DiYnPx
	 irzKjsb2C6DVkaGGQ0j3WkLeMJE27TFQOOkFhxoMnck7JKfbarrXcEy3q/y/MHPiBQ
	 0VFEB5KFEKtkNZLvbKTAgqYbo2rfyPNP5kH1Le9VrjSKh80LCf8+lXwpNgyTZke2Rc
	 5//FidY4WjFL3DuCymBmccvJMLfqgvNBdG4jPHKE1cIegjJ9v888E39LlJlN6TnBUA
	 52ibJZjxn41bg==
Date: Mon, 8 Jul 2024 10:36:31 +0100
From: Will Deacon <will@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, lpieralisi@kernel.org,
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, liviu.dudau@arm.com, sudeep.holla@arm.com,
	joro@8bytes.org, robin.murphy@arm.com, nicolinc@nvidia.com,
	ketanp@nvidia.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: generic: Add ats-supported
 property
Message-ID: <20240708093630.GA11302@willie-the-truck>
References: <20240607105415.2501934-2-jean-philippe@linaro.org>
 <20240607105415.2501934-3-jean-philippe@linaro.org>
 <20240706032431.GH1195499@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240706032431.GH1195499@rocinante>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Krzysztof,

On Sat, Jul 06, 2024 at 12:24:31PM +0900, Krzysztof Wilczyński wrote:
> > Add a way for firmware to tell the OS that ATS is supported by the PCI
> > root complex. An endpoint with ATS enabled may send Translation Requests
> > and Translated Memory Requests, which look just like Normal Memory
> > Requests with a non-zero AT field. So a root controller that ignores the
> > AT field may simply forward the request to the IOMMU as a Normal Memory
> > Request, which could end badly. In any case, the endpoint will be
> > unusable.
> > 
> > The ats-supported property allows the OS to only enable ATS in endpoints
> > if the root controller can handle ATS requests. Only add the property to
> > pcie-host-ecam-generic for the moment. For non-generic root controllers,
> > availability of ATS can be inferred from the compatible string.
> 
> Applied to dt-bindings, thank you!
> 
> [1/1] dt-bindings: PCI: generic: Add ats-supported property
>       https://git.kernel.org/pci/pci/c/631b2e7318d45

FWIW: I already picked this up in the IOMMU tree last week. If you need
it to avoid a conflict, then you can pull from the pci/ats branch:

https://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git/commit/?h=pci/ats&id=40929e8e5449a18bc98baf7a907dd6674bd60049

Cheers,

Will

