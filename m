Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE07F337E
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 16:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKGPhh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 10:37:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33820 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfKGPhh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Nov 2019 10:37:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nGydLSsGxxmYrXGAw15Q8ycWDwl66hdCC3wCq7d7wXo=; b=bb6vI2fUQXVprSJX8mvHLWV0T
        qchAtG7zVD0aBCE9cQ+hgInMVqiVVtfX09jGUsqDkk4NpqCn09loxwLv48gsLbQnWgPvHf3HXF98s
        N//TD6YaMcBV4UPlu7REWBJxd2xHSwAbEQ5dXBj/5wgh31RbTeOS/IV/5We12Pb/N2b1qLZmr/GgF
        aF/uuUF8mixSFtrk0UomvYF2r8RGsCodfdc93wVqdE1mcC32D+9G2T9Xpx246w76UfWmze2sSwbZb
        /mri3tMLAjoALYoJGSskZk+GKM9qTPURjvcEGNYKRWvTnyeyr864SiOj8WMKYmPL24A6g2rQ6SSTj
        GyJ+2GijA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSjqq-0004Fj-2m; Thu, 07 Nov 2019 15:37:36 +0000
Date:   Thu, 7 Nov 2019 07:37:36 -0800
From:   "hch@infradead.org" <hch@infradead.org>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH 0/3] PCI: vmd: Reducing tail latency by affining to the
 storage stack
Message-ID: <20191107153736.GA16006@infradead.org>
References: <1573040408-3831-1-git-send-email-jonathan.derrick@intel.com>
 <20191107093952.GA13826@infradead.org>
 <bfc69a54dc394ffb7580d14818047ec6a647536f.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfc69a54dc394ffb7580d14818047ec6a647536f.camel@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 07, 2019 at 02:12:50PM +0000, Derrick, Jonathan wrote:
> > How does this compare to simplify disabling VMD?
> 
> It's a moot point since Keith pointed out a few flaws with this set,
> however disabling VMD is not an option for users who wish to
> passthrough VMD

And why would you ever pass through vmd instead of the actual device?
That just makes things go slower and adds zero value.
