Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01DD59A999
	for <lists+linux-pci@lfdr.de>; Sat, 20 Aug 2022 01:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240454AbiHSXt5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Aug 2022 19:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237975AbiHSXt4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Aug 2022 19:49:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBC7108B0E;
        Fri, 19 Aug 2022 16:49:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1870B829B2;
        Fri, 19 Aug 2022 23:49:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6527CC433C1;
        Fri, 19 Aug 2022 23:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660952991;
        bh=r032yi5f7jSvbtPWAQ6XRmRvaeTLytXl9zlKYBzY9rs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TbghKOwdHLO3or8iW71wr2VfXoLtSiENChNAl0NVe6bAk9fKFDX1qC3phJOB9kawa
         GnqdFEWsHDQ+yQnEbHG77tP15/xwjoaq99jjeNwjKgvzTwweE2oBRi+YXQn2bEhYMU
         Y4b1+WL3VgxS2DY+Y7WRDK+oL0R5L3o3uVlDXXyCFAQYybVOJKiFoH1dqzV3HBxG4v
         zvcMMqpByrV0ZHx9IoEhmAz8wdAEnVeu0EQ04UlAM/KKxyy8l5XP4no+NFM80UKEuP
         5iFZ6xJQEBhEbGAukNuEApFquiVcWcXLMi3UmHbYMjt6Sibxp7siScgzYuL2QwqpGv
         RRrJWcoipOSgQ==
Date:   Fri, 19 Aug 2022 18:49:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, mika.westerberg@linux.intel.com,
        koba.ko@canonical.com,
        "David E . Box" <david.e.box@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Disable upstream port PTM during suspend
Message-ID: <20220819234949.GA2515897@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706123244.18056-1-kai.heng.feng@canonical.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 06, 2022 at 08:32:44PM +0800, Kai-Heng Feng wrote:
> On Intel Alder Lake platforms, Thunderbolt entering D3cold can cause
> some errors reported by AER:

What's the connection with Thunderbolt?  I see "thunderbolt
0000:0a:00.0" in dmesg, but I think we see that message only because
0a:00.0 happens to be in the hierarchy below the 00:1d.0 Root Port,
not specifically because it's a Thunderbolt device.

Here's the hierarchy:

  0000:00:1d.0 Root Port              to [bus 08-71]
  0000:08:00.0 Switch Upstream Port   to [bus 09-71]
  0000:09:00.0 Switch Downstream Port to [bus 0a]
  0000:0a:00.0 Endpoint (USB controller)
  0000:09:01.0 Switch Downstream Port to [bus 0b-3d]
  0000:09:02.0 Switch Downstream Port to [bus 3e]
  0000:3e:00.0 Endpoint (USB controller)
  0000:09:03.0 Switch Downstream Port to [bus 3f-71]

The error logged by 00:1d.0 is an Unsupported Request with Requester
ID 08:00.0.

I think the only relevant thing is that 08:00.0 has PTM enabled and
00:1d.0 has PTM disabled because pci_prepare_to_sleep() only disables
PTM for Root Ports.  The same thing could happen if 08:00.0 were an
Endpoint or a non-Thunderbolt Switch Upstream Port.

Is entering D3cold relevant here?  I don't know how to tell from dmesg
that we're entering D3cold.  If we actually put 08:00.0 in D3cold, I
don't think we would see the Unsupported Request because 08:00.0 can't
send PTM requests from D3cold.

> pcieport 0000:00:1d.0: AER: Uncorrected (Non-Fatal) error received: 0000:00:1d.0
> pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00100000/00004000
> pcieport 0000:00:1d.0:    [20] UnsupReq               (First)
> pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 08000052 00000000 00000000
> thunderbolt 0000:0a:00.0: AER: can't recover (no error_detected callback)
> xhci_hcd 0000:3e:00.0: AER: can't recover (no error_detected callback)
> pcieport 0000:00:1d.0: AER: device recovery failed
> 
> In addition to that, it can also block system from suspending when
> a Thunderbolt dock is attached to the same system.


