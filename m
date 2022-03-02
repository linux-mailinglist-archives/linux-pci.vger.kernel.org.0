Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA69E4C99B3
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 01:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbiCBAIT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Mar 2022 19:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbiCBAIS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Mar 2022 19:08:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5250644C;
        Tue,  1 Mar 2022 16:07:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78874611AF;
        Wed,  2 Mar 2022 00:07:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA39C340EE;
        Wed,  2 Mar 2022 00:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646179655;
        bh=YcTOvV2zUwz+GQf0/MYqRBF0QxCZnZNNF2mX9UMtPEA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JJBVowLK04QWflXAcdQ294itfnuaarvsBc7L3xBfbp/FwCE/ef4u5TdK7wJTR0mJY
         iNFAv8yaBR9fURVeg/oWK73GuKPfVIYwuV4zkjVqsBpZt4E7B+o41FX8gxAAPdVLXw
         tz/qlGbpT6gWY3krTdMgpzsHZ3emMVvhKIKuQbnnHV9i3exJ/W1COrmj9Z6p6Ta6wu
         q09PHDh7EkOctt8V+ajB6pyZ+j7n0+Vkhp4tu9Ng5yvstcAXNhWADKKdUyw/1NWBJC
         hHQmemU3RSKO0NuR6fB0rOxWPZYrhwLJrxQrj81YNItobP6BC07hN3Du/tZ8KXEQyL
         QNQEbetKpTPvQ==
Date:   Tue, 1 Mar 2022 18:07:34 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, bhupesh.linux@gmail.com,
        lorenzo.pieralisi@arm.com, agross@kernel.org,
        bjorn.andersson@linaro.org, svarbanov@mm-sol.com,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 6/7] arm64: dts: qcom: sm8150: Add pcie nodes for
 SM8150
Message-ID: <20220302000734.GA676465@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301072511.117818-7-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In subject, s/pcie/PCIe/

Since the subject already mentions "sm8150:", maybe the "for SM8150"
is superfluous?

On Tue, Mar 01, 2022 at 12:55:10PM +0530, Bhupesh Sharma wrote:
> Add nodes for the two PCIe controllers founds on the
> SM8150 SoC.

s/founds/found/

Rewrap to fill 75 columns.

> +			interrupt-map = <0 0 0 1 &intc 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> +					<0 0 0 2 &intc 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> +					<0 0 0 3 &intc 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> +					<0 0 0 4 &intc 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */

Personally I would use INTA, INTB, etc in the comments to match the
PCI spec usage, but grep says that's a minority view.
