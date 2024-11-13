Return-Path: <linux-pci+bounces-16632-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ECE9C6C09
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 10:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8469EB28F5F
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 09:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D820D1F80CB;
	Wed, 13 Nov 2024 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N3OSex4u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PlRTtVCy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N3OSex4u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PlRTtVCy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BA818B460;
	Wed, 13 Nov 2024 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491477; cv=none; b=Q0j9BWzsqpPkef8gQVRMNk3f9iV5UYcAK2w+t9bRon9w1Prdg+4yvCfrlVyyslRqp0zQSFtQDuARZdYaCRgxKzMkDgV18RWGtOsoo4AyY1aneYmrTfu7dhsQS35QoyLn+fNGSKubDfn6+I4xPoL8//JlfEi2P5cSbReLZYCowOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491477; c=relaxed/simple;
	bh=P39PjyIiaovTps1vX5kTC2tJVvVHoSfk67Ehp2TsEWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p/FXrCZzCIYvWPFtcO2tDC8bGJyKIQwWF7LmAbDWwxrIWjt+8l3HG/e5rciAWnziAjrgXqn45MF9ilUTCh6SfGDFnrcchw4WAj7/I6yOr98ZndaVg3/Fo5cW6c6DBMvH+wb7gdfPGz3wblPEwDDa7Rh8KHhPWqyQZHchvXSdW0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N3OSex4u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PlRTtVCy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N3OSex4u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PlRTtVCy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 66B8D211D6;
	Wed, 13 Nov 2024 09:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731491474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ElIsBM/8y9WJvsjd8VnyWPvVkquaQSaEO0rKfXW157Y=;
	b=N3OSex4ukMwPySSMIaZpjAi4UXTEa1L6666sipx85E4IJvHBNfoFo1QYy3213BBz7tfUo4
	AW3LD8TOzt0Mpt+ujL8Nc0BEf8rW5iZVjN/pj+BgiKf14vxw5+T1AbnBYZso7CT1bcXCzV
	/hFZrF584Tabgv4RedrT7CKGnLSdB+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731491474;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ElIsBM/8y9WJvsjd8VnyWPvVkquaQSaEO0rKfXW157Y=;
	b=PlRTtVCyhXsKAEZdRDsZq3h8itQ1nkOZ9lTvhsrWLPUvNWd5dYKUAeqhfpU93SAKSYH2yQ
	QZjuZroTsaHD+WBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=N3OSex4u;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PlRTtVCy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731491474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ElIsBM/8y9WJvsjd8VnyWPvVkquaQSaEO0rKfXW157Y=;
	b=N3OSex4ukMwPySSMIaZpjAi4UXTEa1L6666sipx85E4IJvHBNfoFo1QYy3213BBz7tfUo4
	AW3LD8TOzt0Mpt+ujL8Nc0BEf8rW5iZVjN/pj+BgiKf14vxw5+T1AbnBYZso7CT1bcXCzV
	/hFZrF584Tabgv4RedrT7CKGnLSdB+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731491474;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ElIsBM/8y9WJvsjd8VnyWPvVkquaQSaEO0rKfXW157Y=;
	b=PlRTtVCyhXsKAEZdRDsZq3h8itQ1nkOZ9lTvhsrWLPUvNWd5dYKUAeqhfpU93SAKSYH2yQ
	QZjuZroTsaHD+WBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29DCE13A6E;
	Wed, 13 Nov 2024 09:51:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id If6bCZJ2NGcGFgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 13 Nov 2024 09:51:14 +0000
Message-ID: <0aab195d-e342-459c-89ad-3809f1c3891f@suse.de>
Date: Wed, 13 Nov 2024 10:51:13 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] virtio: blk/scsi: replace blk_mq_virtio_map_queues
 with blk_mq_hctx_map_queues
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
 <20241112-refactor-blk-affinity-helpers-v3-7-573bfca0cbd8@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241112-refactor-blk-affinity-helpers-v3-7-573bfca0cbd8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 66B8D211D6
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 11/12/24 14:26, Daniel Wagner wrote:
> Replace all users of blk_mq_virtio_map_queues with the more generic
> blk_mq_hctx_map_queues. This in preparation to retire
> blk_mq_virtio_map_queues.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/block/virtio_blk.c | 4 ++--
>   drivers/scsi/virtio_scsi.c | 3 +--
>   2 files changed, 3 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

