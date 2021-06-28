Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231B83B5C6A
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jun 2021 12:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhF1KWO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Jun 2021 06:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbhF1KWN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jun 2021 06:22:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA17C061767
        for <linux-pci@vger.kernel.org>; Mon, 28 Jun 2021 03:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d/Z47dXwWZvbmoLNLAZpUvgU0ZblKc+cW5clCvoAq/0=; b=WmZTe5rikyBmwxW2I82Jgc3pZy
        fsbyrxkvTvzxhN7tTO6a3RRxkObaF47AZlnOVw1MP/zB5GT4WfitCCwqCRLMU/S9RTh4Kageo3plK
        tnyJUlfC6lAvSq9Iv13hTtmLzbfwzdBXQukn1dpm+4PXcCvSPhjjWN1AYzHvhyZq8sl1YDmNBoYOG
        odlR5NJrgHw57gcIQaSHQ5ZrCcnHjASsxyBHtZuTw/5eUiGH/mIocRG9dI54Dm128IraO8hI0j8Zz
        du11IkYMmfQcBf+MpMfn+lAIxsNxIb9lhtRtcvXevbV4sxH0aG0wPD8t5Q3/PNO9RwQdXDfbi17od
        3G6PBD5Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxoIv-002q54-Jz; Mon, 28 Jun 2021 10:16:08 +0000
Date:   Mon, 28 Jun 2021 11:15:49 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Krzysztof Wilczy??ski <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        Pali Roh??r <pali@kernel.org>,
        Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI/sysfs: Pass iomem_get_mapping() as a function
 pointer
Message-ID: <YNmhVQzj4fdgVPf0@infradead.org>
References: <20210625233118.2814915-1-kw@linux.com>
 <20210625233118.2814915-3-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625233118.2814915-3-kw@linux.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Doesn't this need to be merged into the previous patch to prevent
a compile failure after just the previous patch is applied?
