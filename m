Return-Path: <linux-pci+bounces-28268-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BA2AC0A77
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 13:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C40E1BC53DC
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 11:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233D7234962;
	Thu, 22 May 2025 11:17:32 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F130D231859;
	Thu, 22 May 2025 11:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747912652; cv=none; b=kMi61bmuy4e9Jwm81ZFdlnbvnjK48SW+Qq6KIiY/pmhXzqpvqMcDCwT0X20VHDdQgpnX7SDAb9zFAnmgLVTOiYgwuJ4lVcmPjFppVMvi2NsIMSvZBTbsI9gq5rjRWKjwg1BcXg+rXYAKeuzvJhCMBxB+EHOG9GuaMhZ0TwVtrGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747912652; c=relaxed/simple;
	bh=cJHVVEwCyg2HFGmy3+awErBpn5aR10k/YzTfGYQ+0a0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sWcoZVu0NbvujKriMMVHA6F8qxl9E43VzlUSTZ1ZZj44zEWwL9IL06+TyB756a8NNzKzcWI2VUGq6fQpxZ0xRnLg2OwTRqAGFtl3RRil8OJhUE8JKSOZ14NOvoQ98GmxyRAU1l+LjHbDFeElIJsiYmRiIIXWXQTdY6Ukzuu6wMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b35Jv3sz3z6L5Fm;
	Thu, 22 May 2025 19:14:07 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id DE1141402EE;
	Thu, 22 May 2025 19:17:21 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 22 May
 2025 13:17:20 +0200
Date: Thu, 22 May 2025 12:17:18 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, Jon Pan-Doh <pandoh@google.com>, "Karolina
 Stolarek" <karolina.stolarek@oracle.com>, Weinan Liu <wnliu@google.com>,
	Martin Petersen <martin.petersen@oracle.com>, Ben Fuller
	<ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, "Anil
 Agrawal" <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Sathyanarayanan
 Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner
	<lukas@wunner.de>, Sargun Dhillon <sargun@meta.com>, "Paul E . McKenney"
	<paulmck@kernel.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver
 O'Halloran <oohall@gmail.com>, Kai-Heng Feng <kaihengf@nvidia.com>, Keith
 Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>, "Terry Bowman"
	<terry.bowman@amd.com>, Shiju Jose <shiju.jose@huawei.com>, "Dave Jiang"
	<dave.jiang@intel.com>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v7 15/17] PCI/AER: Ratelimit correctable and non-fatal
 error logging
Message-ID: <20250522121718.00005fa2@huawei.com>
In-Reply-To: <20250521225430.GA1442014@bhelgaas>
References: <20250521113121.000067ce@huawei.com>
	<20250521225430.GA1442014@bhelgaas>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 21 May 2025 17:54:30 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Wed, May 21, 2025 at 11:31:21AM +0100, Jonathan Cameron wrote:
