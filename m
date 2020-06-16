Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2BE1FC235
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jun 2020 01:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgFPXUW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jun 2020 19:20:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgFPXUV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Jun 2020 19:20:21 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B618A207DD;
        Tue, 16 Jun 2020 23:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592349621;
        bh=tiK4KMdA62onp2wByWby+/bwJDYFvHk4Oek1Xrw3dFA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=D7HZDgKlntaC82ZPfQik/dwZOJzJT8jigSpJ6AyIV8lHA6Cg/pM1zhcrNrtBna2A7
         kwoDrlCmjaOCGTlzlQzpNBUXNCxV/ZBZyNFuk9Yb6KlzTl7Us1ydVRQaEVUwryEqso
         wVt0aaNxTPk4+CMop//V+SdFwLsaSU0gEfDhcg3E=
Date:   Tue, 16 Jun 2020 18:20:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net, bp@alien8.de,
        james.morse@arm.com, lenb@kernel.org, tony.luck@intel.com,
        dan.carpenter@oracle.com, zhangliguang@linux.alibaba.com,
        andriy.shevchenko@linux.intel.com, wangkefeng.wang@huawei.com,
        jroedel@suse.de, yangyicong@hisilicon.com,
        jonathan.cameron@huawei.com, tanxiaofei@huawei.com
Subject: Re: [PATCH v9 2/2] PCI: hip: Add handling of HiSilicon HIP PCIe
 controller errors
Message-ID: <20200616232019.GA1987909@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615101552.802-3-shiju.jose@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 15, 2020 at 11:15:52AM +0100, Shiju Jose wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> The HiSilicon HIP PCIe controller is capable of handling errors
> on root port and perform port reset separately at each root port.
> 
> Add error handling driver for HIP PCIe controller to log
> and report recoverable errors. Perform root port reset and restore
> link status after the recovery.
> 
> Following are some of the PCIe controller's recoverable errors
> 1. completion transmission timeout error.
> 2. CRS retry counter over the threshold error.
> 3. ECC 2 bit errors
> 4. AXI bresponse/rresponse errors etc.

> +static int hisi_pcie_notify_error(struct notifier_block *nb,
> +				  unsigned long event, void *data)
> +{
> +	struct acpi_hest_generic_data *gdata = data;
> +	const struct hisi_pcie_error_data *error_data =
> +				acpi_hest_get_payload(gdata);
> +	struct hisi_pcie_error_private *priv =
> +			container_of(nb, struct hisi_pcie_error_private, nb);
> +	struct platform_device *pdev = priv->pdev;
> +	struct device *dev = &pdev->dev;
> +	u8 socket;
> +
> +	if (device_property_read_u8(dev, "socket", &socket))
> +		return NOTIFY_DONE;
> +
> +	if (!guid_equal((guid_t *)gdata->section_type, &hisi_pcie_sec_type) ||
> +	    error_data->socket_id != socket)
> +		return NOTIFY_DONE;

I think you have to verify the GUID first before you can even safely
extract a struct hisi_pcie_error_private from the payload:

  if (!guid_equal(...))
    return NOTIFY_DONE;

  priv = container_of(nb, struct hisi_pcie_error_private, nb);
  pdev = priv->pdev;
  dev = &pdev->dev;

  if (device_property_read_u8(dev, "socket", &socket))
    return NOTIFY_DONE;

  if (error_data->socket_id != socket)
    return NOTIFY_DONE;

> +	hisi_pcie_handle_error(pdev, error_data);
> +
> +	return NOTIFY_OK;
> +}
