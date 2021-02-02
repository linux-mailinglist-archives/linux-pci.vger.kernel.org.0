Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF29030C96B
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 19:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238443AbhBBSR2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 13:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238184AbhBBSPv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Feb 2021 13:15:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBC3C0613ED;
        Tue,  2 Feb 2021 10:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0+8razvFOQF0lS6CiOBgQgUcWVFkIsoX+gdB9DN1ClU=; b=pNl3Xj1mdOaJGg6BrCAQmSG7Yh
        xz2YE7gjLnfL+2/GiMGVjBPbhl+yAOvvb9WyejQVrN8ASA+sApTEgdMZq6SPqZhELIactT8GnHZBZ
        uIWRAL7abBYC1cEV/DH66sGw4D2Lopy0ffjVfSU2sL589ol0WjYdso9YEnZbAJgshi96MRmYIcN4T
        M7T5cXgp059iRV3fT/LBqwIz+iHcW+zMZezLX9zlniZYb6laU4PicbHSn8m5Ny2ZF0RvzrAL9dkie
        o4kQrizef23/6Gs5w98dW4KM1QAVnkE69Pi5hqMpkQpCWGf1lxQRjpzbA6D4cy+tAiHzgQAZHMNRj
        9bKuHTPQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l70Cf-00FZxS-Kf; Tue, 02 Feb 2021 18:15:06 +0000
Date:   Tue, 2 Feb 2021 18:15:05 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        daniel.lll@alibaba-inc.com,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Subject: Re: [PATCH 06/14] cxl/mem: Add basic IOCTL interface
Message-ID: <20210202181505.GF3708021@infradead.org>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-7-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210130002438.1872527-7-ben.widawsky@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> +#if defined(__cplusplus)
> +extern "C" {
> +#endif

This has no business in a kernel header.
