Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842952AFB0F
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 23:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgKKWG2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 17:06:28 -0500
Received: from mga12.intel.com ([192.55.52.136]:8979 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbgKKWG1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Nov 2020 17:06:27 -0500
IronPort-SDR: llxxzmw2uFArtAUgDvjHIshI58402TE5588t1fpcB77JsKry8IZuJ4ltvTxCPoMRx8edIRGhE3
 eH3lX94fxP+w==
X-IronPort-AV: E=McAfee;i="6000,8403,9802"; a="149498458"
X-IronPort-AV: E=Sophos;i="5.77,470,1596524400"; 
   d="scan'208";a="149498458"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 14:06:26 -0800
IronPort-SDR: ac8RWsvq4E5LnlUMwOfsStZxjDxiRyEm3835faeb4v0xM7LBnH068ix2ZlsM0qM9Prri5rlKQY
 kPINUensokMQ==
X-IronPort-AV: E=Sophos;i="5.77,470,1596524400"; 
   d="scan'208";a="366390856"
Received: from fitchbe-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.129.43])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 14:06:26 -0800
Date:   Wed, 11 Nov 2020 14:06:24 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH 0/9] CXL 2.0 Support
Message-ID: <20201111220624.gpzykl4k26vylfyy@intel.com>
References: <20201111054356.793390-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111054356.793390-1-ben.widawsky@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adding a cross reference to the QEMU work since I sent those patches after this:

https://gitlab.com/bwidawsk/qemu/-/tree/cxl-2.0
https://lists.nongnu.org/archive/html/qemu-devel/2020-11/msg02886.html

[snip]

