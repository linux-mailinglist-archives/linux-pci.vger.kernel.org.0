Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD14468C951
	for <lists+linux-pci@lfdr.de>; Mon,  6 Feb 2023 23:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjBFW1Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Feb 2023 17:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBFW1Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 17:27:25 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E27813D49
        for <linux-pci@vger.kernel.org>; Mon,  6 Feb 2023 14:27:24 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 7D50630000CE2;
        Mon,  6 Feb 2023 23:27:22 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 64FF12F90FD; Mon,  6 Feb 2023 23:27:22 +0100 (CET)
Date:   Mon, 6 Feb 2023 23:27:22 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, rafael@kernel.org, bhelgaas@google.com,
        robert.moore@intel.com
Subject: Re: [PATCH 10/18] PCI: Export pcie_get_speed() using the code from
 sysfs PCI link speed show function
Message-ID: <20230206222722.GC21823@wunner.de>
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
 <167571665075.587790.11513782507200128278.stgit@djiang5-mobl3.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167571665075.587790.11513782507200128278.stgit@djiang5-mobl3.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 06, 2023 at 01:50:52PM -0700, Dave Jiang wrote:
> Move the logic in current_link_speed_show() to a common function and export
> that functiuon as pcie_get_speed() to allow other drivers to to retrieve
> the current negotiated link speed.
[...]
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6215,6 +6215,26 @@ enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL(pcie_get_width_cap);
>  
> +/**
> + * pcie_get_speed - query for the PCI device's current link speed
> + * @dev: PCI device to query
> + *
> + * Query the PCI device current link speed.
> + */
> +enum pci_bus_speed pcie_get_speed(struct pci_dev *dev)
> +{
> +	u16 linkstat, cls;
> +	int err;
> +
> +	err = pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &linkstat);
> +	if (err)
> +		return PCI_SPEED_UNKNOWN;
> +
> +	cls = FIELD_GET(PCI_EXP_LNKSTA_CLS, linkstat);
> +	return pcie_link_speed[cls];
> +}
> +EXPORT_SYMBOL(pcie_get_speed);

It seems we're already caching the current speed in dev->bus->cur_bus_speed.
Is that not sufficient?  If it isn't, that should be explained in the
commit message.

Thanks,

Lukas
