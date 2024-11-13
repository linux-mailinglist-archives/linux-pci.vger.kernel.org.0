Return-Path: <linux-pci+bounces-16630-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 905DB9C6BF4
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 10:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDE72B221D7
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 09:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8108B1F81B2;
	Wed, 13 Nov 2024 09:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T1tNyApX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q4bCy2+z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T1tNyApX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q4bCy2+z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5AA1F81A5;
	Wed, 13 Nov 2024 09:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491384; cv=none; b=cBd8oCHQwV9e1h+a9KVXwTECdqiQV0r0frZF64i8aIUabmrGFUzzkP4FY04tP8HEvO3cBsvXtt8povqoypwlBmqNy2hURhrSfesB6JzJso2VHWvuQ6BTLntxeTrnBEvk0oqzcvc7SVIMm6FiDUBHwjfIEleg6bxd/2MlnE6aolw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491384; c=relaxed/simple;
	bh=9i3UsklB6+OV7m6CPmxDWtrSLPjZEsvdtffR0tvdrzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IaLAQfk9VArfNc/qSNLiDBZ5Mk1TQ8k99Q+qMDCl+fZXxobMsUwi82rM+hgOLFstJSGYCTKnxpc7BjZOhH2RNrM5KqGRNjXK820eEV3H1sGinasP5l5aSAVoHsSsh5uwHCYcJW6gXrmx/WOZU833G1W5KRB/zEn+JmeNtk8SkY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T1tNyApX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q4bCy2+z; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T1tNyApX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q4bCy2+z; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1AEA61F443;
	Wed, 13 Nov 2024 09:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731491381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zPXzZydT6qO4UokPRFwEZNudeu1M8HPAtnVVbwn0LLU=;
	b=T1tNyApXhsadqKPRBvkhvdE8do15PWzdoweDb8GvAFmf9B1uLU9OAv8vdap6A2hQ8ovFXu
	rSxhO8LwoGOMxCSxIf8lZF52Ib0q6s5lWkhnrNh/9MycebbAw5W/6JwprrdrVCJY0zVGKq
	05nqTU6gi+HiXoL1OwhujElZlAk5/qE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731491381;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zPXzZydT6qO4UokPRFwEZNudeu1M8HPAtnVVbwn0LLU=;
	b=q4bCy2+zJivHKa4X75WD4y0ZoZ8jKUIeO6gj7fHPeEkQePXM6bjVnGaph/rKq7Cdy2BMla
	g/rALeTsKGsHrpAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731491381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zPXzZydT6qO4UokPRFwEZNudeu1M8HPAtnVVbwn0LLU=;
	b=T1tNyApXhsadqKPRBvkhvdE8do15PWzdoweDb8GvAFmf9B1uLU9OAv8vdap6A2hQ8ovFXu
	rSxhO8LwoGOMxCSxIf8lZF52Ib0q6s5lWkhnrNh/9MycebbAw5W/6JwprrdrVCJY0zVGKq
	05nqTU6gi+HiXoL1OwhujElZlAk5/qE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731491381;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zPXzZydT6qO4UokPRFwEZNudeu1M8HPAtnVVbwn0LLU=;
	b=q4bCy2+zJivHKa4X75WD4y0ZoZ8jKUIeO6gj7fHPeEkQePXM6bjVnGaph/rKq7Cdy2BMla
	g/rALeTsKGsHrpAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D733D13A6E;
	Wed, 13 Nov 2024 09:49:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id W9MbNDR2NGd2FQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 13 Nov 2024 09:49:40 +0000
Message-ID: <4c4415c0-8ad9-4783-86d9-383676116e65@suse.de>
Date: Wed, 13 Nov 2024 10:49:40 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] scsi: replace blk_mq_pci_map_queues with
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
 <20241112-refactor-blk-affinity-helpers-v3-5-573bfca0cbd8@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241112-refactor-blk-affinity-helpers-v3-5-573bfca0cbd8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
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
>   drivers/scsi/fnic/fnic_main.c             | 3 +--
>   drivers/scsi/hisi_sas/hisi_sas.h          | 1 -
>   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c    | 4 ++--
>   drivers/scsi/megaraid/megaraid_sas_base.c | 3 +--
>   drivers/scsi/mpi3mr/mpi3mr.h              | 1 -
>   drivers/scsi/mpi3mr/mpi3mr_os.c           | 2 +-
>   drivers/scsi/mpt3sas/mpt3sas_scsih.c      | 3 +--
>   drivers/scsi/pm8001/pm8001_init.c         | 2 +-
>   drivers/scsi/pm8001/pm8001_sas.h          | 1 -
>   drivers/scsi/qla2xxx/qla_nvme.c           | 3 +--
>   drivers/scsi/qla2xxx/qla_os.c             | 4 ++--
>   drivers/scsi/smartpqi/smartpqi_init.c     | 7 +++----
>   12 files changed, 13 insertions(+), 21 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

