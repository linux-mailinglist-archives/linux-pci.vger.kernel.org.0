Return-Path: <linux-pci+bounces-7060-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8798BB655
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 23:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A794FB267C4
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 21:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D279258AA7;
	Fri,  3 May 2024 21:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IeBg60tK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lw4CfQAw"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABA654903;
	Fri,  3 May 2024 21:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772522; cv=none; b=Js6fBIZBvpsTVpmBYU1p5h7vVXIWY4srRMJOeb9r9uKZG/R8uT6cWh0VeG+2/LwlZIaKjI/eoG/h6MCKEOI3iwuTvGhgD+KKWeN9MqsM4xKlS2XIRP4P0yZ8wnCvw1xMR0GLZ4dchp8DIjTEBxy4E/ALefevc8FP4td3c8p26bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772522; c=relaxed/simple;
	bh=HQm+V3Biee53no+YJeqbhU4w8NB6wtn8SA4D32s6iXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=je/tRnM3p4Va1NcoPCYpddwJFiJl+c8tLKdvuwfvPbaeMPyxB9gxgNojPkLb6LBl620YdMYC+DcuXXOJq1y/b8xc6gTQJLfd5WJ7mxEu2lgnLyNmxwgclvACtGzwZ07nzI54vkxgkYIp6XShEovVuEr9CHdE+RnFdRqyAxT6LtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IeBg60tK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lw4CfQAw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 3 May 2024 23:41:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714772519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rm+oVconEb8YVTlSeJTiM2JoTmuBUcCQK7KwBej9OiE=;
	b=IeBg60tKkbm9N/BcYYvVbK1kBVYcQ4JKONUl83wDZljZal3E87dNJ05FtGtG1qBrmc9xNP
	8LBhKCXHSuSDvxXQPqjrY6QnYwpv7CxMNcbJhFnWyXqvKyCJTXwXDTSnI0XJFpopF2IiW4
	9DCPQN59gYMwdU7Dka5RhGZbRuQjow1L9bW4WlxhzsV+Z9qzyFucnw12SgcL4Z7ce90HoR
	7BLQVQOw4ffoQP/8XtuXUIsJ8m+3UsWxWLw/HwFfoTo0fCcwSs/sgMpn9QlOOu1/dAcv3F
	QprKPIKC8doHpn7bwV3k6lI7AsU/N1nRC8XhdBVS10K0Q0wS1m93yZcOkS9gCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714772519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rm+oVconEb8YVTlSeJTiM2JoTmuBUcCQK7KwBej9OiE=;
	b=lw4CfQAwSHiG9TSRGDDHaMyDeOm7T38Eei/usvVBJ+Yk0AisxpKsszaEomJnere1BenYKx
	ROo4CvmJzV4UdSAg==
From: Nam Cao <namcao@linutronix.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rajesh Shah <rajesh.shah@intel.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 2/4] PCI: pciehp: bail out if pci_hp_add_bridge() fails
Message-ID: <20240503214152.p902TB4a@linutronix.de>
References: <401e4044e05d52e4243ca7faa65d5ec8b19526b8.1714762038.git.namcao@linutronix.de>
 <20240503212341.GA1604125@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503212341.GA1604125@bhelgaas>

On Fri, May 03, 2024 at 04:23:41PM -0500, Bjorn Helgaas wrote:
> On Fri, May 03, 2024 at 09:23:20PM +0200, Nam Cao wrote:
> > If there is no bus number available for the downstream bus of the
> > hot-plugged bridge, pci_hp_add_bridge() will fail. The driver proceeds
> > regardless, and the kernel crashes.
> > 
> > Abort if pci_hp_add_bridge() fails.
> 
> Thanks for this and for the details in the cover letter.  The cover
> letter doesn't get directly preserved and connected to the git commit,
> so please include some of the details here in the commit log.
> 
> I don't think we need *everything* from the cover letter; just enough
> of the messages to show what went wrong and how the kernel crashed, so
> somebody who trips over this can connect the crash with this fix.  And
> the timestamps are not relevant, so you can strip them out.  The qemu
> repro case is useful too, thanks for that!
> 
> Same for the shpchp patch.
> 
> And use "git log --oneline drivers/pci/hotplug/pciehp_pci.c" and match
> the formatting (in particular, the capitalization) of your subject
> lines.

Thanks for the detailed instructions. I will send v2 next week.

Best regards,
Nam

