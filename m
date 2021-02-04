Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3C030F01C
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 11:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbhBDKCw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 05:02:52 -0500
Received: from mga18.intel.com ([134.134.136.126]:54608 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235311AbhBDKCw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Feb 2021 05:02:52 -0500
IronPort-SDR: DML6KJDCdzdxSaKV5Jna17Du1Na0/zX3H8u93E3Jqlh8onrPtNlw0g6eZXRL67Ew4FS70tqyGc
 wST/7tUbqhFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="168891043"
X-IronPort-AV: E=Sophos;i="5.79,400,1602572400"; 
   d="scan'208";a="168891043"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:00:27 -0800
IronPort-SDR: d9DO6uJzTaVOLuyXyQdxvftReSl/DDuhgEf6H1pUjEWlXGCebIGLGLReSR95sBMVRSRWCJv9E6
 TzUUK0TQt30Q==
X-IronPort-AV: E=Sophos;i="5.79,400,1602572400"; 
   d="scan'208";a="393090013"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:00:23 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 04 Feb 2021 12:00:21 +0200
Date:   Thu, 4 Feb 2021 12:00:21 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     mingchuang.qiao@mediatek.com
Cc:     bhelgaas@google.com, matthias.bgg@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, haijun.liu@mediatek.com,
        lambert.wang@mediatek.com, kerun.zhu@mediatek.com,
        alex.williamson@redhat.com, rjw@rjwysocki.net,
        utkarsh.h.patel@intel.com
Subject: Re: [v4] PCI: Avoid unsync of LTR mechanism configuration
Message-ID: <20210204100021.GA2542@lahna.fi.intel.com>
References: <20210204095125.9212-1-mingchuang.qiao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204095125.9212-1-mingchuang.qiao@mediatek.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 04, 2021 at 05:51:25PM +0800, mingchuang.qiao@mediatek.com wrote:
> From: Mingchuang Qiao <mingchuang.qiao@mediatek.com>
> 
> In bus scan flow, the "LTR Mechanism Enable" bit of DEVCTL2 register is
> configured in pci_configure_ltr(). If device and bridge both support LTR
> mechanism, the "LTR Mechanism Enable" bit of device and bridge will be
> enabled in DEVCTL2 register. And pci_dev->ltr_path will be set as 1.
> 
> If PCIe link goes down when device resets, the "LTR Mechanism Enable" bit
> of bridge will change to 0 according to PCIe r5.0, sec 7.5.3.16. However,
> the pci_dev->ltr_path value of bridge is still 1.
> 
> For following conditions, check and re-configure "LTR Mechanism Enable" bit
> of bridge to make "LTR Mechanism Enable" bit match ltr_path value.
>    -before configuring device's LTR for hot-remove/hot-add
>    -before restoring device's DEVCTL2 register when restore device state
> 
> Signed-off-by: Mingchuang Qiao <mingchuang.qiao@mediatek.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
