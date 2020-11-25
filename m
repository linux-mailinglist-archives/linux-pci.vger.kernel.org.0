Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72332C44F7
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 17:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbgKYQZG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 11:25:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38960 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730980AbgKYQZD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Nov 2020 11:25:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606321502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o/Y0frm+n6+KcF0/nn/2XkdcdJw5e1jlF8WzBJfpXEs=;
        b=A8n7liN1YPvOaYE5ZQMoTJJRmc5focnNKaKElcxA8bQKRPXXFPRMtL7TzmF/uY2izWN7Qu
        xmXKw8T+24q6TGKTZVZwtDQn7EnPkj5zcuinfOVZ30SAv3oOHV/ELjV2XmLmJ4zkwp2rZi
        XFMRGibEeHx7lBL4dUanxOG38mzxOj8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-JMyfGYw_NGS3vgQc4F4nCg-1; Wed, 25 Nov 2020 11:24:58 -0500
X-MC-Unique: JMyfGYw_NGS3vgQc4F4nCg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA308101AFA7;
        Wed, 25 Nov 2020 16:24:55 +0000 (UTC)
Received: from [10.36.113.83] (ovpn-113-83.ams2.redhat.com [10.36.113.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D09E10016F4;
        Wed, 25 Nov 2020 16:24:47 +0000 (UTC)
Subject: Re: [PATCH v3 2/2] powerpc/pseries: pass MSI affinity to
 irq_create_mapping()
To:     Denis Kirjanov <kda@linux-powerpc.org>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Paul Mackerras <paulus@samba.org>, Greg Kurz <groug@kaod.org>,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-block@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Marc Zyngier <maz@kernel.org>
References: <20201125150932.1150619-1-lvivier@redhat.com>
 <20201125150932.1150619-3-lvivier@redhat.com>
 <CAOJe8K1Q7sGf67bdj-2Mthkj4XNR4fOSskV1dyh62AdzefhpAQ@mail.gmail.com>
From:   Laurent Vivier <lvivier@redhat.com>
Message-ID: <7184880b-0351-ae18-d2e1-fab7b79fc864@redhat.com>
Date:   Wed, 25 Nov 2020 17:24:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAOJe8K1Q7sGf67bdj-2Mthkj4XNR4fOSskV1dyh62AdzefhpAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 25/11/2020 17:05, Denis Kirjanov wrote:
> On 11/25/20, Laurent Vivier <lvivier@redhat.com> wrote:
>> With virtio multiqueue, normally each queue IRQ is mapped to a CPU.
>>
>> But since commit 0d9f0a52c8b9f ("virtio_scsi: use virtio IRQ affinity")
>> this is broken on pseries.
> 
> Please add "Fixes" tag.

In fact, the code in commit 0d9f0a52c8b9f is correct.

The problem is with MSI/X irq affinity and pseries. So this patch fixes more than
virtio_scsi. I put this information because this commit allows to clearly show the
problem. Perhaps I should remove this line in fact?

Thanks,
Laurent

> 
> Thanks!
> 
>>
>> The affinity is correctly computed in msi_desc but this is not applied
>> to the system IRQs.
>>
>> It appears the affinity is correctly passed to rtas_setup_msi_irqs() but
>> lost at this point and never passed to irq_domain_alloc_descs()
>> (see commit 06ee6d571f0e ("genirq: Add affinity hint to irq allocation"))
>> because irq_create_mapping() doesn't take an affinity parameter.
>>
>> As the previous patch has added the affinity parameter to
>> irq_create_mapping() we can forward the affinity from rtas_setup_msi_irqs()
>> to irq_domain_alloc_descs().
>>
>> With this change, the virtqueues are correctly dispatched between the CPUs
>> on pseries.
>>
>> BugId: https://bugzilla.redhat.com/show_bug.cgi?id=1702939
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> Reviewed-by: Greg Kurz <groug@kaod.org>
>> ---
>>  arch/powerpc/platforms/pseries/msi.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/msi.c
>> b/arch/powerpc/platforms/pseries/msi.c
>> index 133f6adcb39c..b3ac2455faad 100644
>> --- a/arch/powerpc/platforms/pseries/msi.c
>> +++ b/arch/powerpc/platforms/pseries/msi.c
>> @@ -458,7 +458,8 @@ static int rtas_setup_msi_irqs(struct pci_dev *pdev, int
>> nvec_in, int type)
>>  			return hwirq;
>>  		}
>>
>> -		virq = irq_create_mapping(NULL, hwirq);
>> +		virq = irq_create_mapping_affinity(NULL, hwirq,
>> +						   entry->affinity);
>>
>>  		if (!virq) {
>>  			pr_debug("rtas_msi: Failed mapping hwirq %d\n", hwirq);
>> --
>> 2.28.0
>>
>>
> 

