Return-Path: <linux-pci+bounces-798-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EF780EA54
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 12:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 973E01F21475
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 11:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FE65CD1C;
	Tue, 12 Dec 2023 11:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bBWFVO8a"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89596D2
	for <linux-pci@vger.kernel.org>; Tue, 12 Dec 2023 03:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702380373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3VCPhUza2WDSv0OPfffTIRcwZLYS7Z9nqJ6x5U/LS9Q=;
	b=bBWFVO8abE1MvoGAUmIw1tpkU4b+auH2Tz+G/5gbEN25GIK/O8Gz6GqDejs6+LD3Whq2Wm
	QRm6/JIxD18iwR8rbTwxdNUHgDaZjAtSSFRL4fadlnb4cqlXD4VsTvmOaPK2udke6YU35b
	X7LEKVR0I78CbSW1l3JNBa2/pfWu8bA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-k8F92_nMMjm5aeBirgTXYg-1; Tue, 12 Dec 2023 06:26:12 -0500
X-MC-Unique: k8F92_nMMjm5aeBirgTXYg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a1d0767f0b3so297491266b.2
        for <linux-pci@vger.kernel.org>; Tue, 12 Dec 2023 03:26:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702380371; x=1702985171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3VCPhUza2WDSv0OPfffTIRcwZLYS7Z9nqJ6x5U/LS9Q=;
        b=M5p7DJcRTkOj4jXYNqYPeJOYVQNryDYXNOkkbb501+t04tMMe1WjXlLvMN0aoDUMBI
         gYLOKgEEc5QmrpGMDFUDZphFepGFo0RqBw1LvdUkGSiAErZy+b3eJV2EwPjRFLZIiaKi
         64Q67OwuyD6HjZ+32I34ydLAirp5B/l36PFuLB5XPU1GDcALq9Ku8TBesDEpqnZOUaCT
         z1DgXYup37CMRWNBi9d/pHlhhG7TH6Y16Xl7TP3wPfIfQrzBSFbcS0uatZZgRh5UQNIL
         vT9SEJ3+Bq5rZUYW0knJhB9I7QdnhQhQdIOOyYclB4r6Gmf/+j8eogSxIBIRpjIsHqx5
         kd8w==
X-Gm-Message-State: AOJu0Yz7OdK4IrlIQlT5X8Pc6oPsf1k3nCgQukCqcVGGs3lUzfYaHHFy
	LO2tuSs3ZJF+gskg3IKD8LLayyo/AXh8yN0U4vObtOHa+rdZwXhNsVmqvsDu8eek7yrutMCsPnH
	k1YpWKu4Mebf0KVt1JnRQkmag3pBx
X-Received: by 2002:a17:907:8688:b0:a19:a19b:55eb with SMTP id qa8-20020a170907868800b00a19a19b55ebmr3739492ejc.123.1702380370802;
        Tue, 12 Dec 2023 03:26:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAky8UR7GX5tqJ0wl3aJCEUtp3YuSWksklCWQP+DbM0tyL1tcOWxOzYYJaJEyigKEG4GjJEQ==
X-Received: by 2002:a17:907:8688:b0:a19:a19b:55eb with SMTP id qa8-20020a170907868800b00a19a19b55ebmr3739481ejc.123.1702380370419;
        Tue, 12 Dec 2023 03:26:10 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id rf20-20020a1709076a1400b00a1d1b8a088esm6121282ejc.92.2023.12.12.03.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 03:26:09 -0800 (PST)
Date: Tue, 12 Dec 2023 12:26:08 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhelgaas@google.com, lenb@kernel.org, rafael@kernel.org, Thomas Lamprecht
 <t.lamprecht@proxmox.com>
Subject: Re: SCSI hotplug issues with UEFI VM with guest kernel >= 6.5
Message-ID: <20231212122608.1b4f75ce@imammedo.users.ipa.redhat.com>
In-Reply-To: <c6233df5-01d8-498f-8235-ce4b102a2e91@proxmox.com>
References: <9eb669c0-d8f2-431d-a700-6da13053ae54@proxmox.com>
	<20231207232815.GA771837@bhelgaas>
	<20231208164723.12828a96@imammedo.users.ipa.redhat.com>
	<20231211084604.25e209af@imammedo.users.ipa.redhat.com>
	<c6233df5-01d8-498f-8235-ce4b102a2e91@proxmox.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 14:52:42 +0100
Fiona Ebner <f.ebner@proxmox.com> wrote:

