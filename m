Return-Path: <linux-pci+bounces-16629-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A98C9C6BE2
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 10:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C72EB2489D
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 09:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238A81F81B4;
	Wed, 13 Nov 2024 09:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pzjrA//g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NVPl8zER";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pzjrA//g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NVPl8zER"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827B01F80BA;
	Wed, 13 Nov 2024 09:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491308; cv=none; b=AUODv1ogG+z2ff8OV95GQmJIpkKrUUt2x9QRRxuqDs+iKNPreChtMmUyMaSIf5TkeUFyLwItgRce1GEklWK967RthmEiDJGE1hY0GTg+9Xt5wGTEGfRRA5lpLkwpvDfAM9sycQvrAaqRRlouprwUAmBV/cEoisM7PoIduF51ET8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491308; c=relaxed/simple;
	bh=dI2wtQ1ohi7xgBvgcEzNuF/EqiBUXtyzCJPc05Ff95o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E7DlORyAhXOUdvmDmPx3Mnaa/ibaTAJW7n4m35CW6vFdnFmMRI8AYEBOeFkXDcZXrQkKswV4gzl3U/CHiIkO25zWumewYjk/aiU4RYZEp73Sdu4pv1t1yDBGTA6a//ZG+jQyyH/8CI8ICZkZNXmx+hGKDodzBdoQUJBcg9QX0LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pzjrA//g; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NVPl8zER; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pzjrA//g; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NVPl8zER; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C4E9F211D4;
	Wed, 13 Nov 2024 09:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731491304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x03lHb2NlF8giJPDjnZ8KNjG5BnlxnM3noEvtBrKxp8=;
	b=pzjrA//g7r/d+yol1CiRRBBPM4kFT4sDFUYFyauckN3qRAYvop9/FBzBIkfFhCzLCN6eIL
	afKEF48KVqsKiW6UnT0BiLrVibgK82gkmuAbzlfZ5tIQ0gQZIc+Q2xiId0I+z6VwrE3E0l
	E67QWk74P9odF0CLdL5AoIRilHqN2jw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731491304;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x03lHb2NlF8giJPDjnZ8KNjG5BnlxnM3noEvtBrKxp8=;
	b=NVPl8zERbrVO6jmFvsbLxY0I89mb3aFlAoLun2DOjk0lFEapaB+OZ8gWGUxwtN2usqgj4c
	Yi/uEpt2BOVl1uBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731491304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x03lHb2NlF8giJPDjnZ8KNjG5BnlxnM3noEvtBrKxp8=;
	b=pzjrA//g7r/d+yol1CiRRBBPM4kFT4sDFUYFyauckN3qRAYvop9/FBzBIkfFhCzLCN6eIL
	afKEF48KVqsKiW6UnT0BiLrVibgK82gkmuAbzlfZ5tIQ0gQZIc+Q2xiId0I+z6VwrE3E0l
	E67QWk74P9odF0CLdL5AoIRilHqN2jw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731491304;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x03lHb2NlF8giJPDjnZ8KNjG5BnlxnM3noEvtBrKxp8=;
	b=NVPl8zERbrVO6jmFvsbLxY0I89mb3aFlAoLun2DOjk0lFEapaB+OZ8gWGUxwtN2usqgj4c
	Yi/uEpt2BOVl1uBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 911F713A6E;
	Wed, 13 Nov 2024 09:48:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JFL8Iuh1NGfHFAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 13 Nov 2024 09:48:24 +0000
Message-ID: <1c78d7ff-78d0-48e9-8da8-abd54018cbb4@suse.de>
Date: Wed, 13 Nov 2024 10:48:24 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] blk-mp: introduce blk_mq_hctx_map_queues
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
 <20241112-refactor-blk-affinity-helpers-v3-4-573bfca0cbd8@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241112-refactor-blk-affinity-helpers-v3-4-573bfca0cbd8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLst1wom1x1pd8ajtcs5pyzfej)];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On 11/12/24 14:26, Daniel Wagner wrote:
> blk_mq_pci_map_queues and blk_mq_virtio_map_queues will create a CPU to
> hardware queue mapping based on affinity information. These two function
> share common code and only differ on how the affinity information is
> retrieved. Also, those functions are located in the block subsystem
> where it doesn't really fit in. They are virtio and pci subsystem
> specific.
> 
> Thus introduce provide a generic mapping function which uses the
> irq_get_affinity callback from bus_type.
> 
> Originally idea from Ming Lei <ming.lei@redhat.com>
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   block/blk-mq-cpumap.c  | 37 +++++++++++++++++++++++++++++++++++++
>   include/linux/blk-mq.h |  2 ++
>   2 files changed, 39 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

