Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC69500D54
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 14:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243264AbiDNMaM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 08:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243348AbiDNM3W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 08:29:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B428D69A;
        Thu, 14 Apr 2022 05:26:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E958B82938;
        Thu, 14 Apr 2022 12:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D033C385A1;
        Thu, 14 Apr 2022 12:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649939215;
        bh=Bm7Q2ZnByE6GSEUiZhqmxSzL/BKHsqE5oxAj9ul5+wo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZMwU4DE3YXocQcCgSia+UsHiXnrwjYJYgwMnuIBAp+K+WBbtipcU2L5g+Siej6Kxn
         X7LofKt9QOyjnegvTaiY7/y53qp0tvUAGoiq2XQrYFVrKOdxI6HkMqjeOYgVbJEWz+
         hdwe+nDMp4MXEqbRYYU3oZtMbhBMsBxfaBCZE3RGamOQ5qCDBjkYyOdOeFlyTZcXqZ
         ub6uhlrGxEU7O7C480uM1DU851I8xYMfbgK/3WNwb46fuOleWBQ2wSA5YqS0FmgA3E
         apmerTJ5rlH96vO2KBC/7IG1ZtfrZ5IUwyPFaB2ULabHW5uvkX/1GsmodWY7pypASk
         w3XfZaa8NEL7Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1neyYl-0006Fo-3g; Thu, 14 Apr 2022 14:26:51 +0200
Date:   Thu, 14 Apr 2022 14:26:51 +0200
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
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/5] clk: qcom: regmap-mux: add pipe clk implementation
Message-ID: <YlgTC5RdDXC3abrI@hovoldconsulting.com>
References: <20220412193839.2545814-1-dmitry.baryshkov@linaro.org>
 <20220412193839.2545814-2-dmitry.baryshkov@linaro.org>
 <YlaUtCuMZZL4bM2U@hovoldconsulting.com>
 <82c6813c-fcff-5097-56e0-0cb7aac2eac2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82c6813c-fcff-5097-56e0-0cb7aac2eac2@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 14, 2022 at 01:21:29AM +0300, Dmitry Baryshkov wrote:
> On 13/04/2022 12:15, Johan Hovold wrote:
> > On Tue, Apr 12, 2022 at 10:38:35PM +0300, Dmitry Baryshkov wrote:
> >> On recent Qualcomm platforms the QMP PIPE clocks feed into a set of
> >> muxes which must be parked to the "safe" source (bi_tcxo) when
> >> corresponding GDSC is turned off and on again. Currently this is
> >> handcoded in the PCIe driver by reparenting the gcc_pipe_N_clk_src
> >> clock. However the same code sequence should be applied in the
> >> pcie-qcom endpoint, USB3 and UFS drivers.

> > The caching of the parent is broken since set_parent() is typically not
> > called before enabling the clock.
> > 
> > This means that the above code will set the mux to its zero-initialised
> > value, which currently only works by chance as the pipe clock config
> > value happens to be zero.
> > 
> > For this to work generally, you'd also need to define also the
> > (default/initial) non-safe parent for each mux. Handling handover from
> > the bootloader might also be tricky.
> 
> It's not tricky at all. We can set stored_parent_cfg from gcc probe from 
> function. Or set statically from the config. I'll probably do the latter.

That means you're just ignoring the problem. How is hard coding the
initial mux configuration in any way dealing with bootloader handover?
 
> > Furthermore, the current implementation appears to ignore locking and
> > doesn't handle the case where set_parent() races with enable(). The
> > former is protected by the prepare mutex and the latter by the enable
> > spinlock and a driver that needs to serialise the two needs to handle
> > that itself.
> 
> Since I'm trying to remove pipe_clk usage from pcie driver itself, there 
> is just one user left - qmp phy. And while you are correct that there is 
> a race, I think we can neglect that for now. Or shift enable/disable ops 
> to prepare/unprepare, thus using the same mutex everywhere.

Let's not add known broken code. Correctness first.

Handling the muxing the prepare/unprepare might work. I even considered
using those callbacks to let CCF know about the reparenting so that for
example debugfs continues to reflect the actual state of things.

But I'm still leaning towards this being a misguided endeavour as I've
explained elsewhere.

Johan
