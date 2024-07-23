Return-Path: <linux-pci+bounces-10673-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2370993A917
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 00:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73C132840FA
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 22:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053F0143879;
	Tue, 23 Jul 2024 22:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="k+E71AL7";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CA2T3w3/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7031E1DDD6;
	Tue, 23 Jul 2024 22:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721773062; cv=none; b=qLMozz/ANJRXODJfmTiG/00opaj7DL2lHVgiHeQ+D8SjARLNzPJO6a7P1teYy0D026fD2fP+BtbLZsjFu4sLMfWt4lsatHJSIBCjdFXYoTTvm/EOcEVYLQB0Csi9OBU6B93Y8e9IpQ98O02BuFQMCcQI5f6N4EhyCi1AzmiGMAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721773062; c=relaxed/simple;
	bh=Q6VrosfhVtus9b+YlKEoEQnACHYed/G03SlB4bJKYrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oGEm3ENNToIbn7Z/9TaKKI/YnT2gclVPDOd9196AG5t29NSsbpHoa6HoWrqYKYZJAZDkkosLIgqXw36NBETtXdyu/hNBjdnTKq11ot50VFEkse1NC0WwVlXGpuO9ZOWc4CKIS35JyDADQBgtbvTCIeKAL9NYmsNdSj4KQoj8nGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=k+E71AL7; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=CA2T3w3/; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WTBND1bPWz9sZq;
	Wed, 24 Jul 2024 00:17:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1721773052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BARvzmI5E5OWMhHv4N9kKE99NnRVRVNNEj9+C5tXmms=;
	b=k+E71AL7w462WuCvt67nBxg430t/K8FJ0dk1JPMzn9GGkO8bh1Ryft4rlsesQ8D20rlqA8
	bIvinglXQywkLUvuq0hltw0tHfqUcxvoOhPUzhjl8RgZkWJy2b6ufoDOtAl888q3j8XuVz
	uGikaOwD0kJk+SnMHPQqFfNRhwCvFIYeNTQprng/LG1N2p7mry5t5Xim+cgmMsI3FjQlyI
	h6+hbNXdIkkCBNSkhGNT3kt0SL0j1nuafIB7SKXW3NLF3P7t+qvn3JGqBITckFHZNhRQko
	tqaw/EolTHCRxm5EFv4yAsIX6XoMe6PuVuL5hYKeUB7pQX4GIebIpK9fOLFqzA==
Message-ID: <553ff386-a543-485a-ae23-aae7a2c51826@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1721773050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BARvzmI5E5OWMhHv4N9kKE99NnRVRVNNEj9+C5tXmms=;
	b=CA2T3w3/AJ5dBJsjy8ijB1FvFuoQiurJP9B4c3ayBIM/VsZ8Yaj8Wj98G7vps4jF5+ZwGZ
	vZcoEF//boLtnhrcZflwSpGWSSVSkt6eS2Ne4CGlxDIYW5bQbCyG3vHPhfZEBZ7l4JJ6/J
	4FXClwdoEykce8ybgWQGsHecRDWdfdp8r8lPel76jwKqEPFKa7osNHF4UX2tZAM3hEWTlG
	fzVOZBnI8eiAPr+WZwhvmWTotsElwpv5VBimZbgnaenThD8y5rE6WRq9LCoGhAE+CXBzU1
	xnw8ZVDQfchHkNGTz7yQFOxhEVLug3czuiNNpxCTzWkMbCGZYdbczrhIRlxWPA==
Date: Wed, 24 Jul 2024 00:17:25 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/3] PCI/rcar-host: Silence set affinity failed warning
To: Bjorn Helgaas <helgaas@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Anup Patel <apatel@ventanamicro.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
 Jon Hunter <jonathanh@nvidia.com>, Koichiro Den <den@valinux.co.jp>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Nipun Gupta <nipun.gupta@amd.com>, Rob Herring <robh@kernel.org>,
 Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>,
 Thierry Reding <thierry.reding@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20240722223814.GA740637@bhelgaas>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20240722223814.GA740637@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 7fa4a617b288eaad54e
X-MBO-RS-META: hthmqicr6tuaf6mscxozygowb9wg1mok

On 7/23/24 12:38 AM, Bjorn Helgaas wrote:
> In subject, to match history:
> 
> s|PCI/rcar-host|PCI: rcar-host|
> 
> On Mon, Jul 15, 2024 at 02:19:27PM +0200, Marek Vasut wrote:
>> Use newly introduced MSI_FLAG_NO_AFFINITY, which keeps .irq_set_affinity unset
>> and allows migrate_one_irq() code in cpuhotplug.c to exit right away, without
>> printing "IRQ...: set affinity failed(-22)" warning.
>>
>> Remove .irq_set_affinity implementation which only return -EINVAL from this
>> controller driver.
> 
> This would be a nice improvement; thanks for working on it.
> 
> As you allude to at [1], there are many more PCI controller drivers
> that could benefit from similar changes.  I'd like to do them all at
> once if possible.

Should be addressed in V4 .

