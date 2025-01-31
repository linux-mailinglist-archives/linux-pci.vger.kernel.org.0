Return-Path: <linux-pci+bounces-20595-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39730A23F3C
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 15:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DACFE18882A2
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 14:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630721C54A6;
	Fri, 31 Jan 2025 14:44:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF24D1B87E9
	for <linux-pci@vger.kernel.org>; Fri, 31 Jan 2025 14:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738334644; cv=none; b=rpOus0x4apcD6l600lxyjcMUQPr8jhFFCrlPPJbGYfzqk09DeYMcAGCh6bgVVcso5PnJUxSsG3ppuHS/bbVsd7dKBggjkFxv7gZwAo/asoemfrqHW1IhUEMjBo3Pg+REzsxae3cOro1tZdmdhYPcYepSA8fVSW+0bXxvEKEWO28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738334644; c=relaxed/simple;
	bh=hOVucOHFuKPcPJL2F8FC3QN1TKKp7yJT2OehjiTOf2g=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cAL6H1Pf/nu5TUDbxhnwQJH57/RqqNAl9YZIG1Hm2z3AqvGnz8oW3ca3vkjyzVKv3nSmzPTrzE4lk5/qyoQD5QeDyjCGncDRKLiWlco4Z3VpXI+ROkPXnDHVywyi6JVlc6wUXxgz79rOIWqurIs4t57OWu0xxPnGMhzOLWOdd7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YkzCS2PXFz6K5ym;
	Fri, 31 Jan 2025 22:43:16 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 29B68140B55;
	Fri, 31 Jan 2025 22:43:58 +0800 (CST)
Received: from localhost (10.195.244.178) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 31 Jan
 2025 15:43:57 +0100
Date: Fri, 31 Jan 2025 14:43:55 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Lukas Wunner <lukas@wunner.de>
CC: Jon Pan-Doh <pandoh@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	<linux-pci@vger.kernel.org>, Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 5/8] PCI/AER: Introduce ratelimit for AER IRQs
Message-ID: <20250131144355.00004065@huawei.com>
In-Reply-To: <Z5SVN8tt-xtCAHph@wunner.de>
References: <20250115074301.3514927-1-pandoh@google.com>
	<20250115074301.3514927-6-pandoh@google.com>
	<Z5SVN8tt-xtCAHph@wunner.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sat, 25 Jan 2025 08:39:35 +0100
Lukas Wunner <lukas@wunner.de> wrote:

> On Tue, Jan 14, 2025 at 11:42:57PM -0800, Jon Pan-Doh wrote:
> > After ratelimiting logs, spammy devices can still slow execution by
> > continued AER IRQ servicing.
> > 
> > Add higher per-device ratelimits for AER errors to mask out those IRQs.
> > Set the default rate to 3x default AER ratelimit (30 per 5s).  
> 
> Masking errors at the register level feels overzealous,
> in particular because it also disables logging via tracepoints.
> 
> Is there a concrete device that necessitates this change?
> If there is, consider adding a quirk for this particular device
> which masks specific errors, but doesn't affect other devices.
> If there isn't, consider dropping this change until a buggy device
> appears that actually needs it.

Fully agree with this comment.  At very least this should default
to not ratelimiting on the tracepoints unless a specific opt in has
occurred (probably a platform or device driver quirk).

In particular I'd worry that you are masking whatever errors are
finally trigger masking.  That might be the only one of that
particular type that was seen and I think the only report we
see is the 'I masked it message'.  So rasdaemon for example
never sees the error at all.   So another tweak would be report
one last time so we definitely see any given error type at least
once.

For CXL errors we trigger off one AER error type (internal error),
but then that is multiplexed onto finer grained errors. Even if
we fix the above we would want the masking in the CXL RAS controls,
not AER.

Jonathan


> 
> Thanks,
> 
> Lukas
> 


