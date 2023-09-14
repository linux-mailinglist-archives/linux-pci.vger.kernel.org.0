Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240E77A0A1D
	for <lists+linux-pci@lfdr.de>; Thu, 14 Sep 2023 18:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241715AbjINQBc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Sep 2023 12:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241815AbjINQBT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Sep 2023 12:01:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28332716;
        Thu, 14 Sep 2023 09:01:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E00C433C7;
        Thu, 14 Sep 2023 16:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694707260;
        bh=Nkkv6aDL1D5TTqvjrRRRh4zdX4zcZxoBLRYI9o1UB9M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tJTs7BD1Sd1brkG65MiVYm8K8L2ti9/t1hqenkLmk5OPz2flwUbQ5agxW+wumyI1e
         Gl+rqKsX0hgFW32O0RoRIwwqVaE0pG4sA9tL56ynB+oqCf6ot5Wd7tosybFwHlDYI4
         EyDarBB54e0E+x8gFsf1uc/a8ARD1SO2Ezsdbq6gvJs8WuncVtrNqxD28zWPMhdUqm
         WWnN2SwvIVEKBB3Y2XF25ssCNLC/ZVCD2vUdiC31iUm6HK4Qia4rHaAF46vWJw8G44
         pVuesm6H4UDU/SUYUQcv2a+Jze+ByiFSklcuramK7NK0Havv1IMT6LWimOT/BEQ5wP
         XiNtXmjjDiTsQ==
Date:   Thu, 14 Sep 2023 11:00:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, marek.vasut+renesas@gmail.com,
        fancer.lancer@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v20 07/19] PCI: dwc: Add missing PCI_EXP_LNKCAP_MLW
 handling
Message-ID: <20230914160058.GA32113@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825093219.2685912-8-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 25, 2023 at 06:32:07PM +0900, Yoshihiro Shimoda wrote:
> Update dw_pcie_link_set_max_link_width() to set PCI_EXP_LNKCAP_MLW.
> In accordance with the DW PCIe RC/EP HW manuals [1,2,3,...] aside with
> the PORT_LINK_CTRL_OFF.LINK_CAPABLE and GEN2_CTRL_OFF.NUM_OF_LANES[8:0]
> field there is another one which needs to be updated. It's
> LINK_CAPABILITIES_REG.PCIE_CAP_MAX_LINK_WIDTH. If it isn't done at
> the very least the maximum link-width capability CSR won't expose
> the actual maximum capability.
> 
> [1] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
>     Version 4.60a, March 2015, p.1032
> [2] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
>     Version 4.70a, March 2016, p.1065
> [3] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
>     Version 4.90a, March 2016, p.1057
> ...
> [X] DesignWare Cores PCI Express Controller Databook - DWC PCIe Endpoint,
>       Version 5.40a, March 2019, p.1396
> [X+1] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
>       Version 5.40a, March 2019, p.1266

Is there value in keeping all four of these Root Port citations?  I
assume that if you have the most recent one (X+1), it completely
obsoletes the older ones, so you should never have to look at the
older ones?

Bjorn
