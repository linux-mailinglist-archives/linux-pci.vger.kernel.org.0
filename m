Return-Path: <linux-pci+bounces-854-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7DD810DE6
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 11:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05278281B33
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 10:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B18B22313;
	Wed, 13 Dec 2023 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TmnMCJuN"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D04583
	for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2023 02:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702462056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YdSkfSCIDP93EM+mxv9M+W9x4jK0YGjz6e+tBs7DUUU=;
	b=TmnMCJuN4x4ADs27WOTnHMFqqMQarBZl3sE1On8aNzIxHgTOsNPvubI5CEZJ7v0zQFbifX
	boIZm7uY60jdQkIPrY5OBDXnjn9Ve8C2a1JtxWCWtf8xzw1fxCP92sjRcZ7tYv5+2Cn4Ig
	TCPb8zsnNiJvLSOAQU4MMkLAOlE6HYI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-kqfzGTewOHustLPKzPFYIQ-1; Wed, 13 Dec 2023 05:07:35 -0500
X-MC-Unique: kqfzGTewOHustLPKzPFYIQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50dfaa1ad34so3619256e87.1
        for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2023 02:07:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702462052; x=1703066852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdSkfSCIDP93EM+mxv9M+W9x4jK0YGjz6e+tBs7DUUU=;
        b=QZYczv5RLNIj1GVF3W8RHLgw5myTnQvjdgUYxISt4tHtBuODzTDGmFT1ubsexncPlg
         uiLTkTqGgJyud5wi6vdjzeeC8cgYOPO5n7hHeg0DhBjH6UScX6z3+c9vfT9eLfvPvDni
         su2jg0ILS7ZU+3EWfQJi1QX3xZxoFzRQJrIS3cs7mGrt2q0e4sIyfqb4EcRhCaZ0tIAJ
         WLOffqVXR8IpIQRGw1/ZyBhu8upONKjpFbsDcVR9EtJ72Lr1jQeeJm9q9Q5RaBQtj39g
         Dl2yjUtCZ/SQVt2UEwhBJjfSdprJMcA+8wNBRIV6Zv5YZLHY3idSdevD3moTB32OiggQ
         FJWg==
X-Gm-Message-State: AOJu0Yx2WKQ9zk73igHLKZPPQOtulgde0u6IBstI1YlX7VgCyfoMmOeD
	NQZCPpfctKAKvYJvdgZgULLSPQqnuEu18reQoTspzPHP6YmIloKASDbk9ZirbbNf117e/paJKbt
	h6VJupX9GijTrUeYDRsZVAjfbN7c6
X-Received: by 2002:a05:6512:104d:b0:50b:f380:5fad with SMTP id c13-20020a056512104d00b0050bf3805fadmr4913039lfb.87.1702462052210;
        Wed, 13 Dec 2023 02:07:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkYdiiq48AtFlXavTGhK5TgEnQUjes08MTe0tzKUxfAO2LnnNyQQT8kV1vdp+a/90HJ+pTfA==
X-Received: by 2002:a05:6512:104d:b0:50b:f380:5fad with SMTP id c13-20020a056512104d00b0050bf3805fadmr4913025lfb.87.1702462051861;
        Wed, 13 Dec 2023 02:07:31 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5-20020ac25f45000000b0050bf06c8098sm1590674lfz.116.2023.12.13.02.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 02:07:31 -0800 (PST)
Date: Wed, 13 Dec 2023 11:07:29 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: linux-kernel@vger.kernel.org, Dongli Zhang <dongli.zhang@oracle.com>,
 linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, mst@redhat.com,
 rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
 mika.westerberg@linux.intel.com, boris.ostrovsky@oracle.com,
 joe.jin@oracle.com, stable@vger.kernel.org, Thomas Lamprecht
 <t.lamprecht@proxmox.com>
Subject: Re: [RFC 1/2] PCI: acpiphp: enable slot only if it hasn't been
 enabled already
Message-ID: <20231213110729.3845f530@imammedo.users.ipa.redhat.com>
In-Reply-To: <501c1078-ef45-4469-87f8-32525d6f2608@proxmox.com>
References: <20231213003614.1648343-1-imammedo@redhat.com>
	<20231213003614.1648343-2-imammedo@redhat.com>
	<501c1078-ef45-4469-87f8-32525d6f2608@proxmox.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Dec 2023 10:47:27 +0100
Fiona Ebner <f.ebner@proxmox.com> wrote:

> Am 13.12.23 um 01:36 schrieb Igor Mammedov:
> > When SCSI_SCAN_ASYNC is enabled (either via config or via cmd line),
> > adding device to bus and enabling it will kick in async host scan
> > 
> >  scsi_scan_host+0x21/0x1f0
> >  virtscsi_probe+0x2dd/0x350
> >  ..
> >  driver_probe_device+0x19/0x80
> >  ...
> >  driver_probe_device+0x19/0x80
> >  pci_bus_add_device+0x53/0x80
> >  pci_bus_add_devices+0x2b/0x70
> >  ...
> > 
> > which will schedule a job for async scan. That however breaks
> > if there are more than one SCSI host behind bridge, since
> > acpiphp_check_bridge() will walk over all slots and try to
> > enable each of them regardless of whether they were already
> > enabled.
> > As result the bridge might be reconfigured several times
> > and trigger following sequence:
> > 
> >   [cpu 0] acpiphp_check_bridge()
> >   [cpu 0]   enable_slot(a)
> >   [cpu 0]     configure bridge
> >   [cpu 0]     pci_bus_add_devices() -> scsi_scan_host(a1)
> >   [cpu 0]   enable_slot(b)
> >   ...
> >   [cpu 1] do_scsi_scan_host(a1) <- async jib scheduled for slot a
> >   ...
> >   [cpu 0]     configure bridge <- temporaly disables bridge
> > 
> > and cause do_scsi_scan_host() failure.
> > The same race affects SHPC (but it manages to avoid hitting the race due to
> > 1sec delay when enabling slot).
> > To cover case of single device hotplug (at a time) do not attempt to
> > enable slot that have already been enabled.
> > 
> > Fixes: 40613da52b13 ("PCI: acpiphp: Reassign resources on bridge if necessary")
> > Reported-by: Dongli Zhang <dongli.zhang@oracle.com>
> > Reported-by: iona Ebner <f.ebner@proxmox.com>  
> 
> Missing an F here ;)

Sorry for copypaste mistake, I'll fix it up on the next submission.

> 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>  
> 
> Thank you! Works for me:
> 
> Tested-by: Fiona Ebner <f.ebner@proxmox.com>
> 


