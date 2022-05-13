Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466AC525F00
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 12:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbiEMJnP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 05:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbiEMJnO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 05:43:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F121D644C6;
        Fri, 13 May 2022 02:43:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85A5BB82D5A;
        Fri, 13 May 2022 09:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E134C34100;
        Fri, 13 May 2022 09:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652434990;
        bh=b8sBE15RBNxyIMw0U56/5sGMycgU0eaNt/RbigefwkY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BtRjPJpwP45vGmTA6ujugg3YaQ+NtUTFNfrKB8DpjpaOJjITZkw6CZHDpB8ypyR5y
         i9a8vmeFcliCDQ1eGs5NJ916tS1B+ZhD291f0ocTlDnsFck6imb649KaW49S6htyFx
         hZWk4OomHHZIa87kYufx6Uk6R9mrBfHvZy1UnSzm51Z0940BkWbypRQ6E2ljNOO4Di
         R5IOqkL9tto90rX9OPF1cKYU4ALsF1L6Pq3Y71w/cRHv48dstv8hHn/8i+vwfi2LZV
         x3lDYryM+vgnRepr50izSovTShaZd2/Nwvif4D4hHaHvrogFUYbC9AooPx1DSiyEP0
         1z9nywvIi7BgA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1npRpB-0007x3-T1; Fri, 13 May 2022 11:43:06 +0200
Date:   Fri, 13 May 2022 11:43:05 +0200
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
Subject: Re: [PATCH v5 0/5] PCI: qcom: Rework pipe_clk/pipe_clk_src handling
Message-ID: <Yn4oKQS+7DfjP9c5@hovoldconsulting.com>
References: <20220512172909.2436302-1-dmitry.baryshkov@linaro.org>
 <Yn4LsB/dkwjdslQs@hovoldconsulting.com>
 <CAA8EJpqCFAxNuK4B25hZUQa4DWqc3M4FXvJq7Cob752OWUmYcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpqCFAxNuK4B25hZUQa4DWqc3M4FXvJq7Cob752OWUmYcg@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 13, 2022 at 12:31:27PM +0300, Dmitry Baryshkov wrote:
> On Fri, 13 May 2022 at 10:41, Johan Hovold <johan@kernel.org> wrote:
> > On Thu, May 12, 2022 at 08:29:04PM +0300, Dmitry Baryshkov wrote:

> > > PCIe part depends on [1].
> >
> > This one was merged a month ago.
> 
> It is not in Linus's tree (only in Lorenzo's one). So anybody wishing
> to test the series would still have to pick it up manually.

Fair enough, but you generally don't need to describe dependencies that
have already been picked up by the maintainer.

Johan
