Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDBC5B786A
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 19:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbiIMRly (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 13:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbiIMRko (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 13:40:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37F5D4A;
        Tue, 13 Sep 2022 09:34:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1C18B80EF6;
        Tue, 13 Sep 2022 16:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10255C433C1;
        Tue, 13 Sep 2022 16:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663086866;
        bh=4yJETbBECttQFo+n2AKxq36MbZwpbmzoK/+wm/PtUoQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ToR+bgp2XhdybgWJOjGlIjjN1yZyXIFCXXbV1copC4mQWjRjM8IxiiR3cbldoDz0U
         kkdAenU37q4bjV4zvV4As44zG1hW+gGFyf2Kj1BkBYjtY6/8XCG8bu3ZfB4eTJcJ9d
         eQYz6AvsFyuNhyZAnzsOATFbCYbCTs1q6Rtfe73ruLnAEsNAP1cWVRvXEkuSxpFVuM
         K/JKclINt+4fIA9JYNZK1pSAAug+GpFM0o8hXKJsNe+74PpUGxLNxuqCNQabeH4Zx9
         sadSMDhixF8O9JMNwg8QDTOYtjhEz1iduaM2T571UjSJSWJfbqUtz1/xGo2znAYCjR
         oNUmfjiYmeUBA==
Date:   Tue, 13 Sep 2022 11:34:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        quic_rjendra@quicinc.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, quic_vbadigan@quicinc.com,
        quic_hemantk@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v6 5/5] clk: qcom: Alwaya on pcie gdsc
Message-ID: <20220913163424.GA602259@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912170437.GA36223@thinkpad>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 12, 2022 at 10:34:37PM +0530, Manivannan Sadhasivam wrote:
> + Rajendra
> 
> On Fri, Sep 09, 2022 at 02:14:44PM +0530, Krishna chaitanya chundru wrote:
> > Make GDSC always on to ensure controller and its dependent clocks
> > won't go down during system suspend.
> 
> You need to mention the SoC name in subject, otherwise one cannot know for
> which platform this patch applies to.

Also:

s/Alwaya/Always/
s/pcie/PCIe/
s/gdsc/GDSC/ as you did in commit log

I might use "ALWAYS_ON" in the subject to make clear this refers to a
specific flag, not a change in the code logic, e.g.,

  clk: qcom: gcc-sc7280: Mark PCIe GDSC clock ALWAYS_ON
