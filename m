Return-Path: <linux-pci+bounces-23260-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CBCA58920
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 00:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6D9F169B33
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 23:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7B71DE880;
	Sun,  9 Mar 2025 23:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvKPC7u5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68D442A93;
	Sun,  9 Mar 2025 23:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741561872; cv=none; b=rLCaqtp/CChvIc/mfyoJHy2+Fg1tbmpTWm4IW4ncqxXqFhdykBJ7q0QvI1TIQj3QL0NR+yYbdIycICTJXRFzzAFeiLkZQ9TtkPaIZ7iz1v6fHDcF46lqu9m2RYMlooXq+yeMtF6rXY9nhejGhpohCvEmWSIjtkEzec+qN4eiZpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741561872; c=relaxed/simple;
	bh=atcNgUQAREeh0fhb4DRMjchCgwjfjadvjS4sJmAd6J4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LOHPqvodpl8VoDEYKAO6/adckAuus9+JNNzDqNxMG42InZUve3y3P8KVUsqLcWBnXBR1W0pycFVYkNQIuGXtx7UtNGGhU5fgzVPcaQWVi9iHQ9T4HQWmyEtCWiliHxs8Gcs47XdeRnt9A+vgoOpF3a3IUU9tzcbc+nGaPSFqrws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvKPC7u5; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fec3176ef3so5026275a91.1;
        Sun, 09 Mar 2025 16:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741561870; x=1742166670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3shQeLIb87O/RRIaqXwJ5kPUFh1GOsvFtb4du+fw5o=;
        b=KvKPC7u5awFSZ0H3pwXmxBLl5SSaKv/XStOCQsWuEFzHuKi9ODuz342CoX8TRG64eu
         cx/T6Uio8RM2+7LNrVNjoauWQQYYS/tD9KEyZ/2eA7/mqTAGNEwLSEYbQq9zmTd+6ZhL
         KlV1GggLQktT9QxI3xIy8c59v0LyBfmodBDGY4AlKB2ggr4Fah9a525eJL5ppAAS8G+X
         3hCWMGOEfeLWOjlqp8mF6PwkxK2UdHJ+0ZyGZqkmhps5A3m6HkjohpLH/UXCrqZlR03N
         0I+UDcoor53iQwdAYxRiIcNIKIxgX91D/9B9ApCsCdgxSQARZt1vP9NL0O5PnKy5RZ0g
         48GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741561870; x=1742166670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3shQeLIb87O/RRIaqXwJ5kPUFh1GOsvFtb4du+fw5o=;
        b=vA9YalCziNaaG9u4baqwCoUrJk+aqcRNLsEyWLTF7VCYcN+iAH+D4umgTGJnnTsZPx
         AKMmHBZNgWTGzgkDeKiGJKQFbPX8vhUhd3B8G6na2/+vGjovb6TiSztSDoASQLdFnXv4
         USj6ZxnI7JfUZzs0mvCKePTKdhMRu8chK5jtLyVdlUPrWS8GL+f0JiqwgIc7D9LL7PXq
         R3o8X73AhKlAtRWCHgpziJDQK9aINRX5gSQsHPrN7EMbCAOcQe9hmepOkPr1dkTi7E+C
         /9/zva5Ku5dchcSxBfzaQ8BoXRJi01+MctLp71sTxOMNOgVt/kHSLTGbhL0AdMhi76rL
         FKig==
X-Forwarded-Encrypted: i=1; AJvYcCU2IHo03pC+kJ4grj8mfm00wkaWjhFWPLfxrSEmkncbDcMHK89ZgpEjr95chuDFeTboWHpRYK2fm2pkncc=@vger.kernel.org, AJvYcCWdDRSBYrm0EOKVqRWiz/VFRxonse8ACcejtgaXagQGmPICbGgcq5GiUruA9TvZy3mvVNZtA0yDPrSU@vger.kernel.org
X-Gm-Message-State: AOJu0YyCAVmDmTyJ7wSgf41NlaCxA3IlJMJCPdPBM7i7gcMkVz4Vb/ym
	rUvIfqHPjn2s40RgzQag6uw/Vk4eh29FPYGtVckWCVfMLghKrMxS4Um18Ba6Dvn4xDS2iFUSyb1
	ogbg5xK3/Xx0srPdl/0Lg2ZnSVhM=
