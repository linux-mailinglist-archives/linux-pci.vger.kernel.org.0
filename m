Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163CA34AEE6
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 20:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhCZTCM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 15:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhCZTBv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Mar 2021 15:01:51 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABEEC0613AA
        for <linux-pci@vger.kernel.org>; Fri, 26 Mar 2021 12:01:50 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id g8so3472741qvx.1
        for <linux-pci@vger.kernel.org>; Fri, 26 Mar 2021 12:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BAL0m/RHqxQpdmmLPAQhvtUtUkOGClZd+wtpp5eE3NI=;
        b=e7BHdcfCRu7gzQTQZeMe5siu0dEHGNMUdl5PWrnXSxdwPxWx6GhTKar0U60CJTBeUr
         KoLT0xWW8jIbV4lsZ5XySyARgV3WePqBpemdS5Lp+XvaL2+P/oBXBXI/egBXpNBVHnTf
         70HLSuF0eTtQVYDJthloPsId7LIGJ8GwuwDU8SMNv9JJMkTWUg07pZ00ZRChYsLb0Axd
         lMjJQ7tdF8Ds4Ra6Rpt/vG79i04x2IFiHfZPyBtnmpdQHQCGSGSgnCwgWZtOBert80o6
         a1KmaESeGe9KKy9AcD1KLsy35zf8LMTiKBoNzkahJ6jWrQ2qafE6hMY5stk3iDxGQ+PA
         K13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BAL0m/RHqxQpdmmLPAQhvtUtUkOGClZd+wtpp5eE3NI=;
        b=qJWVndtWuUyTWDOT8vY8yjEZy15G24Tm2it4qGdrKRVmQhRwuaNkAKUrs5Ej/e5ecJ
         M0hm341cVSZLyYMGqNa5vs8oRpBBwaeSRLJRTCkb6JVFG/A4xgELMOpc08vVaipFC3Bh
         c91gkdv1zCASaOqMDwO78k9zW8EajXS1MbWyWuUX/dv/3eQiD+b9KU/E+/g0ZAwkGAxr
         NGE0LNXpK50XD7QJKpx5ohcKpmDW6Md+lkiIPs5yiOI8IrudDMpaL6uQvKRzWcsLua0F
         9yee0wW3RAeudzZpJQf5hSbwipnBYki2fQKAdTej/knC8l7/+ZBFZbauDjvBWMJ5hRTi
         Ostg==
X-Gm-Message-State: AOAM532wCq9CSRjm+Q/RlcUvKO8GBtnmr7g5TNqq6CO8Q0D3HNl7GxAA
        cgUaqh8P6wH2LJdh9crm1sKaOg==
X-Google-Smtp-Source: ABdhPJyPPROj/duhNJKoNUDXx1x3dnnvxm/V4m5aDR//p8MIcbL4trIZyfZVH2nljvSUZ016XrlnTA==
X-Received: by 2002:a05:6214:12a1:: with SMTP id w1mr15062105qvu.57.1616785310073;
        Fri, 26 Mar 2021 12:01:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id z11sm7442877qkg.52.2021.03.26.12.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 12:01:49 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lPriO-003mMa-JQ; Fri, 26 Mar 2021 16:01:48 -0300
Date:   Fri, 26 Mar 2021 16:01:48 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-rdma@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        Don Dutile <ddutile@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH mlx5-next v7 0/4] Dynamically assign MSI-X vectors count
Message-ID: <20210326190148.GN2710221@ziepe.ca>
References: <CAKgT0UfK3eTYH+hRRC0FcL0rdncKJi=6h5j6MN0uDA98cHCb9A@mail.gmail.com>
 <20210326170831.GA890834@bjorn-Precision-5520>
 <CAKgT0UcXwNKDSP2ciEjM2AWj2xOZwBxkPCdzkUqDKAMtvTTKPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UcXwNKDSP2ciEjM2AWj2xOZwBxkPCdzkUqDKAMtvTTKPg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 26, 2021 at 11:50:44AM -0700, Alexander Duyck wrote:

> My concern would be that we are defining the user space interface.
> Once we have this working as a single operation I could see us having
> to support it that way going forward as somebody will script something
> not expecting an "offline" sysfs file, and the complaint would be that
> we are breaking userspace if we require the use of an "offline"
> file.

Well, we wouldn't do that. The semantic we define here is that the
msix_count interface 'auto-offlines' if that is what is required. If
we add some formal offline someday then 'auto-offline' would be a NOP
when the device is offline and do the same online/offline sequence as
today if it isn't.

> I almost wonder if it wouldn't make sense to just partition this up to
> handle flexible resources in the future. Maybe something like having
> the directory setup such that you have "sriov_resources/msix/" and

This is supposed to be about PCI properties, that is why we are doing
it in the PCI layer.

If you want to see something that handles non-PCI properties too then
Leon needs to make the whole thing general so the device driver can
give a list of properties it wants to configure and the core manages
the thing.

But at that point, why involve the PCI core in the first place? Just
put the complex configuration in the driver, use configfs or devlink
or nvmecli or whatever is appropriate.

And we are doing that too, there will also be pre-driver configuration
in devlink for *non PCI* properties. *shrug*

Jason
