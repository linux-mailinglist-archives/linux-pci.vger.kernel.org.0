Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B72AA90086
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 13:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfHPLKg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 07:10:36 -0400
Received: from foss.arm.com ([217.140.110.172]:55136 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbfHPLKg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Aug 2019 07:10:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65C6428;
        Fri, 16 Aug 2019 04:10:35 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D32C3F706;
        Fri, 16 Aug 2019 04:10:34 -0700 (PDT)
Date:   Fri, 16 Aug 2019 12:10:32 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V3 1/3] PCI: rcar: Move the inbound index check
Message-ID: <20190816111032.GC23677@e121166-lin.cambridge.arm.com>
References: <20190809175741.7066-1-marek.vasut@gmail.com>
 <20190816105227.GB23677@e121166-lin.cambridge.arm.com>
 <fcf457c1-7297-6a27-5bd7-4fdd05d72698@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcf457c1-7297-6a27-5bd7-4fdd05d72698@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 16, 2019 at 12:59:51PM +0200, Marek Vasut wrote:
> On 8/16/19 12:52 PM, Lorenzo Pieralisi wrote:
> > On Fri, Aug 09, 2019 at 07:57:39PM +0200, marek.vasut@gmail.com wrote:
> >> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> >>
> >> Since the $idx variable value is stored across multiple calls to
> >> rcar_pcie_inbound_ranges() function, and the $idx value is used to
> >> index registers which are written, subsequent calls might cause
> >> the $idx value to be high enough to trigger writes into nonexistent
> >> registers.
> > 
> > Can this really happen ? 'index' is initialized to 0 in
> > rcar_pci_parse_map_dma_ranges() and, through rcar_pcie_inbound_ranges()
> > return value, it bails out on idx overrun, we can argue this patch
> > improves robustness but I do not think it is fixing anything.
> 
> We probably don't want to write into non-existent registers ?

I have not questioned that.

> I think it can happen when there are too many ranges in DT.

Yes that's true when idx == MAX_NR_INBOUND_MAPS, forgive me the
question.

Lorenzo
