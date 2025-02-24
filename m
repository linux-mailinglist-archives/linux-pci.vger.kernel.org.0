Return-Path: <linux-pci+bounces-22266-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A93A42EDA
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 22:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA41A165329
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 21:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFA01DC997;
	Mon, 24 Feb 2025 21:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OA6vU+Dp"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891D31D7985
	for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 21:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740431943; cv=none; b=X8kXqpwCDkK3g2uHKtuDETBL2dT8TYLTivDiamybHNyba2bPk3ns2JQ7PH5fhMj1hyQbzWivxKbP0ly2aPR541Oh57L6vWB5IY2VnH5PWnljecqUKsK0o51K3cbmt2CD45wn0g+ymY/yfiLLf73LRfruaxbTcGKay3c6h/MS2mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740431943; c=relaxed/simple;
	bh=/PQO7ZUzimjU555KfQCQmRzVBItJMZqfMDY7mblzjks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVYqW5Xr8X4GVhY/GtTLNiblrReWzGsZrgw/vX0zsTHf4aT3611AlJb2zb6zlac10pHdTRAKa4auq9WUbCxbQPkgVdRZShIsNZJxl/1TsrwsLrozlQT0mSiPsbrheQeiCOQoLSYOLS0svwJswwlaNX/rYbsFl1rl2Abr11pucHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OA6vU+Dp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740431940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b4ChK7d4tTnyUI2qkV4nzn6rGiBQ0dJ69F8Ua/liB9M=;
	b=OA6vU+DpQ5QFlPkhsXvUdfCi/a5Izx8aOLUZMgeeW4QroIhmONsw/SktqPGNu+DYsJmvEH
	94LXojjmzsPJBvM6ejG78ck/68aJwS+ghkX3567LnfRTA4vCIDWWaS2wLdO/mwRXNYhxi1
	TydZBVURawAbTHqRIJXFwpxUqN/IW5w=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-9sSoROeGNY6s6xKhLGc7CQ-1; Mon, 24 Feb 2025 16:18:57 -0500
X-MC-Unique: 9sSoROeGNY6s6xKhLGc7CQ-1
X-Mimecast-MFC-AGG-ID: 9sSoROeGNY6s6xKhLGc7CQ_1740431937
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5e08b755856so4119340a12.1
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 13:18:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740431937; x=1741036737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4ChK7d4tTnyUI2qkV4nzn6rGiBQ0dJ69F8Ua/liB9M=;
        b=HkScjLeP91/uV83yBLL63N7WxU3wee4spGzkdYcVTFcu/pv/ocCxxzvHv31hN5vWCx
         NRFFhBNuMmAckJmwmPQvjP2hpoL55DrwKtNtU8T7E3ay0BcWiIix6/4l424SDONR2JB3
         4VTJwLXKLATNphibPLP1qtkvMtlByf7ttJlVI325YnoGFb20Ebkz4dxBrEKpn3Q7PqAd
         lvYcJiCnTN7mewdt7d2i6N/6NNhKn5Ch6eGdPWBoNV+ZTCCj4PGQp+7TA2DoiUhoa9/s
         dDJtRC3q5wMYoTsV9cqz71DPPmd9e4t6h5b1B7a6ZbJuocSB6ms7Hgrl9kXSSC4LcOjG
         FWZA==
X-Forwarded-Encrypted: i=1; AJvYcCXnWpNjdVllFXh4XtopGmQ3iW4yXNCAqKi1Q5bv8xWXaMl7nVbQEaAq6fnfEBhp5fidbT3NC7S3BRE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa1K9D4cYQHP3ZY9ieOYGHWnIgYntw5ndQSxx+SJjSLBPjJa+O
	0rZj4PjNhxZCi5RCp6Mbz/dR4Q/LupozytseVTa8+v2/ebyKUaV024hsKHI9/WYH6KUVBZBHbxE
	Y5UZvHE0zdYkeJsFspxpNjcSIIQA6M8onYhgBJZfOjzYyaTMyu1TYVUc3PA==
X-Gm-Gg: ASbGncuLHJllzYHu6C8abPvY65Z4aiRe4x57p47Dkx0wZXca2cYvVQQqo44sSs+Lf8Y
	RbYrh8hmX6I83L7XWM6ZeWwFfw1Nhs6vbABro8HVBu+N7W3I7mhbl5x6rQ246BtnstpUT6iaPR+
	T2Tg58IkLfnI0ELCnGF4t5yIhnvkWsAAx4IWndq/B17J5quLO/mKth2eYe7zESxlTkFOWJ5t/r7
	iV+XdQBHxW7f9kY2znUfK7zrZL1fCxGndZMEJ8O4zILJQpcXR62Q435pxOcHM78ScgOrmW4917i
	eWglXWEOhg==