> > On Tue, 20 May 2025 16:50:32 -0500
> > Bjorn Helgaas <helgaas@kernel.org> wrote:
> >   
> > > From: Jon Pan-Doh <pandoh@google.com>
> > > 
> > > Spammy devices can flood kernel logs with AER errors and slow/stall
> > > execution. Add per-device ratelimits for AER correctable and non-fatal
> > > uncorrectable errors that use the kernel defaults (10 per 5s).  Logging of
> > > fatal errors is not ratelimited.  
> > 
> > See below. I'm not sure that logging of fatal error should affect the rate
> > for non fatal errors + the rate limit infrastructure kind of assumes
> > that you only call it if you are planning to respect it's decision.
> > 
> > Given overall aim is to restrict rates, maybe we don't care if we sometimes
> > throttle earlier that we might expect with a simpler separation of what
> > is being limited.
> > 
> > I don't mind strongly either way.  
> 
> > > @@ -593,7 +593,8 @@ struct aer_err_info {
> > >  	unsigned int id:16;
> > >  
> > >  	unsigned int severity:2;	/* 0:NONFATAL | 1:FATAL | 2:COR */
> > > -	unsigned int __pad1:5;
> > > +	unsigned int ratelimit:1;	/* 0=skip, 1=print */  
> > 
> > That naming is less than intuitive.  Maybe expand it to ratelimit_print or
> > something like that.  
> 
> True, although it does match uses like "if (aer_ratelimit(...))"
> 
> I'll try ratelimit_print and see how you like it :)
> 
> > > +	unsigned int __pad1:4;
> > >  	unsigned int multi_error_valid:1;
> > >  
> > >  	unsigned int first_error:5;
> > > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > > index 4f1bff0f000f..f9e684ac7878 100644
> > > --- a/drivers/pci/pcie/aer.c
> > > +++ b/drivers/pci/pcie/aer.c  
> >   
> > > @@ -815,8 +843,19 @@ EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
> > >   */
> > >  static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
> > >  {
> > > +	/*
> > > +	 * Ratelimit AER log messages.  "dev" is either the source
> > > +	 * identified by the root's Error Source ID or it has an unmasked
> > > +	 * error logged in its own AER Capability.  If any of these devices
> > > +	 * has not reached its ratelimit, log messages for all of them.
> > > +	 * Messages are emitted when "e_info->ratelimit" is non-zero.
> > > +	 *
> > > +	 * Note that "e_info->ratelimit" was already initialized to 1 for the
> > > +	 * ERR_FATAL case.
> > > +	 */
> > >  	if (e_info->error_dev_num < AER_MAX_MULTI_ERR_DEVICES) {
> > >  		e_info->dev[e_info->error_dev_num] = pci_dev_get(dev);
> > > +		e_info->ratelimit |= aer_ratelimit(dev, e_info->severity);  
> > 
> > So this is a little odd.  I think it works but there is code inside
> > __ratelimit that I think we should not be calling for that
> > ERROR_FATAL case (whether we should call lots of times for each
> > device isn't obvious either but maybe that is more valid).
> > 
> > In the event of it already being 1 due to ERROR_FATAL you will
> > falsely trigger a potential print from inside __ratelimit() if we
> > were rate limited and no longer are but only skipped FATAL prints.
> > My concern is that function is kind of assuming it's only called in
> > cases where a rate limit decision is being made and the
> > implementation may change in future).  
> 
> Hmmm.  That's pretty subtle, thanks for catching this.
> 
> In the light of day, ".ratelimit = fatal ? 1 : 0" looks a bit sketchy.
> If we want to avoid ratelimiting AER_FATAL, maybe aer_ratelimit()
> should just return 1 ("print") unconditionally in that case, without
> calling __ratelimit():
> 
>   static int aer_ratelimit(struct pci_dev *dev, unsigned int severity)
>   {
>     struct ratelimit_state *ratelimit;
> 
>     if (severity == AER_FATAL)
>       return 1;       /* AER_FATAL not ratelimited */
> 
>     if (severity == AER_CORRECTABLE)
>       ratelimit = &dev->aer_info->cor_log_ratelimit;
>     else
>       ratelimit = &dev->aer_info->uncor_log_ratelimit;
> 
>     return __ratelimit(ratelimit);
>   }

Neat solution so go with that.

> 
> That still leaves this question of how to deal with info->dev[] when
> there's more than one entry, which is kind of an annoying case that
> only happens for the native AER path.
> 
> I think it's because for a single AER interrupt from an RP/RCEC, we
> collect the root info in one struct aer_err_info and scrape all the
> downstream devices for anything interesting.  We visit each downstream
> device and is_error_source() reads its status register, but we only
> keep the pci_dev pointer, so aer_get_device_error_info() has to read
> the status registers *again*.  This all seems kind of obtuse.
> 
> The point of the OR above in add_error_device() was to try to match up
> RP/RCEC logging with downstream device logging so they're ratelimited
> the same.  If we ratelimit the Error Source ID based on the RP/RCEC
> and the details based on the downstream devices individually, they'll
> get out of sync, so sometimes we'll print an Error Source ID and elide
> the details and vice versa.
> 
> I wanted to make it so that if we log downstream details, we also log
> the Error Source ID.  But maybe we should ratelimit downstream devices
> individually (instead of doing this weird union) and make the RP/RCEC
> part more explicit, e.g.,
> 
>   add_error_device(...)
>   {
>     int i = e_info->error_dev_num;
> 
>     e_info->dev[i] = pci_dev_get(dev);
>     e_info->error_dev_num++;
> 
>     if (aer_ratelimit(dev, e_info->severity)) {
>       e_info->root_ratelimit_print = 1;
>       e_info->ratelimit_print[i] = 1;
>     }
>   }

As it's a weird corner case, I don't really mind how you handle it.
I'm not sure I grasp this last suggestion fully but can look at the full
code if you do go with something like that.

Jonathan

> 
> > https://elixir.bootlin.com/linux/v6.14.7/source/lib/ratelimit.c#L56
> > 
> > Maybe, 
> > 		if (!info->ratelimit)
> > 			e_info->ratelimit = aer_ratelimit(dev, e_info->severity);
> > is an alternative option.
> > That allows a multiplication factor on the rate as all device count for 1.  


