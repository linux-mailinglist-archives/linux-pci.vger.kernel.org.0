Return-Path: <linux-pci+bounces-13260-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E896097AEEF
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2024 12:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A9C1F217E5
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2024 10:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA588165F18;
	Tue, 17 Sep 2024 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="n2AGEgRj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0HyloQUg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="n2AGEgRj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0HyloQUg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD9B166F39;
	Tue, 17 Sep 2024 10:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726569389; cv=none; b=eKZgJtqgjF3VUSuaTRSP6Bq0c6hQPUoadg5X007axdE9wyYRfwtY74OTXF6JHZEMLgm3MLCLunOUeC6JFNceoaO7gOA5le0Cg1Z63UrVi+ZlfKdhCrFg2R+S0u2gOdJRXdO2eMGk5vLilcK4/9YooJyU7+GywF+F44QBbn847wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726569389; c=relaxed/simple;
	bh=EXjHP0ntIqBSDvqt/VUu+sQc/EeSv8evdSX1J2w9cxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CeCpOHrPoRzEZfrc+daVlKdHsgTTvVMI0YmVTq61sE4iMjZKRHogwbFfohmtw648k65FSh+u2fmqE8A/GsjFf1hpiXEwEIiyLv5QSl6kK5YLtE1PaN2QgbEnQHSBtTjFu0BstDa7zxFkd7opQ8cSX2GL1/QnjPMiWi91kKDCGT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=n2AGEgRj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0HyloQUg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=n2AGEgRj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0HyloQUg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 577DA2000D;
	Tue, 17 Sep 2024 10:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726569386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EMMN4yUf7Xe7564xvTCUNORqPqK8TC5Mw2dgzq+7TBY=;
	b=n2AGEgRjSSSpUeEhqEFKDbrsf+QBmNJmdgEU1IfCFPmp6F/o/VzePAillHSkv1rOxO+6Ye
	BNDQLj5Avg4yewxo0l85hT0o05aFaHeAH00YvOis0RZ5eHv2FDGC7A3Gj9D8SmQlfrpFOb
	pK/1bsVoWB1c4bHoI2m4apxMntgA5VQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726569386;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EMMN4yUf7Xe7564xvTCUNORqPqK8TC5Mw2dgzq+7TBY=;
	b=0HyloQUgExFcWuF0noc9p6gZUg878/BJS33bxdnG1Anul7mZEkjW1OZ39amj/o69rlnqKv
	ApKruc6EATX6ytCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=n2AGEgRj;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0HyloQUg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726569386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EMMN4yUf7Xe7564xvTCUNORqPqK8TC5Mw2dgzq+7TBY=;
	b=n2AGEgRjSSSpUeEhqEFKDbrsf+QBmNJmdgEU1IfCFPmp6F/o/VzePAillHSkv1rOxO+6Ye
	BNDQLj5Avg4yewxo0l85hT0o05aFaHeAH00YvOis0RZ5eHv2FDGC7A3Gj9D8SmQlfrpFOb
	pK/1bsVoWB1c4bHoI2m4apxMntgA5VQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726569386;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EMMN4yUf7Xe7564xvTCUNORqPqK8TC5Mw2dgzq+7TBY=;
	b=0HyloQUgExFcWuF0noc9p6gZUg878/BJS33bxdnG1Anul7mZEkjW1OZ39amj/o69rlnqKv
	ApKruc6EATX6ytCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A2A2139CE;
	Tue, 17 Sep 2024 10:36:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GBGKE6lb6WYzeQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Tue, 17 Sep 2024 10:36:25 +0000
Message-ID: <d9e4253f-c817-4197-9c77-40d2ac8dec65@suse.de>
Date: Tue, 17 Sep 2024 13:36:20 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next 03/11] irqchip: mip: Add Broadcom bcm2712 MSI-X
 interrupt controller
To: Thomas Gleixner <tglx@linutronix.de>,
 Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>
References: <20240910151845.17308-1-svarbanov@suse.de>
 <20240910151845.17308-4-svarbanov@suse.de> <87o74va4br.ffs@tglx>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <87o74va4br.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 577DA2000D
X-Spam-Level: 
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[21];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,broadcom.com,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -5.01
X-Spam-Flag: NO

Hi Thomas,

Thank you for the comments!

On 9/10/24 18:58, Thomas Gleixner wrote:
> On Tue, Sep 10 2024 at 18:18, Stanimir Varbanov wrote:
>> +
>> +struct mip_priv {
>> +	/* used to protect bitmap alloc/free */
>> +	spinlock_t lock;
>> +	void __iomem *base;
>> +	u64 msg_addr;
>> +	u32 msi_base;
>> +	u32 num_msis;
>> +	unsigned long *bitmap;
>> +	struct irq_domain *parent;
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#struct-declarations-and-initializers
> 
> And please read the rest of the document too.

Sure.

> 
>> +};
>> +
>> +static void mip_mask_msi_irq(struct irq_data *d)
>> +{
>> +	pci_msi_mask_irq(d);
>> +	irq_chip_mask_parent(d);
>> +}
>> +
>> +static void mip_unmask_msi_irq(struct irq_data *d)
>> +{
>> +	pci_msi_unmask_irq(d);
>> +	irq_chip_unmask_parent(d);
> 
> This is asymmetric vs. mask(), but that's just the usual copy & pasta
> problem.

Correct, but this will disappear when convert to MSI parent.

> 
>> +}
>> +static int mip_init_domains(struct mip_priv *priv, struct device_node *np)
>> +{
>> +	struct irq_domain *middle_domain, *msi_domain;
>> +
>> +	middle_domain = irq_domain_add_hierarchy(priv->parent, 0,
>> +						 priv->num_msis, np,
>> +						 &mip_middle_domain_ops,
>> +						 priv);
>> +	if (!middle_domain)
>> +		return -ENOMEM;
>> +
>> +	msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(np),
>> +					       &mip_msi_domain_info,
>> +					       middle_domain);
>> +	if (!msi_domain) {
>> +		irq_domain_remove(middle_domain);
>> +		return -ENOMEM;
>> +	}
> 
> This is not much different. Please convert this to a proper MSI parent
> domain and let the PCI/MSI core handle the PCI/MSI part.

I apologize, but I wasn't able to make it work on time. The good news is
that I made it now and will send it in next version of the series.

regards,
~Stan

