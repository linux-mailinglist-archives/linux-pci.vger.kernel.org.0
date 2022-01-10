Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031BF489448
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jan 2022 09:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242507AbiAJIwJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jan 2022 03:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242256AbiAJIuF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jan 2022 03:50:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A089C06173F;
        Mon, 10 Jan 2022 00:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AUTeW22BpNDDF1icPr7BlgZZ5aYLeEr/4W4bnlubcPs=; b=G0m6RiA4hux2kbGCSUhQXQ11tw
        s7S9E+W8aBweUE3WZNR3lFPI1F7A39FH7CgF/5iG1K9jhQZDbTpHF3HuGfxaBaW/VqYdaAZ35IR53
        GfO3TPYnnWtY3X8K8NJzU3aSio8bqUmlMGv9sC3EXplfUV6s83Y3Y1xCfhJEfLcfwcPAhbRxTegvv
        PkzzA98gEVgcx8oYwxTHH30O090kK8Tb+MQPHsUXzgUY4KuDrBMCBXV7yp2jzrMTEDCGTDZbL3d+d
        eo55GtAoMhB2aWkH2gb1tXsKzQoG/6M9gPUKpJtcdebnxVoAaJa40AP1o7zliTzyPOS5x2foCTQRR
        fwkxdu3Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6qNH-00A2No-4x; Mon, 10 Jan 2022 08:49:55 +0000
Date:   Mon, 10 Jan 2022 00:49:55 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, arnd@arndb.de,
        hch@infradead.org, akpm@linux-foundation.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 16/16] PCI: Remove usage of the deprecated
 "pci-dma-compat.h" API
Message-ID: <YdvzMz3aQzWfbjnu@infradead.org>
References: <e965573211f8c81c8ba978cfbc21925810a662b1.1641500561.git.christophe.jaillet@wanadoo.fr>
 <20220106222804.GA330366@bhelgaas>
 <0e381699-8bfa-186b-3688-5346e42a63cd@wanadoo.fr>
 <cfabcc1c-16cd-80f7-7d28-6d817c29a7a0@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfabcc1c-16cd-80f7-7d28-6d817c29a7a0@wanadoo.fr>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 07, 2022 at 06:23:25PM +0100, Marion & Christophe JAILLET wrote:
> What is the best option?
> 1. Add    #include <linux/dma-mapping.h>?		or
> 2. Add this "missing" include in needed place?
> 
> I would say 2, but I would need help, because I don't have a built farm at
> home! :)

In the long run 2 is where we want to end up.  But I'd do 1 first to get
the legacy API removal finished, and then do 2 later after a lot of test
coverage from the build bot.
