Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B94528D742
	for <lists+linux-pci@lfdr.de>; Wed, 14 Oct 2020 02:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbgJNAD3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Oct 2020 20:03:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:4327 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727818AbgJNAD3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Oct 2020 20:03:29 -0400
IronPort-SDR: B19hEfRlx4DWILPVtWpIxa0a+mBOibJxULlkCVVl8hUhHd0rzs7aaS78ei3SdoRdzvphBH9AdM
 1PS8eQSmSkzA==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="230182649"
X-IronPort-AV: E=Sophos;i="5.77,372,1596524400"; 
   d="scan'208";a="230182649"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 17:03:29 -0700
IronPort-SDR: QQYsMQkp6aGb7Gxor4Si6Ivc0eI7iuHZyFDcA3HB7qdu3AwfAWhGMhUnMD3Fv2GBOGvZIb1hfD
 VDAvvkTe1jnw==
X-IronPort-AV: E=Sophos;i="5.77,372,1596524400"; 
   d="scan'208";a="313990880"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 17:03:29 -0700
Date:   Tue, 13 Oct 2020 17:03:28 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Kuppuswamy Sathyanarayanan <sathyanarayanan.nkuppuswamy@gmail.com>
Cc:     bhelgaas@google.com, okaya@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v5 1/2] PCI/ERR: Call pci_bus_reset() before calling
 ->slot_reset() callback
Message-ID: <20201014000327.GA94232@otc-nc-03>
References: <162495c76c391de6e021919e2b69c5cd2dbbc22a.1602632140.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162495c76c391de6e021919e2b69c5cd2dbbc22a.1602632140.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 13, 2020 at 04:45:01PM -0700, Kuppuswamy Sathyanarayanan wrote:
> Currently if report_error_detected() or report_mmio_enabled()
> functions requests PCI_ERS_RESULT_NEED_RESET, current
> pcie_do_recovery() implementation does not do the requested
> explicit device reset, but instead just calls the
> report_slot_reset() on all affected devices. Notifying about the
> reset via report_slot_reset() without doing the actual device
> reset is incorrect. So call pci_bus_reset() before triggering
> ->slot_reset() callback.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Sinan Kaya <okaya@kernel.org>
> ---
>  Changes since v4:
>   * Added check for pci_reset_bus() return value.

Looks good!

Reviewed-by: Ashok Raj <ashok.raj@intel.com>
