Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFC9669D14
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 17:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjAMQBB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 11:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjAMQA0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 11:00:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C469A96764;
        Fri, 13 Jan 2023 07:51:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9A9B6223C;
        Fri, 13 Jan 2023 15:51:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFED9C433EF;
        Fri, 13 Jan 2023 15:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673625081;
        bh=wOWtrdSlhbszE+tN7qXeYBL750xu36ZW+cH1OVBcLPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WJvifSfl5C1QvFNKgAkIvS79KuZ0lCos/no9zHPrzgxldsRNFC7iRUOIL/Ck7nlUV
         SfYlVqFPnXWD91UHyVDPFUnPulYambSP5SLC7FkDrhrPSqx4nnz/8LnAU4thz5I+jT
         Yx8P1MChqhyTvO1e53BbGrXPCEqT5wR7KDxqozaw4fKcI9ehJ6F78szii6ctwQus0F
         pJKKPZ0OYOtVF9WXfH1nDInC+95KHprnl6odXS1JAdsjcz/FHmel9hr1wxnYgBz6Hc
         NVzvxGMnfiQLpVtWIswyyQYqpPKHx0Imeczlai4RQsiPBp2aSUJ1P36M9O/DKA0hM+
         Eb0cNG4yaclpQ==
Date:   Fri, 13 Jan 2023 16:51:13 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] PCI: qcom: Add support for modular builds
Message-ID: <Y8F98UTZNgQpX6UG@lpieralisi>
References: <20221017114705.8277-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017114705.8277-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 17, 2022 at 01:47:03PM +0200, Johan Hovold wrote:
> Allow the Qualcomm PCIe controller driver to be built as a module, which
> is useful for multi-platform kernels as well as during development.
> 
> There's no rush with this, but I figured I'd send an updated version
> that has been rebased on 6.1-rc1 (where post_deinit() has been removed).
> 
> I also broke out the qcom_pcie_host_deinit() handler in a separate patch
> as the host_deinit() callback has now been added to dwc core and can be
> used to fixes some late-probe error handling.

Waiting for the dust to settle on patch 2, does it make sense to
merge patch 1 on its own ?

Thanks,
Lorenzo

> Johan
> 
> 
> Changes in v3
>  - rebase on 6.1-rc1 where post_deinit() has been removed
>  - split out host-init error handling
>  - add Stan's ack
> 
> Changes in v2
>  - rebase on next-20220720 (adjust context)
>  - add Rob and Mani's reviewed-by tags
> 
> 
> Johan Hovold (2):
>   PCI: qcom: Fix host-init error handling
>   PCI: qcom: Add support for modular builds
> 
>  drivers/pci/controller/dwc/Kconfig     |  2 +-
>  drivers/pci/controller/dwc/pcie-qcom.c | 39 +++++++++++++++++++++++---
>  2 files changed, 36 insertions(+), 5 deletions(-)
> 
> -- 
> 2.37.3
> 
