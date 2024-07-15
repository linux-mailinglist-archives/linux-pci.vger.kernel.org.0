Return-Path: <linux-pci+bounces-10250-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FF093125B
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 12:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E600FB21772
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 10:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6937186E43;
	Mon, 15 Jul 2024 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m5B/BlhD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wP8zXUOo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m5B/BlhD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wP8zXUOo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA51186E3C;
	Mon, 15 Jul 2024 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721039789; cv=none; b=OBBvNzIeGT62kJFEWr3RwdWn6kpXvFENGiQ0sAjYnAy3k4dGKn+JD3lN/ErcRMEkmbH+D+y+75kCRsojCcsw8fWX63qeflJi9UUYiiyBu+DMZ+P0wdt3rkQiRJkay+XSLlq4MuqPWLtihB4n/huyrm8F9Gk02nZ/AntV4CwlDE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721039789; c=relaxed/simple;
	bh=BwDkCKtXLJdt2v4l+zs23iivQWmBxUOlVqDfJcImsqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iSJpXiayLwterrSXE/ImorBkp1t96GEbs9HYVBeTmFuPYv/ea2nazfKg9VFizBAjHRUMsjpizWAiYq35B7uyAsqUWOTHKtIFevaAyetcQzJWZc7bewi/wGhjZTHSdN5RnWvxTjfHeJDomHcFyK+G231N4SDSXy6UviQXiwl5eqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m5B/BlhD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wP8zXUOo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m5B/BlhD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wP8zXUOo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 48D8A2123C;
	Mon, 15 Jul 2024 10:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721039786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XETBKh5Tf/saD68TCMoGImgWWSFg3tUvfsyoKMVxLD8=;
	b=m5B/BlhDMfSFp9Zm8saaNRlHxM/Il1VEje74gSAY4iqqPiuznTlV9nwzk+kc84dcHx1UKH
	O/KloFSKSnXe/Hr2zrsb9BphSxMcoeJr4kvJbEqP9WSOQmbNmSEArqsDj9gQy4cCsvuSPP
	JRwE9g+c5xeWCCw+B7g/mwS45Mm5lSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721039786;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XETBKh5Tf/saD68TCMoGImgWWSFg3tUvfsyoKMVxLD8=;
	b=wP8zXUOoMUPc0J0x/7j++co/7SuXShGzDdr+WgpHXU+G+DK4ed34ugfWOvPIRCqPaGNqZ2
	7+qKHTQMjX1Xb5CQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="m5B/BlhD";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wP8zXUOo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721039786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XETBKh5Tf/saD68TCMoGImgWWSFg3tUvfsyoKMVxLD8=;
	b=m5B/BlhDMfSFp9Zm8saaNRlHxM/Il1VEje74gSAY4iqqPiuznTlV9nwzk+kc84dcHx1UKH
	O/KloFSKSnXe/Hr2zrsb9BphSxMcoeJr4kvJbEqP9WSOQmbNmSEArqsDj9gQy4cCsvuSPP
	JRwE9g+c5xeWCCw+B7g/mwS45Mm5lSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721039786;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XETBKh5Tf/saD68TCMoGImgWWSFg3tUvfsyoKMVxLD8=;
	b=wP8zXUOoMUPc0J0x/7j++co/7SuXShGzDdr+WgpHXU+G+DK4ed34ugfWOvPIRCqPaGNqZ2
	7+qKHTQMjX1Xb5CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 77D2C137EB;
	Mon, 15 Jul 2024 10:36:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lEfSGqn7lGZCIwAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Mon, 15 Jul 2024 10:36:25 +0000
Message-ID: <6daeb8fc-1f83-487f-a7c7-8c6769c6fc69@suse.de>
Date: Mon, 15 Jul 2024 13:36:24 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] PCI: brcmstb: PCI: brcmstb: Make HARD_DEBUG,
 INTR2_CPU_BASE offsets SoC-specific
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240710221630.29561-1-james.quinlan@broadcom.com>
 <20240710221630.29561-7-james.quinlan@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20240710221630.29561-7-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 48D8A2123C
X-Spam-Flag: NO
X-Spam-Score: -0.50
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.50 / 50.00];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_TO(0.00)[broadcom.com,vger.kernel.org,kernel.org,google.com,arm.com,debian.org,suse.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Spamd-Bar: /



On 7/11/24 01:16, Jim Quinlan wrote:
> Our HW design has again changed a register offset which used to be standard
> for all Broadcom SOCs with PCIe cores.  This difference is now reconciled
> for the registers HARD_DEBUG and INTR2_CPU_BASE.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 39 ++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 15 deletions(-)
> 

Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>

~Stan

