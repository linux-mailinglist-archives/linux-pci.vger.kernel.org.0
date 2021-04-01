Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802EC351F48
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 21:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbhDATEx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 15:04:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235132AbhDAS5z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Apr 2021 14:57:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DDCF761007;
        Thu,  1 Apr 2021 18:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617303476;
        bh=Unxdca/ucm6GHUuCU0QEVjeWMxaO2OJQzs1jTrMwUZ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QIrJ305dScy694KH1nGUF897501/QwVGsylb5+AUB696+/2VkAomsSxkO9fcGeH8Q
         LOVrsWwJg06w3BGeD156IWD1YBBgE84MuMTlJ8ftqmlCxB2j15rf7YLHo5P23fBtrX
         OaYSyNqcx9ls4fyIcQyXiaVkxVQ78/2JbqwoRH+CiVM1QlksUUfnwXNNhvWK6Vt/3H
         qiH5xIz4HvtgryhX7OFQor/RgcgqNuPDW9dTH4JFmTba2v8lXlkzmQ08bQYdbSslns
         5m7FawNJ5LciDCVClzgUkkAE1yKJ67LYBv9QHTX2p9pObX9ab0YF5Cm3rtxcRIxb38
         uuaepr6aZsR2A==
Date:   Thu, 1 Apr 2021 13:57:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2] PCI/VPD: Silence warning if optional VPD PROM is
 missing
Message-ID: <20210401185754.GA1530831@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccbc11f1-4dbb-e2c8-d0ea-559e06d4c340@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 01, 2021 at 02:03:49PM +0200, Heiner Kallweit wrote:
> Realtek RTL8169/8168/8125 NIC families indicate VPD capability and an
> optional VPD EEPROM can be connected via I2C/SPI. However I haven't
> seen any card or system with such a VPD EEPROM yet. The missing EEPROM
> causes the following warning whenever e.g. lscpi -vv is executed.
> 
> invalid short VPD tag 00 at offset 01
> 
> The warning confuses users, I think we should handle the situation more
> gentle. Therefore, if first VPD byte is read as 0x00, assume a missing
> optional VPD PROM and replace the warning with a more descriptive
> message at info level.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Looks perfect, applied to pci/vpd for v5.13, thanks!

> ---
> v2: - don't remove user info completely, replace the warning with a more
>       message at info level
> ---
>  drivers/pci/vpd.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index d1cbc5e64..48f4a9ae8 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -74,6 +74,11 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
>  	       pci_read_vpd(dev, off, 1, header) == 1) {
>  		unsigned char tag;
>  
> +		if (!header[0] && !off) {
> +			pci_info(dev, "Invalid VPD tag 00, assume missing optional VPD EPROM\n");
> +			return 0;
> +		}
> +
>  		if (header[0] & PCI_VPD_LRDT) {
>  			/* Large Resource Data Type Tag */
>  			tag = pci_vpd_lrdt_tag(header);
> -- 
> 2.31.1
> 
