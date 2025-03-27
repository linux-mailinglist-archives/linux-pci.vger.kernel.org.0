Return-Path: <linux-pci+bounces-24890-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01918A7404B
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 22:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D15F73B835A
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 21:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A451DB365;
	Thu, 27 Mar 2025 21:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xSCNosCI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vEBDEnkD"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A821C6FF3;
	Thu, 27 Mar 2025 21:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743110949; cv=none; b=pfLcA2Hen3spR+Gcrv9X7pzE5LDW5cyRLZrax461m+mmNBUOcupx++Q1qQjK7AFxmSEZVlD7lSjsZ8Awrn8d+kI/kiEZPSo/Xp6rmqBk/SXtVs7q12YNbmOGhwfTsyNLOcGB17VLkYoyavP3XBTsb0QUSaD8jIMjzoLFHUBk5a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743110949; c=relaxed/simple;
	bh=/HkAZBRGYoIDI/o7tYKRcJaF4YnK76S5D8n7M3gbSpk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cg9aO3RDSCM8wbh4oOX+7p8dPJvtAt717NarZXSRDS8DhVP+cITj3ULcUqU166LZOP1Y1RoKewzpamyXj8o9dmkjXYAu6DQyFxVP6ikWLPBMnjIjTSQi/eEkfKTmjG0Ksc0/F3sHrjSLixg5sV6vuD+g/E3a+/ujgE+g0gW8zYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xSCNosCI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vEBDEnkD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743110946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tJcn+XXDh9OVxnhtVleZAHV4if9g76OMKEQ94nLRtKg=;
	b=xSCNosCIbv5YhR0yRjpgOb3w6iLs2BwJAPxxJpWzsZaYnzO+Wrwuku+runGROjNC9dT5u5
	7vzPW3Z/NfUJmTv/ONurIt8OniVq/YnPUaT0J5ydOw3kQe4OBrEE1wrL5Cmc0n/fHC7Lv2
	z8P7gg1H7wjGgYbZ2xbC2QsmJI9V+gZfeo34RsUW3WD+zLikLj8wI5c+NDicNpRCMzGeGD
	eUPO58+dQWA8DYNYObe4nSjlRfOCoZQA9Q/WsZwRbjLwpVnRfNz13TzJ+bX5TchwZzp4ug
	dqH8XeFBldAoYsB5Gwab004DzxtrcsgZvfoCic6BZEkVZ7xjPf6rvp6BAx17wQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743110946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tJcn+XXDh9OVxnhtVleZAHV4if9g76OMKEQ94nLRtKg=;
	b=vEBDEnkDvaceU0bYIfm2a+fSYhcrNVaJ1E6m4IOdF/dZIcg3+Qo6CcX41X3GQXxNqgezx2
	FyUJDiwtxWDpzDBw==
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ashish Kalra
 <Ashish.Kalra@amd.com>
Cc: bhelgaas@google.com, jgross@suse.com, roger.pau@citrix.com,
 pstanner@redhat.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
Subject: Re: [PATCH RESEND v2] PCI/MSI: Fix x86 VMs crash due to
 dereferencing NULL MSI domain
In-Reply-To: <Z-WPDm9PcPLt9Hu6@smile.fi.intel.com>
References: <20250327162946.11347-1-Ashish.Kalra@amd.com>
 <Z-WPDm9PcPLt9Hu6@smile.fi.intel.com>
Date: Thu, 27 Mar 2025 22:29:05 +0100
Message-ID: <875xjuxivy.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Mar 27 2025 at 19:46, Andy Shevchenko wrote:

> On Thu, Mar 27, 2025 at 04:29:46PM +0000, Ashish Kalra wrote:
>> From: Ashish Kalra <ashish.kalra@amd.com>
>> 
>> Moving pci_msi_ignore_mask to per MSI domain flag is causing a panic
>> with SEV-SNP VMs under KVM while booting and initializing virtio-scsi
>> driver as below :
>
> Isn't it already fixed (in current Linus' master branch?

Yes it is.

  3ece3e8e5976 ("PCI/MSI: Handle the NOMASK flag correctly for all PCI/MSI backends")

And it is fixed so that it takes _all_ potential PCI/MSI backends into
account and not only papers over the problem at hand as pointed out in
the thread leading up to the above commit.

Thanks,

        tglx

