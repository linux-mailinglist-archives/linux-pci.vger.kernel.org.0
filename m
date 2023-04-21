Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358DC6EB30C
	for <lists+linux-pci@lfdr.de>; Fri, 21 Apr 2023 22:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjDUUvV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Apr 2023 16:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjDUUvT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Apr 2023 16:51:19 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34BB1FD8
        for <linux-pci@vger.kernel.org>; Fri, 21 Apr 2023 13:51:17 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 446B4300037FF;
        Fri, 21 Apr 2023 22:51:14 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 3909E171760; Fri, 21 Apr 2023 22:51:14 +0200 (CEST)
Date:   Fri, 21 Apr 2023 22:51:14 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>, oohall@gmail.com,
        Chris Chiu <chris.chiu@canonical.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Stanislav Spassov <stanspas@amazon.de>,
        Yang Su <yang.su@linux.alibaba.com>,
        shuo.tan@linux.alibaba.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4] PCI/PM: Shorten pci_bridge_wait_for_secondary_bus()
 wait time for slow links
Message-ID: <20230421205114.GA24809@wunner.de>
References: <20230418072808.10431-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418072808.10431-1-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 18, 2023 at 10:28:08AM +0300, Mika Westerberg wrote:
> With slow links (<= 5GT/s) active link reporting is not mandatory, so if
> a device is disconnected during system sleep we might end up waiting for
> it to respond for ~60s slowing down resume time. PCIe spec r6.0 sec
> 6.6.1 mandates that the system software must wait for at least 1s before
> it can determine the device as brokine device so use the minimum
                                 ^^^^^^^
				 broken


> @@ -5027,14 +5032,29 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
>  	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
>  		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
>  		msleep(delay);
> -	} else {
> -		pci_dbg(dev, "waiting %d ms for downstream link, after activation\n",
> -			delay);
> -		if (!pcie_wait_for_link_delay(dev, true, delay)) {
> -			/* Did not train, no need to wait any further */
> -			pci_info(dev, "Data Link Layer Link Active not set in 1000 msec\n");
> -			return -ENOTTY;
> +
> +		/*
> +		 * If the port supports active link reporting we now check
> +		 * whether the link is active and if not bail out early with
> +		 * the assumption that the device is not present anymore.
> +		 */
> +		if (dev->link_active_reporting) {
> +			u16 status;
> +
> +			pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &status);
> +			if (!(status & PCI_EXP_LNKSTA_DLLLA))
> +				return -ENOTTY;
>  		}
> +
> +		return pci_dev_wait(child, reset_type, PCI_RESET_WAIT - delay);
> +	}

So above in the Gen1/Gen2 case (<= 5 GT/s), a delay of 100 msec is afforded
and if the link isn't up by then, the function returns an error.

Doesn't that violate PCIe r6.0.1 sec 6.6.1 that states:

 "system software must allow at least 1.0 s following exit from a
  Conventional Reset of a device, before determining that the device
  is broken if it fails to return a Successful Completion status for
  a valid Configuration Request.  This period is independent of how
  quickly Link training completes."

I think what we can do here is:

		if (!pci_dev_wait(child, reset_type, PCI_RESET_WAIT - delay))
			return 0;

		if (!dev->link_active_reporting)
			return -ENOTTY;

		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &status);
		if (!(status & PCI_EXP_LNKSTA_DLLLA))
			return -ENOTTY;

		return pci_dev_wait(child, reset_type,
				    PCIE_RESET_READY_POLL_MS - PCI_RESET_WAIT);

In other words, if link active reporting is unsupported, we can only
afford the 1 second prescribed by the spec and that's it.  If the
subordinate device is still inaccessible after that, reset recovery
failed.

If link active reporting is supported and the link is up, then we know
the device is accessible but may need more time.  In that case the
full 60 seconds are afforded.

Does that make sense?

Thanks,

Lukas
