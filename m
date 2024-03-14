Return-Path: <linux-pci+bounces-4836-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4497587C4ED
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 22:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D85A51F221ED
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 21:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4757776418;
	Thu, 14 Mar 2024 21:58:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3D574BF1;
	Thu, 14 Mar 2024 21:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710453503; cv=none; b=NwEbdOHwxaxWnZj2K7dwE1WolwipJStFLem5TA/dItFPteEW4MmTCnpEnOQV25lo9fUWQpGhAfnLU4jjc6DokHipUM1GAuXKQKefMFp9JAKlZh85xzfWEvOV9qkAnout33pcYmZAKt/hJMFSqWnllxPYCJv2+I058Vl5KcPwMhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710453503; c=relaxed/simple;
	bh=QSCWd+TdMFNpJGRQ1DIVGNPy+8YVd9Lq4b3H4thFAz0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SHLohGhKcuPJvwiSErmBMKmSXhNIDgIpeDdMbpiNy50dl0ILsMqw87iRQeltWnzoKFlQyBfhNSV9ScGfIZ6BI02VJIAPNyMYU3aMTzWfC0H0+FGZyMKrEmI8CV18ooX4EuGn4HvVzAGbnArgMoKO+84UEeUrDFIsvYtTpwmpzCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 3A0C092009C; Thu, 14 Mar 2024 22:58:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 2AF7492009B;
	Thu, 14 Mar 2024 21:58:11 +0000 (GMT)
Date: Thu, 14 Mar 2024 21:58:11 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI: Use the correct bit in Link Training not active
 check
In-Reply-To: <c4fe9080-245f-7089-84c1-bb47dcf2cd83@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2403142145010.37739@angie.orcam.me.uk>
References: <20240301150641.4037-1-ilpo.jarvinen@linux.intel.com> <alpine.DEB.2.21.2403011622560.42226@angie.orcam.me.uk> <c740c6e4-ca1a-33ad-8437-4a1219c16eb1@linux.intel.com> <alpine.DEB.2.21.2403060951310.43702@angie.orcam.me.uk>
 <01666075-504d-a434-d039-2e25db931f23@linux.intel.com> <c4fe9080-245f-7089-84c1-bb47dcf2cd83@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 14 Mar 2024, Ilpo Järvinen wrote:

> One more point to add here, I started to wonder today why that use_lt 
> parameter is needed at all for pcie_retrain_link()?
> 
> Once the Target Speed has been changed to 2.5GT/s which is what the quirk 
> does before calling retraining, LT too should work "normally" after that.

 We don't know if the link is going to become stable with the TLS update 
to 2.5GT/s and we want to ensure that the link has reached the active 
state before claiming victory; LT clear does not mean the link is active, 
it only means what it means, that is that the link isn't being trained at 
the moment.

 Also we don't want to reset the TLS to the maximum before the link has 
become active.

 Does this answer your question?

  Maciej

