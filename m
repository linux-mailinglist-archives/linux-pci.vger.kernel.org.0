Return-Path: <linux-pci+bounces-28115-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D67ABDD6C
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 16:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B09DE3A5074
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 14:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A1E19F137;
	Tue, 20 May 2025 14:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzjmbZLl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF4F1EA7FF;
	Tue, 20 May 2025 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747751923; cv=none; b=T83lq+iY+k231dptrAtO+pBiDHeDS3rd0SINKRPfTpAdMJir6flp2hAFBFunu/tvZlHlhuvobUgi0IxhHgjaEWq8tqYQU6+pHqhbfr/8qpU+pf0Sum/6C1flZ2HJnzkcYraCmhqcFCvXsPZEsv+voFTrL+tYujj62BsGoGSUlvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747751923; c=relaxed/simple;
	bh=9hZ98IY5t69NRybclTeywqNeLTwH6jYGal0hHUhxo9s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=G8Zeda06RZE61ey6EEklwKPWt5D4KeVTgD8D4MpF/9j2rfgT1PZSL/3TZ6ervCAmyK4nAVoJF/XPIVa4yjjLW4qXecZyDL7tW19uDo8bRgO4ZXafwxlArpk1Pwy7It/I9LDSkZH2oyFLcPdDAylwks+lrElxl+7roGZzd/svouQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzjmbZLl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D316C4CEE9;
	Tue, 20 May 2025 14:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747751922;
	bh=9hZ98IY5t69NRybclTeywqNeLTwH6jYGal0hHUhxo9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rzjmbZLlJFEQL80Af1kv/lGr7QRedncFHbnWG5o8x9U+egfPJa4cYvf+b6pFrJfGo
	 Uyewa5KEnynZb7r9rMySE6KBaWk+Xt1WZmBLDmp2EbpaU0cDcMl+DX0/XaIksGdxM7
	 o3pY68jW2YCdcuPF6D6RuzmOFmMQ5PZOVWIT/Y9XnNE5ZkvlVK5y/2tMQU0KYe8oHl
	 vRS60U97cfYMVhfEcbWL8d2JLORClhS0aMpix5IWzW7GSHlxuKuUCodaz7AuhYop+v
	 NDLQiod+cZjClVvn43PouWT5pRdxl4vk4ejJNo8C3Oc6dpMz9ClMAPHT/Pc6d5X9J2
	 +foqXJC/ONzQw==
Date: Tue, 20 May 2025 09:38:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
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
	Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 08/16] PCI/AER: Simplify pci_print_aer()
Message-ID: <20250520143841.GA1298026@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89d93eb8-ad95-4ac4-b0dc-44b37c458d91@linux.intel.com>

On Mon, May 19, 2025 at 05:02:28PM -0700, Sathyanarayanan Kuppuswamy wrote:
> On 5/19/25 2:35 PM, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Simplify pci_print_aer() by initializing the struct aer_err_info "info"
> > with a designated initializer list (it was previously initialized with
> > memset()) and using pci_name().
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >   drivers/pci/pcie/aer.c | 16 ++++++++--------
> >   1 file changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index 40f003eca1c5..73d618354f6a 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -765,7 +765,10 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
> >   {
> >   	int layer, agent, tlp_header_valid = 0;
> >   	u32 status, mask;
> > -	struct aer_err_info info;
> 
> You have cleaned up other stack allocations of struct aer_err_info to zero
> initialization in your previous patches. Why not follow the same format
> here? I don't think this function resets all fields of aer_err_info, right?

This is new to me, but IIUC this does initialize all the fields.
https://gcc.gnu.org/onlinedocs/gcc/Designated-Inits.html says "Omitted
fields are implicitly initialized the same as for objects that have
static storage duration."

> > +	struct aer_err_info info = {
> > +		.severity = aer_severity,
> > +		.first_error = PCI_ERR_CAP_FEP(aer->cap_control),
> > +	};
> >   	if (aer_severity == AER_CORRECTABLE) {
> >   		status = aer->cor_status;
> > @@ -776,14 +779,11 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
> >   		tlp_header_valid = status & AER_LOG_TLP_MASKS;
> >   	}
> > -	layer = AER_GET_LAYER_ERROR(aer_severity, status);
> > -	agent = AER_GET_AGENT(aer_severity, status);
> > -
> > -	memset(&info, 0, sizeof(info));
> > -	info.severity = aer_severity;
> >   	info.status = status;
> >   	info.mask = mask;
> > -	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
> > +
> > +	layer = AER_GET_LAYER_ERROR(aer_severity, status);
> > +	agent = AER_GET_AGENT(aer_severity, status);
> >   	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
> >   	__aer_print_error(dev, &info);
> > @@ -797,7 +797,7 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
> >   	if (tlp_header_valid)
> >   		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
> > -	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
> > +	trace_aer_event(pci_name(dev), (status & ~mask),
> >   			aer_severity, tlp_header_valid, &aer->header_log);
> >   }
> >   EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
> 

