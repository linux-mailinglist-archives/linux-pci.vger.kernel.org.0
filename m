Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B05C189601
	for <lists+linux-pci@lfdr.de>; Wed, 18 Mar 2020 07:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgCRGvV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Mar 2020 02:51:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54110 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgCRGvV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Mar 2020 02:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HU3OpK2WrMDnYBFQ0mcXfjSZpfmRV36qu/4VljNG5ig=; b=UUXNx2bLZbq9R2xgMp9+ZXf/X4
        5Y+ZcxwA5J8Qu83bkUjfw6NDUo/6/Ee3tU+fekoobfS2QyzjaXVBj8QWHxwtVFruT9IJTVY3d/VAa
        TyrHpyWfCH2IpQqZOCOSO98nIjaGm9Mvx4p1pt4dHj3G742mLzfMeEGXUHGbR8n1bptovK2IXCRGE
        iYOSzb0xzMa2LFb6S0N4C7H3GWyk5G+gH/YNhpDN1xbjAvlSRYTgBvqgUTf8Aj/hajO3Jm4Fueu8e
        Lt4wQNZht/RT3UAH1cIoXhHVTHkFWmFXlOXBDJA0Vx6M2C85qYjQg8HMb3bfsyEimY+kNbe7CQ+3G
        JJ3JhzlA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jESXv-00059Q-PA; Wed, 18 Mar 2020 06:51:19 +0000
Date:   Tue, 17 Mar 2020 23:51:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mikel Rychliski <mikel@mikelr.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org,
        nouveau@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH RESEND v2 2/2] PCI: Use ioremap(), not phys_to_virt() for
 platform ROM
Message-ID: <20200318065119.GA14425@infradead.org>
References: <20200313222258.15659-1-mikel@mikelr.com>
 <20200313222258.15659-3-mikel@mikelr.com>
 <20200317144731.GG23471@infradead.org>
 <49518530.5kixuQOrMm@glidewell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49518530.5kixuQOrMm@glidewell>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 17, 2020 at 09:34:33PM -0400, Mikel Rychliski wrote:
> I think the direct access to pdev->rom you suggest makes sense, especially 
> because users of the pci_platform_rom() are exposed to the fact that it just 
> calls ioremap().
> 
> I decided against wrapping the iounmap() with a pci_unmap_platform_rom(), but 
> I didn't apply the same consideration to the existing function.
> 
> How about something like this (with pci_platform_rom() removed)?

That looks sensible to me.
