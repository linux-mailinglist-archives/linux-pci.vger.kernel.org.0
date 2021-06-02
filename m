Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77939398295
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jun 2021 09:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhFBHHW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Jun 2021 03:07:22 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:34981 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbhFBHHW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Jun 2021 03:07:22 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 05A9E102F019C;
        Wed,  2 Jun 2021 09:05:36 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id BEF893D1E91; Wed,  2 Jun 2021 09:05:35 +0200 (CEST)
Date:   Wed, 2 Jun 2021 09:05:35 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>, kw@linux.com
Subject: Re: [PATCH v2] Add support for PCIe SSD status LED management
Message-ID: <20210602070535.GA16825@wunner.de>
References: <20210601203820.3647-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601203820.3647-1-stuart.w.hayes@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 01, 2021 at 04:38:20PM -0400, Stuart Hayes wrote:
> --- /dev/null
> +++ b/drivers/pci/pcie-ssd-leds.c

Since this is a PCIe-specific feature, it should probably live in the
pcie/ subdirectory.  Or in drivers/nvme/.


> +static bool pdev_has_dsm(struct pci_dev *pdev)
> +{
> +	acpi_handle handle;
> +
> +	handle = ACPI_HANDLE(&pdev->dev);
> +	if (!handle)
> +		return false;
> +
> +	return acpi_check_dsm(handle, &pcie_ssdleds_dsm_guid, 0x1,
> +			      1 << GET_SUPPORTED_STATES_DSM ||
> +			      1 << GET_STATE_DSM ||
> +			      1 << SET_STATE_DSM);
> +}

Would it be possible to bail out early if pdev->class !=
PCI_CLASS_STORAGE_EXPRESS (or something like that), thus avoiding
the overhead of an ACPI namespace search for *every* PCI device?

Thanks,

Lukas
