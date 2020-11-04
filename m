Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CB42A6C82
	for <lists+linux-pci@lfdr.de>; Wed,  4 Nov 2020 19:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbgKDSLA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Nov 2020 13:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730245AbgKDSLA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2020 13:11:00 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136B6C0613D4
        for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2020 10:11:00 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id f93so12824704qtb.10
        for <linux-pci@vger.kernel.org>; Wed, 04 Nov 2020 10:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k0O2tryRBN/txl6awTV8eKioqjAa/NAL5VwW/RaREWI=;
        b=CrqhrkR7HAzUAGqSb60bOMK7qe5EIflczymnySw9Y5+bNjne9otfjktFQ6v+q7J5Bn
         QkYEsfvJoF/V7dNVQyc6aFNIdKrN1rYxwz6brltfl3vKl7GrhGkHBfbp/rhIGXnZsDyO
         q/iG27QnRKzRiEukn1JBcRUnjZMZ/Ak9n8ACm1EiTKdWPIltBuEFSSjrXyLFHI9ot/JV
         8uBpfDuI13wJ7vALHBveYCdpbk+A19p4Bv4z46ArjZXEgsqRrdu1kwYS320gfNeLMlWW
         W2r30op0NjtAJ7YPSSK/BVYOYThngPwmUNlHggeP4WiKmejHxYofVLU4IlsEUP8nocyW
         gCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k0O2tryRBN/txl6awTV8eKioqjAa/NAL5VwW/RaREWI=;
        b=GuuycjHYYXPCIzVmMx+OKq4pllcsK5YWmN3AYyhwXjc19FWAny6y0gDmmQQ4fRpyiw
         Nydn/7Y25hdCrZ9S62Rhd7WAGuOaHsArBbmnYHAsKAb15MI4JRSj8ekBr2h3iobScH7r
         NAE1WfPn1Xg8DKI/olbUxEPNitGCobJqOC9fkaYvb2L3UQCAWjawnrPpctf3ccobDSRM
         JuqhYKtbJhs1iQ0TM5YNEQg3lgd8DVqS/Rkd+mBqPSB3Q4WkmZQL9OQxKyu3+qsD+bdQ
         4+VeY7sQk7lyBgOLFxUEcpqck2w88usxQ9drhzos/LjsM5W/8lNM4hktKcA+iX0whgEz
         ci9w==
X-Gm-Message-State: AOAM530ihQ9fw+V77LjdU7pLPq+YhsNn0EywPHej6nk6Rb/gJFLvjN3G
        L7xmOBRZGNNP9kN9tDPyYBdE5BzIy02mHAEw
X-Google-Smtp-Source: ABdhPJwkADJ1e/NwsQb+VIyXw9DQ2vEHkyjUPuy8BExU4QQfjYg+akP04U4TisV1zRg4p7BfBzttTQ==
X-Received: by 2002:aed:2d82:: with SMTP id i2mr10942501qtd.10.1604513459358;
        Wed, 04 Nov 2020 10:10:59 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id h65sm969050qkd.95.2020.11.04.10.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 10:10:58 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kaNFJ-00GaMz-NI; Wed, 04 Nov 2020 14:10:57 -0400
Date:   Wed, 4 Nov 2020 14:10:57 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: Re: [PATCH 2/5] RDMA/core: remove use of dma_virt_ops
Message-ID: <20201104181057.GT36674@ziepe.ca>
References: <20201104140108.GA5674@lst.de>
 <20201104095052.1222754-1-hch@lst.de>
 <20201104095052.1222754-3-hch@lst.de>
 <20201104134241.GP36674@ziepe.ca>
 <OFFDBE80DE.245A259C-ON00258616.00528DDA-00258616.00533A9D@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFFDBE80DE.245A259C-ON00258616.00528DDA-00258616.00533A9D@notes.na.collabserv.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 04, 2020 at 03:09:04PM +0000, Bernard Metzler wrote:

> lkey of zero to pass a physical buffer, only allowed for
> kernel applications? Very nice idea I think.

It already exists, it is called the local_dma_lkey, just set
IB_DEVICE_LOCAL_DMA_LKEY and provide the value you want to use
in device->local_dma_lkey

> btw.
> It would even get the vain blessing of the old IETF RDMA
> verbs draft ;)
> 
> https://tools.ietf.org/html/draft-hilland-rddp-verbs-00#page-90

IBTA standadized this, they just didn't require HW to use 0 as the
lkey.

Jason
