Return-Path: <linux-pci+bounces-617-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 717DA808B24
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 15:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE89E1F21578
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 14:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED1E44370;
	Thu,  7 Dec 2023 14:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cP8F50TJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEA819A
	for <linux-pci@vger.kernel.org>; Thu,  7 Dec 2023 06:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701960947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tz6X+bifKo7AdaGetM0WimZ3DgQEAXtIAzsWo7qdtOo=;
	b=cP8F50TJrcWNT4Yt49TEXroAwvYOeC5avlf6Ysv/iCnfpMNufj+zciNSHiEnSmyA5ZjmiR
	dDk22abrzF8J1kOB6/5tO/EL+/eRPdZqvqZKos7H3DsMzyFAyW/t7maYqjRo/c+7Z8rpcU
	MQdUI9sW6tbuDMptR8MOcZsGHER/zWE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-7pJp32dqM-6rlT-qAj9Rbg-1; Thu, 07 Dec 2023 09:55:46 -0500
X-MC-Unique: 7pJp32dqM-6rlT-qAj9Rbg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40c193fca81so9292105e9.3
        for <linux-pci@vger.kernel.org>; Thu, 07 Dec 2023 06:55:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701960944; x=1702565744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tz6X+bifKo7AdaGetM0WimZ3DgQEAXtIAzsWo7qdtOo=;
        b=PA/BIgO5+h2S2jlrMf0Aw3+t1slsTU4OfC4qaAc/BV6MJUSDInAI/L3lZVoMnpCAbh
         mac3iaWePOFrRog8VSXfnBq3wGhc2Ve8YBHSyCfGKW5ZlAKEKqLxbMfR08OQAwO0byVW
         2WeVIrpsuuV06RAiEUZr8jeAfwut9M/Wo+GK9SZQvt9qWaJ98n0upWvIN1T591Qk/xtK
         6Z31hmUbEXqDFpJ6KkSs+l0/4Cv7EAPqM9+US+znMKBr+2TfT4CnuxWGAFrP/iXaVrY1
         /pav/j5lSkkbgEDlvLR8rrpkvieMTNQwAoFA0kgEfF2UAKs/XvXG364tu44Gusd3OMYl
         RD9g==
X-Gm-Message-State: AOJu0YyaJELDzrQPNnPzF6pzFOgCCl2/+rTZV6sCBkUlwLToy+/9p4kK
	itOTgvyNEnuQBePX3USJVRCeUxI9ZeaIzUdQu/KaBuOfiJNlzfY+vV+Oz0Vf43fwtxR1wB/Bly+
	j9nS3c3rIPCr7pdzJsEx2b28z2/mT
X-Received: by 2002:a05:600c:198b:b0:40b:5e21:dd34 with SMTP id t11-20020a05600c198b00b0040b5e21dd34mr2068543wmq.98.1701960943985;
        Thu, 07 Dec 2023 06:55:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqPu0jtkLU9hMN3uH/bMY5VhR71AQ+5SLWqCAxzRD+0Q/xUOdmx8munOvaO4iPnv+olLoNZQ==
X-Received: by 2002:a05:600c:198b:b0:40b:5e21:dd34 with SMTP id t11-20020a05600c198b00b0040b5e21dd34mr2068529wmq.98.1701960943567;
        Thu, 07 Dec 2023 06:55:43 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 3-20020a170906208300b00a1e04f24df1sm918499ejq.223.2023.12.07.06.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 06:55:43 -0800 (PST)
Date: Thu, 7 Dec 2023 15:55:41 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhelgaas@google.com, lenb@kernel.org, rafael@kernel.org, Thomas Lamprecht
 <t.lamprecht@proxmox.com>
Subject: Re: SCSI hotplug issues with UEFI VM with guest kernel >= 6.5
Message-ID: <20231207155541.735e0055@imammedo.users.ipa.redhat.com>
In-Reply-To: <4dbc72ba-8edb-4ff5-b95d-b601189e4415@proxmox.com>
References: <20231130231802.GA498017@bhelgaas>
	<4dbc72ba-8edb-4ff5-b95d-b601189e4415@proxmox.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Dec 2023 10:24:41 +0100
Fiona Ebner <f.ebner@proxmox.com> wrote:

