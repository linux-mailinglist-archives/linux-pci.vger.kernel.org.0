Return-Path: <linux-pci+bounces-28233-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FB5ABFC0E
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 19:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBA261BC7880
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 17:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A36264614;
	Wed, 21 May 2025 17:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmtHGiAl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C944E134AC;
	Wed, 21 May 2025 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747847538; cv=none; b=AIRfXR7vYB38vcJthhTfdPOEbHzU0uhFso1JHNMTWOBi5rNMHdksuPweXoP3/lxq+w57zGQQSr1xe56/O2yz5utIzgOyIz8aiT4ghQxozuK9WUE47TtC5eP4EBC16OvQLKqm0YfuQRqxA8CR0aDHdKrtqTr8nwATQtyZQ9z9Gy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747847538; c=relaxed/simple;
	bh=1dN4hypelxyk1rZ8sC/y4l5vwCFStdVU/YluIIrrUYM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IkDB4jF14IkqJydLsY8hkkY4br95ifKocFUF6BrZFSPZ/a3Uj0evWHh3u4hOEJ/zUbjCayEsCYWljuRnjCjmKxvV4kSW6xwwfQu3M7b4fJn9ZZZyNECXurwhzDDbkci4QRaQt2qCouVpiACXmqc05ZVkPXS+JGJ7JwOPfm2ZMi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmtHGiAl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD4CC4CEE4;
	Wed, 21 May 2025 17:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747847537;
	bh=1dN4hypelxyk1rZ8sC/y4l5vwCFStdVU/YluIIrrUYM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jmtHGiAlnJ73/jaSZK1r37Jx1N0d7k8PF5KCtu1Hy4V820AyYSTWjAg0yoFA0tFCA
	 6lLq4B9BFBkUKktlmQ2INKiieLHhVCRp4rMdvSTf4p80Q8oLEeqFxjV1jT7YywOtkt
	 ZoGok5vhnZV6AbGYI2iSvQ+2k0kP8YaySIJYl4GJBA/OLmYrg/XLQpaYJgGOzLJ7K4
	 WbUJhqS0e9qb/uxKJGW4KI+qZCSoikzrQ5ikfl0LhBFTZ7M1+ER61IqMUtcNNQ8WaY
	 Q1FvvrHA8y2Gw8Rx6ZNXI65pOWQZohuoG3l68HI4xP3IhLiTHxTtKp7hqzFc8MXeJc
	 x+IRMvchmNwaw==
Date: Wed, 21 May 2025 12:12:15 -0500
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
Subject: Re: [PATCH v7 11/17] PCI/AER: Combine trace_aer_event() with
 statistics updates
Message-ID: <20250521171215.GA1421937@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250521104642.00003648@huawei.com>

On Wed, May 21, 2025 at 10:46:42AM +0100, Jonathan Cameron wrote:
> On Tue, 20 May 2025 16:50:28 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > As with the AER statistics, we always want to emit trace events, even if
> > the actual dmesg logging is rate limited.
> > 
> > Call trace_aer_event() directly from pci_dev_aer_stats_incr(), where we
> > update the statistics.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > Tested-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
> > Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Hmm. This runs a bit counter to what I liked in previous patch.
> Whilst convenient to issue trace points in the stats update function
> it's not obvious behavior given naming.  Maybe just duplicate the call
> and call it immediately after the pci_dev_aer_stats_incr() calls?

Good point, thanks.  I made this change, which also means we don't
need to copy the header log into "info" because we can just use
aer->header_log as before:

> > @@ -782,6 +782,9 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
> >  
> >  	info.status = status;
> >  	info.mask = mask;
> > +	info.tlp_header_valid = tlp_header_valid;
> > +	if (tlp_header_valid)
> > +		info.tlp = aer->header_log;
> >  
> >  	pci_dev_aer_stats_incr(dev, &info);
> >  
> > @@ -799,9 +802,6 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
> >  
> >  	if (tlp_header_valid)
> >  		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
> > -
> > -	trace_aer_event(pci_name(dev), (status & ~mask),
> > -			aer_severity, tlp_header_valid, &aer->header_log);
> >  }
> >  EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
> >  
> 

