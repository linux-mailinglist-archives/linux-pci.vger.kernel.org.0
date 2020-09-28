Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F5827A869
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 09:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgI1HR6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 03:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgI1HR5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Sep 2020 03:17:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658C8C0613CE
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2020 00:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qsvMoz5mYBDDu6VyE30BJbrf3loXHCyeOw1EaYfX8i8=; b=GPyZ70CTXgTSXlX1SX/ImLHvNl
        H4F4pPBnGr1vbcdnnWYVg77kFEefQBwWAnW7C2o4OsJ6t4fZofK8DVfBIQ2i1Pj1iAFdwWLsLj6cL
        f5+TPkFjVTlWgDS/xm/alULPh2R++htfPiZ2M9RHPrOu7gza1FDhDlEJ9sIDeA5r99fSa65yZ85Ws
        OqG7w30TTbZ9om/du3hLlMi7WA8ahsfxxlU8MQRrN+JCwlfe6FPDecI2qumA/bjQqSUsFtgfwlUBY
        Nyr7VuNMQRjkM0nh67IUpOfCEf2vafacgv3cCKWGjF6RJMRXLUvbiBpaZOJeBcAR6YL4l45i5scOQ
        AfNKl9TA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kMnQ3-0006aY-QC; Mon, 28 Sep 2020 07:17:55 +0000
Date:   Mon, 28 Sep 2020 08:17:55 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
        Dave Fugate <david.fugate@intel.com>
Subject: Re: [PATCH 2/3] PCI: Introduce a minimizing assignment algorithm
Message-ID: <20200928071755.GB24862@infradead.org>
References: <20200928010609.5375-1-jonathan.derrick@intel.com>
 <20200928010609.5375-3-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928010609.5375-3-jonathan.derrick@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Please keep this code in VMD if we really have to do it (although I'd
be perfectly fine to let people dumb enough to enable VMD devices to
live with the problems).  You are adding lots of code that gets
copiled into every Linux kernel that supports PCI jut to work around
a copletely idiotic invention from Intel that makes life painful for
us for no good reason.
