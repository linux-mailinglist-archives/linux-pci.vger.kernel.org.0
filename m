Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3823ACF8A3
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2019 13:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730608AbfJHLiz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Oct 2019 07:38:55 -0400
Received: from mga18.intel.com ([134.134.136.126]:23830 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730371AbfJHLiy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Oct 2019 07:38:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 04:38:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,270,1566889200"; 
   d="scan'208";a="206621037"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 08 Oct 2019 04:38:51 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 08 Oct 2019 14:38:50 +0300
Date:   Tue, 8 Oct 2019 14:38:50 +0300
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH v8 2/6] PCI: In extend_bridge_window() change available
 to new_size
Message-ID: <20191008113850.GG2819@lahna.fi.intel.com>
References: <SL2P216MB0187C2C1536E8AA6CD318FDF80C00@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SL2P216MB0187C2C1536E8AA6CD318FDF80C00@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 26, 2019 at 12:53:41PM +0000, Nicholas Johnson wrote:
> In extend_bridge_window() change "available" parameter name to new_size.
> This makes more sense as this parameter represents the new size for the
> window.
> 
> Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
