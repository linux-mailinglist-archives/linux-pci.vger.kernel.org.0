Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA49348B5A
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 09:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhCYIQo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 04:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhCYIQY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Mar 2021 04:16:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FE4C06174A;
        Thu, 25 Mar 2021 01:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/exH9O9awcWsxCz7+eapTVCjP1xnjzd++2TmK3g0wUA=; b=mza4LLBSMR5tgg00tK6/RqwQry
        EAWd+m3DmQ5LsHRZKpQcVroIj4hHPKMXZeiDU6H8WaOSWgA3Px6N+76itUWRjbryxa4/LU5SIjTi4
        kvOAg5i2hzYGoVV88qRszX0+ZYbQV2Oj460JUXXQc/Nf4PqndcOxoEzXahqHyolGihggvuIyBmkjc
        vdRP9Kv8oS1sskhHLDQ7mVC4ucvxbxolI7CPsrMYx3Ud13XsNnHJHs9F7CaRYGF9XinZCMZrBb6eO
        XWEvbq7mPzOiPd92WTnq8e0rKsrRKASUqwZ71WJTXp8wY5EldPpCxwS8yjlommcB3dE2wgohUPhsp
        vQJgoTpQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lPL9n-00CWsM-Ov; Thu, 25 Mar 2021 08:16:05 +0000
Date:   Thu, 25 Mar 2021 08:15:55 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        ben.widawsky@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] cxl/mem: Introduce 'struct cxl_regs'
Message-ID: <20210325081555.GA2983117@infradead.org>
References: <161662142382.1723715.5934723983022398253.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161662143530.1723715.15800475088422813585.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161662143530.1723715.15800475088422813585.stgit@dwillia2-desk3.amr.corp.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 24, 2021 at 02:30:35PM -0700, Dan Williams wrote:
> In preparation for common register mapping facility, introduce a generic
> container, 'struct cxl_regs', for CXL device register and later
> component register block base pointers. Some CXL device types implement
> both.

The code looks like complete gibberish to me with a struct of a union of
a struct declaring members in a macro.  This needs a much more detailed
explanation and rationale.
