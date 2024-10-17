Return-Path: <linux-pci+bounces-14746-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6329A1C6E
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 10:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E1B528991B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 08:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BBB1D1F76;
	Thu, 17 Oct 2024 08:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qKZ+7nKW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nQ4t7L+A";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qKZ+7nKW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nQ4t7L+A"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712361D2200;
	Thu, 17 Oct 2024 08:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152172; cv=none; b=IeXEsl4Y6FwJ8EIOs9kj/6fzXtvJvJXlLVX7+EC/9ZmlPMRfDo0gVEg4lz7ZLijfS0k0CdDlQmWKBX72OCbMGgJ4iJBjJRpTdJ+ugDBJcgizj12MezjEcU7cFuOJVhm6ySyikynXnVQAbu4zO5/zTkrR8Cl7oTArfuJJZq/Rbj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152172; c=relaxed/simple;
	bh=V4BJk5KxBF4m37hxR/CxOWtyY33ThgFlaqbsXRJ6+Sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JuD6kJ2SabWFKgd58qjFQO0zkbrr8V/0O5P7QetQpe5xJKTLz/a/+TiGV3WmkwEbfAI5WpJ9Mz2Q6BhIrjkhns3rIGnP17l3QVFLWa90Dw81SlB5C4luD69onTGESpqY0KcMLzFNbGrRq07Uon7ce6IqKKEdORaZiK4L3Ojmw+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qKZ+7nKW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nQ4t7L+A; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qKZ+7nKW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nQ4t7L+A; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1DE6421C53;
	Thu, 17 Oct 2024 08:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729152163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lef/WUqsQk/+4fftS5U7JFsSwY0sjGlKvSnKtlvMSmE=;
	b=qKZ+7nKWYqY5XkDVYxLzj/ojWgM/RqddCk8hoew7r6cqPU+gtJX6Y86/yAKjvGqk/43sc3
	tZTBhl3dSC9S3kV7Deugq7VeEPM6QkvFq5Kpts8FEE+WI/f0IQMIl4ocPdMHT148q3Nc5V
	PTX4U4ArReUyN+v5Ri3zJ2qGrb38n10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729152163;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lef/WUqsQk/+4fftS5U7JFsSwY0sjGlKvSnKtlvMSmE=;
	b=nQ4t7L+AkFxPs24GgcuxYBF7kuD/jIUHbez6gLDbZL2vYy76BzorlSC0gB70yH4UuJlaVU
	pPZx+bhPXDxo9PDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729152163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lef/WUqsQk/+4fftS5U7JFsSwY0sjGlKvSnKtlvMSmE=;
	b=qKZ+7nKWYqY5XkDVYxLzj/ojWgM/RqddCk8hoew7r6cqPU+gtJX6Y86/yAKjvGqk/43sc3
	tZTBhl3dSC9S3kV7Deugq7VeEPM6QkvFq5Kpts8FEE+WI/f0IQMIl4ocPdMHT148q3Nc5V
	PTX4U4ArReUyN+v5Ri3zJ2qGrb38n10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729152163;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lef/WUqsQk/+4fftS5U7JFsSwY0sjGlKvSnKtlvMSmE=;
	b=nQ4t7L+AkFxPs24GgcuxYBF7kuD/jIUHbez6gLDbZL2vYy76BzorlSC0gB70yH4UuJlaVU
	pPZx+bhPXDxo9PDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 061F713A53;
	Thu, 17 Oct 2024 08:02:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XJ6SOqHEEGdGMAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Thu, 17 Oct 2024 08:02:41 +0000
Message-ID: <27c18374-8120-40bd-87d2-183c40945fbf@suse.de>
Date: Thu, 17 Oct 2024 11:02:33 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/11] PCI: brcmstb: Expand inbound size calculation
 helper
To: Bjorn Helgaas <helgaas@kernel.org>, Jim Quinlan <jim2101024@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner
 <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>
References: <20241016193802.GA645895@bhelgaas>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20241016193802.GA645895@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[22];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Score: -6.80
X-Spam-Flag: NO

Hi Bjorn,

On 10/16/24 22:38, Bjorn Helgaas wrote:
> On Wed, Oct 16, 2024 at 01:09:00PM -0400, Jim Quinlan wrote:
>> On Mon, Oct 14, 2024 at 1:25 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>> On Mon, Oct 14, 2024 at 10:10:11AM -0700, Florian Fainelli wrote:
>>>> On 10/14/24 09:57, Bjorn Helgaas wrote:
>>>>> On Mon, Oct 14, 2024 at 04:07:03PM +0300, Stanimir Varbanov wrote:
>>>>>> BCM2712 memory map can supports up to 64GB of system
>>>>>> memory, thus expand the inbound size calculation in
>>>>>> helper function up to 64GB.
>>>>>
>>>>> The fact that the calculation is done in a helper isn't important
>>>>> here.  Can you make the subject line say something about supporting
>>>>> DMA for up to 64GB of system memory?
>>>>>
>>>>> This is being done specifically for BCM2712, but I assume it's safe
>>>>> for *all* brcmstb devices, right?
>>>>
>>>> It is safe in the sense that all brcmstb devices with this PCIe
>>>> controller will adopt the same encoding of the size, all of the
>>>> currently supported brcmstb devices have a variety of
>>>> limitations when it comes to the amount of addressable DRAM
>>>> however. Typically we have a hard limit at 4GB of DRAM per
>>>> memory controller, some devices can do 2GB x3, 4GB x2, or 4GB
>>>> x1.
>>>>
>>>> Does that answer your question?
>>>
>>> I'd like something in the commit log to the effect that while
>>> we're doing this to support more system memory on BCM2712, this
>>> change is safe for other SoCs that don't support as much system
>>> memory.
>>
>> This setting configures the size of an RC's inbound window to system
>> memory.  Any inbound access outside of all of the inbound windows
>> will be discarded.
>>
>> Some existing SoCs cannot support the 64GB size.  Configuring such
>> an SoC to 64GB will effectively disable the entire window.
> 
> So I *think* you're saying that this patch will break existing SoCs
> that don't support the 64GB size, right?

Existing SoCs will not be impacted. It could be theoretically possible
to break inbound window translations only if you wrongly populate window
sizes in DT.

~Stan

