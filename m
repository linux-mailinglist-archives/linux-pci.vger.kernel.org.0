Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFD2293658
	for <lists+linux-pci@lfdr.de>; Tue, 20 Oct 2020 10:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732547AbgJTICV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Oct 2020 04:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732545AbgJTICU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Oct 2020 04:02:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8C6C061755;
        Tue, 20 Oct 2020 01:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=emL9IWe4Y71z9LCkV55HxG23Cm1SkPxtHPJIxCpbC9g=; b=eLNPTSevIa6QTDdIDPCSxF3Thr
        YAYixkv7J4BRstFroqAgYcsagXWpgkmceC7GVFEyhiB8h67HBVP5cTfFCck8gDN5jqGd/plZuxRuN
        EOKf6FuDPLtRmvQtd1Mf3UBg+Ptxov4jtef8OkEdS9HS3P3W4dVEc5imvGF4A36JvM4QH96CEGLR4
        bo1Mo0x2Y4Ib3QlCGn/d/p1x8pztl2j7c++O1WZEnxMMqrGMe3Z0eabhwRnETdX3FUEiW0y1swD04
        tPWJNJD6/BdSz6+cVCDH74SDWyHyzsgIdRXYEJ1jeoMWTFf6sAdK7xk1EFodH3UTs/WWIVfHpx94Q
        8BQlQ/rA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kUmb5-0005VC-K1; Tue, 20 Oct 2020 08:02:19 +0000
Date:   Tue, 20 Oct 2020 09:02:19 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        linux-mips@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: export pci_find_host_bridge() to fix MFD build error
Message-ID: <20201020080219.GA21011@infradead.org>
References: <20201019061453.32295-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019061453.32295-1-rdunlap@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Oct 18, 2020 at 11:14:53PM -0700, Randy Dunlap wrote:
> Fix a build error in drivers/mfd/ioc.o by exporting
> pci_find_host_bridge().
> 
> ERROR: modpost: "pci_find_host_bridge" [drivers/mfd/ioc3.ko] undefined!

I think the mfd code should be fixed to not depend on such an internal
symbol instead.