> Am 01.12.23 um 00:18 schrieb Bjorn Helgaas:
> > On Wed, Nov 29, 2023 at 04:22:41PM +0100, Fiona Ebner wrote:  
> >> Hi,
> >> it seems that hot-plugging SCSI disks for QEMU virtual machines booting
> >> with UEFI and with guest kernels >= 6.5 might be broken. It's not
> >> consistently broken, hinting there might be a race somewhere.
> >>
> >> Reverting the following two commits seems to make it work reliably again:
> >>
> >> cc22522fd55e2 ("PCI: acpiphp: Use
> >> pci_assign_unassigned_bridge_resources() only for non-root bus")
> >> 40613da52b13f ("PCI: acpiphp: Reassign resources on bridge if necessary"
> >>
> >> Of course, they might only expose some pre-existing issue, but this is
> >> my best lead. See below for some logs and details about an affected
> >> virtual machine. Happy to provide more information and to debug/test
> >> further.  
> > 
> > Shoot.  Thanks very much for the report and your debugging.  I'm
> > hoping Igor will chime in with some ideas.
> > 
> > Both of those commits appeard in v6.5 and fixed legit issues, so I
> > hate to revert them, but this does appear to be a regression.
> > 
> > #regzbot introduced: cc22522fd55e2 ^
> > #regzbot introduced: 40613da52b13f ^
> >   
> >> Host kernel: 6.5.11-4-pve which is based on the one from Ubuntu
> >> Guest kernel: 6.7.0-rc3 and 6.7.0-rc3 with above commits reverted
> >> QEMU version: v8.1.0 built from source
> >> EDK2 version: submodule in the QEMU v8.1 repository: edk2-stable202302
> >>  
> 
> I should mention that I haven't run into the issue when booting the VM
> with SeaBIOS yet.
> 
> Log for 6.7.0-rc3 + SeaBIOS (bundled with QEMU 8.1):
> 
> > Dec 01 10:08:08 hotplug kernel: pci 0000:01:02.0: [1af4:1004] type 00 class 0x010000
> > Dec 01 10:08:08 hotplug kernel: pci 0000:01:02.0: reg 0x10: [io  0x0000-0x003f]
> > Dec 01 10:08:08 hotplug kernel: pci 0000:01:02.0: reg 0x14: [mem 0x00000000-0x00000fff]
> > Dec 01 10:08:08 hotplug kernel: pci 0000:01:02.0: reg 0x20: [mem 0x00000000-0x00003fff 64bit pref]
> > Dec 01 10:08:08 hotplug kernel: pci 0000:01:02.0: BAR 4: assigned [mem 0xfd404000-0xfd407fff 64bit pref]
> > Dec 01 10:08:08 hotplug kernel: pci 0000:01:02.0: BAR 1: assigned [mem 0xfe801000-0xfe801fff]
> > Dec 01 10:08:08 hotplug kernel: pci 0000:01:02.0: BAR 0: assigned [io  0xe040-0xe07f]
> > Dec 01 10:08:08 hotplug kernel: pci 0000:00:05.0: PCI bridge to [bus 01]
> > Dec 01 10:08:08 hotplug kernel: pci 0000:00:05.0:   bridge window [io  0xe000-0xefff]
> > Dec 01 10:08:08 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xfe800000-0xfe9fffff]
> > Dec 01 10:08:08 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xfd400000-0xfd5fffff 64bit pref]
> > Dec 01 10:08:08 hotplug kernel: virtio-pci 0000:01:02.0: enabling device (0000 -> 0003)
> > Dec 01 10:08:08 hotplug kernel: ACPI: \_SB_.LNKC: Enabled at IRQ 11
> > Dec 01 10:08:08 hotplug kernel: scsi host3: Virtio SCSI HBA
> > Dec 01 10:08:08 hotplug kernel: pci 0000:00:05.0: PCI bridge to [bus 01]
> > Dec 01 10:08:08 hotplug kernel: pci 0000:00:05.0:   bridge window [io  0xe000-0xefff]
> > Dec 01 10:08:08 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xfe800000-0xfe9fffff]
> > Dec 01 10:08:08 hotplug kernel: scsi 3:0:0:1: Direct-Access     QEMU     QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
> > Dec 01 10:08:08 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xfd400000-0xfd5fffff 64bit pref]
> > Dec 01 10:08:08 hotplug kernel: scsi 3:0:0:1: Attached scsi generic sg1 type 0
> > Dec 01 10:08:08 hotplug kernel: sd 3:0:0:1: Power-on or device reset occurred
> > Dec 01 10:08:08 hotplug kernel: sd 3:0:0:1: [sdb] 2048 512-byte logical blocks: (1.05 MB/1.00 MiB)
> > Dec 01 10:08:08 hotplug kernel: sd 3:0:0:1: [sdb] Write Protect is off
> > Dec 01 10:08:08 hotplug kernel: sd 3:0:0:1: [sdb] Mode Sense: 63 00 00 08
> > Dec 01 10:08:08 hotplug kernel: sd 3:0:0:1: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> > Dec 01 10:08:08 hotplug kernel: sd 3:0:0:1: [sdb] Attached SCSI disk  
> 
> Interestingly, the line with "QEMU HARDDISK" does not come after all
> lines with "bridge window" like was the case for the one time it did
> work with UEFI. So maybe that was just a red herring.

I've just seen this,
let me try to reproduce and see what can be done with it.

> 
> Best Regards,
> Fiona
> 


