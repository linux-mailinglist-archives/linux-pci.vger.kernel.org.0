Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518C162C0D3
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 15:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiKPOay (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 09:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiKPOax (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 09:30:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A99B7669;
        Wed, 16 Nov 2022 06:30:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFEAF61E0F;
        Wed, 16 Nov 2022 14:30:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40490C433D6;
        Wed, 16 Nov 2022 14:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668609051;
        bh=/AjG37WtkubkiMBOzXPXptvhwcVGBkvHlGfpc12mPB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IHkZttgC9Fbbspo2+F+4pjHovPsNkaRrXzMEqMhyJ+7tRRoJvGoqH2luLeZp+l3U1
         Y2AJzdGJ962Yil57jHkq+AVkbedc41cPnDy5H/GxpyJtW2x46Hn8ui+xEys/ph5uT8
         s8zVNMw+gvCiBDT74B36VtP6E3RJhX//q6HQd1bXuaZtFk3CFcA7qbTa9xLYHCyoPf
         qU1gyzUuabFFa6rJiU6FjGLla1Y4w9nDJ/3USZXd4Yb/sO9lvm95js9WNgE+/O3vIG
         Qd9ktneKP8Te0RFy+uGVCppvjEVajXP4mcLGRC2j9DKSPm7ceJtGQ3hUY5yVCdnrPO
         L3aRPByQU03mw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ovJQj-0003Ax-II; Wed, 16 Nov 2022 15:30:21 +0100
Date:   Wed, 16 Nov 2022 15:30:21 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/8] dt-bindings: phy: qcom,qmp-pcie: add sm8350
 bindings
Message-ID: <Y3Tz/TzTsygFmZED@hovoldconsulting.com>
References: <20221110183158.856242-1-dmitry.baryshkov@linaro.org>
 <20221110183158.856242-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110183158.856242-3-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[ You forgot to CC me on v3, but my filters caught a couple. ]

On Thu, Nov 10, 2022 at 09:31:52PM +0300, Dmitry Baryshkov wrote:
> Add bindings for the PCIe QMP PHYs found on SM8350.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan
