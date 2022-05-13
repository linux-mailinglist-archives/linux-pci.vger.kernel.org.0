Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C920525D2C
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 10:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349659AbiEMIWY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 04:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243538AbiEMIWX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 04:22:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA4625B076;
        Fri, 13 May 2022 01:22:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1FFE62038;
        Fri, 13 May 2022 08:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A69C34100;
        Fri, 13 May 2022 08:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652430141;
        bh=YVebMdoUgeH+IdcQdM7MMGmb1fsUdeCywNHPrxi4/SI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q/zEuugIkIrNOhcC4JOlU+YETJRuF7fmI8ohyGZ3VpAtFyZaHW4yfZGhUYRJaDxvT
         Pn2r/gXF44OK3CR8pWwh1Aftj+zI7NGyzFrtSZv6j7/rYsQO0h5of5M5H1JrpD5vcz
         2PGQOJsIXaSYhKD58ZxQK5is9Oi5JL9Xk60qTqgizkLK+LpyLLwIqdf7eRdrcSvSlR
         U4i/k/ilhHbNdP7nw9ssn14qBtisE/Lo4mS9WDWJ8DeBHVRKrlAr+JK7GiT97suPfK
         CAe7NR3EOvuEJAWWE/zo20T5m6iUlJVxnr8XxLyoIZ7c4TiL24v+SWKtG01rGwWv5Z
         Fn0xNO8ACisFw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1npQYz-0007Dy-Tj; Fri, 13 May 2022 10:22:17 +0200
Date:   Fri, 13 May 2022 10:22:17 +0200
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
Message-ID: <Yn4VOS3T7nXo1CwT@hovoldconsulting.com>
References: <20220501192149.4128158-1-dmitry.baryshkov@linaro.org>
 <20220501192149.4128158-3-dmitry.baryshkov@linaro.org>
 <20220502101053.GF5053@thinkpad>
 <c47616bf-a0c3-3ad5-c3e2-ba2ae33110d0@linaro.org>
 <20220502111004.GH5053@thinkpad>
 <29819e6d-9aa1-aca9-0ff6-b81098077f28@linaro.org>
 <YnUXOYxk47NRG2VD@hovoldconsulting.com>
 <30846cb5-a22e-0102-9700-a1417de69952@linaro.org>
 <YnjtJuR7ShSsF+mz@hovoldconsulting.com>
 <adb49293-ea59-0a40-27de-4a654a02d456@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adb49293-ea59-0a40-27de-4a654a02d456@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 11, 2022 at 05:17:48PM +0300, Dmitry Baryshkov wrote:
> On 09/05/2022 13:29, Johan Hovold wrote:
> > On Fri, May 06, 2022 at 04:00:38PM +0300, Dmitry Baryshkov wrote:
> >> On 06/05/2022 15:40, Johan Hovold wrote:
> >>> On Mon, May 02, 2022 at 02:18:26PM +0300, Dmitry Baryshkov wrote:

> >>>> It has 4 parents. It uses just two of them (pipe and tcxo).
> >>>
> >>> Really? I did not know that. Which are the other two parents and what
> >>> would they be used for?
> >>
> >> This is described neither in the downstream tree nor in any sources I
> >> have at possession.
> > 
> > Yeah, I don't see anything downstream either, but how do you know that
> > it has four parents then?
> 
> 4 possible parents (judging from bitfield).

Ah, ok, so just an assumption based on the configuration field width.

Johan
