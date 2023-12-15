Return-Path: <linux-pci+bounces-1067-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086F0814970
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 14:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4EC62869C1
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 13:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5E52DB85;
	Fri, 15 Dec 2023 13:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K923AG4h"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2348C2F87A
	for <linux-pci@vger.kernel.org>; Fri, 15 Dec 2023 13:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702647404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PeGoU3o+S7+CrRMsRKZCUSMgsVnOClZrkqDfWJvQpQE=;
	b=K923AG4hHAiwIs3pBFTDm/ggH66pz0nZ5H8TDdVVRhrs+1orKjZgh+vSk3ONeqBySrVOU2
	z16h501A0hH3qu5oTK4Q4/m5ULkKQxCPBp6zxhWQwRrh1dekpZiJQDIRgSPStuqQ+MxOzT
	Cad14185R3WQ5eaRF4W1wLH8i0vMcZM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-ZMcAKaNWPEuDo52AftDjig-1; Fri, 15 Dec 2023 08:36:41 -0500
X-MC-Unique: ZMcAKaNWPEuDo52AftDjig-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40c3cea4c19so5379015e9.1
        for <linux-pci@vger.kernel.org>; Fri, 15 Dec 2023 05:36:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702647400; x=1703252200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PeGoU3o+S7+CrRMsRKZCUSMgsVnOClZrkqDfWJvQpQE=;
        b=a1KmgIrOPdFE4tMDIzC92L8PHnrL72yPsNoEOxLljbs2YCuuHu0o2w6r7rvQZxTOI9
         xaKdxM93QWYGowyQ2/T71fv+BJZEv3cM8QkHyXmgd60VtjaC+uwHXz8twvFPGG6o3ZFz
         dQSSteiR5a+oIF5t6+5dGQkWxMCqbnpj/9H4xyh7P5jr0/izXNjNa+6Jbm6zD4UdR9iB
         W7J9azfNOfWphs5CvQbqYXVb+XW5llhx0U3jxecgFcYPenOAb1dicrfb8uCGgJoQwiNX
         VbyWROF2Bc7YNRe+mHJ/iQ8qnsuL5KoriA8/Ulj+txB1ggvKE4Nl47j0lFFFP+mV9xfO
         GfZA==
X-Gm-Message-State: AOJu0YzhH+7b/M9/xtw7RD+gYJexp8sJCjYNWkL9ZM6f48t4hd35cfNk
	eVV05OzvGSt1AJNmmpvOloq0eHr+Vjo+pDN49OLhobG5DitokE1TKXaTmvYpCQSq/9oZBxngesk
	26QsxBzzEOHFPaaiWn8sw
X-Received: by 2002:a05:600c:30d2:b0:40c:4378:f111 with SMTP id h18-20020a05600c30d200b0040c4378f111mr4670766wmn.80.1702647400352;
        Fri, 15 Dec 2023 05:36:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNqnCnqPED8jOPTrsrHmCaOogZEFFYNAlGMfhhBxoxOjIysGAkQmntROKUnv2U3WFzoyYr1A==
X-Received: by 2002:a05:600c:30d2:b0:40c:4378:f111 with SMTP id h18-20020a05600c30d200b0040c4378f111mr4670759wmn.80.1702647399910;
        Fri, 15 Dec 2023 05:36:39 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id kt17-20020a1709079d1100b00a015eac52dcsm10720815ejc.108.2023.12.15.05.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 05:36:39 -0800 (PST)
