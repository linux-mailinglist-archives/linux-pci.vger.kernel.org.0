Return-Path: <linux-pci+bounces-33240-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733E6B171A9
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 15:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69CDCA813C2
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 13:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26892241671;
	Thu, 31 Jul 2025 13:01:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6BF7DA95;
	Thu, 31 Jul 2025 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753966894; cv=none; b=RYkjLLi+YrQ2u85x0aVWXh5aPty6yG2MB78iCyB6YIIVcqDRa11s01pUG64WzXM0d+Augz4ZlhLa3y8J/uHIK8k6riPS/Hx8T5p5NlbGY6fGuFVu68suwbcXtt1HWx6brPtOUPezJl6d9/eRi2nocafkKbuu/6VvCR4dkCv7+hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753966894; c=relaxed/simple;
	bh=10Nc3UvULvBe/f+PVIKkbmId2QepTNuYHQwTmW4WA9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVJt384+880O9Z9ZWujwDOlkwJ3DJbVj3Cq37L3OGeOHixSDwgpJ7tdKfjX0UlCa0sGUYmIWB7eQK79tg7RhlHK5+hHriBYmCPnQJrRl1VsA3oY263IUgezPGjSqo5rNh9ILtA1bjexNiYYXMoKb0tZ1ng1FeDiubNk+57UKMT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 6C3922C06E34;
	Thu, 31 Jul 2025 15:01:28 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 550D02A060F; Thu, 31 Jul 2025 15:01:28 +0200 (CEST)
Date: Thu, 31 Jul 2025 15:01:28 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Linas Vepstas <linasvepstas@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Sinan Kaya <okaya@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v3 1/2] PCI/AER: Fix missing uevent on recovery when a
 reset is requested
Message-ID: <aItpKIhYr0T8jf7A@wunner.de>
References: <20250730-add_err_uevents-v3-0-540b158c070f@linux.ibm.com>
 <20250730-add_err_uevents-v3-1-540b158c070f@linux.ibm.com>
 <aIp6LiKJor9KLVpv@wunner.de>
 <aIp_Z9IdwSjMtDho@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIp_Z9IdwSjMtDho@wunner.de>

On Wed, Jul 30, 2025 at 10:24:07PM +0200, Lukas Wunner wrote:
> On Wed, Jul 30, 2025 at 10:01:50PM +0200, Lukas Wunner wrote:
> > On Wed, Jul 30, 2025 at 01:20:57PM +0200, Niklas Schnelle wrote:
> > > Since commit 7b42d97e99d3 ("PCI/ERR: Always report current recovery
> > > status for udev") AER uses the result of error_detected() as parameter
> > > to pci_uevent_ers(). As pci_uevent_ers() however does not handle
> > > PCI_ERS_RESULT_NEED_RESET this results in a missing uevent for the
> > > beginning of recovery if drivers request a reset. Fix this by treating
> > > PCI_ERS_RESULT_NEED_RESET as beginning recovery.
> > [...]
> > > +++ b/drivers/pci/pci-driver.c
> > > @@ -1592,6 +1592,7 @@ void pci_uevent_ers(struct pci_dev *pdev, enum pci_ers_result err_type)
> > >  	switch (err_type) {
> > >  	case PCI_ERS_RESULT_NONE:
> > >  	case PCI_ERS_RESULT_CAN_RECOVER:
> > > +	case PCI_ERS_RESULT_NEED_RESET:
> > >  		envp[idx++] = "ERROR_EVENT=BEGIN_RECOVERY";
> > >  		envp[idx++] = "DEVICE_ONLINE=0";
> > >  		break;
> > 
> > I note that PCI_ERS_RESULT_NO_AER_DRIVER is also missing in that
> > switch/case statement.  I guess for the patch to be complete,
> > it needs to be added to the PCI_ERS_RESULT_DISCONNECT case.
> > Do you agree?
> 
> I realize now there's a bigger problem here:  In pcie_do_recovery(),
> when control reaches the "failed:" label, a uevent is only signaled
> for the *bridge*.  Shouldn't a uevent instead be signaled for every
> device *below* the bridge?  (And possibly the bridge itself if it was
> the device reporting the error.)

The small patch below should resolve this issue.
Please let me know what you think.

> In that case you don't need to add PCI_ERS_RESULT_NO_AER_DRIVER to
> the switch/case statement because we wouldn't want to have multiple
> uevents reporting disconnect, so the one emitted below the "failed:"
> label would be sufficient.

I'll send a separate Reviewed-by for your original patch as the small
patch below should resolve my concern about PCI_ERS_RESULT_NO_AER_DRIVER.

> This all looks so broken that I'm starting to wonder if there's any
> user space application at all that takes advantage of these uevents?

I'd still be interested to know which user space application you're
using to track these uevents?

Thanks,

Lukas

-- >8 --

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index e795e5ae..3a95aa2 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -165,6 +165,12 @@ static int report_resume(struct pci_dev *dev, void *data)
 	return 0;
 }
 
+static int report_disconnect(struct pci_dev *dev, void *data)
+{
+	pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
+	return 0;
+}
+
 /**
  * pci_walk_bridge - walk bridges potentially AER affected
  * @bridge:	bridge which may be a Port, an RCEC, or an RCiEP
@@ -272,7 +278,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 failed:
 	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
 
-	pci_uevent_ers(bridge, PCI_ERS_RESULT_DISCONNECT);
+	pci_walk_bridge(bridge, report_disconnect, NULL);
 
 	pci_info(bridge, "device recovery failed\n");
 

