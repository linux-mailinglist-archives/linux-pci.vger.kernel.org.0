Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57099C20F4
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2019 14:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbfI3Mxo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 08:53:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50726 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729914AbfI3Mxo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Sep 2019 08:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0uRDM7LscqyGGmgD0X4C8lR+d/8Zk+ETfC2SdYfM5aE=; b=WQaz/vv1sTqRFrAWlD1a2kUpb
        wmyRXGJ1qL9FvQRY9ueLVEqtaBlwLAYpSTy4WEQJBiDJq/0ZXJz8KlRJz/cxeg7D5bF++ihyaXYpb
        OmMQw4tzjMsWrqkV30WWZ822ejO/aa4zihF7C9oD2OM+zOpFAOfu3GoZyn1383zuDp15GKcs136qI
        KDGdKilkA29X5p7gEiV/zthlmC/AZMhHtjjXXnMJ8TbjkLtV/AI9ZR8ihLr78fUyKN9RMXBzX6pxN
        yxitnhDHikq5JnunQy3SJ0iKWWaSxIrZ7ErtfyCiQOVuhwQJ6c0Caw3dxtBGuV+5Jz4g8B4kSYkEF
        X1N0z7zaQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iEvBP-0005jM-NT; Mon, 30 Sep 2019 12:53:43 +0000
Date:   Mon, 30 Sep 2019 05:53:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Oza Pawandeep <oza.oza@broadcom.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Robin Murphy <robin.murphy@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH 02/11] of: Make of_dma_get_range() private
Message-ID: <20190930125343.GB12051@infradead.org>
References: <20190927002455.13169-1-robh@kernel.org>
 <20190927002455.13169-3-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927002455.13169-3-robh@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> +#ifdef CONFIG_OF_ADDRESS
> +extern int of_dma_get_range(struct device_node *np, u64 *dma_addr,
> +			    u64 *paddr, u64 *size);

No need for the extern here.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
