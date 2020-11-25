Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C487B2C3A21
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 08:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgKYHaV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 02:30:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24530 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725308AbgKYHaV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Nov 2020 02:30:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606289420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D3DSrYj+gqE7fmTGGcLGiNd0q/oeDN1ODN+0Xluwkpc=;
        b=dsl+i09RZAdJ1lSShUGzc/UxlseV3QU7WIkHDBRIP0wK9BkkmrYpsgoEqc/RL5YWGYwAdM
        0NnM01Qk53ZU7gI4gJvvF+mgPPToSU4g0GH+I/LEwdVNqQUCPSkfDYmz0H9erALoryJR+0
        f2/9duKW/EdZ8O2LDeJG7+0wI9OCPUY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-HGAXgTQcP7C0r00a5_OLvQ-1; Wed, 25 Nov 2020 02:30:15 -0500
X-MC-Unique: HGAXgTQcP7C0r00a5_OLvQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 161A618C89E0;
        Wed, 25 Nov 2020 07:30:13 +0000 (UTC)
Received: from [10.36.113.83] (ovpn-113-83.ams2.redhat.com [10.36.113.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DDFAF10023B0;
        Wed, 25 Nov 2020 07:30:06 +0000 (UTC)
Subject: Re: [PATCH 1/2] genirq: add an affinity parameter to
 irq_create_mapping()
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-block@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Marc Zyngier <maz@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20201124200308.1110744-1-lvivier@redhat.com>
 <20201124200308.1110744-2-lvivier@redhat.com>
 <87h7pel7ng.fsf@nanos.tec.linutronix.de>
From:   Laurent Vivier <lvivier@redhat.com>
Message-ID: <8e9002d0-086f-1e7d-4b94-45b6d49f7917@redhat.com>
Date:   Wed, 25 Nov 2020 08:30:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <87h7pel7ng.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 24/11/2020 23:19, Thomas Gleixner wrote:
> On Tue, Nov 24 2020 at 21:03, Laurent Vivier wrote:
>> This parameter is needed to pass it to irq_domain_alloc_descs().
>>
>> This seems to have been missed by
>> o06ee6d571f0e ("genirq: Add affinity hint to irq allocation")
> 
> No, this has not been missed at all. There was and is no reason to do
> this.
> 
>> This is needed to implement proper support for multiqueue with
>> pseries.
> 
> And because pseries needs this _all_ callers need to be changed?
> 
>>  123 files changed, 171 insertions(+), 146 deletions(-)
> 
> Lots of churn for nothing. 99% of the callers will never need that.
> 
> What's wrong with simply adding an interface which takes that parameter,
> make the existing one an inline wrapper and and leave the rest alone?

Nothing. I'm going to do like that.

Thank you for your comment.

Laurent

