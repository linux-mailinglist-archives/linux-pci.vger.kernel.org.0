Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F872D37F3
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 01:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbgLIAsG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 19:48:06 -0500
Received: from mga01.intel.com ([192.55.52.88]:29718 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727844AbgLIAsG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Dec 2020 19:48:06 -0500
IronPort-SDR: xIOSwYxowER5c7U2Iw0H6SFq9UDwtwNBgeaxwrKGr1eWB9edNwzlEgshnwG8cBgAXLLk5dYmDc
 SbcSq7baWqkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="192295311"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="192295311"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 16:47:15 -0800
IronPort-SDR: 8VyqTDO8zOgqA/wLT0gU2tOdrdWtwvOXlKTrJhxSQM+6DNLg7q5KKB/4Ruz5L++eFZVOGFAR05
 /97RfSc9dFwg==
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="363898098"
Received: from mlubyani-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.137.9])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 16:47:14 -0800
Date:   Tue, 8 Dec 2020 16:47:13 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH v2 00/14] CXL 2.0 Support
Message-ID: <20201209004713.xvwz2cklwccamnny@intel.com>
References: <20201209002418.1976362-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209002418.1976362-1-ben.widawsky@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20-12-08 16:24:04, Ben Widawsky wrote:

[snip]

This is available on gitlab here: https://gitlab.com/bwidawsk/linux/-/tree/cxl-2.0v2
