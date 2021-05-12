Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6814037B6C9
	for <lists+linux-pci@lfdr.de>; Wed, 12 May 2021 09:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhELHYQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 May 2021 03:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhELHYP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 May 2021 03:24:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27E7C061574
        for <linux-pci@vger.kernel.org>; Wed, 12 May 2021 00:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=w0OefE2cE/yG1n3YZPo1nGxYNb+j7j3fnzGbjcZwh6Y=; b=q4dDhh6pDneFL9E7Pov/vCfoA4
        +kxxGO51T++BlaAdFpDU1kvBAmnzIQ3GpTrKOxjr0bjrM9I3uVUmr809TPvwA3WZ3hsKACwe6rFml
        Bdj7g3srgUpA3Tcu2harofHBu9JmXwomrqCeYoanvwH6XPTInp0iJWKy3c7gUP5bONQoLZKIj/O54
        B+4klvBLUZchiYkyu0PcF9t7akoi61lxVWK4RKUJI6CsLC4wVfM0UCt+Sxho5m6Dw30uOOIp1HVo+
        ZHbltWv5Danz3mySX2xDWZGytlOmLNzt0E+trgA/oc4DZaCpFOzZ2NFGLXC9x5LAHG/WPvZVFn95H
        0cU/2tsg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgjBn-0083Oy-0s; Wed, 12 May 2021 07:21:58 +0000
Date:   Wed, 12 May 2021 08:21:51 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2] PCI/VPD: Use unaligned access helpers in pci_vpd_read
Message-ID: <YJuCD9WCpV+rViys@infradead.org>
References: <5719b91c-9f91-0029-0a28-386f1cb29d31@gmail.com>
 <YJjUWulw8vkscdwg@infradead.org>
 <26a9b3ec-07dc-c474-25ad-d7082060d305@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26a9b3ec-07dc-c474-25ad-d7082060d305@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 10, 2021 at 09:09:02AM +0200, Heiner Kallweit wrote:
> len can have any value 1 .. 4. Also the proposal doesn't consider
> the skip value.

So what about just keeping the code as-is then?  The existing version
is much easier to read than the new one, has less branching and doesn't
use an obscure API thast should not generally be used in driver code.
