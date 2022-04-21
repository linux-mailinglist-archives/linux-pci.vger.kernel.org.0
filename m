Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EF3509DAD
	for <lists+linux-pci@lfdr.de>; Thu, 21 Apr 2022 12:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239921AbiDUKbu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Apr 2022 06:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbiDUKbu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Apr 2022 06:31:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3739D1113;
        Thu, 21 Apr 2022 03:29:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1BB0B823EA;
        Thu, 21 Apr 2022 10:28:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F11BC385A1;
        Thu, 21 Apr 2022 10:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650536938;
        bh=bxue8ZtwMQMyRy8NefsZ1PIntfrTYQCoztKFP/yP8wY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L7nwFcYvQE5TNDkujME5dtDcHsPMjc39z8mRQ0p+4qFxQxe410a8Ux78sOJ8Wfqo8
         VWRQ3sWyQEH1F4cAnrVPIbHUbJwbOz/dTV1b+C0uByrGr4xLXCBNqLV4Je77EhhfL8
         r0CguD5hLMPBTD8rMnY5AJR96IkoaG7ISMvhp6+fvyCcFmedmoYydhDRXkcpJokV3O
         xZrGpyTF4E2ZScFihH6ubWjhvRjJAVp3//sVI0agniIxFZGdZVmk6r69ah0CY9ojd1
         oYgwTf+PkpvjWkWiYROJjLJ20MrX0nngdlqZiKMB7idUjBAtDyCA2ND4rH+rWrN35m
         F49eu+epDrUNA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nhU3Q-0004c5-CV; Thu, 21 Apr 2022 12:28:52 +0200
Date:   Thu, 21 Apr 2022 12:28:52 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 0/6] PCI: qcom: rework pipe_clk/pipe_clk_src handling
Message-ID: <YmEx5JPcDucjDiho@hovoldconsulting.com>
References: <20220413233144.275926-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413233144.275926-1-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 14, 2022 at 02:31:38AM +0300, Dmitry Baryshkov wrote:
> PCIe pipe clk (and some other clocks) must be parked to the "safe"
> source (bi_tcxo) when corresponding GDSC is turned off and on again.
> Currently this is handcoded in the PCIe driver by reparenting the
> gcc_pipe_N_clk_src clock.
> 
> Instead of doing it manually, follow the approach used by
> clk_rcg2_shared_ops and implement this parking in the enable() and
> disable() clock operations for respective pipe clocks.

Please take a look at the alternative approach of moving the pipe clock
muxing into the PHY driver:

	https://lore.kernel.org/all/20220421102041.17345-1-johan+linaro@kernel.org/

The implementation is more straight forward and I believe it is also
more conceptually sound as it ties the muxing to when the PHY is powered
on so that the GCC pipe clock always has a valid source.

Johan
