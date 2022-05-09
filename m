Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1866651F8EE
	for <lists+linux-pci@lfdr.de>; Mon,  9 May 2022 12:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236046AbiEIJxZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 May 2022 05:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239570AbiEIJqn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2022 05:46:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C749D4F1;
        Mon,  9 May 2022 02:42:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1111B810AD;
        Mon,  9 May 2022 09:41:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05F1C385A8;
        Mon,  9 May 2022 09:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652089290;
        bh=uz/2I097YaC72815e/cPi9TS8annMekWx+H8PCJvgnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BAqUJ6k7ZR0G1QnS1BRb9f4vUUIiEq6e1L0EhS0chKwyziCOj7zdGAH1HdaVmoVru
         SbyeOP6pG9zpglHrLkxAnipJPmYgwRYKIJe0G3zPyfKpe4DpIHNfa0uSABIM+q3lpz
         NZO98zSIH/XcEEA9UCduWREzm5r5NpJFoP5/psVUvKN3Qg0dbjwqaUEXv25VeXKemy
         F/FWYWwxfIjzeRJmgBxDO1LMFtaMrsmKxHn0p5jTCi6kb8QUK9u+xUf4Gz7570Fi3g
         ba5Mnk5e9g6IYnIUC+OiHeXQMN1zhWe483cgXkUKzxXXcGzoxpOmZvi+wXys3CeSgH
         S1QPxysOnrwSg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nnztO-0005tH-TP; Mon, 09 May 2022 11:41:27 +0200
Date:   Mon, 9 May 2022 11:41:26 +0200
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
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 1/5] PCI: qcom: Remove unnecessary pipe_clk handling
Message-ID: <YnjhxkajHW0u8SAK@hovoldconsulting.com>
References: <20220501192149.4128158-1-dmitry.baryshkov@linaro.org>
 <20220501192149.4128158-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220501192149.4128158-2-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, May 01, 2022 at 10:21:45PM +0300, Dmitry Baryshkov wrote:
> QMP PHY driver already does clk_prepare_enable()/_disable() pipe_clk.

The pcie-qcom driver is used also with non-QMP PHYs such as the Qualcomm
PCIe2 PHY so please expand the commit message here explaining why this
is safe to remove.

> Remove extra calls to enable/disable this clock from the PCIe driver, so
> that the PHY driver can manage the clock on its own.

Johan
