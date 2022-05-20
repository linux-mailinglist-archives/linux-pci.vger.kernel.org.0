Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D9052F04D
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 18:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351439AbiETQNa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 May 2022 12:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236744AbiETQN3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2022 12:13:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC98163F4F;
        Fri, 20 May 2022 09:13:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13677B82A71;
        Fri, 20 May 2022 16:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBDFC385A9;
        Fri, 20 May 2022 16:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653063205;
        bh=q6T3WjvTqSKVE1rZoNZimUXpps62AluUuTHHWBmq5Qo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A82Gq1WUZWfWR+tiX3dxOVzmlJMvtzD3kfr1iUSn5AkPzVsGdQTeFcIv8W4GuQrZZ
         KcKNcwBpPdELr9/v6Hsu1RWkzQc3bj9gTe2ctxcMnbV4F9s4MD4A8VCeQl+J6DmOTY
         QYBijtQGAtgRp9iIe9vBi39E4trD/0QotuSys0qHIV8tPCU9QBkbhEIrLe4jBB+64x
         rhAQNzzUFXHUsZiEX3SzedbyV4bbM8VYtczVOlpdRYXN7wUql56ARyYzZmo3OidymS
         nkFssjn5RNiXxxmekbiwfwIdK6GSqflyFn04lm+kvH4GfTEh4tXgej6dtnENp8BU5Y
         SDlJ4uViVY/Qg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ns5Fl-0008B1-VW; Fri, 20 May 2022 18:13:26 +0200
Date:   Fri, 20 May 2022 18:13:25 +0200
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
Subject: Re: [PATCH v7 6/6] PCI: qcom: Drop manual pipe_clk_src handling
Message-ID: <Yoe+JZIZ/DfudcP3@hovoldconsulting.com>
References: <20220520015844.1190511-1-dmitry.baryshkov@linaro.org>
 <20220520015844.1190511-7-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520015844.1190511-7-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 20, 2022 at 04:58:44AM +0300, Dmitry Baryshkov wrote:
> Manual reparenting of pipe_clk_src is being replaced with the parking of
> the clock with clk_disable()/clk_enable() in the phy driver. Drop
> redundant code switching of the pipe clock between the PHY clock source
> and the safe bi_tcxo.
> 
> Cc: Prasad Malisetty <quic_pmaliset@quicinc.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

You forgot to add my 

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>

Johan
