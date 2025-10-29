Return-Path: <linux-pci+bounces-39730-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99251C1DA37
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 00:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 31EE24E0F02
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 23:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8624B2DCF6F;
	Wed, 29 Oct 2025 23:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlRwxbo5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6257C2E7645
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 23:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761779051; cv=none; b=qE2qUL5kll0TBfDlguMZCBkQy69KM2+ulVpJduOec41I++QstVVK0X8Rk+hj2q7HVpLrm/naJDUlkMi+JiPMNCX/yYkGNKC285ojBT7tKJZ6EXXgAY7ZSzUKnZajCBuGUOlqkWZPp+Pk+K9xcu02qwLlyai8zHuw7tQT+6F7O+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761779051; c=relaxed/simple;
	bh=GpupXLo7thRHRYciDVJ97ynh+x0kfFm663YZnX0nI8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TDkZaabFR7O1D9U0LSZtZmkV0di+Ghf5lbqyZZDbkkjDhfDZFY2j7pgJmSdrfOD9zpCSxaH/VLp8LUfqW2aojVgNRhw9DqFkt/+gLEZJyahv1lyrqznQhX8XIwD1Fpoxz6PJJgo+SBEqzLbcWSs2gqp4Q2ySTw0902tykja6Gx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlRwxbo5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC467C4CEF7;
	Wed, 29 Oct 2025 23:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761779049;
	bh=GpupXLo7thRHRYciDVJ97ynh+x0kfFm663YZnX0nI8Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WlRwxbo5A0KsyuPdG7OaqKqxfsHbzTsVcLPg9RYAfPGgRAsNi3j7kzMI66BHMkHpq
	 CR1ITgW0LUNHhAQUz/97mVt/imgoU+H3IxXKtwMyZJvfcn1TBZJHkC+r7JMSnrOLmF
	 rMui0gaSefyNRIGyNySlrl3cfCD2b89IejssWQJFN7PbLSdCiDmVxt6h++rZYUe5D7
	 CnmT+OKN8xrMAU8JsYhKV1MhKSWbwF+l6aISL+WJ5GVCu1ImHqqH+qVHGaZiW/Gabx
	 jl4Bw+88kOKFV9t4MznIy06sJ/PaITh66IroVBEsViBFFHIjm3pWJvKEa40U+k7enO
	 EU9GcA+17QXDA==
Date: Wed, 29 Oct 2025 18:04:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: James Quinlan <james.quinlan@broadcom.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Cyril Brulebois <kibi@debian.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v3 0/2] PCI: brcmstb: Add panic/die handler to driver
Message-ID: <20251029230408.GA1600876@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <225baaa9-2c7c-4755-a999-3ecadc026509@broadcom.com>

On Wed, Oct 29, 2025 at 05:28:57PM -0400, James Quinlan wrote:
> On 10/28/25 14:07, Bjorn Helgaas wrote:
> > [+cc Ilpo]
> > 
> > On Mon, Oct 20, 2025 at 12:18:48PM +0530, Manivannan Sadhasivam wrote:
> > > On Fri, 03 Oct 2025 15:56:05 -0400, Jim Quinlan wrote:
> > > > v3 Changes:
> > > >    -- Commit "Add a way to indicate if PCIe bridge is active"
> > > >      o Implement Bjorn's V1 suggestion properly (Bjorn, Mani)
> > > >      o Remove unrelated change in commit (Mani)
> > > >      o Remove an "inline" directive (Mani)
> > > >      o s/bridge_on/bridge_in_reset/ (Mani)
> > > >    -- Commit "Add panic/die handler to driver"
> > > >      o dev_err(...) message changed from "handling" error (Mani)
> > > > 
> > > > [...]
> > > Applied, thanks!
> > > 
> > > [1/2] PCI: brcmstb: Add a way to indicate if PCIe bridge is active
> > >        commit: 7dfe1602f6dc96f228403b930dbe0a93717bc287
> > > [2/2] PCI: brcmstb: Add panic/die handler to driver
> > >        commit: 47288064f6a6ce99c3c1fd7b116011b970945273
> > I deferred these for now because there are some open questions that we
> > should resolve first:
> > 
> >    https://lore.kernel.org/r/20251020184832.GA1144646@bhelgaas
> >    https://lore.kernel.org/r/2b0f9620-a105-6e49-f9cb-4bac14e14ce2@linux.intel.com
> 
> Sorry about the delay Bjorn.  Hopefully I've addressed all comments with
> today's V4.

Yep, looks good to me, thanks!

