Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBA06E35E2
	for <lists+linux-pci@lfdr.de>; Sun, 16 Apr 2023 09:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjDPHsz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 16 Apr 2023 03:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjDPHsu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 16 Apr 2023 03:48:50 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F532123
        for <linux-pci@vger.kernel.org>; Sun, 16 Apr 2023 00:48:48 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 6119A3000452E;
        Sun, 16 Apr 2023 09:48:46 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 4EC4D12BC1B; Sun, 16 Apr 2023 09:48:46 +0200 (CEST)
Date:   Sun, 16 Apr 2023 09:48:46 +0200
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
Message-ID: <20230416074846.GA14021@wunner.de>
References: <20230413101642.8724-1-mika.westerberg@linux.intel.com>
 <20230414074238.GA22973@wunner.de>
 <20230414101147.GA66750@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414101147.GA66750@black.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 14, 2023 at 01:11:47PM +0300, Mika Westerberg wrote:
> To summarize the v4 patch would look something like below. Only compile
> tested but I will run real testing later today. I think it now includes
> the 1s optimization and also checking of the active link reporting
> support for the devices behind slow links. Let me know is I missed
> something.

The patch seems to be based on a branch which has the v3 patch applied
instead of on pci.git/reset, and that makes it slightly more difficult
to review, but from a first glance it LGTM.


> It is getting rather complex unfortunately :(

I disagree. :)  Basically the Gen1/Gen2 situation becomes a special case
because it has specific timing requirements (need to observe a delay
before accessing the Secondary Bus, instead of waiting for the link)
and it doesn't necessarily support link active reporting.  So special
casing it seems fair to me.


> -	 * However, 100 ms is the minimum and the PCIe spec says the
> -	 * software must allow at least 1s before it can determine that the
> -	 * device that did not respond is a broken device. There is
> -	 * evidence that 100 ms is not always enough, for example certain
> -	 * Titan Ridge xHCI controller does not always respond to
> -	 * configuration requests if we only wait for 100 ms (see
> -	 * https://bugzilla.kernel.org/show_bug.cgi?id=203885).
> +	 * However, 100 ms is the minimum and the PCIe spec says the software
> +	 * must allow at least 1s before it can determine that the device that
> +	 * did not respond is a broken device. Also device can take longer than
> +	 * that to respond if it indicates so through Request Retry Status
> +	 * completions.

It *might* be worth avoiding the rewrapping of the first 3 lines to
make the patch smaller, your choice.


> +
> +		/*
> +		 * If the port supports active link reporting we now check one
> +		 * more time if the link is active and if not bail out early
> +		 * with the assumption that the device is not present anymore.
> +		 */

Nit:  Drop the "one more time" because it seems this is actually the
first time the link is checked.


Somewhat tangentially, I note that pcie_wait_for_link_delay() has a
"if (!pdev->link_active_reporting)" branch right at its top, however
pci_bridge_wait_for_secondary_bus() only calls the function in the
Gen3+ (> 5 GT/s) case, which always supports link active reporting.

Thus the branch is never taken when pcie_wait_for_link_delay() is called
from pci_bridge_wait_for_secondary_bus().  There's only one other caller,
pcie_wait_for_link().  So moving the "if (!pdev->link_active_reporting)"
branch to pcie_wait_for_link() *might* make the code more readable.
Just a thought.

Thanks,

Lukas
