Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A09286A51
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 23:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgJGVgg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 17:36:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27366 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726013AbgJGVge (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Oct 2020 17:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602106592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VaWBCvnLnMCu9K8Y6rGNvR+4FR1+Z+PYqu4cnE5JVz0=;
        b=hBrxVwSQVyrVPCfBBBtSlopvzZS7EDBfKxgaQCUo+xGkug5GIZwW/2S8DZBfbBnfY17nzo
        1pfDJtWQTHdP6n1oDIgjrK1JeoaQ1XP5ojBV5bWm3S4RwcRoQjq+p30cmT7uhAejq5OENR
        3J8yqBcGGKV5ZLaXzemsYCjBcWLA7AY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-26JM37vnNsK74GDJ0WG_Ig-1; Wed, 07 Oct 2020 17:36:29 -0400
X-MC-Unique: 26JM37vnNsK74GDJ0WG_Ig-1
Received: by mail-ed1-f70.google.com with SMTP id s21so1455507edi.6
        for <linux-pci@vger.kernel.org>; Wed, 07 Oct 2020 14:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VaWBCvnLnMCu9K8Y6rGNvR+4FR1+Z+PYqu4cnE5JVz0=;
        b=bcizBbH3U5XwLWMdqbF845lf5pr1JCe8KZvZZ5i212vyf0N19dajmzkub62rBWPiQB
         sw7jJdrIPdvPJ8l/rAcmcmAl9A49+d0EKRLyHWjyDlpFoB6pu+nU7Y2aDmiMGKL7jhO1
         VeI4iyZTH/5w/1E0nOPzoIi3fh7O9u6/Q46vRGq6dRdL9Kg4gpN9dzGmSIRXFONkG79y
         pqzFLI0Q3Kuf7dEukDlDdBGl/tduMiZDw+xOifcw5IviQg3zstAf/t4dTeZQGP2S1iLO
         UJz8mEJJ8eZ9m72LYleL87gK/0oUEELp+KB+kq8m8s+9XMJ4OO+eAecQxADphbmzMklT
         Cngw==
X-Gm-Message-State: AOAM532VC/Wtj9BkRZDp7UvwCx08ZA9bW21BlXNEGpOEdwOUWBXgOJGb
        R/mxEk5PvSZpY+1QQ3diICTJmISAf6qcOfIGPMyJTw7kWHnbUW2hdKES2exGH8o1whp7xbiQcRI
        eOiameCy/MJ/CarBgDWkq
X-Received: by 2002:a17:906:d186:: with SMTP id c6mr5193520ejz.298.1602106587848;
        Wed, 07 Oct 2020 14:36:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkfKaJEhZrG5NDUqhcd7QFr5sWP0E6bwLI9Qqlgn3cv72BQQ3Te9xwgxqq9162bqA11Qp/2g==
X-Received: by 2002:a17:906:d186:: with SMTP id c6mr5193505ejz.298.1602106587608;
        Wed, 07 Oct 2020 14:36:27 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id c5sm2453276edx.58.2020.10.07.14.36.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 14:36:26 -0700 (PDT)
Subject: Re: [PATCH V8 1/5] PCI: Add defines for Designated Vendor-Specific
 Extended Capability
To:     Lee Jones <lee.jones@linaro.org>,
        "David E. Box" <david.e.box@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, dvhart@infradead.org,
        andy@infradead.org, bhelgaas@google.com,
        alexey.budankov@linux.intel.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20201007005118.GA3230211@bjorn-Precision-5520>
 <dcaea6b4e1d5b4a452c304fadb034b7b1e1c40af.camel@linux.intel.com>
 <20201007065451.GB6148@dell>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e09f4c44-e3d0-e14b-297f-6981516ea3bf@redhat.com>
Date:   Wed, 7 Oct 2020 23:36:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201007065451.GB6148@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 10/7/20 8:54 AM, Lee Jones wrote:
> On Tue, 06 Oct 2020, David E. Box wrote:
> 
>> On Tue, 2020-10-06 at 19:51 -0500, Bjorn Helgaas wrote:
>>> On Tue, Oct 06, 2020 at 03:45:54PM -0700, David E. Box wrote:
>>>> Hi Bjorn,
>>>>
>>>> This patch has been acked and unchanged for weeks. Is it possible
>>>> to
>>>> get this pulled into next? We have SIOV and CXL related work that
>>>> is
>>>> using these definitions. Thanks.
>>>
>>> I acked it because I expected you to merge it along with the rest of
>>> the series.
>>>
>>> I guess I could merge this patch via the PCI tree if you really want,
>>> but that ends up being a hassle because we have to worry about which
>>> order things get merged to Linus' tree.  Better if the whole series
>>> is
>>> merged via the same tree.
>>
>> Agreed. The hope is that this series is ready for the next merge window
>> but no ack yet on V8. And if the series does not make it I'd like this
>> patch to at least get in.
> 
> If Bjorn is happy to take this patch so late in the release cycle then
> please go ahead.  The other patches are due for v5.11.

I agree (that the other patches are for 5.11) talking about merging
this series patch 2 is a mfd patch and patches 3-5 are drivers/platform/x86
patches.

Lee, FYI I'm taking over drivers/platform/x86 maintainership from Andy.

I suggest that we merge the entire series through a single tree
(with acks or reviewed-by-s from the other maintainer)
either through the mfd tree or through the drivers/platform/x86
tree. Since most changes are in drivers/platform/x86 the latter
probably makes more sense, but either way works for me.
So how would you like to proceed with this series ?

Regards,

Hans

