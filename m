Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 857731085F
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2019 15:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfEANm7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 May 2019 09:42:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60634 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfEANm7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 May 2019 09:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Gtq4JmMfUCuDBcwjWVk5PupuLXw0ggotjoDtbikdPkk=; b=gsMadiN8olRQgm7Wq1P/geFIJ
        2hJz5Z+zvpfQUGlX7OtnXShz0J65tq9ganvCCKE+d7erpLzom242KngIHClvT53pmCdGGa1gCTefd
        i07swuMZR0eY7l0KOu4PFd/rD58Oh1ZyefZ82QPxHqtjFIyuqJd87qWI9s3Bf+U/450I9pwwLmpww
        2YieBqef8zDYnwKHgPuJ7DqkCz9mrbwBGJsocpVSNcny/wfFxlTwIuSDKJm7T91hIZt5JLmmhAH3S
        BWoRaVSrQhaxAKpe2Sc/1H5LOURN+OobyGwpkuzVuYHDxJh7w2y2xuUr3QIf1KEXwemuShsRqT/cH
        5aRe3T1uQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLpVh-0004ia-A4; Wed, 01 May 2019 13:42:57 +0000
Date:   Wed, 1 May 2019 06:42:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Keith Busch <keith.busch@intel.com>
Cc:     --to=Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <alex_gagniuc@dellteam.com>
Subject: Re: [PATCH] PCI/LINK: Add Kconfig option (default off)
Message-ID: <20190501134257.GA18020@infradead.org>
References: <20190501132248.26842-1-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501132248.26842-1-keith.busch@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 01, 2019 at 07:22:48AM -0600, Keith Busch wrote:
> +config PCIE_BW
> +	bool "PCI Express Bandwidth Change Notification"
> +	default n

n is the default default, no need to add it manually.