> The original approach [1] is to disable AER and DPC when link is in
> L2/L3 Ready, L2 and L3, but Bjorn identified the root cause is the Unsupported
> Request:
>   - 08:00.0 sent a PTM Request Message (a Posted Request)
>   - 00:1d.0 received the PTM Request Message
>   - The link transitioned to DL_Down
>   - Per sec 2.9.1, 00:1d.0 discarded the Request and reported an
>     Unsupported Request
>   - Or, per sec 6.21.3, if 00:1d.0 received a PTM Request when its
>     own PTM Enable was clear, it would also be treated as an
>     Unsupported Request
> 
> And further: 'David did something like this [1], but just for Root Ports. That
> looks wrong to me because sec 6.21.3 says we should not have PTM enabled in an
> Upstream Port (i.e., in a downstream device like 08:00.0) unless it is already
> enabled in the Downstream Port (i.e., in the Root Port 00:1d.0).'
> 
> So also disable upstream port PTM to make the PCI driver conform to the spec
> and solve the issue.
> 
> [1] https://lore.kernel.org/all/20220408153159.106741-1-kai.heng.feng@canonical.com/
> [2] https://lore.kernel.org/all/20220422222433.GA1464120@bhelgaas/
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215453
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=216210
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: David E. Box <david.e.box@linux.intel.com>
> Cc: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/pci/pci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index cfaf40a540a82..8ba8a0e12946e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2717,7 +2717,8 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
>  	 * port to enter a lower-power PM state and the SoC to reach a
>  	 * lower-power idle state as a whole.
>  	 */
> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> +	    pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM)
>  		pci_disable_ptm(dev);
>  
>  	pci_enable_wake(dev, target_state, wakeup);
> @@ -2775,7 +2776,8 @@ int pci_finish_runtime_suspend(struct pci_dev *dev)
>  	 * port to enter a lower-power PM state and the SoC to reach a
>  	 * lower-power idle state as a whole.
>  	 */
> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> +	    pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM)
>  		pci_disable_ptm(dev);
>  
>  	__pci_enable_wake(dev, target_state, pci_dev_run_wake(dev));

What do you think of the following possible rework?  I think it's
functionally the same except that it disables PTM on Endpoints as well
as Switch Upstream Ports.


diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 95bc329e74c0..96487a9ce5bf 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2707,14 +2707,19 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
 		return -EIO;
 
 	/*
-	 * There are systems (for example, Intel mobile chips since Coffee
-	 * Lake) where the power drawn while suspended can be significantly
-	 * reduced by disabling PTM on PCIe root ports as this allows the
-	 * port to enter a lower-power PM state and the SoC to reach a
-	 * lower-power idle state as a whole.
+	 * We want to disable PTM on Root Ports because that allows some
+	 * chips, e.g., Intel mobile chips since Coffee Lake, to enter a
+	 * lower-power PM state.
+	 *
+	 * PCIe r6.0, sec 2.2.8, strongly recommends that functions support
+	 * generation of messages in non-D0 states, so we assume Switch
+	 * Upstream Ports or Endpoints may send PTM Requests while in D1,
+	 * D2, and D3hot.  A PTM message received by a Downstream Port
+	 * (including a Root Port) with PTM disabled must be treated as an
+	 * Unsupported Request (sec 6.21.3).  To prevent this error,
+	 * disable PTM in *all* devices, not just Root Ports.
 	 */
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
-		pci_disable_ptm(dev);
+	pci_disable_ptm(dev);
 
 	pci_enable_wake(dev, target_state, wakeup);
 
@@ -2764,15 +2769,8 @@ int pci_finish_runtime_suspend(struct pci_dev *dev)
 	if (target_state == PCI_POWER_ERROR)
 		return -EIO;
 
-	/*
-	 * There are systems (for example, Intel mobile chips since Coffee
-	 * Lake) where the power drawn while suspended can be significantly
-	 * reduced by disabling PTM on PCIe root ports as this allows the
-	 * port to enter a lower-power PM state and the SoC to reach a
-	 * lower-power idle state as a whole.
-	 */
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
-		pci_disable_ptm(dev);
+	/* See rationale above for disabling PTM */
+	pci_disable_ptm(dev);
 
 	__pci_enable_wake(dev, target_state, pci_dev_run_wake(dev));
 
diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index 368a254e3124..ec338470d13f 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -31,12 +31,18 @@ static void pci_ptm_info(struct pci_dev *dev)
 
 void pci_disable_ptm(struct pci_dev *dev)
 {
-	int ptm;
+	int type, ptm;
 	u16 ctrl;
 
 	if (!pci_is_pcie(dev))
 		return;
 
+	type = pci_pcie_type(dev);
+	if (!(type == PCI_EXP_TYPE_ROOT_PORT ||
+	      type == PCI_EXP_TYPE_UPSTREAM ||
+	      type == PCI_EXP_TYPE_ENDPOINT))
+		return;
+
 	ptm = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
 	if (!ptm)
 		return;
