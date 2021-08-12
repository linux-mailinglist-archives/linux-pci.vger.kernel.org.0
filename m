Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A2D3E9EF8
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 08:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbhHLGx5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Aug 2021 02:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbhHLGx5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Aug 2021 02:53:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501F0C061765
        for <linux-pci@vger.kernel.org>; Wed, 11 Aug 2021 23:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=uv8XkVSPcweRpGVENdTvEYxm97
        bnyIAFCjU7YEtIhokxZBl/XYkjAcZQBbnL8kkGPOlX6PC14mb0YafuLblSG/PheIOoqkjUmLmjUl/
        hVXo11me6O/M/Ry/KZ3LfN8W6xCmIViECiapp2JmAjaKBdliDQNDJ0tJapAbCj1HXIXLk4DzlQfZF
        BUJ10RoZ+QDa1hoVcwaleHoqngA5raTXituCDH7Bm+aGbDHijZ55hg9h/fodghyenmz+prn5HfxRu
        g5EqKd3U1uPDRpFt8/JObU29yiFmPKFa8lX6yxW74civSUXhscU4un4rEb0R9Qm+3aQ2jQ6oanlUT
        /JoAjBpQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mE4Xy-00EFw7-EK; Thu, 12 Aug 2021 06:51:14 +0000
Date:   Thu, 12 Aug 2021 07:50:34 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Boris@pengutronix.de,
        Ostrovsky@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, kernel@pengutronix.de,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH v3 3/8] xen/pci: Drop some checks that are always true
Message-ID: <YRTEut8cvAct5yPV@infradead.org>
References: <20210811080637.2596434-1-u.kleine-koenig@pengutronix.de>
 <20210811080637.2596434-4-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811080637.2596434-4-u.kleine-koenig@pengutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
