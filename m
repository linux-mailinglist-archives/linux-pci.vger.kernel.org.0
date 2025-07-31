Return-Path: <linux-pci+bounces-33241-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12022B171B9
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 15:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 474255802F9
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 13:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68112C1582;
	Thu, 31 Jul 2025 13:04:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830363A8C1;
	Thu, 31 Jul 2025 13:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753967066; cv=none; b=eo9pYwPPFTbYmaWsnQUhrOzySPQvQPJFUhUJqySj2RkqMGmyWPTxrt6lqNcnct8ap/kBmxy+BPM7DsEoH/0lh23N/VOvmL6z2QB4SmB+aEj2WpQ30cv1wxXgR5LF1Ul1w5CvdZ9FMv1RC59ADCa6n/ReDyZ1BL8MFyq1LZjl3Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753967066; c=relaxed/simple;
	bh=hnNNL1muVNtWgWimMK0tj3kLYw9BGtZEbs34PoRgGLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m78j4xOojyYJAxFyRT8ORrFK1rxxwA3e1bZJLxY2O4xNJqwahnV6Omm8QbYBZAS2xCzqLuWXN03Cjfx6g8yur98bRbPD0HDfkE0RNmIGUffJOBXL57idwaRAoAp8czWB53gj/pdc+c5fgddU8Ls31jQuh6NMC4u91zo0csbL10c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id C0D832C06E34;
	Thu, 31 Jul 2025 15:04:22 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A42CD2A060E; Thu, 31 Jul 2025 15:04:22 +0200 (CEST)
Date: Thu, 31 Jul 2025 15:04:22 +0200
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
Message-ID: <aItp1uUeYBsv0z_-@wunner.de>
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
> 
> Cc: stable@vger.kernel.org
> Fixes: 7b42d97e99d3 ("PCI/ERR: Always report current recovery status for udev")
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>

