Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45FE03E9F43
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 09:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbhHLHLr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Aug 2021 03:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbhHLHLr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Aug 2021 03:11:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849AAC061765;
        Thu, 12 Aug 2021 00:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=YxDFlwEVyj/F9oNqUTEE/ssl+n
        jmKWFhHmPuiCIn8Xq0OJxen+mikjiJMhf5LovmKG8FNINiynLW+MyjRwy0BqXxko7TQiGTJZciMG6
        peFGBF1A8uZwMcXGs3IXxEBksOQYOG+7KXNvLTz1CzYXTtpC5P6DiZ07ri1GsZoNQcoALV12CkAz+
        XnABK2mERRUcK7/rtU6wW052dfwww4vkad6zXSAZKV8ZzX0EJNgO3AH/thGLYSUfyguYcdpN9lrge
        nNwwWhWOqrbHUmKEAELq9EqkB/FpHYf4fE1XInl2Y//1kDmuknMoanoUEP/g2TRZ1VGWDIgmNLS+V
        Sb6bEhyQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mE4r2-00EH2Q-5n; Thu, 12 Aug 2021 07:10:34 +0000
Date:   Thu, 12 Aug 2021 08:10:16 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, kernel@pengutronix.de,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v3 5/8] scsi: message: fusion: Remove unused parameter of
 mpt_pci driver's probe()
Message-ID: <YRTJWCv+oJa6bq6W@infradead.org>
References: <20210811080637.2596434-1-u.kleine-koenig@pengutronix.de>
 <20210811080637.2596434-6-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811080637.2596434-6-u.kleine-koenig@pengutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
