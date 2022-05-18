Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F82352B3F9
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 09:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbiERHmW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 03:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbiERHmV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 03:42:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFDF119913;
        Wed, 18 May 2022 00:42:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E43D0B81EB5;
        Wed, 18 May 2022 07:42:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB3BC385A5;
        Wed, 18 May 2022 07:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652859737;
        bh=WYaHCyWZxWA4RQlP16EUbIxXAnAIytwOQ+j9ZaN9jHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dR4s11nKz7OnKkMQmJiQ+aHwand386rwJsvyTGD2h8QE3grp2QgHHKcJ0EyZtrRJ1
         mdkLreBh8b7LD/joAOv3bnZ0RYr9Qhuaa0oEf36cvnOmsRQsnat54s1/PRgj0CasF4
         OmWCfseFPRdfZiKPh9oYBvNeLPF3JTf+yyUTmXbXMXpsUzgPeUscxBXRmKCVD3P2IW
         UDkfgNmfgpeqcAbyOEZStgPEG2Em6RvY8ZLV1Ggx9Zr6iwDEFe/T2+gkp8qNZMxOMU
         dgJT9PcBkmIVdhD+Aa3YunTgrG/vH67iBZz2+nXFdZG0A6SjiAlOnd3Ap/KqTN0W+Y
         zj0tc6DqPQvcQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nrEK2-0004IB-J4; Wed, 18 May 2022 09:42:18 +0200
Date:   Wed, 18 May 2022 09:42:18 +0200
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
Subject: Re: [PATCH v6 1/5] PCI: qcom: Remove unnecessary pipe_clk handling
Message-ID: <YoSjWqeOK0cMtfdm@hovoldconsulting.com>
References: <20220513175339.2981959-1-dmitry.baryshkov@linaro.org>
 <20220513175339.2981959-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513175339.2981959-2-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 13, 2022 at 08:53:35PM +0300, Dmitry Baryshkov wrote:
> PCIe PHY drivers (both QMP and PCIe2) already do clk_prepare_enable() /
> clk_prepare_disable() pipe_clk. Remove extra calls to enable/disable
> this clock from the PCIe driver, so that the PHY driver can manage the
> clock on its own.
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Tested-by: Johan Hovold <johan+linaro@kernel.org>
