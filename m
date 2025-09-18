Return-Path: <linux-pci+bounces-36440-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57032B86EAF
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 22:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FC3A188E6A1
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 20:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C080C2D63FF;
	Thu, 18 Sep 2025 20:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qhK07UFg";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TDujv0H+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFD72EA759;
	Thu, 18 Sep 2025 20:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758227719; cv=none; b=CWS6UuIYH3Ri/QcILe/Eo9lCw1eGbXRVd2LMtxdc0nRN4mUO4ba+KvdygZXu5+1nYb+AX6fzNpZPZO9dW4DiNav2HuzOvED2X/Imlfz886GUi08mJ33NFFXHyDoTLkV3W9+xJds8rD15mXaTvWep4/5QSxOzxyBhi+WourByETw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758227719; c=relaxed/simple;
	bh=PAEgt7cN+HeiCBOmSgmaZh8pNusSQUqb5D3NIFDbJgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TjQ3+G8ATPq0P5H9GT79n+zQdi0oprW7sTo4SVBzOG799ZjP7cxs7OoCnAQuGqUG7UEBLw2yeq035Hv7eyGH4+qNeTJeADAY93sJvnttU3cZM6xljCtO/oU7jki6kYufYZsCXMPp9/POc3SzGl0XvXQS4vTcc8C1o49EvVuer6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=qhK07UFg; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=TDujv0H+; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cSS7P5sk6z9tgp;
	Thu, 18 Sep 2025 22:35:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758227713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FaS6u23HoBPHdlxc1ysX027h47f3tckPFZGiwmGm7lU=;
	b=qhK07UFg/M0qoIFN/PpcEPQtJOV/qwlbzLajE4yoQ+ptywegxiWzLuIdBW9h6P/yCyEIA1
	58zzDR8ehxC1pO3cpR0qui5q//6AakmrBIt/Ci+pdZ025t/BvA+Xh15USHNDYUzur1fjwt
	rz0PppxL3F+j2Qzp1DyikxyyPpMaBGAcb8mBg9gseRjohz5Wpp92Bihc029m/FxGDPNEQH
	YWsln6s1FY0v6BPJftVy/UYyU/1iVS+Fx4v4QQJf+KX66c2jP5+75UrV/2pW++OBdiOYCM
	hx3tvsKViusOM+ISx4WVWlWWEwchzOy9iEiIfkgJeuQO8oKizIizhfX4YWyJuA==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=TDujv0H+;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <b2a739ab-e59f-491b-bb94-b7554266712d@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758227711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FaS6u23HoBPHdlxc1ysX027h47f3tckPFZGiwmGm7lU=;
	b=TDujv0H+yHkYP2GmlQNMZ5Wax5NbmyJjMqbJ5hAfaxA5/dC8VDcDDxo1JTEQT/ooAht8bY
	7/5bGMypefNZCHAvTeWFooneuP3jDo18FwgAwurQdGX1d7Iv4sbLtD15lcevA5w98tf3Si
	q2P0jUfy167KtZr48ZWYOshXgrdQ2HCJeZnT9+k0sfp1XxYglspyVli5UHjvkJzjCp5/Gr
	HEUhJ+0poZRw6NOnhBPvrXHBtv3rNpLVrrwrsE50C91UUch+cJrMxtiDpYnfbNpELiek9G
	IRgXFTARPBxhNy/DzPBAEe9JgzNMDM9nmiD128Q1vuUFgGOistsK6QvfbI4NeQ==
Date: Thu, 18 Sep 2025 22:35:08 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: rcar-gen4: Add missing 1ms delay after PWR reset
 assertion
To: Bjorn Helgaas <helgaas@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-renesas-soc@vger.kernel.org
References: <20250918200447.GA1919114@bhelgaas>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250918200447.GA1919114@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 2c500edd652e6271079
X-MBO-RS-META: bgiu91ecq19g4byiahaq1yhett8iaoft
X-Rspamd-Queue-Id: 4cSS7P5sk6z9tgp

On 9/18/25 10:04 PM, Bjorn Helgaas wrote:
> On Thu, Sep 18, 2025 at 05:00:26AM +0200, Marek Vasut wrote:
>> R-Car V4H Reference Manual R19UH0186EJ0130 Rev.1.30 Apr. 21, 2025 page 585
>> Figure 9.3.2 Software Reset flow (B) indicates that for peripherals in HSC
>> domain, after reset has been asserted by writing a matching reset bit into
>> register SRCR, it is mandatory to wait 1ms.
> 
>> @@ -182,8 +182,10 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
>>   		return ret;
>>   	}
>>   
>> -	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc))
>> +	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc)) {
>>   		reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
>> +		usleep_range(1000, 2000);
> 
> What would you think of "fsleep(1000)"?
> 
> I know there's controvery about fsleep(), but while the 1000 usec
> lower bound is important, I think the selection of the 2000 usec upper
> bound is pretty arbitrary and doesn't really justify spelling it out.
The upper bound is arbitrary.

My reasoning for picking up usleep_range() is to give the kernel 
sufficient space to pick the best fitting delay in that 1..2 ms range, 
without constraining the timers too much. In other words, let the kernel 
pick the next easy to use timer tick which guarantees at least 1ms delay.

As far as I can tell, fsleep() in this case would add a bit of 
auto-detection overhead, and then select equivalent of 
usleep_range(1000, 1250) , wouldn't it ?

So I think using fsleep() here would add overhead, but not yield any 
actual benefit. Is my understanding and conclusions correct ?

