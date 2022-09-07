Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FDB5B0ED5
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 23:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiIGVFo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Sep 2022 17:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiIGVFn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Sep 2022 17:05:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFB02529E;
        Wed,  7 Sep 2022 14:05:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE6EE61A4E;
        Wed,  7 Sep 2022 21:05:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF1BC433C1;
        Wed,  7 Sep 2022 21:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662584742;
        bh=g89Y1k2o37z4XvQht9X7eSvdZSvYxyRuWDgrnXpCuHo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Okf7h1wnsxKTzxt8+CnMQBR0g646AZKlkLkgwuNXLaKUoDv2nAZvGPYXM1hWvRGJa
         s+2iFJvEkUYUnyxfzPGAx39iDHZH8St19iWiko9c3oa7KO0DLaboVNm+/zBaXnQGa9
         T2C+TfPAUdQZmcof06MyUmWTTxHdBSIUJIVav347TpSF9ClYBrAFKaqir5KBAjvJdx
         sGpUcIMFN5GNL80GXjc7wOM9q/SpchBRuLYU0rgUcjUjaskLU6BvIJEZmRCXtKay7i
         eKOrlSWbZQygvRXDdfsCyXQkcr31LiuioiMxs9yObWem1qUNkIWfc7oiIKlp/Y44uX
         bDef0oCDVjgMw==
Date:   Wed, 7 Sep 2022 16:05:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        refactormyself@gmail.com, kw@linux.com, rajatja@google.com,
        kenny@panix.com, kai.heng.feng@canonical.com, treding@nvidia.com,
        jonathanh@nvidia.com, abhsahu@nvidia.com, sagupta@nvidia.com,
        benchuanggli@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V3] PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume
Message-ID: <20220907210540.GA140988@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826125526.28859-1-vidyas@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 26, 2022 at 06:25:26PM +0530, Vidya Sagar wrote:
> Previously ASPM L1 Substates control registers (CTL1 and CTL2) weren't
> saved and restored during suspend/resume leading to L1 Substates
> configuration being lost post-resume.
> 
> Save the L1 Substates control registers so that the configuration is
> retained post-resume.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V3:
> * Disabled L1.2 enable fields while restoring Control-1 register

This really looks promising!  Has somebody confirmed that the
disappearing L1SS capability problem doesn't happen here?

> +void pci_save_aspm_l1ss_state(struct pci_dev *dev)
> +{
> +	int aspm_l1ss;
> +	struct pci_cap_saved_state *save_state;
> +	u32 *cap;
> +
> +	if (!pci_is_pcie(dev))
> +		return;
> +
> +	aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
> +	if (!aspm_l1ss)
> +		return;

Isn't it enough to check this?

  if (!dev->l1ss)
    return;

> +void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
> +{
> +	int aspm_l1ss;
> +	struct pci_cap_saved_state *save_state;
> +	u32 *cap, l1_2_enable;
> +
> +	if (!pci_is_pcie(dev))
> +		return;
> +
> +	aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
> +	if (!aspm_l1ss)
> +		return;
> +
> +	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
> +	if (!save_state)
> +		return;
> +
> +	cap = (u32 *)&save_state->cap.data[0];
> +	pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, *cap++);
> +	/* Disable L1.2 while updating.  See PCIe r5.0, sec 5.5.4, 7.8.3.3 */
> +	l1_2_enable = *cap & PCI_L1SS_CTL1_L1_2_MASK;
> +	pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1,
> +			       (*cap & ~PCI_L1SS_CTL1_L1_2_MASK));
> +	if (l1_2_enable)
> +		pci_clear_and_set_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, 0,
> +					l1_2_enable);
> +}

What if we did something like the following?  Then we wouldn't have to
duplicate the fancy logic in aspm_calc_l1ss_info() and
pci_restore_aspm_l1ss_state(), and we'd only need the big comment in
one place.

+static void aspm_program_l1ss(struct pci_dev *dev, u32 ctl1, u32 ctl2)
+{
+	u16 l1ss = dev->l1ss;
+	u32 l1_2_enable;
+
+	/*
+	 * Per PCIe r6.0, sec 5.5.4, T_POWER_ON in PCI_L1SS_CTL2 must be
+	 * programmed prior to setting the L1.2 enable bits in PCI_L1SS_CTL1.
+	 */
+	pci_write_config_dword(dev, l1ss + PCI_L1SS_CTL2, ctl2);
+
+	/*
+	 * In addition, Common_Mode_Restore_Time and LTR_L1.2_THRESHOLD in
+	 * PCI_L1SS_CTL1 must be programmed *before* setting the L1.2
+	 * enable bits, even though they're all in PCI_L1SS_CTL1.
+	 */
+	l1_2_enable = ctl1 & PCI_L1SS_CTL1_L1_2_MASK;
+	ctl1 &= ~PCI_L1SS_CTL1_L1_2_MASK;
+
+	pci_write_config_dword(dev, l1ss + PCI_L1SS_CTL1, ctl1);
+	if (l1_2_enable)
+		pci_write_config_dword(dev, l1ss + PCI_L1SS_CTL1,
+				       ctl1 | l1_2_enable);
+}

(This is somewhat simplified from what aspm_calc_l1ss_info() does
today.  It looks to me like aspm_calc_l1ss_info() does more config
reads than necessary.)
