Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227843641ED
	for <lists+linux-pci@lfdr.de>; Mon, 19 Apr 2021 14:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbhDSMpX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Apr 2021 08:45:23 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39940 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhDSMpX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Apr 2021 08:45:23 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13JCimsG086768;
        Mon, 19 Apr 2021 07:44:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1618836288;
        bh=nYwebb1IXwFKgtnm2vFcxeDvsqvpQZ8aSr5dxVbRK1k=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QlgOC6WW/t4XQdAXkDTjpQjup6FSId6Y38BAvyZJCyvwUTT2qw3g4HyTn96ttxd5L
         U0ACVlCi3qT3uDYksovaMQdkZn6fLjTY6Tdmh4tx2SuLV5G16ci9BjU/9dpCq9c5Cy
         Z+4e2xV4T0Vfs2alFvvwwInSR/HqHZb9NCy8i+dM=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13JCilTn056813
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Apr 2021 07:44:47 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 19
 Apr 2021 07:44:47 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 19 Apr 2021 07:44:47 -0500
Received: from [10.250.234.34] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13JCiiSG050079;
        Mon, 19 Apr 2021 07:44:45 -0500
Subject: Re: [PATCH v4] PCI: Add quirk for preventing bus reset on TI C667X
To:     =?UTF-8?Q?Antti_J=c3=a4rvinen?= <antti.jarvinen@gmail.com>,
        <helgaas@kernel.org>
CC:     <alex.williamson@redhat.com>, <bhelgaas@google.com>,
        <kw@linux.com>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
References: <20210312210917.GA2290948@bjorn-Precision-5520>
 <20210315102606.17153-1-antti.jarvinen@gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <d7753802-4f7f-7470-1add-de44817eff5c@ti.com>
Date:   Mon, 19 Apr 2021 18:14:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210315102606.17153-1-antti.jarvinen@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 15/03/21 3:56 pm, Antti Järvinen wrote:
> Some TI KeyStone C667X devices do not support bus/hot reset. Its PCIESS
> automatically disables LTSSM when secondary bus reset is received and
> device stops working. Prevent bus reset by adding quirk_no_bus_reset to
> the device. With this change device can be assigned to VMs with VFIO,
> but it will leak state between VMs.
> 
> Reference: https://e2e.ti.com/support/processors/f/791/t/954382
> Signed-off-by: Antti Järvinen <antti.jarvinen@gmail.com>

Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/quirks.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 653660e3ba9e..d9201ad1ca39 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3578,6 +3578,16 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0034, quirk_no_bus_reset);
>   */
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CAVIUM, 0xa100, quirk_no_bus_reset);
>  
> +/*
> + * Some TI keystone C667X devices do no support bus/hot reset.
> + * Its PCIESS automatically disables LTSSM when secondary bus reset is
> + * received and device stops working. Prevent bus reset by adding
> + * quirk_no_bus_reset to the device. With this change device can be
> + * assigned to VMs with VFIO, but it will leak state between VMs.
> + * Reference https://e2e.ti.com/support/processors/f/791/t/954382
> + */
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TI, 0xb005, quirk_no_bus_reset);
> +
>  static void quirk_no_pm_reset(struct pci_dev *dev)
>  {
>  	/*
> 
