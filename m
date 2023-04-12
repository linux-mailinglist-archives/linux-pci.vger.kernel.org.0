Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E662B6DFEB5
	for <lists+linux-pci@lfdr.de>; Wed, 12 Apr 2023 21:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjDLTZN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Apr 2023 15:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjDLTZN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2023 15:25:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC08618C
        for <linux-pci@vger.kernel.org>; Wed, 12 Apr 2023 12:25:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7C4F6351F
        for <linux-pci@vger.kernel.org>; Wed, 12 Apr 2023 19:25:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE2DC433EF;
        Wed, 12 Apr 2023 19:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681327511;
        bh=H/n8a7FS+yfgpLJgdJr3OUZDCixzYbjB5arWZzjOILI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IKWVPyDDQ8PiA7uvqOUdS1jH5rBxn6cSVYK6l2bXHz5/1bGhvJuSmJc3SXJPAEjlV
         24J3K+IFpdQuIqHwLGKiLvn+q2J6+y5lBKyFldtyFa/EjoXTUChkyvzDLveof4otFY
         kjm/ytCvWWsOKmQZ6xa/JsKqYP2Zrm349WDje+HGkgFr7WxVDK/jmNFKn56KUaxXDB
         BzD7O/DUSaKi0rP2wAhR2EI6n5ZP29vC0ShqY2AoctoXO/CPGlzb7GZARpEC2FUD/y
         yC5mG8whC6+pugwY+mjCaG/HR/hQP/t1USXscl+jadPJN6pANrm00V5bMShiokLVFG
         pzgSUHcJ3fBcQ==
Date:   Wed, 12 Apr 2023 14:25:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>, oohall@gmail.com,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Stanislav Spassov <stanspas@amazon.de>,
        Yang Su <yang.su@linux.alibaba.com>,
        shuo.tan@linux.alibaba.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI/PM: Resume/reset wait time change
Message-ID: <20230412192509.GA69942@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412080019.GE33314@black.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 12, 2023 at 11:00:19AM +0300, Mika Westerberg wrote:
> On Tue, Apr 11, 2023 at 05:40:14PM -0500, Bjorn Helgaas wrote:
> ...

> > I'm hoping we can restructure the rest of this as mentioned in the
> > thread.  If that's not possible, can you rebase what's left on top of
> > this?
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=reset
> 
> Sure. The end result is below. I did not add the wait_for_link_active()
> because we already have the pcie_wait_for_link_delay(), and the
> msleep(100) really needs to be msleep(delay) because we extract that
> 'delay' from the device d3cold_delay which can be more than 100 ms.

Agreed about delay vs 100ms.  I used 100ms in my pidgin patch just for
simplicity.

Yeah, I think this is OK.  I think there's room for improvement around
pcie_wait_for_link_delay() because it does several things that get a
little muddled when mixed together, but your patch is fine as-is:

  - When !pdev->link_active_reporting, it ignores the "active"
    parameter and always returns true ("link is up").  It happens that
    we never wait for the link to go *down* when link_active_reporting
    isn't supported, so the behavior is fine, but this is a weird
    restriction of the interface.

  - IIUC, the 20ms delay comes from a requirement that *hardware* must
    enter LTSSM within 20ms, not software delay requirement.  Also,
    20ms only applies to devices at <= 5.0 GT/s; faster devices have
    up to 100ms.  From the spec point of view, I don't think there's a
    reason to delay config reads to the Downstream Port (we only need
    to delay config accesses to devices below), so I would argue for
    removing all this.

  - It conflates the 1000ms timeout waiting for the link to come up
    with the 100ms wait times in the spec.  AFAIK, we made up the
    1000ms number out of thin air, and I think it would be clearer to
    handle it at a separate place (as opposed to "msleep(timeout +
    delay)").

  - There's only one path (dpc_reset_link()) that waits for the link
    to go *down*.  In that case, pcie_wait_for_link() passes a delay
    of 100ms, but since active==false and spec requires that Ports
    with DPC must implement link_active_reporting, that 100ms is
    ignored.  Works like we want, but ... it feels like it relies a
    little bit too much on internal knowledge.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 0b4f3b08f780..61bf8a4b2099 100644
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

I have to smile about this: we make sure we don't wait that extra
0.1s when the overall timeout is a completely arbitrary 60s :)

Bjorn
