Return-Path: <linux-pci+bounces-30088-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 028E5ADF22D
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 18:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDABB3B9167
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 16:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7282F0022;
	Wed, 18 Jun 2025 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="mUshL+nz"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2662ED159;
	Wed, 18 Jun 2025 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263016; cv=none; b=AailKEENOI08/gOVI2v4Q3R9r8myIPxFYblaynhr2h4Aurj4QrlKLLMYdGR5mj832D7am295otYPqhCw5ohhNyvszHgmwCwxcgoBsXiQI56Qy+FyROT98LmMvDDYXSbpzj8VvxLj0BH3xi3hYWEliSF3UA31Tv/+KSSVzdp4Kp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263016; c=relaxed/simple;
	bh=NOym2xZcgJfB+z+AAQuaFL7SN41M6k+rBUoLUvCNhGQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=hy1AQzMjQDVQRc9A1a1v7i+O6rOlyg6sAlp8A6cE+SwdaE/8xeUMqPHlj6LbxXDHBSompdXEgWJzZ1LfMq6CFvOWOxq7Gp8gG6ecC+0yxAWnHyu6IlyyZFgA92TNqmD++eKFGJJy7SfLXRKuydYniCzhZ/Nk02OjVfAeNVbgTWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=mUshL+nz; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 455FF82888DD;
	Wed, 18 Jun 2025 11:10:06 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id X_pUIaLZDl61; Wed, 18 Jun 2025 11:10:02 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 909B88288871;
	Wed, 18 Jun 2025 11:10:02 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 909B88288871
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1750263002; bh=jzmacsdU6uI9FhGkK2oO6/7D6m0SuoLy6Bj4U6ELlRA=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=mUshL+nzI8gkBXELnjg9WBeHhA5NGuq1DLusUDrP6UwP2TxvvudbCMreU7GQQIk0U
	 BXQR9Lj73ak0tJhV4RUCgMsfbGCkqexCCemoZ252ZbK9TEHxFHCJCiz+43KufZTfLv
	 ATErfBUqQ7E1g+fNFa4smT7cdZ1BJHrm+BeYO0m0=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JI3qCWrOjecK; Wed, 18 Jun 2025 11:10:02 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 4C0C382882C6;
	Wed, 18 Jun 2025 11:10:02 -0500 (CDT)
Date: Wed, 18 Jun 2025 11:10:02 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-pci <linux-pci@vger.kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, 
	christophe leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	Shawn Anastasio <sanastasio@raptorengineering.com>
Message-ID: <1728509613.1310543.1750263002144.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <aFJQ8AtYlKx1t_ri@infradead.org>
References: <946966095.1309769.1750220559201.JavaMail.zimbra@raptorengineeringinc.com> <aFJQ8AtYlKx1t_ri@infradead.org>
Subject: Re: [PATCH 3/8] powerpc/pseries/eeh: Export eeh_unfreeze_pe() and
 eeh_ops
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC137 (Linux)/8.5.0_GA_3042)
Thread-Topic: powerpc/pseries/eeh: Export eeh_unfreeze_pe() and eeh_ops
Thread-Index: bupdJGUzprnsSSzB+HYmaNkawJnfUQ==



----- Original Message -----
> From: "Christoph Hellwig" <hch@infradead.org>
> To: "Timothy Pearson" <tpearson@raptorengineering.com>
> Cc: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-pci"
> <linux-pci@vger.kernel.org>, "Madhavan Srinivasan" <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>,
> "christophe leroy" <christophe.leroy@csgroup.eu>, "Naveen N Rao" <naveen@kernel.org>, "Bjorn Helgaas"
> <bhelgaas@google.com>, "Shawn Anastasio" <sanastasio@raptorengineering.com>
> Sent: Wednesday, June 18, 2025 12:38:56 AM
> Subject: Re: [PATCH 3/8] powerpc/pseries/eeh: Export eeh_unfreeze_pe() and eeh_ops

> On Tue, Jun 17, 2025 at 11:22:39PM -0500, Timothy Pearson wrote:
>>  /* Platform dependent EEH operations */
>>  struct eeh_ops *eeh_ops = NULL;
>> +EXPORT_SYMBOL(eeh_ops);
> 
> Exporting ops vectors is generally a really bad idea.  Please build a
> proper abstraction instead.
> 
> And use EXPORT_SYMBOL_GPL for any kind of low-level API.

Fair enough.  I'll add a properly exported method for PE get_state() and update the series in the next couple of days.

