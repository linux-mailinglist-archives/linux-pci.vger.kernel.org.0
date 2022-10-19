Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C02604F95
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 20:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJSS0Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 14:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiJSS0Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 14:26:24 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845461BF872
        for <linux-pci@vger.kernel.org>; Wed, 19 Oct 2022 11:26:23 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E55B45C0071;
        Wed, 19 Oct 2022 14:26:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 19 Oct 2022 14:26:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1666203979; x=1666290379; bh=o1zIHbl3OT
        sSV5EeNLYMhV03inFVomukhuIwvEz/ABQ=; b=a1ecQD4cauKUlB2Jv+G9SIT2YF
        ui7yG2v+IJfPd5Iqi1fKp4jce3sGprMVq5a0ThRN8iFd3GO9pJDpSFVjw+5cNDnm
        4vFweeCrqiw2ZLOZoXRWYsQgSnyOH8X/WEoTVs5BwvP3LVea3OwTVvZwzFIDqJKV
        qstVxyiOLwJOdLqvVCYsYxwrsmG6GlokQkL0WE/BWmrd9/aTu7GmGG2wNGIFfcko
        0/Fnx36+W3pagKlCZs0FI+Ac5lywWw9AfsFtI3Mir1doq4ezPxIZg470eorcePCa
        iSrevOEj92ttlYlMESbHmKyy/0u1sRSKPtUlBuOwta4bhsUzoZaj+WdfdHrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666203979; x=1666290379; bh=o1zIHbl3OTsSV5EeNLYMhV03inFV
        omukhuIwvEz/ABQ=; b=MhySkoLZwtvtPHRLx6dt9a9XPlyuB/rlTdabJRQWwrbe
        VEFNg0nfnHVbp7PX2FZlt5QjsElQ1qD4Ax6T7uGf3P9WDMvecxVRrN3hVJTSHZcz
        JcZu2Fwi/spez+QVnctDjzAYzRnXCqdaS0/oUwkvfU7nWq3QEuN2sohGLCDWaOjv
        J8wTvrr773c7YtlAAiOvc4vqN1mkt6N2mrz3fTYdJraLg/F9aJu9YSAhajt44MqU
        YfNsrK46C7j6iwaQtflABBeOUH1zbDnUnNpStwD+3siCZGkmCbQzKWakmb/79sr2
        RPXuQINRwHIkpjyZMOd8NfeEd98uMQkTq+5ziYxd2g==
X-ME-Sender: <xms:S0FQY_CA_S1gpKiaQNJ1-oM01HH-2EypLMmhZRqNhnbpzHm7ZMs-jA>
    <xme:S0FQY1ii_Zt-cJVp_5iKM8V-L_BMr5sITcK4h-bH-uG_yeodYYn7-ktlrRJ-dYyQe
    OeWS3LzCcKKbud8Rsc>
X-ME-Received: <xmr:S0FQY6mHWTvtztO6L07LMqJi7_sjwZ8OfXt-ghFej7_HZo0T6h_eQE-sLoE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeelgedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhihl
    vghrucfjihgtkhhsuceotghouggvsehthihhihgtkhhsrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvhedvtddthfefhfdtgfelheefgefgudejueevkeduveekvdegjedttdefgfel
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtoh
    guvgesthihhhhitghkshdrtghomh
X-ME-Proxy: <xmx:S0FQYxwFsJeOa3vxwfl31YNj6R0N0CJwge0syZJUiczXyoYoMZ9n3w>
    <xmx:S0FQY0QZnfRAfd60ysnbHET8DrC7AIf5a8spDF9aj0G8jxM85YVaUQ>
    <xmx:S0FQY0Z2LQ_Tr7DgTBP_E5D2OhBgIgT8giQHwzt_vFIUEBhXkVMWug>
    <xmx:S0FQY6ceGKmDCAZwzbLi-npQNh7QcrKEMKQjHyVekG4KNcG6hcr4Bg>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Oct 2022 14:26:19 -0400 (EDT)
Date:   Wed, 19 Oct 2022 13:25:59 -0500
From:   Tyler Hicks <code@tyhicks.com>
To:     bhelgaas@google.com, Keith Busch <kbusch@kernel.org>
Cc:     linux-pci@vger.kernel.org, Zhiqiang Hou <Zhiqiang.Hou@nxp.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH] PCI: Align MPS to upstream bridge for SAFE and
 PERFORMANCE mode
Message-ID: <20221019182559.yjnd2z6lhbvptwr3@sequoia>
References: <20220610150131.6256-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610150131.6256-1-Zhiqiang.Hou@nxp.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-06-10 23:01:31, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> The commit 27d868b5e6cf ("PCI: Set MPS to match upstream bridge")

Adding Keith, as the author of that commit.

> made the device's MPS matches upstream bridge for PCIE_BUS_DEFAULT
> mode, so that it's more likely that a hot-added device will work in
> a system with an optimized MPS configuration.
> 
> Obviously, the Linux itself optimizes the MPS settings in the
> PCIE_BUS_SAFE and PCIE_BUS_PERFORMANCE mode, so let's do this also
> for these modes.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---

I wanted to give a little more information about the issue we're seeing.
We're having trouble retaining the optimized Max Payload Size (MPS)
value of a PCIe endpoint after hotplug/rescan. In this case,
`pcie_ports=native` and `pci=pcie_bus_safe` are set on the cmdline and
we expect the Linux kernel to retain the MPS value. Commit 27d868b5e6cf
preserved the MPS value when using the default PCIe bus mode
(PCIE_BUS_DEFAULT) and we're hopeful that this can be extended to other
modes, as well.

Tyler

>  drivers/pci/probe.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 17a969942d37..2c5a1aefd9cb 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2034,7 +2034,9 @@ static void pci_configure_mps(struct pci_dev *dev)
>  	 * Fancier MPS configuration is done later by
>  	 * pcie_bus_configure_settings()
>  	 */
> -	if (pcie_bus_config != PCIE_BUS_DEFAULT)
> +	if (pcie_bus_config != PCIE_BUS_DEFAULT &&
> +	    pcie_bus_config != PCIE_BUS_SAFE &&
> +	    pcie_bus_config != PCIE_BUS_PERFORMANCE)
>  		return;
>  
>  	mpss = 128 << dev->pcie_mpss;
> @@ -2047,7 +2049,7 @@ static void pci_configure_mps(struct pci_dev *dev)
>  
>  	rc = pcie_set_mps(dev, p_mps);
>  	if (rc) {
> -		pci_warn(dev, "can't set Max Payload Size to %d; if necessary, use \"pci=pcie_bus_safe\" and report a bug\n",
> +		pci_warn(dev, "can't set Max Payload Size to %d; if necessary, use \"pci=pcie_bus_peer2peer\" and report a bug\n",
>  			 p_mps);
>  		return;
>  	}
> -- 
> 2.17.1
> 
