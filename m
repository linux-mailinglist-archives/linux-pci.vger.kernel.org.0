Return-Path: <linux-pci+bounces-2403-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5A8835818
	for <lists+linux-pci@lfdr.de>; Sun, 21 Jan 2024 23:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D423B1C20CEE
	for <lists+linux-pci@lfdr.de>; Sun, 21 Jan 2024 22:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EA738DFA;
	Sun, 21 Jan 2024 22:21:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CECB38DF7;
	Sun, 21 Jan 2024 22:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.101.241.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705875714; cv=none; b=DTmtjcf4ho43PjVSjiRMHJY20lWe8GT4xs8HsJNZIUT7/twudfG2riNxelu18lbxnN3NbfDWcfLIFZb+EStfzk3rJ1X3OY1q6yAB1nWX6AmqdXGuOYWPLUigX4ykTX3O/msHzECti/KpXG/sFnwSMTqc2eQcQptNYhZeW5VDmvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705875714; c=relaxed/simple;
	bh=Tb/h+cGUzGAV2xeqvibzuCTLaxv4CJ2BINKOQ4QTy+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ok5O9raX2JoMSUxAO6XPF96mB8IE6jr7wCvr2jHabtNVA2xucG/fac1oTJPRcfBfxtXkUvmyGUumnL3azf0PJbuWrN6EPD8ivrDoA4pi3MvDoV/VXa00wROfBah6SMQ9jpmvOy1IFSrIj1GgSvNIOyCayYzBOScfT5UDeb8WK1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=just42.net; spf=pass smtp.mailfrom=just42.net; arc=none smtp.client-ip=150.101.241.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=just42.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=just42.net
Received: from marvin.atrad.com.au (marvin.atrad.com.au [192.168.0.2])
	by server.atrad.com.au (8.17.2/8.17.2) with ESMTPS id 40LMKcoq011184
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 22 Jan 2024 08:50:40 +1030
Date: Mon, 22 Jan 2024 08:50:38 +1030
From: Jonathan Woithe <jwoithe@just42.net>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] PCI: Solve two bridge window sizing issues
Message-ID: <Za2YtnwLKKeMquv6@marvin.atrad.com.au>
References: <20231228165707.3447-1-ilpo.jarvinen@linux.intel.com>
 <20240104131210.71f44d4b@imammedo.users.ipa.redhat.com>
 <ZZaiLOR4aO84CG2S@marvin.atrad.com.au>
 <ZZ+gEmxI/TxdbmyQ@marvin.atrad.com.au>
 <ZajJzcquyvRebAFN@marvin.atrad.com.au>
 <Za0T_siv79qz1jkk@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Za0T_siv79qz1jkk@smile.fi.intel.com>
X-MIMEDefang-action: accept
X-Scanned-By: MIMEDefang 2.86 on 192.168.0.1

On Sun, Jan 21, 2024 at 02:54:22PM +0200, Andy Shevchenko wrote:
> On Thu, Jan 18, 2024 at 05:18:45PM +1030, Jonathan Woithe wrote:
> > On Thu, Jan 11, 2024 at 06:30:22PM +1030, Jonathan Woithe wrote:
> > > On Thu, Jan 04, 2024 at 10:48:53PM +1030, Jonathan Woithe wrote:
> > > > On Thu, Jan 04, 2024 at 01:12:10PM +0100, Igor Mammedov wrote:
> > > > > On Thu, 28 Dec 2023 18:57:00 +0200
> > > > > Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > 
> > > > > > Hi all,
> > > > > > 
> > > > > > Here's a series that contains two fixes to PCI bridge window sizing
> > > > > > algorithm. Together, they should enable remove & rescan cycle to work
> > > > > > for a PCI bus that has PCI devices with optional resources and/or
> > > > > > disparity in BAR sizes.
> > > > > > 
> > > > > > For the second fix, I chose to expose find_empty_resource_slot() from
> > > > > > kernel/resource.c because it should increase accuracy of the cannot-fit
> > > > > > decision (currently that function is called find_resource()). In order
> > > > > > to do that sensibly, a few improvements seemed in order to make its
> > > > > > interface and name of the function sane before exposing it. Thus, the
> > > > > > few extra patches on resource side.
> > > > > > 
> > > > > > Unfortunately I don't have a reason to suspect these would help with
> > > > > > the issues related to the currently ongoing resource regression
> > > > > > thread [1].
> > > > > 
> > > > > Jonathan,
> > > > > can you test this series on affected machine with broken kernel to see if
> > > > > it's of any help in your case?
> > > > 
> > > > Certainly, but it will have to wait until next Thursday (11 Jan 2024).  I'm
> > > > still on leave this week, and when at work I only have physical access to
> > > > the machine concerned on Thursdays at present.
> > > > 
> > > > Which kernel would you prefer I apply the series to?
> > > 
> > > I was very short of time today but I did apply the above series to the
> > > 5.15.y branch (since I had this source available), resulting in version
> > > 5.15.141+.  Unfortunately, in the rush I forgot to do a clean after the
> > > bisect reset, so the resulting kernel was not correctly built.  It booted
> > > but thought it was a different version and therefore none of the modules
> > > could be found.  As a result, the test is invalid.
> > > 
> > > I will try again in a week when I next have physical access to the system. 
> > > Apologies for the delay.  In the meantime, if there's a specific kernel I
> > > should apply the patch series against please let me know.  As I understand
> > > it, you want it applied to one of the kernels which failed, making 5.15.y
> > > (for y < 145) a reasonable choice.
> > 
> > I did a "make clean" to reset the source tree and recompiled.  However, it
> > errored out:
> > 
> >   drivers/pci/setup-bus.c:988:24: error: ‘RESOURCE_SIZE_MAX’ undeclared
> >   drivers/pci/setup-bus.c:998:17: error: ‘pci_bus_for_each_resource’ undeclared
> > 
> > This was with the patch series applied against 5.15.141.  It seems the patch
> > targets a kernel that's too far removed from 5.15.x.
> > 
> > Which kernel would you like me to apply the patch series to and test?
> 
> The rule of thumb is to test against latest vanilla (as of today v6.7).
> Also makes sense to test against Linux Next. The v5.15 is way too old for
> a new code.

Thanks, and understood.  In this case the request from Igor was 

    can you test this series on affected machine with broken kernel to see if
    it's of any help in your case?

The latest vanilla kernel (6.7) has (AFAIK) had the offending commit
reverted, so it's not a "broken" kernel in this respect.  Therefore, if I've
understood the request correctly, working with that kernel won't produce the
desired test.

Regards
  jonathan

