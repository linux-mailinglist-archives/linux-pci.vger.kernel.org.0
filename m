Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E51743B63B
	for <lists+linux-pci@lfdr.de>; Tue, 26 Oct 2021 17:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237175AbhJZP72 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Oct 2021 11:59:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31153 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237070AbhJZP7Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Oct 2021 11:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635263819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UYwBjkSj5lDOT0PzzhKLwMNAvnrM/P7dTV0P8w6zo6E=;
        b=U1xxr1Z80035CkVha3x1cOK7cPNve7GcTT242W0XtpnL0SGIBtwGLlkFJ7BGHNo7I3mSPB
        cMwwPfJxWEUIFqlQQwo0gSV07Vss6Qhu5odPCknJdTvCzKtVssEF8tv3Xo+P7L/mqND8tZ
        CPeLr4HD5HDNm8lQWa+Y1OcwqcyaiYs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-IsWlb1JsM16T5PUnSi5AiA-1; Tue, 26 Oct 2021 11:56:53 -0400
X-MC-Unique: IsWlb1JsM16T5PUnSi5AiA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5DBE8026AD;
        Tue, 26 Oct 2021 15:56:50 +0000 (UTC)
Received: from localhost (unknown [10.39.193.201])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 725C85D6BA;
        Tue, 26 Oct 2021 15:56:46 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Yishai Hadas <yishaih@nvidia.com>, bhelgaas@google.com,
        jgg@nvidia.com, saeedm@nvidia.com, linux-pci@vger.kernel.org,
        kvm@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org,
        leonro@nvidia.com, kwankhede@nvidia.com, mgurtovoy@nvidia.com,
        maorg@nvidia.com
Subject: Re: [PATCH V4 mlx5-next 06/13] vfio: Fix
 VFIO_DEVICE_STATE_SET_ERROR macro
In-Reply-To: <20211026095057.1024c132.alex.williamson@redhat.com>
Organization: Red Hat GmbH
References: <20211026090605.91646-1-yishaih@nvidia.com>
 <20211026090605.91646-7-yishaih@nvidia.com> <87pmrrdcos.fsf@redhat.com>
 <20211026095057.1024c132.alex.williamson@redhat.com>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Tue, 26 Oct 2021 17:56:44 +0200
Message-ID: <87k0hzdbk3.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 26 2021, Alex Williamson <alex.williamson@redhat.com> wrote:

> On Tue, 26 Oct 2021 17:32:19 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
>
>> On Tue, Oct 26 2021, Yishai Hadas <yishaih@nvidia.com> wrote:
>> 
>> > Fixed the non-compiled macro VFIO_DEVICE_STATE_SET_ERROR (i.e. SATE
>> > instead of STATE).
>> >
>> > Fixes: a8a24f3f6e38 ("vfio: UAPI for migration interface for device state")
>> > Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
>> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>  
>> 
>> This s-o-b chain looks weird; your s-o-b always needs to be last.
>> 
>> > ---
>> >  include/uapi/linux/vfio.h | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> > index ef33ea002b0b..114ffcefe437 100644
>> > --- a/include/uapi/linux/vfio.h
>> > +++ b/include/uapi/linux/vfio.h
>> > @@ -622,7 +622,7 @@ struct vfio_device_migration_info {
>> >  					      VFIO_DEVICE_STATE_RESUMING))
>> >  
>> >  #define VFIO_DEVICE_STATE_SET_ERROR(state) \
>> > -	((state & ~VFIO_DEVICE_STATE_MASK) | VFIO_DEVICE_SATE_SAVING | \
>> > +	((state & ~VFIO_DEVICE_STATE_MASK) | VFIO_DEVICE_STATE_SAVING | \
>> >  					     VFIO_DEVICE_STATE_RESUMING)
>> >  
>> >  	__u32 reserved;  
>> 
>> Change looks fine, although we might consider merging it with the next
>> patch? Anyway,
>
> I had requested it separate a couple revisions ago since it's a fix.
> Thanks,
>
> Alex

Fair enough.

