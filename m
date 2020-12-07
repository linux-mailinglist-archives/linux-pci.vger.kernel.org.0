Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8BD2D141B
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 15:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbgLGOxo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Dec 2020 09:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgLGOxo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Dec 2020 09:53:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B95EC06138C;
        Mon,  7 Dec 2020 06:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xwgmoCoKG6McRJp+uAqWFjRnme17iWRJlYPeQFEG0sQ=; b=bWoExFl2ViTn/NCxMNSY5YP5YY
        JW9uXGRMOa4Y2LILnkVhLUM4s/UpGf3houbtHV+AAiRFX67TIN7TeJai1qZVxJFS0kvzGiUg+7pHy
        Mu/YzoNY9FtEKxlSsrticrQmnZJrozoT4HUIcaVS0v3m1MhjcODkbyzPbjfMSG5G+VWGeja/DanpO
        +Q1VC3tFMglSen2Qg+rETviLmcZZcaSlZS55Ot8goukrUbtjCDtbpsPMyl7u9ivPibVuS6brHhS7n
        zvkYZIYFLKtQ57+WINC8w6Bt461jRqCyz7kiG0pp246eLBnTIQS+hdyKpdUJIm1cmQOa0z+1ZBy7/
        dCrJl8Mw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmHso-0004gj-KI; Mon, 07 Dec 2020 14:52:58 +0000
Date:   Mon, 7 Dec 2020 14:52:58 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Damien.LeMoal@wdc.com, linux-block@vger.kernel.org,
        bjorn@helgaas.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH] drivers: block: save return value of
 pci_find_capability() in u8
Message-ID: <20201207145258.GA16899@infradead.org>
References: <20201206194300.14221-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201206194300.14221-1-puranjay12@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Can we take a step back?  I think in general drivers should not bother
with pci_find_capability.  Both mtip32xx and skd want to find out if
the devices are PCIe devices, skd then just prints the link speed for
which we have much better helpers, mtip32xx than messes with DEVCTL
which seems actively dangerous to me.
