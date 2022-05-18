Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E939952B3F1
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 09:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbiERHst (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 03:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbiERHss (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 03:48:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585DCBC08;
        Wed, 18 May 2022 00:48:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5BE3614B3;
        Wed, 18 May 2022 07:48:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E134C385AA;
        Wed, 18 May 2022 07:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652860126;
        bh=7q4uWGmM0jEwsrujxekuJ2wVjpvE2c1GnTkFVYjD+9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KdAj62ZLaBLuJkyj5YjYqg+kdAO8yi71r34mHQgDmnYMQq3vkCypLGhgy0oexvj1k
         KecpOsjaPfU03RkeN/ykLIZmmmSj3PF/00woB4QnH5QBztUmkShp2d7Z9jjIz8fWJ2
         ndjJbrexHdYPlLcb7bWDEvYiTDFzmekpR3OXu8VMTwwLo/gCNynaU8OLK4vTcHjHrD
         KzU3/KaUtRJT9Q5HMmZfPj8HncAAh6SiLPhuOCuJtemgPRQa2anWd3Dbu6jbbPGL5C
         NVnETffhhxpanxgoKZI4MzQ9nJv+BPE9ib/T2ZrmmP8eJGUp/kOd3Vf8znMNSvhBa+
         nx3EiQ15j42PA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nrEQI-0004Km-D9; Wed, 18 May 2022 09:48:46 +0200
Date:   Wed, 18 May 2022 09:48:46 +0200
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
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 2/5] clk: qcom: regmap: add PHY clock source
 implementation
Message-ID: <YoSk3i00b02bRThU@hovoldconsulting.com>
References: <20220513175339.2981959-1-dmitry.baryshkov@linaro.org>
 <20220513175339.2981959-3-dmitry.baryshkov@linaro.org>
 <YoShe/rWXVq78+As@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoShe/rWXVq78+As@hovoldconsulting.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 18, 2022 at 09:34:19AM +0200, Johan Hovold wrote:
> On Fri, May 13, 2022 at 08:53:36PM +0300, Dmitry Baryshkov wrote:

> > +/*
> > + * A special clock implementation for PHY pipe and symbols clock sources.
> 
> s/sources/muxes/
> 
> > + *
> > + * If the clock is running off the from-PHY source, report it as enabled.
> > + * Report it as disabled otherwise (if it uses reference source).
> > + *
> > + * This way the PHY will disable the pipe clock before turning off the GDSC,
> 
> s|pipe|pipe/symbol|
> 
> > + * which in turn would lead to disabling corresponding pipe_clk_src (and thus
> > + * it being parked to a safe, reference clock source). And vice versa, after
> > + * enabling the GDSC the PHY will enable the pipe clock, which would cause
> 
> s|pipe|pipe/symbol|
> 
> > + * pipe_clk_src to be switched from a safe source to the working one.
> > + */
> 
> You're still referring to the old pipe_clk_src name in two places in
> this comment.

Just remembered that the PCIe/USB mux is also referred to as
pipe_clk_src and that your not referring to the clock implementation.

I guess the comment works as-is even if the example refers to just
USB/PCIe.

> Should this be reflected in Subject as well (e.g. "PHY mux
> implementation")?

Johan
