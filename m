Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA8725B4BA
	for <lists+linux-pci@lfdr.de>; Wed,  2 Sep 2020 21:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgIBTsX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 15:48:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:35112 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgIBTsX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Sep 2020 15:48:23 -0400
IronPort-SDR: 6lG2wBFsSbBz5Afwdm72SDj8NoLjougRo+WktULhobQHfF5coLcOgsPep12g055gz5vqlJyelz
 9LLdDuTdEqvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="154871634"
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; 
   d="scan'208";a="154871634"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2020 12:48:21 -0700
IronPort-SDR: tVkddLVBeA3qWBhyGUc42GmgoU+ag6G++7iuZV21E5H52fVVDP3Vtow3ADwut0XYyTuy6DSASJ
 64O/boPgzHAA==
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; 
   d="scan'208";a="477769014"
Received: from unknown (HELO dwf-u18040) ([10.232.115.11])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2020 12:48:20 -0700
Message-ID: <c19782e36c9b4a8319f2f16102e1823dc6a33d3c.camel@linux.intel.com>
Subject: Re: [PATCH] PCI/ASPM: Enable ASPM for links under VMD domain
From:   David Fugate <david.fugate@linux.intel.com>
Reply-To: david.fugate@linux.intel.com
To:     Christoph Hellwig <hch@infradead.org>,
        Kai Heng Feng <kai.heng.feng@canonical.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, jonathan.derrick@intel.com,
        Mario.Limonciello@dell.com, Heiner Kallweit <hkallweit1@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Krzysztof Wilczynski <kw@linux.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Huffman, Amber" <amber.huffman@intel.com>, david.fugate@intel.com
Date:   Wed, 02 Sep 2020 13:48:19 -0600
In-Reply-To: <20200825065634.GA2691@infradead.org>
References: <20200821123222.32093-1-kai.heng.feng@canonical.com>
         <20200825062320.GA27116@infradead.org>
         <08080FC7-861B-472A-BD7D-02D33926677F@canonical.com>
         <20200825065634.GA2691@infradead.org>
Organization: Intel
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2020-08-25 at 07:56 +0100, Christoph Hellwig wrote:
> while adding absolutely no value.  Basically we have to add a large
> chunk of kernel code just to undo silicone/firmware Intel added to
> their
> platform to make things complicated.  I mean it is their platform and
> if
> they want a "make things complicated" option that is fine, but it
> should
> not be on by default.


Thanks for your feedback.

Over the years, I've been forwarded numerous emails from VMD customers 
praising it's ability to prevent Linux kernel panics upon hot-removals
and inserts of U.2 NVMe drives. Many were migrating from SATA drives,
which didn't have this issue, and considered it a showstopper to NVMe
adoption. I hope we can all agree reliable and robust hot-plug support
adds value.

