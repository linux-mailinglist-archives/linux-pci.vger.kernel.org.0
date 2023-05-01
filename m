Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C2A6F3505
	for <lists+linux-pci@lfdr.de>; Mon,  1 May 2023 19:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjEARV2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 May 2023 13:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjEARV1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 May 2023 13:21:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FCE1994
        for <linux-pci@vger.kernel.org>; Mon,  1 May 2023 10:21:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C6AC61382
        for <linux-pci@vger.kernel.org>; Mon,  1 May 2023 17:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92491C433EF;
        Mon,  1 May 2023 17:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682961676;
        bh=bw+KrDCTBO3uTsopMPF+Jqg74R5lTCzq5LMg66p/LkQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=n7Ql1jmkRAyyeRrMrAo5Ps0aGnPoWRSrYsILON00hpjxRFi298/Mp2Q0xSU9DkkXK
         iEFkB19vVoFCzF0KAZErT9fvBKoAmqDqkKb/BWl7tKmKUQo2bnuO5c5guToSzn18cd
         PIfhMDAxWLPE70vwoMhZhl9oM+HMS+tC7Z4V8FZk1gsXbskpbwrkx/TKHUgWZ4JKzS
         wzq3tN/kPuZ9xKEl8GoFptFoGpqXjhDoFoqUnks83Q89rVdGRyJhub1O3QPbV+eIra
         o+wpsk2+uMDY42DQlEWJ2Tu7uGcRbN5M7skVMww7LRYkphnqcWJQds4ff32Ld5G7aE
         zDm3CMMVIWAQQ==
Date:   Mon, 1 May 2023 12:21:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ajay Agarwal <ajayagarwal@google.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Nikhil Devshatwar <nikhilnd@google.com>,
        Manu Gautam <manugautam@google.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI/ASPM: Disable ASPM_STATE_L1 only when class
 driver disables L1 ASPM
Message-ID: <20230501172114.GA591899@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411111034.1473044-2-ajayagarwal@google.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 11, 2023 at 04:40:32PM +0530, Ajay Agarwal wrote:
> Currently the aspm driver sets ASPM_STATE_L1 as well as
> ASPM_STATE_L1SS bits when the class driver disables L1.

I would have said just "driver" -- do you mean something different by
using "class driver"?  The callers I see are garden-variety drivers
for individual devices like hci_bcm4377, xillybus_pcie, e1000e, jme,
etc.

> pcie_config_aspm_link takes care that L1ss ASPM is not enabled
> if L1 is disabled. ASPM_STATE_L1SS bits do not need to be
> explicitly set. The sysfs node store() function, which also
> modifies the aspm_disable value, does not set these bits either
> when only L1 ASPM is disabled by the user.

Right.  It'd be nice to combine __pci_disable_link_state() and
aspm_attr_store_common() so they use the same logic for this, but
that's not really trivial to do.

> Disable ASPM_STATE_L1 only when class driver disables L1 ASPM.

So IIUC, this is a cleanup and should not fix any actual function
bugs, right?  If it *does* fix a bug, we should add a Fixes: tag and a
description of the bug.

> Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> ---
>  drivers/pci/pcie/aspm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 66d7514ca111..5765b226102a 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1095,8 +1095,7 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
>  	if (state & PCIE_LINK_STATE_L0S)
>  		link->aspm_disable |= ASPM_STATE_L0S;
>  	if (state & PCIE_LINK_STATE_L1)
> -		/* L1 PM substates require L1 */
> -		link->aspm_disable |= ASPM_STATE_L1 | ASPM_STATE_L1SS;
> +		link->aspm_disable |= ASPM_STATE_L1;
>  	if (state & PCIE_LINK_STATE_L1_1)
>  		link->aspm_disable |= ASPM_STATE_L1_1;
>  	if (state & PCIE_LINK_STATE_L1_2)
> -- 
> 2.40.0.577.gac1e443424-goog
> 
