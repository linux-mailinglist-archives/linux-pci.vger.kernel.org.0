Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E68E605EE6
	for <lists+linux-pci@lfdr.de>; Thu, 20 Oct 2022 13:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiJTLdQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Oct 2022 07:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiJTLdO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Oct 2022 07:33:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD38B1DC089;
        Thu, 20 Oct 2022 04:33:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48282B8270A;
        Thu, 20 Oct 2022 11:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA73EC433C1;
        Thu, 20 Oct 2022 11:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666265588;
        bh=whoAIgWQYEIspsxStBO8vFJ26MnuDdju6Vgr7FeJypk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ls21c5NkEM+PlMV7XUT2nrQNtB8SeTY/P5QVnEYCdRteCNe1Sbk1G9iawNM1UI5SN
         2Pvj185PZC25ZnfzvMDV1xNC47YdHXxYNNRttgrQQH2ANBACVn7qFaRRMP8pMrRV96
         XcFMDMS+yPwuABThmAvoW+1fYmPgzfjIOb4+quIzJBs9dxv1k+RC5vOJshAkZewVZ8
         csyNmY6uG4h0hbG8+beNYjtmPZ6X5hQMoVadExzJCyHti0xMqtpomVm+MPlMqiFVyp
         DhNTn8zDNDIp67fva9ebxn0mH0US48iO/jAUQ1/bIdhpDVMQB5WcKTVCIbu1b93XSv
         WVkPOSpbggxLw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1olTnC-0005YK-Hl; Thu, 20 Oct 2022 13:32:55 +0200
Date:   Thu, 20 Oct 2022 13:32:54 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/4] PCI: qcom: Use clk_bulk_ API for 1.0.0 clocks
 handling
Message-ID: <Y1Ex5ks9PIJmPfkf@hovoldconsulting.com>
References: <20221020103120.1541862-1-dmitry.baryshkov@linaro.org>
 <20221020103120.1541862-3-dmitry.baryshkov@linaro.org>
 <Y1EsOGhEqNe9Cxo6@hovoldconsulting.com>
 <30850757-0e39-bd3d-0d4f-cdb4627b097c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30850757-0e39-bd3d-0d4f-cdb4627b097c@linaro.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 20, 2022 at 02:22:47PM +0300, Dmitry Baryshkov wrote:
> On 20/10/2022 14:08, Johan Hovold wrote:
> > On Thu, Oct 20, 2022 at 01:31:18PM +0300, Dmitry Baryshkov wrote:

> >> +	res->clks[0].id = "aux";
> >> +	res->clks[1].id = "iface";
> >> +	res->clks[2].id = "master_bus";
> >> +	res->clks[3].id = "slave_bus";
> >>   
> >> -	res->slave_bus = devm_clk_get(dev, "slave_bus");
> >> -	if (IS_ERR(res->slave_bus))
> >> -		return PTR_ERR(res->slave_bus);
> >> +	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
> >> +	if (ret < 0)
> >> +		return ret;
> > 
> > Are you sure there are no dependencies between these clocks and that
> > they can be enabled and disabled in any order?
> 
> The order is enforced by the bulk API. Forward to enable, backward to 
> disable.

Right you are. (I had it mixed up with a different API which had no such
guarantees and now I can't seem to remember which it was, maybe I dreamt
it.)

> > Are you also convinced that they will always be enabled and disabled
> > together (e.g. not controlled individually during suspend)?
> 
>  From what I see downstream, yes. They separate host and pipe clocks, 
> but for each of these groups all clocks are disabled and enabled in 
> sequence.
> 
> For the newer platforms the only exceptions are refgen (handled by the 
> PHY in our kernels) and ddrss_sf_tbu (only on some platforms), which is 
> not touched by these patches.

Sounds good.

Johan
