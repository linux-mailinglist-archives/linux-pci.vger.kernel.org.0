Return-Path: <linux-pci+bounces-28110-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C19B9ABDB90
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 16:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B64AA4C6D59
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 14:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252B6242D9A;
	Tue, 20 May 2025 14:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxPz/9Kl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED80DEEDE;
	Tue, 20 May 2025 14:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749937; cv=none; b=V+9t32Gp77MCzhYCeZxi3TJZxamp36hGEjRJdF9Tq/tDscDvhTRkvbPykd3VppC0OvvucoGynUgrrg7Cn5qhY0ufDWveKW7Iq58RRsdmvCYlRENMFjaL1B8eL4xpYAYhxxAUAMb9Y7iyfOdW5kvDsLjXr4i7q1VPXwLpfbPfn3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749937; c=relaxed/simple;
	bh=Aw0u5qiCrfy3PtV1eC5TuUu69ReE3gjbZ+S8PG4ER8c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nujCBHrtIL3UsWX/sb+VBGgFuHegTN0QVU+bIqdpEUa8TdxfNZ/bEKbfxudzwW2WPV+ajh0ePRTD10i+PtUZiGjttKK9/qF96hGzg28QwStjc6CZ8eYo8sIYVoHpp3+FlWvgAlIjeCpWaFGAkK8ZqKTDvZMieoGNQoqLFYduVG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxPz/9Kl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFDCC4CEEB;
	Tue, 20 May 2025 14:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747749936;
	bh=Aw0u5qiCrfy3PtV1eC5TuUu69ReE3gjbZ+S8PG4ER8c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lxPz/9KlwyaHpGSsfVSURFLpXxfxw+Wg3IaN5utk3Eq0AVYoy3LtaneRXZ0JNEAC/
	 1E7refYyMYzV+n0YiKmb64U2ozIsV+TT3LjGVDcComg4d7wJDHL3SfxvGalQNK5voZ
	 taT1mG7iqbBgrcXQZOYDYomma+RuLqbYtOmUayWHf5vGfVN1IW/eh8W5w9inEtLUNd
	 YHTF9z+FNVDCtaF9Z7KPV4z9BWXmAeaoL1iDmcxFdgtYIM8h2tFLZl7w5O755mvlOC
	 fX09j3zRmI9ibRN+Od5lIABbKztTq0ECUMNecZByaBMs57l/pMAZPbvVrMbCzg/uIU
	 0KFGwVebeygmg==
Date: Tue, 20 May 2025 09:05:35 -0500
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
Subject: Re: [PATCH v6 02/16] PCI/DPC: Log Error Source ID only when valid
Message-ID: <20250520140535.GA1291979@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6ba76ff-7cbd-2d73-fdc4-41aa8c788bc9@linux.intel.com>

On Tue, May 20, 2025 at 01:28:02PM +0300, Ilpo Järvinen wrote:
> On Mon, 19 May 2025, Bjorn Helgaas wrote:
> > DPC Error Source ID is only valid when the DPC Trigger Reason indicates
> > that DPC was triggered due to reception of an ERR_NONFATAL or ERR_FATAL
> > Message (PCIe r6.0, sec 7.9.14.5).
> > 
> > When DPC was triggered by ERR_NONFATAL (PCI_EXP_DPC_STATUS_TRIGGER_RSN_NFE)
> > or ERR_FATAL (PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE) from a downstream device,
> > log the Error Source ID (decoded into domain/bus/device/function).  Don't
> > print the source otherwise, since it's not valid.
> > 
> > For DPC trigger due to reception of ERR_NONFATAL or ERR_FATAL, the dmesg
> > logging changes:
> > 
> >   - pci 0000:00:01.0: DPC: containment event, status:0x000d source:0x0200
> >   - pci 0000:00:01.0: DPC: ERR_FATAL detected
> >   + pci 0000:00:01.0: DPC: containment event, status:0x000d, ERR_FATAL received from 0000:02:00.0
> > 
> > and when DPC triggered for other reasons, where DPC Error Source ID is
> > undefined, e.g., unmasked uncorrectable error:
> > 
> >   - pci 0000:00:01.0: DPC: containment event, status:0x0009 source:0x0200
> >   - pci 0000:00:01.0: DPC: unmasked uncorrectable error detected
> >   + pci 0000:00:01.0: DPC: containment event, status:0x0009: unmasked uncorrectable error detected
> > 
> > Previously the "containment event" message was at KERN_INFO and the
> > "%s detected" message was at KERN_WARNING.  Now the single message is at
> > KERN_WARNING.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/pci/pcie/dpc.c | 45 ++++++++++++++++++++++++++----------------
> >  1 file changed, 28 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> > index fe7719238456..315bf2bfd570 100644
> > --- a/drivers/pci/pcie/dpc.c
> > +++ b/drivers/pci/pcie/dpc.c
> > @@ -261,25 +261,36 @@ void dpc_process_error(struct pci_dev *pdev)
> >  	struct aer_err_info info = { 0 };
> >  
> >  	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
> > -	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &source);
> > -
> > -	pci_info(pdev, "containment event, status:%#06x source:%#06x\n",
> > -		 status, source);
> >  
> >  	reason = status & PCI_EXP_DPC_STATUS_TRIGGER_RSN;
> > -	ext_reason = status & PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT;
> > -	pci_warn(pdev, "%s detected\n",
> > -		 (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_UNCOR) ?
> > -		 "unmasked uncorrectable error" :
> > -		 (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_NFE) ?
> > -		 "ERR_NONFATAL" :
> > -		 (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE) ?
> > -		 "ERR_FATAL" :
> > -		 (ext_reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_RP_PIO) ?
> > -		 "RP PIO error" :
> > -		 (ext_reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_SW_TRIGGER) ?
> > -		 "software trigger" :
> > -		 "reserved error");
> > +
> > +	switch (reason) {
> > +	case PCI_EXP_DPC_STATUS_TRIGGER_RSN_UNCOR:
> > +		pci_warn(pdev, "containment event, status:%#06x: unmasked uncorrectable error detected\n",
> > +			 status);
> > +		break;
> > +	case PCI_EXP_DPC_STATUS_TRIGGER_RSN_NFE:
> > +	case PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE:
> > +		pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID,
> > +				     &source);
> > +		pci_warn(pdev, "containment event, status:%#06x, %s received from %04x:%02x:%02x.%d\n",
> > +			 status,
> > +			 (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE) ?
> > +				"ERR_FATAL" : "ERR_NONFATAL",
> > +			 pci_domain_nr(pdev->bus), PCI_BUS_NUM(source),
> > +			 PCI_SLOT(source), PCI_FUNC(source));
> > +		return;
> > +	case PCI_EXP_DPC_STATUS_TRIGGER_RSN_IN_EXT:
> > +		ext_reason = status & PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT;
> > +		pci_warn(pdev, "containment event, status:%#06x: %s detected\n",
> > +			 status,
> > +			 (ext_reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_RP_PIO) ?
> > +			 "RP PIO error" :
> > +			 (ext_reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_SW_TRIGGER) ?
> > +			 "software trigger" :
> > +			 "reserved error");
> > +		break;
> > +	}
> >  
> >  	/* show RP PIO error detail information */
> >  	if (pdev->dpc_rp_extensions &&
> 
> After adding that switch (reason) there, wouldn't it make sense to move 
> also the code from the if blocks into the case blocks? That if 
> conditions check for reason anyway so those if branches would naturally 
> belong under one of the cases each.

Great idea, thanks!

