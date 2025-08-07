Return-Path: <linux-pci+bounces-33597-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA9DB1DFC9
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 01:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35427623DEE
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 23:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D43222DA15;
	Thu,  7 Aug 2025 23:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Md0xDHXC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF04C1946AA;
	Thu,  7 Aug 2025 23:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754609198; cv=none; b=n7i91ZYRfpWphm13ynhRTazBVyafghUkuuJzfA3T2RryUtE4kpysqoeBv09Uf27eWCk2U81aHciwxPYbFP+QHXEbg9uKL5sQNrsmRh33WtSi1W4afrqwQ6dbbLamhgErV4Dkk68/kAZSSEdg2vAnm2i+ncmc5rp+MnHsYVzvX0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754609198; c=relaxed/simple;
	bh=/Dha1AnamekDF+eoFpqLFEytcJK/ld7mdjOG9Qbmd4I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZgjhXYBVgmlLm4/rpDTw4v3eXv2pbMTnWDl0RAPH4O4RsxwLUf2cebvTYQcTapntoZdvWAhdeFz1X5uV1ulQqdoQd0irQDKlFEWzzIRr76aGqrTuRK+FkyCHFlNYGcHVNWYxi7cpW85RvwmM+tvazBYyDs7Ww/EZQ18roPO70UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Md0xDHXC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D2BC4CEEB;
	Thu,  7 Aug 2025 23:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754609198;
	bh=/Dha1AnamekDF+eoFpqLFEytcJK/ld7mdjOG9Qbmd4I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Md0xDHXCqK0W1aOnfinpaq5J0qSsqFz+a9V42g554Rmlslwzh5qrWu3HoboBSJref
	 dRj2RTrkGPuanolIXn0H8YVE+gk9sB9YOaBqRIMGcH38KKU/o5Rs9ds5h/mbHgVqIN
	 I15K32DokaG2nuPK1CTGxx+wepDlpmWIaD+FjULeZ9vgUdtRc5c2Pqjf4fX2oU/DIP
	 fIBEUsr8XmMzUbzWrJQqgod2WqXGajinftyfkBrpiiAheqhAs2s6se1ubpmmrjdshn
	 z/GESIkfPLU0w9DQ66PsRE2XilsS/Gmkh8xtJ/Rv7lynRgnDHo+w+HOVQstnnplLWV
	 4zg+1tCUxjVGw==
Date: Thu, 7 Aug 2025 18:26:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: dan.j.williams@intel.com
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, bhelgaas@google.com, aik@amd.com,
	lukas@wunner.de
Subject: Re: [PATCH v4 03/10] PCI: Introduce pci_walk_bus_reverse(),
 for_each_pci_dev_reverse()
Message-ID: <20250807232636.GA68733@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6895342226a99_cff9910086@dwillia2-xfh.jf.intel.com.notmuch>

On Thu, Aug 07, 2025 at 04:17:54PM -0700, dan.j.williams@intel.com wrote:
> Bjorn Helgaas wrote:
> > On Thu, Jul 17, 2025 at 11:33:51AM -0700, Dan Williams wrote:

> > > +++ b/drivers/base/bus.c
> > > +static struct device *prev_device(struct klist_iter *i)
> > > +{
> > > +	struct klist_node *n = klist_prev(i);
> > > +	struct device *dev = NULL;
> > > +	struct device_private *dev_prv;
> > > +
> > > +	if (n) {
> > > +		dev_prv = to_device_private_bus(n);
> > > +		dev = dev_prv->device;
> > > +	}
> > > +	return dev;
> > 
> > I think this would be simpler as:
> > 
> >   if (!n)
> >     return NULL;
> > 
> >   dev_prv = to_device_private_bus(n);
> >   return dev_prv->device;
> 
> Agree, in isolation, but next to next_device() the style looks odd. So,
> go back and style-fix code from 2008, or make 2025 code look like 2008
> code is the choice.

Good point, I didn't look around at that code.  Following the existing
style seems right to me.

> > > +++ b/drivers/pci/bus.c
> > > +static int __pci_walk_bus_reverse(struct pci_bus *top,
> > > +				  int (*cb)(struct pci_dev *, void *),
> > > +				  void *userdata)
> > > +{
> > > +	struct pci_dev *dev;
> > > +	int ret = 0;
> > > +
> > > +	list_for_each_entry_reverse(dev, &top->devices, bus_list) {
> > > +		if (dev->subordinate) {
> > > +			ret = __pci_walk_bus_reverse(dev->subordinate, cb,
> > > +						     userdata);
> > > +			if (ret)
> > > +				break;
> > > +		}
> > > +		ret = cb(dev, userdata);
> > > +		if (ret)
> > > +			break;
> > > +	}
> > > +	return ret;
> > 
> > Why not:
> > 
> >   list_for_each_entry_reverse(...) {
> >     ...
> >     if (ret)
> >       return ret;
> >   }
> >   return 0;
> 
> Again, for conformance to existing style of __pci_walk_bus(). Want a
> lead-in cleanup for that?

Don't bother.  Maybe some janitor will show up and do it eventually.

Bjorn

