Return-Path: <linux-pci+bounces-2900-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1009F844B51
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 23:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C4828F959
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 22:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCE13A1AA;
	Wed, 31 Jan 2024 22:59:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829073A8C5;
	Wed, 31 Jan 2024 22:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.101.241.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706741948; cv=none; b=Euey6KQESTq+Xv8Exrj6pd/Rep90MV61fW9CNTIATxEnJwUYxTUfzMLPf3KUaan8OjinPcH3xrYMduV7n//FpqAXnEZ5J1LjBMM+zIk5wY3waa7DwO2IXxpLsbATh/Ztqug8i8BnVoUeU4dt2sFJEwcRpbYIM6ukdETcTnUVytM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706741948; c=relaxed/simple;
	bh=K7ewgk79QCombkqi3c5WQVJe6Ip0DZ6iX8pogb7qiwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYbr4+nNR3OSKfXJ8PsVsivjxCc1WjwIOUBmwbGSNhq7MqE8Rf0m/Yqwe2MtPCRNJsQIoJIlSTB/lfeXqIv5e1lEa0idzpo76JB7K7aIKbFqLEp0PQw7xhUYn4dd0YJwjtiuBf20gX4Pejyj3Mz5iQzYxx6cgVykbTVNQS26v5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=just42.net; spf=pass smtp.mailfrom=just42.net; arc=none smtp.client-ip=150.101.241.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=just42.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=just42.net
Received: from marvin.atrad.com.au (marvin.atrad.com.au [192.168.0.2])
	by server.atrad.com.au (8.17.2/8.17.2) with ESMTPS id 40VMmx1W001349
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 1 Feb 2024 09:19:00 +1030
Date: Thu, 1 Feb 2024 09:18:59 +1030
From: Jonathan Woithe <jwoithe@just42.net>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] PCI: Solve two bridge window sizing issues
Message-ID: <ZbrOW/eTC0FFPjec@marvin.atrad.com.au>
References: <20231228165707.3447-1-ilpo.jarvinen@linux.intel.com>
 <20240104131210.71f44d4b@imammedo.users.ipa.redhat.com>
 <ZZaiLOR4aO84CG2S@marvin.atrad.com.au>
 <ZZ+gEmxI/TxdbmyQ@marvin.atrad.com.au>
 <ZajJzcquyvRebAFN@marvin.atrad.com.au>
 <Za0T_siv79qz1jkk@smile.fi.intel.com>
 <Za2YtnwLKKeMquv6@marvin.atrad.com.au>
 <62b66d58-7824-3650-6a73-12068a22563e@linux.intel.com>
 <20240122144520.7761c5a6@imammedo.users.ipa.redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240122144520.7761c5a6@imammedo.users.ipa.redhat.com>
X-MIMEDefang-action: accept
X-Scanned-By: MIMEDefang 2.86 on 192.168.0.1

