Return-Path: <linux-pci+bounces-35613-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1839FB47217
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 17:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79E237B14C7
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 15:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EA2217666;
	Sat,  6 Sep 2025 15:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKYW6YY4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED5C139D1B;
	Sat,  6 Sep 2025 15:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757173074; cv=none; b=nHZ7AXT9GKtETbu0qGPjSo0hwHKv6FQpSF7AFrYZI7h3FtkC0M8VMyYwCzvkMJK4bwrxJssmaY66NKWBJFH3cgUfh+lwnnK6dK5h0gqV/A8wCDwyNSwrCk10kqCtqcnbfB9DBcumEDlHkZHHC9XM2RzHXh7ia7MdKo9mOIPGDEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757173074; c=relaxed/simple;
	bh=eXqndn9A8d2Q3IcwKZULqQ6qeZg1mGIiF7oNPpimTcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ha1wdfJ6g4mqEpx+YsEzt7AdhR86UJQMFCCMWb2aZWoLO1KePEC5gWohv63liQWlAL6un/95jaEgw+PRTTXQF4NQa+0MeN//RNsVc7cmg1LYbINnEQ0Mdbt89DOonGKrehnp3nJ6gMsNNQAKQzgwFEYc+TJ/HiBG4kxwKP2q7FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKYW6YY4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A68CC4CEE7;
	Sat,  6 Sep 2025 15:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757173074;
	bh=eXqndn9A8d2Q3IcwKZULqQ6qeZg1mGIiF7oNPpimTcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YKYW6YY4tPWJv/ZQnUeI7fcMKU9JzBDQphos9U2d7sKnANJLDyHq1ldi0w9Sjku4e
	 Fz2M1qvzLf/EtldVTmcS/gO521zho7kqkI8nmM05fkADBS3yqKloP687Nfn+FFs4tm
	 YqQcQbRcNiObYnSfl7OzCPDmmGgl/FWo+9KNXB29m9GpEOkCWLbkA93+t6471MbOSO
	 Op7z7I+xx8muUcjETfDWg+qSseX9cMYIBraD6Q1C52jHzbYzF3l4nqhw8cWYnM6A//
	 cp2+xaeBLuh1ozk1JXv/5knstboMxTQKUkAzEEOAl+5w3CsrB9uDv/GJmIHzrOFeIE
	 ruveltpRtbCtg==
Date: Sat, 6 Sep 2025 21:07:41 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: David Box <david.e.box@linux.intel.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Nirmal Patel <nirmal.patel@linux.intel.com>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath12k@lists.infradead.org, ath11k@lists.infradead.org, ath10k@lists.infradead.org, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 2/8] PCI/ASPM: Fix the behavior of
 pci_enable_link_state*() APIs
Message-ID: <rci6ku374tvbco2leey3ccyjf4r6bfa6mdksasn2c26v2a5ydc@xqbccsco3x5o>
References: <20250825-ath-aspm-fix-v2-0-61b2f2db7d89@oss.qualcomm.com>
 <20250825-ath-aspm-fix-v2-2-61b2f2db7d89@oss.qualcomm.com>
 <f644fc83-31cc-1f0e-58cf-7c007e6173e4@linux.intel.com>
 <qfw7nv53hmy6whxnf4zqfdtvjzkdxkvxn7eghuxzuuojmvxl34@sxw2jvxze4wm>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qfw7nv53hmy6whxnf4zqfdtvjzkdxkvxn7eghuxzuuojmvxl34@sxw2jvxze4wm>

On Tue, Aug 26, 2025 at 02:24:05PM GMT, David Box wrote:
> On Tue, Aug 26, 2025 at 03:55:42PM +0300, Ilpo Järvinen wrote:
> > +David
> > 
> > On Mon, 25 Aug 2025, Manivannan Sadhasivam via B4 Relay wrote:
> > 
> > > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > 
> > > pci_enable_link_state() and pci_enable_link_state_locked() APIs are
> > > supposed to be symmectric with pci_disable_link_state() and
> > > pci_disable_link_state_locked() APIs.
> > > 
> > > But unfortunately, they are not symmetric. This behavior was mentioned in
> > > the kernel-doc of these APIs:
> > > 
> > > " Clear and set the default device link state..."
> > > 
> > > and
> > > 
> > > "Also note that this does not enable states disabled by
> > > pci_disable_link_state()"
> > > 
> > > These APIs won't enable all the states specified by the 'state' parameter,
> > > but only enable the ones not previously disabled by the
> > > pci_disable_link_state*() APIs. But this behavior doesn't align with the
> > > naming of these APIs, as they give the impression that these APIs will
> > > enable all the specified states.
> > > 
> > > To resolve this ambiguity, allow these APIs to enable the specified states,
> > > regardeless of whether they were previously disabled or not. This is
> > > accomplished by clearing the previously disabled states from the
> > > 'link::aspm_disable' parameter in __pci_enable_link_state() helper. Also,
> > > reword the kernel-doc to reflect this behavior.
> > > 
> > > The current callers of pci_enable_link_state_locked() APIs (vmd and
> > > pcie-qcom) did not disable the ASPM states before calling this API. So it
> > > is evident that they do not depend on the previous behavior of this API and
> > > intend to enable all the specified states.
> > 
> > While it might be "safe" in the sense that ->aspm_disable is not set by 
> > anything, I'm still not sure if overloading this function for two 
> > different use cases is a good idea.
> > 
> > I'd like to hear David's opinion on this as he grasps the ->aspm_default 
> > vs ->aspm_disable thing much better than I do.
> 
> The concern I see is that this would override the init-time blacklist which is
> set in pcie_aspm_sanity_check() and only consulted during initialization.
> __pci_disable_link_state() doesn't do this. It ORs in bits to aspm_disable.  By
> contrast, this change would clear bits from aspm_disable in the enable path,
> which allows ASPM to be enabled on links that pcie_aspm_sanity_check()
> determined should be disabled.
> 
> But I noticed the sysfs path, aspm_attr_store_common(), already permits this
> override. That may be unintentional though since the comment in
> pcie_aspm_sanity_check() implies the blacklist can only be overridden with
> pcie_aspm=force. At minimum, that needs to be clarified.
> 

Thanks for pointing out the blacklist devices issue. I have no concerns with
pcie-qcom as we are going to drop the pci_enable_link_state_locked() API anyway
from it. But I'm not sure about VMD as one may still connect pre 1.1 device to
it and observe issues.

So I'll create a separate API for this new behavior and use it with ath drivers
only since they know what kind of devices they are dealing with and since they
were changing the LNKCTL manually, there shouldn't be any issue.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

