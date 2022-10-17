Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA4E6007FA
	for <lists+linux-pci@lfdr.de>; Mon, 17 Oct 2022 09:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiJQHoq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Oct 2022 03:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiJQHop (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2022 03:44:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC171EC61;
        Mon, 17 Oct 2022 00:44:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E2D260F68;
        Mon, 17 Oct 2022 07:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67137C433D7;
        Mon, 17 Oct 2022 07:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665992683;
        bh=762l0StSz/K7tU5EDi5x7CTZNdEOP6u673sfhPq8Obg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d2Q+UQLuzVLVgjbv7NgmM1ahBDHgvOcAoa4jED6v3iWUKhJrY9T/sdvoP5YDKTFWg
         TlIc0EdyCI73QPOvlCrR+GSRgtje7fTLng01LLj8HoHImcQTYXzrrPkpStX80aZbHY
         liK+NVaV5KiRgRVFmAlFV8b8or3fGEONsj1K8L28vIHvFPLA70p6ukY+GOUI0p5lbF
         ppVJA9PjPnGLl3bHGo+C5ikiwIF3U924NaXIHVMVDf+qw2jZIf0vgF3Hbf2I0078lI
         ii/z7X4Y8XYmpXdA5ysyzAzz1zFXe0AVuxShoBMCKXo/woQYFZoevRIdk2/EBNW+XL
         UI3YnOkawfCZw==
Date:   Mon, 17 Oct 2022 13:14:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
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
        Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v6 0/5] PCI: qcom: Support using the same PHY for both RC
 and EP
Message-ID: <Y00H5te4zXVAgS7M@matsya>
References: <20220927092207.161501-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927092207.161501-1-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 27-09-22, 12:22, Dmitry Baryshkov wrote:
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

Applied, thanks

-- 
~Vinod
