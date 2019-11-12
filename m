Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19AFDF91FD
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2019 15:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbfKLOYH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Nov 2019 09:24:07 -0500
Received: from mga12.intel.com ([192.55.52.136]:55938 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbfKLOYH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Nov 2019 09:24:07 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2019 06:24:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,296,1569308400"; 
   d="scan'208";a="214091908"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 12 Nov 2019 06:24:03 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 12 Nov 2019 16:24:03 +0200
Date:   Tue, 12 Nov 2019 16:24:02 +0200
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH 1/1] PCI: Fix bug resulting in double hpmemsize being
 assigned to MMIO window
Message-ID: <20191112142402.GA34425@lahna.fi.intel.com>
References: <PS2P216MB07554FF63C34AFBCE04BD55D80780@PS2P216MB0755.KORP216.PROD.OUTLOOK.COM>
 <20191112093953.GD2644@lahna.fi.intel.com>
 <PS2P216MB0755753A471700A4418008C880770@PS2P216MB0755.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PS2P216MB0755753A471700A4418008C880770@PS2P216MB0755.KORP216.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 12, 2019 at 02:17:35PM +0000, Nicholas Johnson wrote:
> > >  	if (!b_res)
> > >  		return;
> > 
> > I think it may be good to comment here that skip the resources that are
> > assigned (->parent != NULL).
> 
> Something like
> 
> /* If resource is already assigned, nothing more to do. */

This one looks good to me.
