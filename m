Return-Path: <linux-pci+bounces-33571-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F3EB1DC93
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 19:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C19E18A785F
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 17:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CCC273816;
	Thu,  7 Aug 2025 17:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0rIbZlE3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FwpxbV5O"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BB5273806;
	Thu,  7 Aug 2025 17:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754588609; cv=none; b=mn2u3yFqC8FLeXHH9YhzxZ0+N1BNQrKxYGrRqawtHFQZtdoQx69AF6Mi+VROQCDhA9FInlNtQXJU1kbFrtBdTLBaqMcNM3SYGmSquhn3yxQ2Y/lwO6IWJlMy/yhc+uqBcaSG8wAN34AS2CbRbAdDOyjTDi09Jni6Kg/ggojdphk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754588609; c=relaxed/simple;
	bh=LpnjjKhJlpxUJLeVsNu0mrBkwKc8hdCdeJLFWq4wLnE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A/Mx+2WvLT9GBLlu0S/IdcoqgRfgZulvqr20/MVClwFW/0M1f6dzKVhLeo7JSSc61YSmGd5wK4wDUrxzMi4c+Fb6pkb8TvOwmKhGeGPVfK7ZRGhV+OP0et2WtzKoj7S6DsIUinhiimsWi6vcbTB6mSx86vMxZmJZqN7HIUeC9Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0rIbZlE3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FwpxbV5O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754588605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=os+EnVN5c+Emzsvy27+fTqdfegoTBRpfyxHQVxrjvUc=;
	b=0rIbZlE3qMmRmDssa7LxAaE16+6/MlQsAfzmszEgHMd/IO1mdVfrWYxDCO7GuJwaru0zly
	Psj61qyxCC13Ijhpvtlo3EACHDsvmYd9bWqnC4kNibp7RWoXCEesZoNlcXZi14+tQ+8z+M
	GleYEQZ4bVNwB6J9cQqBnzWrTs2IjVoJnTWGiVvgeGZJJILMotZTAGOQ0VF9nBMAJTcRAj
	Zm0JCkUzyeJr6Xpz18R5/u6TlkmjFHvk1QhQEr16NdB4BMLqO/R+1TborC0ql0dS6lL1l6
	b/QO2ekYdwev+M1wsrsMsITS7Rl5w09lMTLut0abhwGUnTumdKe+jaoPRdBhIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754588605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=os+EnVN5c+Emzsvy27+fTqdfegoTBRpfyxHQVxrjvUc=;
	b=FwpxbV5OKwWPgWQ4gVZQj14C9D154rs259oE2NDX7cWNm2I5hS60L/4Hs68Dp4aNcA510x
	EZPWyH4akyk9I3Aw==
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>, Jonathan Derrick
 <jonathan.derrick@linux.dev>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan
 Sadhasivam
 <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Kenneth Crudup
 <kenny@panix.com>, Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH v2] PCI: vmd: Fix wrong kfree() in vmd_msi_free()
In-Reply-To: <20250807163309.GA52078@bhelgaas>
References: <20250807163309.GA52078@bhelgaas>
Date: Thu, 07 Aug 2025 19:43:17 +0200
Message-ID: <87bjorxc22.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bjorn Helgaas <helgaas@kernel.org> writes:
> On Thu, Aug 07, 2025 at 10:10:51AM +0200, Nam Cao wrote:
>> vmd_msi_alloc() allocates struct vmd_irq and stashes it into
>> irq_data->chip_data associated with the VMD's interrupt domain.
>> vmd_msi_free() extracts the pointer by calling irq_get_chip_data() and
>> frees it.
>> 
>> irq_get_chip_data() returns the chip_data associated with the top interrupt
>> domain. This worked in the past, because VMD's interrupt domain was the top
>> domain.
>> 
>> But since commit d7d8ab87e3e7 ("PCI: vmd: Switch to
>> msi_create_parent_irq_domain()") changed the interrupt domain hierarchy,
>> VMD's interrupt domain is not the top domain anymore. irq_get_chip_data()
>> now returns the chip_data at the MSI devices' interrupt domains. It is
>> therefore broken for vmd_msi_free() to kfree() this chip_data.
>> 
>> Fix this issue, correctly extract the chip_data associated with the VMD's
>> interrupt domain.
...
>
> Applied to pci/for-linus for v6.17, thanks!
>
> I assume you checked the other msi_create_parent_irq_domain() changes
> for similar problems?

Not before you reminded me :(

But yes, none of the similar PCI patches has the same problem.

Nam

