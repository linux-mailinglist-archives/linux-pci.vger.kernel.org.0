Return-Path: <linux-pci+bounces-28117-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A63E2ABDE58
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 17:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C30F3B70DE
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 15:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B23425228E;
	Tue, 20 May 2025 15:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJWU12d6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E9A25228B;
	Tue, 20 May 2025 15:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747753498; cv=none; b=Xu4w5lM8EKKq2hxo/Q0IhsWFAmG1iu8oBgdHY/Ox/6KjhZpIO1E2MehCghPnK64+mKOTqv2EjEi5MAEejExedDHcAx3J+2LfF3gpbeZiJnQno0NASJd8PwGh4WnMkJeXPnVJBo62cvHtXVehFJCc9Iy86T3oCNrzbeymhtG+AT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747753498; c=relaxed/simple;
	bh=386vJl/A+qlhOwBt1iwrNQY1ZNkTiZORVnCA7Xh0ge8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JZxkm17DO/aepYIQSDiEmQozf7pkGPxl5Xuj/0sy92ZDhYHQghajef8sHceSZq7EqjWU1K8h9lhErMYq+thVWHpGd3Ugo/wSTstMEX9YY/bJoOvMsZ0tiQ2N4JJNneIiSNBnvIX5dMhf1Q8T92kUXu+FWgOhL26pRlyCgfxarMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJWU12d6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3729AC4CEEA;
	Tue, 20 May 2025 15:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747753497;
	bh=386vJl/A+qlhOwBt1iwrNQY1ZNkTiZORVnCA7Xh0ge8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VJWU12d62az2Yuj+AiW/gJexWUaLd+pCW0i0fnwxfBu6oNPS2cbTPk9e0zEnP2e0g
	 3nGpWzqsHXcLuOcGrm9iKFo9cj9T9UnWcvukafFN4no84C7QpBSxSPtilNGGkXjt4b
	 UbYDjd7v+cCptdXnJy9doVcR6avpcHvQBe7ZrUawMvCTYGyPsXeQjTP4SHNRuQlsve
	 hhwtDsdkvAiWCPa4y1WlykZAzi7mQmNRu+v+8YjFYZPy8f62HIQAh3nHNFw9CvUv4y
	 kz7ArCrgyOZzwaufLKWg6Xw00fU7H9Tg0ndpU5JMoji2u2qjW4+Se10JoMM72SdyZR
	 WA+Indy/ny7cA==
Date: Tue, 20 May 2025 10:04:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sargun Dhillon <sargun@meta.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 12/16] PCI/AER: Make all pci_print_aer() log levels
 depend on error type
Message-ID: <20250520150455.GA1300985@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <921fea13-9a28-9dc6-90c3-48498626f317@linux.intel.com>

On Tue, May 20, 2025 at 02:37:33PM +0300, Ilpo Järvinen wrote:
> On Mon, 19 May 2025, Bjorn Helgaas wrote:
> 
> > From: Karolina Stolarek <karolina.stolarek@oracle.com>
> > 
> > Some existing logs in pci_print_aer() log with error severity by default.
> > Convert them to depend on error type (consistent with rest of AER logging).
> > 
> > Link: https://lore.kernel.org/r/20250321015806.954866-3-pandoh@google.com
> > Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/pci/pcie/aer.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index 73b03a195b14..06a7dda20846 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -788,15 +788,21 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
> >  	layer = AER_GET_LAYER_ERROR(aer_severity, status);
> >  	agent = AER_GET_AGENT(aer_severity, status);
> >  
> > -	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
> > +	aer_printk(info.level, dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n",
> > +		   status, mask);
> >  	__aer_print_error(dev, &info);
> > -	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
> > -		aer_error_layer[layer], aer_agent_string[agent]);
> > +	aer_printk(info.level, dev, "aer_layer=%s, aer_agent=%s\n",
> > +		   aer_error_layer[layer], aer_agent_string[agent]);
> >  
> >  	if (aer_severity != AER_CORRECTABLE)
> > -		pci_err(dev, "aer_uncor_severity: 0x%08x\n",
> > -			aer->uncor_severity);
> > +		aer_printk(info.level, dev, "aer_uncor_severity: 0x%08x\n",
> > +			   aer->uncor_severity);
> >  
> > +	/*
> > +	 * pcie_print_tlp_log() uses KERN_ERR, but we only call it when
> > +	 * tlp_header_valid is set, and info.level is always KERN_ERR in
> > +	 * that case.
> > +	 */
> >  	if (tlp_header_valid)
> >  		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
> 
> There's another similar callsite but only this has the comment added. I 
> was thinking if this call could be made from __aer_print_error(). There 
> would be small change in order of messages but I can't seem to decide if 
> it would be bad/good.

I guess the other caller is dpc_process_rp_pio_error(), which uses
pci_err() for other logging, so at least it matches the level used by
pcie_print_tlp_log().

This patch uses info.level to control the message level, and
pcie_print_tlp_log() doesn't look at info.level.  I added this comment
to explain why that's OK and the message level happens to match
already.  Maybe not super ideal long term.

