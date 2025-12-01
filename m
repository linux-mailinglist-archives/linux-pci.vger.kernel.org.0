Return-Path: <linux-pci+bounces-42393-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 624A1C98C67
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 19:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F5EE4E031E
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 18:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B562D21D3F4;
	Mon,  1 Dec 2025 18:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rJrdc4my"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B0836D513
	for <linux-pci@vger.kernel.org>; Mon,  1 Dec 2025 18:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764615259; cv=none; b=SQBSAyGrGeNt3XRv6fbxfDYVMaQoXYIpCyhgvW9jqW3DLfXqUwB0HwvBQ0I/Gsj/2+VlNH9mu/olLarllD2X37chuFd4IY/trYrCwG+vp7YOcZdnlaFkBEMHj9AF2BHGHkLgcn9Ab/5Kw/kuTggetl3uYPr79j8TPHqZR6ohGhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764615259; c=relaxed/simple;
	bh=xdQFSPwBDitJJbj4YFqv8oX69ifcmN2sMzq3HiUxFog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXazZe1GK3pt+3OKxr5EeWTF09gr0EDp/J3aMk6gsJfDlakEatYUBUjGC/QowZfSauHV9ZRcBTOzSLkgVj6RD+3CuPIq/FCEbnVPGa3p5NR8NEr7wp2WGL5kKazp74p9ciIp7DD72QRy85nz97K9uvVIp4rbvfVi9aDjV6uXs3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rJrdc4my; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3438231df5fso5251097a91.2
        for <linux-pci@vger.kernel.org>; Mon, 01 Dec 2025 10:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764615257; x=1765220057; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NZR7hK5x4THTBId2vxyDYOqgCYL0BSheMqFuUmlt+Jw=;
        b=rJrdc4myLwh5sTna1PuJYPc/KOILdlLOmqy97IzQq1WNI+gRSTu77M/5mUVqJe26pv
         Vxb029p44Gag8/bWe00oXbZS+Ftp8ymQhnMHBs0Mgc0eWQR8LrXlvW2YHAB6ppq9lKwb
         IOPkaCW2XSW5iDBk2JJ9IZ6iPoGc5oHjY2G3qx45Nd5gl+h0yGZtsXoiFIZ7LnF00WyA
         gH6sz/VIsim6SU9HLb3wzF66lBxUhWTAcLkW+wVKIzwkTCJPKgaHFQ/FDahBRzZqhE8k
         2YzM19tyU6JMfTgzRM6MM41Q8wMrQbaQ+z52Glxjqs4v2dLDivW/WfQ3JViz9u7AuU3u
         wLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764615257; x=1765220057;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NZR7hK5x4THTBId2vxyDYOqgCYL0BSheMqFuUmlt+Jw=;
        b=Gvb4wy1qfadEfo9LNdmacg0PJFxxLejtCfwNUOv7WnHvibA3jsH07udu65wPGscjpC
         IPSjzFwNkJ6N+L50tk4ZQL8RTwdYzU3NnSe4lMN/nXKztELnFfs2WqI7VEp5E6OVwT8n
         3JRZoA/zDj0aaTlopSGHpFaN+DDs2jRdcdyt8qPUe3Meyc7kO173GHNIRyNJoD+g6voA
         37AdglgiUtJ8P1EWn7R+1FIP4qtalPlGOWArsRx3RYwXY0KDa9hENHpOUvR9dnoYp2cJ
         yJDYUpe3x/5SklaBBkDmmpKn9zAOWXoWboLfIADb8cTG1vnlYToZC1pC0VmP1PJOmgkC
         lUvA==
X-Forwarded-Encrypted: i=1; AJvYcCWTB7do9XoeX2RhFA2Ry2NdAlIPRjvtfBQ6xvGi2YwpcenK0FZay+fiq+76bvuPrvXWRhCrtFjTFII=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqs1mMbMTyzJKUu8iWsdeIK801x1AA1ryy0o8M1/+ZXpi8cbfR
	g+IP6iMInXzLXtE7699qjX7dG9p2vdHx3p2oNU7i1uIfAMyGOsG4xHC9rSWMeKW23A==
