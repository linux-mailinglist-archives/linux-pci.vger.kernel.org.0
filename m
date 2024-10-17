Return-Path: <linux-pci+bounces-14754-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFFB9A1CAB
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 10:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ECC81C26F82
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 08:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C581D2B0E;
	Thu, 17 Oct 2024 08:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="orrHegpP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2vLzZROT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="orrHegpP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2vLzZROT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FB61C32EB;
	Thu, 17 Oct 2024 08:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152585; cv=none; b=R1q5olSgSjEJlpuWfuFAhxWAp1WelJOHEHI0n82VwhDiRVYD6YB6HPSFjcrK2oJNmjY18XqEzwA3u2S2Pj5paz8cCWPYT8FHRY5D6Ifw7q1AMbpcjFnieruhah6J1PRzkhQx5v36w3dxP4nhqUZqbi1xEHFchmgdOdSkRtICv3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152585; c=relaxed/simple;
	bh=DtpwZxjV//lCWUdU2vg8tsbxZYoCFt6RqV0FtlC6Da0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nM+A6NxQ2UncXJxl4pHuE74kc2+54C+Dxa1y0quyIZc50wh84MX3V0a3HmbrRAL//hsldY2FNjAMM5rZ9zOqQ5Ih+v4pgnIIFYdJ0dx4585moDAQi1PhC7XLHJfTsOzGo8N3/JaRcJBgh7uWV1mZWCABesVWtIJ8KVE2ODovJSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=orrHegpP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2vLzZROT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=orrHegpP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2vLzZROT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9532C1F840;
	Thu, 17 Oct 2024 08:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729152581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aQVOzFVjekC7rKLqVW9fV3ddgCIKZnmqNeWupIsqSjM=;
	b=orrHegpPWzglYcytZ+0kPqrz8T0v19pwKcSRn9TdbULgQTsxdNv9lHjrySxdjr/0HdQviN
	hgkXibBZsyD0w6LHhx7h+dcxXTUpOUVJIHxPn1RDMTKrQSk3m2JEI9pYjpuxrmuNaFfSNm
	NmIz3Dgqy16lbO61Q30bJxYN27DqI/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729152581;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aQVOzFVjekC7rKLqVW9fV3ddgCIKZnmqNeWupIsqSjM=;
	b=2vLzZROT1fYNaOf5VKH80Ue/KpPiTgxPAIdFKGdf8HzlrOgwxjEklvBMr+fZADNfKtzm75
	glbn8fXkMA3x6/DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=orrHegpP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2vLzZROT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729152581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aQVOzFVjekC7rKLqVW9fV3ddgCIKZnmqNeWupIsqSjM=;
	b=orrHegpPWzglYcytZ+0kPqrz8T0v19pwKcSRn9TdbULgQTsxdNv9lHjrySxdjr/0HdQviN
	hgkXibBZsyD0w6LHhx7h+dcxXTUpOUVJIHxPn1RDMTKrQSk3m2JEI9pYjpuxrmuNaFfSNm
	NmIz3Dgqy16lbO61Q30bJxYN27DqI/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729152581;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aQVOzFVjekC7rKLqVW9fV3ddgCIKZnmqNeWupIsqSjM=;
	b=2vLzZROT1fYNaOf5VKH80Ue/KpPiTgxPAIdFKGdf8HzlrOgwxjEklvBMr+fZADNfKtzm75
	glbn8fXkMA3x6/DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C23213A53;
	Thu, 17 Oct 2024 08:09:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qmY0EETGEGeWMgAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Thu, 17 Oct 2024 08:09:40 +0000
Message-ID: <ac03c2ff-fedc-414b-a559-662e21b5e4a6@suse.de>
Date: Thu, 17 Oct 2024 11:09:39 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/11] PCI: brcmstb: Reuse config structure
To: Bjorn Helgaas <helgaas@kernel.org>, Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner
 <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>
References: <20241014170303.GA611791@bhelgaas>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20241014170303.GA611791@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9532C1F840
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[dt];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,broadcom.com,linutronix.de,kernel.org,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi Bjorn,

On 10/14/24 20:03, Bjorn Helgaas wrote:
> On Mon, Oct 14, 2024 at 04:07:07PM +0300, Stanimir Varbanov wrote:
>> Instead of copying fields from pcie_cfg_data structure to
>> brcm_pcie reference it directly.
> 
> This seems good.  I would consider moving it earlier in the series
> so you don't have to touch the CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN stuff
> twice.

Sure, will do it. Thank you for the review!

