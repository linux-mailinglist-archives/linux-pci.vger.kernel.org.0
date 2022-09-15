Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFDB5B9333
	for <lists+linux-pci@lfdr.de>; Thu, 15 Sep 2022 05:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiIODhQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 23:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiIODhO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 23:37:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8C492F6D;
        Wed, 14 Sep 2022 20:37:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10E55B81D8A;
        Thu, 15 Sep 2022 03:37:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B686C433D7;
        Thu, 15 Sep 2022 03:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663213029;
        bh=Q1Vmh+7bOPQzSlAFsVhCx1QAcFuHH/ieRaqT8rSJNOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ajrcOMnIXlOn/GvhkhU0de1jileDzs8rp+VF+V+TZdAjl+UlRLx1IqrjPgJilv9Vk
         gTSEJQ5m/FpXmzEutHXEasjVOpkuKo47se6OTHYkqxTgiIlPJzzXeQZ8U0DC51g5aC
         s01nfsWLF5oR9jqb2+mJ/hb6o/eoa0q/UxSxPEYo9DMnUjumbB3jrKtsDFruYAdCZo
         m0Dpm4CnQecPWwVuRPSNk09362avsRLW41om5o88+fJIwZvX/hiZxqVasK5hea82Dg
         DHaGrYSnN4yCDO89p31bA89pFCtNYWxluZnn5QHvz9rH35zq86Sds7PcU6AekCjKTp
         as5ciBblHIdpw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, jingoohan1@gmail.com,
        konrad.dybcio@somainline.org,
        Bjorn Andersson <andersson@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        gustavo.pimentel@synopsys.com, dmitry.baryshkov@linaro.org,
        svarbanov@mm-sol.com, robh+dt@kernel.org, bhelgaas@google.com,
        krzysztof.kozlowski+dt@linaro.org,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     johan@kernel.org, vkoul@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: (subset) [PATCH v17 0/6] PCI: dwc: Fix higher MSI vectors handling
Date:   Wed, 14 Sep 2022 22:36:52 -0500
Message-Id: <166321302057.788007.12231815201009656469.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220707134733.2436629-1-dmitry.baryshkov@linaro.org>
References: <20220707134733.2436629-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 7 Jul 2022 16:47:27 +0300, Dmitry Baryshkov wrote:
> I have replied with my Tested-by to the patch at [2], which has landed
> in the linux-next as the commit 20f1bfb8dd62 ("PCI: qcom:
> Add support for handling MSIs from 8 endpoints"). However lately I
> noticed that during the tests I still had 'pcie_pme=nomsi', so the
> device was not forced to use higher MSI vectors.
> 
> After removing this option I noticed that hight MSI vectors are not
> delivered on tested platforms. After additional research I stumbled upon
> a patch in msm-4.14 ([1]), which describes that each group of MSI
> vectors is mapped to the separate interrupt. Implement corresponding
> mapping.
> 
> [...]

Applied, thanks!

[6/6] arm64: dts: qcom: sm8250: provide additional MSI interrupts
      commit: f2819650aab5b037e5e730c88abcd971e96a1637

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
