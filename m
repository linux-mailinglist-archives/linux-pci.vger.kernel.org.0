Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D03D5EBDD3
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 10:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiI0Iz0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 04:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiI0IzZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 04:55:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5466E58B6D;
        Tue, 27 Sep 2022 01:55:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFF6F6174F;
        Tue, 27 Sep 2022 08:55:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517D0C433C1;
        Tue, 27 Sep 2022 08:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664268923;
        bh=9CEZSGxZXu10IfLWzBonZeqKa3qHuekmxQGhNgMxu3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o54hJYec0DnzxPLdHbiag+mJdkcPVG/7Ra1RmjUyvX20WlL71ez6+wxlEL4dQ3X0o
         3sRaPcYTQqwLCw5IvwDCaJLgUWDC+dYP2kobN1zEBMGg7nS0M5JvNNRCrE9ZRB7iGE
         PZHH9fnNu/Z544Sv7ztMIVvGHRo3pyvg62yOuqdVSEUUPff+o+mWHL7A5gdpaTaCQj
         CAlb3w3Prul0PnD+Fkr2gsB0ehLEi0wuarXGzAtrJdIgqQ/4WlheuDmvw3pReUKGWB
         yh4XZXrx5+wMbb007pamlbittAT5vtUVZhWwZU9sYL5h6XDqERiAyyIXbpo0yqd0Ff
         EhjFM2rZAGLBg==
Date:   Tue, 27 Sep 2022 10:55:15 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v5 0/5] PCI: qcom: Support using the same PHY for both RC
 and EP
Message-ID: <YzK6c2g0bgwyvZ+O@lpieralisi>
References: <20220926173435.881688-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926173435.881688-1-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 26, 2022 at 08:34:30PM +0300, Dmitry Baryshkov wrote:
> Programming of QMP PCIe PHYs slightly differs between RC and EP modes.
> 
> Currently both qcom and qcom-ep PCIe controllers setup the PHY in the
> default mode, making it impossible to select at runtime whether the PHY
> should be running in RC or in EP modes. Usually this is not an issue,
> since for most devices only the RC mode is used. Some devices (SDX55)
> currently support only the EP mode without supporting the RC mode (at
> this moment).
> 
> Nevertheless some of the Qualcomm platforms (e.g. the aforementioned
> SDX55) would still benefit from being able to switch between RC and EP
> depending on the driver being used. While it is possible to use
> different compat strings for the PHY depending on the mode, it seems
> like an incorrect approach, since the PHY doesn't differ between
> usecases. It's the PCIe controller, who should decide how to configure
> the PHY.
> 
> This patch series implements the ability to select between RC and EP
> modes, by allowing the PCIe QMP PHY driver to switch between
> programming tables.
> 
> This patchseries depends on the header from the pre-6.1 phy/next. Thus
> after the 6.1 the PCIe patches can be applied independently of the PHY
> part.

I assume then it is better for me to ACK the PCI patches so
that they can be pulled into the PHY tree, right ?

Lorenzo

> Changes since v4:
> - Fixed the possible oops in probe (Johan)
> - Renamed the tables struct and individual table fields (Johan)
> - Squashed the 'separate funtions' patch to lower the possible
>   confusion.
> 
> Changes since v3:
> - Rebased on top of phy/next to pick in newly defined
>   PHY_MODE_PCIE_RC/EP.
> - Renamed 'main' to 'common' and 'secondary' to 'extra' to reflect the
>   intention of the split (the 'common' tables and the 'extra for the ...
>   mode' tables).
> - Merged the 'pointer' patch into first and second patches to make them
>   more obvious.
> 
> Changes since v2:
> - Added PHY_SUBMODE_PCIE_RC/EP defines (Vinod),
> - Changed `primary' table name to `main', added extra comments
>   describing that `secondary' are the additional tables, not required in
>   most of the cases (following the suggestion by Johan to rename
>   `primary' table),
> - Changed secondary tables into the pointers to stop wasting extra
>   memory (Vinod),
> - Split several functions for programming the PHY using these tables.
> 
> Changes since v1:
> - Split the if(table) removal to the separate patch
> - Expanded commit messages and comments to provide additional details
> - Fixed build error on pcie-qcom.c
> - Added support for EP mode on sm8450 to demonstrate the usage of this
>   patchset
> 
> Changes since RFC:
> - Fixed the compilation of PCIe EP driver,
> - Changed pri/sec names to primary and secondary,
> - Added comments regarding usage of secondary_rc/_ep fields.
> 
> Dmitry Baryshkov (5):
>   phy: qcom-qmp-pcie: split register tables into common and extra parts
>   phy: qcom-qmp-pcie: support separate tables for EP mode
>   phy: qcom-qmp-pcie: Support SM8450 PCIe1 PHY in EP mode
>   PCI: qcom: Setup PHY to work in RC mode
>   PCI: qcom-ep: Setup PHY to work in EP mode
> 
>  drivers/pci/controller/dwc/pcie-qcom-ep.c     |   5 +
>  drivers/pci/controller/dwc/pcie-qcom.c        |   5 +
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 523 +++++++++++-------
>  .../qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h    |   1 +
>  4 files changed, 335 insertions(+), 199 deletions(-)
> 
> -- 
> 2.35.1
> 
