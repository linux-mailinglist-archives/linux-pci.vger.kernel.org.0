Return-Path: <linux-pci+bounces-31937-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30961B0209B
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 17:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AE671CA230E
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 15:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804A92ED149;
	Fri, 11 Jul 2025 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DOGDZsOv"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2DE2ED154
	for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248429; cv=none; b=dh/ltJArQPPzuTyxBh5Dp5xSce/o92VnNSJP8ro6A9DZNljOOJhHeVFNjNCg3WUu/Q4pjp0yoyGSGut0lvYzFph8nBy5o2bxTe8BGh1etkHHrV8X167jas6F3T/C5CLNkqBea4A0OObgYQHT61ZtKLGBV4XrdYZALCNs52Vs+vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248429; c=relaxed/simple;
	bh=cRSEYeAZQIo3llsEJyfAYMMwsDk6fdhA/0tgZ9rZxlg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aozcnnC0LjTugBWmuTXA74OkURnnpPKmnLG07BV7W7UWzN6FU34cX7USypCnZWhmEVOTBd+HK8eHc2ens926QNqw25ET5ws0zcw6tVBZFzfn1YoiqzObv2szC7WT29eYvosGk6lQ4dZU1/qOhxNYXl6o7bqVxZ5KJUL/YRsbUIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DOGDZsOv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752248426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cYYFL7iSZ/ER1ZVOlySXlTIkEzpjXHGgym0ucB+NEiw=;
	b=DOGDZsOvrw23uC5kD654YOz47133FAxmCvcRGYqvXxi7EOiI2r5zzuj/wquXd9BoTF8HA5
	zb0msLR7UAdODApFkZlN42e9RcgyK9vU5I30ThE79HZoiTXanrFG9NtqVLeTrC6wYQWHOX
	7kj52WJq/X/ke77+045enjVYPJkqb8E=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-tzPc3UAyMUSExW-hoNAnKg-1; Fri, 11 Jul 2025 11:40:25 -0400
X-MC-Unique: tzPc3UAyMUSExW-hoNAnKg-1
X-Mimecast-MFC-AGG-ID: tzPc3UAyMUSExW-hoNAnKg_1752248424
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8769aa1f0c7so36451239f.1
        for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 08:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752248424; x=1752853224;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cYYFL7iSZ/ER1ZVOlySXlTIkEzpjXHGgym0ucB+NEiw=;
        b=Uy/dY0tnzTR8xJmM3VjYX+mrkG3gtTo3aS2YS9UuhPOBEb3M1at/S3HZwQQhZWKIW3
         pMK+vu5XiNjzvkEH5D8a/K5JFda7UKbrx6Hg6VLI4jQGEi0B5OO6bFRpQXmBcTiPQjDn
         Mx96bROU/FIqX9boavBka7ZHn2727cngQEZ2JUgiFRPM60ZGP2mLrS3Bd+zWr5jhfYpp
         qlppDtXTwy7LRwKfobzO8rMGz+terv5UA6/D81+lrd98+yyEWXi6Jq+4p4dsSznmyZ+q
         pHT2XWVgII04CuS1Qsdy2dx+iCMjFQh/Fpu9mEGwx548mZvPMesTKPcMt6c1LHUuNWrg
         TL7w==
X-Forwarded-Encrypted: i=1; AJvYcCWr3dfyz0mJDgL68dK0HhnEaVCyE8ngt0LfHtu/kKDzi5R0c+hZWcPYqDNnFJ1B3rbNyXE4hQCZcVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwj0HxKuYMMyiay6CmMfBjtdgQxGYM/85p3C/lKLauXgVQ1E7n
	5HpPZtlEJlTDMRXuys+bRXUH/2Ma10+T+X3cEQrL6bNFmXyWK+w1L/0IuBtTA3R6SPzJIGcQw7A
	I3llKuCTtOTf9+YBYB3K6+dUX9ireFMIuWmBaflydTpUq7IBT5mzCPkYGFxB0dg==
