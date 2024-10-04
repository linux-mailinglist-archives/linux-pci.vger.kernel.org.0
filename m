Return-Path: <linux-pci+bounces-13811-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D7A990217
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 13:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EC571C21CE1
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 11:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E4215853A;
	Fri,  4 Oct 2024 11:32:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9738613D503;
	Fri,  4 Oct 2024 11:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728041531; cv=none; b=VhJhLLysiwCWg9jTZi799M6f/OGBroeHfxO5JYSW8Mjup1klFhRdIcU8gz+/QPc7RGwRZKjczo0JyEImMzj0d5OHjSjqaTDI6N2A8a27NvSqLnMl0rSSPewdyUiu6qXk0aY+ao4qmeu4NynKf1SPFYbo3c16cepe3jwT1BhxzZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728041531; c=relaxed/simple;
	bh=yZJUr5y0cFjRAooP/YZ0lox9GjmGrEgMTe2qMk8Si8E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b804lXHl1nGZQIskE0PynH2hJWSbKTlmOycQt68m1PLnpgzboSIh0auCd/GOXP3VF8lEnAoS1zZXwUpSdc5599jsOdtiH3aUnvkRPIB0Nq4+U0o2CTqKN31Fpvx4NCNQtpGgDnqld5rVMKAjE4QkTzJyI2o23XjHU0ngk7e4Iqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XKmVy3Kfnz6LCql;
	Fri,  4 Oct 2024 19:27:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3EC721402C6;
	Fri,  4 Oct 2024 19:32:06 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Oct
 2024 13:32:05 +0200
Date: Fri, 4 Oct 2024 12:32:03 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Lukas Wunner <lukas@wunner.de>
CC: Gregory Price <gourry@gourry.net>, Dan Williams
	<dan.j.williams@intel.com>, <linux-pci@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bhelgaas@google.com>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>
Subject: Re: [PATCH] pci/doe: add a 1 second retry window to pci_doe
Message-ID: <20241004123203.00007456@Huawei.com>
In-Reply-To: <ZvwZd5CCV2PdqSLF@wunner.de>
References: <20240913183241.17320-1-gourry@gourry.net>
	<66e51febbab99_ae212949d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<20240916101557.00007b3a@Huawei.com>
	<ZvwRjbRIrkCSjwQI@PC2K9PVX.TheFacebook.com>
	<ZvwZd5CCV2PdqSLF@wunner.de>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 1 Oct 2024 17:47:03 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> On Tue, Oct 01, 2024 at 11:13:17AM -0400, Gregory Price wrote:
> > > > Gregory Price wrote:  
> > > > > Depending on the device, sometimes firmware clears the busy flag
> > > > > later than expected.  This can cause the device to appear busy when
> > > > > calling multiple commands in quick sucession. Add a 1 second retry
> > > > > window to all doe commands that end with -EBUSY.    
> > 
> > Just following up here, it sounds like everyone is unsure of this change.
> > 
> > I can confirm that this handles the CDAT retry issue I am seeing, and that
> > the BUSY bit is set upon entry into the initial call. Only 1 or 2 retries
> > are attempted before it is cleared and returns successfully.
> > 
> > I'd explored putting the retry logic in the CDAT code that calls into here,
> > but that just seemed wrong.  Is there a suggestion or a nak here?
> > 
> > Trying to find a path forward.  
> 
> The PCIe Base Spec doesn't prescribe a maximum timeout for the
> DOE BUSY bit to clear.  Thus it seems fine to me in principle
> to add a (or raise the) timeout if it turns out to be necessary
> for real-life hardware.
> 
> That said, the proposed patch has room for improvement:
> 
> * The patch seems to wait for DOE BUSY bit to clear *after*
>   completion.  That's odd.  The kernel waits for DOE Busy bit
>   to clear *before* sending a new request, in pci_doe_send_req().
>   My expectation would have been that you'd add a loop there which
>   polls for DOE Busy bit to clear before sending a request.
> 
>   It seems that polling is the only option as no interrupt is
>   raised on DOE Busy bit clear, per PCIe r6.2 sec 6.30.3.
>   (Please add this bit of information to the commit message.)

This changed at some point.  In PCI 6.0 the clearing
of this bit is explicitly called out in DOE interrupt status
as a reason to trigger the interrupt. By 6.1 that's gone.
This was a problem for the original implementation as we had
to assume that we'd get random spurious interrupts because
of that delight.

Anyhow, hopefully doesn't matter to us here as you are correct
that we have to poll for it.

Mind you we still have to allow for spurious garbage interrupts
and eat them silently. :(

> 
> * The commit message should clearly specify the device(s)
>   affected by the issue (Vendor and Device ID plus name).
>   Comments such as "Depending on the device, sometimes ..."
>   are a little too vague.
> 
> * The "1 or 2 retries" bit of information you're mentioning
>   above should likewise be in the commit message.
> 
> * Please use "PCI/DOE:" as subject prefix to match previous
>   commits which touched drivers/pci/doe.c.
> 
> * Please adhere to spec language, e.g. use "DOE Busy bit"
>   instead of "busy bit" so it's unambiguous for readers
>   what you're referring to.
> 
> Thanks,
> 
> Lukas
> 


