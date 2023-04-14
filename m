Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF776E1D66
	for <lists+linux-pci@lfdr.de>; Fri, 14 Apr 2023 09:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjDNHmq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 03:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDNHmo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 03:42:44 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDAD4C0A
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 00:42:42 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 1C80230000085;
        Fri, 14 Apr 2023 09:42:39 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 08BA22A69; Fri, 14 Apr 2023 09:42:39 +0200 (CEST)
Date:   Fri, 14 Apr 2023 09:42:38 +0200
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
Subject: Re: [PATCH v3] PCI/PM: Bail out early in
 pci_bridge_wait_for_secondary_bus() if link is not trained
Message-ID: <20230414074238.GA22973@wunner.de>
References: <20230413101642.8724-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230413101642.8724-1-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 13, 2023 at 01:16:42PM +0300, Mika Westerberg wrote:
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5037,6 +5037,22 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
>  		}
>  	}
>  
> +	/*
> +	 * Everything above is handling the delays mandated by the PCIe r6.0
> +	 * sec 6.6.1.
> +	 *
> +	 * If the port supports active link reporting we now check one more
> +	 * time if the link is active and if not bail out early with the
> +	 * assumption that the device is not present anymore.
> +	 */
> +	if (dev->link_active_reporting) {
> +		u16 status;
> +
> +		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &status);
> +		if (!(status & PCI_EXP_LNKSTA_DLLLA))
> +			return -ENOTTY;
> +	}
> +
>  	return pci_dev_wait(child, reset_type,
>  			    PCIE_RESET_READY_POLL_MS - delay);
>  }

Hm, shouldn't the added code live in the

	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT)

branch?  For the else branch (Gen3+ devices with > 5 GT/s),
we've already waited for the link to become active, so the
additional check seems superfluous.  (But maybe I'm missing
something.)

I also note that this documentation change has been dropped
vis-à-vis v1 of the patch, not sure if that's intentional:

-	* However, 100 ms is the minimum and the PCIe spec says the
-	* software must allow at least 1s before it can determine that the
-	* device that did not respond is a broken device. There is
-	* evidence that 100 ms is not always enough, for example certain
-	* Titan Ridge xHCI controller does not always respond to
-	* configuration requests if we only wait for 100 ms (see
-	* https://bugzilla.kernel.org/show_bug.cgi?id=203885).
+	* However, 100 ms is the minimum and the PCIe spec says the software
+	* must allow at least 1s before it can determine that the device that
+	* did not respond is a broken device. Also device can take longer than
+	* that to respond if it indicates so through Request Retry Status
+	* completions.

Thanks,

Lukas
