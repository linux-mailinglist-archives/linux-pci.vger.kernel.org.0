Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A6B27F53E
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 00:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731649AbgI3Wja (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 18:39:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731626AbgI3Wja (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Sep 2020 18:39:30 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FA072071E;
        Wed, 30 Sep 2020 22:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601505570;
        bh=tbAFpGAEMkngf5R/BX2da9DBbg1YwnUPT9h0HtzMl3Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=S1nYt4bXD/ymFbyHClk22TYDG4tZpwM+x4FjOVFO51GW429wsYo4CGZhs2kKsqapN
         A4hoDY7sSCUKs8ZxdjyhFNQUZsZSoIYUQxNY55uAP01zQ8lkop2xkE22dR4S2LsS03
         wCFlWqRvnmFQ9l+Tgw/+dnxlYl8HjSZkgQ7kkH/s=
Date:   Wed, 30 Sep 2020 17:39:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: sparse warnings
Message-ID: <20200930223928.GA2643255@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729194815.GA1961117@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 29, 2020 at 02:48:15PM -0500, Bjorn Helgaas wrote:
> Just FYI, I see the following sparse warnings (among others):
> 
>   $ make C=2 drivers/pci/
> 
>   drivers/pci/endpoint/functions/pci-epf-test.c:288:24: warning: incorrect type in argument 1 (different address spaces)
>   drivers/pci/endpoint/functions/pci-epf-test.c:288:24:    expected void *to
>   drivers/pci/endpoint/functions/pci-epf-test.c:288:24:    got void [noderef] <asn:2> *[assigned] dst_addr
>   drivers/pci/endpoint/functions/pci-epf-test.c:288:34: warning: incorrect type in argument 2 (different address spaces)
>   drivers/pci/endpoint/functions/pci-epf-test.c:288:34:    expected void const *from
>   drivers/pci/endpoint/functions/pci-epf-test.c:288:34:    got void [noderef] <asn:2> *[assigned] src_addr
> 
>   drivers/pci/controller/dwc/pcie-designware.c:447:52: warning: cast truncates bits from constant value (ffffffff7fffffff becomes 7fffffff)
> 
> It'd be nice to fix these if it's practical.

Any ideas about these?

Bjorn
