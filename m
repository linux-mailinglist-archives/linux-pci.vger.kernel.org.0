Return-Path: <linux-pci+bounces-16633-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 561059C6C18
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 10:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47406B29B1C
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 09:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD301F9A99;
	Wed, 13 Nov 2024 09:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jwD8zBD+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sNoc5gOq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jwD8zBD+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sNoc5gOq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7528B1F9A88;
	Wed, 13 Nov 2024 09:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491524; cv=none; b=W2mZSH6krxezRb6AHWGXan5riK8sb7egG+N8H1ZUg4AVMxOJmAf8nUAmwxxYs1EkN+5yIQCEbEazhthV9h3ON+8U3MnrJdJwJjpYQifjS0rULeRV3N8sujQ6erKh1vPy/C6Qy9YrxQdr6d2Yb/c2XNfA83izSRqdhRsDM3QeKs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491524; c=relaxed/simple;
	bh=IFNIBl0VTxuzzi6XsWdk3q0iWZTGogl1p2ysg4YbHfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rrKBajErewJ0I1zrIUnyBVyUx3H3Vqf4/xRJ78t7D3fVupWHDasnVG0DKXcliZFsTZ2jFwqFG6Zb/DdjeiZcdJiMFoTr/1K2tJqOMK4Ny3uDRRF32rFeLeQAmOm/MGGC56pqLYp0DMDZ5gvvqjBvVbENmsLHghK4Dgmop2P5z+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jwD8zBD+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sNoc5gOq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jwD8zBD+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sNoc5gOq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9BDE61F44E;
	Wed, 13 Nov 2024 09:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731491520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9u+NB9BalEQqk52ZyuyFFi4Aabx8cwdfVcWV7jA/8ZU=;
	b=jwD8zBD+7TLVq0Jl3wxTBY3/X9q6doxXBUP1NqgMdTd9YfxKvWcl3eXaRQYqrzOc56vZQO
	/ZQMQMuE1A1BuRmPQb2j5EDoHpbpGy9/oPwhIHrIh8FRH5DrUhodkWi7bRlaBLeXXku/LR
	NK0jnCyZr78TnLQiCDcFOG+eV8jhKSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731491520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9u+NB9BalEQqk52ZyuyFFi4Aabx8cwdfVcWV7jA/8ZU=;
	b=sNoc5gOqveYMjQScvBQYt3veOBuH4Rj/SGILe63oII59XOt31Usp++u3gfFEG9VkAfeKra
	4ipvXI/OGkTeKEAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jwD8zBD+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sNoc5gOq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731491520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9u+NB9BalEQqk52ZyuyFFi4Aabx8cwdfVcWV7jA/8ZU=;
	b=jwD8zBD+7TLVq0Jl3wxTBY3/X9q6doxXBUP1NqgMdTd9YfxKvWcl3eXaRQYqrzOc56vZQO
	/ZQMQMuE1A1BuRmPQb2j5EDoHpbpGy9/oPwhIHrIh8FRH5DrUhodkWi7bRlaBLeXXku/LR
	NK0jnCyZr78TnLQiCDcFOG+eV8jhKSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731491520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9u+NB9BalEQqk52ZyuyFFi4Aabx8cwdfVcWV7jA/8ZU=;
	b=sNoc5gOqveYMjQScvBQYt3veOBuH4Rj/SGILe63oII59XOt31Usp++u3gfFEG9VkAfeKra
	4ipvXI/OGkTeKEAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6468A13A6E;
	Wed, 13 Nov 2024 09:52:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9LX2F8B2NGdhFgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 13 Nov 2024 09:52:00 +0000
Message-ID: <a04aec90-b526-4e0f-af3d-affefc4b6cf3@suse.de>
Date: Wed, 13 Nov 2024 10:52:00 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] blk-mq: remove unused queue mapping helpers
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
 <20241112-refactor-blk-affinity-helpers-v3-8-573bfca0cbd8@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241112-refactor-blk-affinity-helpers-v3-8-573bfca0cbd8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9BDE61F44E
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 11/12/24 14:26, Daniel Wagner wrote:
> There are no users left of the pci and virtio queue mapping helpers.
> Thus remove them.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   block/Makefile                |  2 --
>   block/blk-mq-pci.c            | 46 -------------------------------------------
>   block/blk-mq-virtio.c         | 46 -------------------------------------------
>   include/linux/blk-mq-pci.h    | 11 -----------
>   include/linux/blk-mq-virtio.h | 11 -----------
>   5 files changed, 116 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

