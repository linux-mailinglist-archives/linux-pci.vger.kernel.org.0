Return-Path: <linux-pci+bounces-3063-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 254FF8483D5
	for <lists+linux-pci@lfdr.de>; Sat,  3 Feb 2024 06:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF49F281C0A
	for <lists+linux-pci@lfdr.de>; Sat,  3 Feb 2024 05:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2443410795;
	Sat,  3 Feb 2024 05:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SbS81VZA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E100A10A05;
	Sat,  3 Feb 2024 05:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706936405; cv=none; b=P5ovPdUiYgtfwRWcJmZg6ZZcoNB/5q2u2BZtMyGpV6mInapeeGsCYnVA17jToVdcxmQgt+IBvweeWGeC2BbCiDyrbWHuvnL/nsPIl0jwZ/HeWGz11Jv2GxrsHQfXOmDacAw3g13jS3ywFnaOjhAi8bkgETEH7T9VEiJISm9HtXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706936405; c=relaxed/simple;
	bh=kf32GCMyGnr3JaXaP9xyzsdixQItASwsYvGjp9HHTXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TB3y9Q0AUKKVb81CWMomeMCriqKxy4XpouzMXA2tLPBvt3z0yBskKZ6+SPIMfDpdAzeBGQuYFzbOVTCKjpljOnJBvKTZc8veuCMBa9JFVnTYrp0nndeXy7Cx/wc2PMNaFonVxY3aVHB1OnIcOKAfwIvLJ5RlUDn70t3dBL7zEc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SbS81VZA; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706936403; x=1738472403;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kf32GCMyGnr3JaXaP9xyzsdixQItASwsYvGjp9HHTXk=;
  b=SbS81VZAv5S+EOobk9KXTvNfPX/6dpAqB9C0l48s2CHCgT0WwbEaxH56
   mkMlP96PqtoPb+Aiu0R5Zu0LxFa2gVw4l2gpk8AxZQdu9bM58A/H11+PD
   MbZw3xVTzOF7OyA3oXfaHY3NqkubvLu9VELFJdWxdXQ4oVCZbpGmtSIqJ
   2np2EvhQlQIt0CEFkH0b9e0WMgyRUlfUP9gw0GA347QDessqWFGvUcoMk
   GqnHiOns927QYRkwBGlf0APC95leddZNASZ7ZsXhLfWVM02uCoqSSMUKB
   5GGvaWF3Htm0RYxIhOH1MTmi6ECTGDNWsbZ3GBFfkn5i8b0eDrkpauOrA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="193956"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="193956"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 21:00:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="4864772"
Received: from yanqiu-mobl.ccr.corp.intel.com (HELO localhost) ([10.254.214.166])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 20:59:53 -0800
Date: Sat, 3 Feb 2024 12:59:44 +0800
From: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-acpi@vger.kernel.org, chao.p.peng@linux.intel.com, erwin.tsaur@intel.com, 
	feiting.wanyan@intel.com, qingshun.wang@intel.com, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, 
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Shiju Jose <shiju.jose@huawei.com>, 
	Adam Preble <adam.c.preble@intel.com>, Li Yang <leoyang.li@nxp.com>, Lukas Wunner <lukas@wunner.de>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, 
	Robert Richter <rrichter@amd.com>, linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-edac@vger.kernel.org
Subject: Re: [PATCH v2 3/4] PCI/AER: Fetch information for FTrace
Message-ID: <7ajtd5skxgfkkwolsbxrd7y2yzfjsikffkg4shxvpumconc2rz@i7hk4gvirrx2>
References: <20240125062802.50819-1-qingshun.wang@linux.intel.com>
 <20240125062802.50819-4-qingshun.wang@linux.intel.com>
 <65bd2e04aed44_2d43c29463@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65bd2e04aed44_2d43c29463@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Fri, Feb 02, 2024 at 10:01:40AM -0800, Dan Williams wrote:
> Wang, Qingshun wrote:
> > Fetch and store the data of 3 more registers: "Link Status", "Device
> > Control 2", and "Advanced Error Capabilities and Control". This data is
> > needed for external observation to better understand ANFE.
> > 
> > Signed-off-by: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
> > ---
> >  drivers/acpi/apei/ghes.c |  8 +++++++-
> >  drivers/cxl/core/pci.c   | 11 ++++++++++-
> >  drivers/pci/pci.h        |  4 ++++
> >  drivers/pci/pcie/aer.c   | 26 ++++++++++++++++++++------
> >  include/linux/aer.h      |  6 ++++--
> >  5 files changed, 45 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > index 6034039d5cff..047cc01be68c 100644
> > --- a/drivers/acpi/apei/ghes.c
> > +++ b/drivers/acpi/apei/ghes.c
> > @@ -594,7 +594,9 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
> >  	if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
> >  	    pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO) {
> >  		struct pcie_capability_regs *pcie_caps;
> > +		u16 device_control_2 = 0;
> >  		u16 device_status = 0;
> > +		u16 link_status = 0;
> >  		unsigned int devfn;
> >  		int aer_severity;
> >  		u8 *aer_info;
> > @@ -619,7 +621,9 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
> >  
> >  		if (pcie_err->validation_bits & CPER_PCIE_VALID_CAPABILITY) {
> >  			pcie_caps = (struct pcie_capability_regs *)pcie_err->capability;
> > +			device_control_2 = pcie_caps->device_control_2;
> >  			device_status = pcie_caps->device_status;
> > +			link_status = pcie_caps->link_status;
> >  		}
> >  
> >  		aer_recover_queue(pcie_err->device_id.segment,
> > @@ -627,7 +631,9 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
> >  				  devfn, aer_severity,
> >  				  (struct aer_capability_regs *)
> >  				  aer_info,
> > -				  device_status);
> > +				  device_status,
> > +				  link_status,
> > +				  device_control_2);
> >  	}
> >  #endif
> >  }
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index 9111a4415a63..3aa57fe8db42 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -903,7 +903,9 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
> >  	struct aer_capability_regs aer_regs;
> >  	struct cxl_dport *dport;
> >  	struct cxl_port *port;
> > +	u16 device_control_2;
> >  	u16 device_status;
> > +	u16 link_status;
> >  	int severity;
> >  
> >  	port = cxl_pci_find_port(pdev, &dport);
> > @@ -918,10 +920,17 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
> >  	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
> >  		return;
> >  
> > +	if (pcie_capability_read_word(pdev, PCI_EXP_DEVCTL2, &device_control_2))
> > +		return;
> > +
> >  	if (pcie_capability_read_word(pdev, PCI_EXP_DEVSTA, &device_status))
> >  		return;
> >  
> > -	pci_print_aer(pdev, severity, &aer_regs, device_status);
> > +	if (pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &link_status))
> > +		return;
> > +
> > +	pci_print_aer(pdev, severity, &aer_regs, device_status,
> > +		      link_status, device_control_2);
> 
> Rather than complicate the calling convention of pci_print_aer(), update
> the internals of pci_print_aer() to get these extra registers, or
> provide a new wrapper interface that satisfies the dependencies and
> switch users over to that.  Otherwise multiple touches of the same code
> path in one patch set is indicative of the need for a higher level
> helper.

Thanks for the advice, it does make sense. Will reconsider the
implementation.

--
Best regards,
Wang, Qingshun

