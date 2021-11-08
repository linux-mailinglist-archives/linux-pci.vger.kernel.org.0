Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0934E449AA7
	for <lists+linux-pci@lfdr.de>; Mon,  8 Nov 2021 18:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237686AbhKHRVH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Nov 2021 12:21:07 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:39602 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhKHRVH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Nov 2021 12:21:07 -0500
Received: by mail-wr1-f51.google.com with SMTP id d27so28179497wrb.6;
        Mon, 08 Nov 2021 09:18:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k+xBEZ60gaFRX6TewmJXrlZ7gEV8kWXNlWQ1p+Qwerc=;
        b=G1dKyzOdmL8P2Rf6fdpwzDjSPbNpz7qh1TdbRCdNPfthhy6f4DjfEilPvvY/YIIKbv
         8qIiAf1Bke7JHbl2wRbcYpnl9C+rNZ7riFXGmnFt6rP8WWaaGEXPFh1DDaYwHQXfsI6a
         QF25MMzbAQhty6bEUikiUTPyMDz9UpGw7LBg/XTgGVaeGORa3yLQQxHV0bEOO8kvZ2xU
         0DbZEX6tnT5KYjgLSDSp6OMjOzSqHN3JDC7ASZhHLhkvDbO8jdkaCIKbL+A3w35jou7j
         BLbUqnPN/3mE+ZdNc0eX6YY74gbhYTjxIABgtamsiWuHWSxJPZe0mTwlacAf101bZHSE
         LSIg==
X-Gm-Message-State: AOAM532BczY7GnaZxAzEjbzABhr2iEMHeuaKGCSkEG1akIGbHc7nH/Pl
        bfEm17ytA6igWwUQMQYRJh8=
X-Google-Smtp-Source: ABdhPJyhia6d85wm25bZ2YttwtRNLe8TYhS/6mtXkEsdSSvLaOR+qPwM+MSHCuDa9WsPVoLocUfggQ==
X-Received: by 2002:a5d:45cc:: with SMTP id b12mr912657wrs.164.1636391901696;
        Mon, 08 Nov 2021 09:18:21 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id f18sm17208547wre.7.2021.11.08.09.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 09:18:21 -0800 (PST)
Date:   Mon, 8 Nov 2021 18:18:19 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        iommu@lists.linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: How to reduce PCI initialization from 5 s (1.5 s adding them to
 IOMMU groups)
Message-ID: <YYlb2w1UVaiVYigW@rocinante>
References: <de6706b2-4ea5-ce68-6b72-02090b98630f@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <de6706b2-4ea5-ce68-6b72-02090b98630f@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Paul,

> On a PowerEdge T440/021KCD, BIOS 2.11.2 04/22/2021, Linux 5.10.70 takes
> almost five seconds to initialize PCI. According to the timestamps, 1.5 s
> are from assigning the PCI devices to the 142 IOMMU groups.
[...]
> Is there anything that could be done to reduce the time?

I am curious - why is this a problem?  Are you power-cycling your servers
so often to the point where the cumulative time spent in enumerating PCI
devices and adding them later to IOMMU groups is a problem? 

I am simply wondering why you decided to signal out the PCI enumeration as
slow in particular, especially given that a large server hardware tends to
have (most of the time, as per my experience) rather long initialisation
time either from being powered off or after being power cycled.  I can take
a while before the actual operating system itself will start.

We talked about this briefly with Bjorn, and there might be an option to
perhaps add some caching, as we suspect that the culprit here is doing PCI
configuration space read for each device, which can be slow on some
platforms.

However, we would need to profile this to get some quantitative data to see
whether doing anything would even be worthwhile.  It would definitely help
us understand better where the bottlenecks really are and of what magnitude.

I personally don't have access to such a large hardware like the one you
have access to, thus I was wondering whether you would have some time, and
be willing, to profile this for us on the hardware you have.

Let me know what do you think?

	Krzysztof
