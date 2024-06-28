Return-Path: <linux-pci+bounces-9394-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C43A891B626
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 07:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35D65B227AB
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 05:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2271A33086;
	Fri, 28 Jun 2024 05:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="TwzTH6mf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60941249F5;
	Fri, 28 Jun 2024 05:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719552883; cv=none; b=ON908fcuMRMBK7klrLTisCJQs3E34CDGFM9V22FOVdN60u/Or4Py8jqCsp2mwBC40ielF3RbMeFNRbWQZj98iaIUvL2oz2YVXHMCTseCh09U8GhfRNsrXd25/B1junPpCZfuzbQq7lEa/CBmnkAu/EyH7e1Z95f4hwd1INO5fYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719552883; c=relaxed/simple;
	bh=+YTi0H7GC5/m+a9k9DgfF9CeXLW+NiWbJeFYLixWHXg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AWMs7adcxMPkyoRdo8uiy/FP0GApYfKuBy98xdAzO724pMVc2bumJjub/6pKTgFS6vDROLL/AyGju+dYxGPmR3NBLGei0ft4Q2Veu3D6khjFYrIXzx4nwQYg0qFexObGeLVd/svhP4rUmgO/IlEjB+3N29prJepPlvv8moicq6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=TwzTH6mf; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1719552878;
	bh=V4tEOQ9UGeIQAjhJ/FQpHexugT3Fmzlf9p6/vfCvUD4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TwzTH6mfqpKiM1bOviw8zRJTdZB++J8GHaNmHXyFy3VEq+bf+AoMBXmU8HQ4892hj
	 Ny2e84gcWtweIRFQ1Zw2LI5LnFubWaLq5qKkRDskMZoc0/yJfndG0/yB0Bns5I+Ou0
	 letwP18U4KkhuOzO3dMU/B07Huqgcm6ztkKRWa1NXcmZpf37u9Hm6wMAlFN19afbtf
	 ieIb46kvzG0O9b9WiVBGzIXGQwbRdXtO3RFE9QSbHHjJCeATKvOvVZkKKJFz9ejz6H
	 guoWXUbWm3oZiACaX9m2Ohi0+itg5hvdluC4MyVSfWyeZfV40yw02H9vZGdX/BGBWY
	 bPiCZZYBBi7AQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9PJZ2TWqz4w2N;
	Fri, 28 Jun 2024 15:34:38 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bjorn Helgaas <helgaas@kernel.org>, Krishna Kumar <krishnak@linux.ibm.com>
Cc: npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 brking@linux.vnet.ibm.com, gbatra@linux.ibm.com, aneesh.kumar@kernel.org,
 christophe.leroy@csgroup.eu, nathanl@linux.ibm.com, bhelgaas@google.com,
 oohall@gmail.com, tpearson@raptorengineering.com,
 mahesh.salgaonkar@in.ibm.com
Subject: Re: [PATCH v3 1/2] pci/hotplug/pnv_php: Fix hotplug driver crash on
 Powernv
In-Reply-To: <20240626152154.GA1467164@bhelgaas>
References: <20240626152154.GA1467164@bhelgaas>
Date: Fri, 28 Jun 2024 15:34:37 +1000
Message-ID: <87jzi9ljf6.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bjorn Helgaas <helgaas@kernel.org> writes:
> I expect this series would go through the powerpc tree since that's
> where most of the chance is.

Thanks, yeah I'll plan to merge v4 with your comments addressed.

cheers

> On Mon, Jun 24, 2024 at 05:39:27PM +0530, Krishna Kumar wrote:
>> Description of the problem: The hotplug driver for powerpc
>> (pci/hotplug/pnv_php.c) gives kernel crash when we try to
>> hot-unplug/disable the PCIe switch/bridge from the PHB.
>> 
>> Root Cause of Crash: The crash is due to the reason that, though the msi
>> data structure has been released during disable/hot-unplug path and it
>> has been assigned with NULL, still during unregistartion the code was
>> again trying to explicitly disable the msi which causes the Null pointer
>> dereference and kernel crash.
>
> s/unregistartion/unregistration/
> s/Null/NULL/ to match previous use
> s/msi/MSI/ to match spec usage
>
>> Proposed Fix : The fix is to correct the check during unregistration path
>> so that the code should not  try to invoke pci_disable_msi/msix() if its
>> data structure is already freed.
>
> s/Proposed Fix : The fix is to// ... Just say what the patch does.
>
> If/when the powerpc folks like this, add my:
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
>> Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Gaurav Batra <gbatra@linux.ibm.com>
>> Cc: Nathan Lynch <nathanl@linux.ibm.com>
>> Cc: Brian King <brking@linux.vnet.ibm.com>
>> 
>> Signed-off-by: Krishna Kumar <krishnak@linux.ibm.com>
>> ---
>>  drivers/pci/hotplug/pnv_php.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>> 
>> diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
>> index 694349be9d0a..573a41869c15 100644
>> --- a/drivers/pci/hotplug/pnv_php.c
>> +++ b/drivers/pci/hotplug/pnv_php.c
>> @@ -40,7 +40,6 @@ static void pnv_php_disable_irq(struct pnv_php_slot *php_slot,
>>  				bool disable_device)
>>  {
>>  	struct pci_dev *pdev = php_slot->pdev;
>> -	int irq = php_slot->irq;
>>  	u16 ctrl;
>>  
>>  	if (php_slot->irq > 0) {
>> @@ -59,7 +58,7 @@ static void pnv_php_disable_irq(struct pnv_php_slot *php_slot,
>>  		php_slot->wq = NULL;
>>  	}
>>  
>> -	if (disable_device || irq > 0) {
>> +	if (disable_device) {
>>  		if (pdev->msix_enabled)
>>  			pci_disable_msix(pdev);
>>  		else if (pdev->msi_enabled)
>> -- 
>> 2.45.0
>> 

