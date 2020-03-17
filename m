Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7911887AF
	for <lists+linux-pci@lfdr.de>; Tue, 17 Mar 2020 15:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgCQOlA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Mar 2020 10:41:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60734 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgCQOk7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Mar 2020 10:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+ci629dFV1rA4mLXf3zjaClioHEx9UgTdwzd1ogshHs=; b=YOlyWR8ytPC95fzKsiOd+1TMNv
        TCGqD+NRiNGvQ1VDhnIcEXYSDRnwVSJmE9Dd1T/fPjVsbYaJgnGIDplkxovodJ4bsurE9KDEm78+R
        CM1KtLZxwOOfhsKdjW4w9QUW+ULCxg/pZUmE/5HK/Jsv+bwa0Fugil9lboln477qNXE/v/8SEe5+M
        bxQZ1hqyg7j+Io4zwxSEoLEeBh7OTOj1dzv3V0EcxyPn8F04ze1TnGioml3ZXvRtVnKYL/lYxOPMj
        /B5uILjEorrw+rj0eeDlrCdWTn2kLtzV8Va5I6uTeiGrX4M++N20l3w0guycwKFgQ94x/GGpZ/D6A
        LerHow9A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEDOr-000655-OI; Tue, 17 Mar 2020 14:40:57 +0000
Date:   Tue, 17 Mar 2020 07:40:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
Subject: Re: [PATCH v17 03/12] PCI/ERR: Remove service dependency in
 pcie_do_recovery()
Message-ID: <20200317144057.GC23471@infradead.org>
References: <cover.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <152c530a3ca8780ae85c2325f97f5f35f5d3602f.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152c530a3ca8780ae85c2325f97f5f35f5d3602f.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -static pci_ers_result_t reset_link(struct pci_dev *dev, u32 service)
> +static pci_ers_result_t reset_link(struct pci_dev *dev,
> +			pci_ers_result_t (*reset_cb)(struct pci_dev *pdev))
>  {
>  	pci_ers_result_t status;
> -	struct pcie_port_service_driver *driver = NULL;
>  
> -	driver = pcie_port_find_service(dev, service);
> -	if (driver && driver->reset_link) {
> -		status = driver->reset_link(dev);
> +	if (reset_cb) {
> +		status = reset_cb(dev);

As far as I can tell reset_cb is never NULL.  So all the code below
is dead, and the remainder of reset_link is so trivial that it can
be inlined into the only caller.
