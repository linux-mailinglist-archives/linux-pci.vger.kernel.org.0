Return-Path: <linux-pci+bounces-10508-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C79934F94
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 17:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D57D2828AA
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 15:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61D2144306;
	Thu, 18 Jul 2024 15:01:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A114143876;
	Thu, 18 Jul 2024 15:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721314902; cv=none; b=byDbBw4vIk9csHHu8Q0m+Jm81vG+HsU+exsdOyx8mWJskaa0k+ZtxLIB6KvhYVc5mR8tVQCoZyEFAPISC9um4hA1iA7RiCxEO1m62bn7g3QLZ+eCoaZ9SH0BpURkyxoMKRTsKcXt+VdCbmxxCsX0zH4EF0ZPrBdbgpjeQXp59UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721314902; c=relaxed/simple;
	bh=26xRFki/++tCJSlncJH7baiLrj7Y357SkhqjVxLQ3fE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AxLAN9MJmI/0ZLAyULnjENce116tycXYygSeAs/Sxzdz7Pe9zUXwvQdayjVlzqErRYx6i3ACa2D2+KcJ4ftLoaL1L2BmNksk8n55e4RYrVIF2TlNqKXe0HZ7rFCmsO+41Jjm5add4N65rAr9oVhbJPk274XifArd+QN0cXX5CN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WPwtw30Qfz6K9Zt;
	Thu, 18 Jul 2024 22:59:20 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id ABF36140B33;
	Thu, 18 Jul 2024 23:01:36 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 18 Jul
 2024 16:01:36 +0100
Date: Thu, 18 Jul 2024 16:01:35 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>, David
 Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, David Woodhouse
	<dwmw2@infradead.org>, James Bottomley
	<James.Bottomley@hansenpartnership.com>, <linux-pci@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<linuxarm@huawei.com>, David Box <david.e.box@intel.com>, "Li, Ming"
	<ming4.li@intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Alistair
 Francis <alistair.francis@wdc.com>, Wilfred Mallawa
	<wilfred.mallawa@wdc.com>, Damien Le Moal <dlemoal@kernel.org>, "Alexey
 Kardashevskiy" <aik@amd.com>, Dhaval Giani <dhaval.giani@amd.com>,
	Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>, Jason Gunthorpe
	<jgg@nvidia.com>, Peter Gonda <pgonda@google.com>, Jerome Glisse
	<jglisse@google.com>, Sean Christopherson <seanjc@google.com>, "Alexander
 Graf" <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>
Subject: Re: [PATCH v2 10/18] PCI/CMA: Reauthenticate devices on reset and
 resume
Message-ID: <20240718160135.00000e6b@Huawei.com>
In-Reply-To: <668f17d4553_6de2294ba@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1719771133.git.lukas@wunner.de>
	<bd850e8257552d47433bdb2e10fa9b0a49659a4e.1719771133.git.lukas@wunner.de>
	<668f17d4553_6de2294ba@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 10 Jul 2024 16:23:00 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Lukas Wunner wrote:
> > CMA-SPDM state is lost when a device undergoes a Conventional Reset.
> > (But not a Function Level Reset, PCIe r6.2 sec 6.6.2.)  A D3cold to D0
> > transition implies a Conventional Reset (PCIe r6.2 sec 5.8).
> > 
> > Thus, reauthenticate devices on resume from D3cold and on recovery from
> > a Secondary Bus Reset or DPC-induced Hot Reset.
> > 
> > The requirement to reauthenticate devices on resume from system sleep
> > (and in the future reestablish IDE encryption) is the reason why SPDM  
> 
> TSM "connect" state also needs to be managed over reset, so stay tuned
> for some collaboration here.
> 
> > needs to be in-kernel:  During ->resume_noirq, which is the first phase
> > after system sleep, the PCI core walks down the hierarchy, puts each
> > device in D0, restores its config space and invokes the driver's  
> > ->resume_noirq callback.  The driver is afforded the right to access the  
> > device already during this phase.  
> 
> I agree that CMA should be in kernel, it's not clear that authentication
> needs to be automatic, and certainly not in a way that a driver can not
> opt-out of.
> 
> What if a use case cares about resume time latency?  What if a driver
> knows that authentication is only needed later in the resume flow? Seems
> presumptious for the core to assume it knows best when authentication
> needs to happen.

Feels like a policy question - maybe a static key (as Kees suggested for
the other question).  By all means default to on, but a latency sensitive
setup might opt out?  Or specific driver opt out might be an option
if we are allowing a driver managed flow (and the policy allows drivers
to opt out - we definitely want a policy option that doesn't allow
drivers to be part of the decision and indeed does what we have here).

Hope someone writes a nice guide to any policy choices that come out of
this.  Maybe the policy hooks don't belong in a first patch set though
as this one in particular is a performance optimization.

> 
> At a minimum I think pci_cma_reauthenticate() should do something like:
> 
> /* not previously authenticated skip authentication */
> if (!spdm_state->authenticated)
> 	return;
> 
> ...so that spdm capable devices can opt-out of automatic reauthentication.

This seems reasonable as only possibility of change is that it can now
authenticate (maybe the reset was a firmware update...) and if we accepted
it before then no loss of security in not checking.  Userspace can then poke
the reauthenticate and reload the driver if relevant (maybe more functionality
will be enabled.)



Note the whole always try to authenticate first was outcome of one of the LPC
BoFs (2 years ago?).

Jonathan


> 



