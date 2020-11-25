Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3D22C41D8
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 15:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbgKYOJ7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 09:09:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57475 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729597AbgKYOJ6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Nov 2020 09:09:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606313397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L7x1+zQZq5AdNReGA03HZCNw2qvTVYRyYsN6XftQCxU=;
        b=h/OT5/8s0S+UEIuo/PCfje1kCO0N58LvGMdtv9P0bLP0T1P3VIbIBuHfNAta933NA453r2
        HC977uFrFpYN5VufEvuJCJ/lQ7u0LaknH2DImnIAgmc7Nzh694cOEojPIZKofeh7KUNasI
        h7SMVgBrrQ5x2buyNnksb4wTwEbx5qQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-oVkqOzzQNAWKywPe2GBTeA-1; Wed, 25 Nov 2020 09:09:52 -0500
X-MC-Unique: oVkqOzzQNAWKywPe2GBTeA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D261185E482;
        Wed, 25 Nov 2020 14:09:50 +0000 (UTC)
Received: from [10.36.113.83] (ovpn-113-83.ams2.redhat.com [10.36.113.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1CB195D9CA;
        Wed, 25 Nov 2020 14:09:42 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] genirq: add an irq_create_mapping_affinity()
 function
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        linux-pci@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Michael S . Tsirkin" <mst@redhat.com>, Greg Kurz <groug@kaod.org>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20201125111657.1141295-1-lvivier@redhat.com>
 <20201125111657.1141295-2-lvivier@redhat.com>
 <87sg8xk1yi.fsf@nanos.tec.linutronix.de>
From:   Laurent Vivier <lvivier@redhat.com>
Message-ID: <e32641f7-0993-8923-7d74-5ac57a60f10d@redhat.com>
Date:   Wed, 25 Nov 2020 15:09:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <87sg8xk1yi.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 25/11/2020 14:20, Thomas Gleixner wrote:
> Laurent,
> 
> On Wed, Nov 25 2020 at 12:16, Laurent Vivier wrote:
> 
> The proper subsystem prefix is: 'genirq/irqdomain:' and the first letter
> after the colon wants to be uppercase.

Ok.

>> This function adds an affinity parameter to irq_create_mapping().
>> This parameter is needed to pass it to irq_domain_alloc_descs().
> 
> A changelog has to explain the WHY. 'The parameter is needed' is not
> really useful information.
> 

The reason of this change is explained in PATCH 2.

I have two patches, one to change the interface with no functional change (PATCH 1) and
one to fix the problem (PATCH 2). Moreover they don't cover the same subsystems.

I can either:
- merge the two patches
- or make a reference in the changelog of PATCH 1 to PATCH 2
  (something like "(see folowing patch "powerpc/pseries: pass MSI affinity to
   irq_create_mapping()")")
- or copy some information from PATCH 2
  (something like "this parameter is needed by rtas_setup_msi_irqs() to pass the affinity
   to irq_domain_alloc_descs() to fix multiqueue affinity")

What do you prefer?

Thanks,
Laurent

