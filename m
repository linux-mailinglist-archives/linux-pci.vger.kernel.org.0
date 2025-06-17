Return-Path: <linux-pci+bounces-29939-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA10ADD211
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 17:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E08D017D2A9
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 15:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7282E88A5;
	Tue, 17 Jun 2025 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="cYHgfbwF"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7811A20F090
	for <linux-pci@vger.kernel.org>; Tue, 17 Jun 2025 15:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750174722; cv=none; b=UGDxLE7dXNtisW9ddOkrkhZIVdghSy+Iqa0l2Wpt59r17YhJlizIo7DyhJY7OUmawMizctnTvaUAs38gg+xr1AjK8i1PRsclTRvC1mMn4Sz8eyeKPQBTYn3y3CshUUCrnaKYTkFDPCnlLmQJAfEmJKCswt15jnums1RZPfYKeYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750174722; c=relaxed/simple;
	bh=oioVPuQ9yJByfvUXquPvsMT2TE/eKw6G9cVVI1FATYs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=eMBdNjNzM40Y3BwS58u3L63BQcCa6pWxFZuttHaLuwT3b3UESJxzEAJHhDpbjltVWxoP2f93M/00sUkaUU4PjXaMgRrtml4p//IAh+ufgQP6rm9YcW9G4qe49T8Szai7Rk92JKa2cncqVSpgsKxhGg4TiPP2qO7JXqcKqJnRiqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=cYHgfbwF; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 93FED8285885;
	Tue, 17 Jun 2025 10:38:39 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id cPZx6lvXjM2f; Tue, 17 Jun 2025 10:38:38 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id B9E3E8288AD8;
	Tue, 17 Jun 2025 10:38:38 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com B9E3E8288AD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1750174718; bh=bQe7uQ8M2AcEvzaufogbp/MAwuX8rYGTjtcF38ejnkw=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=cYHgfbwFRx7Zrgwe2zXKvVgBGj6L7wWIgKqkkljHE4OR4b6AzZXzssnnIiBDTHMDc
	 Az0zfXUDEBG+ue3IxxD45CodEIGSQyKStoF3L2ptTzoZGCM0288aGAjlJLfJxkxU4J
	 tptwNLbNH8acempI3XIN2Y/Lpw44EwUMLfUCEXbY=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sUP1wtcOu25R; Tue, 17 Jun 2025 10:38:38 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 868038285885;
	Tue, 17 Jun 2025 10:38:38 -0500 (CDT)
Date: Tue, 17 Jun 2025 10:38:35 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci <linux-pci@vger.kernel.org>, mahesh <mahesh@linux.ibm.com>, 
	Oliver <oohall@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, 
	Lukas Wunner <lukas@wunner.de>
Message-ID: <1148677100.1308178.1750174715908.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <2127487659.1308103.1750173325095.JavaMail.zimbra@raptorengineeringinc.com>
References: <20250617150301.GA1135647@bhelgaas> <2127487659.1308103.1750173325095.JavaMail.zimbra@raptorengineeringinc.com>
Subject: Re: [PATCH v7] PCI: Add pcie_link_is_active() to determine if the
 PCIe link
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC137 (Linux)/8.5.0_GA_3042)
Thread-Topic: Add pcie_link_is_active() to determine if the PCIe link
Thread-Index: mPjtM1CFB5FTX/3Lq8dnxkB0X3MnMOsJOzKd



----- Original Message -----
> From: "Timothy Pearson" <tpearson@raptorengineeringinc.com>
> To: "Bjorn Helgaas" <helgaas@kernel.org>
> Cc: "linux-pci" <linux-pci@vger.kernel.org>, "mahesh" <mahesh@linux.ibm.com>, "Oliver" <oohall@gmail.com>, "Madhavan
> Srinivasan" <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>, "Lukas Wunner" <lukas@wunner.de>
> Sent: Tuesday, June 17, 2025 10:15:25 AM
> Subject: Re: [PATCH v7] PCI: Add pcie_link_is_active() to determine if the PCIe link

> ----- Original Message -----
>> From: "Bjorn Helgaas" <helgaas@kernel.org>
>> To: "Timothy Pearson" <tpearson@raptorengineering.com>
>> Cc: "linux-pci" <linux-pci@vger.kernel.org>, "mahesh" <mahesh@linux.ibm.com>,
>> "Oliver" <oohall@gmail.com>, "Madhavan
>> Srinivasan" <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>,
>> "Lukas Wunner" <lukas@wunner.de>
>> Sent: Tuesday, June 17, 2025 10:03:01 AM
>> Subject: Re: [PATCH v7] PCI: Add pcie_link_is_active() to determine if the PCIe
>> link
> 
>> [+cc ppc folks, Lukas]
>> 
>> On Tue, Jun 17, 2025 at 09:25:24AM -0500, Timothy Pearson wrote:
> 
>>> +	return !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
>>> +}
>>> +EXPORT_SYMBOL(pcie_link_is_active);
>> 
>> Unless something outside drivers/pci/ actually needs this, it should
>> not be exported and it should be declared in drivers/pci/pci.h
>> instead.
> 
> Agreed.  Will fix in v8.

On further inspection, it looks like we need to export the symbol after all.  The problem is hotplug drivers (pnv-php in particular) a.) need this functionality and b.) may be built as a module.  I think we should still keep the definition in the PCI include directory, but the symbol itself needs to be exported.  I will make this change in the next patch series revision.

