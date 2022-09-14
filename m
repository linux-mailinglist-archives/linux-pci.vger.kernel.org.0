Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E416C5B81A4
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 08:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiINGsp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 02:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiINGsm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 02:48:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B126BD77;
        Tue, 13 Sep 2022 23:48:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 095AF6185D;
        Wed, 14 Sep 2022 06:48:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB5AC433D6;
        Wed, 14 Sep 2022 06:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663138120;
        bh=e/RiAwC60v7qXBvmpwe09GemDUBtLQTXY1Qpe8RuHhg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B6pYCs5EZJSCT4I8r0325I8QPVckkHKxR5UNb1RcdhI5VmOrPF6/7hPTrpSoeuY+Z
         o5WPHIce0bGsRiFT93UI8P5cqquxb6qMhVQoc8bcAmKk7EDuAstiHllm2WCAX/Fj78
         vgb+6x3CeXb8LnjYjn4KE/Rqn6cvIDdMHCf73XZUPEfFz4hSwFAzkuXAtXnG4QmWs8
         d0z8wRAj+64cl2o43kec6bSO/A7iaVzI2sQZdTlnVMM4Uxd5l179XdSq/Ez2Au38lM
         BMnDdSRN3l69TPCstRotorWmO8Ib/9xfb26YSTdZSjxuyRLmLBOvnVnqHXaIyfrB5m
         BAvUe/2TblRFg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oYMCO-00038b-6y; Wed, 14 Sep 2022 08:48:40 +0200
Date:   Wed, 14 Sep 2022 08:48:40 +0200
From:   Johan Hovold <johan@kernel.org>
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
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 0/9] PCI: qcom: Support using the same PHY for both RC
 and EP
Message-ID: <YyF5SJASdCJWcPaX@hovoldconsulting.com>
References: <20220909091433.3715981-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909091433.3715981-1-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 09, 2022 at 12:14:24PM +0300, Dmitry Baryshkov wrote:
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
> Unlike previous iterations, this series brings in the dependecy from
> PCI parts onto the first patch. Merging of PHY and PCI parts should be
> coordinated by the maintainers (e.g. by putting the first patch into the
> immutable branch).
> 
> Changes since v2:
> - Added PHY_SUBMODE_PCIE_RC/EP defines (Vinod),
> - Changed `primary' table name to `main', added extra comments
>   describing that `secondary' are the additional tables, not required in
>   most of the cases (following the suggestion by Johan to rename
>   `primary' table),

This wasn't really what I suggested. "main" is in itself is no more
understandable than "primary".

Please take another look at:

	https://lore.kernel.org/all/Yw2+aVbqBfMSUcWq@hovoldconsulting.com/

Johan
