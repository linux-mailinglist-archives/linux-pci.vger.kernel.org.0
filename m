Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4122EFEC2
	for <lists+linux-pci@lfdr.de>; Sat,  9 Jan 2021 10:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbhAIJ0b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Jan 2021 04:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbhAIJ0a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Jan 2021 04:26:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77131C061786
        for <linux-pci@vger.kernel.org>; Sat,  9 Jan 2021 01:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=orTrwl6mDAQHr3qpvUBQdkm781G49tmCK2vydKoShek=; b=UwQt0S0ZTez3nYn6wqD4k/xQyg
        oovrXB/K0vpV1JZiwhqQj1Z11RB1FRONgP9z5FT19CugTW+kUMY3fFfUUMrL3e/LeJ9oJx4cWy9XB
        wBiLpGKwChJAXwT8NnJFh3kU4r4uxpP1tL+saoOO9kRd01AcQ3BhdUjrU2qTREpp7X9Q3EC+IaOGL
        fSK7AvLp8274SkrwZdCswjgXOXse5gaUALd4DYZR8vT9PD3u4nwz06dNq4suk3A06E4yWGlvUeyKr
        Ro1UHnY5q8es01SI36HIcp9yrbBbMEBmHG0Tm4V3J0k5iomw0++9icz7l0o+aZ1D41tD+bKaTpcxo
        PKC4WJWg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kyAUb-000PHa-89; Sat, 09 Jan 2021 09:25:08 +0000
Date:   Sat, 9 Jan 2021 09:25:05 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian K??nig <ckoenig.leichtzumerken@gmail.com>
Cc:     bhelgaas@google.com, devspam@moreofthesa.me.uk,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] pci: export pci_rebar_get_possible_sizes
Message-ID: <20210109092505.GA95206@infradead.org>
References: <20210105134404.1545-1-christian.koenig@amd.com>
 <20210105134404.1545-2-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105134404.1545-2-christian.koenig@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 05, 2021 at 02:44:01PM +0100, Christian K??nig wrote:
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e578d34095e9..ef80ed451415 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3579,6 +3579,7 @@ u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
>  	pci_read_config_dword(pdev, pos + PCI_REBAR_CAP, &cap);
>  	return (cap & PCI_REBAR_CAP_SIZES) >> 4;
>  }
> +EXPORT_SYMBOL(pci_rebar_get_possible_sizes);

EXPORT_SYMBOL_GPL please for such internals.
