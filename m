Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969F330E0A4
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 18:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhBCRNO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 12:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhBCRNM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Feb 2021 12:13:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAD6C061573;
        Wed,  3 Feb 2021 09:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TOHrz9rJRmT1MZjmRcdSp7+GuY9P+OtZtUJvbJgCulo=; b=QlTPVhm61sGQuTcf3P0iNWT8ED
        Bi2gkvv6DDeJQwV2HZj+zq53XZjee6QmF+jgW/E4anVOGeBwLE0OhGlE/INHWoFljCKhZx4kLuKFi
        vBpPlOiPaIYrUSdcPkchYs5y8EocLYDkgBQi5zK2utgiNqo1gFusaNMlddnGX4lCKct1oIiIfQN0x
        4FZFsAcm9c0hrwdS+WY55lmm+xjte1BQs5jszrftBaCW8zuTfPkpbQPL1wxnyHoTRZuCOgTwdKSQC
        PmSjukh2Zy50HgX10fdq7MOFixROv7xKlGJkbVoqgE9rz6+csO3TxasqOuAu242s0FMgsIu5s/vvZ
        pnxR5IZg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l7LhT-00HEZu-Qm; Wed, 03 Feb 2021 17:12:20 +0000
Date:   Wed, 3 Feb 2021 17:12:19 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-cxl@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
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
Subject: Re: [PATCH 02/14] cxl/mem: Map memory device registers
Message-ID: <20210203171219.GA4104698@infradead.org>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-3-ben.widawsky@intel.com>
 <20210202180441.GC3708021@infradead.org>
 <20210202183151.7kwruvip7nshqsc4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202183151.7kwruvip7nshqsc4@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 02, 2021 at 10:31:51AM -0800, Ben Widawsky wrote:
> > > +		if (reg_type == CXL_REGLOC_RBI_MEMDEV) {
> > > +			rc = 0;
> > > +			cxlm = cxl_mem_create(pdev, reg_lo, reg_hi);
> > > +			if (!cxlm)
> > > +				rc = -ENODEV;
> > > +			break;
> > 
> > And given that we're going to grow more types eventually, why not start
> > out with a switch here?  Also why return the structure when nothing
> > uses it?
> 
>  We've (Intel) already started working on the libnvdimm integration which does
>  change this around a bit. In order to go with what's best tested though, I've
>  chosen to use this as is for merge. Many different people not just in Intel
>  have tested these codepaths. The resulting code moves the check on register
>  type out of this function entirely.
> 
>  If you'd like me to make it a switch, I can, but it's going to be extracted
>  later anyway.

This was just a suggestion.  No hard feelings, it's just that the code
looks a little odd to me.
