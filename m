Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B31B6C0E46
	for <lists+linux-pci@lfdr.de>; Sat, 28 Sep 2019 01:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfI0XPH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Sep 2019 19:15:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53766 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfI0XPH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Sep 2019 19:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jpQ+cgpYgorqncxujkoyHM8IzUkc+K1/nH0wPDL+W9s=; b=ihosnk8ToIlXCYlg3/0bKQS0y
        1cIBC2Q3dbp6UZuz/7oOeMIjwXvptnoZBMRRFi7769g7WcBypM8yjx3LreaPkji4KVvF9U8r+hPLp
        S0KzexbzN4RaL+gD6ma66lJAFqTHON/LJu/wLbT4k8F2vkpjpiFtECpTU6v5MbqmG/eQUjU69Se8s
        zL8PqCWhnrgdOIhHXIpcEvXg1g+6ao2eukBs/rVtaWAUEYhMLzjnAZ0EmthsiiC7XZ0oXhdptxiWH
        aC7k40lmmWThGW3QuCM2NvwPtSvOsEizWoMdcUtMKKSmx7z23dKf468T9ivNyhWZeR36OQJnli4fv
        LxJ/E2PAQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iDzS4-0004Lk-9W; Fri, 27 Sep 2019 23:15:04 +0000
Date:   Fri, 27 Sep 2019 16:15:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Minghuan Lian <Minghuan.Lian@nxp.com>,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
Subject: Re: [PATCH] PCI: mobiveil: Fix csr_read/write build issue
Message-ID: <20190927231504.GA13714@infradead.org>
References: <20190925142121.56607-1-wangkefeng.wang@huawei.com>
 <20190926092933.GC9720@e119886-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926092933.GC9720@e119886-lin.cambridge.arm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 26, 2019 at 10:29:34AM +0100, Andrew Murray wrote:
> Though I'd be just as happy if the csr_[read,write][l,] functions were
> renamed to mobiveil_csr_[read,write][l,].

Please do that instead, using such generic names as csr_* in a driver
is a bad idea, with or without a __ prefix.
