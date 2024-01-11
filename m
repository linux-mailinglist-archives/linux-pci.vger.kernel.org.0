Return-Path: <linux-pci+bounces-2035-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C13982A8A3
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 09:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 377251F23734
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 08:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5682ED2EA;
	Thu, 11 Jan 2024 08:02:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5879CDDA8;
	Thu, 11 Jan 2024 08:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=just42.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=just42.net
Received: from marvin.atrad.com.au (marvin.atrad.com.au [192.168.0.2])
	by server.atrad.com.au (8.17.2/8.17.2) with ESMTPS id 40B80IuY005806
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 11 Jan 2024 18:30:19 +1030
Date: Thu, 11 Jan 2024 18:30:18 +1030
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
Message-ID: <ZZ+gEmxI/TxdbmyQ@marvin.atrad.com.au>
References: <20231228165707.3447-1-ilpo.jarvinen@linux.intel.com>
 <20240104131210.71f44d4b@imammedo.users.ipa.redhat.com>
 <ZZaiLOR4aO84CG2S@marvin.atrad.com.au>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZZaiLOR4aO84CG2S@marvin.atrad.com.au>
X-MIMEDefang-action: accept
X-Scanned-By: MIMEDefang 2.86 on 192.168.0.1

On Thu, Jan 04, 2024 at 10:48:53PM +1030, Jonathan Woithe wrote:
> On Thu, Jan 04, 2024 at 01:12:10PM +0100, Igor Mammedov wrote:
> > On Thu, 28 Dec 2023 18:57:00 +0200
> > Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:
> > 
> > > Hi all,
> > > 
> > > Here's a series that contains two fixes to PCI bridge window sizing
> > > algorithm. Together, they should enable remove & rescan cycle to work
> > > for a PCI bus that has PCI devices with optional resources and/or
> > > disparity in BAR sizes.
> > > 
> > > For the second fix, I chose to expose find_empty_resource_slot() from
> > > kernel/resource.c because it should increase accuracy of the cannot-fit
> > > decision (currently that function is called find_resource()). In order
> > > to do that sensibly, a few improvements seemed in order to make its
> > > interface and name of the function sane before exposing it. Thus, the
> > > few extra patches on resource side.
> > > 
> > > Unfortunately I don't have a reason to suspect these would help with
> > > the issues related to the currently ongoing resource regression
> > > thread [1].
> > 
> > Jonathan,
> > can you test this series on affected machine with broken kernel to see if
> > it's of any help in your case?
> 
> Certainly, but it will have to wait until next Thursday (11 Jan 2024).  I'm
> still on leave this week, and when at work I only have physical access to
> the machine concerned on Thursdays at present.
> 
> Which kernel would you prefer I apply the series to?

I was very short of time today but I did apply the above series to the
5.15.y branch (since I had this source available), resulting in version
5.15.141+.  Unfortunately, in the rush I forgot to do a clean after the
bisect reset, so the resulting kernel was not correctly built.  It booted
but thought it was a different version and therefore none of the modules
could be found.  As a result, the test is invalid.

I will try again in a week when I next have physical access to the system. 
Apologies for the delay.  In the meantime, if there's a specific kernel I
should apply the patch series against please let me know.  As I understand
it, you want it applied to one of the kernels which failed, making 5.15.y
(for y < 145) a reasonable choice.

Regards
  jonathan

