Return-Path: <linux-pci+bounces-16159-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 871CE9BF456
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 18:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B27071C20911
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 17:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6DD206957;
	Wed,  6 Nov 2024 17:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T8Uyp6C4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eFBp7CVc"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E46F20514A;
	Wed,  6 Nov 2024 17:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730914357; cv=none; b=tdJWeJus567Qd8+4g/qgI4lHn7oAGD6rwe5IdeeshbLB6Dl4IJWqqsMtLaCvXZLuhaL7tA8TODAZHMCRdHuGCSpGD6sNXNWSC3AnSWgvmqumhRWGV2bhqyTFlHFIpC7p7m1fOUUgzm5IxZYuM4SpYGfXHk1RxLHIbM55p358WUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730914357; c=relaxed/simple;
	bh=xDZD3EROPfjZQNOBw9AkJKWkWGR9TfTMeO1dSl47/V8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qpaB5EBATia8weXUi8CySbVMfTrzydkOzDYYNDmCJiLx25ZgUBQlhqLiQ/tFNj6jXY/61T2wYfPZQbs+Bl/BDgxGTOothHJvcucyGXLRofLO59VwwlMoX+mMQf/DZlqT2fVo495tYy4+mgszXu+6Re8koGSksivVHU76Ejn7Ff4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T8Uyp6C4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eFBp7CVc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730914350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=enKlAVpEQ+kwM5vK2Sd+XWtklCNXXXGMYN0op4Beiow=;
	b=T8Uyp6C4ctAbWbTk5TzvbS7Z54be78i3lxDLpzwLC/L+YgmgDAmE5YPvye211wc+QPQrRa
	08MRJD9Jk4VApAjXueE9D6vDp1J1QuwXvrGtvJlF/EzYAIh4zVQlJdGMeuBirGTOPEQ57A
	UB/UX545jEe3cI21gdUIdK4UTJ0S+dPx3zrNgaEenWW7Z0ZN+vzs5GVzHOfsjscjfkLMwC
	6M2Nup8PhbPe+W5Sdnfuap8XarffE+QJoQbjSIrj8UvWk1yz3Ukm2VDgGZQjFXyngvX6BZ
	HPkeJaOFzf2vWhhU4sivfsH+UKbfKOtTX+MrEcHoqC1kXQGEa4UWJacNK6u+DQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730914350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=enKlAVpEQ+kwM5vK2Sd+XWtklCNXXXGMYN0op4Beiow=;
	b=eFBp7CVcGEzjt4ouE4j7hSpkMyrNQEZ/KY7B0pOp9SVNrk/5rDPbmYbJ/BNXrxWQvYZIO7
	SHFfnA9Bs/mleiCw==
To: Dullfire <dullfire@yahoo.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: davem@davemloft.net, sparclinux@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org
Subject: Re: Kernel panic with niu module
In-Reply-To: <973e2e20-51d9-4fe4-a361-0e07bcf95bab@yahoo.com>
References: <20241104234412.GA1446170@bhelgaas> <87fro4pe6i.ffs@tglx>
 <973e2e20-51d9-4fe4-a361-0e07bcf95bab@yahoo.com>
Date: Wed, 06 Nov 2024 18:32:01 +0100
Message-ID: <87cyj8p8tq.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 06 2024 at 10:04, dullfire@yahoo.com wrote:
>> 7d5ec3d36123 had the mask_all() invocation _before_ setting up the the
>> entries and reading back the descriptors. So that commit cannot break
>> the niu device when your problem analysis is correct.
>
> In 7d5ec3d36123 (and later) msix_mask_all() only writes to
> PCI_MSIX_ENTRY_VECTOR_CTRL. I have tried all the MSIX registers, and only 
> writes to PCI_MSIX_ENTRY_DATA were able to prevent a fatal trap on a read.
> However the only write to PCI_MSIX_ENTRY_DATA I see is in
> __pci_write_msi_msg() for 7d5ec3d36123, or pci_write_msg_msix(), in 6.11.5.

Yuck. They really went a great lenght to make this hard to handle.

Something like the obviously uncompiled below should work.

Thanks,

        tglx
---
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -611,6 +611,8 @@ void msix_prepare_msi_desc(struct pci_de
 	if (desc->pci.msi_attrib.can_mask) {
 		void __iomem *addr = pci_msix_desc_addr(desc);
 
+		if (dev->dev_flags & PCI_MSIX_TOUCH_ENTRY_DATA_FIRST)
+			writel(0x0, addr + PCI_MSIX_ENTRY_DATA);
 		desc->pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 	}
 }


