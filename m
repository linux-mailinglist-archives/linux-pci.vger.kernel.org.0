Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDA9D1887B7
	for <lists+linux-pci@lfdr.de>; Tue, 17 Mar 2020 15:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgCQOmD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Mar 2020 10:42:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60842 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgCQOmD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Mar 2020 10:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=14Ep8nPwTW69hdxdwx0Pwg1JDQYGgrnW8Ny5LzdsxBc=; b=HOs+JxpvYBCkgDmwv+5iG+dOi4
        8EJ8KcjNhyQUxEFHwyqfQ7/MUEcP3PL8bm3jCRRxNA3jnyUK8zGVA6d7u3nbS6X1lIb4qAxgIohmR
        IpH+02eTW/URyAYOc3lZr/L/EEriXjK1Bgj0Cvtf5xr9CmR/DBT7x/0bayWeT42MWiUCJ8Zuhhw7V
        mmCYZb2aUys94kBHp9EzpzU3z6fwyMHPt8peCI6C0AGYAvjcw3f0HCooaahiDnSlEEfTw+DKzUMt4
        DbOfHff0NOlt2wZaRQaI52uQ0XDx4guYB1lHTSewuQ0ORR7hQHeSlmp8xnQN2dOijEfQ+rCJknpOZ
        LnEhlS4w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEDPv-00069M-9x; Tue, 17 Mar 2020 14:42:03 +0000
Date:   Tue, 17 Mar 2020 07:42:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
Subject: Re: [PATCH v17 06/12] Documentation: PCI: Remove reset_link
 references
Message-ID: <20200317144203.GE23471@infradead.org>
References: <cover.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <a46938d227f6a11c010943800450a10aac39b7d3.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a46938d227f6a11c010943800450a10aac39b7d3.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 03, 2020 at 06:36:29PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> After pcie_do_recovery() refactor, instead of reset_link
> member in struct pcie_port_service_driver, we use reset_cb
> callback parameter in pcie_do_recovery() function to pass
> the service driver specific reset_link function. So modify
> the Documentation to reflect the latest changes.

This should be folded into the patch removing the method.
