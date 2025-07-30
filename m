Return-Path: <linux-pci+bounces-33201-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE6EB16748
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 22:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB970174659
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 20:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5211F3B87;
	Wed, 30 Jul 2025 20:02:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197F735953;
	Wed, 30 Jul 2025 20:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753905722; cv=none; b=g/w+InHsFHRqNOfh0stCcD2isJVerME6oNE3LX/yigBYqrzjxogC8SSPbYgFkUTul2sScb7I93dgcPoQB0S4ZV3nnIbdbJvckB6VvhrptlMxYSlZr29O7GYlBk/aoR1P/dpRHI6liO4NLO0Pwq/18e0LG8nUR3Al3SGjWFVqPO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753905722; c=relaxed/simple;
	bh=ipvWMC5ORKpXf13zvvXvYaHycqW+1ujf+id3s3rcLsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1HQVgndceX2xfj5SvhOO1E0khDIFGv2WWBG8JpZiJiFels1LwYb+McM1vTftpB9H7aemqqt49BHsZxgcnrGUqED9sCqK9FBSwYzxq+Rr4/5HRXK/1bGIgpBN66NFxGC0kaVg69+pw5AFSnnRC+GTJNmKJPLziFWtu5PlaRgTIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 71CAD200B1CF;
	Wed, 30 Jul 2025 22:01:50 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 5A85339C007; Wed, 30 Jul 2025 22:01:50 +0200 (CEST)
Date: Wed, 30 Jul 2025 22:01:50 +0200
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
Message-ID: <aIp6LiKJor9KLVpv@wunner.de>
References: <20250730-add_err_uevents-v3-0-540b158c070f@linux.ibm.com>
 <20250730-add_err_uevents-v3-1-540b158c070f@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730-add_err_uevents-v3-1-540b158c070f@linux.ibm.com>

On Wed, Jul 30, 2025 at 01:20:57PM +0200, Niklas Schnelle wrote:
> Since commit 7b42d97e99d3 ("PCI/ERR: Always report current recovery
> status for udev") AER uses the result of error_detected() as parameter
> to pci_uevent_ers(). As pci_uevent_ers() however does not handle
> PCI_ERS_RESULT_NEED_RESET this results in a missing uevent for the
> beginning of recovery if drivers request a reset. Fix this by treating
> PCI_ERS_RESULT_NEED_RESET as beginning recovery.
[...]
> +++ b/drivers/pci/pci-driver.c
> @@ -1592,6 +1592,7 @@ void pci_uevent_ers(struct pci_dev *pdev, enum pci_ers_result err_type)
>  	switch (err_type) {
>  	case PCI_ERS_RESULT_NONE:
>  	case PCI_ERS_RESULT_CAN_RECOVER:
> +	case PCI_ERS_RESULT_NEED_RESET:
>  		envp[idx++] = "ERROR_EVENT=BEGIN_RECOVERY";
>  		envp[idx++] = "DEVICE_ONLINE=0";
>  		break;

I note that PCI_ERS_RESULT_NO_AER_DRIVER is also missing in that
switch/case statement.  I guess for the patch to be complete,
it needs to be added to the PCI_ERS_RESULT_DISCONNECT case.
Do you agree?

If you do and respin the patch with that change, feel free to add
my Reviewed-by.

Since you're an IBMer and EEH is maintained by IBM, I'm wondering
if it would be possible to amend EEH to report "rc" instead of
PCI_ERS_RESULT_NONE in eeh_report_error()?  There are multiple
deviations between AER and EEH, this is one of them.  It would
be good to move towards a more consistent recovery process across
platforms.

Thanks,

Lukas

