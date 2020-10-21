Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59921294B14
	for <lists+linux-pci@lfdr.de>; Wed, 21 Oct 2020 12:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438588AbgJUKI4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Oct 2020 06:08:56 -0400
Received: from elvis.franken.de ([193.175.24.41]:43319 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438552AbgJUKI4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Oct 2020 06:08:56 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1kVB38-0003hB-00; Wed, 21 Oct 2020 12:08:54 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 16F9FC0569; Wed, 21 Oct 2020 12:08:45 +0200 (CEST)
Date:   Wed, 21 Oct 2020 12:08:45 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Paul Burton <paulburton@kernel.org>,
        linux-mips@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: export pci_find_host_bridge() to fix MFD build error
Message-ID: <20201021100844.GA3693@alpha.franken.de>
References: <20201019061453.32295-1-rdunlap@infradead.org>
 <20201020080219.GA21011@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020080219.GA21011@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 20, 2020 at 09:02:19AM +0100, Christoph Hellwig wrote:
> On Sun, Oct 18, 2020 at 11:14:53PM -0700, Randy Dunlap wrote:
> > Fix a build error in drivers/mfd/ioc.o by exporting
> > pci_find_host_bridge().
> > 
> > ERROR: modpost: "pci_find_host_bridge" [drivers/mfd/ioc3.ko] undefined!
> 
> I think the mfd code should be fixed to not depend on such an internal
> symbol instead.

are you talking about the EXPORT_SYMBOL or the usage of
pci_find_host_bridge() outside of drivers/pci ? If the latter the
function is used in arm/arm64 code and pci controller code... so
I doesn't look like a pure internal symbol to me.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