X-Gm-Gg: ASbGncsvdAIHS5Rsumw0KjhgDiYbtquS6rCYBJaoJfsZQRMeg0pI+6rCd+WkkyMGg8R
	C/iwaDJiKPo52ylp9yiRKpL4xpL5UhL15R5IDoMkhpa6WQVSIgEw1OWa/IT6MoOsQXKhZlcYg/C
	j9BqjTAI0xIUBrMF3ahLigy9+RACc=
X-Google-Smtp-Source: AGHT+IFe2StKic7zJ9Jgf5erx9+TI5xxzkr/gT5dQYlAUYkc/bIxUrE7KMGg6WyvNMafLmzlkJP6r+I4HMQcHz/VXCw=
X-Received: by 2002:a17:90b:2e51:b0:2fe:8282:cb9d with SMTP id
 98e67ed59e1d1-2ff7cee9c3fmr17474627a91.28.1741561869860; Sun, 09 Mar 2025
 16:11:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEzXK1qtSRVS0TYAwMHTYh=7edO604iRKuXMQNMO_MC+-hunQg@mail.gmail.com>
 <20250303202127.GA192918@bhelgaas>
In-Reply-To: <20250303202127.GA192918@bhelgaas>
From: =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date: Sun, 9 Mar 2025 23:10:58 +0000
X-Gm-Features: AQ5f1JrX_WRbHkZhleekcYsB7cCyzfBQFLDu6wL5tcoddQB-SqXNxBX-sbmbh6U
Message-ID: <CAEzXK1qwHf5no6B2eCX1U7NGe-BoJYFLTHPkbM=_XpgrMAE2dw@mail.gmail.com>
Subject: Re: [PATCH] PCI: mvebu: Use devm_request_irq() for registering
 interrupt handler
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the delay, but last week was a busy work week and I had to
struggle to package Linux kernel 6.14-rc5 because it fails to
cross-compile... it tries to use target compiler flags with the host
compiler. I ended up compiling the kernel in a mvebu armhf machine.
Also I noticed that some hash algos are failing.

All logs presented were obtained from a SolidRun A388 ClearFog Base,
if more detailed PCI logs are needed I have the other machine, the
Armada Duo that has 2 PCIe slots and handles an AMD RX 550 GPU. Just
let me know.

- Complete dmesg log, booted with "pci=3Dnomsi"  is available here:
https://pastebin.com/wDj0NGFN
- Complete output of "sudo lspci -vv" is available here:
https://pastebin.com/f4yHRhLr
- Contents of /proc/interrupts is available here: https://pastebin.com/ejDU=
uhbJ
- Output of "grep -r . /proc/irq/" is available here:
https://pastebin.com/4jvFBBhy

Let me know if more information is needed.

On Mon, Mar 3, 2025 at 8:21=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Sat, Mar 01, 2025 at 07:49:23PM +0000, Lu=C3=ADs Mendes wrote:
> > ... I would like to offer my help for testing the patches with your
> > guidance.
> >
> > ... In any way, long story short I've read in some threads about
> > mvebu that PCIe is broken, and I say that it is not, the secret to
> > have PCIe working is to use a good u-boot bootloader. Many recent
> > u-boot versions cause the PCIe not to work on boot and I haven't
> > figured out why yet. In fact my A388 systems are working with the
> > amdgpu driver and an AMD Polaris, a RX 550 with 4GB VRAM. I have
> > been succesfully using PCIe with this old u-boot version:
> > https://github.com/SolidRun/u-boot-armada38x repo and branch
> > u-boot-2013.01-15t1-clearfog.
>
> Glad to hear that.  Making this work with more versions of u-boot
> would be great, and maybe we can make progress on that eventually.
>
> For right now, I want to try to make progress on Pali's patches.  I'm
> pretty much in the dark as far as mvebu and IRQ details, but it might
> help enlighten me if you could collect these:
>
>   - complete dmesg log, booted with "pci=3Dnomsi"
>   - complete output of "sudo lspci -vv"
>   - contents of /proc/interrupts
>   - output of "grep -r . /proc/irq/"
>
> For now just pick one of your systems, probably the solidrun one since
> that sounds like one that other folks might have.
>
> Bjorn

