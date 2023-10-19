Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3FC7CFC1D
	for <lists+linux-pci@lfdr.de>; Thu, 19 Oct 2023 16:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345961AbjJSOJW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Oct 2023 10:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345531AbjJSOJV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Oct 2023 10:09:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26B4B0;
        Thu, 19 Oct 2023 07:09:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F280C433C7;
        Thu, 19 Oct 2023 14:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697724558;
        bh=fUU2yQBsdFjq1E6XjHGGe6reCr7dtP65SbDkzgy/1+s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JuGYIRMNuTZQuep6Z6n93RnXdEOjJGvvXlyY7c/w+ymB1ZtwtmYNRbrDuIisxRPpI
         NvKNPqfNaPEaqc/TAJ9+HPUUvpIOpaAPXImY27Cm602lxbUqHrmSP/uzI/hdfsvZyY
         iQ7nY0bCISb2VC8wxQynGRwgAvdFjg8snwIdT1XpGT600WLqFr1b4G/II2f//iwQPL
         e+Bz4mmI6GtKmyvKnmIf27C4AjsVAWlHEGU5jE8Vscd26U5tQ19zykSd3KP9i9dsLo
         HTjJ4hHmCPH9a2jV+ThHfhm3QmBvmeoJaZHv6SLrelhoz9lkp4mYPL/Cc+LlNr7nuN
         CiC4NYi+8zQNA==
Date:   Thu, 19 Oct 2023 09:09:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v25 00/15] PCI: dwc: rcar-gen4: Add R-Car Gen4 PCIe
 support
Message-ID: <20231019140916.GA1400116@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYBPR01MB5341B3E0062E61EE5F2C84D8D8D4A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 19, 2023 at 04:08:52AM +0000, Yoshihiro Shimoda wrote:
> > From: Bjorn Helgaas, Sent: Thursday, October 19, 2023 12:11 PM
> > On Wed, Oct 18, 2023 at 05:56:16PM +0900, Yoshihiro Shimoda wrote:
> > > Add R-Car S4-8 (R-Car Gen4) PCIe controller for both host and endpoint modes.
> > > To support them, modify PCIe DesignWare common codes.
> > >
> > > Changes from v24:
> > >
> <snip URL>
> > >  - Based on the latest pci.git / next branch.
> > >  - Reordering the patches. (This is suggested by Bjorn.)
> > >  - Drop "PCI: dwc: Disable two BARs to avoid unnecessary memory assignment"
> > >    because break other platforms.
> > 
> > Does R-Car Gen4 still work without this patch?
> 
> Yes, R-Car Gen4 still work without this patch because I added this code into
> the patch 12/15 again:
> 
> ---
> +static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
> +{
> ...
> +	/*
> +	 * According to the section 3.5.7.2 "RC Mode" in DWC PCIe Dual Mode
> +	 * Rev.5.20a and 3.5.6.1 "RC mode" in DWC PCIe RC databook v5.20a, we
> +	 * should disable two BARs to avoid unnecessary memory assignment
> +	 * during device enumeration.
> +	 */
> +	dw_pcie_writel_dbi2(dw, PCI_BASE_ADDRESS_0, 0x0);
> +	dw_pcie_writel_dbi2(dw, PCI_BASE_ADDRESS_1, 0x0);

Great, thanks!

Bjorn
