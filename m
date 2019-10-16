Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6F0D88C7
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2019 08:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732011AbfJPGwf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 02:52:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48166 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfJPGwf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Oct 2019 02:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uMAZZRys5GkzQMBlqs8w/J6ZliGfuWbMK7Pk12sLaUw=; b=GpyqjUPum5gD6lqhhmAKF9cBC
        GX/YKd8exF9pGkmAoBwrCiaWKufls/xApL1uDV/uul9f3KpM+0kqCbT6hIyPQCjgNnGIJTZl07Lw/
        jYZR6yJdsUgxb+mveZlQt+00clzw1/lgUN4/SehVlz+HL2C5Nx2Qn6Bm2YrzQVjcCZlfWnIHvzcR3
        FoOKhpJ9kNM97ARiXodDohQA/wDPfnlnoWJp84+b4ppCmSvqHJ4+igh64kfHSCF8tR/cxlDzH0+9u
        Qh6XQdHpJCRJ9AKLMUuKR41/BdwXyO1syMRkQmE2XTOV2njok98kn1Hz5+zzH8mkJsSLe1NsBqAMo
        GhJECqXPQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKdAg-000227-1j; Wed, 16 Oct 2019 06:52:34 +0000
Date:   Tue, 15 Oct 2019 23:52:34 -0700
From:   'Christoph Hellwig' <hch@infradead.org>
To:     Pankaj Dubey <pankaj.dubey@samsung.com>
Cc:     'Christoph Hellwig' <hch@infradead.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        andrew.murray@arm.com, lorenzo.pieralisi@arm.com,
        gustavo.pimentel@synopsys.com, jingoohan1@gmail.com,
        vidyas@nvidia.com, 'Anvesh Salveru' <anvesh.s@samsung.com>
Subject: Re: [PATCH v3] PCI: dwc: Add support to add GEN3 related
 equalization quirks
Message-ID: <20191016065234.GA6825@infradead.org>
References: <CGME20191015025933epcas5p1f0891dacc13648559ed8e037e49ee5b1@epcas5p1.samsung.com>
 <1571108362-25962-1-git-send-email-pankaj.dubey@samsung.com>
 <20191015081620.GA28204@infradead.org>
 <068001d58336$a76ed970$f64c8c50$@samsung.com>
 <20191015090547.GA7199@infradead.org>
 <000e01d5836b$ac871190$059534b0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000e01d5836b$ac871190$059534b0$@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 15, 2019 at 08:47:32PM +0530, Pankaj Dubey wrote:
> OK, but do we think the current driver has only code which is being used by
> some user?

That is at least the intent of how we do kernel development. 

> At least I can see current driver has some features which is not being used
> by any current driver.  

Please send patches to remove them.
