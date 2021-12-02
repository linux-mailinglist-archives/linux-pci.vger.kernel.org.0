Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FDB4662C4
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 12:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241583AbhLBLzk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 06:55:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24856 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231177AbhLBLzk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 06:55:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638445937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I4l2g13zlARxBgz+u6NApkRqVjZd/HGQhO4CG2YhV/E=;
        b=FcHXJpUCkrYKJS/eJJlqLLpAdICYVqzXyYtdpGu0/MGs6AzC0la7418c2s1t9Lxjw3ZHKp
        0a9f+huierdhOg95X13hC6hoAkL1B7cJmomTtmAGWCWCZnBh2o83ayBOrtOeThrhLft+Rr
        KfAjvMmj4Yy7rts8Y0w/Wh5a8QGpOxA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-16QJbUg9M8CXd8AkEmwatQ-1; Thu, 02 Dec 2021 06:52:16 -0500
X-MC-Unique: 16QJbUg9M8CXd8AkEmwatQ-1
Received: by mail-ed1-f69.google.com with SMTP id d13-20020a056402516d00b003e7e67a8f93so23376117ede.0
        for <linux-pci@vger.kernel.org>; Thu, 02 Dec 2021 03:52:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=I4l2g13zlARxBgz+u6NApkRqVjZd/HGQhO4CG2YhV/E=;
        b=cZw4RfYsPUT2vdF9GpnVO1RtFhSomJop6inmE7hj5LWpBNRbAYiIofRylkPdN31Zpb
         VEaAKjSImjGjO02TZhJO62YcZ6OekdBsTtmQ0KG6tbfIBYFXUgNoUJ1XlfC0Y2BMbOfK
         gO8SBYYBbWMcdXvkp+F7Bjbly9rVGHCZ2t7CTM12WJpzOBGK+mjITN0PYNrWb4XIz1Mh
         4zy046wzPb3DMVKlBM/THO6uvX8YOHNXIVggSFnPv1r/MKgAA3cesiLHUHfEGniuq0ct
         UAkVATHHxDQzoV7hGbR5emzo25vxV8jcZzZODM9x5ZU2ZlRCejuJLHEKpty6oydVTX5r
         B6+g==
X-Gm-Message-State: AOAM532MtTx521OvJcvn5dVxovmpqgV5RZBqxBKza1B0Z6j3ottNveZp
        A0bcG6KQjE/dext3SDYhtKW1St/bkSPCtnO1TCaan75y7kS8USB4O7ukTYgWS5Bo0yDBf7qsO2o
        Nhbf1DrpaggpAX18uTayB
X-Received: by 2002:a17:906:229b:: with SMTP id p27mr14880109eja.264.1638445935301;
        Thu, 02 Dec 2021 03:52:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzFTvPL6KGAYPs8sqdWB7JMRyWSCuuqKGW0txm9NlrGCWYjqwDF01agsOcX9s9clr3cF9YlvQ==
X-Received: by 2002:a17:906:229b:: with SMTP id p27mr14880080eja.264.1638445935032;
        Thu, 02 Dec 2021 03:52:15 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id jg32sm2058369ejc.43.2021.12.02.03.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 03:52:14 -0800 (PST)
Message-ID: <05f460a4-e6ba-a04c-cab8-ab86e265e83c@redhat.com>
Date:   Thu, 2 Dec 2021 12:52:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 2/2] PCI: pciehp: Use down_read/write_nested(reset_lock)
 to fix lockdep errors
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-pci@vger.kernel.org
References: <20211129121934.4963-1-hdegoede@redhat.com>
 <20211129121934.4963-2-hdegoede@redhat.com> <20211129153943.GA4896@wunner.de>
 <20211129185946.GA1475@wunner.de>
 <0dcac663-4726-6deb-d518-3f29583b7baf@redhat.com>
 <20211130193951.GA15925@wunner.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211130193951.GA15925@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 11/30/21 20:39, Lukas Wunner wrote:
> On Tue, Nov 30, 2021 at 11:15:40AM +0100, Hans de Goede wrote:
>> On 11/29/21 19:59, Lukas Wunner wrote:
>>> Hm, I found the notes that I took when I investigated Theodore's report:
>>> Using a subclass may be problematic because it's limited to a value < 8
>>> (MAX_LOCKDEP_SUBCLASSES).  If there's a hotplug port at a deeper level
>>> than 8 in the PCI hierarchy (can easily happen, Thunderbolt daisy chain
>>> allows up to 6 devices, each device contains a PCIe switch, so 2 levels per
>>> device), look_up_lock_class() in kernel/locking/lockdep.c will emit a BUG
>>> error message.
> 
> Actually, after thinking about this some more it has occurred to me
> that you should be able to make do with 8 subclasses if you change
> the algorithm in patch [1/2] to something like this:
> 
> 	while (bus->parent) {
> -		depth++;
> 		bus = bus->parent;
> +		if (bus->self->is_hotplug_bridge)
> +			depth++;
> 	}
> 
> (It may be necessary to add a NULL pointer check for bus->self,
> off the top of my hat I'm not sure if that's set for the root bus.)
> 
> Because with the patches as they are, the array of 8 subclasses is
> sparsely populated, i.e. if a parent port is not a hotplug port,
> a subclass is wasted.  You only care about hotplug ports (more
> specifically those handled by pciehp) because those are the only
> ones with a reset_lock.  The above change should result in a
> densely populated array of subclasses.
> 
> Naturally, because this makes the function pciehp-specific,
> it should be moved from include/linux/pci.h to pciehp_hpc.c.
> 
> With Thunderbolt you can have 6 devices plus the hotplug port in
> the host controller.  And there may be an 8th hotplug port at the
> Root Port if the host controller can be "unplugged" when it goes
> to D3cold.  (That's handled by acpiphp, not pciehp, and I'm not
> even sure if is_hotplug_bridge is set in that case.)
> So 8 subclasses should be sufficient.
> 
> Aside from Thunderbolt, nested hotplug ports exist in data centers
> with hot-removable NVMe slots in hot-removable chassis, but I highly
> doubt those use cases have more than 8 levels of hotplug ports.
> 
> So that would probably be a pragmatic and minimalistic approach to this
> problem.

Ack. I've prepared and tested a v2 patch using this approach, this
v2 also addresses all your and Bjorn's other remarks.

I will send out the v2 patch right after this email.

Regards,

Hans

