Return-Path: <linux-pci+bounces-5457-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0C3892E2D
	for <lists+linux-pci@lfdr.de>; Sun, 31 Mar 2024 03:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6279C28213F
	for <lists+linux-pci@lfdr.de>; Sun, 31 Mar 2024 01:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE02653;
	Sun, 31 Mar 2024 01:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="Uj7DTHHZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EE1389
	for <linux-pci@vger.kernel.org>; Sun, 31 Mar 2024 01:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711847049; cv=none; b=dvwsp21CrDbrVssBj/GuP1TaEI+m8K0xpMeD2xqjCZrrnW2NYXrXYgZpqY6PURyERA3A0sAFYjJ9ZYI+9HZRLl4lVNzPMXS9CKW8HGjLgyW5ggpIeDR9eFvfMbvlFRBBopR/AKwJDNjwwbVPZxzf/3i1o5aRYDxXkHtl3FEbUH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711847049; c=relaxed/simple;
	bh=moxV8NLD4oFvjfXW/coD+y0iRjEP4+zMCKBX+Ymsun4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRm4/MOK8RmQA++LLQoFYXbKhVnnhlgn+9BaXySEiMXoCajlWv3I3VtyTF9Cv1yjXEKlAxTX/jqfHuVni74hS7YsdZU2GDFVNDV2PRsxpB/stUXtnGac4VM0aMh3WDpw5+F158gKq1Ln+4S6SWYlfB/KlEW3f8XAQczXOh8IC30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=Uj7DTHHZ; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
	id D5668285EF7; Sun, 31 Mar 2024 03:03:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1711847037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RsKNcBh3VGWNGZjbyNBK4t+Lo1NnHzTo5HDtN2e4BW4=;
	b=Uj7DTHHZyL4nFA8406lXNb7eR/JfIcfp2BKsU/a/yZOOreTpwbeTlnN4lARG70yYpLbk3a
	GVx9SJ1sZaehawCt4695Y+b8qRb/omIxBmK5+ODtpiBLY7uSVQS7f0R54elqGfeLIRb29Z
	vXOgCfcHqM4Z/5xpZP5rrJUcEqp50xc=
Date: Sun, 31 Mar 2024 03:03:57 +0200
From: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>,
	linux-cxl@vger.kernel.org, y-goto@fujitsu.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 3/3] Add function to display cxl1.1 device link status
Message-ID: <mj+md-20240331.010245.99093.nikam@ucw.cz>
References: <20240312080559.14904-1-kobayashi.da-06@fujitsu.com>
 <20240312080559.14904-4-kobayashi.da-06@fujitsu.com>
 <mj+md-20240329.221545.11188.nikam@ucw.cz>
 <660767abc418d_19e0294c7@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <660767abc418d_19e0294c7@dwillia2-mobl3.amr.corp.intel.com.notmuch>

Hello!

> > Does it make sense to look up CXL RCD information for all PCIe devices of type
> > PCI_EXP_TYPE_ROOT_INT_EP? Shouldn't it be done only for devices with the CXL
> > capability?
> 
> I think so, would this fit more naturally in pci_scan_caps() with a new
> scan for DVSEC caps ("PCI_EXT_CAP_ID_DVSEC" in Linux). However, isn't
> the trouble that this needs a DVSEC scan for CXL to know it needs to go
> back and fill in details that normally in appear in the base PCIe
> capability scan?

I would prefer to display all CXL stuff together (i.e., when showing the
DVSEC caps). Is there any reason not to?

					Martin

