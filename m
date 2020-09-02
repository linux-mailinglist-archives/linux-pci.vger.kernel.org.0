Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F27525B6C4
	for <lists+linux-pci@lfdr.de>; Thu,  3 Sep 2020 00:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgIBWyu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 18:54:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbgIBWyu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Sep 2020 18:54:50 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [129.253.182.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3AD02078E;
        Wed,  2 Sep 2020 22:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599087288;
        bh=1hW5kK/Njw86oLEnRxfrgC0dQ6uHQ5uW+j2YeKTOfco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ggliH6W8V3O+VQRG6Wbx2htraCrN+um/4joPY1T1lhD92f4ORXXvwbpLqURZ/ma4c
         vHKpruHPmtZcN4Y2THfRfn5hrIIlRezEgl922fvOGb6JTr4ZMu8Cv6k0N8pCF5RtM8
         YLKkIFUo8wnIwplAgCuOQfSXeiXnujIePzXXkGBA=
Date:   Thu, 3 Sep 2020 07:54:39 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     David Fugate <david.fugate@linux.intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        jonathan.derrick@intel.com, Mario.Limonciello@dell.com,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Krzysztof Wilczynski <kw@linux.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Huffman, Amber" <amber.huffman@intel.com>, david.fugate@intel.com
Subject: Re: [PATCH] PCI/ASPM: Enable ASPM for links under VMD domain
Message-ID: <20200902225439.GA24219@redsun51.ssa.fujisawa.hgst.com>
References: <20200821123222.32093-1-kai.heng.feng@canonical.com>
 <20200825062320.GA27116@infradead.org>
 <08080FC7-861B-472A-BD7D-02D33926677F@canonical.com>
 <20200825065634.GA2691@infradead.org>
 <c19782e36c9b4a8319f2f16102e1823dc6a33d3c.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c19782e36c9b4a8319f2f16102e1823dc6a33d3c.camel@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 02, 2020 at 01:48:19PM -0600, David Fugate wrote:
> Over the years, I've been forwarded numerous emails from VMD customers 
> praising it's ability to prevent Linux kernel panics upon hot-removals
> and inserts of U.2 NVMe drives.

The same nvme and pcie hotplug drivers are used with or without VMD
enabled. Where are the bug reports for linux kernel panics? We have a
very real interest in fixing such issues.
