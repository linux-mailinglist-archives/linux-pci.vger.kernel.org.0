Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C7541C9E2
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 18:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345526AbhI2QQV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 12:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345129AbhI2QQQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 12:16:16 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4397BC061764
        for <linux-pci@vger.kernel.org>; Wed, 29 Sep 2021 09:14:35 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id t2so2799033qtx.8
        for <linux-pci@vger.kernel.org>; Wed, 29 Sep 2021 09:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2/DOweLZi1LYkI2NBZkoCxBZv2x+eGa4aLJUobv2L1o=;
        b=PboCFsQCjD2723LhLYT/hgjkJdWoO/Qr7CahpEILXMofMHRSJifpiRAfKU1XinqG67
         AhaKbB8c6M8JSRC5xiTi7/mAm/tA9MPNU7KxHCJwsT3TcNZEvni9gIYQHpEE2twn3Lb1
         XEQAd+awFGQvrjYTvZmCM8JGYWsNB3RPHyweKekQKlu0doslil+cuRJjDW4QCgq+lEPM
         +n+cIMyeEp1R/IhkNJfh1Av4WkSJThIfSSnZIbzDvJEu3PUwI3+Rbi/hzxYhv46mrVo4
         C2Ww+6AXHWKS7AbB4UjQ/vimBLFOVmr7X6zBKKsORWg5TkRoxZSArV+Enk/yQJYpQidO
         Yk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2/DOweLZi1LYkI2NBZkoCxBZv2x+eGa4aLJUobv2L1o=;
        b=obyz7Jw75wezq+87xAjLcBQBM32QVA/RC+rqopeWl8bFEuwDj8FuMlyGQUhn4nS2CY
         zXU4wNN4Hb0YvyRGjmlFwCXAd+ZIR7IfRxDpIjJVMbExq2+FIi7gRG5hvW1ZcujQeKW2
         DuSOZFb835BrQGcKE36kaAz/4LbQz8g47Z0OdPx50L8Ffx7/uYq/AvgNw/kYY68YUzWy
         npa+PT5PDK4QADv5SfoId3pjHlRy/BwiDcJMZpumZSfuzaoyjvit62kZpihUPPuzFGXm
         CpD8J760dmhDRQ0ILWjByxa3o+gtuBOOjj3jKUgjjBzB1Y5gvzKaMXIGjdohnShS7jgd
         hmHA==
X-Gm-Message-State: AOAM5307hMIwBmX3mbAKxDqDbO+0Jzc/p/LsvjQ89A9FloFpUb6ssing
        VhwiKYclpw4LlWnTUHDiaJ1fPw==
X-Google-Smtp-Source: ABdhPJz3genm3m/pxNLME0A8yc2mxcvVNovagYhEOWLyS+VtXcmuaVaqUzXPZnkRrIL56CYjTIjNqA==
X-Received: by 2002:ac8:610f:: with SMTP id a15mr758684qtm.387.1632932074489;
        Wed, 29 Sep 2021 09:14:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id v17sm163354qkp.75.2021.09.29.09.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 09:14:33 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mVcE5-007cDu-62; Wed, 29 Sep 2021 13:14:33 -0300
Date:   Wed, 29 Sep 2021 13:14:33 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Kirti Wankhede <kwankhede@nvidia.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH mlx5-next 2/7] vfio: Add an API to check migration state
 transition validity
Message-ID: <20210929161433.GA1808627@ziepe.ca>
References: <c87f55d6fec77a22b110d3c9611744e6b28bba46.1632305919.git.leonro@nvidia.com>
 <20210927164648.1e2d49ac.alex.williamson@redhat.com>
 <20210927231239.GE3544071@ziepe.ca>
 <25c97be6-eb4a-fdc8-3ac1-5628073f0214@nvidia.com>
 <20210929063551.47590fbb.alex.williamson@redhat.com>
 <1eba059c-4743-4675-9f72-1a26b8f3c0f6@nvidia.com>
 <20210929075019.48d07deb.alex.williamson@redhat.com>
 <d2e94241-a146-c57d-cf81-8b7d8d00e62d@nvidia.com>
 <20210929091712.6390141c.alex.williamson@redhat.com>
 <e1ba006f-f181-0b89-822d-890396e81c7b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1ba006f-f181-0b89-822d-890396e81c7b@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 29, 2021 at 06:28:44PM +0300, Max Gurtovoy wrote:

> > So you have a device that's actively modifying its internal state,
> > performing I/O, including DMA (thereby dirtying VM memory), all while
> > in the _STOP state?  And you don't see this as a problem?
> 
> I don't see how is it different from vfio-pci situation.

vfio-pci provides no way to observe the migration state. It isn't
"000b"

> Maybe we need to rename STOP state. We can call it READY or LIVE or
> NON_MIGRATION_STATE.

It was a poor choice to use 000b as stop, but it doesn't really
matter. The mlx5 driver should just pre-init this readable to running.

Jason
