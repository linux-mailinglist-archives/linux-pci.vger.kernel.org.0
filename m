Return-Path: <linux-pci+bounces-33692-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEA5B1FED2
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 07:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A32643B62A2
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 05:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218B026B098;
	Mon, 11 Aug 2025 05:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b="RzUWA1kD"
X-Original-To: linux-pci@vger.kernel.org
Received: from server-vie001.gnuweeb.org (server-vie001.gnuweeb.org [89.58.62.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80024265CCB;
	Mon, 11 Aug 2025 05:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.62.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754891640; cv=none; b=a5KATDQvWZQeTxk+v/HHNnLICX4tYl2WUC+mYZ0sxPPvGfeWfteU8tIgnRvWm1mTQb6lZUyzMiOniO4b8ziiiPzzSlgBRyU7OhkM+/jmXWGEOWe+PRjsJx5XZmLLMywiwcjouwGmOrGm2Omq8P7zME616HRQRz2eHzfDUKsfBNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754891640; c=relaxed/simple;
	bh=LdTWUVYFawnNUScxZTcEwsS8O6bpuKjnWmrxbPu74LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUO7zcOPhghXoZJ71XycdjWz5KWo5ni7yNhYbCiQkNQS2JiEG2aKar48M5aHdJVZt5hl4TBupHSrYM0cX92111BzOvmD9ZPFMfgXrihnIhksTruQjI7n6IfRvBArGB90wWcwBFWbCq9QOK5aA4WoTRQ7Mdgo0+6X+1y/FA3KNa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org; spf=pass smtp.mailfrom=gnuweeb.org; dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b=RzUWA1kD; arc=none smtp.client-ip=89.58.62.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnuweeb.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
	s=new2025; t=1754891629;
	bh=LdTWUVYFawnNUScxZTcEwsS8O6bpuKjnWmrxbPu74LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Message-ID:Date:From:Reply-To:Subject:To:
	 Cc:In-Reply-To:References:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:User-Agent:Content-Type:Content-Transfer-Encoding;
	b=RzUWA1kDnsdsUM/b/Px4JpHpwdjIwtTmgsk46lDTVFUeQ3ZMiPiLtMbCxNZl/yJ9q
	 J2sfswk1EtSfp57BT26CJzH2g1xfkzXGkYu8OIWB67x1g4/Cy2A5aMRK4chgef2bqU
	 q5TnnZ4Gf65DClVKeHRp/lwUxJR3mxhG1Hlvv7LsKWWjeMeEJqLJtZ/Oft+SQZk48B
	 YR3xHfVkMtf81fEqy0yFpi+IKflJKAIMzzIldnS+kC5cMM2PASPj/UvH3f32ayk+/z
	 fcjdDaGv29/Lqrw4MUWpKpI/KKhM88rQvII6QwnvMwNpzvF1vmPkmwZ1JeKSH/bCU7
	 JBocM2V3PYlEg==
Received: from linux.gnuweeb.org (unknown [182.253.126.18])
	by server-vie001.gnuweeb.org (Postfix) with ESMTPSA id EBB933127E5B;
	Mon, 11 Aug 2025 05:53:46 +0000 (UTC)
X-Gw-Bpl: wU/cy49Bu1yAPm0bW2qiliFUIEVf+EkEatAboK6pk2H2LSy2bfWlPAiP3YIeQ5aElNkQEhTV9Q==
Date: Mon, 11 Aug 2025 12:53:43 +0700
From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Armando Budianto <sprite@gnuweeb.org>,
	Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Subject: Re: [PATCH] PCI: vmd: Remove MSI-X check on child devices
Message-ID: <20250811055343.GA1405254-ammarfaizi2@gnuweeb.org>
References: <20250811053935.4049211-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811053935.4049211-1-namcao@linutronix.de>
X-Gw-Outgoing-Server-Hash: 01afd303c8b96d0c1d5e80aa96a4ee40ec69888f786fa24107c0862c0644af79
X-Gw-Message-ID: f59be7574d497f477ca5ef988b115a76f94e479a024663befd1c34f672bc61f6
X-Gw-PM-Hash: 2e951b9a704e07782988b715bd31630e21b836e0015ddcfab9fd4aef34ab1156

On Mon, Aug 11, 2025 at 07:39:35AM +0200, Nam Cao wrote:
> Commit d7d8ab87e3e7 ("PCI: vmd: Switch to msi_create_parent_irq_domain()")
> added a WARN_ON sanity check that child devices support MSI-X, because VMD
> document says [1]:
> 
>     "Intel VMD only supports MSIx Interrupts from child devices and
>     therefore the BIOS must enable PCIe Hot Plug and MSIx interrups [sic]."
> 
> However, on Ammar's machine, a PCIe port below VMD does not support MSI-X,
> triggering this WARN_ON.
> 
> This inconsistency between the document and reality should be investigated
> further. For now, remove the MSI-X check.

Posting the processor model in question here for Intel VMD team. It may
help the investigation. The processor model I use is i7-1165G7.

Let me know if you guys need more information from me.

-- 
Ammar Faizi


