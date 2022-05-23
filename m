Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B95530C29
	for <lists+linux-pci@lfdr.de>; Mon, 23 May 2022 11:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbiEWI4x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 May 2022 04:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbiEWI4t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 May 2022 04:56:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6715D11C;
        Mon, 23 May 2022 01:56:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 371D260F00;
        Mon, 23 May 2022 08:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918FCC385A9;
        Mon, 23 May 2022 08:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653296204;
        bh=Q5eUJXYpAGTyVW1k30SbejcbHGQMhf5cXtb9Q2uVNRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f3MJbXYCAD3sent/cH8XqNpG3Q9+bKHwE/DKb/wmurC9RyRjIwhRpgOF2GNck5Xot
         Mfg4QS87qP0Zu6aPJh7ZkuQunIfGDo0OcazVIXtrQji8GrvcV/Rmm4iBckAFEubZiV
         rEYdTTqpXd888ZuCERhBLcbcqzNMl/QDh78/gYXekEfZ1mfgwefpWEZeqA6nFuNsfj
         Ddu4Ay0d1ZwZLez4Tt97VVK3LAEVAJ7MJvWDCcvfuS0h7tqkTmUPxmx9ml17EAbHrY
         vvgyhntvjQlDD4WBFhLyKfe571+tJ4SkV6YODpp35eJyoNPYD5e/m8NfSAPRMeZMHv
         keIfMzYgrGbfg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nt3rl-0000hY-HM; Mon, 23 May 2022 10:56:41 +0200
Date:   Mon, 23 May 2022 10:56:41 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Prasad Malisetty <quic_pmaliset@quicinc.com>
Subject: Re: [PATCH v7 8/8] PCI: qcom: Drop manual pipe_clk_src handling
Message-ID: <YotMSa+sRVTrsDXX@hovoldconsulting.com>
References: <20220521005343.1429642-1-dmitry.baryshkov@linaro.org>
 <20220521005343.1429642-9-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521005343.1429642-9-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, May 21, 2022 at 03:53:43AM +0300, Dmitry Baryshkov wrote:
> Manual reparenting of pipe_clk_src is being replaced with the parking of
> the clock with clk_disable()/clk_enable() in the phy driver. Drop
> redundant code switching of the pipe clock between the PHY clock source
> and the safe bi_tcxo.
> 
> Cc: Prasad Malisetty <quic_pmaliset@quicinc.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

You forgot to add my Reviewed-by and Tested-by yet again.

Johan
