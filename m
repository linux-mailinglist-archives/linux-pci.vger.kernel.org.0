Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11428A696F
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2019 15:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfICNOS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Sep 2019 09:14:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56926 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbfICNOR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Sep 2019 09:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6h394cWq1+4srtB43ScQN+6skk/Nc2LDPA6V/gdTlrs=; b=jeFvzny2fL/AzCDPmn9DLAhqH
        hYdFmRjfm73A6y5ti7DfnB1GKdxfB6d7JIcX9XTV/ify68EeJsyw9OOswNnXv5s3ZQXTFzzAHkdH7
        XlGntZAGI/K5u4wjBmWmqv3mAV05XgKr0N9xeckACY6KUXXF7eTdnWrPpFfcoMY9PjZ/CadKyeNhx
        olRNL+4ey/qoWliwc65DtCbX/COSvbdKRL2HBeMIXByh1OSt02GayGxqf9aEB7McTJiJct3sFvdPY
        oCo9rdmSmvSzFgn0lTsFuiGUu/amUw+45mXgtxT6qNwIbOfe4WopDgk1zUSiOxiLoiirl2a5gQD2q
        k4nGC7qHw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i58dU-0007MJ-Rz; Tue, 03 Sep 2019 13:14:16 +0000
Date:   Tue, 3 Sep 2019 06:14:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Andrei Leonvikov <andreil499@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Fix ARI enabling for a NVME devices
Message-ID: <20190903131416.GA26756@infradead.org>
References: <20190903125315.10349-1-andreil499@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903125315.10349-1-andreil499@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 03, 2019 at 12:53:15PM +0000, Andrei Leonvikov wrote:
> +	if ((dev->driver != NULL) && (strncmp(dev->driver->name, "nvme", 4) == 0)) {
> +		// for NVME device this field always zero, but ARI can be enabled
> +		pcie_capability_read_dword(bridge, PCI_EXP_DEVCAP2, &cap);
> +		if (!(cap & PCI_EXP_DEVCAP2_ARI))
> +			return;
> +	}

Besides the missing patch description, all the obvious style issues, and
the fact that you can't just check a driver name a here:

There are plenty NVMe drives that support the ARI capability, and I
don't know of any standard saying nvme device should be treated special.
