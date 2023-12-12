Return-Path: <linux-pci+bounces-810-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A2E80F605
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 20:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E80A41F2155E
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 19:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECB08004C;
	Tue, 12 Dec 2023 19:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RDGGSWd4"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F832CF
	for <linux-pci@vger.kernel.org>; Tue, 12 Dec 2023 11:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702408058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FED27YmNOd7V+oZeJKNoXbNO7gH5+lQwLLcQbiy2vMU=;
	b=RDGGSWd4KlRXJxjfPcZ9skvvP+Ntafybfr8t9Ke+8vVKpp9ZPBdXBmb59GntW8Cw+xTn5b
	10DYB7Rl8YG0sjnAVtZTp5esI4cbg+Um3fgUrLz622Pn58JpR/9AJYsJ8Xl+slYgj7Bjpi
	y0ELk3oFLv8L8Sa0QkxWgAIHMvyEHcg=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-H0pulbGbME-IgYS9W8SQ9Q-1; Tue, 12 Dec 2023 14:07:36 -0500
X-MC-Unique: H0pulbGbME-IgYS9W8SQ9Q-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-35d65c9dea3so63380195ab.3
        for <linux-pci@vger.kernel.org>; Tue, 12 Dec 2023 11:07:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702408055; x=1703012855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FED27YmNOd7V+oZeJKNoXbNO7gH5+lQwLLcQbiy2vMU=;
        b=e1+uQ2RPPX5a+cTPLt6PkWsus/oJIcn5DPUWNOLdsereUSWywNqEZ6C/XKO95E6LmN
         I4HYV+64q2jt7sjSasJAKNYGSWVkMAn2jYn34PSO8nHK3cqFy1rmjIeDF10AAilNxmAk
         0vQfth2KtsfUcTYkwsNE3jhNr8FaRuD3PxVqsecodv9b0mbonRY8f90HAiY1sIS/DB5G
         SGqCXxX15Wiytdoh32Zq8FwqTHaEjD3N2xS/lq/s1yBsQd2GEOEmvcdDT8F0NpnITM7P
         b6+WA9mytJ9b/8lpAUPajiAbNxTORXOR9wIq7Fr9rYDMogEZY6zN2iSj5uW/+Bc8B9PA
         LZNQ==
X-Gm-Message-State: AOJu0YxcOBYAv2UsDUOJCK2E62p63c8uRUudSzcHrTrguq2Xq9ZHjPtL
	i7aUVSMS6/vLk9m7IDTR/GZnOdu/KbMbcLn4NeTYLVZ/H6lntad/YfTjMFOdXhTLn59Ri+oD6zY
	Cdj/zJsofVO/8gLzFLsDRTzs5Jumt
X-Received: by 2002:a05:6e02:1bcb:b0:35d:61b4:e628 with SMTP id x11-20020a056e021bcb00b0035d61b4e628mr9640240ilv.60.1702408055388;
        Tue, 12 Dec 2023 11:07:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGda909qB0r9Ew8IPtUFSHBRPzOG9BaOeogeMBjylm8Sdw+95yUodB4i8i8Qg3TXpPRPQvoyw==
X-Received: by 2002:a05:6e02:1bcb:b0:35d:61b4:e628 with SMTP id x11-20020a056e021bcb00b0035d61b4e628mr9640223ilv.60.1702408055130;
        Tue, 12 Dec 2023 11:07:35 -0800 (PST)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id m18-20020a056638271200b00466593d380fsm2500141jav.53.2023.12.12.11.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 11:07:34 -0800 (PST)
Date: Tue, 12 Dec 2023 12:07:33 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Ashutosh Sharma <ashutosh.dandora4@gmail.com>, Lukas Wunner
 <lukas@wunner.de>, linux-pci@vger.kernel.org, helgaas@kernel.org,
 dwmw2@infradead.org, yi.l.liu@intel.com, majosaheb@gmail.com,
 cohuck@redhat.com, zhenzhong.duan@gmail.com, Smita Koralahalli
 <Smita.KoralahalliChannabasappa@amd.com>, Yazen Ghannam
 <yazen.ghannam@amd.com>
Subject: Re: PCI device hot insert is not detected
Message-ID: <20231212120733.7b62f92c.alex.williamson@redhat.com>
In-Reply-To: <5d880d78-ee3b-4c3d-a0bb-4e278c3d7b29@amd.com>
References: <CADOvten7jG7KjW6W1MRd7i8_E18L0xCCaCzmZOY_vvgJhdfOSw@mail.gmail.com>
	<20231212105934.GA15015@wunner.de>
	<CADOvte=k6JJbj=CqjLQqYu1Hp+Cu891KNkn-BDkOKPTdfdVQvw@mail.gmail.com>
	<5d880d78-ee3b-4c3d-a0bb-4e278c3d7b29@amd.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Dec 2023 12:29:13 -0600
