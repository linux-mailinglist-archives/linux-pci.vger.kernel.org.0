Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8776F2C22F7
	for <lists+linux-pci@lfdr.de>; Tue, 24 Nov 2020 11:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731910AbgKXKbJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Nov 2020 05:31:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52949 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731904AbgKXKbI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Nov 2020 05:31:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606213867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h+X/QM3LIRfUSG0/Ck2rlt3TvdbGoFO5E2DZVLdsfOw=;
        b=SsuKR54dhpLYIOQjkHN4FTxtlTiKSCWtbHuGgHaQBFI3JXFdautdiDuI/rQAj1aav5ZwAM
        61rneSo0bN2mnF+Pdc8ZmAjN6eH7zpFyYFqFIF9G0v+XLm5R9F4KnEAdZvVLIexoEr4t4W
        wTehctBxOVXVd9iyPGVNiV0adev4S0A=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-2Q8HcDq0M5-cvYHn9XRrXw-1; Tue, 24 Nov 2020 05:31:04 -0500
X-MC-Unique: 2Q8HcDq0M5-cvYHn9XRrXw-1
Received: by mail-ej1-f71.google.com with SMTP id y10so2124600ejg.3
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2020 02:31:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h+X/QM3LIRfUSG0/Ck2rlt3TvdbGoFO5E2DZVLdsfOw=;
        b=NhHaJd7rGZeMxY4LxIhTOB2TxkCe8IMoZl5Eht35HcXGnxsNDDGe0cbiYGSEDNt4Xy
         6C/BkZe3SA+RHIILTvNuCSepuhoYm6cyhoeP+pCQ3h9PGlK10ATFeTtA4gEy6fDE899T
         YT5CwN8TcbBlPz9PKfJQTduEg9FC9WwJkdCvVSd8GRDfrWErn35nly8bxr94lWCqOUS0
         3uajaIPd81WXRne/b8jvO9h2ZYcrzgnWtHx3LEnhtcMZz6INiPBx3+p7IE6QeVGgIbxC
         ZCK7s2ikUFBdRhpNGqHmhok5ulzsOHx8hHtuPaO7Cf2VjLTt4VR52VMHcn766dNCW9AH
         BksA==
X-Gm-Message-State: AOAM533iBG3aaCOrowGnJJS/JfYg6e2X7KLRjuhhEM2QmSB/ewr8B1EE
        p6RFy+5uKHhWzz9isQuadYHC27inyjY0XotuV3K7fKQz+GP7yc3LfJwVzIOl6dsVbKXVpWG4HFx
        OZo9DYsBDxYMLkyVLyple8u3kPwE+rCBD+7qei1JsfPjx+FcaWPliScG0Xldcl2YMKHjGLGSo
X-Received: by 2002:a50:b584:: with SMTP id a4mr3303667ede.301.1606213863572;
        Tue, 24 Nov 2020 02:31:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx1j1BZSeJJvNp43wSQVFfTRwJU5DVEOcEbiKgJSh1BIM/Fcda7aNMf+62DHflzA3z3suVNBw==
X-Received: by 2002:a50:b584:: with SMTP id a4mr3303648ede.301.1606213863382;
        Tue, 24 Nov 2020 02:31:03 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id i13sm6517717ejv.84.2020.11.24.02.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 02:31:02 -0800 (PST)
Subject: Re: 5.10 regression, many XHCI swiotlb buffer is full / DMAR: Device
 bounce map failed errors on thunderbolt connected XHCI controller
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
References: <b046dd04-ac4f-3c69-0602-af810fb1b365@redhat.com>
 <be031d15-201f-0e5c-8b0f-be030077141f@redhat.com>
 <20201124102715.GA16983@lst.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f1bd62b4-a746-6b1c-08ee-6dd1982722b6@redhat.com>
Date:   Tue, 24 Nov 2020 11:31:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201124102715.GA16983@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 11/24/20 11:27 AM, Christoph Hellwig wrote:
> On Mon, Nov 23, 2020 at 03:49:09PM +0100, Hans de Goede wrote:
>> Hi,
>>
>> +Cc Christoph Hellwig <hch@lst.de>
>>
>> Christoph, this is still an issue, so I've been looking around a bit and think this
>> might have something to do with the dma-mapping-5.10 changes.
>>
>> Do you have any suggestions to debug this, or is it time to do a git bisect
>> on this before 5.10 ships with regression?
> 
> Given that DMAR prefix this seems to be about using intel-iommu + bounce
> buffering for external devices.  I can't really think of anything specific
> in 5.10 related to that, so maybe you'll need to bisect.
> 
> I doub this means we are actually leaking swiotlb buffers, so while
> I'm pretty sure we broke something in lower layers this also means
> xhci doesn't handle swiotlb operation very gracefully in general.

Ok, I've re-arranged my schedule a bit so that I have time to bisect this
tomorrow, so with some luck I will be able to provide info on which commit
introduced this issue tomorrow around the end of the day.

Regards,

Hans

