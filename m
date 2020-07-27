Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DA722EC31
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jul 2020 14:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgG0Mbf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jul 2020 08:31:35 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2536 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727078AbgG0Mbf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Jul 2020 08:31:35 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 064B5A8BB5A575217348;
        Mon, 27 Jul 2020 13:31:34 +0100 (IST)
Received: from localhost (10.52.121.176) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Mon, 27 Jul
 2020 13:31:33 +0100
Date:   Mon, 27 Jul 2020 13:30:10 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Sean V Kelley <sean.v.kelley@intel.com>
CC:     <bhelgaas@google.com>, <rjw@rjwysocki.net>, <ashok.raj@kernel.org>,
        <tony.luck@intel.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [RFC PATCH 2/9] PCI: Extend Root Port Driver to support RCEC
Message-ID: <20200727133010.00003de8@Huawei.com>
In-Reply-To: <20200724172223.145608-3-sean.v.kelley@intel.com>
References: <20200724172223.145608-1-sean.v.kelley@intel.com>
        <20200724172223.145608-3-sean.v.kelley@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.176]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 24 Jul 2020 10:22:16 -0700
Sean V Kelley <sean.v.kelley@intel.com> wrote:

> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> 
> If a Root Complex Integrated Endpoint (RCiEP) is implemented, errors may
> optionally be sent to a corresponding Root Complex Event Collector (RCEC).
> Each RCiEP must be associated with no more than one RCEC. Interface errors
> are reported to the OS by RCECs.
> 
> For an RCEC (technically not a Bridge), error messages "received" from
> associated RCiEPs must be enabled for "transmission" in order to cause a
> System Error via the Root Control register or (when the Advanced Error
> Reporting Capability is present) reporting via the Root Error Command
> register and logging in the Root Error Status register and Error Source
> Identification register.
> 
> Given the commonality with Root Ports and the need to also support AER
> and PME services for RCECs, extend the Root Port driver to support RCEC
> devices through the addition of the RCEC Class ID to the driver
> structure.
> 
Hi.

I'm surprised it ended up this simple :) Seems we are a bit lucky that
the existing code is rather flexible on what is there and what isn't
and that there is never any reason to directly touch the various
type1 specific registers (given as I read the spec, an RCEC uses a
type0 config space header unlike the ports).

Given you mention PME, it's probably worth noting (I think) you aren't
actually enabling the service yet as there is a check in that path on whether we
have a root port or not.
https://elixir.bootlin.com/linux/v5.8-rc4/source/drivers/pci/pcie/portdrv_core.c#L241

Thanks,

Jonathan


> Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> ---
>  drivers/pci/pcie/portdrv_pci.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index 3acf151ae015..d5b109499b10 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -106,7 +106,8 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
>  	if (!pci_is_pcie(dev) ||
>  	    ((pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
>  	     (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM) &&
> -	     (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)))
> +	     (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM) &&
> +	     (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC)))
>  		return -ENODEV;
>  
>  	status = pcie_port_device_register(dev);
> @@ -195,6 +196,8 @@ static const struct pci_device_id port_pci_ids[] = {
>  	{ PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0) },
>  	/* subtractive decode PCI-to-PCI bridge, class type is 060401h */
>  	{ PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x01), ~0) },
> +	/* handle any Root Complex Event Collector */
> +	{ PCI_DEVICE_CLASS(((PCI_CLASS_SYSTEM_RCEC << 8) | 0x00), ~0) },
>  	{ },
>  };
>  


