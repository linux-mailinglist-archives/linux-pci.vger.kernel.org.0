Return-Path: <linux-pci+bounces-16912-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8C59CF308
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 18:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32231280F10
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 17:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3B71D63FC;
	Fri, 15 Nov 2024 17:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xgr+BHvU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3D61D63CF;
	Fri, 15 Nov 2024 17:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731692145; cv=none; b=P+pgYCtk95QaSWY8ciJVk9uWakUXlJl4puUnt3TXOXzSOgHHHHyN7FAeOhrqZ1vVBeCaXdn81Tw8e6CqDi10CUiFbM6l7nOgg4+eszCugAebw1lB7WiP1dNGYPqwwE7ntTA64NujjwdpGhj5hUITMOja9SefXzt9+wqWdMAskXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731692145; c=relaxed/simple;
	bh=84FTnS/tXEQAO33gnrKTfEaj14PRAW8pWgGeaB/rt18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QS1nFjWCECBXacKuEFgVvC5G8L9HFccUdO+B7H1siV6WNsODnr343tHh6aYilT39Ojdf41mIYoPXHPuM2GVzn79wQmK9jZHjMFdSznEB26hEXNN2ErhzALLFZ48LzLBjkfl1QJVO2Yxn94DZYh2j1bqM1GONl10Hhp4RZglJYvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xgr+BHvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288D9C4CECF;
	Fri, 15 Nov 2024 17:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731692145;
	bh=84FTnS/tXEQAO33gnrKTfEaj14PRAW8pWgGeaB/rt18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xgr+BHvUbyH8re/YwwwIVVIgsEAbgzRz4h4WFyhgL3YguDMOvxnKEeJruFU+d5V63
	 kA1LmV9tHSpnWG8NOi3PCjtmmvUuQhCslJ81aGKth+X2RowUtu0hJ+0n5nkryxihoq
	 rCBtKIk94PfzX2LmZKDAVf1FUXlfLSJbKX9hudKf88IhNopHUKE/FIuWDo//bNLVMo
	 1EzO0Wxh3ULOMXwmfPPDJ/4/NWXeGRjMUG5W1CNkiLBKotVhm9L6zdzDKzGVjYyYRN
	 X1EuKUKyrXRlekBLKK7lJzY97EzQ7L9KdmISaxJjCzNURLa2Qrny8EjI9vzG1fa8Wd
	 Nb9jq2k+INX1Q==
Date: Fri, 15 Nov 2024 18:35:39 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, dlemoal@kernel.org, maz@kernel.org,
	tglx@linutronix.de, jdmason@kudzu.us
Subject: Re: [PATCH v7 3/6] PCI: endpoint: Add pci_epf_align_addr() helper
 for address alignment
Message-ID: <ZzeGa-aWlv6bV3fv@ryzen>
References: <20241114-ep-msi-v7-0-d4ac7aafbd2c@nxp.com>
 <20241114-ep-msi-v7-3-d4ac7aafbd2c@nxp.com>
 <ZzcaA4PMHRcsEaDt@ryzen>
 <Zzd6Kp1mliKGW2m0@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zzd6Kp1mliKGW2m0@lizhi-Precision-Tower-5810>

On Fri, Nov 15, 2024 at 11:43:22AM -0500, Frank Li wrote:
> On Fri, Nov 15, 2024 at 10:53:07AM +0100, Niklas Cassel wrote:
> > On Thu, Nov 14, 2024 at 05:52:39PM -0500, Frank Li wrote:
> > > +static inline int pci_epf_align_addr_lo_hi(struct pci_epf *epf, enum pci_barno bar,
> > > +					   u32 low, u32 high, u64 *base, size_t *off)
> > > +{
> > > +	u64 addr = high;
> > > +
> > > +	addr <<= 32;
> > > +	addr |= low;
> > > +
> > > +	return pci_epf_align_addr(epf, bar, addr, base, off);
> > > +}
> >
> > I'm not sure if this function deserves to live :)
> > Can't the caller just do this before calling pci_epf_align_addr() ?
> 
> Ideally, kernel should have macro to combine 32bit macro to a 64bit, but
> I have not found it.
> 
> It is quite easy to make error or warning by simple
> (high << 32 | low)
> 
> It needs ((u64) high << 32 | low) at least. I just want to avoid everyone
> to struggle simple issue.
> 
> And msi_msg use lo and hi. pci_function_test actually just demostrate how
> to use doorbell. if other function driver use doorbell in future, avoid
> "(u64) high << 32 | low" copy to everywhere.

Keeping the helper is fine with me, but it probably should be renamed
to include _ib_ or _inbound_ in the function name, similar to the comment
for pci_epf_align_addr().


Kind regards,
Niklas

