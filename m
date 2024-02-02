Return-Path: <linux-pci+bounces-3022-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8DF8471C4
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 15:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55FC6282895
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 14:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A08140771;
	Fri,  2 Feb 2024 14:22:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103C513E228;
	Fri,  2 Feb 2024 14:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706883736; cv=none; b=r3HPYjar4xir/0bcQTiEechWzp9K6FZGi7Z0sHj1plme5fjDLCTy84xm9/4HnLnQ/RDxlXB85+yleDWcPHOO+TwF6fRUSaTWlzPDNOPz7sOOnWsHxjYSlV6+BxCF5uYIZa5eb+BbP5ZrwwjgJb7Lo0K3PPyrt25koLvvACOOZUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706883736; c=relaxed/simple;
	bh=e8mbu9VI1MYm93k66z/fyWP4oHlqGTyfNIeheP4a2oM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sGNp9POePubt+kbQfbso4+vlJ3DaHEsuBpHo0jp2DljCy6HeZav5iYIwHGs8uIZw3gRnKSX/7Y1mXXlttrz03Fs07tc2S1W3672KgcsfKE7m4Hz+ars69IFWthbqxWQlRVAJeMfndMqqlatTycW6+9YMfUSpP24lBIPTxDyXglk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id AE36B92009C; Fri,  2 Feb 2024 15:22:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id A704492009B;
	Fri,  2 Feb 2024 14:22:10 +0000 (GMT)
Date: Fri, 2 Feb 2024 14:22:10 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    linux-kernel@vger.kernel.org, 
    Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/1] PCI: Cleanup link activation wait logic
In-Reply-To: <20240202134108.4096-1-ilpo.jarvinen@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2402021359450.15781@angie.orcam.me.uk>
References: <20240202134108.4096-1-ilpo.jarvinen@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 2 Feb 2024, Ilpo Järvinen wrote:

> 1. Change pcie_failed_link_retrain() to return true only if link was
>    retrained successfully due to the Target Speed quirk. If there is no
>    LBMS set, return false instead of true because no retraining was
>    even attempted. This seems correct considering expectations of both
>    callers of pcie_failed_link_retrain().

 You change the logic here in that the second conditional isn't run if the 
first has not.  This is wrong, unclamping is not supposed to rely on LBMS. 
It is supposed to be always run and any failure has to be reported too, as 
a retraining error.  I'll send an update according to what I have outlined 
before then, with some testing done first.

> 2. Handle link-was-not-retrained-successfully return (false) from
>    pcie_failed_link_retrain() properly in pcie_wait_for_link_delay() by
>    directly returning false.

 I think it has to be a separate change, as a fix to what I can see is an 
issue with a three-way-merge done with commit 1abb47390350 ("Merge branch 
'pci/enumeration'"); surely a bool result wasn't supposed to be assigned 
to an int variable carrying an error code.

 Either or both changes may have to be backported independently.

  Maciej

