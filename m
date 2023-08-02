Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492B376D388
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 18:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjHBQT7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 12:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjHBQT6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 12:19:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C032019AD;
        Wed,  2 Aug 2023 09:19:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55BFB61A39;
        Wed,  2 Aug 2023 16:19:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B059C433C9;
        Wed,  2 Aug 2023 16:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690993195;
        bh=QTwasRuhNebEV2x038dVhKhR/ojnqWPqXsBjFOvKkoo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VmYKxiz2lH82VF3/Bh1HznBLPf0W8KvQ7pBRWT8k4Z+w6V3WuH1GTVLPq/Ub3JGMs
         Kr3DPgEej2Tx35mcn+2ZYGEu3MjL0FuGAs7bDXrBTvP2cJiezprBmoqEPmNNQBunbG
         sNLzDiE760QgvDIf0vxzftb+u+Oc7UH71tOWm2bHi7ZQplXI81FHmaTkGUBCqrQiY/
         5WdM1X7iFK7kPJ5QfhqOEtkrcNamn50Rh/9fSH18K7JmkBdjOgvEj1kpf7WkVcUIhx
         VrBkWHIjhtV4/p2Z3BtJsaqSrXhVo02c7o35nymFRDXAsND573IWJuStxcB6vRKpHR
         HhVTrl3lAzkFg==
Date:   Wed, 2 Aug 2023 11:19:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Achal Verma <a-verma1@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: cadence: Set the AFS bit in Device Capabilities 2
 Register
Message-ID: <20230802161953.GA60043@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802103059.3492181-1-a-verma1@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In subject, "Advertise ARI Forwarding Supported".

It's not obvious that "AFS" refers to ARI Forwarding Supported, and
the bit name is enough; we don't need to know that it's in Dev Cap 2.
"Advertise" shows that we're just *advertising* the functionality, not
*enabling* it.

On Wed, Aug 02, 2023 at 04:00:59PM +0530, Achal Verma wrote:
> J7 PCIe Root Complex has ARI Forwarding Support, means supporting
> forwarding of TLPs addressed to functions with function number greater than
> 7 but some PCIe instances on J7 have this bit cleared which results in
> failure of forwarding of TLPs destined for function number > 7.
> Setting the AFS bit in Device Capabilities 2 Register explicitly, resolves
> the issue and leads to successful access to function number > 7.

s/AFS/ARI Forwarding Supported/

> Some observations:
> 1. J7200-EVB has single PCIe instance(PCIe1) for which ARIFwd bit is not
>    set. Enumeration gracefully fails for funciton number greater than 7 but
>    later read/write access to these funcitons results in a crash.

By "ARIFwd bit" here, I assume you mean PCI_EXP_DEVCAP2_ARI in the Root
Port?  Maybe you can use the #define to make this more greppable.

s/funciton/function/ (twice)

If we don't enumerate function numbers greater than 7, we shouldn't
have pci_dev structs for them, so why are there later read/write
config accesses to them?

If the Root Port doesn't advertise ARI Forwarding Supported,
bridge->ari_enabled will not be set, and we shouldn't even try to
enumerate functions greater than 7.  So it's not that enumeration
*fails*; it just doesn't happen at all.

> 2. On J721E-EVB, PCIe1 instance has ARIFwd bit set while it is cleared for
>    PCIe0 instance. This issue combined with errata i2086
>    (Unsupported Request (UR) Response Results in External Abort) results in
>    SERROR while scanning multi-function endpoint device.

Is the SERROR when scanning under PCIe0 or under PCIe1?

I'm not clear on what's happening here:

  1) Root Port advertises PCI_EXP_DEVCAP2_ARI, we set
     bridge->ari_enabled and scan functions > 7, we do a config read
     to function 8, get a UR response (as expected during enumeration)
     and that results in SERROR?

  2) Root Port *doesn't* advertise PCI_EXP_DEVCAP2_ARI, we don't set
     bridge->ari_enabled, so we don't try config read to function 8,
     and something blows up later?

  3) Something else?

> @@ -507,6 +507,7 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>  	struct cdns_pcie *pcie;
>  	struct resource *res;
>  	int ret;
> +	u32 pcie_cap2;
>  
>  	bridge = pci_host_bridge_from_priv(rc);
>  	if (!bridge)
> @@ -536,6 +537,12 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>  	if (rc->quirk_detect_quiet_flag)
>  		cdns_pcie_detect_quiet_min_delay_set(&rc->pcie);
>  
> +	if (rc->set_afs_bit) {
> +		pcie_cap2 = cdns_pcie_rp_readl(pcie, CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_DEVCAP2);
> +		pcie_cap2 |= PCI_EXP_DEVCAP2_ARI;
> +		cdns_pcie_rp_writel(pcie, CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_DEVCAP2, pcie_cap2);
> +	}

This seems like a j721e defect; why does the workaround need to be in
the generic cadence code?

Bjorn
