Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 140F78D1A1
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2019 12:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfHNK7Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Aug 2019 06:59:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37776 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfHNK7Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Aug 2019 06:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pgEYvZ1eHaerdck2Co4GVpTNOK0XG7sAjbhxzXDr3cg=; b=efd7BB7FFkItnlBI7w8GHVMsn
        4GIbgYe82811OaU8L8vno4ecf6DctuZmkjgAcU6XJogETY9aisqUqQE488gz+w6ob6S3d1wAiwFQg
        VF2ROeJuN5utdGVIF7F1coTOaAkq147leVOXWaxbv6bBEAGC4W4eRRIFWjr29Xkum22aa4xNgzaJ4
        6LoNx/XH7TJAT23Zj9p1D2qRrgkFYTbhidlPp5R0TNxA4uZra5pt2DxXui0OpetIfeUIdz4CWfSo+
        i2Wus477698g9LqAJiAruVKH/i03lJAoiAlqD/SilFQBOEVuE1m8s6PgWplVESN5T7c3Rz1xe1Oel
        jHfRRPE/A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxqzy-00032b-R3; Wed, 14 Aug 2019 10:59:22 +0000
Date:   Wed, 14 Aug 2019 03:59:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com
Subject: Re: [PATCH] PCI: dwc: Add map irq callback
Message-ID: <20190814105922.GA11568@infradead.org>
References: <333e87c8ea92cd7442fbe874fc8c9eccabc62f58.1565763869.git.eswara.kota@linux.intel.com>
 <20190814073605.GA31526@infradead.org>
 <fe722a89-37e7-9ef6-042b-a9584f234740@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe722a89-37e7-9ef6-042b-a9584f234740@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 14, 2019 at 04:31:14PM +0800, Dilip Kota wrote:
> > callback.
> pp->map_irq() must assign the callback along with the platform specific
> configuration.
> In Intel PCIe driver pp->map_irq() does the same. (Driver is not yet present
> in mainline, i will submit for review once this change is approved).

And that's what I meant.  The standard procedure is to submit your
core changes together with the user, not separately.
