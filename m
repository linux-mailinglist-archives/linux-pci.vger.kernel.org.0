Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5689044FEF7
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 08:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhKOHFZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 02:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhKOHFU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Nov 2021 02:05:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2C1C061746;
        Sun, 14 Nov 2021 23:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=AneAEniOut1uL+iB8PkCMP4yeg
        kTN5f7Fjtry1nDOQo5PVsa5HHfwmdLwU2cPTlsFBXsfRZ6Vb50u89oQ+Rekfd+K+GhtLyKcpn01Eo
        u1wrasP6NQBvj3jjMU5xcWwhYhBYD4llxfav+4AuTi+hV6VL6wWYqTPfgVqIJ+3h79Y7tzGL7/6/P
        IJusEviH0YT+u67oR9uXrRLEsbRTPIiNYh1bianC6SJSrPtmeJbH3fvEcSXHuKKeHhUvy+jp5pl3h
        N7CuNWj51aUFddD5CzEUHMs4YKJakwtiya23VesyxTzWHOBEbFgXZf7o9/2tTCkTOvZP4qrxBeMaM
        k75dvmUg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmW0T-00ETza-Tb; Mon, 15 Nov 2021 07:02:21 +0000
Date:   Sun, 14 Nov 2021 23:02:21 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 4/4] PCI/ASPM: Remove struct aspm_latency
Message-ID: <YZIF/ZkebyRxfbVu@infradead.org>
References: <20211106175305.25565-1-refactormyself@gmail.com>
 <20211106175305.25565-5-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211106175305.25565-5-refactormyself@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