On Mon, Jan 22, 2024 at 02:45:20PM +0100, Igor Mammedov wrote:
> On Mon, 22 Jan 2024 14:37:32 +0200 (EET)
> Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:
> 
> > On Mon, 22 Jan 2024, Jonathan Woithe wrote:
> > 
> > > On Sun, Jan 21, 2024 at 02:54:22PM +0200, Andy Shevchenko wrote:  
> > > > On Thu, Jan 18, 2024 at 05:18:45PM +1030, Jonathan Woithe wrote:  
> > > > > On Thu, Jan 11, 2024 at 06:30:22PM +1030, Jonathan Woithe wrote:  
> > > > > > On Thu, Jan 04, 2024 at 10:48:53PM +1030, Jonathan Woithe wrote:  
> > > > > > > On Thu, Jan 04, 2024 at 01:12:10PM +0100, Igor Mammedov wrote:  
> > > > > > > > On Thu, 28 Dec 2023 18:57:00 +0200
> > > > > > > > Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > > > >   
> > > > > > > > > Hi all,
> > > > > > > > > 
> > > > > > > > > Here's a series that contains two fixes to PCI bridge window sizing
> > > > > > > > > algorithm. Together, they should enable remove & rescan cycle to work
> > > > > > > > > for a PCI bus that has PCI devices with optional resources and/or
> > > > > > > > > disparity in BAR sizes.
> > > > > > > > > 
> > > > > > > > > For the second fix, I chose to expose find_empty_resource_slot() from
> > > > > > > > > kernel/resource.c because it should increase accuracy of the cannot-fit
> > > > > > > > > decision (currently that function is called find_resource()). In order
> > > > > > > > > to do that sensibly, a few improvements seemed in order to make its
> > > > > > > > > interface and name of the function sane before exposing it. Thus, the
> > > > > > > > > few extra patches on resource side.
> > > > > > > > > 
> > > > > > > > > Unfortunately I don't have a reason to suspect these would help with
> > > > > > > > > the issues related to the currently ongoing resource regression
> > > > > > > > > thread [1].  
> > > > > > > > 
> > > > > > > > Jonathan,
> > > > > > > > can you test this series on affected machine with broken kernel to see if
> > > > > > > > it's of any help in your case?  
> > > > > > > 
> > > > > > > Certainly, but it will have to wait until next Thursday (11 Jan 2024).  I'm
> > > > > > > still on leave this week, and when at work I only have physical access to
> > > > > > > the machine concerned on Thursdays at present.
> > > > > > > 
> > > > > > > Which kernel would you prefer I apply the series to?  
> > > > > > 
> > > > > > I was very short of time today but I did apply the above series to the
> > > > > > 5.15.y branch (since I had this source available), resulting in version
> > > > > > 5.15.141+.  Unfortunately, in the rush I forgot to do a clean after the
> > > > > > bisect reset, so the resulting kernel was not correctly built.  It booted
> > > > > > but thought it was a different version and therefore none of the modules
> > > > > > could be found.  As a result, the test is invalid.
> > > > > > 
> > > > > > I will try again in a week when I next have physical access to the system. 
> > > > > > Apologies for the delay.  In the meantime, if there's a specific kernel I
> > > > > > should apply the patch series against please let me know.  As I understand
> > > > > > it, you want it applied to one of the kernels which failed, making 5.15.y
> > > > > > (for y < 145) a reasonable choice.  
> > > > > 
> > > > > I did a "make clean" to reset the source tree and recompiled.  However, it
> > > > > errored out:
> > > > > 
> > > > >   drivers/pci/setup-bus.c:988:24: error: ‘RESOURCE_SIZE_MAX’ undeclared
> > > > >   drivers/pci/setup-bus.c:998:17: error: ‘pci_bus_for_each_resource’ undeclared
> > > > > 
> > > > > This was with the patch series applied against 5.15.141.  It seems the patch
> > > > > targets a kernel that's too far removed from 5.15.x.
> > > > > 
> > > > > Which kernel would you like me to apply the patch series to and test?  
> > > > 
> > > > The rule of thumb is to test against latest vanilla (as of today v6.7).
> > > > Also makes sense to test against Linux Next. The v5.15 is way too old for
> > > > a new code.  
> > > 
> > > Thanks, and understood.  In this case the request from Igor was 
> > > 
> > >     can you test this series on affected machine with broken kernel to see if
> > >     it's of any help in your case?
> > > 
> > > The latest vanilla kernel (6.7) has (AFAIK) had the offending commit
> > > reverted, so it's not a "broken" kernel in this respect.  Therefore, if I've
> > > understood the request correctly, working with that kernel won't produce the
> > > desired test.  
> > 
> > Well, you can revert the revert again to get back to the broken state.
> 
> either this or just a hand patching as Ilpo has suggested earlier
> would do.

No problem.  This was the easiest approach for me and I have now done this. 
Apologies for the delay in getting to this: I ran out of time last Thursday.

> There is non zero chance that this series might fix issues
> Jonathan is facing. i.e. failed resource reallocation which
> offending patches trigger.

I can confirm that as expected, this patch series has had no effect on the
system which experiences the failed resource reallocation.  From syslog,
running a 5.15.141+ kernel[1]:

    kernel: radeon 0000:4b:00.0: Fatal error during GPU init
    kernel: radeon: probe of 0000:4b:00.0 failed with error -12

This is unchanged from what is seen with the unaltered 5.15.141 kernel.

In case it's important, can also confirm that the errors related to the
thunderbolt device are are also still present in the patched 5.15.141+
kernel:

    thunderbolt 0000:04:00.0: interrupt for TX ring 0 is already enabled
    :
    thunderbolt 0000:04:00.0: interrupt for RX ring 0 is already enabled
    :

Like the GPU failure, they do not appear in the working kernels on this
system.

Let me know if you would like to me to run further tests.

Regards
  jonathan

[1] This is 5.15.141, patched with the series of interest here and the hand
    patch from Ilpo.

