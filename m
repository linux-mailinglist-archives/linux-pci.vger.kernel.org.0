Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C641773C5
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2019 23:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfGZV4D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Jul 2019 17:56:03 -0400
Received: from mga12.intel.com ([192.55.52.136]:49220 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727692AbfGZV4D (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Jul 2019 17:56:03 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 14:56:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,312,1559545200"; 
   d="scan'208";a="170771618"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jul 2019 14:56:02 -0700
Date:   Fri, 26 Jul 2019 15:53:12 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        keith.busch@intel.com
Subject: Re: [PATCH v6 0/9] Add Error Disconnect Recover (EDR) support
Message-ID: <20190726215311.GA8720@localhost.localdomain>
References: <cover.1564177080.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1564177080.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 26, 2019 at 02:43:10PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> This patchset adds support for following features:
> 
> 1. Error Disconnect Recover (EDR) support.
> 2. _OSC based negotiation support for DPC.
> 
> You can find EDR spec in the following link.
> 
> https://members.pcisig.com/wg/PCI-SIG/document/12614

Thank you for sticking with this. I've reviewed the series and I think
this looks good for the next merge window.

Acked-by: Keith Busch <keith.busch@intel.com>
