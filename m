Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04783552C65
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 09:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347000AbiFUHxq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 03:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346664AbiFUHxq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 03:53:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7727E23BC6;
        Tue, 21 Jun 2022 00:53:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1514861457;
        Tue, 21 Jun 2022 07:53:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746A6C3411D;
        Tue, 21 Jun 2022 07:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655798024;
        bh=MpeEIIy9pRKV+9+aIbYO9RMnNjY4VitAYHKXHqLyjz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tv6Z4bwBbfRqciNuJn1ZLOH+05a+7YGR3D7ZPhImIueGNT9qxD0VBIMoHAiYNfFsC
         gGAamaeXB47eXKx0ItUmsnhv4PjCBp3ZebLxG8y08rc+L74wEI1xrOhq8VboWKrzAJ
         6qzYEoG1ED40AkWBVh6Hd1aOBoXK7VnLA37Dww91gMIAV+Z7TjMSiiNu/XGKJBRY8L
         3rbRGV0SRjCGkGZ6/BM2vPZ7g6HNfHPLSKR8H6laZiy3qldgi+rYeMbz82FfXWvyIR
         PYE0x7//qOfMn9xONXBQBtm5ilo7aEjTT1+tu/hF9/skB+1AoO4XseO/cBaAkijtvO
         b1/E5+aV7xAOw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o3Yhd-0005fc-7k; Tue, 21 Jun 2022 09:53:37 +0200
Date:   Tue, 21 Jun 2022 09:53:37 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Selvam Sathappan Periakaruppan <quic_speriaka@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v7 3/3] PCI: qcom: Add IPQ60xx support
Message-ID: <YrF5ARelhL5GnOnJ@hovoldconsulting.com>
References: <cover.1655028401.git.baruch@tkos.co.il>
 <a470b27a642d21e7b3e64d0f3287c0c3521bd182.1655028401.git.baruch@tkos.co.il>
 <YrCY0dhQEE5pgWT1@hovoldconsulting.com>
 <87k09aekop.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k09aekop.fsf@tarshish>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 21, 2022 at 06:39:45AM +0300, Baruch Siach wrote:
> Hi Johan,
> 
> Thanks for your review comments.
> 
> On Mon, Jun 20 2022, Johan Hovold wrote:
> > On Sun, Jun 12, 2022 at 01:18:35PM +0300, Baruch Siach wrote:
> >> From: Selvam Sathappan Periakaruppan <quic_speriaka@quicinc.com>
> >> 
> >> IPQ60xx series of SoCs have one port of PCIe gen 3. Add support for that
> >> platform.
> >> 
> >> The code is based on downstream[1] Codeaurora kernel v5.4 (branch
> >> win.linuxopenwrt.2.0).
> >> 
> >> Split out the DBI registers access part from .init into .post_init. DBI
> >> registers are only accessible after phy_power_on().
> >> 
> >> [1] https://source.codeaurora.org/quic/qsdk/oss/kernel/linux-ipq-5.4/
> >> 
> >> Signed-off-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
> >> Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
> >> ---
> >
> >> +static void qcom_pcie_deinit_2_9_0(struct qcom_pcie *pcie)
> >> +{
> >> +	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
> >> +
> >> +	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
> >
> > Assert reset as you do in the init error path?
> 
> Not sure about that. As I understand, the reset assert/deassert sequence
> on init is meant to ensure clean startup state. Deinit most likely does
> not need that. So maybe I should remove reset assert from init error
> path instead?

Yeah, I think the init error path and deinit should at least be
consistent.

> As always, this code sequence is from downstream kernel. I have no
> access to documentation.

I feel your pain. ;)

Johan