X-Gm-Gg: ASbGncstMn+3cuK1jnqmlhvxHod2AxbViKAmICQ5lpXobS76FCt7owd+aj1YIUreIXH
	xcLLgEjPTYS7KNNUotW4+LNVrBcxF42NuS+kB0ojZWBCdtp8o7vqI++2Gri/eoxbzPiWWthN59n
	xYVCs96+tiPMnCp+LRKcxqEMuXwnTtdc20N2V+pikWrseUSracv/YR5S4jy1MsVszHm/nj7XyEH
	Kf9LsOfLEquqrBFy7GQuPijZp99hTqvGaukdzXMF3Hq6aEF71NSrD5fH08oEQ7QmH6z56lmmBC5
	CHWkAglCQoAjJUeAWKE4y/hZv+7gTsIDaTvAzYEJexUNHVzHnlmO9qQAjarYh7cE61eelXvFm0V
	50aRpsGzw4jZlsucwuQPAoubGp/jQOUCtvM8lg2nQeKm+XMY7SbCdLNWZr6BCMFgm5cookEEpYa
	qp3d/m6b9TLPK2pnit+sGYa4eRFca3jfzrYQOYL/8mN9KCVds=
X-Google-Smtp-Source: AGHT+IEiFxvWkfPP9po3hvukZ9ksCP0VDwl+C6gb0NjWaMPZyH9tph+K1Sdl9eUHW9tCV4/voZXr4g==
X-Received: by 2002:a17:90b:53c3:b0:33f:ebc2:634 with SMTP id 98e67ed59e1d1-3475ebe8173mr23598831a91.9.1764615256953;
        Mon, 01 Dec 2025 10:54:16 -0800 (PST)
Received: from google.com (28.29.230.35.bc.googleusercontent.com. [35.230.29.28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3475e952efbsm8216852a91.1.2025.12.01.10.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 10:54:16 -0800 (PST)
Date: Mon, 1 Dec 2025 18:54:11 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Lukas Wunner <lukas@wunner.de>, Alex Williamson <alex@shazbot.org>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>,
	kvm@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-pci@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
	Parav Pandit <parav@nvidia.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <shuah@kernel.org>, Tomita Moeko <tomitamoeko@gmail.com>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH 02/21] PCI: Add API to track PCI devices preserved across
 Live Update
Message-ID: <aS3kUwlVV_WGT66w@google.com>
References: <20251126193608.2678510-1-dmatlack@google.com>
 <20251126193608.2678510-3-dmatlack@google.com>
 <aSrMSRd8RJn2IKF4@wunner.de>
 <20251130005113.GB760268@nvidia.com>
 <CA+CK2bB0V9jdmrcNjgsmWHmSFQpSpxdVahf1pb3Bz2WA3rKcng@mail.gmail.com>
 <20251201132934.GA1075897@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251201132934.GA1075897@nvidia.com>

On 2025-12-01 09:29 AM, Jason Gunthorpe wrote:
> On Sat, Nov 29, 2025 at 08:20:34PM -0500, Pasha Tatashin wrote:
> > On Sat, Nov 29, 2025 at 7:51 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Sat, Nov 29, 2025 at 11:34:49AM +0100, Lukas Wunner wrote:
> > > > On Wed, Nov 26, 2025 at 07:35:49PM +0000, David Matlack wrote:
> > > > > Add an API to enable the PCI subsystem to track all devices that are
> > > > > preserved across a Live Update, including both incoming devices (passed
> > > > > from the previous kernel) and outgoing devices (passed to the next
> > > > > kernel).
> > > > >
> > > > > Use PCI segment number and BDF to keep track of devices across Live
> > > > > Update. This means the kernel must keep both identifiers constant across
> > > > > a Live Update for any preserved device.
> > > >
> > > > While bus numbers will *usually* stay the same across next and previous
> > > > kernel, there are exceptions.  E.g. if "pci=assign-busses" is specified
> > > > on the command line, the kernel will re-assign bus numbers on every boot.
> > >
> > > Stuff like this has to be disabled for this live update stuff, if the
> > > bus numbers are changed it will break the active use of the iommu
> > > across the kexec.
> > >
> > > So while what you say is all technically true, I'm not sure this is
> > > necessary.
> > 
> > I agree. However, Lukas's comment made me wonder about the future: if
> > we eventually need to preserve non-PCI devices (like a TPM), should we
> > be designing a common identification mechanism for all buses now? Or
> > should we settle on BDF for PCI and invent stable identifiers for
> > other bus types as they become necessary?
> 
> Well, at least PCI subsystem should use BDF..
> 
> You are probably right that the matching of preserved data to a struct
> device should be more general though.

Lukas' suggestion would also make it more reliable to detect bus numbers
changing during a Live Update. We can play whack-a-mole with things like
assign-busses, but there will be a risk that we miss something or
something changes in the future.

Perhaps it would make sense to rely on BDF in the PCI subsystem in the
short term and enforce bus number stability manually (e.g. see patch at
the bottom), and then explore stable device paths as a future
improvement to make PCI device preservation more reliable and also to
enable other bus types?

To handle pci=assign-busses, perhaps something like this? Are there any
other places where the kernel could change busses?

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0ce98e18b5a8..2e1e1aa385a8 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1331,6 +1331,20 @@ static bool pci_ea_fixed_busnrs(struct pci_dev *dev, u8 *sec, u8 *sub)
 	return true;
 }
 
