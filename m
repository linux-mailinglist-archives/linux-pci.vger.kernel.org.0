Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3861A5D30
	for <lists+linux-pci@lfdr.de>; Sun, 12 Apr 2020 09:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbgDLHfl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 Apr 2020 03:35:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52234 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgDLHfl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 Apr 2020 03:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ScwCZOvLyFziUiTE/s7lRo5HTwcGZHzgW4gqUCQQOG8=; b=PQNuB55FuOufIMCAs4l9mm4Pvl
        S39LPeZmPYgk9QUS9N6fe86vpkL6cVTqOlL0YxrW5Y6YqG9ZBnRxdkUpfXHRIRKbaEKPgaa+gU+FW
        oQgOHguDt5aMYpvsNP2RAOU9Y7E5r0LTejc6Lr1yoQm4Jf+LUvuW3Gyb1SI4Yseu6nD3b7X2NOmUt
        41uMp06oHzCWbd0XYIFVP6aW32sl7LbpnWIY+4pFVlWgkyqfTbCey1pSGbaojkiKC/ymwtFINeJdS
        xw1lDAKFFi8fT5n2NdiMIVLHsvfwxk9HyA14BDDB43+6SreqF8mTPnYM3gk1nV5D/Dee3YeS3Y9hC
        Ykeaoddw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jNX9N-0000Km-Ah; Sun, 12 Apr 2020 07:35:29 +0000
Date:   Sun, 12 Apr 2020 00:35:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniel Drake <drake@endlessm.com>
Cc:     Jon Derrick <jonathan.derrick@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Linux Upstreaming Team <linux@endlessm.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: use DMA domain for real DMA devices and
 subdevices
Message-ID: <20200412073529.GA13784@infradead.org>
References: <20200409191736.6233-1-jonathan.derrick@intel.com>
 <20200409191736.6233-2-jonathan.derrick@intel.com>
 <CAD8Lp442LO1Sq5xpKOaRUKLsEyGbou4TiHQrDdnMbCOV-TG0+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD8Lp442LO1Sq5xpKOaRUKLsEyGbou4TiHQrDdnMbCOV-TG0+g@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Apr 12, 2020 at 11:50:09AM +0800, Daniel Drake wrote:
> > different addressing capabilities and some require translation. Instead we can
> > put the real DMA dev and any subdevices on the DMA domain. This change assigns
> > subdevices to the DMA domain, and moves the real DMA device to the DMA domain
> > if necessary.
> 
> Have you tested this with the real DMA device in identity mode?
> It is not quite working for me. (Again, I'm not using VMD here, but
> have looked closely and believe we're working under the same
> constraints)

So if you are not using VMD how does this matter for upstream?
