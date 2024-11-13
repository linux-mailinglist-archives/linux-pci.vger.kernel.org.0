Return-Path: <linux-pci+bounces-16628-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9879C6BDF
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 10:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6CF31F23B36
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 09:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8E91F80BD;
	Wed, 13 Nov 2024 09:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JPi7to5Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6HqRKeyq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JPi7to5Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6HqRKeyq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624751F80B6;
	Wed, 13 Nov 2024 09:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491279; cv=none; b=PEnwhwcaqathNX1jDLSOXuvVYkGHeIK/ighQdTvVsnuScJeEXqlQEayBBfO/ozgiNxvI7B8KVLymxZhArb7PTiftcruYJs5mEbneWSH2X6nOTX2IPh4zInBgAKG4qnhzogPIRZZvylDPE92vX5Gq2jWBPqh1mEF0vlq3D/uwrQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491279; c=relaxed/simple;
	bh=oC1fkYOJX6R3/oNdEPqloIze0tDGWiSOjuSe/+nR81E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kUYD94r7K/BBI53+2skrBKJ6KZKcT7BmwrILKZriRjbMa4K6nEEj5++LYnFsAscmyxzAGNFKi1vefF2CMwWBd0o4KrfQz3cjKluATE0juE1e2jwWsSYwUVaKgXUl5f61FhMAaGzMgbfyCv7olMcdQZdX3c0WoYULXKvUkLo1r2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JPi7to5Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6HqRKeyq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JPi7to5Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6HqRKeyq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AD05B211D4;
	Wed, 13 Nov 2024 09:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731491275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ux5hQQVi/kyvEIycZL/VXB8sz2oDX2jW2f1xgbFArs8=;
	b=JPi7to5QIdmVVrwoH8ReriShgkevjIQGgzWJ05ghlCrqH4tNnhE22APY5RVcnXkx45sz6X
	AJULj3iQlNXz04sYN9ZYSCmAaBSY/lRs28PhYeuW9b7YY67i6t+PebT+ct83uCM4+cMYw9
	xESsIR2FM0PWh3sZEIl1AAihYRfpQ0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731491275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ux5hQQVi/kyvEIycZL/VXB8sz2oDX2jW2f1xgbFArs8=;
	b=6HqRKeyqT6/O1TV13qpK/+8fKArzLparJjComRo6A5035YiSnIQ8ZfHhdkUorY0LV9FvGG
	bYXcrPiaSF6QoMDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731491275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ux5hQQVi/kyvEIycZL/VXB8sz2oDX2jW2f1xgbFArs8=;
	b=JPi7to5QIdmVVrwoH8ReriShgkevjIQGgzWJ05ghlCrqH4tNnhE22APY5RVcnXkx45sz6X
	AJULj3iQlNXz04sYN9ZYSCmAaBSY/lRs28PhYeuW9b7YY67i6t+PebT+ct83uCM4+cMYw9
	xESsIR2FM0PWh3sZEIl1AAihYRfpQ0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731491275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ux5hQQVi/kyvEIycZL/VXB8sz2oDX2jW2f1xgbFArs8=;
	b=6HqRKeyqT6/O1TV13qpK/+8fKArzLparJjComRo6A5035YiSnIQ8ZfHhdkUorY0LV9FvGG
	bYXcrPiaSF6QoMDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7774B13A6E;
	Wed, 13 Nov 2024 09:47:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Uhi7HMt1NGeLFAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 13 Nov 2024 09:47:55 +0000
Message-ID: <d39fe434-40af-4829-b964-bacebe082777@suse.de>
Date: Wed, 13 Nov 2024 10:47:55 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] virtio: hookup irq_get_affinity callback
To: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Bjorn Helgaas <bhelgaas@google.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, virtualization@lists.linux.dev,
 linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
 mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
 storagedev@microchip.com, linux-nvme@lists.infradead.org
References: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org>
 <20241112-refactor-blk-affinity-helpers-v3-3-573bfca0cbd8@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241112-refactor-blk-affinity-helpers-v3-3-573bfca0cbd8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 11/12/24 14:26, Daniel Wagner wrote:
> struct bus_type has a new callback for retrieving the IRQ affinity for a
> device. Hook this callback up for virtio based devices.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/virtio/virtio.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

