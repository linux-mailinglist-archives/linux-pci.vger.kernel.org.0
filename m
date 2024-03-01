Return-Path: <linux-pci+bounces-4340-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2935286E712
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 18:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1153286AD1
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 17:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46DB525B;
	Fri,  1 Mar 2024 17:22:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910895228;
	Fri,  1 Mar 2024 17:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709313768; cv=none; b=DAu36qoVKZ5L4pwuh0nzrZqrBjbJizhXTYbUmsqsI/AE0GlV+IbHqwdsxH4Ou5qxMsvvSFmuCLUOC29wNlXWEMJ20i0SawQ6PubJXX1FHGb/0F3dU3jdDvCOR81WCcDVjs49aWMTmYJdm19CYZsb0kuFfzc9aqplYqDLCuxGLAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709313768; c=relaxed/simple;
	bh=ovQQBQAWHPAsC8cOFrxmlF14GYtzvzGc9A84d8GOGEE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bLKHHg2jbHjEADW9eoJ97KHJOAhsslM4PtxmM8RCHnbJ0w0RHQmw7C9Kr1gya29Q4AvbMQSSH4KCPvUVl3lnnErhbKDBKvlJXj1v2Z+tGCdR/S3+gYFNZknwNlWk82T4zXNKKERg34WXFRJvnXi6d0RAFWZekQOUMYo3aoGzi5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 193D192009C; Fri,  1 Mar 2024 18:22:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 0ABCE92009B;
	Fri,  1 Mar 2024 17:22:38 +0000 (GMT)
Date: Fri, 1 Mar 2024 17:22:37 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: Use the correct bit in Link Training not active
 check
In-Reply-To: <20240301150641.4037-1-ilpo.jarvinen@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2403011622560.42226@angie.orcam.me.uk>
References: <20240301150641.4037-1-ilpo.jarvinen@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 1 Mar 2024, Ilpo Järvinen wrote:

> Besides Link Training bit, pcie_retrain_link() can also be asked to
> wait for Data Link Layer Link Active bit (PCIe r6.1 sec 7.5.3.8) using
> 'use_lt' parameter since the merge commit 1abb47390350 ("Merge branch
> 'pci/enumeration'").

 Nope, it was added with commit 680e9c47a229 ("PCI: Add support for 
polling DLLLA to pcie_retrain_link()"), before said merge.

> pcie_retrain_link() first tries to ensure Link Training is not
> currently active (see Implementation Note in PCIe r6.1 sec 7.5.3.7)
> which must always check Link Training bit regardless of 'use_lt'.
> Correct the pcie_wait_for_link_status() parameters to only wait for
> the correct bit to ensure there is no ongoing Link Training.

 You're talking the PCIe spec here and code is talking a bad device case.

> Since waiting for Data Link Layer Link Active bit is only used for the
> Target Speed quirk, this only impacts the case when the quirk attempts
> to restore speed to higher than 2.5 GT/s (The link is Up at that point
> so pcie_retrain_link() will fail).

 NAK.  It's used for both clamping and unclamping and it will break the 
workaround, because the whole point there is to wait until DLLA has been 
set.  Using LT is not reliable because it will oscillate in the failure 
case and seeing the bit clear does not mean link has been established.  

 What are you trying to achieve here and what problem is it to fix?

  Maciej

