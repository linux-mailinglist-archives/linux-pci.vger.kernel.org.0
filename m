Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7188E2C4282
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 15:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgKYOyY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 09:54:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:44382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbgKYOyY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Nov 2020 09:54:24 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B2F6206B5;
        Wed, 25 Nov 2020 14:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606316063;
        bh=tHkXsp0lYry+LrxVumeVX78AT7FJzfcqs1X3jktXgN0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hwGOzEWeVZia6AU1cymJ7WZ6js+joX28GR1U4JTqy6BD2mMckiMcBOF+CYurZK7L6
         bDuWwL4nLFxty8Yusdfg28cQQnzAO94P28hR0leptdyJinLMFTS5DOpfa4YEdDhCmn
         wR5nipU8wsdwL033EwxZO7YN0B+/2gJtXHeI6BHQ=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1khwBZ-00DY7S-Fm; Wed, 25 Nov 2020 14:54:21 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 25 Nov 2020 14:54:21 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Laurent Vivier <lvivier@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Michael S . Tsirkin" <mst@redhat.com>, Greg Kurz <groug@kaod.org>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 1/2] genirq: add an irq_create_mapping_affinity()
 function
In-Reply-To: <e32641f7-0993-8923-7d74-5ac57a60f10d@redhat.com>
References: <20201125111657.1141295-1-lvivier@redhat.com>
 <20201125111657.1141295-2-lvivier@redhat.com>
 <87sg8xk1yi.fsf@nanos.tec.linutronix.de>
 <e32641f7-0993-8923-7d74-5ac57a60f10d@redhat.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <5100171ff6d4c3efffe008e1e0bf3707@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: lvivier@redhat.com, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, paulus@samba.org, linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, mst@redhat.com, groug@kaod.org, hch@lst.de, mpe@ellerman.id.au
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-11-25 14:09, Laurent Vivier wrote:
> On 25/11/2020 14:20, Thomas Gleixner wrote:
>> Laurent,
>> 
>> On Wed, Nov 25 2020 at 12:16, Laurent Vivier wrote:
>> 
>> The proper subsystem prefix is: 'genirq/irqdomain:' and the first 
>> letter
>> after the colon wants to be uppercase.
> 
> Ok.
> 
>>> This function adds an affinity parameter to irq_create_mapping().
>>> This parameter is needed to pass it to irq_domain_alloc_descs().
>> 
>> A changelog has to explain the WHY. 'The parameter is needed' is not
>> really useful information.
>> 
> 
> The reason of this change is explained in PATCH 2.
> 
> I have two patches, one to change the interface with no functional
> change (PATCH 1) and
> one to fix the problem (PATCH 2). Moreover they don't cover the same 
> subsystems.
> 
> I can either:
> - merge the two patches
> - or make a reference in the changelog of PATCH 1 to PATCH 2
>   (something like "(see folowing patch "powerpc/pseries: pass MSI 
> affinity to
>    irq_create_mapping()")")
> - or copy some information from PATCH 2
>   (something like "this parameter is needed by rtas_setup_msi_irqs()
> to pass the affinity
>    to irq_domain_alloc_descs() to fix multiqueue affinity")
> 
> What do you prefer?

How about something like this for the first patch:

"There is currently no way to convey the affinity of an interrupt
  via irq_create_mapping(), which creates issues for devices that
  expect that affinity to be managed by the kernel.

  In order to sort this out, rename irq_create_mapping() to
  irq_create_mapping_affinity() with an additional affinity parameter
  that can conveniently passed down to irq_domain_alloc_descs().

  irq_create_mapping() is then re-implemented as a wrapper around
  irq_create_mapping_affinity()."

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
