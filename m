Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABD85E7073
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 12:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731599AbfJ1Lbm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 07:31:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:65335 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730681AbfJ1Lbm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Oct 2019 07:31:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 04:31:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,239,1569308400"; 
   d="scan'208";a="210859145"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 28 Oct 2019 04:31:38 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 28 Oct 2019 13:31:37 +0200
Date:   Mon, 28 Oct 2019 13:31:37 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de
Subject: Re: [PATCH v4 0/3] PCI: pciehp: Do not turn off slot if presence
 comes up after link
Message-ID: <20191028113137.GW2593@lahna.fi.intel.com>
References: <20191025190047.38130-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025190047.38130-1-stuart.w.hayes@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 25, 2019 at 03:00:44PM -0400, Stuart Hayes wrote:
> Alexandru Gagniuc (2):
>   PCI: pciehp: Add support for disabling in-band presence
>   PCI: pciehp: Wait for PDS if in-band presence is disabled
> 
> Stuart Hayes (1):
>   PCI: pciehp: Add dmi table for in-band presence disabled

For the whole series,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
