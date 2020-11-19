Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAEC22B9DB4
	for <lists+linux-pci@lfdr.de>; Thu, 19 Nov 2020 23:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgKSWhv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Nov 2020 17:37:51 -0500
Received: from mga04.intel.com ([192.55.52.120]:26974 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbgKSWhv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Nov 2020 17:37:51 -0500
IronPort-SDR: 55q3q+wacyKVyF0WjdGf8dCQ6ka0t89Y+6dcDIIOQBu/ySOknbcsSzTKz5Fh9k3ABs8Z+KpC1J
 f+5MwVKSH3Dw==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="168805132"
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="168805132"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 14:37:51 -0800
IronPort-SDR: d4T97rmbY0L8esIcJlOGkqP/BzD8jnR6xVae0OqWaxD6m7KelDgtHPzLffNagR6K+OBlj40t8G
 EDBd7X2WOPxg==
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="360197014"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 14:37:51 -0800
Date:   Thu, 19 Nov 2020 14:37:49 -0800
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>,
        linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 1/1] pci: pciehp: Handle MRL interrupts to enable slot
 for hotplug.
Message-ID: <20201119223749.GA103783@otc-nc-03>
References: <20201119220807.GB102444@otc-nc-03>
 <20201119222741.GA206150@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119222741.GA206150@bjorn-Precision-5520>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 19, 2020 at 04:27:41PM -0600, Bjorn Helgaas wrote:
> Hi Ashok,
> 
> When you update this patch, can you run "git log --oneline
> drivers/pci/hotplug/pciehp*" and make yours match?  It is a severe
> character defect of mine, but seeing subject lines that are obviously

:-)

> different than the convention is a disincentive to look at the patch.
> 

Thanks for the reminder. forgot the cap the PCI, and some inadvertant '.'
at the end of the line...

Will fix when i resend. 
