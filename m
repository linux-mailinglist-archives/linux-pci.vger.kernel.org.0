Return-Path: <linux-pci+bounces-9516-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC5991DE80
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 13:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E285FB222EF
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 11:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C558284D02;
	Mon,  1 Jul 2024 11:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G56Y/Su9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962E61422A6;
	Mon,  1 Jul 2024 11:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719835050; cv=none; b=QAJkYmR7ziBWb5qZK3Uxv5cYz105jNx+VhFwG1T27VqkMzQCmP7u7rd1/k5MmfjSXHAGgNhPKRAQ/TbdcEA9PpyAtJfZQF7c9hFRteEKN1KEAtGHV8yQXFpwCE9lReDfADIdZjqHdyD6aB8kqLq1fKg+TPh20WuzNNjyyL6SUY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719835050; c=relaxed/simple;
	bh=hzmzErIa14odgkFiGOmGNMUeyolu8zX2etABDTkla90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqmAH+YzmQtlm5+q+szrCoYmxHw4DHRCrGx1T3F8JJMsmxwyBcVMvTQRmjU4h0EuBMfMiqY6thGCySgTVsb0V9RgH4wb+1Su1mgxJ2Ddxk38cThphurAMKJaevHCdnwrfqYcSm2xzSJ50x5MRgWqIYunEJvQB3Qe608pCpfQ840=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G56Y/Su9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F873C116B1;
	Mon,  1 Jul 2024 11:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719835050;
	bh=hzmzErIa14odgkFiGOmGNMUeyolu8zX2etABDTkla90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G56Y/Su9chR8vStNUMCKGsKq5ePJtlZMhhpmqlWbeUKuCdMezGkSAOL4jSl7YA/QL
	 BzMU38h/Vrvdzs2VzOKYtvX3E1Tnxzi4KzFRIOpJprR+S4R9A8GCMi7TlJQ4WpF0+O
	 Ldwkd4eNZelD9OF/h+XsnYXqqTbF8DlwOsI507GJThGgy/GeT6pB0N0Z359w/YY+TW
	 INT+nuTow3N94NRCEx4hPHqbaVJDx0tyI39Ic0bkqavKJmG7ThRO9haz0UYUO4dAot
	 tf1B97UsuPagnlL4mAiTJXOhGXN7Wajm1Itm8P3QpLtXVF2oJ8kMo+sevRAVYAciwO
	 oH/sSRSmOsOYQ==
Date: Mon, 1 Jul 2024 12:57:23 +0100
From: Will Deacon <will@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	liviu.dudau@arm.com, sudeep.holla@arm.com, joro@8bytes.org,
	robin.murphy@arm.com, nicolinc@nvidia.com, ketanp@nvidia.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Enable PCIe ATS for devicetree boot
Message-ID: <20240701115723.GA1732@willie-the-truck>
References: <20240607105415.2501934-2-jean-philippe@linaro.org>
 <20240701102400.GA2414@myrica>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701102400.GA2414@myrica>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Jul 01, 2024 at 11:24:00AM +0100, Jean-Philippe Brucker wrote:
> On Fri, Jun 07, 2024 at 11:54:13AM +0100, Jean-Philippe Brucker wrote:
> > Before enabling Address Translation Support (ATS) in endpoints, the OS
> > needs to confirm that the Root Complex supports it. Obtain this
> > information from the firmware description since there is no architected
> > method. ACPI provides a bit via IORT tables, so add the devicetree
> > equivalent.
> > 
> > Since v1 [1] I added the review and ack tags, thanks all. This should be
> > ready to go via the IOMMU tree.
> 
> This series enables ATS for devicetree boot, and is needed on an Nvidia
> system: https://lore.kernel.org/linux-arm-kernel/ZeJP6CwrZ2FSbTYm@Asurada-Nvidia/
> 
> Would you mind picking it up for v6.11?

I'll take a look.

Will

