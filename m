Return-Path: <linux-pci+bounces-10239-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A64A7930959
	for <lists+linux-pci@lfdr.de>; Sun, 14 Jul 2024 10:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F38C71F21787
	for <lists+linux-pci@lfdr.de>; Sun, 14 Jul 2024 08:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4E61CFBD;
	Sun, 14 Jul 2024 08:42:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAEC1F5FF;
	Sun, 14 Jul 2024 08:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720946573; cv=none; b=UCsEr+H/WDftCkqFrxAzFJMlDBk59VuLH4WIKVW8Edi8rgOZmT0yBwYQvxuNo+w0ARTeAJf17O4SCaJ8fDgyKZA3ZngXy0ORFbvmzKVoctlkHBUI1wCZbXIYdXvWqm3zN2KRCPSs2dp64BOnlOqEuY892PObknFZbrWyU+cgq7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720946573; c=relaxed/simple;
	bh=r8QUsPT+q8BDUuCNRac8TuMNIQlNaaK5BIOllXFbCPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEyIMRB58JGFPFZYGt+6h6HesfMkFX6PHXEF1xb1kLTHuS1elnuqFF7TUg6ryLIDlYhCTM+eSi/uZHh7VMTb3QMI+BXaDgO0rVk5DdPcuKWcq/hdIoUc3XEDrO6DrRFAU/2bgoC5/9paPURVileH70OGetQ9qX08BiHZnadelYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id A8EF730000099;
	Sun, 14 Jul 2024 10:42:41 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 8F60811DB61; Sun, 14 Jul 2024 10:42:41 +0200 (CEST)
Date: Sun, 14 Jul 2024 10:42:41 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	David Woodhouse <dwmw2@infradead.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-coco@lists.linux.dev, keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org, linuxarm@huawei.com,
	David Box <david.e.box@intel.com>, "Li, Ming" <ming4.li@intel.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dhaval Giani <dhaval.giani@amd.com>,
	Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Gonda <pgonda@google.com>,
	Jerome Glisse <jglisse@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>,
	Kees Cook <kees@kernel.org>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 08/18] PCI/CMA: Authenticate devices on enumeration
Message-ID: <ZpOPgcXU6eNqEB7M@wunner.de>
References: <Zo_zivacyWmBuQcM@wunner.de>
 <66901b646bd44_1a7742941d@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66901b646bd44_1a7742941d@dwillia2-xfh.jf.intel.com.notmuch>

[cc += Kees Cook, Jann Horn; start of thread:
https://lore.kernel.org/all/6d4361f13a942efc4b4d33d22e56b564c4362328.1719771133.git.lukas@wunner.de/
]

On Thu, Jul 11, 2024 at 10:50:28AM -0700, Dan Williams wrote:
> Lukas Wunner wrote:
> > Resume is parallelized (see dpm_noirq_resume_devices()), so the latency
> > is bounded by the time to authenticate a single device.
> 
> As far as I understand that can still be on the order of seconds, and
> pathological cases that could be longer. [...]
> How bad is that latency problem in practice?

I'm seeing 150 msec to authenticate a PCI device if the signature can't be
verified (e.g. due to missing trusted root certificate) and 400 msec if
the signature *is* verified.  This varies depending on beefiness of CPU,
algorithm selection, key length and number of provisioned slots.

But I've never seen this take "on the order of seconds", I assume that's
a misunderstanding.

vmlinux size grows by 12.752 bytes with CONFIG_PCI_CMA=y on x86_64.
The feature is disabled by default.


> All of these are mitigated by pushing authentication management to
> drivers.

Device authentication can't be pushed to drivers.  It must be done
*before* driver binding:

Drivers are bound based on identity information in config space
(such as Vendor ID or Device ID).  A malicious device could spoof
identity information in config space to force binding to a specific
(CMA-unaware) driver.

The certificate contains the signed Vendor ID and Device ID of the
device.  By validating the certificate and the signature presented
by the device, its identity can be ascertained by the PCI core
before a driver (the right one) starts accessing it.


> I see no justification for the hard coded aggressive default policy

I think that just preventing driver binding if a device fails
authentication may not be good enough.  If a device is truly
malicious, perhaps we should firewall it off.  I'm worried about
a device laterally attacking other devices through P2PDMA or
sending malformed TLPs upstream to the root complex. 

In patch [11/18], I'm suggesting:

   "Traffic from devices which failed authentication could also be
    filtered through ACS I/O Request Blocking Enable (PCIe r6.2 sec
    7.7.11.3) or through Link Disable (PCIe r6.2 sec 7.5.3.7)."

To firewall off malicious devices, authentication should happen early on.
The system shouldn't be exposed to those devices any longer than necessary.
That's one reason why this patch set performs mandatory authentication
already on enumeration:  So that we're able to catch malicious devices
as early as possible.

Patch [08/18] inserts pci_cma_init() at the end of pci_init_capabilities()
because CMA depends on DOE.  We may want to move DOE and CMA init
further up in the function to authenticate the device even before
enumerating any of its other capabilities.

It's probably too early to decide which actions to take if a device fails
authentication, whether to offer a variety of actions (only prevent driver
binding) or just stick to the harshest one (firewall off the device),
when to perform those actions and which knobs to offer to users for
controlling policy and overriding actions.  We may need more real-world
experience before we can make those decisions and we may need to ask
security folks such as Kees Cook and Jann Horn for their perspective.

This patch set merely exposes to user space whether a device passed
authentication or not.  For that alone, it would indeed be sufficient
to authenticate asynchronously -- or delay authentication until the
sysfs attribute is accessed.

But I wanted to keep the option open to firewall off devices early on.
And placing pci_cma_init() in pci_init_capabilities() felt natural
because it's where all the other device capabilities are enumerated
and initialized.

Thanks,

Lukas

