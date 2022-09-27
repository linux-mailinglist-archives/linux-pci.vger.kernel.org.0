Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212995EBD03
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 10:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiI0IRf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 04:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiI0IRK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 04:17:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B66979EC;
        Tue, 27 Sep 2022 01:16:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46AD2B81A35;
        Tue, 27 Sep 2022 08:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC51C433C1;
        Tue, 27 Sep 2022 08:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664266611;
        bh=HFVQ3B2gRtZ+PI8s3sN7EZre2WiSSz8N337/Z29bmXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nZDSXlVSOSDYtVCiOVrsqZQRb8nTuzM/0diml8OIQMwjayIbh+rDUA3UafAw89h0C
         1sln5Q8SKb02exiWI4+nD+oWc/d8lKFbRAwRjD92wJMHmmHZjyqW5zFOQ6ThJzR+GZ
         isefmAm3w+O8PiGeH183ATtyuoSm31jVcuo7n7NtDBJ+HaDJTgvp3Nr5Wr9/dCmiyf
         8St6Ndm8400PRZCu/01ME8tdlTLE9eeB92jYImdG7hhWcK1uyUl7DGDNjoKRP81Uh1
         jXEqe0heSGxtxcnDqVD4AFLc07rNf+gDg1GYrAoPs89uH8dfZ/Ksm5ZoSE0eRs22ct
         OJDopY4lMz8MA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1od5lx-0005WM-VP; Tue, 27 Sep 2022 10:16:58 +0200
Date:   Tue, 27 Sep 2022 10:16:57 +0200
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
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v5 5/5] PCI: qcom-ep: Setup PHY to work in EP mode
Message-ID: <YzKxeWrhed20XLKj@hovoldconsulting.com>
References: <20220926173435.881688-1-dmitry.baryshkov@linaro.org>
 <20220926173435.881688-6-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926173435.881688-6-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 26, 2022 at 08:34:35PM +0300, Dmitry Baryshkov wrote:
> Call phy_set_mode_ext() to notify the PHY driver that the PHY is being
> used in the EP mode.
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

You forgot Jingoo's tag here too.

Johan
