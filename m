Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D66296193
	for <lists+linux-pci@lfdr.de>; Thu, 22 Oct 2020 17:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901370AbgJVPVu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Oct 2020 11:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2901369AbgJVPVu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Oct 2020 11:21:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBCFC0613CE;
        Thu, 22 Oct 2020 08:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sQ5Xmcg/9wGewf1aqsxbuSsff3EYWaYFXfjaMu6eJPM=; b=NHzfoahNst/RyH/HXY3XWvQcoI
        Vq+uirgzYCYecuo5YW+6OmTEjT+55Qyp/2Up6lagOo/nNtQ349C956mJ1FkVCCOEhFWP7uZUs167p
        x3XCj8ianvPUSNXz2S/IqlIxmTs/Z3n8s9oXN6Qs4umCe1uqIsZwzUKZRE/Qk8lq1HwYo4tyAahFn
        7ItUOJkS9tM08SETI5p17l1yXKpP/i/7lyhpHz2kVxOqif34yrl8bZ8P+KaaaDdCmFS1qKM6DlOmg
        +FM0OcPYlRipP70RLayf7Y4JQBVMygxyyyLa4dtf5qj1MAgD3oFUYa7tqPmBtTwQYP1fANdt6J2Wg
        QLN1xOdg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVcPU-0006bh-Cj; Thu, 22 Oct 2020 15:21:48 +0000
Date:   Thu, 22 Oct 2020 16:21:48 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com
Subject: Re: [PATCH 1/2] PCI: export pci_match_device()
Message-ID: <20201022152148.GA23673@infradead.org>
References: <20201021081030.160-1-zhenzhong.duan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021081030.160-1-zhenzhong.duan@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 21, 2020 at 04:10:29PM +0800, Zhenzhong Duan wrote:
> pci_match_id() is deprecated as it doesn't catch any dynamic ids that
> a driver might want to check for.
> 
> Export pci_match_device() as a replacement which supports both dynamic
> and static ids.

You don't actually seems to add any user outside of the PCI core,
so I think you only need to drop the static specifier and add a
prototype.
