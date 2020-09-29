Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A555D27C24C
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 12:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbgI2KXq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 06:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgI2KXq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2020 06:23:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3841C061755;
        Tue, 29 Sep 2020 03:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sV4VNQCWQf29io+r4hg8Lpwxjuh7yXB+CYPd2yDqlSU=; b=h5hqc9q1wUCWghI2xM5pqKmCH4
        +T+uiRORJc1xBnxKtOvLt0fFWxluwC8GbWYQUbAx5+fYnsnSSc8X6vC1xh5ExI5ApC1fTkrPpjiIL
        dDKAvVgwqEzSm4iHMjfxOWjsbV1Pt9Pm2WEu2GnYQD4behHoN7AAL/0hCBAIaHJveKH5E4ZdIwwH4
        yWhIetW77lgCWeMrB2Il5/qoHKJuu9FP4roE8ql9gAE4Yhe2u4/aCOpUmqdC6VoCCqxWANxGzroIc
        VRWouUVPTGqHGDDQrqw7xJSo4bWgQ3jsY6a2sLQkViy9kd/qKvJRhzoIlxUxHLQJkUAyT5wbv5pV8
        hI+W24Bw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNCnF-0002GW-Dd; Tue, 29 Sep 2020 10:23:33 +0000
Date:   Tue, 29 Sep 2020 11:23:33 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     hch@infradead.org, sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, kishon@ti.com,
        lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH V2 1/4] misc: vop: change the way of allocating vring
Message-ID: <20200929102333.GA7784@infradead.org>
References: <20200929084425.24052-1-sherry.sun@nxp.com>
 <20200929084425.24052-2-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929084425.24052-2-sherry.sun@nxp.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> +		vr->va = dma_alloc_coherent(vop_dev(vdev), vr_size, &vr_addr, GFP_KERNEL);

Please stick to 80 character lines unless you have a really good
reason not to. 
