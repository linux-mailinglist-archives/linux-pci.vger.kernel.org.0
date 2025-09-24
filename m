Return-Path: <linux-pci+bounces-36827-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E098B98253
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 05:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A0947A3E93
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 03:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0875854774;
	Wed, 24 Sep 2025 03:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="QnfykSBW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600192F56;
	Wed, 24 Sep 2025 03:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758684904; cv=none; b=Wq4l+ZOMHaVuvjyKV3ofhss1j0qV7qOKUBeoj3f/QK9SoOYY2j30WurtOLW08k6dFk1rRfvGloyxwLMzI1v+8QiXBxX+tdjusui0IXckA64fNMU5MCIiUtCpM1JmlIhNXfuXBR8nEXDyP2l9U3i1huAevoWdk9HV2GqN4Q7CaHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758684904; c=relaxed/simple;
	bh=Nips8DxkxYzNKkIjzvQZvWfaU+UNMQN+KZVBo7xTLaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EdiyNRXBc194xrcpeySPe+YgiRd2LTBYhvR6eJBc29jF1Ky3AP6Dz4HgBksRpQmZqA1FecVceiwNBQb7png3Niv12iEcLmsAhtxFqfXooU7FN5fgChsQCUYCywXWE5jWk0zwbGQlOpv4zw9iXJt0ukmc+hiMZrN1AMnUc6zEwAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=QnfykSBW; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cWjCR53G9z9tGC;
	Wed, 24 Sep 2025 05:34:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758684899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iR1pTz/lDYQR3QLZ6+UFSS8mDYe4e/iOZKh/ftPVts8=;
	b=QnfykSBWD0y3oAzdH3uFes6d4RjleUcXcdXFd/X5aFp5RHza8VGwKEpntxsz8XINxEBIFJ
	yCxJmvNnsaH3f9daURGLVzinTSNe8IzH2D3lVjqGPOCSn45yEg1IKQy/028XK2+ZVBbfuH
	/qzH2DMCiHh1zf1R32QcsJ6Qi+stfw0xZE0IR5nQLmfoUaJT0uxjHthSucBWT8B2F2ZH2h
	z7Iu/wYWgJCk9UfReMMY2sPUW7ctJkGS1v37rJF+lDu6ZuhP8SCWNra5xwbSCKsJfgB6tC
	wy9EaBw/jdX3uoBSJVcp0Of4yc+E3Eb8h/YMx8NGDUJz15fKHa/T1O2pRDRV1Q==
Message-ID: <85a97019-2f80-4104-b27a-6578612af1e4@mailbox.org>
Date: Wed, 24 Sep 2025 05:34:55 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] PCI: rcar-host: Add static assertion to check
 !PCI_LOCKLESS_CONFIG
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Marek Vasut <marek.vasut+renesas@gmail.com>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20250923234644.82890-1-marek.vasut+renesas@mailbox.org>
 <ebcvi2mput6dyx5omlcvapjt6mwzrpq4h6c4o3kyfdxfrin35x@d75pxu652f6u>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <ebcvi2mput6dyx5omlcvapjt6mwzrpq4h6c4o3kyfdxfrin35x@d75pxu652f6u>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 866fko86334twjpey4wnyztfgdaeekff
X-MBO-RS-ID: e959066f4c6b06c85d3

Hello Manivannan,

On 9/24/25 5:25 AM, Manivannan Sadhasivam wrote:
> On Wed, Sep 24, 2025 at 01:46:18AM +0200, Marek Vasut wrote:
>> This driver can not function correctly without PCIe subsystem level
>> config space access serialization. In case PCI_LOCKLESS_CONFIG is
>> ever enabled on ARM, complain loudly so the driver can be updated
>> accordingly.
>>
> 
> This limitation applies to almost all host controller drivers except those used
> on Intel platforms like VMD and Hyper-V. So this would require adding the
> Kconfig dependency for all those, not just for RCAR.

Correct.

> We could also add the dependency to the arch Kconfig, but there is still a
> possibility that if the driver is used on a platform selecting
> PCI_LOCKLESS_CONFIG, it would be broken silently. So adding the dependency to
> the individual drivers that suffer from the limitation seems to be the right
> thing to do.

Would you like me to send a few more patches which add 
!PCI_LOCKLESS_CONFIG into per-driver Kconfig entries, at least for 
drivers where I am sure they suffer from this currently hypothetical 
issue ...

> Also, I'm not in favor of adding static_assert with Kconfig dependency in place.
... and drop the static assert ?

Then the drivers would at least be marked accordingly.

