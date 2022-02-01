Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0DB4A5D68
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 14:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238609AbiBAN0k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 08:26:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:49173 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238435AbiBAN0j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 08:26:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643721998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t4DZwBWjH4KMtaPN0r4y8wXSGSfdg/Ee8aiJ79lHN9s=;
        b=Tfcjj/pq57jwBJsDSqDR/Xrbps4R1VAg+EP58k2Dpd9760Lv0Ekj8MOULAt1Hw7MQZ1KSM
        GqWnngv6HZJDVn06N8PF7Z3h8BKqFUg2W96U3m7uz/Ioq5puzGnTNiu9SksQ80JhT8S/8D
        clpzWGfrcqXG/4uqGbi8wzJL0LYRSD8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-Ps4YUhxlNiGFYKnj5GBr2g-1; Tue, 01 Feb 2022 08:26:33 -0500
X-MC-Unique: Ps4YUhxlNiGFYKnj5GBr2g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E1D81091DA3;
        Tue,  1 Feb 2022 13:26:31 +0000 (UTC)
Received: from localhost (unknown [10.39.194.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 38EF978DDD;
        Tue,  1 Feb 2022 13:26:31 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yishai Hadas <yishaih@nvidia.com>, alex.williamson@redhat.com,
        bhelgaas@google.com, saeedm@nvidia.com, linux-pci@vger.kernel.org,
        kvm@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org,
        leonro@nvidia.com, kwankhede@nvidia.com, mgurtovoy@nvidia.com,
        maorg@nvidia.com
Subject: Re: [PATCH V6 mlx5-next 10/15] vfio: Remove migration protocol v1
In-Reply-To: <20220201125444.GE1786498@nvidia.com>
Organization: Red Hat GmbH
References: <20220130160826.32449-1-yishaih@nvidia.com>
 <20220130160826.32449-11-yishaih@nvidia.com> <874k5izv8m.fsf@redhat.com>
 <20220201121325.GB1786498@nvidia.com> <87sft2yd50.fsf@redhat.com>
 <20220201125444.GE1786498@nvidia.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date:   Tue, 01 Feb 2022 14:26:29 +0100
Message-ID: <87mtjayayi.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 01 2022, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Feb 01, 2022 at 01:39:23PM +0100, Cornelia Huck wrote:
>> On Tue, Feb 01 2022, Jason Gunthorpe <jgg@nvidia.com> wrote:
>> 
>> > On Tue, Feb 01, 2022 at 12:23:05PM +0100, Cornelia Huck wrote:
>> >> On Sun, Jan 30 2022, Yishai Hadas <yishaih@nvidia.com> wrote:
>> >> 
>> >> > From: Jason Gunthorpe <jgg@nvidia.com>
>> >> >
>> >> > v1 was never implemented and is replaced by v2.
>> >> >
>> >> > The old uAPI definitions are removed from the header file. As per Linus's
>> >> > past remarks we do not have a hard requirement to retain compilation
>> >> > compatibility in uapi headers and qemu is already following Linus's
>> >> > preferred model of copying the kernel headers.
>> >> 
>> >> If we are all in agreement that we will replace v1 with v2 (and I think
>> >> we are), we probably should remove the x-enable-migration stuff in QEMU
>> >> sooner rather than later, to avoid leaving a trap for the next
>> >> unsuspecting person trying to update the headers.
>> >
>> > Once we have agreement on the kernel patch we plan to send a QEMU
>> > patch making it support the v2 interface and the migration
>> > non-experimental. We are also working to fixing the error paths, at
>> > least least within the limitations of the current qemu design.
>> 
>> I'd argue that just ripping out the old interface first would be easier,
>> as it does not require us to synchronize with a headers sync (and does
>> not require to synchronize a headers sync with ripping it out...)
>
> We haven't worked out the best way to organize the qemu patch series,
> currently it is just one patch that updates everything together, but
> that is perhaps a bit too big...
>
> I have thought that a 3 patch series deleting the existing v1 code and
> then readding it is a potential option, but we don't change
> everything, just almost everything..

Even in that case, removing the old code and adding the new one is
probably much easier to review. (Also, you obviously need to have the
header update in between those two stages.)

>
>> > The v1 support should remain in old releases as it is being used in
>> > the field "experimentally".
>> 
>> Of course; it would be hard to rip it out retroactively :)
>> 
>> But it should really be gone in QEMU 7.0.
>
> Seems like you are arguing from both sides, we can't put the v2 in to
> 7.0 because Linus has not accepted it but we have to rip the v1 out
> even though Linus hasn't accepted that?
>
> We can certainly defer the kernels removal patch for a release if it
> makes qemu's life easier?

No, I'm only talking about the QEMU implementation (i.e. the code that
uses the v1 definitions and exposes x-enable-migration). Any change in
the headers needs to be done via a sync with upstream Linux.

>
>> Considering adding the v2 uapi, we might get unlucky: The Linux 5.18
>> merge window will likely be in mid-late March (and we cannot run a
>> headers sync before the patches hit Linus' tree), while QEMU 7.0 will
>> likely enter freeze in mid-late March as well. So there's a non-zero
>> chance that the new uapi will need to be deferred to 7.1.
>
> Usually in rdma land we start advancing the user side once the kernel
> patches hit the kernel maintainer tree, not Linus's. I run a
> non-rebasing tree so that gives a permanent git hash. It works well
> enough and avoids these kinds of artificial delays.

QEMU policy is "it must be in Linus' tree [*]", because we run a full
header sync. We have been bitten by premature updates in the
past. Updates of only parts of the headers are only acceptable during
development of a patch series, and must be marked as "will be replaced
with a proper header sync".

[*] Preferrably a (full or -rc) release, but the very minimum is a git
hash from his tree.

