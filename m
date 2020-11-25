Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABA72C457D
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 17:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbgKYQmd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 11:42:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:55334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730269AbgKYQmd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Nov 2020 11:42:33 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67B0620857;
        Wed, 25 Nov 2020 16:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606322552;
        bh=RZad696Dkp864M+XIPKQBVBv1zbGfYkVuN9K54E5zF0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ShwHevqzdywqLdhmN37W0cpnFCJTuDfSWryyONq6Z6etTQwB+RGWNpDP0/cldlFE7
         Ig2Tp7Zfr7hKVEgeWj9H+HpEQjyQo5Anum7OMozxG+FD2jUkwwZPO41NOXxsBTiGAw
         wQkNRWhKuXrafZGHV1afMncS+XD0q0DwZcfQCFGE=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1khxsE-00DZgJ-9e; Wed, 25 Nov 2020 16:42:30 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 25 Nov 2020 16:42:30 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Laurent Vivier <lvivier@redhat.com>
Cc:     Denis Kirjanov <kda@linux-powerpc.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Paul Mackerras <paulus@samba.org>, Greg Kurz <groug@kaod.org>,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-block@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 2/2] powerpc/pseries: pass MSI affinity to
 irq_create_mapping()
In-Reply-To: <7184880b-0351-ae18-d2e1-fab7b79fc864@redhat.com>
References: <20201125150932.1150619-1-lvivier@redhat.com>
 <20201125150932.1150619-3-lvivier@redhat.com>
 <CAOJe8K1Q7sGf67bdj-2Mthkj4XNR4fOSskV1dyh62AdzefhpAQ@mail.gmail.com>
 <7184880b-0351-ae18-d2e1-fab7b79fc864@redhat.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <5419d1790c9ea0d9d7791ae887794285@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: lvivier@redhat.com, kda@linux-powerpc.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, hch@lst.de, paulus@samba.org, groug@kaod.org, linuxppc-dev@lists.ozlabs.org, tglx@linutronix.de, benh@kernel.crashing.org, mpe@ellerman.id.au, linux-block@vger.kernel.org, mst@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-11-25 16:24, Laurent Vivier wrote:
> On 25/11/2020 17:05, Denis Kirjanov wrote:
>> On 11/25/20, Laurent Vivier <lvivier@redhat.com> wrote:
>>> With virtio multiqueue, normally each queue IRQ is mapped to a CPU.
>>> 
>>> But since commit 0d9f0a52c8b9f ("virtio_scsi: use virtio IRQ 
>>> affinity")
>>> this is broken on pseries.
>> 
>> Please add "Fixes" tag.
> 
> In fact, the code in commit 0d9f0a52c8b9f is correct.
> 
> The problem is with MSI/X irq affinity and pseries. So this patch
> fixes more than virtio_scsi. I put this information because this
> commit allows to clearly show the problem. Perhaps I should remove
> this line in fact?

This patch does not fix virtio_scsi at all, which as you noticed, is
correct. It really fixes the PPC MSI setup, which is starting to show
its age. So getting rid of the reference seems like the right thing to 
do.

I'm also not keen on the BugId thing. It should really be a lore link.
I also cannot find any such tag in the kernel, nor is it a documented
practice. The last reference to a Bugzilla entry seems to have happened
with 786b5219081ff16 (five years ago).

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