Mario Limonciello <mario.limonciello@amd.com> wrote:

> On 12/12/2023 05:32, Ashutosh Sharma wrote:
> >> This doesn't work, try "echo 1 | sudo tee power" instead.  
> > 
> > This was not a permission issue, I already gave it read/write permission.
> > 
> > admin@node-4:/sys/bus/pci/slots/14$ sudo echo 1 > power
> > -bash: power: Permission denied
> > admin@node-4:/sys/bus/pci/slots/14$ sudo chmod 0666 power
> > admin@node-4:/sys/bus/pci/slots/14$ sudo echo 1 > power
> > echo: write error: Operation not permitted
> > admin@node-4:/sys/bus/pci/slots/14$
> >   
> >> This is from a "Link up" situation (DLActive+), it would be more
> >> interesting to get lspci output of the port in a "No link" situation.  
> > 
> > Unfortunately, I did not collect that output before system reboot.
> > 
> > On Tue, 12 Dec 2023 at 16:29, Lukas Wunner <lukas@wunner.de> wrote:  
> >>
> >> On Tue, Dec 12, 2023 at 04:04:41PM +0530, Ashutosh Sharma wrote:  
> >>> Removed one NVMe drive (pci address 0000:83:00.0), it got unbound
> >>> successfully from "vfio-pci" driver but saw below error in the syslog.
> >>>
> >>> can't change power state from D0 to D3hot (config space inaccessible)  
> >>
> >> This is normal, the drive's config space is inaccessible after removal.
> >>  
> 
> Was the removal a "surprise" removal?  Or you mean it was by using 
> 'remove' sysfs file?
> 
> IIRC surprise removal will need platform firmware support to handle it 
> properly.

The vfio-pci driver also makes zero claims about supporting surprise
removal, you'll likely end up in an inconsistent state.  Thanks,

Alex

> >>> Then after 2:30 min approx, re-inserted the same drive to the same PCI
> >>> slot. But the drive was not detected.
> >>>
> >>> Dec 11 23:54:39 node-4 kernel: [183672.630191] pcieport 0000:80:03.2:
> >>> pciehp: Slot(14): Attention button pressed
> >>> Dec 11 23:54:39 node-4 kernel: [183672.630195] pcieport 0000:80:03.2:
> >>> pciehp: Slot(14) Powering on due to button press
> >>> Dec 11 23:54:44 node-4 kernel: [183677.671931] pcieport 0000:80:03.2:
> >>> pciehp: Slot(14): Card present
> >>> Dec 11 23:54:46 node-4 kernel: [183679.783922] pcieport 0000:80:03.2:
> >>> pciehp: Slot(14): No link  
> >>
> >> The link doesn't come up, so the kernel gives up on the slot.
> >>
> >> I don't know what the reason is, could be a hardware issue or
> >> protocol incompatibility.  This doesn't look like a kernel issue.
> >>
> >>  
> >>>   |           +-03.0  Advanced Micro Devices, Inc. [AMD]
> >>> Starship/Matisse PCIe Dummy Host Bridge
> >>>   |           +-03.1-[82]----00.0  Samsung Electronics Co Ltd NVMe SSD
> >>> Controller PM9A1/PM9A3/980PRO
> >>>   |           +-03.2-[83]--  
> >>
> >> Adding Mario, Smita, Yazen from AMD to cc, maybe they have an idea
> >> what the issue is or how to get diagnostics on this Epyc platform.
> >>
> >> Start of thread:
> >> https://lore.kernel.org/linux-pci/CADOvten7jG7KjW6W1MRd7i8_E18L0xCCaCzmZOY_vvgJhdfOSw@mail.gmail.com/
> >>
> >>  
> >>> admin@node-4:/sys/bus/pci/slots/14$ sudo echo 1 > power
> >>> echo: write error: Operation not permitted  
> >>
> >> This doesn't work, try "echo 1 | sudo tee power" instead.
> >>
> >>  
> >>> lspci output of the pci port:
> >>> 80:03.2 PCI bridge: Advanced Micro Devices, Inc. [AMD]
> >>> Starship/Matisse GPP Bridge (prog-if 00 [Normal decode])  
> >> [...]  
> >>>                  LnkSta: Speed 16GT/s (ok), Width x4 (ok)
> >>>                          TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-  
> >>
> >> This is from a "Link up" situation (DLActive+), it would be more
> >> interesting to get lspci output of the port in a "No link" situation.
> >>
> >> Thanks,
> >>
> >> Lukas  
> 