+static bool pci_assign_all_busses(void)
+{
+	/*
+	 * During a Live Update, do not assign new bus numbers. Use bus numbers
+	 * assigned by the firmware and the previous kernel. Bus numbers must
+	 * remain constant so that devices preserved across the Live Update can
+	 * use the IOMMU uninterrupted.
+	 */
+	if (liveupdate_count())
+		return false;
+
+	return pcibios_assign_all_busses();
+}
+
 /*
  * pci_scan_bridge_extend() - Scan buses behind a bridge
  * @bus: Parent bus the bridge is on
@@ -1404,7 +1418,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL,
 			      bctl & ~PCI_BRIDGE_CTL_MASTER_ABORT);
 
-	if ((secondary || subordinate) && !pcibios_assign_all_busses() &&
+	if ((secondary || subordinate) && !pci_assign_all_busses() &&
 	    !is_cardbus && !broken) {
 		unsigned int cmax, buses;
 
@@ -1441,13 +1455,16 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		if (subordinate > max)
 			max = subordinate;
 	} else {
+		pci_WARN_ONCE(dev, liveupdate_count(),
+			      "Assigning new bus numbers during a Live Update! [%u %u %u %u]\n",
+			      secondary, subordinate, is_cardbus, broken);
 
 		/*
 		 * We need to assign a number to this bus which we always
 		 * do in the second pass.
 		 */
 		if (!pass) {
-			if (pcibios_assign_all_busses() || broken || is_cardbus)
+			if (pci_assign_all_busses() || broken || is_cardbus)
 
 				/*
 				 * Temporarily disable forwarding of the
@@ -1522,7 +1539,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 							max+i+1))
 					break;
 				while (parent->parent) {
-					if ((!pcibios_assign_all_busses()) &&
+					if ((!pci_assign_all_busses()) &&
 					    (parent->busn_res.end > max) &&
 					    (parent->busn_res.end <= max+i)) {
 						j = 1;
diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index b913d63eab5f..87a4982d0eb1 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -219,6 +219,7 @@ struct liveupdate_flb {
 
 /* Return true if live update orchestrator is enabled */
 bool liveupdate_enabled(void);
+int liveupdate_count(void);
 
 /* Called during kexec to tell LUO that entered into reboot */
 int liveupdate_reboot(void);
@@ -241,6 +242,11 @@ static inline bool liveupdate_enabled(void)
 	return false;
 }
 
+static inline int liveupdate_count(void)
+{
+	return 0;
+}
+
 static inline int liveupdate_reboot(void)
 {
 	return 0;
diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index 69298d82f404..2f273397bd41 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -256,6 +256,13 @@ bool liveupdate_enabled(void)
 {
 	return luo_global.enabled;
 }
+EXPORT_SYMBOL_GPL(liveupdate_enabled);
+
+int liveupdate_count(void)
+{
+	return luo_global.liveupdate_num;
+}
+EXPORT_SYMBOL_GPL(liveupdate_count);
 
 /**
  * DOC: LUO ioctl Interface

