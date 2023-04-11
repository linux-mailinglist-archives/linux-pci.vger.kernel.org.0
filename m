Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D1F6DE10E
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 18:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjDKQgS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 12:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDKQgR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 12:36:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7A93A8F;
        Tue, 11 Apr 2023 09:36:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9886A62943;
        Tue, 11 Apr 2023 16:36:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A3EC433D2;
        Tue, 11 Apr 2023 16:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681230976;
        bh=HM31XqmcqFK6TzHcoHGA4AUt5rkxraVJvBHJzTof4i0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kV5E8XdYH5V8jW/d8A1V8otct1REBr/Eg5rho9x5nxEUmJrIfJyuJbDV/5nwmylgE
         QvnyQ2EqrpEQqnR0rEECdeg65MoDCftOqUgSg/N36pppO3kKrfAqvJj2Shk9TfXCMr
         QARh7AJAiZzX7ikKsT2wekeC741G9Go/GoWZ4n+54C6uA2/ipQzbMJdN3y5fWV2BHr
         N7PAp0m2TdApGpbfmLRDP4/VXZWnb9BNhFuq7x7HCKF43Em+o0EZWEidcW1wEVjwI7
         IYgwQ4XWLBQUJ22LSwOjqmLmshxSnLrIgBktuslNGqgM/78N7H52ay8GmAjSGx3ZXn
         +m0Vukch8NVQQ==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>, bhelgaas@google.com,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "dt-bindings: PCI: qcom: Add iommu-map properties"
Date:   Tue, 11 Apr 2023 18:36:08 +0200
Message-Id: <168123095198.29829.10981583872399699588.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411121533.22454-1-manivannan.sadhasivam@linaro.org>
References: <20230411121533.22454-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 11 Apr 2023 17:45:33 +0530, Manivannan Sadhasivam wrote:
> This reverts commit 6ebfa40b63ae65eac20834ef4f45355fc5ef6899.
> 
> "iommu-map" property is already documented in commit
> ("dt-bindings: PCI: qcom: Add SM8550 compatible") along with the "iommus"
> property.
> 
> So let's revert the commit that just added "iommu-map" to avoid
> duplication.
> 
> [...]

Applied to controller/qcom, thanks!

[1/1] Revert "dt-bindings: PCI: qcom: Add iommu-map properties"
      https://git.kernel.org/pci/pci/c/dc8d33452b36

Thanks,
Lorenzo
