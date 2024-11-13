Return-Path: <linux-pci+bounces-16631-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9A59C6C03
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 10:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 221E51F22219
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 09:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199401F8901;
	Wed, 13 Nov 2024 09:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yE2noZQz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NAau4Ge+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yE2noZQz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NAau4Ge+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696991C8FBA;
	Wed, 13 Nov 2024 09:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491423; cv=none; b=OUTk48QZRCruc0kb8EbYPJTjwuJCu57pJrGg1Yf3csNBs93Cj1w/5t3RF2dWeM/2B5gOIh82kPl27pzFqNnAWo3G1Eb7noz6qz0Oo2D/AFz4HXw07eG3fh0XLANDiTqh74aS3JNLFYVLL7R95jSgq/O7FoDN1XEAozDaEuLqpyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491423; c=relaxed/simple;
	bh=tzhjbj+jnvJ0zjeO8y6l3GclprOhGnYq1VboJVHAULM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WoY9Ox8M5CzeXHkAB1rni3SAkl9DOr3q1b2Fd+L+0CWHIHx1GPLxAB7xyHK1rvOveWZ8iT+cSRE36oiK344IgtGfy4z06RdG3kZaai7+JFVsoilarZd7y/s25n3tMc9pni/k15ngB48m9QYyTe03AfpvaVrsAUpj6QfvK3HThxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yE2noZQz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NAau4Ge+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yE2noZQz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NAau4Ge+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AE1EA1F44E;
	Wed, 13 Nov 2024 09:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731491419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dvPYHyt6fuFyMxt0h6FUL1ixgfbjotxHl8UFKAJ5rjk=;
	b=yE2noZQzNMlCLgIL1fetrYHvxWtW/q8Mev2BYkSrO4+jN5lb2It2KfyVngmVNknq8zBe/8
	9buEDWKyCoUgVoMT4aOgA3kM4Mb/AThgDNcvhxwsAMEks3huoB/ZLuJCm2f4JPi2Ezkjrl
	WXzWM61stkcCANE8r2dNXjb11R+lJbE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731491419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dvPYHyt6fuFyMxt0h6FUL1ixgfbjotxHl8UFKAJ5rjk=;
	b=NAau4Ge+J7WDKXttFqhc7RMPJ6iwhfOa6jeQSFvQeSv96F43TApMaq4lfBnrHL/rEK61D5
	rmOxs08Au4jqJtDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731491419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dvPYHyt6fuFyMxt0h6FUL1ixgfbjotxHl8UFKAJ5rjk=;
	b=yE2noZQzNMlCLgIL1fetrYHvxWtW/q8Mev2BYkSrO4+jN5lb2It2KfyVngmVNknq8zBe/8
	9buEDWKyCoUgVoMT4aOgA3kM4Mb/AThgDNcvhxwsAMEks3huoB/ZLuJCm2f4JPi2Ezkjrl
	WXzWM61stkcCANE8r2dNXjb11R+lJbE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731491419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dvPYHyt6fuFyMxt0h6FUL1ixgfbjotxHl8UFKAJ5rjk=;
	b=NAau4Ge+J7WDKXttFqhc7RMPJ6iwhfOa6jeQSFvQeSv96F43TApMaq4lfBnrHL/rEK61D5
	rmOxs08Au4jqJtDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7822213A6E;
	Wed, 13 Nov 2024 09:50:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hZftHFt2NGewFQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 13 Nov 2024 09:50:19 +0000
Message-ID: <cea04348-a73f-4ffb-9ed7-0b117d36c112@suse.de>
Date: Wed, 13 Nov 2024 10:50:19 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] nvme: replace blk_mq_pci_map_queues with
 blk_mq_hctx_map_queues
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
 <20241112-refactor-blk-affinity-helpers-v3-6-573bfca0cbd8@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241112-refactor-blk-affinity-helpers-v3-6-573bfca0cbd8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLst1wom1x1pd8ajtcs5pyzfej)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 11/12/24 14:26, Daniel Wagner wrote:
> Replace all users of blk_mq_pci_map_queues with the more generic
> blk_mq_hctx_map_queues. This in preparation to retire
> blk_mq_pci_map_queues.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/host/fc.c  | 1 -
>   drivers/nvme/host/pci.c | 3 +--
>   2 files changed, 1 insertion(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

