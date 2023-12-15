Return-Path: <linux-pci+bounces-1080-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE1E815494
	for <lists+linux-pci@lfdr.de>; Sat, 16 Dec 2023 00:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69F251C239AA
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 23:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA2418ED8;
	Fri, 15 Dec 2023 23:35:53 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1741118ECB;
	Fri, 15 Dec 2023 23:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=just42.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=just42.net
Received: from marvin.atrad.com.au (marvin.atrad.com.au [192.168.0.2])
	by server.atrad.com.au (8.17.2/8.17.2) with ESMTPS id 3BFNZKjE001393
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 16 Dec 2023 10:05:22 +1030
Date: Sat, 16 Dec 2023 10:05:20 +1030
From: Jonathan Woithe <jwoithe@just42.net>
To: Igor Mammedov <imammedo@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Regression] Commit 40613da52b13 ("PCI: acpiphp: Reassign
 resources on bridge if necessary")
Message-ID: <ZXziuPCKNBLhbssO@marvin.atrad.com.au>
References: <ZXpaNCLiDM+Kv38H@marvin.atrad.com.au>
 <20231214143205.4ba0e11a@imammedo.users.ipa.redhat.com>
 <ZXt+BxvmG6ru63qJ@marvin.atrad.com.au>
 <ZXw4Ly/csFgl76Lj@marvin.atrad.com.au>
 <20231215143638.032028eb@imammedo.users.ipa.redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215143638.032028eb@imammedo.users.ipa.redhat.com>
X-MIMEDefang-action: accept
X-Scanned-By: MIMEDefang 2.86 on 192.168.0.1

On Fri, Dec 15, 2023 at 02:36:38PM +0100, Igor Mammedov wrote:
> On Fri, 15 Dec 2023 21:57:43 +1030
> Jonathan Woithe <jwoithe@just42.net> wrote:
> 
> > On Fri, Dec 15, 2023 at 08:43:29AM +1030, Jonathan Woithe wrote:
> > > On Thu, Dec 14, 2023 at 02:32:05PM +0100, Igor Mammedov wrote:  
> > > > On Thu, 14 Dec 2023 11:58:20 +1030 Jonathan Woithe wrote:  
> > > > > 
> > > > > Following an update from 5.15.72 to 5.15.139 on one of my machines, the  
> > > > 
> > > > looks like you are running downstream kernel, can you file bug report
> > > > with distro that you use (with a link posed here as well).  
> > > 
> > > I am running Slackware64 15.0.  The kernels supplied by that distribution
> > > are unmodified kernel.org kernels.
> > >   
> > > > For now offending patches are being reverted, so downstream bug will help
> > > > with tracking it and reverting it there.   
> > > 
> > > The patches will be reverted in Slackware as a matter of course when a
> > > kernel.org "-stable" kernel with the fix is adopted.  Slackware does not
> > > apply any patches to kernel.org kernels.  Nevertheless, I will raise a post
> > > in the forum, hopefully later today.  
> > 
> > This has now been done:
> > 
> >   https://www.linuxquestions.org/questions/slackware-14/heads-up-pci-regression-introduced-in-or-around-5-15-129-commit-40613da52b13-4175731828/#post6470559
> > 
> > > > > The output of lspci is given at the end of this post[1].  The CPU is an
> > > > > "Intel(R) Core(TM) i7-5930K CPU @ 3.50GHz" which is not overclocked.  Please
> > > > > let me know if you'd like more information about the affected machine.  I
> > > > > can also perform additional tests if required, although for various reasons
> > > > > these can only be done on Thursdays at present.
> > > > > 
> > > > > The kernel configuration file can easily be supplied if that would be
> > > > > useful.  
> > > > 
> > > > full dmesg log and used config might help down the road (preferably with current
> > > > upstream kernel), as I will be looking into fixing related issues.
> > > > 
> > > > Perhaps a better way for taking this issue and collecting logs, will be
> > > > opening a separate bug at https://bugzilla.kernel.org (pls CC me as well)  
> > > 
> > > Sure, will do.  I'll be able to get the dmesg log from my earlier tests and
> > > config easily enough.  Testing with another kernel will have to wait until
> > > next Thursday as that is when I'll next have physical access to the machine.  
> > 
> > A bug has been opened at bugzilla.kernel.org as requested.  The logs, kernel
> > configuration and the "lspci -tv" output (requested in a subsequent email)
> > have been added.  The logs and kernel configuration are from the kernel.org
> > 5.15.139 kernel.  You have been added to the bug's CC.  The bug number is
> > 218268:
> > 
> >   https://bugzilla.kernel.org/show_bug.cgi?id=218268
> > 
> > As mentioned, testing another kernel can only happen next Thursday.  If
> > you would like other tests done let me know and I'll do them at the same
> > time.  I have remote access to the machine, so it's possible to retrieve
> > information from it at any time.
> 
> lets wait till you can get logs with dyndbg='...' (I've asked for earlier)
> and one more test with "pci=realloc" on kernel CLI to see if that helps.

Okay.

> > Let me know if there's anything else I can do to assist.
> 
> It looks like  pci_assign_unassigned_bridge_resources() messed up BIOS configured
> resources. And then didn't manage to reconfigure bridges correctly, which led to
> unassigned BARs => thunderbolt/VGA issues.
> 
> Something in ACPI tables must be triggering acpiphp hotplug path during boot.
> Can you dump DSDT + SSDT tables and attach them to BZ.
> PS:
> to dump tables you can use command from acpica-tools (not sure how it's called in Slackware) 
>  acpidump -b
> which will dump all tables in binary format (so attach those or 'iasl -d' de-compiled ones)

Slackware doesn't provide acpidump AFAIK but it was easy enough to compile
from tools/power/acpi/tools/acpidump within the 5.15.72 tree I'd used
previously to build 5.15.72 (the kernel that's currently running).  However,
running

  acpidump -b

resulted in a segmentation fault.  The root cause is line 339 in vsnprintf()
in utprint.c.  With a workaround in place a functional acpidump was
obtained.  I can provide further information from my analysis if it's
appropriate and you're interested.

For completeness I then tried the acpica source from Intel (version
20230628).  The acpidump from this worked fine, and the files produced were
identical to those from my fixed kernel-tree acpidump.  A tarball of these
is now attached to the Bugzilla report.  Curiously enough, the corresponding
vsnprintf() line in the Intel acpica source distribution matches that in the
5.15.72 source.  Perhaps the compiler flags in the Intel package happen to
prevent the segfault condition occurring at runtime for me.

Regards
  jonathan

