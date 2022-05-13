Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3096525C7C
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 09:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377848AbiEMHpN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 03:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351043AbiEMHpM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 03:45:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44392992FA;
        Fri, 13 May 2022 00:45:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DCC7B82C69;
        Fri, 13 May 2022 07:45:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A3DC34100;
        Fri, 13 May 2022 07:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652427908;
        bh=Fo/s2Zqwh4HukCpQjx2NKIpqTo8WeGytWKIBT8sKfbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jwXipwcOuqx0S7klC4FVoFR82fnE3Yun4+xMiATjllNCezuQDJbn5GBO7AuosntMM
         sORVklFfxkzbkQfkRV5utL+bipBg/ijswkqHhsb76XaHUUdq2yWyE2u0S2FtRdHYz/
         F3clL6khgUsE13Fc5EzuTxK7TQLIDegNGxvTiUlSFcFi883fjnsSRIGLsn+xigPy0H
         2kziqp20t5Rc5/9zlpJhcdPNirMtPiIHMEwkg9mVQKXlJTCu97ndrwrqP15Ri+6dQk
         03PVSG/vZUUM63tW8kAQ7ShTGHuzRsv1JY0qPqlqIaOyc0sqmUm8WBTs7XsPr5Fon6
         6lm/11qLxJrog==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1npPyz-0006yT-A4; Fri, 13 May 2022 09:45:05 +0200
Date:   Fri, 13 May 2022 09:45:05 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Prasad Malisetty <pmaliset@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 1/5] PCI: qcom: Remove unnecessary pipe_clk handling
Message-ID: <Yn4MgdV5/RiX5XgM@hovoldconsulting.com>
References: <20220512172909.2436302-1-dmitry.baryshkov@linaro.org>
 <20220512172909.2436302-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512172909.2436302-2-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 12, 2022 at 08:29:05PM +0300, Dmitry Baryshkov wrote:
> PCIe PHY drivers (both QMP and PCIe2) already do clk_prepare_enable() /
> clk_prepare_disable() pipe_clk. Remove extra calls to enable/disable
> this clock from the PCIe driver, so that the PHY driver can manage the
> clock on its own.
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

I assume you checked that there are no further PHY drivers used with
pcie-qcom by any in-kernel dts?

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan
