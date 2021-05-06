Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9220374DAE
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 04:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhEFCrZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 May 2021 22:47:25 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:44901 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhEFCrY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 May 2021 22:47:24 -0400
Received: by mail-wm1-f53.google.com with SMTP id 82-20020a1c01550000b0290142562ff7c9so2186417wmb.3
        for <linux-pci@vger.kernel.org>; Wed, 05 May 2021 19:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q63Yl8ODPSJvfVQOAWVTya7fVCffsXgPYg1cX6mYt0s=;
        b=L/EkfQjBoXYz0gZxaFbc9XAbHTvZiRkBO85DhCQfIr82T4yfjLiINL07OMKZpc5HCG
         4MjCRL+MJ9gSjAYLMPohmavU9Qd90mcRWxDtiYFskSEKCR+KYJ+9YPN6HHuMzZWuxOf+
         zeUQyKc7zR+EpVaBN71QNZFZZ9zpPG2BaIvJoeHG88NjUer+Nljbg/Wy3/zUyCiydszO
         nKZTg7RdXe8HtEyggaInecNPZF7jpUsqFzmkDDfOEi3GHPDydxH2xUjrU3Nnf4diYtWk
         toJ944cj8H97flhjcLM0m2mTR6VyBh4FyQvKzb1txUoymO4C7OPt1tv5VASVboRti7l7
         YijA==
X-Gm-Message-State: AOAM532/RF3i3eT/YkR73Bom/CD6Lfb3OILX+I/Ng/gsWo7T5Pgl0Uh0
        2xyVXR0RXhrBHld31DoS9Pk=
X-Google-Smtp-Source: ABdhPJwTbYnZpHucJmBrMp3chIejQzLSFwfj5Dd6E/KIbytZQoDpMcgAh61CIxQSa4porDTUoYEahA==
X-Received: by 2002:a7b:cb4a:: with SMTP id v10mr1469901wmj.53.1620269186194;
        Wed, 05 May 2021 19:46:26 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id b8sm1767787wrx.15.2021.05.05.19.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 19:46:25 -0700 (PDT)
Date:   Thu, 6 May 2021 04:46:24 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] Add support for PCIe SSD status LED management
Message-ID: <20210506024624.GA182840@rocinante.localdomain>
References: <20210416192010.3197-1-stuart.w.hayes@gmail.com>
 <20210506014827.GA175453@rocinante.localdomain>
 <20210506023403.GB1187168@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210506023403.GB1187168@dhcp-10-100-145-180.wdc.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Keith,

> > > >cat /sys/class/leds/0000:88:00.0::pcie_ssd_status/supported_states
> > > ok                              0x0004 [ ]
> > > locate                          0x0008 [*]
> > > fail                            0x0010 [ ]
> > > rebuild                         0x0020 [ ]
> > > pfa                             0x0040 [ ]
> > > hotspare                        0x0080 [ ]
> > > criticalarray                   0x0100 [ ]
> > > failedarray                     0x0200 [ ]
> > > invaliddevice                   0x0400 [ ]
> > > disabled                        0x0800 [ ]
> > > --
> > > supported_states = 0x0008
> > > 
> > > >cat /sys/class/leds/0000:88:00.0::pcie_ssd_status/current_states
> > > locate                          0x0008 [ ]
> > 
> > As per what Keith already noted, this is a very elaborate output as far
> > as sysfs goes - very human-readable, but it would be complex to parse
> > should some software would be interested in showing this values in a way
> > or another.
> > 
> > I would propose output similar to this one:
> > 
> >   $ cat /sys/block/sda/queue/scheduler
> >   mq-deadline-nodefault [bfq] none
> > 
> > If you prefer to show the end-user a string, rather than a numeric
> > value.  This approach could support both the supported and current
> > states (similarly to how it works for the I/O scheduler), thus there
> > would be no need to duplicate the code between the two attributes.
> > 
> > What do you think?
> 
> Some enclosures may support just one blinky state at a time. Other
> implementations might have multiple LEDs and colors, so you could, for
> example, "locate" something that is also "failed", with both states
> visible simultaneously. You could capture the current states with the
> "scheduler" type display, but setting new states may be more
> complicated.

Ah, excellent point.  I didn't think about this - the use-case you
provided.  This would, indeed, be far more complex to deal with when
accepting a write.  I can see why Stuart did it the way he did
currently.

Krzysztof
