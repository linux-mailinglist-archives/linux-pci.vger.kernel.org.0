Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC82F796C
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2019 18:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfKKRDn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Nov 2019 12:03:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39994 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKKRDn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Nov 2019 12:03:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jJ2XSvmWYSjH8U6K0+cFtVLMQGHVRVlZ4wb+eJcs2bM=; b=nTy5/J5uQXmgXT+1+meEgmTgk
        nnyQfpjO2QGevTyl3/hTL0I2Koi3cmSrTVF7BUorhPZKaE5uhy662x8TNptxqnuR91U6XDYT40Ocf
        3bG3ui4+MdL8a3mpsVLGBO3Td0CZ5AVOjddPs58Kyt0WQZu/8Rp0WYq0UI7pde8hnhPcXyZzWKfWA
        /eiTfW2E4pwg9Y6AFjPg4fTkdGo5N46BZTaD1XxxZUAxdv79kBMNbeHjUBWaD1BJ7fYeoxCHZd7vl
        NQumPCDdcvcopw2Jwj8DRHjb0b00RIhKLDZlFUnc9vh8+mIxFatKHthRxHjPUESO07J3h4o4ZsHwx
        1yZHdRSxg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUD6K-00076k-EO; Mon, 11 Nov 2019 17:03:40 +0000
Date:   Mon, 11 Nov 2019 09:03:40 -0800
From:   "hch@infradead.org" <hch@infradead.org>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH 0/3] PCI: vmd: Reducing tail latency by affining to the
 storage stack
Message-ID: <20191111170340.GA26474@infradead.org>
References: <1573040408-3831-1-git-send-email-jonathan.derrick@intel.com>
 <20191107093952.GA13826@infradead.org>
 <bfc69a54dc394ffb7580d14818047ec6a647536f.camel@intel.com>
 <20191107153736.GA16006@infradead.org>
 <c0d62e0f1f8d1d6f31b2a63757aad471ced1df28.camel@intel.com>
 <20191107154224.GA26224@infradead.org>
 <784d25a41399472e80a0b384f88eccab29b01cc1.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <784d25a41399472e80a0b384f88eccab29b01cc1.camel@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 07, 2019 at 03:47:09PM +0000, Derrick, Jonathan wrote:
> A cloud service provider might have several VMs on a single system and
> wish to provide surprise hotplug functionality within the guests so
> that they don't need to bring the whole server down or migrate VMs in
> order to swap disks.

And how does the vmd mechanism help with that?  Maybe qemu is missing
a memremap to not access the remove device right now, but adding that
is way simpler than having to deal with a device that makes everyones
life complicated.

