Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514F5473DD2
	for <lists+linux-pci@lfdr.de>; Tue, 14 Dec 2021 08:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbhLNHzd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Dec 2021 02:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbhLNHzc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Dec 2021 02:55:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52A7C061574;
        Mon, 13 Dec 2021 23:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZgCKIjCBbZsE6mdp2caR3SSGOAg+b9LM/fEfk4M75uI=; b=a/gLBA8F9cNhzmLzhckUQWXQHn
        vfDmVXr5wZbbexGYjk4Tt4Amy5LhIs8MlCjQS1u00G3Kf0rxZy23+AU3EulYc1gFoTGcs5NCiJ8aU
        XK2oWD6e1g6Zy8T79fie4iCScsAA67GmTKalGnXjJAxdOmVZBV1FIOgyiZvccc90z5M6myj1GtowC
        Z8AzJxrB1KF/0z4AWqNxR2yjuAqOaR5gdho4N3LyflyzCLwXHTuYc/5/D7HX2msKb8aLVHpPBwbO/
        bi4Cwx7CVv8Z63ph4ea1KqoCopQK6Fjn4VTwqxB24m712CLWHFcCcc4AwouVzXNm98lOnVBKezGO4
        f1WXhX5Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mx2ei-00CwRL-0P; Tue, 14 Dec 2021 07:55:24 +0000
Date:   Mon, 13 Dec 2021 23:55:23 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v5 4/4] rsxx: Drop PCI legacy power management
Message-ID: <YbhN69IhTbGhvVeD@infradead.org>
References: <20211208192449.146076-1-helgaas@kernel.org>
 <20211208192449.146076-5-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208192449.146076-5-helgaas@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Maybe it is time to just drop this driver?  It was never widly used,
seems unmaintained and uses a cumbersome own queueing layer instead
of blk-mq.
