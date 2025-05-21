Return-Path: <linux-pci+bounces-28234-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3340ABFC7E
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 19:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9A04E4D22
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 17:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207CB22C35D;
	Wed, 21 May 2025 17:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RljfERsi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89C414EC62;
	Wed, 21 May 2025 17:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747849515; cv=none; b=OqBGQ1Ey/OxcHdKaWtz9R8gPUfuo4QmOXFNqBJzJ8JtmPd80SJhOKBkLK3vQ+l/gW7zkoQdkYUdnozPVqLSBWnoTHfTRr6eAGLLMsSP2WjwBNtRqfOPu0FsQ+a+sJK5DpqXnlkg5pA0Wo5J51QBgdYYd5hvADCQFEgm0lcGz6A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747849515; c=relaxed/simple;
	bh=V2RuI4M0Yg8yY4cQ1BGXlcPOPaGhDVK1o5Gd0zRxX6s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Z7irmZa1236L9ez0JIw9FIbl6ItLAObycPrI2/Yh87OUNJK8t30aLYIvObAfizNrTZlvscm71Visa3BxNpaA9SLKy/oYM8sgfdqBOgsxUJmmaAgX3e2bP1xk51vIYv6wMDjp5NMeYoVIpR8ZVy/IiW+5iJG/rq7s7s21+a0KolM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RljfERsi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E58C4CEE4;
	Wed, 21 May 2025 17:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747849514;
	bh=V2RuI4M0Yg8yY4cQ1BGXlcPOPaGhDVK1o5Gd0zRxX6s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RljfERsiU7aFbLVKDq5ROTWlQtAUt3TSPdC13pCW+KAEi1HcbnZfIzw3wwGSzwIvd
	 8P43hHIJ/fnuTagraQu1Md6zU6v4R6GHObnrJZFUN6dtwfTb04gdxf/91M/Hn0UAwv
	 /du5mpef0IdqcKAfnJGQjBjx/Qfh3gyesyx9hjbLF6Hdfnnw0BWbkms44iLj/6VOYr
	 VGeS1y4vsazQv4eVJFlNX0uQ2dbPGEWJvQwhaDS/NUbWRVk7XMMUHgnYliFWtqhh+o
	 mkqtpf7voixiQLX/jAX3LS99ryQQoJ3LmPT0vHDX5P6pliW2+H16bQbFLIIeDuRUKh
	 LA0173jC5vRdQ==
Date: Wed, 21 May 2025 12:45:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-pci@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Weinan Liu <wnliu@google.com>,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, Sargun Dhillon <sargun@meta.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v7 13/17] PCI/AER: Make all pci_print_aer() log levels
 depend on error type
Message-ID: <20250521174512.GA1426306@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250521105659.000064bd@huawei.com>

On Wed, May 21, 2025 at 10:56:59AM +0100, Jonathan Cameron wrote:
> On Tue, 20 May 2025 16:50:30 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > From: Karolina Stolarek <karolina.stolarek@oracle.com>
> > 
> > Some existing logs in pci_print_aer() log with error severity by default.
> > Convert them to depend on error type (consistent with rest of AER logging).
> > 
> > Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > Tested-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
> > Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> One comment inline. It is painful to have a non trivial comment
> that says we didn't pass a parameter for 'reason X' when maybe
> it would be simpler to just pass it and not care that it always
> takes the same value?

I agree.  I added a patch to pass the level to pcie_print_tlp_log().

> Either way this is fine.
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > ---
> >  drivers/pci/pcie/aer.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index f5e9961d2c63..4cdcf0ebd86d 100644
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
> 
> I wonder if it's easier to just pass the level in than have the
> comment?
> 
> > +	 */
> >  	if (tlp_header_valid)
> >  		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
> >  }
> 

