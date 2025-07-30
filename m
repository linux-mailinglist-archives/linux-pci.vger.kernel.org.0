Return-Path: <linux-pci+bounces-33202-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB98B16791
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 22:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34FDB7AE17A
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 20:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20C6213E66;
	Wed, 30 Jul 2025 20:24:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EBF1E7C19;
	Wed, 30 Jul 2025 20:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753907057; cv=none; b=NVDx45FKTAHJJAJ+B8+WzDQnxPpnMnkvndYhyPm9IQk4XZJcSHaqWXOgxWXgqFoPyaf/70iBYTQkQOdtFEMzJfhFkOLE/1soJCzQ17On2AER1R6PK2jz1DrDb6PpWFhdRQOCESKOlaIdYfPmTBZKD1TBRP0r6cv7VMBT+d2p/cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753907057; c=relaxed/simple;
	bh=VUbTMcf9w61UswesyXxS8pLpFqy8WRInjHYkTP1EmH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/FZn9oex2kLuVo8/78MFK8BSNx1RGJ+7/gaA69xVehAtSXhQKATgeVsDnkGXW4xD06J73sunYZsFeDm8H1RM/wKbI6Z6jcK2DjqnMHvd1NJOHJiQzIqBibrn5aTKjMMd8W5bksk6sLaWJX3a+M11qOYaF0ZPiTYWNNr1Tisv8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 7F00D2C02AD6;
	Wed, 30 Jul 2025 22:24:07 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6C714467C48; Wed, 30 Jul 2025 22:24:07 +0200 (CEST)
Date: Wed, 30 Jul 2025 22:24:07 +0200
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
Message-ID: <aIp_Z9IdwSjMtDho@wunner.de>
References: <20250730-add_err_uevents-v3-0-540b158c070f@linux.ibm.com>
 <20250730-add_err_uevents-v3-1-540b158c070f@linux.ibm.com>
 <aIp6LiKJor9KLVpv@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIp6LiKJor9KLVpv@wunner.de>

On Wed, Jul 30, 2025 at 10:01:50PM +0200, Lukas Wunner wrote:
> On Wed, Jul 30, 2025 at 01:20:57PM +0200, Niklas Schnelle wrote:
> > Since commit 7b42d97e99d3 ("PCI/ERR: Always report current recovery
> > status for udev") AER uses the result of error_detected() as parameter
> > to pci_uevent_ers(). As pci_uevent_ers() however does not handle
> > PCI_ERS_RESULT_NEED_RESET this results in a missing uevent for the
> > beginning of recovery if drivers request a reset. Fix this by treating
> > PCI_ERS_RESULT_NEED_RESET as beginning recovery.
> [...]
> > +++ b/drivers/pci/pci-driver.c
> > @@ -1592,6 +1592,7 @@ void pci_uevent_ers(struct pci_dev *pdev, enum pci_ers_result err_type)
> >  	switch (err_type) {
> >  	case PCI_ERS_RESULT_NONE:
> >  	case PCI_ERS_RESULT_CAN_RECOVER:
> > +	case PCI_ERS_RESULT_NEED_RESET:
> >  		envp[idx++] = "ERROR_EVENT=BEGIN_RECOVERY";
> >  		envp[idx++] = "DEVICE_ONLINE=0";
> >  		break;
> 
> I note that PCI_ERS_RESULT_NO_AER_DRIVER is also missing in that
> switch/case statement.  I guess for the patch to be complete,
> it needs to be added to the PCI_ERS_RESULT_DISCONNECT case.
> Do you agree?

I realize now there's a bigger problem here:  In pcie_do_recovery(),
when control reaches the "failed:" label, a uevent is only signaled
for the *bridge*.  Shouldn't a uevent instead be signaled for every
device *below* the bridge?  (And possibly the bridge itself if it was
the device reporting the error.)

In that case you don't need to add PCI_ERS_RESULT_NO_AER_DRIVER to
the switch/case statement because we wouldn't want to have multiple
uevents reporting disconnect, so the one emitted below the "failed:"
label would be sufficient.

Right now we may report BEGIN_RECOVERY to user space, but we fail to
later on signal FAILED_RECOVERY (unless I'm missing something).

This all looks so broken that I'm starting to wonder if there's any
user space application at all that takes advantage of these uevents?

Thanks,

Lukas

