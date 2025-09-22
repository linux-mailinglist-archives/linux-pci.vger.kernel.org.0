Return-Path: <linux-pci+bounces-36646-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B01A9B903FF
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 12:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC63A163A8A
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 10:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4940F305E18;
	Mon, 22 Sep 2025 10:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qds18ubK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210392472B1;
	Mon, 22 Sep 2025 10:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758537861; cv=none; b=K93IYpwqJ9a7htBAhHgHsJ7LkJcLmXsTpGkjqTTXekR9rWkJYGFeuYtNva0W7v+Fo0WXMYFzijhNQZ6HZ8HedLOch/vDadWo7TiB/3ZgADRefwFkCC1pOpDmUXwtlyeiYEltOBZzR6/u22ICxJXTlT5bJKRbC6Guj1xZNujsoxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758537861; c=relaxed/simple;
	bh=QqlkC4VIw2NMFJJssYh1tePKUDlKegBAeXoYEOJzzxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RvcBF0ybnoaIEv8vEvQJEKqOAUdaXOfdRUWYZRFRQ3qa0+fKZjs/NYX9rPKr3sIyxiIitpL2gZ4XiUPAakZ3e6uvmUhikHefSoAn4vaeSOGbTK/QVqqbgKsuya2RdavtRv8DKqxYKDMDolIHnzmriDYQ0qCyXV9hR0f74P4J6kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=qds18ubK; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cVfqg3lPVz9tJ5;
	Mon, 22 Sep 2025 12:44:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758537855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ffQVE6RmN+mQv8c9pCzPipYza5TWS00xqFZeWOzO1Y=;
	b=qds18ubKQf+nvMIt0edDffiF7oM1ut4ST9MkdavIwC/TheBCY75jPk8cpu8RTXfMLQpZ88
	lT+mw6mu4Cs6xMPN4EvF1/2SzSNeu0ImlGThJ5REuq0pq3U5RFGDn/AcNXeL/iiQw5Jcqw
	98/ZVsBtumpQDe2ulDYEFcKqwWbpMhiXAaalf6q5J/gRMcXF6n/RLaj7PFwOXPS8RHwDDa
	+LFEqg3z9HF+EvNAt45OUlRLeCtvSl7Q2Dw6A/EyDFRc2K3J357JJU5FlqjD8Hivukvbgv
	WEs0GO+0iBp7LxF9/gLKsc6GUJqILMYt2Xw9spK1WbzuWsRZYlloiPJBG2q/IQ==
Message-ID: <575ae1bc-0478-4f69-9002-4a48742e04e8@mailbox.org>
Date: Mon, 22 Sep 2025 12:44:11 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] PCI: rcar-host: Drop PMSR spinlock
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-pci@vger.kernel.org, Duy Nguyen <duy.nguyen.rh@renesas.com>,
 Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>, stable@vger.kernel.org,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-renesas-soc@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <20250909162707.13927-1-marek.vasut+renesas@mailbox.org>
 <CAMuHMdXWWLGHJwxz6yYjhS2oQdmMO+Zfi4b3N3uTPN-NOeEpkA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAMuHMdXWWLGHJwxz6yYjhS2oQdmMO+Zfi4b3N3uTPN-NOeEpkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: opnzcha5bkc3u47g71beyfr4aecqasn7
X-MBO-RS-ID: 29c6735e9cbf14601cb

On 9/22/25 11:14 AM, Geert Uytterhoeven wrote:

Hello Geert,

> On Tue, 9 Sept 2025 at 18:27, Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
>> The pmsr_lock spinlock used to be necessary to synchronize access to the
>> PMSR register, because that access could have been triggered from either
>> config space access in rcar_pcie_config_access() or an exception handler
>> rcar_pcie_aarch32_abort_handler().
>>
>> The rcar_pcie_aarch32_abort_handler() case is no longer applicable since
>> commit 6e36203bc14c ("PCI: rcar: Use PCI_SET_ERROR_RESPONSE after read
>> which triggered an exception"), which performs more accurate, controlled
>> invocation of the exception, and a fixup.
>>
>> This leaves rcar_pcie_config_access() as the only call site from which
>> rcar_pcie_wakeup() is called. The rcar_pcie_config_access() can only be
>> called from the controller struct pci_ops .read and .write callbacks,
>> and those are serialized in drivers/pci/access.c using raw spinlock
>> 'pci_lock' . CONFIG_PCI_LOCKLESS_CONFIG is never set on this platform.
>>
>> Since the 'pci_lock' is a raw spinlock , and the 'pmsr_lock' is not a
>> raw spinlock, this constellation triggers 'BUG: Invalid wait context'
>> with CONFIG_PROVE_RAW_LOCK_NESTING=y .
>>
>> Remove the pmsr_lock to fix the locking.
>>
>> Fixes: a115b1bd3af0 ("PCI: rcar: Add L1 link state fix into data abort hook")
>> Reported-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
>> Reported-by: Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> Thanks for your patch!
> 
> Your reasoning above LGTM, so
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> My only worry is that PCI_LOCKLESS_CONFIG may be selected on non-x86
> one day, breaking your assumptions.  IMHO, the mechanism behind this
> config option, introduced in commit 714fe383d6c9bd95 ("PCI: Provide
> Kconfig option for lockless config space accessors") looks very fragile
> to me: it is intended to be selected by an architecture, if "all" low
> level PCI configuration space accessors use their own serialization or
> can operate completely lockless.  Usually we use the safer, inverted
> approach (PCI_NOLOCKLESS_CONFIG), to be selected by all drivers that
> do not adhere to the assumption.
> But perhaps I am missing something, and this does not depend on
> individual PCIe host drivers?
> 
> Regardless, improving that is clearly out-of-scope for this patch...
I could send a follow up patch which would add build-time assertion that 
PCI_LOCKLESS_CONFIG must not be selected for this driver to work. Would 
that be an option ?

