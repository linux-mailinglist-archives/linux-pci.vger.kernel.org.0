Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98167186F5F
	for <lists+linux-pci@lfdr.de>; Mon, 16 Mar 2020 16:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732003AbgCPPxM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Mar 2020 11:53:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42350 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731994AbgCPPxM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Mar 2020 11:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x8zdJsqd2TuNRvG2kYCqg4zk6EDgjEiGz4509vOWtU8=; b=FA/FOpOag848GQSEBQ39K+RPIr
        9956vGJi4GNnoM3CPyi3prUgjsfDzWYxfhWPrEzaQj/rFRNAD9zq1IITPXTwzagEy9lnefAJd7DSJ
        W3KfRAjQvGATQKacCOT/0KfBw7e2HTV8jM2oJBtJ/dbpjOpInzeh3k6IW9XxpGiGZXU2/vWBdZesP
        q1MJ34whatk74l8N2FmnP8fqGP2HB1kfsuArONClwjvLoSPDmei22GMspaIZ5q58OBvnBGK6fv2Yy
        Mb1xGXkAFhp13x7aayyQdXgis/+JpPg/gq9rgg9nE0ajHVJ7TmRvTS94IAPfasGDNgMyd5Hk/176N
        UsBqgbtw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jDs3A-0005ro-Nm; Mon, 16 Mar 2020 15:53:08 +0000
Date:   Mon, 16 Mar 2020 08:53:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        Daniel Drake <drake@endlessm.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu/vt-d: Ignore devices with out-of-spec domain
 number
Message-ID: <20200316155308.GC18704@infradead.org>
References: <20200312060955.8523-1-baolu.lu@linux.intel.com>
 <20200312060955.8523-3-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312060955.8523-3-baolu.lu@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 12, 2020 at 02:09:55PM +0800, Lu Baolu wrote:
> @@ -128,6 +129,13 @@ dmar_alloc_pci_notify_info(struct pci_dev *dev, unsigned long event)
>  
>  	BUG_ON(dev->is_virtfn);
>  
> +	/*
> +	 * Ignore devices that have a domain number higher than what can
> +	 * be looked up in DMAR, e.g. VMD subdevices with domain 0x10000
> +	 */
> +	if (pci_domain_nr(dev->bus) > U16_MAX)

I think this needs a well documented core PCI layer function, as that
is where these "fake" domains are create.

