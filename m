Return-Path: <linux-pci+bounces-4015-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4158675B7
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 13:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70801F27AE2
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 12:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDDF7F7F9;
	Mon, 26 Feb 2024 12:55:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B0E7F7EC;
	Mon, 26 Feb 2024 12:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708952118; cv=none; b=iZcvoQGrxRT+Xc2KNENlhUfkXZDsRNaFBWAjnzCaPBh01pXswM181toTwtKQ+NVnyKAtpIz6d3cKUiGTIC5v/fHlgQzhVZYoWkHR9UVWb/rcWj9O+IkZNSEW6P3t1QL8ckftvv31TbbFx4ODDZcQCLHVU8jBcM/ptpi4H9G0XUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708952118; c=relaxed/simple;
	bh=ftlPqeR87KGSpz19WNbfN03npJ6lFzJpiw/GgfRyyNE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tb8L5Bz0bLZt5n7chONAh0SE9CzptrRztz0T4ndMyCiPWDUpBClFW6Z4brWdGgnn/r0lNA5UlXiA+dQAlx6UBsztt4db9qlIYXGxkF71aQ5Ur/kSQXBAfwnChImEBTJlWF24xPJGIBsPf+yrUxYL6f3cw1m5Hjo00mtelWI9Gqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id DEA0992009C; Mon, 26 Feb 2024 13:55:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id D9A4392009B;
	Mon, 26 Feb 2024 12:55:14 +0000 (GMT)
Date: Mon, 26 Feb 2024 12:55:14 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Bjorn Helgaas <bhelgaas@google.com>
cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
    linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: Rework error reporting with PCIe failed link
 retraining
In-Reply-To: <alpine.DEB.2.21.2402092125070.2376@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2402261249230.60326@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2402092125070.2376@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 10 Feb 2024, Maciej W. Rozycki wrote:

> Unfortunately I cannot verify the changes anymore beyond just checking 
> that the system `pcie_failed_link_retrain' was intended for still boots, 
> because something happened that makes the problematic link not to work at 
> all.
[...]
>  Hopefully I'll be able fix it one way or another and will be able to 
> report on LBMS behaviour too, that is whether it retriggers with every 
> link training iteration or not.

 As mentioned in the other thread, I have now fixed the hardware failure, 
and I'll try to collect information on LBMS reporting sometime this week.  
I've brought additional hardware too in case I couldn't address the issue, 
so I may be able to find out more.  I'll report on my findings once I have 
them.

  Maciej

