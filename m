Return-Path: <linux-pci+bounces-13689-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B63D98C1F8
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 17:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1619282FA7
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 15:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9F61CB300;
	Tue,  1 Oct 2024 15:47:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4C91C9EC9;
	Tue,  1 Oct 2024 15:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727797629; cv=none; b=Q2WDwXuJ/qqYN7Y41IKz1+Zqw/+fYfyEWgG2l3+lEPMU6Gg2Aof43Tvobyk0BCavd/FLUJUEsG1aQIqPd9inQWIEDnLxhJ1aXrpfCjDBM6FBETjWWqRWkt9dtbtc2oKow/CIs4NSCr5iRnsErRaex88ibq1/PUcj9BgJjGSuNmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727797629; c=relaxed/simple;
	bh=LbnThuOkvJQLggX5f8+TIkhPw2EtISnLC74p+3MWKLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9xOHcs41tJDUW/AaW2zlS1SwUg3rSi+LLocVIeAfyjRncv4safUqCykM6aHMYEY7QMN9y7lfnq+ORbhUbmDAPheqxZDqJg293HDTcm/eWpmerIKGoEjCHiJXXC4+3jkU0uM2sqSI4uPQ/n8msk1WwAe8S6I3VejBu1ufRIPgQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 597B7100DA1D3;
	Tue,  1 Oct 2024 17:47:03 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 19317268E72; Tue,  1 Oct 2024 17:47:03 +0200 (CEST)
Date: Tue, 1 Oct 2024 17:47:03 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Gregory Price <gourry@gourry.net>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-pci@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, dave@stgolabs.net, dave.jiang@intel.com,
	vishal.l.verma@intel.com
Subject: Re: [PATCH] pci/doe: add a 1 second retry window to pci_doe
Message-ID: <ZvwZd5CCV2PdqSLF@wunner.de>
References: <20240913183241.17320-1-gourry@gourry.net>
 <66e51febbab99_ae212949d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240916101557.00007b3a@Huawei.com>
 <ZvwRjbRIrkCSjwQI@PC2K9PVX.TheFacebook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvwRjbRIrkCSjwQI@PC2K9PVX.TheFacebook.com>

On Tue, Oct 01, 2024 at 11:13:17AM -0400, Gregory Price wrote:
> > > Gregory Price wrote:
> > > > Depending on the device, sometimes firmware clears the busy flag
> > > > later than expected.  This can cause the device to appear busy when
> > > > calling multiple commands in quick sucession. Add a 1 second retry
> > > > window to all doe commands that end with -EBUSY.  
> 
> Just following up here, it sounds like everyone is unsure of this change.
> 
> I can confirm that this handles the CDAT retry issue I am seeing, and that
> the BUSY bit is set upon entry into the initial call. Only 1 or 2 retries
> are attempted before it is cleared and returns successfully.
> 
> I'd explored putting the retry logic in the CDAT code that calls into here,
> but that just seemed wrong.  Is there a suggestion or a nak here?
> 
> Trying to find a path forward.

The PCIe Base Spec doesn't prescribe a maximum timeout for the
DOE BUSY bit to clear.  Thus it seems fine to me in principle
to add a (or raise the) timeout if it turns out to be necessary
for real-life hardware.

That said, the proposed patch has room for improvement:

* The patch seems to wait for DOE BUSY bit to clear *after*
  completion.  That's odd.  The kernel waits for DOE Busy bit
  to clear *before* sending a new request, in pci_doe_send_req().
  My expectation would have been that you'd add a loop there which
  polls for DOE Busy bit to clear before sending a request.

  It seems that polling is the only option as no interrupt is
  raised on DOE Busy bit clear, per PCIe r6.2 sec 6.30.3.
  (Please add this bit of information to the commit message.)

* The commit message should clearly specify the device(s)
  affected by the issue (Vendor and Device ID plus name).
  Comments such as "Depending on the device, sometimes ..."
  are a little too vague.

* The "1 or 2 retries" bit of information you're mentioning
  above should likewise be in the commit message.

* Please use "PCI/DOE:" as subject prefix to match previous
  commits which touched drivers/pci/doe.c.

* Please adhere to spec language, e.g. use "DOE Busy bit"
  instead of "busy bit" so it's unambiguous for readers
  what you're referring to.

Thanks,

Lukas

