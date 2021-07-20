Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8B93CF231
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jul 2021 04:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbhGTCH0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jul 2021 22:07:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42277 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344927AbhGTB5v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jul 2021 21:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626748709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G3SWoqsOcAK0oX6I/hgpTqrzjtvMRxHWPl/NBHoZkvM=;
        b=Wgr/TAYK91q27AD9JuZbgo8zXeuwkLXjHjblTy0d+6lQGIdJqUUIM0KKZkY6ljh/zdEeWr
        db8HNFKy/hDzXsPAI6yv09sfHzqsjTQkBkwnEHAbmpJJVj0aAYhiEw7mg3AuVQeEaT3faU
        wfR9F45XH/psNHtAZs0bjQvGVbjgIzM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-Ir__ZHnNMo2aKSHiw_R7PA-1; Mon, 19 Jul 2021 22:38:26 -0400
X-MC-Unique: Ir__ZHnNMo2aKSHiw_R7PA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6318F106B7DF;
        Tue, 20 Jul 2021 02:38:23 +0000 (UTC)
Received: from T590 (ovpn-12-229.pek2.redhat.com [10.72.12.229])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CFF919C79;
        Tue, 20 Jul 2021 02:38:13 +0000 (UTC)
Date:   Tue, 20 Jul 2021 10:38:08 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V4 1/3] driver core: mark device as irq affinity managed
 if any irq is managed
Message-ID: <YPY3EMngyf2JFZ3j@T590>
References: <20210715120844.636968-1-ming.lei@redhat.com>
 <20210715120844.636968-2-ming.lei@redhat.com>
 <5e534fdc-909e-39b2-521d-31f643a10558@huawei.com>
 <20210719094414.GC431@lst.de>
 <5153406c-e3ed-d466-5603-14fd919304f4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5153406c-e3ed-d466-5603-14fd919304f4@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 19, 2021 at 11:39:53AM +0100, John Garry wrote:
> On 19/07/2021 10:44, Christoph Hellwig wrote:
> > On Mon, Jul 19, 2021 at 08:51:22AM +0100, John Garry wrote:
> > > > Address this issue by adding one field of .irq_affinity_managed into
> > > > 'struct device'.
> > > > 
> > > > Suggested-by: Christoph Hellwig <hch@lst.de>
> > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > 
> > > Did you consider that for PCI device we effectively have this info already:
> > > 
> > > bool dev_has_managed_msi_irq(struct device *dev)
> > > {
> > > 	struct msi_desc *desc;
> > > 
> > > 	list_for_each_entry(desc, dev_to_msi_list(dev), list)
> 
> I just noticed for_each_msi_entry(), which is the same
> 
> 
> > > 		if (desc->affinity && desc->affinity->is_managed)
> > > 			return true;
> > > 	}
> > > 
> > > 	return false;
> > 
> > Just walking the list seems fine to me given that this is not a
> > performance criticial path.  But what are the locking implications?
> 
> Since it would be used for sequential setup code, I didn't think any locking
> was required. But would need to consider where that function lived and
> whether it's public.

Yeah, the allocated irq vectors should be live when running map queues.

> 
> > 
> > Also does the above imply this won't work for your platform MSI case?
> > .
> > 
> 
> Right. I think that it may be possible to reach into the platform msi
> descriptors to get this info, but I am not sure it's worth it. There is only
> 1x user there and there is no generic .map_queues function, so could set the
> flag directly:
> 
> int blk_mq_pci_map_queues(struct blk_mq_queue_map *qmap, struct pci_dev
> *pdev,
>  		for_each_cpu(cpu, mask)
>  			qmap->mq_map[cpu] = qmap->queue_offset + queue;
>  	}
> +	qmap->use_managed_irq = dev_has_managed_msi_irq(&pdev->dev);
> }
> 
> --- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> @@ -3563,6 +3563,8 @@ static int map_queues_v2_hw(struct Scsi_Host *shost)
>                        qmap->mq_map[cpu] = qmap->queue_offset + queue;
>        }
> 
> +       qmap->use_managed_irq = 1;
> +
>        return 0;

virtio can be populated via platform device too, but managed irq affinity
isn't used, so seems dev_has_managed_msi_irq() is fine.


Thanks,
Ming

