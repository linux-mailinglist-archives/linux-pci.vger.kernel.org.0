Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8274B1DBBCA
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 19:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgETRn5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 13:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgETRn5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 13:43:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BB9C061A0E;
        Wed, 20 May 2020 10:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=72/myqImacqZvgA/Df7tM4W80PT1FO6/o07rXUy1dH4=; b=Il+/zPYl2NlqSMAoFu30IRTSjY
        qAqRcgvOOfLXUpfM5ePlyGF7j7lXgyyJ6SErXmiH99NPFl8224Hm4TrNU3wuvVeB8D0LuWGrzrqTo
        2Dj43BzPzcBSwFmJIQh0R/aS8xpR9Xxx0AYNNLl+gIrYiwKG1SSa6zGkMnqhBCjVpY/w3y7N4Q0P/
        478g/Q9fVjPXKiE/9mk6LOfAjwqXCn5StnSrQPrD62zl/F9E/9dqM6W7TJWeAvXXppdbOs8eKuGRL
        V2gS68V4zL+xtZD2BakQcJNwY51dpW5jre6H6jGAf00+EwGtIVhg2oeIH+DcXI7HbrMLrmmsLzTXg
        SSHCH04Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbSl2-0000AA-DN; Wed, 20 May 2020 17:43:56 +0000
Date:   Wed, 20 May 2020 10:43:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sean V Kelley <sean.v.kelley@linux.intel.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 3/3] PCI: Add helpers to enable/disable CXL.mem and
 CXL.cache
Message-ID: <20200520174356.GA26878@infradead.org>
References: <20200518163523.1225643-1-sean.v.kelley@linux.intel.com>
 <20200518163523.1225643-4-sean.v.kelley@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518163523.1225643-4-sean.v.kelley@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 18, 2020 at 09:35:23AM -0700, Sean V Kelley wrote:
> With these helpers, a device driver can enable/disable access to
> CXL.mem and CXL.cache. Note that the device driver is responsible for
> managing the memory area.

Who is going to call these?  Please don't submit new APIs without users.
