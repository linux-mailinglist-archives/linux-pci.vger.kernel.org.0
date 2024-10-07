Return-Path: <linux-pci+bounces-13948-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42055992932
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 12:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 402871C22E70
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 10:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE6A1BBBE6;
	Mon,  7 Oct 2024 10:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+KsTa4+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589631BB686
	for <linux-pci@vger.kernel.org>; Mon,  7 Oct 2024 10:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728296800; cv=none; b=pdQeNv+KE/QjPc4qJcBVkhz8zp+3VVWA3m0PRjPuAbGaGx3WjrrcBEaPra908Xu2Vkb96vZ5vhJaAlPtFZCuZ7zv1e/ktIwIl/Cj2Hjt9zcFaRRBaRxvVvdZ3Q0oMh/ojrt9eCZc9mc5rN+KAdcy9Ny61az1xhxaDBBgnaMexUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728296800; c=relaxed/simple;
	bh=xWZeCv2t+ngHlYtflR8W7eMTpOtQGRpThgYWysiR5Hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E7rZqTLymC+dHnuSkd83aMcum171VQD5rch/SoPteMz1XLGjDmC9CX++Q1hmJrf1H08tI5ujSz1WPZT7Uqe7M9yIwW4RKTDny9udFDGCNAUpXYhlTgF2PPerEnd2jK3x3woduP/4FcQQ0RLjniQZKbNVwUiwWrwtXP9Jb77HjMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+KsTa4+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E34C4CECD;
	Mon,  7 Oct 2024 10:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728296800;
	bh=xWZeCv2t+ngHlYtflR8W7eMTpOtQGRpThgYWysiR5Hc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h+KsTa4+UQ+Vo1rgTyXC+TNHLP4/dFB+3i4AFcn3FVgjcz4jDsxQsp9xxDoptKkNX
	 4L4ig9ybBwbyr1lWDIsoNuI6XYM3Ha/D0BZvmmSC0VrsAMyT/Lq/qDrT1og/lmJ2GD
	 5pNSsHHqseLFIogddZj3uiNkrVrPKe1bsvdKdi9OORxWpIeTWrlV8Q95xzfcArRLpP
	 fR0cICN3WlPw5su4IgGlQwne5qCXwRCEUX9UY3r4XLOt267w5ChltBxYoEGdQBjrT1
	 Hk/F/ZxrMHs1/G/ul/FZBF+Qxd2DMoAsHdVOWWjweKw7PtxADmfCjzGc43hfyN/CFY
	 s6Zd05kvGsefg==
Message-ID: <8b1c846d-6c86-43ea-bc73-aef619094267@kernel.org>
Date: Mon, 7 Oct 2024 19:26:37 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/5] PCI: endpoint: Add NVMe endpoint function driver
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pci@vger.kernel.org,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>
References: <20241007044351.157912-1-dlemoal@kernel.org>
 <20241007044351.157912-5-dlemoal@kernel.org> <ZwO0H0WCnORq9EzQ@ryzen>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <ZwO0H0WCnORq9EzQ@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/24 19:12, Niklas Cassel wrote:
> On Mon, Oct 07, 2024 at 01:43:50PM +0900, Damien Le Moal wrote:
>> From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> 
> (snip)
> 
>> Early versions of this driver code were based on an RFC submission by
>> Alan Mikhak <alan.mikhak@sifive.com> (https://lwn.net/Articles/804369/).
>> The code however has since been completely rewritten.
> 
> Here you state that the code has been completely rewritten...
> 
> 
>>
>> Co-developed-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
>> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> ---
>>  MAINTAINERS                                   |    7 +
>>  drivers/pci/endpoint/functions/Kconfig        |    9 +
>>  drivers/pci/endpoint/functions/Makefile       |    1 +
>>  drivers/pci/endpoint/functions/pci-epf-nvme.c | 2489 +++++++++++++++++
>>  4 files changed, 2506 insertions(+)
>>  create mode 100644 drivers/pci/endpoint/functions/pci-epf-nvme.c
> 
> (snip)
> 
>> --- /dev/null
>> +++ b/drivers/pci/endpoint/functions/pci-epf-nvme.c
>> @@ -0,0 +1,2489 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * NVMe function driver for PCI Endpoint Framework
>> + *
>> + * Copyright (C) 2019 SiFive
> 
> ...yet here you claim Copyright (C) SiFive.
> 
> *If* the code has been completely rewritten, then you probably should
> put yourself and/or your current employeer as the copyright holder.

Oops. One thing I forgot to rewrite :)
Will change the copyright in v2.

> 
> 
> Kind regards,
> Niklas


-- 
Damien Le Moal
Western Digital Research