> Am 11.12.23 um 08:46 schrieb Igor Mammedov:
> > On Fri, 8 Dec 2023 16:47:23 +0100
> > Igor Mammedov <imammedo@redhat.com> wrote:
> >   
> >> On Thu, 7 Dec 2023 17:28:15 -0600
> >> Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>  
> >>>
> >>> What's the actual symptom that this is broken?  All these log
> >>> fragments show the exact same assignments for BARs 0, 1, 4 and for the
> >>> bridge windows.
> >>>  
> 
> The disk never shows up in /dev
> 
> >>> I assume 0000:01:02.0 is the hot-added SCSI HBA, and 00:05.0 is a
> >>> bridge leading to it?
> >>>
> >>> Can you put the complete dmesg logs somewhere?  There's a lot of
> >>> context missing here.
> >>>  
> 
> Is this still necessary with Igor being able to reproduce the issue?

it's not necessary, but it would help to find out what's going wrong faster.
Otherwise we would need to fallback to debugging over email.
Are you willing to help with testing/providing debug logs to track down
the cause?.

Though debug over email would be slow, so our best option is to revert
offending patches until the cause if found/fixed.

> >>> Do you have to revert both cc22522fd55e2 and 40613da52b13f to make it
> >>> work reliably?  If we have to revert something, reverting one would be
> >>> better than reverting both.    
> >>  
> 
> Just reverting cc22522fd55e2 is not enough (and cc22522fd55e2 fixes
> 40613da52b13f so I can't revert just 40613da52b13f).

With UEFI setup, it still works for me fine with current master.

Kernel 6.7.0-rc5-00014-g26aff849438c on an x86_64 (ttyS0)

ibm-p8-kvm-03-guest-02 login: pci 0000:01:02.0: [1af4:1004] type 00 class 0x010000
pci 0000:01:02.0: reg 0x10: [io  0x0000-0x003f]
pci 0000:01:02.0: reg 0x14: [mem 0x00000000-0x00000fff]
pci 0000:01:02.0: reg 0x20: [mem 0x00000000-0x00003fff 64bit pref]
pci 0000:01:02.0: BAR 4: assigned [mem 0x380000004000-0x380000007fff 64bit pref]
pci 0000:01:02.0: BAR 1: assigned [mem 0xc1001000-0xc1001fff]
pci 0000:01:02.0: BAR 0: assigned [io  0xc040-0xc07f]
pci 0000:00:05.0: PCI bridge to [bus 01]
pci 0000:00:05.0:   bridge window [io  0xc000-0xcfff]
pci 0000:00:05.0:   bridge window [mem 0xc1000000-0xc11fffff]
pci 0000:00:05.0:   bridge window [mem 0x380000000000-0x3807ffffffff 64bit pref]
virtio-pci 0000:01:02.0: enabling device (0000 -> 0003)
scsi host3: Virtio SCSI HBA
pci 0000:00:05.0: PCI bridge to [bus 01]
pci 0000:00:05.0:   bridge window [io  0xc000-0xcfff]
pci 0000:00:05.0:   bridge window [mem 0xc1000000-0xc11fffff]
pci 0000:00:05.0:   bridge window [mem 0x380000000000-0x3807ffffffff 64bit pref]
scsi 3:0:0:0: Direct-Access     QEMU     QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
sd 3:0:0:0: Power-on or device reset occurred
sd 3:0:0:0: Attached scsi generic sg2 type 0
sd 3:0:0:0: LUN assignments on this target have changed. The Linux SCSI layer does not automatically remap LUN assignments.
sd 3:0:0:0: [sdb] 5190784 512-byte logical blocks: (2.66 GB/2.47 GiB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 63 00 00 08
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
GPT:Primary header thinks Alt. header is not at the end of the disk.
GPT:5190099 != 5190783
GPT:Alternate GPT header not at the end of the disk.
GPT:5190099 != 5190783
GPT: Use GNU Parted to correct GPT errors.
 sdb: sdb1 sdb2
sd 3:0:0:0: [sdb] Attached SCSI disk

it still doesn't work with Fedora's 6.7.0-0.rc2.20231125git0f5cc96c367f.26.fc40.x86_64 kernel.
However it's necessary to have -smp 4 for it to break,
with -smp 1 it works fine as well.

 
> > Fiona,
> > 
> > Does it help if you use q35 machine with '-global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=off' option?
> >   
> 
> Yes, it does :)
> 
> I added the following to my QEMU commandline (first line, because there
> wouldn't be a "pci.0" otherwise):
> 
> > -device 'pci-bridge,id=pci.0,chassis_nr=4' \
> > -machine 'q35' \
> > -global 'ICH9-LPC.acpi-pci-hotplug-with-bridge-support=off' \  
> 
> and while it takes a few seconds, the disk does show up successfully:

delay is normal for SHPC

> 
> Best Regards,
> Fiona
> 