X-Received: by 2002:a17:906:3151:b0:aba:5e50:6984 with SMTP id a640c23a62f3a-abc099ead3amr1385576966b.2.1740431936627;
        Mon, 24 Feb 2025 13:18:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYEBC44CLKnEsK0LbK9e6zpwdED/WRkdl8e2EWDOlyh5Ynisvb1G99K7KkazLO1N5pYn2zMA==
X-Received: by 2002:a17:906:3151:b0:aba:5e50:6984 with SMTP id a640c23a62f3a-abc099ead3amr1385570066b.2.1740431936166;
        Mon, 24 Feb 2025 13:18:56 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:441:1929:22c5:4595:d9bc:489e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed20134fdsm23497166b.94.2025.02.24.13.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 13:18:55 -0800 (PST)
Date: Mon, 24 Feb 2025 16:18:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-crypto@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Thomas Falcon <tlfalcon@linux.ibm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Matt Wu <wuqiang.matt@bytedance.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kurz <groug@kaod.org>, Peter Xu <peterx@redhat.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: Re: [PATCH v2 00/13] cpumask: cleanup cpumask_next_wrap()
 implementation and usage
Message-ID: <20250224161832-mutt-send-email-mst@kernel.org>
References: <20250128164646.4009-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128164646.4009-1-yury.norov@gmail.com>

On Tue, Jan 28, 2025 at 11:46:29AM -0500, Yury Norov wrote:
> cpumask_next_wrap() is overly complicated, comparing to it's generic
> version find_next_bit_wrap(), not mentioning it duplicates the above.
> It roots to the times when the function was used in the implementation
> of for_each_cpu_wrap() iterator. The function has 2 additional parameters
> that were used to catch loop termination condition for the iterator.
> (Although, only one is needed.)
> 
> Since 4fe49b3b97c262 ("lib/bitmap: introduce for_each_set_bit_wrap()
> macro"), for_each_cpu_wrap() is wired to corresponding generic
> wrapping bitmap iterator, and additional complexity of
> cpumask_next_wrap() is not needed anymore.
> 
> All existing users call cpumask_next_wrap() in a manner that makes
> it possible to turn it to a straight and simple alias to
> find_next_bit_wrap().
> 
> This series replaces historical 4-parameter cpumask_next_wrap() with a
> thin 2-parameter wrapper around find_next_bit_wrap().
> 
> Where it's possible to use for_each_cpu_wrap() iterator, the code is
> switched to use it because it's always preferable to use iterators over
> open loops.
> 
> This series touches various scattered subsystems and To-list for the
> whole series is quite a long. To minimize noise, I send cover-letter and
> key patches #5 and 6 to every person involved. All other patches are sent
> individually to those pointed by scripts/get_maintainers.pl.
> 
> I'd like to move the series with my bitmap-for-next branch as a whole.


virtio-net changes are straight-forward, so

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> v1: https://lore.kernel.org/netdev/20241228184949.31582-1-yury.norov@gmail.com/T/
> v2:
>  - rebase on top of today's origin/master;
>  - drop #v1-10: not needed since v6.14 @ Sagi Grinberg;
>  - #2, #3: fix picking next unused CPU @ Nick Child;
>  - fix typos, cleanup comments @ Bjorn Helgaas, Alexander Gordeev;
>  - CC Christoph Hellwig for the whole series.
> 
> Yury Norov (13):
>   objpool: rework objpool_pop()
>   virtio_net: simplify virtnet_set_affinity()
>   ibmvnic: simplify ibmvnic_set_queue_affinity()
>   powerpc/xmon: simplify xmon_batch_next_cpu()
>   cpumask: deprecate cpumask_next_wrap()
>   cpumask: re-introduce cpumask_next{,_and}_wrap()
>   cpumask: use cpumask_next_wrap() where appropriate
>   padata: switch padata_find_next() to using cpumask_next_wrap()
>   s390: switch stop_machine_yield() to using cpumask_next_wrap()
>   scsi: lpfc: switch lpfc_irq_rebalance() to using cpumask_next_wrap()
>   scsi: lpfc: rework lpfc_next_{online,present}_cpu()
>   PCI: hv: Switch hv_compose_multi_msi_req_get_cpu() to using
>     cpumask_next_wrap()
>   cpumask: drop cpumask_next_wrap_old()
> 
>  arch/powerpc/xmon/xmon.c            |  6 +--
>  arch/s390/kernel/processor.c        |  2 +-
>  drivers/net/ethernet/ibm/ibmvnic.c  | 18 +++++---
>  drivers/net/virtio_net.c            | 12 ++---
>  drivers/pci/controller/pci-hyperv.c |  3 +-
>  drivers/scsi/lpfc/lpfc.h            | 23 +++-------
>  drivers/scsi/lpfc/lpfc_init.c       |  2 +-
>  include/linux/cpumask.h             | 69 ++++++++++++++++++++---------
>  include/linux/objpool.h             |  7 ++-
>  kernel/padata.c                     |  2 +-
>  lib/cpumask.c                       | 37 +---------------
>  11 files changed, 81 insertions(+), 100 deletions(-)
> 
> -- 
> 2.43.0


