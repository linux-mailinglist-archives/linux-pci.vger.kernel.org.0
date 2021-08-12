Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE6D3E9EC8
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 08:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhHLGsV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Aug 2021 02:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbhHLGsV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Aug 2021 02:48:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C6DC061765
        for <linux-pci@vger.kernel.org>; Wed, 11 Aug 2021 23:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ov4Rt0HX+mmU4192K4Y5nFCPnpfgMeQNRVtuAWv3mBw=; b=cmxWdlSn0ohPE5fbiKEn4Rl6K6
        o+nfbEm0J0BgFYWQQ1R58EF4OuK2MsQp6HNkEnWqCH8c+KC+0C/P0GxjzXHX8PjLwf44D7eem64kw
        Qnpi5bmitAOSz3M+JJKpCh/ipWZe5tkzsBdz/3pT07SyS1ovMj10hsPNKVYoP+3X9ewODHtZLricx
        qOjXlKu7+STPUX2FCzN3YGCcHEIZLqAFDALnU0Zmmos0cmUtCDx8tXzUSMxxEtt323Vwzh32XMvlF
        FrDg7jNTGRz2Ud2oVoNdGvtH3VLiWcaxTLyodPPaEPVDffwuyZGN4moEdZdrioHm43NVJ4qSMUJdB
        PWFhAy2Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mE4UB-00EFk0-8V; Thu, 12 Aug 2021 06:46:50 +0000
Date:   Thu, 12 Aug 2021 07:46:39 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v3 2/8] PCI: Drop useless check from pci_device_probe()
Message-ID: <YRTDz4V82WVnO5tF@infradead.org>
References: <20210811080637.2596434-1-u.kleine-koenig@pengutronix.de>
 <20210811080637.2596434-3-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811080637.2596434-3-u.kleine-koenig@pengutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 11, 2021 at 10:06:31AM +0200, Uwe Kleine-K??nig wrote:
> When the device core calls the probe callback for a device the device is
> never bound and so !pci_dev->driver is always true.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
