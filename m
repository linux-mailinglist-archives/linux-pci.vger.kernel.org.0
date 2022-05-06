Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6067251D809
	for <lists+linux-pci@lfdr.de>; Fri,  6 May 2022 14:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392087AbiEFMoY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 May 2022 08:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392111AbiEFMoK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 May 2022 08:44:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA88F6438;
        Fri,  6 May 2022 05:40:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56ADC62010;
        Fri,  6 May 2022 12:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57B5C385A9;
        Fri,  6 May 2022 12:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651840825;
        bh=yS8eoRknU8vfHA2ZcN4Bvr61OFldMWtiIxBIk0TPDw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=frcsASHK5eNU3JFye+oDbZhLCzqMlU9dNbsjPCGF19cNFvGQxZHyjcmFbIDYhd5Ud
         5tQkOYwTzCwdU1Nwxm+f0zulXuop2sAO/gNItkDWRKHU/hoN1qwXLFdsuPGe1eqLxi
         OLc28E9svfWyyvtuKpagv1FPWYSIlpIKCfxpfQn4sR5jq06wWuh7YNBBiT2DqJcfWf
         +15yJT82l12M5cchvu/a0Rgb4dvOi49PJHX4IX+DOutFApwnHnRFUhw0KnCeWL8NwX
         EgPEsYeTbbDvjvL6399E2hfnepAqpyYYD9LP3aDEPS4AMIAEM9jHBJYyfnk1wHQ9cU
         jwFWYO+6eb5Rw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nmxFx-0007SO-Cy; Fri, 06 May 2022 14:40:26 +0200
Date:   Fri, 6 May 2022 14:40:25 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andy Gross <agross@kernel.org>,
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
Subject: Re: [PATCH v4 2/5] clk: qcom: regmap: add pipe clk implementation
Message-ID: <YnUXOYxk47NRG2VD@hovoldconsulting.com>
References: <20220501192149.4128158-1-dmitry.baryshkov@linaro.org>
 <20220501192149.4128158-3-dmitry.baryshkov@linaro.org>
 <20220502101053.GF5053@thinkpad>
 <c47616bf-a0c3-3ad5-c3e2-ba2ae33110d0@linaro.org>
 <20220502111004.GH5053@thinkpad>
 <29819e6d-9aa1-aca9-0ff6-b81098077f28@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29819e6d-9aa1-aca9-0ff6-b81098077f28@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 02, 2022 at 02:18:26PM +0300, Dmitry Baryshkov wrote:
> On 02/05/2022 14:10, Manivannan Sadhasivam wrote:

> > I don't understand this. How can you make this clock disabled? It just has 4
> > parents, right?
> 
> It has 4 parents. It uses just two of them (pipe and tcxo).

Really? I did not know that. Which are the other two parents and what
would they be used for?

Johan
