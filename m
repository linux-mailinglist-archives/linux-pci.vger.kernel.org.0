Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71841E7628
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 17:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730907AbfJ1Qaq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 12:30:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47700 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730494AbfJ1Qaq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2019 12:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GRzG+D+EP5Y4GBT80JjuD057rfFJXLiQlYewtqIWXho=; b=uxYjW9/kDRXPaB3lgbUvwENbu
        ZQ6mKzPyrL0cC/t3n5wJU4GmHyBPXJk3SJ9vd6w3qnuwdnTlAwIPNfsUInTMKQyRZ2FvTweKHc9Nm
        kBdzDvDRnT4Lp6936/JiW+/J/RljZEkckZpVpzllfnyXVxN36/QhRbHvvc2n+iVPt/B6oEXLUXMoQ
        7x59LIK/dmit3HQumIEb87qdx4D5qX/XhSsG66DiJ0oG4/7Ntori1TOGdrDFKfhDuwgC0RThwKZQU
        Q3XHUgbbkeGmJLL7/Nv778t0F03/mbAZqewoc4+U6OXEVuzJDka23xKnTtBo9rhQ+yDaH+O95pZYy
        +Jt9TM80A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iP7uj-0006Uv-OI; Mon, 28 Oct 2019 16:30:41 +0000
Date:   Mon, 28 Oct 2019 09:30:41 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Xiang Zheng <zhengxiang9@huawei.com>
Cc:     bhelgaas@google.com, wangxiongfeng2@huawei.com,
        wanghaibin.wang@huawei.com, guoheyi@huawei.com,
        yebiaoxiang@huawei.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        tglx@linutronix.de, guohanjun@huawei.com, yangyingliang@huawei.com
Subject: Re: [PATCH] pci: lock the pci_cfg_wait queue for the consistency of
 data
Message-ID: <20191028163041.GA8257@bombadil.infradead.org>
References: <20191028091809.35212-1-zhengxiang9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028091809.35212-1-zhengxiang9@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 28, 2019 at 05:18:09PM +0800, Xiang Zheng wrote:
> Commit "7ea7e98fd8d0" suggests that the "pci_lock" is sufficient,
> and all the callers of pci_wait_cfg() are wrapped with the "pci_lock".
> 
> However, since the commit "cdcb33f98244" merged, the accesses to
> the pci_cfg_wait queue are not safe anymore. A "pci_lock" is
> insufficient and we need to hold an additional queue lock while
> read/write the wait queue.
> 
> So let's use the add_wait_queue()/remove_wait_queue() instead of
> __add_wait_queue()/__remove_wait_queue().

As I said earlier, this reintroduces the deadlock addressed by
cdcb33f9824429a926b971bf041a6cec238f91ff
