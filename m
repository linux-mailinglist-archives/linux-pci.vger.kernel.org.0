Return-Path: <linux-pci+bounces-28238-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BB6ABFD75
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 21:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57E68501746
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 19:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC3922F15E;
	Wed, 21 May 2025 19:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbrZJDl8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6218C50276;
	Wed, 21 May 2025 19:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747856360; cv=none; b=RmIR/oaZWnzdLkLHqoy9JWynM7dDS6WQJ83D9gV9XkRwGaFSbIi0ihurqQ68Gce8XJRPyZ/lBMEW01vCx0+xtagB7tXlLEbw31KDvcVaUOBi3CayOMEFXBMRmNpP9xbO3g78eTvW0Q3z/4WuDX41NqPZU0EMvwF3jJ/wLRw4+Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747856360; c=relaxed/simple;
	bh=iZNF7m2weWyRiFFUPmLZk4GdZHibUNgz62DAAiUCwoo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bPaaj2b57EZj3ZJD1xMZbcNQPo2eJ6uhQUxDPzn0wuEGCwwRAIW0O/OErcmFbO8SGpZzji8HjXd5lwtBK4P2+mCveausYkwy2tgHeo17cvAiAUZBJMz3qXuO9J1JjkEVKQAany81Oz9vimeNCTbaq58vvRk5S7fmObIyTutuzP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbrZJDl8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2CAC4CEE4;
	Wed, 21 May 2025 19:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747856359;
	bh=iZNF7m2weWyRiFFUPmLZk4GdZHibUNgz62DAAiUCwoo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qbrZJDl8hYs4Lku2GffW+PA1dRJT33mZGXYDWUqy1XEAWnFGgIxCR/VU/edoGM7jR
	 Wn6XJ8BD/k0hmbud2LPowvgKJ2lvw6100SrAoeiJjNhzkGsuagFV6TQVJROSg6dywZ
	 Bu7NZx6YXBEgJv+dNsVHzrU4/dPS4aJZh+D1r4rR8PELMe7KC8oMEhWTxRKWOSA4in
	 CkCYTQ3nNkq9PPHXSg4ZI5jMLSGIlK9qDWW+el297eCRB9BIuo1ys1JtfIMfH4QYXk
	 poU1Fyxg49UqJGp0Bp1oTyQyciP8K/Z2xkhZU9Gk0NLL/mqyMaxGD1whvAhzM2S7f2
	 a6Y8bJjDD1MPA==
Date: Wed, 21 May 2025 14:39:18 -0500
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
	linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v7 04/17] PCI/AER: Consolidate Error Source ID logging in
 aer_isr_one_error_type()
Message-ID: <20250521193918.GA1437038@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521102041.00004901@huawei.com>

On Wed, May 21, 2025 at 10:20:41AM +0100, Jonathan Cameron wrote:
> On Tue, 20 May 2025 16:50:21 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Previously we decoded the AER Error Source ID in aer_isr_one_error_type(),
> > then again in find_source_device() if we didn't find any devices with
> > errors logged in their AER Capabilities.
> > 
> > Consolidate this so we only decode and log the Error Source ID once in
> > aer_isr_one_error_type().  Add a "details" parameter so we can add a note
> > when we didn't find any downstream devices with errors logged in their AER
> > Capability.
> > 
> > This changes the dmesg logging when we found no devices with errors logged:
> > 
> >   - pci 0000:00:01.0: AER: Correctable error message received from 0000:02:00.0
> >   - pci 0000:00:01.0: AER: found no error details for 0000:02:00.0
> >   + pci 0000:00:01.0: AER: Correctable error message received from 0000:02:00.0 (no details found)
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Nice little improvement.  I'll assume you reuse
> details later as otherwise passing a bool and creating
> the (no details found) in aer_print_port_info() would
> have been simpler to my eyes as it would have put all the
> string generation in one place.

Great idea!  Since there's only one caller, I think passing a bool is
much nicer.

> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > ---
> >  drivers/pci/pcie/aer.c | 22 +++++++++-------------
> >  1 file changed, 9 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index 568229288ca3..488a6408c7a8 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -733,16 +733,17 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
> >  			info->severity, info->tlp_header_valid, &info->tlp);
> >  }
> >  
> > -static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
> > +static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info,
> > +				const char *details)
> >  {
> >  	u8 bus = info->id >> 8;
> >  	u8 devfn = info->id & 0xff;
> >  
> > -	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d\n",
> > +	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d%s\n",
> >  		 info->multi_error_valid ? "Multiple " : "",
> >  		 aer_error_severity_string[info->severity],
> >  		 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
> > -		 PCI_FUNC(devfn));
> > +		 PCI_FUNC(devfn), details);
> >  }
> >  
> >  #ifdef CONFIG_ACPI_APEI_PCIEAER
> > @@ -926,15 +927,8 @@ static bool find_source_device(struct pci_dev *parent,
> >  	else
> >  		pci_walk_bus(parent->subordinate, find_device_iter, e_info);
> >  
> > -	if (!e_info->error_dev_num) {
> > -		u8 bus = e_info->id >> 8;
> > -		u8 devfn = e_info->id & 0xff;
> > -
> > -		pci_info(parent, "found no error details for %04x:%02x:%02x.%d\n",
> > -			 pci_domain_nr(parent->bus), bus, PCI_SLOT(devfn),
> > -			 PCI_FUNC(devfn));
> > +	if (!e_info->error_dev_num)
> >  		return false;
> > -	}
> >  	return true;
> >  }
> >  
> > @@ -1281,9 +1275,11 @@ static inline void aer_process_err_devices(struct aer_err_info *e_info)
> >  static void aer_isr_one_error_type(struct pci_dev *root,
> >  				   struct aer_err_info *info)
> >  {
> > -	aer_print_port_info(root, info);
> > +	bool found;
> >  
> > -	if (find_source_device(root, info))
> > +	found = find_source_device(root, info);
> > +	aer_print_port_info(root, info, found ? "" : " (no details found");
> > +	if (found)
> >  		aer_process_err_devices(info);
> >  }
> >  
> 

