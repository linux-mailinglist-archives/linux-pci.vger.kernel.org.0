Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1292057538E
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 18:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237297AbiGNQ5T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 12:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240043AbiGNQ5F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 12:57:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E95254CBD;
        Thu, 14 Jul 2022 09:56:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3054B82750;
        Thu, 14 Jul 2022 16:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09324C34115;
        Thu, 14 Jul 2022 16:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657817810;
        bh=BK72IdLo+uV0vANGvG41enZ8wflciKo/ZGWbE5eG9xQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=A1ar2hCOOyNRX3gTgads1I75OA03ZMPHHe8xjxrvqomDv7jAwHKKCWTck1gqoQhpz
         KFrnO7aYLk8d9VnY0Gb0PgQ7QWyyKEQm4X5WJzBRWJ2cRXUY6nzhaKKD4P4jKcyINa
         qhUlP8ijgLgztYK7j2zCvZ9+rL4wqx3kxYr37W96WJ+nqJGPUDubUvYBfDW7UKjq/z
         7NqLtET1TEgfk0pNMCif/ci1YmLy81Isw933mQHd4SOQDAYdE/1lUddsPTkSmjkK7U
         3jOL8UJXTI6L2OwJmC17WgqwoB6r9n+nBiGjI2lF+TAh/vTBngaJVk6INsELAZ3SpM
         4Embo6Oqef50w==
Date:   Thu, 14 Jul 2022 11:56:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v11 5/5] PCI: qcom: Drop manual pipe_clk_src handling
Message-ID: <20220714165648.GA1023269@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8763d03-c491-70f3-bb47-b3dbf68b4ad2@mm-sol.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 14, 2022 at 04:08:06AM +0300, Stanimir Varbanov wrote:
> Hi Dmitry,
> 
> On 6/8/22 13:52, Dmitry Baryshkov wrote:
> > Manual reparenting of pipe_clk_src is being replaced with the parking of
> > the clock with clk_disable()/clk_enable() in the phy driver. Drop
> > redundant code switching of the pipe clock between the PHY clock source
> > and the safe bi_tcxo.
> > 
> > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> > Tested-by: Johan Hovold <johan+linaro@kernel.org>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 39 +-------------------------
> >  1 file changed, 1 insertion(+), 38 deletions(-)
> 
> Cool!
> 
> Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>

Thanks, Stan.  Somehow I had applied 4/5 but not 5/5.  I added 5/5 and
your acks to both on my pci/ctrl/qcom branch for v5.20.

Bjorn
