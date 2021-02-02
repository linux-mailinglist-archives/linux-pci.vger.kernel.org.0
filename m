Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1834930C8CC
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 19:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238151AbhBBSAs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 13:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238104AbhBBR67 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Feb 2021 12:58:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AD9C061573;
        Tue,  2 Feb 2021 09:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9dHe8X0M/3eLG6K/H+w57u8zHZx7qqyeZnRzALWt0zg=; b=U+HdSP7RG9UeTUyPuXewIWOgyb
        GTkbvsY8pAvpyiHEPUiLTa3r6y9nOvaqQmOiXfp+Xr2xM0ynU1/P2QNKpnzWwZhI+bnxLTvjVrXJz
        0UvQ6jwxOtAhkolAgCADzjbRJxPCxqRzsoIIoYz/milJdo7OhiV+3PHdIcCrAv0ZP9UOCtrsoPKqA
        ISI+1n1DVCsJNp5rJVz0XeyiNyRZyJQVLJTQG8jFp3MlmMyCdABN9Fr/HB3nmQ5KP3RsYYjMY8uxI
        ATzRpmieLurk15Eq4ATo8ly5fnE2P02l/3nXV7ec/Ss81zLBrCpjEii22JIsbJ7U/luDtX43EU9/Z
        S1GB44DA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l6zwA-00FYjQ-Bn; Tue, 02 Feb 2021 17:58:02 +0000
Date:   Tue, 2 Feb 2021 17:58:02 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        daniel.lll@alibaba-inc.com,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Subject: Re: [PATCH 01/14] cxl/mem: Introduce a driver for CXL-2.0-Type-3
 endpoints
Message-ID: <20210202175802.GA3708021@infradead.org>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-2-ben.widawsky@intel.com>
 <20210201173411.GD197521@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201173411.GD197521@fedora>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 01, 2021 at 12:34:11PM -0500, Konrad Rzeszutek Wilk wrote:
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> 
> Can those two comments have the same type? As in either
> stay with // or do /*.

No.  // is only intended for the SPDX comments specifically so that
they stand out.
