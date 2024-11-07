Return-Path: <linux-pci+bounces-16231-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2399C04E7
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 12:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B5A32820BB
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 11:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8B820F5D3;
	Thu,  7 Nov 2024 11:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WKtYcyJu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6y9VBDS0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WKtYcyJu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6y9VBDS0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A58620C31F;
	Thu,  7 Nov 2024 11:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730980303; cv=none; b=FNkMX1/brfXYASlJiLOtpsJehdC/JfARFNwMOkvFyZFfHkOK7mEIqqIZmnkTHCz/HKrv8T9fhkVA9zsmMaIBWJIziVKcbERQ4/hArTfz7pFHt/eejRkg26pTJ/Nr1O6+cq0EdpW4/GeW85rmieIeg7VK0FlVNLRE1dbiAgFVo4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730980303; c=relaxed/simple;
	bh=2EuzFuovwEC1kBPfLIPJmD2qUpzwJPFM0FDC9Dkau7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q4Qh44Orqph4JXWYsb/c9n0M5X+aGQQXKGU8fEW3gl9AWDOFrvu3Vw5wuLcGx3dhugwdgwO+TEl2l0KlFbl2CgZTpXMbub4QhTMrT8uY8ycbNUP4qjaFgy4UEfHzgEsu31ZebA/glQ7szDmfo/GU0Ua5PaXM3VsAqGI2w80VyTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WKtYcyJu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6y9VBDS0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WKtYcyJu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6y9VBDS0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 357D221E89;
	Thu,  7 Nov 2024 11:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730980300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TVxag8U9jM75UljVybG40T486hx4iXnhCGVMNG4jU7M=;
	b=WKtYcyJuRmqBS3wgJmdiVAEnAF9xdtDvh65mXQjicVeYTeafMBIe0Hx7hZgKjsTezRkblW
	Wk0Ja3RTnsFBvX4jq/ez4kVZdf0a71Cm0+xEdcB7oZ11DJutMxZQX+bmzulAUQPEdaXMNx
	vaBWhG7miv+uB9cO2d2kbBKW2pbgtFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730980300;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TVxag8U9jM75UljVybG40T486hx4iXnhCGVMNG4jU7M=;
	b=6y9VBDS0rtz+KzPrMSFQsof1tuHYCDd2aDlgjyBFIEcheGKdjWTJQlGjNIj0J3wqo2YB7B
	nuIuiUn2iT52tiDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WKtYcyJu;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6y9VBDS0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730980300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TVxag8U9jM75UljVybG40T486hx4iXnhCGVMNG4jU7M=;
	b=WKtYcyJuRmqBS3wgJmdiVAEnAF9xdtDvh65mXQjicVeYTeafMBIe0Hx7hZgKjsTezRkblW
	Wk0Ja3RTnsFBvX4jq/ez4kVZdf0a71Cm0+xEdcB7oZ11DJutMxZQX+bmzulAUQPEdaXMNx
	vaBWhG7miv+uB9cO2d2kbBKW2pbgtFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730980300;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TVxag8U9jM75UljVybG40T486hx4iXnhCGVMNG4jU7M=;
	b=6y9VBDS0rtz+KzPrMSFQsof1tuHYCDd2aDlgjyBFIEcheGKdjWTJQlGjNIj0J3wqo2YB7B
	nuIuiUn2iT52tiDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CAC3B139B3;
	Thu,  7 Nov 2024 11:51:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xRswL8qpLGeLJQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Thu, 07 Nov 2024 11:51:38 +0000
Message-ID: <49aeb2b6-3635-4094-97bd-cbff506f017c@suse.de>
Date: Thu, 7 Nov 2024 13:51:34 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/12] PCI: of_property: Assign PCI instead of CPU bus
 address to dynamic bridge nodes
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof Wilczynski <kw@linux.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Derek Kiernan <derek.kiernan@amd.com>,
 Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
 Masahiro Yamada <masahiroy@kernel.org>, Stefan Wahren <wahrenst@gmx.net>,
 Herve Codina <herve.codina@bootlin.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Andrew Lunn <andrew@lunn.ch>
References: <20241104150521.r4hbsurw4dbzlxpg@thinkpad>
 <20241104234937.GA1446920@bhelgaas>
 <20241106143511.2ao7nwjrxi3tiatt@thinkpad>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20241106143511.2ao7nwjrxi3tiatt@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 357D221E89
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmx.net];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,baylibre.com,kernel.org,broadcom.com,linux.com,google.com,linaro.org,arm.com,bgdev.pl,amd.com,arndb.de,linuxfoundation.org,vger.kernel.org,lists.infradead.org,gmx.net,bootlin.com,lunn.ch];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_RCPT(0.00)[dt];
	R_RATELIMIT(0.00)[to_ip_from(RLd4hfed5x1rwp7wawiizx89ec)];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Hi Mani,

On 11/6/24 16:35, Manivannan Sadhasivam wrote:
> On Mon, Nov 04, 2024 at 05:49:37PM -0600, Bjorn Helgaas wrote:
>> On Mon, Nov 04, 2024 at 08:35:21PM +0530, Manivannan Sadhasivam wrote:
>>> On Mon, Nov 04, 2024 at 09:54:57AM +0100, Andrea della Porta wrote:
>>>> On 22:39 Sat 02 Nov     , Manivannan Sadhasivam wrote:
>>>>> On Mon, Oct 28, 2024 at 03:07:22PM +0100, Andrea della Porta wrote:
>>>>>> When populating "ranges" property for a PCI bridge, of_pci_prop_ranges()
>>>>>> incorrectly use the CPU bus address of the resource. Since this is a PCI-PCI
>>>>>> bridge, the window should instead be in PCI address space. Call
>>>>>> pci_bus_address() on the resource in order to obtain the PCI bus
>>>>>> address.
>>>>>
>>>>> of_pci_prop_ranges() could be called for PCI devices also (not just PCI
>>>>> bridges), right?
>>>>
>>>> Correct. Please note however that while the PCI-PCI bridge has the parent
>>>> address in CPU space, an endpoint device has it in PCI space: here we're
>>>> focusing on the bridge part. It probably used to work before since in many
>>>> cases the CPU and PCI address are the same, but it breaks down when they
>>>> differ.
>>>
>>> When you say 'focusing', you are specifically referring to the
>>> bridge part of this API I believe. But I don't see a check for the
>>> bridge in your change, which is what concerning me. Am I missing
>>> something?
>>
>> I think we want this change for all devices in the PCI address
>> domain, including PCI-PCI bridges and endpoints, don't we?  All those
>> "ranges" addresses should be in the PCI domain.
>>
> 
> Yeah, right. I was slightly confused by the commit message. Maybe including a
> sentence about how the change will work fine for endpoint devices would help.
> Also, why it went unnoticed till now (ie., both CPU and PCI addresses are same
> in many SoCs).

Most probably it is unnoticed because until now nobody has enabled
/selected CONFIG_PCI_DYNAMIC_OF_NODES ?

~Stan