Date: Fri, 15 Dec 2023 14:36:38 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Woithe <jwoithe@just42.net>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [Regression] Commit 40613da52b13 ("PCI: acpiphp: Reassign
 resources on bridge if necessary")
Message-ID: <20231215143638.032028eb@imammedo.users.ipa.redhat.com>
In-Reply-To: <ZXw4Ly/csFgl76Lj@marvin.atrad.com.au>
References: <ZXpaNCLiDM+Kv38H@marvin.atrad.com.au>
	<20231214143205.4ba0e11a@imammedo.users.ipa.redhat.com>
	<ZXt+BxvmG6ru63qJ@marvin.atrad.com.au>
	<ZXw4Ly/csFgl76Lj@marvin.atrad.com.au>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Dec 2023 21:57:43 +1030
Jonathan Woithe <jwoithe@just42.net> wrote:

> On Fri, Dec 15, 2023 at 08:43:29AM +1030, Jonathan Woithe wrote:
> > On Thu, Dec 14, 2023 at 02:32:05PM +0100, Igor Mammedov wrote:  
> > > On Thu, 14 Dec 2023 11:58:20 +1030 Jonathan Woithe wrote:  
> > > > 
> > > > Following an update from 5.15.72 to 5.15.139 on one of my machines, the  
> > > 
> > > looks like you are running downstream kernel, can you file bug report
> > > with distro that you use (with a link posed here as well).  
> > 
> > I am running Slackware64 15.0.  The kernels supplied by that distribution
> > are unmodified kernel.org kernels.
> >   
> > > For now offending patches are being reverted, so downstream bug will help
> > > with tracking it and reverting it there.   
> > 
> > The patches will be reverted in Slackware as a matter of course when a
> > kernel.org "-stable" kernel with the fix is adopted.  Slackware does not
> > apply any patches to kernel.org kernels.  Nevertheless, I will raise a post
> > in the forum, hopefully later today.  
> 
> This has now been done:
> 
>   https://www.linuxquestions.org/questions/slackware-14/heads-up-pci-regression-introduced-in-or-around-5-15-129-commit-40613da52b13-4175731828/#post6470559
> 
> > > > The output of lspci is given at the end of this post[1].  The CPU is an
> > > > "Intel(R) Core(TM) i7-5930K CPU @ 3.50GHz" which is not overclocked.  Please
> > > > let me know if you'd like more information about the affected machine.  I
> > > > can also perform additional tests if required, although for various reasons
> > > > these can only be done on Thursdays at present.
> > > > 
> > > > The kernel configuration file can easily be supplied if that would be
> > > > useful.  
> > > 
> > > full dmesg log and used config might help down the road (preferably with current
> > > upstream kernel), as I will be looking into fixing related issues.
> > > 
> > > Perhaps a better way for taking this issue and collecting logs, will be
> > > opening a separate bug at https://bugzilla.kernel.org (pls CC me as well)  
> > 
> > Sure, will do.  I'll be able to get the dmesg log from my earlier tests and
> > config easily enough.  Testing with another kernel will have to wait until
> > next Thursday as that is when I'll next have physical access to the machine.  
> 
> A bug has been opened at bugzilla.kernel.org as requested.  The logs, kernel
> configuration and the "lspci -tv" output (requested in a subsequent email)
> have been added.  The logs and kernel configuration are from the kernel.org
> 5.15.139 kernel.  You have been added to the bug's CC.  The bug number is
> 218268:
> 
>   https://bugzilla.kernel.org/show_bug.cgi?id=218268
> 
> As mentioned, testing another kernel can only happen next Thursday.  If
> you would like other tests done let me know and I'll do them at the same
> time.  I have remote access to the machine, so it's possible to retrieve
> information from it at any time.

lets wait till you can get logs with dyndbg='...' (I've asked for earlier)
and one more test with "pci=realloc" on kernel CLI to see if that helps.

> Let me know if there's anything else I can do to assist.

It looks like  pci_assign_unassigned_bridge_resources() messed up BIOS configured
resources. And then didn't manage to reconfigure bridges correctly, which led to
unassigned BARs => thunderbolt/VGA issues.

Something in ACPI tables must be triggering acpiphp hotplug path during boot.
Can you dump DSDT + SSDT tables and attach them to BZ.
PS:
to dump tables you can use command from acpica-tools (not sure how it's called in Slackware) 
 acpidump -b
which will dump all tables in binary format (so attach those or 'iasl -d' de-compiled ones)

> 
> Regards
>   jonathan
> 


