Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF3037AABE
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 17:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbhEKPc6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 11:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbhEKPc6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 11:32:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEADC061574
        for <linux-pci@vger.kernel.org>; Tue, 11 May 2021 08:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qd89Yq1zI8Ot5Kn7d3v2k37syKK+PdFa0qHgTzuWIkw=; b=JnXXtZ01Rbput6L/7z4BeWdccK
        cODLrMVbyrTU20bm0m/xzw8cvxRlBtRxjCgRnHeEO9l6Tk0ENdnA5kdrLka/OUVCaC8R47zeEKKrV
        xncq4DW4RKy3pJVmUdY1oDuY1Jmm9jhOLvhev4kDSb/LwsuxKO6zR52sLtjbCweUSh9sm5uXvUTRO
        T4n5rAF6m4DOLorKq9x2Cp6lKWKAEO3TscfNim+4CvZHVoTvkBqvxcyJ54fzcMM2YFBL/M5nQO3Sm
        x45SdEDnHgcnzsz8BRFBGenIV86+Zv1fbGrVFF/JFXO7pPuPeuJLGbiZnBkXxtpG131jRO0oAvhQM
        4fb+Bl5A==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgULt-007PRF-AB; Tue, 11 May 2021 15:31:19 +0000
Date:   Tue, 11 May 2021 16:31:17 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Dongdong Liu <liudongdong3@huawei.com>
Cc:     helgaas@kernel.org, hch@infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V2 5/5] PCI: Enable 10-Bit tag support for PCIe RP devices
Message-ID: <YJqjReTXy5+xaTfN@infradead.org>
References: <1620745965-91535-1-git-send-email-liudongdong3@huawei.com>
 <791a5af6-bcbb-a824-ecd7-504abe7194e2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <791a5af6-bcbb-a824-ecd7-504abe7194e2@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 11, 2021 at 11:24:16PM +0800, Dongdong Liu wrote:
> This patch is based on the patchset [PATCH V2 0/5] PCI: Enable 10-Bit tag
> support for PCIe devices.
> 
> I use "git send-email" report "4.4.2 Message submission rate for this client
> has exceeded the configured limit" lead missed [PATCH V2 5/5].

That is a message from your mail server. Try tweaking the
sendemail.smtpBatchSize option in your .gitconfig
