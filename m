Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F028A37AAB4
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 17:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhEKPbI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 11:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhEKPbE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 11:31:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA5BC061574
        for <linux-pci@vger.kernel.org>; Tue, 11 May 2021 08:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=69yGNYkFReLimODTTV/EkLhTqjWvmaR0v4e6FEqzlY8=; b=TxDIUE+PaOSGAiX1MM9Py/Ixf7
        G297xPzTcWVNMafTTl7dCMfITQbVIr85jfeSSVtRz383lVvAKK4BH+lM4FXY6W8M9zh71n4FuUz1o
        mzuc3lW2L7SfZcqoTzipB8kYdOrlFXqtNgh1VB1lOYVT9E0gtsAQGAI2Ne/8GfrrxVs89EiqZBc08
        7MIf9nlOacNdqgIHqi3EY7aal4Dv7SmEZteU5N5jb6a9SLyX1QO1F4GKxIEX5ZwSTR3aniMVW+BAb
        wV2i+xtvD8uxpH2knRW9vPqIej0hWgL3NFxlAgSx0aO49mpUZDlyaf/tAg09cW/vVArcP6YaCHKmx
        a/zac54A==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgUKS-007PNt-5j; Tue, 11 May 2021 15:29:49 +0000
Date:   Tue, 11 May 2021 16:29:48 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Dongdong Liu <liudongdong3@huawei.com>
Cc:     helgaas@kernel.org, hch@infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V2 5/5] PCI: Enable 10-Bit tag support for PCIe RP devices
Message-ID: <YJqi7M/2bg0v5HvG@infradead.org>
References: <1620745965-91535-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620745965-91535-1-git-send-email-liudongdong3@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> +	/*
> +	 * PCIe spec 5.0r1.0 section 2.2.6.2 implementation note
> +	 * For configurations where a Requester with 10-Bit Tag Requester capability
> +	 * targets Completers where some do and some do not have 10-Bit Tag
> +	 * Completer capability, how the Requester determines which NPRs include
> +	 * 10-Bit Tags is outside the scope of this specification.  So we do not consider
> +	 * hotplug scenario.
> +	 */

Please avoid > 80 char lines that make comments completely unreadable.
