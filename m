Return-Path: <linux-pci+bounces-22051-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35780A40389
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 00:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 388207A89F1
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 23:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AA820A5EE;
	Fri, 21 Feb 2025 23:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9/+cK7b"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BB918DB0B;
	Fri, 21 Feb 2025 23:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740180998; cv=none; b=RyJiyfKpjfmq9yDIwMy+vKAMRQkHPZEA/u+3facS9nVNprPbZVVcnGBL9YZCLkvKlsE4BJTk8To8vCujt/8T7azc75aCfto0dzi+CMq2EmME9GOK30BNW/7yOzYZfVZoXRRP1x2wJYxRHcGe8AnhswfJaShKvqamb9xTsFTtBpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740180998; c=relaxed/simple;
	bh=Fzra3LTozAg1Caf4BQdZdGPzv/rLipAz4636FFpafrU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=t1ZQc5ZJ0Y3lMPLLX/Cel3cy+mpzO2oeZOouAowKE2YAVURN5+643ZPEcxgXUqx6wKy0vvLXYrB/Yf7skZ8Po+cvaU+sgu9RgFbgy8UWNnX+TTX5KkfRvW7voTo+C0FUffIitjO36a11PlfeM0ldbTzPTCnzCTCg9AydNIti9UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9/+cK7b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51352C4CED6;
	Fri, 21 Feb 2025 23:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740180997;
	bh=Fzra3LTozAg1Caf4BQdZdGPzv/rLipAz4636FFpafrU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=I9/+cK7b5Os9EJJvA+A2tT1AI7MEU4cYE2uHhPjbpxsWOSlQTNv7ei/j1775SGlo7
	 ATSaK5KEAOB2X/UFUrMBrRZw/0d73yTA+sAciJ8otQ9st328UxrgVn99TAqt5Mx7cT
	 pQHY5nP52ubmB8bb3AlUUQx1P1tkSk5C1x1JsTI5/ZmZYL7NMq9zW1EDX2PQ5L+PO3
	 ohat8UVjy5+3iKyDcctjf3+3mj49C52dWekRYoV82Jua7pFMxW9BM368BdafOizLSF
	 W3bWwocINj4nXShXAUJC38RGtOzDHGaqveXWXD0aQ16R3vH4njRK0hSU3blbCBKra3
	 wx93WhKB7/a6Q==
Date: Fri, 21 Feb 2025 17:36:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v2 1/2] PCI: Track Flit Mode Status & print it with link
 status
Message-ID: <20250221233635.GA372807@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250221152948.GA926653@yaz-khff2.amd.com>

On Fri, Feb 21, 2025 at 10:29:48AM -0500, Yazen Ghannam wrote:
> On Fri, Feb 07, 2025 at 06:18:35PM +0200, Ilpo Järvinen wrote:
> > PCIe r6.0 added Flit mode that mainly alters HW behavior but some OS
> > visible changes are also because of it. The OS visible changes include
> 
> The first sentence reads oddly. Maybe a slight change?
> 
> "...but there are some OS visible changes because of it."

Updated locally.

> > +	if (dev->bus && dev->bus->flit_mode)
> > +		flit_mode = ", in Flit mode";
> > +
> >  	if (bw_avail >= bw_cap && verbose)
> > -		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth (%s x%d link)\n",
> > +		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth (%s x%d link)%s\n",
> >  			 bw_cap / 1000, bw_cap % 1000,
> > -			 pci_speed_string(speed_cap), width_cap);
> > +			 pci_speed_string(speed_cap), width_cap, flit_mode);
> >  	else if (bw_avail < bw_cap)
> > -		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth, limited by %s x%d link at %s (capable of %u.%03u Gb/s with %s x%d link)\n",
> > +		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth, limited by %s x%d link at %s (capable of %u.%03u Gb/s with %s x%d link)%s\n",
> >  			 bw_avail / 1000, bw_avail % 1000,
> >  			 pci_speed_string(speed), width,
> >  			 limiting_dev ? pci_name(limiting_dev) : "<unknown>",
> >  			 bw_cap / 1000, bw_cap % 1000,
> > -			 pci_speed_string(speed_cap), width_cap);
> > +			 pci_speed_string(speed_cap), width_cap, flit_mode);
> 
> Does the "Flit mode" message *need* to go into these lines? Could it be
> its own message?

I suppose it doesn't need to be there, and these bandwidth lines are
already pretty long (my fault, open to suggestions to shorten them),
but I do think it's useful to have related info all on the same line.

>  +#include <linux/string_choices.h>
> 
>  @@ -6190,21 +6190,25 @@ void __pcie_print_link_status(struct pci_dev *dev, bool verbose)
>   	enum pci_bus_speed speed, speed_cap;
>   	struct pci_dev *limiting_dev = NULL;
>   	u32 bw_avail, bw_cap;
>   
>   	bw_cap = pcie_bandwidth_capable(dev, &speed_cap, &width_cap);
>   	bw_avail = pcie_bandwidth_available(dev, &limiting_dev, &speed, &width);
>   
>  +	if (dev->bus)
>  +		pci_info(dev, "Flit mode: %s\n", str_enabled_disabled(dev->bus->flit_mode);
>  +
>   	if (bw_avail >= bw_cap && verbose)
>  		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth (%s x%d link)\n",
>   			 bw_cap / 1000, bw_cap % 1000,
>  			 pci_speed_string(speed_cap), width_cap);
>   	else if (bw_avail < bw_cap)
>  		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth, limited by %s x%d link at %s (capable of %u.%03u Gb/s with %s x%d link)\n",
>   			 bw_avail / 1000, bw_avail % 1000,
>   			 pci_speed_string(speed), width,
>   			 limiting_dev ? pci_name(limiting_dev) : "<unknown>",
>   			 bw_cap / 1000, bw_cap % 1000,
>  			 pci_speed_string(speed_cap), width_cap);
> 
> >  }

