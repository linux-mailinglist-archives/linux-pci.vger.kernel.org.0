Return-Path: <linux-pci+bounces-16626-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5931B9C6BB6
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 10:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19B04285B1A
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 09:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28C31BDA8D;
	Wed, 13 Nov 2024 09:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="buhMb819";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yDbbnAly";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="buhMb819";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yDbbnAly"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1949D165EE3;
	Wed, 13 Nov 2024 09:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491221; cv=none; b=DO27v5vRBK4QHp9SBo1AkUPDSfGJDRYzAkr9jm0xCVSnUTkB392n2UezDitbDXdGZYrckoj8SY3vdUPjkSrIsAv0gpd+kGQpJ9WZ8WQwJ4AmonpSw3Tk4a0J1eYkNN66+BjhA0VYWdS7rMjHp31q9ZDuoOp9iejpWLgWQ80NBDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491221; c=relaxed/simple;
	bh=IGZBxUf6j8Fre9U4gMPDk+vI2SZImVE4LQ5NSf7swnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUTJhBs0zlK+Ac9zOAaxM8u6DTfUScpKJ65re6/lTfCkRbiOb4wMXy6gtPq+/8DG55BCRVarv+wy3S5SY14U6OhIHGZuXk1Z4zGxOPNzpJNzsFwKeITGscrK/Z7FBHoOuJ1FYhXfh9R/X9Hd3M9FU3NDcqUDYnOIRYMbtXdhh/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=buhMb819; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yDbbnAly; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=buhMb819; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yDbbnAly; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 40C641F37C;
	Wed, 13 Nov 2024 09:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731491217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eWkg1hOqi+ycsd64ANkNglK3giwDFCmogHKWtrMRowk=;
	b=buhMb819wZHU/8iqf/q4eAXXZ66+XnK0O9RtpFEbzsRnuZKFR/vQ9XNEHpi4PQ+SDjQYxh
	3omCBb0a5uhojNHRXGnAinSk560ZVg7A4pxDGXEPRUpkJxU3iirp+4ZByUaCA3ofpYFVNs
	+MFT4aXkNxijSPRa/QI2UwbMQBQAABk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731491217;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eWkg1hOqi+ycsd64ANkNglK3giwDFCmogHKWtrMRowk=;
	b=yDbbnAlyF2GKghvTsSyOgC73RfRuK0CmRznxsYAEyAh7MPWFuUpakA1CP7JMuTqVqtx8tI
	o3BlYDuKhMn48kDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731491217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eWkg1hOqi+ycsd64ANkNglK3giwDFCmogHKWtrMRowk=;
	b=buhMb819wZHU/8iqf/q4eAXXZ66+XnK0O9RtpFEbzsRnuZKFR/vQ9XNEHpi4PQ+SDjQYxh
	3omCBb0a5uhojNHRXGnAinSk560ZVg7A4pxDGXEPRUpkJxU3iirp+4ZByUaCA3ofpYFVNs
	+MFT4aXkNxijSPRa/QI2UwbMQBQAABk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731491217;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eWkg1hOqi+ycsd64ANkNglK3giwDFCmogHKWtrMRowk=;
	b=yDbbnAlyF2GKghvTsSyOgC73RfRuK0CmRznxsYAEyAh7MPWFuUpakA1CP7JMuTqVqtx8tI
	o3BlYDuKhMn48kDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0AE5C13A6E;
	Wed, 13 Nov 2024 09:46:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wZs+ApF1NGcpFAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 13 Nov 2024 09:46:57 +0000
Message-ID: <d73f8c20-27c1-4c13-9be3-7f127f9f093d@suse.de>
Date: Wed, 13 Nov 2024 10:46:56 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] driver core: bus: add irq_get_affinity callback to
 bus_type
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
 <20241112-refactor-blk-affinity-helpers-v3-1-573bfca0cbd8@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241112-refactor-blk-affinity-helpers-v3-1-573bfca0cbd8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 11/12/24 14:26, Daniel Wagner wrote:
> Introducing a callback in struct bus_type so that a subsystem
> can hook up the getters directly. This approach avoids exposing
> random getters in any subsystems APIs.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   include/linux/device/bus.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Han nes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

