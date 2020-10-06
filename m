Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76826284ED9
	for <lists+linux-pci@lfdr.de>; Tue,  6 Oct 2020 17:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgJFPXs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Oct 2020 11:23:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55062 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725906AbgJFPXs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Oct 2020 11:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601997826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ySCeSs2lHG0zJMFNUJWe/o+SED3rw+cfxJDttvVzqbI=;
        b=UXK//kzcGMZNCN74OHCstukX3zhNuDfEInm5N9lr51gOg16b9dgg6wu0NqCOCRmTYoDhLF
        IyRn4Yvu86c8Wfyex55R6iDBVwk22ZcnMkHDcAJ1S6zvjWr9l2dKSmKITYuSMs4C7PKa3r
        UehP/JuHn5xnVSMcYoEMG5wrO+Sv2yw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-jh5Gf5HfOXm18dGTE45rhg-1; Tue, 06 Oct 2020 11:23:42 -0400
X-MC-Unique: jh5Gf5HfOXm18dGTE45rhg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BF8B9CC07;
        Tue,  6 Oct 2020 15:23:40 +0000 (UTC)
Received: from [10.36.113.210] (ovpn-113-210.ams2.redhat.com [10.36.113.210])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F13660BFA;
        Tue,  6 Oct 2020 15:23:33 +0000 (UTC)
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
To:     Al Stone <ahs3@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, lorenzo.pieralisi@arm.com
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <ab2a1668-e40c-c8f0-b77b-abadeceb4b82@redhat.com>
 <20200924045958-mutt-send-email-mst@kernel.org>
 <20200924092129.GH27174@8bytes.org>
 <20200924053159-mutt-send-email-mst@kernel.org>
 <d54b674e-2626-fc73-d663-136573c32b8a@redhat.com>
 <20201002182348.GO138842@redhat.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <e8a37837-30d0-d7cc-496a-df4c12fff1da@redhat.com>
Date:   Tue, 6 Oct 2020 17:23:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201002182348.GO138842@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Al,

On 10/2/20 8:23 PM, Al Stone wrote:
> On 24 Sep 2020 11:54, Auger Eric wrote:
>> Hi,
>>
>> Adding Al in the loop
>>
>> On 9/24/20 11:38 AM, Michael S. Tsirkin wrote:
>>> On Thu, Sep 24, 2020 at 11:21:29AM +0200, Joerg Roedel wrote:
>>>> On Thu, Sep 24, 2020 at 05:00:35AM -0400, Michael S. Tsirkin wrote:
>>>>> OK so this looks good. Can you pls repost with the minor tweak
>>>>> suggested and all acks included, and I will queue this?
>>>>
>>>> My NACK still stands, as long as a few questions are open:
>>>>
>>>> 	1) The format used here will be the same as in the ACPI table? I
>>>> 	   think the answer to this questions must be Yes, so this leads
>>>> 	   to the real question:
>>>
>>> I am not sure it's a must.
>>> We can always tweak the parser if there are slight differences
>>> between ACPI and virtio formats.
>>>
>>> But we do want the virtio format used here to be approved by the virtio
>>> TC, so it won't change.
>>>
>>> Eric, Jean-Philippe, does one of you intend to create a github issue
>>> and request a ballot for the TC? It's been posted end of August with no
>>> changes ...
>> Jean-Philippe, would you?
>>>
>>>> 	2) Has the ACPI table format stabalized already? If and only if
>>>> 	   the answer is Yes I will Ack these patches. We don't need to
>>>> 	   wait until the ACPI table format is published in a
>>>> 	   specification update, but at least some certainty that it
>>>> 	   will not change in incompatible ways anymore is needed.
>>>>
>>
>> Al, do you have any news about the the VIOT definition submission to
>> the UEFI ASWG?
>>
>> Thank you in advance
>>
>> Best Regards
>>
>> Eric
> 
> A follow-up to my earlier post ....
> 
> Hearing no objection, I've submitted the VIOT table description to
> the ASWG for consideration under what they call the "code first"
> process.  The "first reading" -- a brief discussion on what the
> table is and why we would like to add it -- was held yesterday.
> No concerns have been raised as yet.  Given the discussions that
> have already occurred, I don't expect any, either.  I have been
> wrong at least once before, however.
> 
> At this point, ASWG will revisit the request to add VIOT each
> week.  If there have been no comments in the prior week, and no
> further discussion during the meeting, then a vote will be taken.
> Otherwise, there will be discussion and we try again the next
> week.
> 
> The ASWG was also told that the likelihood of this definition of
> the table changing is pretty low, and that it has been thought out
> pretty well already.  ASWG's consideration will therefore start
> from the assumption that it would be best _not_ to make changes.
> 
> So, I'll let you know what happens next week.

Thank you very much for the updates and for your support backing the
proposal in the best delays.

Best Regards

Eric
> 
>>
>>>
>>> Not that I know, but I don't see why it's a must.
>>>
>>>> So what progress has been made with the ACPI table specification, is it
>>>> just a matter of time to get it approved or are there concerns?
>>>>
>>>> Regards,
>>>>
>>>> 	Joerg
>>>
>>
> 

