Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63099254014
	for <lists+linux-pci@lfdr.de>; Thu, 27 Aug 2020 10:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgH0IBp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Aug 2020 04:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbgH0IBp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Aug 2020 04:01:45 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33FCC061264
        for <linux-pci@vger.kernel.org>; Thu, 27 Aug 2020 01:01:44 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id s19so1092300eju.6
        for <linux-pci@vger.kernel.org>; Thu, 27 Aug 2020 01:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KLXKGCMrEd+HEPdG/6Veb0H0KiwUV4QwzjuW5uI1H7Y=;
        b=lksoy1NDScckuAYD4sTllL1Iurtev0e+pvnwfQDJMxCxa7JLt2eW5ZALN6jCFFbZwt
         rnEIqFZ/Kn7iFNQBzR0yn6m4899J5aaMisCuWUNBKBwGamGybczhroFIaIi7M4S6KV5c
         S+kw8klrcatEGIZexnu+yfdz1Z8LWp5yN2mGP2UZC2fgzT1VNci0x8Xk2e6UkXtkY3Xz
         tckKKot1hODrYWrRvUV2p46fu3xJLkQSm2MOsm3V+N4oOz00v50T77zCoYVtf5I2MypU
         G0P7T05k6eFA6lGOrHA5r0uEGiMiQ7ECn6imLPHHN+m6uzMSJMTGSN11V00WRZOer7LJ
         SfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KLXKGCMrEd+HEPdG/6Veb0H0KiwUV4QwzjuW5uI1H7Y=;
        b=pq9Wv4lh00jf1P/XJfSwZKTa4pDtxvOsJHtIKwfe9GNEaQ2N6jzNnA+uu9pHOynBrK
         B2hZ0ZL/K1nSE/btg0bVNvceTEAvk8sczW1dj9D1IZ1eXWqK/ftVnuPAZskxRRDXGz0B
         HO0YjroXetgOTWdLstOs4I4P/QgkSVKX8xJii1IKtLOFWnTSjJA/G9ATDRAm3i0gWYh3
         XuogaGsyfY3W9+cXOusoUnghoRHJhK7lQT3xECy948VWTUQOKoP3gzA0yXThShDkWNFO
         mNQPV0LQ7b6IPI3ed2D+MqxbSxZCFTpXKijKBAN0pGSGnJEFtGVlICtXmhhGXs0v1KZq
         kDtA==
X-Gm-Message-State: AOAM533Uqg7LH3LLImco8DrlZB0a+rlkUDPdLFOAimZNJg1xZkcEsvNv
        H4ofewU0MzfbmrkfNAdyy9En1Ms3slMeoQ==
X-Google-Smtp-Source: ABdhPJy3u3bRyTUX8lEQynqXU4hAdCiT/PYeb2x0IdTm6vsd6r4sfZTB0YNbGlWTbOWqcKJT0ea+2Q==
X-Received: by 2002:a17:906:fa15:: with SMTP id lo21mr20503865ejb.42.1598515303348;
        Thu, 27 Aug 2020 01:01:43 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id i25sm954760edt.1.2020.08.27.01.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 01:01:42 -0700 (PDT)
Date:   Thu, 27 Aug 2020 10:01:25 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org,
        kevin.tian@intel.com, sebastien.boeuf@intel.com,
        bhelgaas@google.com, jasowang@redhat.com
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Message-ID: <20200827080125.GC3399702@myrica>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <20200826092542-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826092542-mutt-send-email-mst@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 26, 2020 at 09:26:02AM -0400, Michael S. Tsirkin wrote:
> On Fri, Aug 21, 2020 at 03:15:34PM +0200, Jean-Philippe Brucker wrote:
> > Add a topology description to the virtio-iommu driver and enable x86
> > platforms.
> > 
> > Since [v2] we have made some progress on adding ACPI support for
> > virtio-iommu, which is the preferred boot method on x86. It will be a
> > new vendor-agnostic table describing para-virtual topologies in a
> > minimal format. However some platforms don't use either ACPI or DT for
> > booting (for example microvm), and will need the alternative topology
> > description method proposed here. In addition, since the process to get
> > a new ACPI table will take a long time, this provides a boot method even
> > to ACPI-based platforms, if only temporarily for testing and
> > development.
> 
> OK should I park this in next now? Seems appropriate ...

Yes that sounds like a good idea. It could uncover new bugs since there is
more automated testing happening for x86.

Thanks,
Jean
