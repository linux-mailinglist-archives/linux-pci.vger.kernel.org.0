Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F1B44FEF0
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 08:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhKOHEB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 02:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhKOHDy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Nov 2021 02:03:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1ABC061746;
        Sun, 14 Nov 2021 23:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=OkBbXvpTvbszL7PnCKTUtjgFkS
        uBMpRSbLZatWWe2jg1Vg+NoFGp4UOesMMUmt5/ZDhF4MRrE++iI4Qw8SxY2j8LV1AyMJkRP89hR58
        oNNsf9sMM9vDeC+zUJ9gJ7YjPvtIS+A//vi6G0mpkzpt8ndlTzuNgpmiMOBwTR8IFbey9QgWsfTa/
        e2EQLGCgXAVj5cZcftDjLoTm+dUKgGXqqI0kDoFaklVdHFQDErHdGboY0cERKKZhRsDr0hoJwLwCb
        +zao0AuIf/2j/k4CBuJzArvK2VSDoDtXEl2ZB60C052Aj4TaDGeGYjaRARH20/BDPAuo1zn0uubSW
        Q23NdAqg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmVz6-00ETo3-Ii; Mon, 15 Nov 2021 07:00:56 +0000
Date:   Sun, 14 Nov 2021 23:00:56 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 1/4] PCI/ASPM: Move pci_function_0() upward
Message-ID: <YZIFqDhIvMhzKtHe@infradead.org>
References: <20211106175305.25565-1-refactormyself@gmail.com>
 <20211106175305.25565-2-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211106175305.25565-2-refactormyself@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
