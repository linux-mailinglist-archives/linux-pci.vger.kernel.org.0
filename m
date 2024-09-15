Return-Path: <linux-pci+bounces-13224-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CB49798B5
	for <lists+linux-pci@lfdr.de>; Sun, 15 Sep 2024 22:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5E04281C6C
	for <lists+linux-pci@lfdr.de>; Sun, 15 Sep 2024 20:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECFB14286;
	Sun, 15 Sep 2024 20:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JC3UHWSB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B4C3EA83
	for <linux-pci@vger.kernel.org>; Sun, 15 Sep 2024 20:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726432356; cv=none; b=dpn4uPD6Lsr/3PM6/KvJbEZxC+j4FLSIxL62qm6Nn8eTqlefeY/FJybgfTthsqZw92dj/K7020+/NiGSgfUCk6RG22FnG/AKu8iP7Wl6umTTskwQ0g4zWN+VtXGeESFgIKoU89j7ZxILTCK+TirafvTt1rmbZ0rx51P2GlTMujY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726432356; c=relaxed/simple;
	bh=a8qUJ8Sm5t1yd934wra0SGfS/kNYzYpHbuN05xQcH9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p861IYvDpGGN/5AVm97vPpLGvtF/fmyRacjgMbTKqSv9yg6L1VIEeUasCB/24oRvGoEYP4GdTWTvuP8MVPHCuxx16GlXPFBGe9wBSaelGENUC6b/31BM5my3FxJOJlHAwNaM+79ApmBu519FqP3pxync8Bs4Y2lelXJlBRTj58U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JC3UHWSB; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-205722ba00cso31506425ad.0
        for <linux-pci@vger.kernel.org>; Sun, 15 Sep 2024 13:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726432354; x=1727037154; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8bFpdsxfx1Ace/q4aasi99xOr7vx0867TrczqjNMxQY=;
        b=JC3UHWSBQ++hPq725lNzqNvMf+3GTzsXYytZtAGBjAd+8ajPqEubBps98zQ4ZY0R1w
         NXaljXTq4pB6iUNRdqEBdbnvYv+ZCO2uGyAJkpoOoYUxLleS1y4Uz2VK/Bphg2mBv/9y
         BpAINSuXB5cPHTWUSTE+QU0+DCKgFxOmWt3sF9CPJ8M9YeSHoGDXFQdDjtfzGpOE8cOr
         If5uLxX2xt3eTJmVmEIdNkLzjQgs7IMviPzmVXhHcF18F/eUHfZXfpADi8ZrRDEHilZB
         V4bV/nhsdbJ5NX8I0a7dstSPD3wefxKGzAagrb1bCIluwJrIrSOK6CKVt33vV+FfR5/K
         iQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726432354; x=1727037154;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8bFpdsxfx1Ace/q4aasi99xOr7vx0867TrczqjNMxQY=;
        b=VtgCY+Wr+zdq7eOfpPWghs6eanPkz7wB6Is0PVbgsYP5bzvPn2Z4nHujUc7HPvxx7X
         itRm4v7P9toTXdTTjtWxDNyOQFVKL/hWh27NihTQJ16cFBR6OLV/Q+Eu13XN607YOBEG
         3BmPehdWgGAvDT3gouIGaeW1jFopxbpKIrs3ufonh3C//JNAJjNZYxFw+lf4E+TPrVwZ
         igJEwpVOmfwIJLDsZIoUZg8dZwpmEtwSlxYPUiP/rwu3YhVdpqXaQWT1ExC+ztsSh/i7
         kLlikf6HIE+tX/OGFw4Tvh1TlAWMC6u8F5e1ksqKAZNZRVC8T2YwUACS9uyijWyzhxSM
         02ow==
X-Forwarded-Encrypted: i=1; AJvYcCUwxNkq5mCckpUoHG1C9WvS4cYX42jInURhtVymwISgPdf9J/WguB5toegfShMgA9fuqlWH1wesx84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2MZaWe7VRfszniaoGcVlXcNHoRr03NC2BcRo8KgPQagGLWbM9
	qEjfmGSNX9G4rl23/odP1vXGsr56hCSpDZGQFAgDnEkiRZe0boB0v4l9wN83IXk=
X-Google-Smtp-Source: AGHT+IFqzpuwo8+eE5vUuJR+DujfLNGM59YFl+GDSbrA+peia+5jh6zgtexzrlgiRgj766UReKE8nQ==
X-Received: by 2002:a17:902:d2d2:b0:205:8a1a:53eb with SMTP id d9443c01a7336-2076e39c2e4mr194842025ad.18.1726432353601;
        Sun, 15 Sep 2024 13:32:33 -0700 (PDT)
Received: from [172.16.7.106] ([63.78.52.170])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9c3f57esm5730249a91.8.2024.09.15.13.32.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2024 13:32:32 -0700 (PDT)
Message-ID: <0bd0be63-5595-4aae-829f-6b278a5b5e60@kernel.dk>
Date: Sun, 15 Sep 2024 14:32:30 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] blk-mq: introduce blk_mq_hctx_map_queues
To: Bjorn Helgaas <helgaas@kernel.org>, Daniel Wagner <wagi@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
 megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
 MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com,
 linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>,
 20240912-do-not-overwrite-pci-mapping-v1-1-85724b6cec49@suse.de,
 Ming Lei <ming.lei@redhat.com>
References: <20240913162654.GA713813@bhelgaas>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240913162654.GA713813@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/13/24 10:26 AM, Bjorn Helgaas wrote:
> On Fri, Sep 13, 2024 at 09:41:59AM +0200, Daniel Wagner wrote:
>> From: Ming Lei <ming.lei@redhat.com>
>>
>> blk_mq_pci_map_queues and blk_mq_virtio_map_queues will create a CPU to
>> hardware queue mapping based on affinity information. These two
>> function share code which only differs on how the affinity information
>> is retrieved. Also there is the hisi_sas which open codes the same loop.
>>
>> Thus introduce a new helper function for creating these mappings which
>> takes an callback function for fetching the affinity mask. Also
>> introduce common helper function for PCI and virtio devices to retrieve
>> affinity masks.
> 
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index e3a49f66982d..84f9c16b813b 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -6370,6 +6370,26 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>>  	return 0;
>>  }
>>  
>> +#ifdef CONFIG_BLK_MQ_PCI
>> +/**
>> + * pci_get_blk_mq_affinity - get affinity mask queue mapping for PCI device
>> + * @dev_data:	Pointer to struct pci_dev.
>> + * @offset:	Offset to use for the pci irq vector
>> + * @queue:	Queue index
>> + *
>> + * This function returns for a queue the affinity mask for a PCI device.
>> + * It is usually used as callback for blk_mq_hctx_map_queues().
>> + */
>> +const struct cpumask *pci_get_blk_mq_affinity(void *dev_data, int offset,
>> +					      int queue)
>> +{
>> +	struct pci_dev *pdev = dev_data;
>> +
>> +	return pci_irq_get_affinity(pdev, offset + queue);
>> +}
>> +EXPORT_SYMBOL_GPL(pci_get_blk_mq_affinity);
>> +#endif
> 
> IMO this doesn't really fit well in drivers/pci since it doesn't add
> any PCI-specific knowledge or require any PCI core internals, and the
> parameters are blk-specific.  I don't object to the code, but it seems
> like it could go somewhere in block/?

Probably not a bad idea.

Unrelated to that topic, but Daniel, all your email gets marked as spam.
I didn't see your series before this reply. This has been common
recently for people that haven't kept up with kernel.org changes, please
check for smtp changes there.

-- 
Jens Axboe

