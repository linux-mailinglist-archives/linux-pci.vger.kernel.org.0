Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F17D253DCF
	for <lists+linux-pci@lfdr.de>; Thu, 27 Aug 2020 08:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgH0GeY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Aug 2020 02:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgH0GeY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Aug 2020 02:34:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21199C061262;
        Wed, 26 Aug 2020 23:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZEAL8yhDmv2NOt8eGkltoZbbAq9aMUTNBk5Kd3S4jBM=; b=P4pIzY3CpH/94U0enuaerI0h69
        /UQ6n1pRAhhMhmdU08FxcNMwhZsl7SaQTptgvn3rIleLvzXeN78/6B7w62uIi699Fvij7n19iozCa
        VPK2XhcZgNffEcuNji2JoHLRVvy6qQ3AVK31lf9w4ScqgWUNmCxIboj0ty4y6usPFvgQm4k6UeeAR
        xvCPPqr0OpAwiFt/xAUGEBqeHiFRYDfpDNCwXNzRy8YwuO1rivio9iFqbjMkDPcG6lTsIO3TEeRn9
        TxUyPLL2jAw8dzv4Rg82GtWlsjUMDbW3cvHGep8uw3iSRcrEaOpYzP8HuyLT8/XmKAvrY8hr+GZHg
        XUNC14NA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBBU6-0003d2-QG; Thu, 27 Aug 2020 06:34:06 +0000
Date:   Thu, 27 Aug 2020 07:34:06 +0100
From:   "hch@infradead.org" <hch@infradead.org>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "wangxiongfeng2@huawei.com" <wangxiongfeng2@huawei.com>,
        "kw@linux.com" <kw@linux.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "Mario.Limonciello@dell.com" <Mario.Limonciello@dell.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Huffman, Amber" <amber.huffman@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] PCI/ASPM: Enable ASPM for links under VMD domain
Message-ID: <20200827063406.GA13738@infradead.org>
References: <20200821123222.32093-1-kai.heng.feng@canonical.com>
 <20200825062320.GA27116@infradead.org>
 <cd5aa2fef13f14b30c139d03d5256cf93c7195dc.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd5aa2fef13f14b30c139d03d5256cf93c7195dc.camel@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 26, 2020 at 09:43:27PM +0000, Derrick, Jonathan wrote:
> Feel free to review my set to disable the MSI remapping which will make
> it perform as well as direct-attached:
> 
> https://patchwork.kernel.org/project/linux-pci/list/?series=325681

So that then we have to deal with your schemes to make individual
device direct assignment work in a convoluted way?  Please just give us
a disable nob for VMD, which solves _all_ these problems without adding
any.
