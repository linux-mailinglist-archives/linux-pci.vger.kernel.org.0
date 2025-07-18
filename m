Return-Path: <linux-pci+bounces-32473-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C884B098B8
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 02:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6EE558587F
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 00:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF73136E;
	Fri, 18 Jul 2025 00:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="VjdYPlHm"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B09E182;
	Fri, 18 Jul 2025 00:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752797125; cv=none; b=MsicWiYhrEqPmTEyk40/ygqXjlU+dPE3dc9/9UIarLRhKsvszbFuMucbLtsosT6bvAfD7Pzn5EShDezj8+uuVrEu+nzGpWA8SdzgPjBwy2QUS5mwgmm3xzrGAu9iIJbLHpO+1t/3l7xhIE3MbT2QRTTm2OddJF6TJz/6oArwHRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752797125; c=relaxed/simple;
	bh=BjITnCdBAzI0MQalAl38WFS1xnO9Ts5R2ceAbYlxbyg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=bR4sybLZHhYia1ioyVn5xj5VfkFVFAyOC4kgsAiGLttnMGmQgXk3t6ipucisp3nrBJoNDFThoAUNFggBwGpN422/U0e0PMWqvUPdvxCyNijpLUEFmZGwr4Q8ZiV3khj89hZwsq1iubxKtVqw07yCStmPlU7iHOoVLMv1DkDLYqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=VjdYPlHm; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 02D168285589;
	Thu, 17 Jul 2025 19:05:16 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id joaj3DPirEEm; Thu, 17 Jul 2025 19:05:12 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 39E43828775B;
	Thu, 17 Jul 2025 19:05:12 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 39E43828775B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1752797112; bh=HH/9mXt7gkyzrKXSj6txN9ECfNMdRVxJxuDvf9QCG70=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=VjdYPlHmlBacwsUZm4AkIqdRIbHvyx+3JPKcvOjHoutc761D7ZA51jRKEcrqPLhE9
	 CsOlf/ZlO+CJCsH5X7vjU2K0Nsgoj9flw5in3flUi0hd2q9fsRgeGOzuR6VffvdEec
	 uEyR39exZl4EO6NvYCZNE0yoSQlqG1JypmQkjYts=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6FN37W4-erl3; Thu, 17 Jul 2025 19:05:11 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id DC84D8285589;
	Thu, 17 Jul 2025 19:05:11 -0500 (CDT)
Date: Thu, 17 Jul 2025 19:05:08 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Timothy Pearson <tpearson@raptorengineering.com>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-pci <linux-pci@vger.kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, 
	christophe leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	Shawn Anastasio <sanastasio@raptorengineering.com>
Message-ID: <551742074.1370228.1752797108649.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <20250717232745.GA2662794@bhelgaas>
References: <20250717232745.GA2662794@bhelgaas>
Subject: Re: [PATCH v3 5/6] PCI: pnv_php: Fix surprise plug detection and
 recovery
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC138 (Linux)/8.5.0_GA_3042)
Thread-Topic: pnv_php: Fix surprise plug detection and recovery
Thread-Index: SRr2FJcjkaGgIRkFlhO9QWQJ8V6vhw==



----- Original Message -----
> From: "Bjorn Helgaas" <helgaas@kernel.org>
> To: "Timothy Pearson" <tpearson@raptorengineering.com>
> Cc: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-pci"
> <linux-pci@vger.kernel.org>, "Madhavan Srinivasan" <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>,
> "christophe leroy" <christophe.leroy@csgroup.eu>, "Naveen N Rao" <naveen@kernel.org>, "Bjorn Helgaas"
> <bhelgaas@google.com>, "Shawn Anastasio" <sanastasio@raptorengineering.com>
> Sent: Thursday, July 17, 2025 6:27:45 PM
> Subject: Re: [PATCH v3 5/6] PCI: pnv_php: Fix surprise plug detection and recovery

> On Tue, Jul 15, 2025 at 04:39:06PM -0500, Timothy Pearson wrote:
>> The existing PowerNV hotplug code did not handle surprise plug events
>> correctly, leading to a complete failure of the hotplug system after
>> device removal and a required reboot to detect new devices.
> 
>> +++ b/drivers/pci/hotplug/pnv_php.c
>> @@ -4,12 +4,14 @@
>>   *
>>   * Copyright Gavin Shan, IBM Corporation 2016.
>>   * Copyright (C) 2025 Raptor Engineering, LLC
>> + * Copyright (C) 2025 Raptor Computing Systems, LLC
> 
> Just to double-check that you want both copyright lines here?

Yes, both entities ended up sponsoring this part of the work over time.  Thank you for double checking!

