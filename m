Return-Path: <linux-pci+bounces-9805-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AD6927778
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 15:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 008651C20916
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 13:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A8A1822E2;
	Thu,  4 Jul 2024 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NT0OKGYd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HDcxLXl8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j4nmYLSB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nW03vohe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B248E1AC240;
	Thu,  4 Jul 2024 13:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720100973; cv=none; b=Cr3M17c+siSpqoaUNr1aA2B9NLTEXTGNNPBNCU88fZIguFHmmBOUdPOE7rkDRCNjJ5851KmMzUGIACSuU4atsQmSC8vEaRPvncuDgdRV1H6dNUVOpBFzSLhQ7tfmmVEYhjb9QDBzKa0nmwjs8l9uZ5+Yf0y53oKbZkg+gP6FGnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720100973; c=relaxed/simple;
	bh=UclCqMyyK92M+SYK5RXb8TofQsXeixsoZ3DIjUU+loY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ozXvjAEUub/1GJyc+dODKQmliMbsaNPMrW8XJL/cFMB8X1H5jM35u2KyHI4Ysc8pdQ1AoA+o0feILqGjt2seBagcjfQ0mtsMw3aMUlVyfVTPgpTFMiPv7qfyHFm3xIz7MHEfiCetInlcdPJ+SsgmWwoNzUmY1/33DhIzqnOrgoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NT0OKGYd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HDcxLXl8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=j4nmYLSB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nW03vohe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EA17C1F7C3;
	Thu,  4 Jul 2024 13:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720100970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7HgACWyqW1s9Cdt/7J82iakp96wmOT4+N0X8GXoXuoU=;
	b=NT0OKGYdY63VFrlmE4rezikZIizTyV0+3Qe7g0cDyJ5t6VMInE2ap0EoSlJRqFK1uq+QhP
	ED54moh/Dppun+88PFRg4bf980uwr34UTlVs7nXjJ4TmgUwv8mNCB7MzekWKDMe87G8MEM
	q7rKEAx/m3NaItWxXpKSR/wY6gtMa7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720100970;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7HgACWyqW1s9Cdt/7J82iakp96wmOT4+N0X8GXoXuoU=;
	b=HDcxLXl87l7qZ+t49LUaV5Si78OU4uEOyqzhn/bCTueq4GvXKCHjw05n+IsmEPwXnhsF/H
	dnY5+A/rVc4Ec2BQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=j4nmYLSB;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nW03vohe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720100968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7HgACWyqW1s9Cdt/7J82iakp96wmOT4+N0X8GXoXuoU=;
	b=j4nmYLSB6IrT5vGG2o/T05ChLnqbV+o11jFJQ7a9c5l84LNxVNzDyYC/EF/SnAKHdZ7BV8
	8LYeTxRzOaq9msa/MOMPcLtohCh11lEF/acU819YnOJ+kkMsJbzo7IC90oQpg3YUnUdIgS
	CiNk13kWBIKFRSXYezkgxlN99dfyrOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720100968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7HgACWyqW1s9Cdt/7J82iakp96wmOT4+N0X8GXoXuoU=;
	b=nW03voheJdCGkCthTbpAWsGALULYh8ceD6SxbjcasHw7vd7q8VORcEwNVRD9/v/iWCArRL
	9fu9cTfI6VEjgsCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F01D1369F;
	Thu,  4 Jul 2024 13:49:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Bt51CGiohmYGJgAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Thu, 04 Jul 2024 13:49:28 +0000
Message-ID: <b8705488-2af8-473a-bb2e-7c4c5d5bd736@suse.de>
Date: Thu, 4 Jul 2024 16:49:27 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/12] PCI: brcmstb: Check return value of all
 reset_control_xxx calls
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240703180300.42959-1-james.quinlan@broadcom.com>
 <20240703180300.42959-11-james.quinlan@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20240703180300.42959-11-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: EA17C1F7C3
X-Spam-Score: -5.50
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-5.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[broadcom.com,vger.kernel.org,kernel.org,google.com,arm.com,debian.org,suse.de,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Hi Jim,

On 7/3/24 21:02, Jim Quinlan wrote:
> In some cases the result of a reset_control_xxx() call have been ignored.
> Now we check all return values of such functions and at the least issue a
> dev_err(...) message if the return value is not zero.
> 

When I made the comment for the return value of reset_control_xxx API I
was thinking for propagating the error to upper PCI layer and not just
print it.

Printing the error is a step forward but I don't think it is enough.
Please drop the patch from the series, we can fix that problem in the
driver with follow up patches.

~Stan

> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 33 ++++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 8 deletions(-)
> 

