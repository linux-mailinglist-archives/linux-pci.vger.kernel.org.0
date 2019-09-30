Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20E87C1D00
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2019 10:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbfI3IU5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 04:20:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43008 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729923AbfI3IU5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Sep 2019 04:20:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=If3yq1ODv3mmckOcV5bip4UCF3kVbPW2FQhUrotgaDI=; b=AN6E2r5+esnTrZkRBItKdRjse
        DHWl6KMtx8uvrMrd6Rm3NccrVdj8sgohG5IhvUu7yiSapvzR4zG/bp79mucxPjSJszkOKVpH8j+Tx
        2LjUq3ltPhxUC0kfPwVvE/2+q38SwH4IotQGcGmUr4Up6EtdRTQiZ0wvN21iKY4deDJKGwH+Nv2Il
        5HZKNU7KLYBypju4ygZ+GcaHczmiCKoY912aV98rRbc4Dnuh4t7KU3uSDZtsZ0InOTzuzjs+hLISZ
        5jXl5ucrYxXR2QxMdaSLYGmnw9DWtFeZwFoRF8dgR6/P6gEdioEZk6JQsrYYRYqhTGEevN4Kgr3OW
        yvuEbI6JA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iEqvP-000835-Nr; Mon, 30 Sep 2019 08:20:55 +0000
Date:   Mon, 30 Sep 2019 01:20:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Rob Herring <robh@kernel.org>, DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Oza Pawandeep <oza.oza@broadcom.com>,
        Christoph Hellwig <hch@infradead.org>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 00/11] of: dma-ranges fixes and improvements
Message-ID: <20190930082055.GA21971@infradead.org>
References: <20190927002455.13169-1-robh@kernel.org>
 <CAK8P3a0oct0EOMi5t4BmpgdkiBM+LjC+2pTST4hcvNCa3MGLmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0oct0EOMi5t4BmpgdkiBM+LjC+2pTST4hcvNCa3MGLmw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 29, 2019 at 01:16:20PM +0200, Arnd Bergmann wrote:
> On a semi-related note, Thierry asked about one aspect of the dma-ranges
> property recently, which is the behavior of dma_set_mask() and related
> functions when a driver sets a mask that is larger than the memory
> area in the bus-ranges but smaller than the available physical RAM.
> As I understood Thierry's problem and the current code, the generic
> dma_set_mask() will either reject the new mask entirely or override
> the mask set by of_dma_configure, but it fails to set a correct mask
> within the limitations of the parent bus in this case.

There days dma_set_mask will only reject a mask if it is too small
to be supported by the hardware.  Larger than required masks are now
always accepted.
