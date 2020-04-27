Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8C51B9710
	for <lists+linux-pci@lfdr.de>; Mon, 27 Apr 2020 08:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgD0GOa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 02:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726231AbgD0GOa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Apr 2020 02:14:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29039C061A0F;
        Sun, 26 Apr 2020 23:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=on8z9Ittpq1vG37rq3n1q4CJliIUajEmB/VdF44xHeQ=; b=uw/Hyy/CILJmKzp8JDfO1Klwcg
        VsO26rPAJeY0W75RwNS00uBvPN9mhqPEW1H4Gf7jDw3hlSJ75YTuwWiY8tgunyhkMYdoWK4oRYxWk
        kjp0RIB3jIdujYj3Jugd3VUcrXfDtx4U3yfZON1EgNUrUCMPIpkPJcPMx0hM+DC3f0XB0zLh7sged
        8fTlZEpUgTEekHOKNHYavqlCoOHUHJWHXMfENgodlw8rNFaxC3HHH9QnrTKdOKpVRBMZoWOGzchP6
        6m48xWU+VV23DpSBXPfcMROJpUvLVBPxAwBOHGG7vSmLHZSU6gYiJzD3Gd9G1ygNNHKuoCtwMTVnC
        ixCPqw3g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jSx2A-0001n6-8B; Mon, 27 Apr 2020 06:14:26 +0000
Date:   Sun, 26 Apr 2020 23:14:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     rui_feng@realsil.com.cn
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, ulf.hansson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] mmc: rtsx: Add SD Express mode support for RTS5261
Message-ID: <20200427061426.GA11270@infradead.org>
References: <1587864346-3144-1-git-send-email-rui_feng@realsil.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587864346-3144-1-git-send-email-rui_feng@realsil.com.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Apr 26, 2020 at 09:25:46AM +0800, rui_feng@realsil.com.cn wrote:
> From: Rui Feng <rui_feng@realsil.com.cn>
> 
> RTS5261 support legacy SD mode and SD Express mode.
> In SD7.x, SD association introduce SD Express as a new mode.
> SD Express mode is distinguished by CMD8.
> Therefore, CMD8 has new bit for SD Express.
> SD Express is based on PCIe/NVMe.
> RTS5261 uses CMD8 to switch to SD Express mode.

So how does this bit work?  They way I imagined SD Express to work
is that the actual SD Card just shows up as a real PCIe device, similar
to say Thunderbolt.
