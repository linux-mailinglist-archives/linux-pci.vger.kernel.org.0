Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5AB5C210C
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2019 14:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731031AbfI3M5x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 08:57:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55352 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731029AbfI3M5x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Sep 2019 08:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fARuBLyTR4HXeEN5GAQcRLDiqW1FdAZoSRGfWrgXFl0=; b=Ytnu72k/V9UtQKPbqK+bXZ/rC
        hPlBEZtRwO5KMbdq53efq3EoWOWDdzlnAEzTmTzRPWZqNqS2scAwPoBpOsC5W4lQOBNLGgrEtyDzK
        ERPuqlt6nM23+LogLxjefgJzSg5jkTQYfNghQ4xb6+6GtOpewBVmCChuKzYFvaZBOgMfK6DeKrOmt
        CjVTmncnXQELuEjaCVwh29wZDCy9UYncMyV2MGsQMELqzsZp15ZlivvYbqb9uiJsP4/WJvis3Wo/U
        cI6ryWc4LilQ9scvbdS0zvXJYytusVy4xRSStne/M++GTrfPwI0h/YJdggMOkOgE8J0Imz17qiJnt
        fz0+Z45Ig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iEvFQ-0007vv-1U; Mon, 30 Sep 2019 12:57:52 +0000
Date:   Mon, 30 Sep 2019 05:57:52 -0700
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
Subject: Re: [PATCH 05/11] of: Ratify of_dma_configure() interface
Message-ID: <20190930125752.GD12051@infradead.org>
References: <20190927002455.13169-1-robh@kernel.org>
 <20190927002455.13169-6-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927002455.13169-6-robh@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 26, 2019 at 07:24:49PM -0500, Rob Herring wrote:
> -int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
> +int of_dma_configure(struct device *dev, struct device_node *parent, bool force_dma)

This creates a > 80 char line.

>  {
>  	u64 dma_addr, paddr, size = 0;
>  	int ret;
>  	bool coherent;
>  	unsigned long offset;
>  	const struct iommu_ops *iommu;
> +	struct device_node *np;
>  	u64 mask;
>  
> +	np = dev->of_node;
> +	if (!np)
> +		np = parent;
> +	if (!np)
> +		return -ENODEV;

I have to say I find the older calling convention simpler to understand.
If we want to enforce the invariant I'd rather do that explicitly:

	if (dev->of_node && np != dev->of_node)
		return -EINVAL;
