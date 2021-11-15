Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660E544FEF5
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 08:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhKOHFY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 02:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhKOHEv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Nov 2021 02:04:51 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F248C061766;
        Sun, 14 Nov 2021 23:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M8zgqhL7LYLUrZWsNq5J+zCm5B75j5U4HdeQpG7LThs=; b=WA9Kxq82NQ8vJN0EFUaJKtsGJO
        YSG3cEryusEWB2Xw5/mfNjTKzMvT43iIcLlhUd+E5Gcgc5T6AJAtEvxyl5w1JyiZg227hBW6Ub/a5
        mxgtW63xegFDCCxxJt6aBQO3R+5eKw+0v3zIA2tpZFFFgDpUDKmAGwl6dfzrysTtaL3GCL8IXxKBe
        jTk4cYzX8LchqD0t8mohqUHuyRrBK7Dei+2JF63MnhxeNo+7Xyrgtai3ptJyVPKNR7Z1DYfUb+hDd
        COH55cEdeTo2ESeZkKBykAkP6rqSacONrH4QmdtA8mcqUUY/PjHBR2mNvnolmkE8iKJU1Jgr2j4/C
        d3HVsnPw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmW02-00ETvq-6g; Mon, 15 Nov 2021 07:01:54 +0000
Date:   Sun, 14 Nov 2021 23:01:54 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 3/4] PCI/ASPM: Remove struct
 pcie_link_state.acceptable
Message-ID: <YZIF4uABdpsT58b+@infradead.org>
References: <20211106175305.25565-1-refactormyself@gmail.com>
 <20211106175305.25565-4-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211106175305.25565-4-refactormyself@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Nov 06, 2021 at 06:53:04PM +0100, Saheed O. Bolarinwa wrote:
> +	u32 reg32, latency, encoding, lnkcap_up, lnkcap_dw, l1_switch_latency = 0;

Another unreadably long line, just split this up.