X-Gm-Gg: ASbGncvy3W9g6MitVcviLP2s4cTRYL2ut4YsLabOdL+AKz3uT8ZK2/cXWbHWxxqkjhi
	PxR3GKhxChcUM4ReA+nlD8cZwkIP/93NiLZzUQXecQXFIxc6ZwCG+w+h4Iz9N4yB0s+VhdY/J9E
	m/refQJO1O+dNGOwkHJLqv7qWSLL7l+kfw7oCecKHGSsv4BfGT6IuMSMaeTZaS2VtssxNzGqmKH
	rBGCFBWA2gKoiOzx6ZQ4Im596mWyktuivN7zwtNeuLiZkFz9X6/gZk9Mo4XSpMpS1dX1kyOAZA2
	mz0cLv8+hjM+IkoZyn/gNU7jL0s0KjVHasHtlaEf1aw=
X-Received: by 2002:a05:6602:2cc2:b0:876:97b0:937b with SMTP id ca18e2360f4ac-87979228fb2mr95699939f.3.1752248424019;
        Fri, 11 Jul 2025 08:40:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHVY5rBGhqRO5sp2SLT2myg1EFX29cpDhlYNuKxgTlHNrK/eYcqxX7DYKWsncg808ZpGBEWg==
X-Received: by 2002:a05:6602:2cc2:b0:876:97b0:937b with SMTP id ca18e2360f4ac-87979228fb2mr95697739f.3.1752248423477;
        Fri, 11 Jul 2025 08:40:23 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8796b8c46f9sm107447039f.8.2025.07.11.08.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 08:40:22 -0700 (PDT)
Date: Fri, 11 Jul 2025 09:40:20 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux.dev, Joerg Roedel
 <joro@8bytes.org>, linux-pci@vger.kernel.org, Robin Murphy
 <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, Lu Baolu
 <baolu.lu@linux.intel.com>, galshalom@nvidia.com, Joerg Roedel
 <jroedel@suse.de>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
 maorg@nvidia.com, patches@lists.linux.dev, tdave@nvidia.com, Tony Zhu
 <tony.zhu@intel.com>
Subject: Re: [PATCH 00/11] Fix incorrect iommu_groups with PCIe switches
Message-ID: <20250711094020.697678fc.alex.williamson@redhat.com>
In-Reply-To: <20250708204715.GA1599700@nvidia.com>
References: <0-v1-74184c5043c6+195-pcie_switch_groups_jgg@nvidia.com>
	<20250701154826.75a7aba6.alex.williamson@redhat.com>
	<20250708204715.GA1599700@nvidia.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Jul 2025 17:47:15 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Jul 01, 2025 at 03:48:26PM -0600, Alex Williamson wrote:
> 
> > Notably, each case where there's a dummy host bridge followed by some
> > number of additional functions (ie. 01.0, 02.0, 03.0, 08.0), that dummy
> > host bridge is tainting the function isolation and merging the group.
> > For instance each of these were previously a separate group and are now
> > combined into one group.  
> 
> I was able to run some testing on a Milan system that seems similar.
> 
> It has the weird "Dummy Host Bridge" MFD. I fixed it with this:
> 
> /*
>  * For some reason AMD likes to put "dummy functions" in their PCI hierarchy as
>  * part of a multi function device. These are notable because they can't do
>  * anything. No BARs and no downstream bus. Since they cannot accept P2P or
>  * initiate any MMIO we consider them to be isolated from the rest of MFD. Since
>  * they often accompany a real PCI bridge with downstream devices it is
>  * important that the MFD be isolated. Annoyingly there is no ACS capability
>  * reported we have to special case it.
>  */
> static bool pci_dummy_function(struct pci_dev *pdev)
> {
> 	if (pdev->class >> 8 == PCI_CLASS_BRIDGE_HOST && !pci_has_mmio(pdev))
> 		return true;
> 	return false;
> }

Yeah, that might work since it does report itself as a host bridge.
Probably noteworthy that you'd end up catching the Intel host bridge
with this too.
 
