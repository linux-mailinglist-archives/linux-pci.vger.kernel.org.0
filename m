Return-Path: <linux-pci+bounces-10842-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 058D193D375
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 14:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81D4BB20F26
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 12:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0C417B437;
	Fri, 26 Jul 2024 12:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="ko+oh1yW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306FB2B9DB;
	Fri, 26 Jul 2024 12:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721998177; cv=none; b=HAuqpP0lE9eLwCFSuNpMNEv4FuRlLLQ/b4xfMDXeyp7bh3RNRS9/Lkf/QqWxn0PPZ3JY/ZsAUHl40FIcr7N0PqQlb3prJC9Jla9fxQilt/jf5JIN3rkC/9FAfLv7iNePbMmQ8CMb9ikddJaSSEFrmgU5CvwEVX2g52EKbONclf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721998177; c=relaxed/simple;
	bh=CG58Cw01rwsoyFtR++iSV0HzK97O4jr4VBnptMsETWA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f70B+IuW4F7ClW0V/7s5CvdAo6J2N3+zhIvku6Sqse779aNZpvaU1RnI0OGwSZWMrKcOzo4fxVfsvmkEoCtfJZj4EwRAl3WhGgks/HQspq5r8KB5Ih2ItcNxRiF6jlHH+meeDj/lAlzFzXm/BKeO7RW8JkLxMrVLbddst+fwGX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=ko+oh1yW; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1721998173;
	bh=FbjGrZAf4KleDcOMWprQnrXa/ICyg2tclBDC0d6LUpM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ko+oh1yWmHuJ28MuSfSmWMSNvw/3PNVTmZhhgZO3y/QcEE8E5mIEiGRDDVZtk5SA3
	 DSwzeimB8ywiZbBMODXyn6E3xM1JH0JxV/aLtd1QGSvDmH0yzkKKa9bG8hiA5NgRKC
	 xgyhcypHpdkzlJONdYHOJh1PbUY+RfLi2lOLNVXFZ2Mtu8zBkRBjE+WI0vLEP3z9P+
	 nX0VvkHtfXlv+O+hkN8NjHNWCrXdHF7EVn8l3kuxbFtZYJJgzZUSv0ZI3+4XmjYaAj
	 XXn1CNLfxSLNtpFcC7HVKXAo4pfHsaM5mjhG0xQrBqhT3aKb+lDVY8fI/M6cV8UPKG
	 FtP423ZOyfizA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WVndS1hY7z4w2M;
	Fri, 26 Jul 2024 22:49:32 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Lizhi Hou <lizhi.hou@amd.com>, Rob Herring <robh@kernel.org>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Saravana
 Kannan <saravanak@google.com>, Vaibhav Jain <vaibhav@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Vaidyanathan Srinivasan
 <svaidy@linux.ibm.com>, Kowshik Jois B S <kowsjois@linux.ibm.com>, Lukas
 Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2] PCI: Fix crash during pci_dev hot-unplug on pseries
 KVM guest
In-Reply-To: <dx32q3sa4oopk3fnm2zyeplotuq6gq3rmnbmaw3mo4q3lgjpe7@gvpgu4rdk4f4>
References: <p6cs4fxzistpyqkc5bv2sb76inrw7fterocdcu3snnyjpqydbr@thxna6v2umrl>
 <20240725205537.GA858788@bhelgaas>
 <dx32q3sa4oopk3fnm2zyeplotuq6gq3rmnbmaw3mo4q3lgjpe7@gvpgu4rdk4f4>
Date: Fri, 26 Jul 2024 22:49:31 +1000
Message-ID: <87sevwuxlw.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Amit Machhiwal <amachhiw@linux.ibm.com> writes:
> Hi Bjorn,
>
> On 2024/07/25 03:55 PM, Bjorn Helgaas wrote:
>> On Thu, Jul 25, 2024 at 11:15:39PM +0530, Amit Machhiwal wrote:
>> > ...
>> > The crash in question is a critical issue that we would want to have
>> > a fix for soon. And while this is still being figured out, is it
>> > okay to go with the fix I proposed in the V1 of this patch?
>> 
>> v6.10 has been released already, and it will be a couple months before
>> the v6.11 release.
>> 
>> It looks like the regression is 407d1a51921e, which appeared in v6.6,
>> almost a year ago, so it's fairly old.
>> 
>> What target are you thinking about for the V1 patch?  I guess if we
>> add it as a v6.11 post-merge window fix, it might get backported to
>> stable kernels before v6.11?  
>
> Yes, I think we can go ahead with taking V1 patch for v6.11 post-merge window to
> fix the current bug and ask Ubuntu to pick it while Lizhi's proposed patch goes
> under test and review.

Lizhi's proposed patch (v3?) looks pretty small and straight forward.
It should be possible to get it tested and reviewed and merge it as a
fix during the v6.11-rc series.

Or if the CONFIG option is completely broken as Rob suggests then it
should just be forced off in Kconfig.

cheers

