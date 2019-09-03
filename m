Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82AEAA6F98
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2019 18:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730714AbfICQde (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Sep 2019 12:33:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38984 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730823AbfICQdc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Sep 2019 12:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=E7M5OHCPCFGvSidMPlknkuDvFUT36qFbZFw1uswvZFM=; b=gXA92M+qRj1oJOmfHj6Hbgihwb
        cXmqRb2s7gGx0C3dDRwlGKMVyI6YboNSetcl7skx30OYn1TxPXw1SYH1oVICQI+ywmWooxbiZ7GMF
        QJg1x4zpoXkD7fjvz5f5bU9LLFTSO4JXBhcAt+N2PBRJBPrl76Ifgm7fAL5ZUIe8cfQ0el5gFkSqS
        6hUqq3sLNdf68QBmQPzxIA1u1VMnfMiyGe9mCq8q/wPxumMAvikntDCAkUnnoku6Te9C4D1SdlDu9
        ZA9J1RytDuqMtBsvyAbh0aQOBCUoe5358UC5SYyR9PqdJHoSR6tVDOGYCGzmS99eScsOwkm+2z9cO
        HKkGg5rA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i5BkJ-0003C9-U1; Tue, 03 Sep 2019 16:33:31 +0000
Date:   Tue, 3 Sep 2019 09:33:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     =?utf-8?B?0JDQvdC00YDQtdC5INCb0LXQvtC90YfQuNC60L7Qsg==?= 
        <andreil499@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrei Leonchikov <andreil499@gmail.com>
Subject: Re: [PATCH 1/1] Fix ARI enabling for a NVME devices
Message-ID: <20190903163331.GA32703@infradead.org>
References: <20190903125315.10349-1-andreil499@gmail.com>
 <20190903131416.GA26756@infradead.org>
 <CA+kE0xQ+z4f8xQ=8oRVcTMC-VsU5dyqVUWxuDamTy59_HTYOeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+kE0xQ+z4f8xQ=8oRVcTMC-VsU5dyqVUWxuDamTy59_HTYOeg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[adding back the Cc list]

On Tue, Sep 03, 2019 at 07:24:15PM +0300, Андрей Леончиков wrote:
> All drives has ARI capability, but everywhere the PCI_EXP_DEVCAP2_ARI
> in the DEVCAP2 register is reset (see NVMe specification, bit 5).
> At the same time, when the device is initialized, the DEVSAP register is
> requested and this bit is checked. And if it is reset, ARI will never turn
> on.
> Because of this, it will be impossible to correctly initialize more than 8
> functions per interface (1 physical and 7 virtual).
> At the moment we are developing a disk, one of the requirements for
> which is the correct operation of up to 128 virtual functions on one
> interface.
> During testing of this device, this behavior was noticed.

Looking at the PCIe spec this bit actually means "ARI forwarding
supported" and isn't the actual ARI support.  And the PCIe spec says
about that:

"Applicable only to Switch
Downstream Ports and Root Ports; must be 0b for other
Function types. This bit must be set to 1b if a Switch
Downstream Port or Root Port supports this optional capability.
See Section 6.13 for additional details."

So I don't see how we'd ever see this bit set on an actual NVMe device.

And yes, the name for our define is a little misnamed.
