Return-Path: <linux-pci+bounces-35612-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D74E4B47182
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 16:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 963C23B2BE5
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 14:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B40A1C860A;
	Sat,  6 Sep 2025 14:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBqDCaiM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B573FBB3;
	Sat,  6 Sep 2025 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757170443; cv=none; b=uDgp7qUaYt9vqKCXLT31H4jbkxl7dCYeaLYcvarGXb1pjMQDuNbxlHWnY5F3CH//KLuTGUiocb7S5INaos0jwrXYuI0K7FWbZNSE9kFihGfz0UbOlVlHPQIqjZs1tDlkMibXD5M56msUbGd2bIoFwqIOtRp+NGhvEgRTcmcFnwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757170443; c=relaxed/simple;
	bh=9lGK3si2C+6VrnNOpedp6M1LTDiz7pJw+iJuj1mVc8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmXJcv4Yr76Nxj7i6H2UlgVL6nnhQVj052Qj6QETY1b0PYubhOq12mvAZm5vOPPkA1RpHQGVY1NoX7xwvb/DBEZIzPoJmHGksqa21I4jmnWKuXXNjy8+2pGOZweJxGh452WOtnOwrFTMQkL0CqMV8kfYJytFkfnNx9zk7PRwLZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBqDCaiM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B723BC4CEE7;
	Sat,  6 Sep 2025 14:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757170442;
	bh=9lGK3si2C+6VrnNOpedp6M1LTDiz7pJw+iJuj1mVc8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EBqDCaiM+rFCZzSGqiDnmVRE5l5WyyF/DHEzciVNr/+bl+7y+3ROTm1DIid5X6XWE
	 JNcs+Sxe6Sx4K2TZvwxjwudbYI1vZAtGqWhfddeLmJzfU3LZY8qhq4CCiUat7vJGnU
	 v3ieSDu/GoiJa4ADqLsCBvxtlsVwPPSXGHJmbEubiQ1CjC0ov0D2OBdZjzVd0We51C
	 1RRpZgNzawJHLL9Mw4Vs68S+ecZiWFdKw9whXF/kwuR6aSqhx9HyQefRp/SPDngL2s
	 6BLhEyMeKox4EghELP1m7+16dIRBauBkcm9+C+SKCCdm13+wpg2e69GbYKwqnljL/3
	 9y/cMWMF7/4Bg==
Date: Sat, 6 Sep 2025 20:23:52 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	David Box <david.e.box@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Nirmal Patel <nirmal.patel@linux.intel.com>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath12k@lists.infradead.org, ath11k@lists.infradead.org, ath10k@lists.infradead.org, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 2/8] PCI/ASPM: Fix the behavior of
 pci_enable_link_state*() APIs
Message-ID: <67274gnjp4qy4h3bcawey2edmjiuufdbm262q2qxgcc76dwlic@hdjxqczr54nt>
References: <20250825-ath-aspm-fix-v2-0-61b2f2db7d89@oss.qualcomm.com>
 <20250825-ath-aspm-fix-v2-2-61b2f2db7d89@oss.qualcomm.com>
 <f644fc83-31cc-1f0e-58cf-7c007e6173e4@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f644fc83-31cc-1f0e-58cf-7c007e6173e4@linux.intel.com>

On Tue, Aug 26, 2025 at 03:55:42PM GMT, Ilpo Järvinen wrote:
> +David
> 
> On Mon, 25 Aug 2025, Manivannan Sadhasivam via B4 Relay wrote:
> 
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > 
> > pci_enable_link_state() and pci_enable_link_state_locked() APIs are
> > supposed to be symmectric with pci_disable_link_state() and
> > pci_disable_link_state_locked() APIs.
> > 
> > But unfortunately, they are not symmetric. This behavior was mentioned in
> > the kernel-doc of these APIs:
> > 
> > " Clear and set the default device link state..."
> > 
> > and
> > 
> > "Also note that this does not enable states disabled by
> > pci_disable_link_state()"
> > 
> > These APIs won't enable all the states specified by the 'state' parameter,
> > but only enable the ones not previously disabled by the
> > pci_disable_link_state*() APIs. But this behavior doesn't align with the
> > naming of these APIs, as they give the impression that these APIs will
> > enable all the specified states.
> > 
> > To resolve this ambiguity, allow these APIs to enable the specified states,
> > regardeless of whether they were previously disabled or not. This is
> > accomplished by clearing the previously disabled states from the
> > 'link::aspm_disable' parameter in __pci_enable_link_state() helper. Also,
> > reword the kernel-doc to reflect this behavior.
> > 
> > The current callers of pci_enable_link_state_locked() APIs (vmd and
> > pcie-qcom) did not disable the ASPM states before calling this API. So it
> > is evident that they do not depend on the previous behavior of this API and
> > intend to enable all the specified states.
> 
> While it might be "safe" in the sense that ->aspm_disable is not set by 
> anything, I'm still not sure if overloading this function for two 
> different use cases is a good idea.
> 

Why? I thought your concern was with the callers of this API. Since that is
taken care, do you have any other concerns?

> I'd like to hear David's opinion on this as he grasps the ->aspm_default 
> vs ->aspm_disable thing much better than I do.
> 
> > And the other API, pci_enable_link_state() doesn't have a caller for now,
> > but will be used by the 'atheros' WLAN drivers in the subsequent commits.
> > 
> > Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> This tag sound like I'm endorsing this approach which is not the case. I'd 
> prefer separate functions for each use case, setting aspm_default and 
> another for the enable state.
> 

Sorry, I misunderstood then. I'll drop this tag.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

