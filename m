Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24204AC7BE
	for <lists+linux-pci@lfdr.de>; Sat,  7 Sep 2019 18:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404679AbfIGQzR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 7 Sep 2019 12:55:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404220AbfIGQzR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 7 Sep 2019 12:55:17 -0400
Received: from localhost (110.8.30.213.rev.vodafone.pt [213.30.8.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D95421835;
        Sat,  7 Sep 2019 16:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567875316;
        bh=TlLJoEwLn2ES5VkyVdxeQEQAlQ/yllDzZx59oFrjxoQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b2JTq8gHyLVblbQ8WN65qSedWFrjhGB9Ug6m3RTWuvqRLloDIZsUAoJYXv9AUGVxA
         KUKTAp7Eti6jgWmm+ViLDqBVP/HE8EhiMX8brh2AewWFVO4nea5jbDLUzAZz7mspnV
         WMeli7Ngt8Ey9N04SsS9IqA0VEn1XGrznKMTeDW8=
Date:   Sat, 7 Sep 2019 11:55:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Chocron <jonnyc@amazon.com>
Cc:     lorenzo.pieralisi@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, robh+dt@kernel.org,
        mark.rutland@arm.com, andrew.murray@arm.com, dwmw@amazon.co.uk,
        benh@kernel.crashing.org, alisaidi@amazon.com, ronenk@amazon.com,
        barakw@amazon.com, talel@amazon.com, hanochu@amazon.com,
        hhhawa@amazon.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 3/7] PCI/VPD: Prevent VPD access for Amazon's
 Annapurna Labs Root Port
Message-ID: <20190907165512.GM103977@google.com>
References: <20190905140018.5139-1-jonnyc@amazon.com>
 <20190905140018.5139-4-jonnyc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905140018.5139-4-jonnyc@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 05, 2019 at 05:00:17PM +0300, Jonathan Chocron wrote:
> The Amazon Annapurna Labs PCIe Root Port exposes the VPD capability,
> but there is no actual support for it.

Oops.  Another oops for the device ID reuse mentioned below.

> Trying to access the VPD (for example, as part of lspci -vv or when
> reading the vpd sysfs file), results in the following warning print:
> 
> pcieport 0001:00:00.0: VPD access failed.  This is likely a firmware bug on this device.  Contact the card vendor for a firmware update

Thanks for not wrapping the message (keeping it together makes it
easier to grep for).  Maybe indent it two spaces since it's quoted
material.

*Is* this a firmware defect?  E.g., could firmware disable this
capability so it doesn't appear in config space, as it apparently can
for the MSI-X capability?

> Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
> Reviewed-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

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
