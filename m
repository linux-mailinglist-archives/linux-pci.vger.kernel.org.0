Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F859AA5AE
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 16:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388337AbfIEOXC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 10:23:02 -0400
Received: from foss.arm.com ([217.140.110.172]:46036 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbfIEOXB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Sep 2019 10:23:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1637028;
        Thu,  5 Sep 2019 07:23:01 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 596C33F67D;
        Thu,  5 Sep 2019 07:23:00 -0700 (PDT)
Date:   Thu, 5 Sep 2019 15:22:58 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Jonathan Chocron <jonnyc@amazon.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        robh+dt@kernel.org, mark.rutland@arm.com, dwmw@amazon.co.uk,
        benh@kernel.crashing.org, alisaidi@amazon.com, ronenk@amazon.com,
        barakw@amazon.com, talel@amazon.com, hanochu@amazon.com,
        hhhawa@amazon.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 3/7] PCI/VPD: Prevent VPD access for Amazon's
 Annapurna Labs Root Port
Message-ID: <20190905142258.GB9720@e119886-lin.cambridge.arm.com>
References: <20190905140018.5139-1-jonnyc@amazon.com>
 <20190905140018.5139-4-jonnyc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905140018.5139-4-jonnyc@amazon.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 05, 2019 at 05:00:17PM +0300, Jonathan Chocron wrote:
> The Amazon Annapurna Labs PCIe Root Port exposes the VPD capability,
> but there is no actual support for it.
> 
> Trying to access the VPD (for example, as part of lspci -vv or when
> reading the vpd sysfs file), results in the following warning print:
> 
> pcieport 0001:00:00.0: VPD access failed.  This is likely a firmware bug on this device.  Contact the card vendor for a firmware update
> 
> Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
> Reviewed-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

> ---
>  drivers/pci/vpd.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index 4963c2e2bd4c..7915d10f9aa1 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -571,6 +571,12 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005f, quirk_blacklist_vpd);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, PCI_ANY_ID,
>  		quirk_blacklist_vpd);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_QLOGIC, 0x2261, quirk_blacklist_vpd);
> +/*
> + * The Amazon Annapurna Labs 0x0031 device id is reused for other non Root Port
> + * device types, so the quirk is registered for the PCI_CLASS_BRIDGE_PCI class.
> + */
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031,
> +			      PCI_CLASS_BRIDGE_PCI, 8, quirk_blacklist_vpd);
>  
>  /*
>   * For Broadcom 5706, 5708, 5709 rev. A nics, any read beyond the
> -- 
> 2.17.1
> 
