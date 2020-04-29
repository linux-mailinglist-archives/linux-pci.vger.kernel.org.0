Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACB11BE1D4
	for <lists+linux-pci@lfdr.de>; Wed, 29 Apr 2020 16:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgD2O5G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Apr 2020 10:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgD2O5G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Apr 2020 10:57:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D448C03C1AD
        for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2020 07:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ORDa7mJYYLP9+fQfQAPW/jM5Ga4mCeO5xNMFMxhT/iY=; b=CwCOvhhJgce2KJMQnVmrJ9+Z/W
        daETCRZd4yHkplpTZ8M1mOR9DlF66iqRsBWA03JJjQwBLEiTTPESMuNDfzuiGGB1p0kuQxU/M/ppq
        JtCFdXULKHrWPRiLHknZRyBlZsBNh63WQ1v5qiytd7MdSpYB0O7f5nf39h44GJuTALTwacVhBs7yd
        rq+mlK+qRNgTMkOGz1KL+23RnXD5kwj3Zy8fwj7SRupUlZi1zZ8LBBXK20Fa7SY3OMGMQNB3iLaux
        h38qYICO/L59uOJet/k1a2RJWTTDVZmJhL7GeL5YSxsNOkuyrtMUuRkK+A9T/Cod+o/6brC8N/qAp
        NdKW7xSg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTo91-0001hk-J2; Wed, 29 Apr 2020 14:57:03 +0000
Date:   Wed, 29 Apr 2020 07:57:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Daire.McNamara@microchip.com
Cc:     hch@infradead.org, amurray@thegoodpenguin.co.uk,
        lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org,
        helgaas@kernel.org
Subject: Re: [PATCH v8 0/1] PCI: microchip: Add host driver for Microchip
 PCIe controller
Message-ID: <20200429145703.GB26461@infradead.org>
References: <a71cee05633ffac508366d66ca23a467716b14b7.camel@microchip.com>
 <20200429111120.GA19649@infradead.org>
 <0570e334b4816aef76be9e71e132eac5d14cd43f.camel@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0570e334b4816aef76be9e71e132eac5d14cd43f.camel@microchip.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 29, 2020 at 02:44:05PM +0000, Daire.McNamara@microchip.com wrote:
> > why?
> The PCIe hardware is only available on 64-bit RISCV based platforms at the moment.  Our intention is to extend the driver, at a later date, as and when the hardware becomes available.
> 

I'll let the actual PCIe maintainer speak, but normally we try to
allow drivers to build on all platforms unless they have an actual
code platform depency.  And as far as I can tell this driver doesn't
actually depend on RISC-V specific code.
