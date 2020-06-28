Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7AEF20C81C
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jun 2020 14:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgF1M5J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Jun 2020 08:57:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6325 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726316AbgF1M5J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 28 Jun 2020 08:57:09 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 93E6FCA98DCAF57D9E6B;
        Sun, 28 Jun 2020 20:57:06 +0800 (CST)
Received: from [10.65.58.147] (10.65.58.147) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Sun, 28 Jun 2020
 20:57:04 +0800
Subject: Re: [PATCH v2 2/2] PCI/ERR: Add reset support for non fatal errors
To:     <sathyanarayanan.kuppuswamy@linux.intel.com>, <bhelgaas@google.com>
References: <ce417fbf81a8a46a89535f44b9224ee9fbb55a29.1591307288.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <18ab6cc7b34dab7630978195248ea031540ba9f1.1591307288.git.sathyanarayanan.kuppuswamy@linux.intel.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ashok.raj@intel.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <75280d1a-da68-10b8-de20-615e9243390e@hisilicon.com>
Date:   Sun, 28 Jun 2020 20:57:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <18ab6cc7b34dab7630978195248ea031540ba9f1.1591307288.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sathy,

one minor comments below.

On 2020/6/5 5:50, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
> PCI_ERS_RESULT_NEED_RESET error status implies the device is
> requesting a slot reset and a notification about slot reset
> completion via ->slot_reset() callback.
>
> But in non-fatal errors case, if report_error_detected() or
> report_mmio_enabled() functions requests PCI_ERS_RESULT_NEED_RESET
> then current pcie_do_recovery() implementation does not do the
> requested explicit slot reset, instead just calls the ->slot_reset()
> callback on all affected devices. Notifying about the slot reset
> completion without resetting it incorrect. So add this support.
>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/pci/pcie/err.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 5fe8561c7185..94d1c2ff7b40 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -206,6 +206,9 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  		 * functions to reset slot before calling
>  		 * drivers' slot_reset callbacks?
>  		 */
> +		if (state != pci_channel_io_frozen)
> +			pci_reset_bus(dev);
> +

If it's the implementation to reset the slot, should we remove the TODO comments?
JYI.

Thanks,
Yicong


>  		status = PCI_ERS_RESULT_RECOVERED;
>  		pci_dbg(dev, "broadcast slot_reset message\n");
>  		pci_walk_bus(bus, report_slot_reset, &status);

