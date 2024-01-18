Return-Path: <linux-pci+bounces-2311-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E43F88312DA
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 07:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B3C0283938
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 06:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CCF8F69;
	Thu, 18 Jan 2024 06:50:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F797481;
	Thu, 18 Jan 2024 06:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.101.241.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705560625; cv=none; b=nDI4/yeeMSBlhkuRLTwN4EwoHroSjNa8wOpGzg2+zGARDIyckmUhOQq3Nh1LMABP/yjIDE40SrYX1VDaEbFofhj3Ddx5MzvQxP4EoqrlzbXwoXr3+kZCcbIhoo6D4e6E5yG+opYaMLak/FCunKVYOWpmgV2cpKS3oVA+kTwgvQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705560625; c=relaxed/simple;
	bh=Thu0mtmAU3blSclLcbZ8kLQKJyxNkZYsKjPWnOmI2Ms=;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-MIMEDefang-action:
	 X-Scanned-By; b=rI41IlgBnHdo8E57s4EdqafFJLYXw+smx2BJV0ur3ZmzSKJx+xGyUFt5Gikx0QaFTI8+9egsC5Uve2aMkx1pnU4RhaJhi6gvQNu+Fs4lPFKQBRdEBavs9l+/XwQZhOw6Em4r7aX8xGCHmHCCNnfJr9YQCNAFwoRPHoW2MAF1prE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=just42.net; spf=pass smtp.mailfrom=just42.net; arc=none smtp.client-ip=150.101.241.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=just42.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=just42.net
Received: from marvin.atrad.com.au (marvin.atrad.com.au [192.168.0.2])
	by server.atrad.com.au (8.17.2/8.17.2) with ESMTPS id 40I6mjS4007416
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 18 Jan 2024 17:18:46 +1030
Date: Thu, 18 Jan 2024 17:18:45 +1030
From: Jonathan Woithe <jwoithe@just42.net>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] PCI: Solve two bridge window sizing issues
Message-ID: <ZajJzcquyvRebAFN@marvin.atrad.com.au>
References: <20231228165707.3447-1-ilpo.jarvinen@linux.intel.com>
 <20240104131210.71f44d4b@imammedo.users.ipa.redhat.com>
 <ZZaiLOR4aO84CG2S@marvin.atrad.com.au>
 <ZZ+gEmxI/TxdbmyQ@marvin.atrad.com.au>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZZ+gEmxI/TxdbmyQ@marvin.atrad.com.au>
X-MIMEDefang-action: accept
X-Scanned-By: MIMEDefang 2.86 on 192.168.0.1

On Thu, Jan 11, 2024 at 06:30:22PM +1030, Jonathan Woithe wrote:
> On Thu, Jan 04, 2024 at 10:48:53PM +1030, Jonathan Woithe wrote:
> > On Thu, Jan 04, 2024 at 01:12:10PM +0100, Igor Mammedov wrote:
> > > On Thu, 28 Dec 2023 18:57:00 +0200
> > > Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:
> > > 
> > > > Hi all,
> > > > 
> > > > Here's a series that contains two fixes to PCI bridge window sizing
> > > > algorithm. Together, they should enable remove & rescan cycle to work
> > > > for a PCI bus that has PCI devices with optional resources and/or
> > > > disparity in BAR sizes.
> > > > 
> > > > For the second fix, I chose to expose find_empty_resource_slot() from
> > > > kernel/resource.c because it should increase accuracy of the cannot-fit
> > > > decision (currently that function is called find_resource()). In order
> > > > to do that sensibly, a few improvements seemed in order to make its
> > > > interface and name of the function sane before exposing it. Thus, the
> > > > few extra patches on resource side.
> > > > 
> > > > Unfortunately I don't have a reason to suspect these would help with
> > > > the issues related to the currently ongoing resource regression
> > > > thread [1].
> > > 
> > > Jonathan,
> > > can you test this series on affected machine with broken kernel to see if
> > > it's of any help in your case?
> > 
> > Certainly, but it will have to wait until next Thursday (11 Jan 2024).  I'm
> > still on leave this week, and when at work I only have physical access to
> > the machine concerned on Thursdays at present.
> > 
> > Which kernel would you prefer I apply the series to?
> 
> I was very short of time today but I did apply the above series to the
> 5.15.y branch (since I had this source available), resulting in version
> 5.15.141+.  Unfortunately, in the rush I forgot to do a clean after the
> bisect reset, so the resulting kernel was not correctly built.  It booted
> but thought it was a different version and therefore none of the modules
> could be found.  As a result, the test is invalid.
> 
> I will try again in a week when I next have physical access to the system. 
> Apologies for the delay.  In the meantime, if there's a specific kernel I
> should apply the patch series against please let me know.  As I understand
> it, you want it applied to one of the kernels which failed, making 5.15.y
> (for y < 145) a reasonable choice.

I did a "make clean" to reset the source tree and recompiled.  However, it
errored out:

  drivers/pci/setup-bus.c:988:24: error: ‘RESOURCE_SIZE_MAX’ undeclared
  drivers/pci/setup-bus.c:998:17: error: ‘pci_bus_for_each_resource’ undeclared

This was with the patch series applied against 5.15.141.  It seems the patch
targets a kernel that's too far removed from 5.15.x.

Which kernel would you like me to apply the patch series to and test?

Regards
  jonathan