> This AMD system has second weirdness:
> 
> 40:01.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Starship/Matisse GPP Bridge (prog-if 00 [Normal decode])
>         Capabilities: [2a0 v1] Access Control Services
>                 ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans+
>                 ACSCtl: SrcValid- TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
> 40:01.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Starship/Matisse GPP Bridge (prog-if 00 [Normal decode])
>         Capabilities: [2a0 v1] Access Control Services
>                 ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans+
>                 ACSCtl: SrcValid- TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
> 40:01.3 PCI bridge: Advanced Micro Devices, Inc. [AMD] Starship/Matisse GPP Bridge (prog-if 00 [Normal decode])
>         Capabilities: [2a0 v1] Access Control Services
>                 ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans+
>                 ACSCtl: SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
> 
> Notice the SrcValid- 
> 
> The kernel definately set SrcValid+, the device stored it, and it
> never set SrcValid-, yet somehow it got changed:
> 
> [    0.483828] pci 0000:40:01.1: pci_enable_acs:1089
> [    0.483828] pci 0000:40:01.1: pci_write_config_word:604 9 678 = 1d
> [    0.483831] pci 0000:40:01.1: ACS Set to 1d, readback=1d
> [..]
> [    0.826514] pci 0000:40:01.1: __pci_device_group:1635 Starting
> [    0.826517] pci 0000:40:01.1: pci_acs_flags_enabled:3668   ctrl=1c acs_flags=1d cap=5f
> 
> I instrumented pci_write_config_word() and it isn't being called a
> second time. I didn't try to narrow this down, too weird. Guessing
> ACPI or FW?
> 
> So the new logic puts all the above and the downstream into group due
> to insuffucient isolation which is the only degredation on this
> system, the LOM ethernet gets grouped together with the above MFD.
> 
> Given in this case we explicitly have ACS flags we consider
> non-isolated I'm not sure there is anything to be done about it.
> 
> Which raises a question if SrcValid should be part of grouping or not,
> it is more of a security enhancement, it doesn't permit/deny P2P
> between devices?

Strange issue.  If a device can spoof a RID then it can theoretically
inject a DMA payload as if it were another device.  That seems like
basic security, not just an enhancement.
 
> > The endpoints result in equivalent grouping, but this is a case where I
> > don't understand how we have non-isolated functions yet isolated
> > subordinate buses.  
> 
> And I fixed this too, as above is showing, by marking the group of the
> MFD as non-isolated, thus forcing it to propogate downstream.
> 
> > An Alder Lake system shows something similar:  
> 
> I also tested a bunch of Intel client systems. Some with an ACS quirk
> and one with the VMD/non transparent bridge setup. Those had no
> grouping changes, but no raptor lake in this group.
> 
> > # lspci -vvvs 1c. | grep -e ^0 -e "Access Control Services"
> > 00:1c.0 PCI bridge: Intel Corporation Raptor Lake PCI Express Root Port #1 (rev 11) (prog-if 00 [Normal decode])
> > 00:1c.1 PCI bridge: Intel Corporation Device 7a39 (rev 11) (prog-if 00 [Normal decode])
> > 	Capabilities: [220 v1] Access Control Services
> > 00:1c.2 PCI bridge: Intel Corporation Raptor Point-S PCH - PCI Express Root Port 3 (rev 11) (prog-if 00 [Normal decode])
> > 	Capabilities: [220 v1] Access Control Services
> > 00:1c.3 PCI bridge: Intel Corporation Raptor Lake PCI Express Root Port #4 (rev 11) (prog-if 00 [Normal decode])
> > 	Capabilities: [220 v1] Access Control Services
> > 
> > So again the group is tainted by a device that cannot generate DMA,   
> 
> It looks like 00:1c.0 is advertised as a root port, so it can generate
> DMA as part of its root port function bridging to something outside
> the root complex.
> 
> This system doesn't seem to have anything downstream of that root port
> (currently plugged in?), but IMHO that port should have ACS. By spec I
> think it is correct to assume that without ACS traffic from downstream
> of the root port would be able to follow the internal loopback of the
> MFD.
> 
> This will probably need a quirk, and it is different from the AMD case
> which used a host bridge..
> 
> Any other idea?

This root port at 1c.0 does look like it could have a subordinate
device, but there is no unpopulated slot/socket on this motherboard.
Possibly another motherboard SKU could use these links for a wifi card.
Versus the other root ports, it lacks routing of its interrupt line, it
does have a secondary bus and apertures assigned, it has a PCIe
capability that claims it has a slot (LnkCap 8GT/s x1), it has an MSI
capability and a NULL capability, no extended config space.  I'm not
sure if this vendor (Gigabyte) is unique in incompletely stubbing out
this link or if this is par for the course.

Again, it should be perfectly safe to assign things downstream of the
ACS isolated root ports in the MFD to userspace drivers, their egress
DMA is isolated.  It would only be ingress from an endpoint that seems
like it cannot exist that would be troublesome.  I don't have a good
solution.  Thanks,

Alex


