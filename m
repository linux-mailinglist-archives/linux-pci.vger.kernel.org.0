Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5732C6B6A
	for <lists+linux-pci@lfdr.de>; Fri, 27 Nov 2020 19:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733041AbgK0SMU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Nov 2020 13:12:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47459 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732755AbgK0SMU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Nov 2020 13:12:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606500738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PvVVh2WZkbAnSX5t/B+zX/WRWvJt82nXnXEMvGPZevw=;
        b=ggsuuNciBXcWl6cOu0VynewOhZ5UZSpOcLeBgAAc/AhwEg2kD40wJMwistswKpQhaGs6gl
        PfixS6RrCk7I67zaNcPqfGA6r1JKRzeZgkYDST49BwH8UhcszZRCnulQjOSJThVKWxVI0o
        TdWOWSQ8bjbq5S6vx3VKKNS60F1EPYg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-r8td5SadPcey54Dca-T_pA-1; Fri, 27 Nov 2020 13:12:16 -0500
X-MC-Unique: r8td5SadPcey54Dca-T_pA-1
Received: by mail-ej1-f70.google.com with SMTP id pv11so2236709ejb.5
        for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2020 10:12:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PvVVh2WZkbAnSX5t/B+zX/WRWvJt82nXnXEMvGPZevw=;
        b=O1xgGPAnd3fDgDSCZl42CuGW0rr/jWzIVdoVfFT0MlgCkzkLpVSottz/VZImzws+tE
         omJ6oWNGJAsInp2eA9d6S9yva01idt7yWSX3AY9F/E2oqh4ObuOqq6zq5BYrUTljnkZE
         vN6aRtIezplOvQqLO/JOM/qf8Nry7or1kBbJVKoG+bL0IixKqSqTTMSKkd6iqgRZmKbn
         yMuRprZT9fWZju1xEIxkLs5V9VxwpSXZXf82d+gJMxxykDn0a4dUbJK5OkXsY+UyYQmO
         S2T4/+qi9EdA+GCqHeS6eZGG5Q/nfbBRS9LitjquNqO4mxG50xlRoA6GJe7vUyXs1l4h
         FxtQ==
X-Gm-Message-State: AOAM532tifh456tH0Vf6yZ3C7K9bE0WhXhvAps1CWavjacaJr8C7k/sh
        QQJy4cmScESfssl0yQrWZesc/7PlzhezWEFBf88rpE5No3st6kFuLh2zV1qqm4wQE/kjO+G+5oC
        h6v0/lacSgEDOcUz/9CPH
X-Received: by 2002:a17:906:8617:: with SMTP id o23mr4696780ejx.274.1606500735282;
        Fri, 27 Nov 2020 10:12:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwyZU3HmLRRmc6hevuC7dKusx9uLm+xbnlpO5CjCfhATeXbQ9o9xALNF+99u8lVyGz2dxLcYQ==
X-Received: by 2002:a17:906:8617:: with SMTP id o23mr4696763ejx.274.1606500735127;
        Fri, 27 Nov 2020 10:12:15 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id lc18sm1454700ejb.77.2020.11.27.10.12.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 10:12:14 -0800 (PST)
Subject: Re: 5.10 regression caused by: "uas: fix sdev->host->dma_dev": many
 XHCI swiotlb buffer is full / DMAR: Device bounce map failed errors on
 thunderbolt connected XHCI controller
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tom Yan <tom.ty89@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
References: <b046dd04-ac4f-3c69-0602-af810fb1b365@redhat.com>
 <be031d15-201f-0e5c-8b0f-be030077141f@redhat.com>
 <20201124102715.GA16983@lst.de>
 <fde7e11f-5dfc-8348-c134-a21cb1116285@redhat.com>
 <8a52e868-0ca1-55b7-5ad2-ddb0cbb5e45d@redhat.com>
 <20201127161900.GA10986@lst.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <fded04e2-f2e9-de92-ab1f-5aa088904e90@redhat.com>
Date:   Fri, 27 Nov 2020 19:12:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201127161900.GA10986@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 11/27/20 5:19 PM, Christoph Hellwig wrote:
> On Fri, Nov 27, 2020 at 01:32:16PM +0100, Hans de Goede wrote:
>> I ran some more tests, I can confirm that reverting:
>>
>> 5df7ef7d32fe "uas: bump hw_max_sectors to 2048 blocks for SS or faster drives"
>> 558033c2828f "uas: fix sdev->host->dma_dev"
>>
>> Makes the problem go away while running a 5.10 kernel. I also tried doubling
>> the swiotlb size by adding: swiotlb=65536 to the kernel commandline but that
>> does not help.
>>
>> Some more observations:
>>
>> 1. The usb-storage driver does not cause this issue, even though it has a
>> very similar change.
>>
>> 2. The problem does not happen until I plug an UAS decvice into the dock.
>>
>> 3. The problem continues to happen even after I unplug the UAS device and
>> rmmod the uas module
>>
>> 3. made me take a bit closer look to the troublesome commit, it passes:
>> udev->bus->sysdev, which I assume is the XHCI controller itself as device
>> to scsi_add_host_with_dma, which in turn seems to cause permanent changes
>> to the dma settings for the XHCI controller. I'm not all that familiar with
>> the DMA APIs but I'm getting the feeling that passing the actual XHCI-controller's
>> device as dma-device to scsi_add_host_with_dma is simply the wrong thing to
>> do; and that the intended effects (honor XHCI dma limits, but do not cause
>> any changes the XHCI dma settings) should be achieved differently.
>>
>> Note that if this is indeed wrong, the matching usb-storage change should
>> likely also be dropped.
> 
> One problem in this area is that the clamping of the DMA size through
> dma_max_mapping_size mentioned in the commit log doesn't work when
> swiotlb is called from intel-iommu. I think we need to wire up those
> calls there as well.

Ok, but that does not sound like a quick last minute fix for 5.10, so maybe
for 5.10 we should just revert the uas and usb-storage changes which trigger
this problem and then retry those for 5.11 ?

Regards,

Hans 

