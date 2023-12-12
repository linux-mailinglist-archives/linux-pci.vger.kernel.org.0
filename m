Return-Path: <linux-pci+bounces-815-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E097180F761
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 21:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 955771F2159C
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 20:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A8F52761;
	Tue, 12 Dec 2023 20:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LzvS8TuL"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AECEA6
	for <linux-pci@vger.kernel.org>; Tue, 12 Dec 2023 12:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702411382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nLTa2dYRrf09pJMNBsngii2VsJyLNKDZosllwS5YIfQ=;
	b=LzvS8TuLRxUNpoX79j0z4hqn2bRJUhI/a1kyJkaOR8ADRvxOoV6iygk0Kc9hd6y5kPTQP+
	+oYM3GJe8vx1L+6HJa7Epu46Me3RYtAadGSHHnsFaxls1z4ulswCLywd77AgwFaYxkxeRh
	RSiENNEsinwZUswhwk+T/UEqxMQdEBo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-u9wrAA1NPAygQ1Uxqbfing-1; Tue, 12 Dec 2023 15:03:01 -0500
X-MC-Unique: u9wrAA1NPAygQ1Uxqbfing-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-54cd2281cd2so8068934a12.1
        for <linux-pci@vger.kernel.org>; Tue, 12 Dec 2023 12:03:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702411380; x=1703016180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLTa2dYRrf09pJMNBsngii2VsJyLNKDZosllwS5YIfQ=;
        b=Qo10nJ41CQJkmtbIL/hngco2C5uZQH0Y/D5r25e2383ZMxxSbp9ul+G8okgGZMh6vQ
         gL3STWcHkYh9Edqr6QtbEmBY4nn+wtw5u520NuFTg9jhXyLYSuZS1MkJN1VBSCTcNUOZ
         vMTbZG+icIYZjod9YLA9SfzdxI5STW9aOUme9vD+YgOv7hAPIo0U3N+yajeZH1itXN8k
         0uUgEhvXtvgdflz5ERv9t4Lc7UC4PQs0djdF2jChGsdXPeEoURybWO51bvNOnNzpnkb8
         XB6fhsM2spyFqCIX0NycWfgTLTgoLe1rPna6WA8ViwlM6zC8/JMvDX10km5ACnOZLBEh
         RW1g==
X-Gm-Message-State: AOJu0Yz9PpxGRt45GsG9g/kXAZrvyFH3eg+afFpmQ9PRA3xQ7ryf9CeH
	hNDHZYC5vEPTUQ3i1XXVXHV6RWbikid+rPUD3KSU35IYDmb9YxFG067LbuHq4BsGOZC6oJ9TUo6
	/mndQTHK+TF8oK1D7Bt5l
X-Received: by 2002:a17:906:9588:b0:a1c:c2f9:980d with SMTP id r8-20020a170906958800b00a1cc2f9980dmr6331024ejx.27.1702411380006;
        Tue, 12 Dec 2023 12:03:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRYpIZTRZBTE4WcrlyktfS653hxvSiRGlBv7+Y1axU2HeESlSi0L3nguCi3mJ4p5t6evrUkA==
X-Received: by 2002:a17:906:9588:b0:a1c:c2f9:980d with SMTP id r8-20020a170906958800b00a1cc2f9980dmr6331007ejx.27.1702411379730;
        Tue, 12 Dec 2023 12:02:59 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com ([185.140.112.229])
        by smtp.gmail.com with ESMTPSA id tl18-20020a170907c31200b00a1da2c9b06asm6698148ejc.42.2023.12.12.12.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 12:02:58 -0800 (PST)
Date: Tue, 12 Dec 2023 21:02:57 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhelgaas@google.com, lenb@kernel.org, rafael@kernel.org, Thomas Lamprecht
 <t.lamprecht@proxmox.com>, mst@redhat.com, Dongli Zhang
 <dongli.zhang@oracle.com>
Subject: Re: SCSI hotplug issues with UEFI VM with guest kernel >= 6.5
Message-ID: <20231212210257.5ddbff0d@imammedo.users.ipa.redhat.com>
In-Reply-To: <20231212162529.09c27fdf@imammedo.users.ipa.redhat.com>
References: <9eb669c0-d8f2-431d-a700-6da13053ae54@proxmox.com>
	<20231207232815.GA771837@bhelgaas>
	<20231208164723.12828a96@imammedo.users.ipa.redhat.com>
	<20231211084604.25e209af@imammedo.users.ipa.redhat.com>
	<c6233df5-01d8-498f-8235-ce4b102a2e91@proxmox.com>
	<20231212122608.1b4f75ce@imammedo.users.ipa.redhat.com>
	<62363899-d7aa-4f1c-abfa-1f87f0b6b43f@proxmox.com>
	<20231212162529.09c27fdf@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Dec 2023 16:25:29 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> On Tue, 12 Dec 2023 13:50:20 +0100
> Fiona Ebner <f.ebner@proxmox.com> wrote:
> 
> > Am 12.12.23 um 12:26 schrieb Igor Mammedov:  
> > > 
> > > it's not necessary, but it would help to find out what's going wrong faster.
> > > Otherwise we would need to fallback to debugging over email.
> > > Are you willing to help with testing/providing debug logs to track down
> > > the cause?.
> > >     
> > 
> > I submitted the dmesg logs in bugzilla:
> > https://bugzilla.kernel.org/show_bug.cgi?id=218255
> >   
> > > Though debug over email would be slow, so our best option is to revert
> > > offending patches until the cause if found/fixed.
> > >     
> > >>>>> Do you have to revert both cc22522fd55e2 and 40613da52b13f to make it
> > >>>>> work reliably?  If we have to revert something, reverting one would be
> > >>>>> better than reverting both.        
> > >>>>      
> > >>
> > >> Just reverting cc22522fd55e2 is not enough (and cc22522fd55e2 fixes
> > >> 40613da52b13f so I can't revert just 40613da52b13f).    
> > > 
> > > With UEFI setup, it still works for me fine with current master.
> > > 
> > > Kernel 6.7.0-rc5-00014-g26aff849438c on an x86_64 (ttyS0)
> > >     
> > 
> > I also built from current master (still 26aff849438c) to verify and it's
> > still broken for me.
> >   
> > > 
> > > it still doesn't work with Fedora's 6.7.0-0.rc2.20231125git0f5cc96c367f.26.fc40.x86_64 kernel.
> > > However it's necessary to have -smp 4 for it to break,
> > > with -smp 1 it works fine as well.
> > >     
> > 
> > For me it's (always with build from current master):
> > 
> > -smp 1 -> it worked 5 times out of 5
> > -smp 2 -> it worked 3 times out of 5
> > -smp 4 -> it worked 0 times out of 5
> > -smp 8 -> it worked 0 times out of 5  
> 
> 
> I managed to reproduce it with upstream using fedora 40 config as is
> (without converting it to mod2yesconfig).
> So give me a couple of days to debug it before reverting.

Actually here is another report + analysis explaining where the race is happening:
https://www.spinics.net/lists/kernel/msg5033061.html

That's the reason why my minimal config worked
(based on defconfig where CONFIG_SCSI_SCAN_ASYNC in not enabled by default for x86)

While distros (at least some) do enable it.

> 
> > 
> > Best Regards,
> > Fiona
> >   
> 


