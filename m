Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76738EA5A8
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2019 22:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfJ3Vpu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Oct 2019 17:45:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40582 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfJ3Vpu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Oct 2019 17:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5D45zdPgzpjQNOnSx9aM0/fseA7MNMJnB+IytBClieU=; b=J6LQ7VfSbXoLVh2AfMxxcO5Ev
        jMDlrS4Ga6c/bK5wkesrM/ljWY1/1S5YWScBxAN2ddfoZzb2UAa1+vfsYmLJHpKW5LMmMFnQg4O1t
        jcwa01gjs5mPo+dmI7jZ+KaiMmeqraf9LHhGdbSWN81n+7Ftl5/XFyFPluIdrhfXeP9f1SftrZcMr
        32kIDpWcXB66sykrfrNRquYu7JVjRfOlh5GWXj7BPLnQwtqA+bVyuQTPurT0PxttnT/iVJH5xcYkU
        S/1YcFyQceL8gp6n7NNZmcy74XDc8aWurib+AgQxIRdiwwJD5M9qztlbyM8Uf1Fl+FV6i8zz4BQsb
        l4VnhbfnQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPvmm-0003lk-5A; Wed, 30 Oct 2019 21:45:48 +0000
Date:   Wed, 30 Oct 2019 14:45:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     rubini@gnudd.com, hch@infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, helgaas@kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/2] x86/PCI: sta2x11: use default DMA address
 translation
Message-ID: <20191030214548.GC25515@infradead.org>
References: <20191018110044.22062-1-nsaenzjulienne@suse.de>
 <20191018110044.22062-3-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018110044.22062-3-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 18, 2019 at 01:00:44PM +0200, Nicolas Saenz Julienne wrote:
> The devices found behind this PCIe chip have unusual DMA mapping
> constraints as there is an AMBA interconnect placed in between them and
> the different PCI endpoints. The offset between physical memory
> addresses and AMBA's view is provided by reading a PCI config register,
> which is saved and used whenever DMA mapping is needed.
> 
> It turns out that this DMA setup can be represented by properly setting
> 'dma_pfn_offset', 'dma_bus_mask' and 'dma_mask' during the PCI device
> enable fixup. And ultimately allows us to get rid of this device's
> custom DMA functions.
> 
> Aside from the code deletion and DMA setup, sta2x11_pdev_to_mapping() is
> moved to avoid warnings whenever CONFIG_PM is not enabled.

Looks sensible to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But I can't tested it either, and kinda wonder if this code is actually
still used by anyone..
