Return-Path: <linux-pci+bounces-12630-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A53C4968DE2
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 20:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AE581F220D9
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 18:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09601A3A8B;
	Mon,  2 Sep 2024 18:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRGqqhaJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70CE1A3A80;
	Mon,  2 Sep 2024 18:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725303138; cv=none; b=hHvplvaAY4jrqlXHPUvJPABx/+s6F4cxtWp4b9WPiCHLN7sr6nn+dJ9x6IfaxSW0sBWTcn9P96IEPvVYRYFj+QLeDc4Bb/EnEKhZFfSLHCMK48aOjJACf0KLFd0FAwH10wao1k511X0TNqxMXywDapgL/WTTwwD/cZSmcFJAAa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725303138; c=relaxed/simple;
	bh=ZTBb1Jqv4twqEPqg4WYll7AU68w80SabtLii7Xfp5q8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NH+cjwwRUOsUSU9+JZ1tMM2kV7HkrnwV1iKiiQ/m6sY3W5hTuFOWFrIkPt+ix2HNzlAhcseKNE4u1sQGltqhcpzmEl5asssst0stWbxWKgCB1zAYPGPk/Ufp1XxnyZLQ57vj8cH+SDirr6PDj0dIwFwchXPg7UXvwyRnoCCeEkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRGqqhaJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2504C4CEC2;
	Mon,  2 Sep 2024 18:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725303138;
	bh=ZTBb1Jqv4twqEPqg4WYll7AU68w80SabtLii7Xfp5q8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CRGqqhaJWczUqsStEvPv+f7+ot0eBEsbKPjGsicNjQC/PnmqrdNclo0PCUtDQGBSH
	 YPbXBjfJsp7VOk87+VPFUQSK3VnyhXM552C8mqLDxNBofsqJ/uNh6xKkMvKdJPNjp6
	 HoPEn8X79NLULTI824zSgtd6ZuhO5E1cH+PZB+itAr3iCWu0ECnMoxHru1SDGicgB1
	 XX8fYmsvRdwnPEuNNcoxCFrHtDjQ92QCI8cxb8m5ql5NeLk7xHPZq9O9fyioOM3fem
	 6/ran3AAbq6Wm6g/qnNVB9I0WqaF+EgdjPWFL2y1hZl6KbZ2pvlnKk1N/244hAiUbn
	 EONolYYT7V7Gg==
Date: Mon, 2 Sep 2024 13:52:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Lukas Wunner <lukas@wunner.de>, LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 7/7] PCI: Create helper to print TLP Header and Prefix
 Log
Message-ID: <20240902185215.GA223280@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0484353-8ba5-02c2-e78c-d51aba55bbb7@linux.intel.com>

On Mon, Sep 02, 2024 at 08:20:41PM +0300, Ilpo Järvinen wrote:
> On Fri, 30 Aug 2024, Bjorn Helgaas wrote:
> 
> > On Tue, May 14, 2024 at 02:31:09PM +0300, Ilpo Järvinen wrote:
> > > Add pcie_print_tlp_log() helper to print TLP Header and Prefix Log.
> > > Print End-End Prefixes only if they are non-zero.
> > > 
> > > Consolidate the few places which currently print TLP using custom
> > > formatting.
> > > 
> > > The first attempt used pr_cont() instead of building a string first but
> > > it turns out pr_cont() is not compatible with pci_err() and prints on a
> > > separate line. When I asked about this, Andy Shevchenko suggested
> > > pr_cont() should not be used in the first place (to eventually get rid
> > > of it) so pr_cont() is now replaced with building the string first.
> > > 
> > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > ---
> > >  drivers/pci/pci.h      |  2 ++
> > >  drivers/pci/pcie/aer.c | 10 ++--------
> > >  drivers/pci/pcie/dpc.c |  5 +----
> > >  drivers/pci/pcie/tlp.c | 31 +++++++++++++++++++++++++++++++
> > >  4 files changed, 36 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > index 7afdd71f9026..45083e62892c 100644
> > > --- a/drivers/pci/pci.h
> > > +++ b/drivers/pci/pci.h
> > > @@ -423,6 +423,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
> > >  int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
> > >  		      unsigned int tlp_len, struct pcie_tlp_log *log);
> > >  unsigned int aer_tlp_log_len(struct pci_dev *dev);
> > > +void pcie_print_tlp_log(const struct pci_dev *dev,
> > > +			const struct pcie_tlp_log *log, const char *pfx);
> > >  #endif	/* CONFIG_PCIEAER */
> > >  
> > >  #ifdef CONFIG_PCIEPORTBUS
> > > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > > index ecc1dea5a208..efb9e728fe94 100644
> > > --- a/drivers/pci/pcie/aer.c
> > > +++ b/drivers/pci/pcie/aer.c
> > > @@ -664,12 +664,6 @@ static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
> > >  	}
> > >  }
> > >  
> > > -static void __print_tlp_header(struct pci_dev *dev, struct pcie_tlp_log *t)
> > > -{
> > > -	pci_err(dev, "  TLP Header: %08x %08x %08x %08x\n",
> > > -		t->dw[0], t->dw[1], t->dw[2], t->dw[3]);
> > > -}
> > > -
> > >  static void __aer_print_error(struct pci_dev *dev,
> > >  			      struct aer_err_info *info)
> > >  {
> > > @@ -724,7 +718,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
> > >  	__aer_print_error(dev, info);
> > >  
> > >  	if (info->tlp_header_valid)
> > > -		__print_tlp_header(dev, &info->tlp);
> > > +		pcie_print_tlp_log(dev, &info->tlp, "  ");
> > 
> > I see you went to some trouble to preserve the previous output, down
> > to the number of spaces prefixing it.
> > 
> > But more than the leading spaces, I think what people will notice is
> > that previously AER and DPC dmesgs contain the "AER: " or "DPC: "
> > prefixes implicitly added by the dev_fmt definitions [1], where now
> > IIUC they won't.
> > 
> > I think adding dev_fmt("") here should take care of that, e.g.,
> > 
> >   pcie_print_tlp_log(dev, &info->tlp, dev_fmt(""));
> > 
> > [1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1990272
> 
> Okay, I'll fix it and resend but looking into that output, it doesn't 
> look very consistent when it comes to prefixes as the lines in between do 
> not start with "AER: " either. Perhaps those lines should be changed as 
> well?

True.  Possibility for future patches.

