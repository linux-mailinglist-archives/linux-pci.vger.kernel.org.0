Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A350665977C
	for <lists+linux-pci@lfdr.de>; Fri, 30 Dec 2022 12:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiL3LIv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Dec 2022 06:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiL3LIu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Dec 2022 06:08:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CE82BE6;
        Fri, 30 Dec 2022 03:08:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 814ADB81BB3;
        Fri, 30 Dec 2022 11:08:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E075C433D2;
        Fri, 30 Dec 2022 11:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672398527;
        bh=x960N/FOlAW8vIqJIIQSYtb2+7LJKCRkTDYzD2ebnMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FSQ/Izs30GpDwt/PvZVjyAqSfsF16ud3fxls/WN3ZEooGJ8HY48MP+pE+COFTvMpx
         VLgW/AqPAR3jAekfoFRJms+XqGBTIfhJF6HqIAEENHvlqAwc78CnfjTYCvuABnmL1I
         j7KDELG8t8sagMBkPxIItHrQW/L6FE18H3XqSDvIzyvuKkTTqk4CJ+cG7uPqeCs2/c
         2o1up9Fta2e/Gar/nSqC6lFkAQ+1rl55d8jizfze6u2wiwObum8A0Or7Zxu5P3nrjL
         RwJY4cad0IPXfluIEbVYLqGtEY8Vxmb87B59nQTBf1vk8jipUTZf92/q855+NvvwlV
         ZHEq0HVaiVwtg==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: (subset) [PATCH 1/4] dt-bindings: PCI: qcom: add MSM8998 specific compatible
Date:   Fri, 30 Dec 2022 12:08:25 +0100
Message-Id: <167239846281.742638.918628227544664589.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221115125310.184012-1-krzysztof.kozlowski@linaro.org>
References: <20221115125310.184012-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 15 Nov 2022 13:53:07 +0100, Krzysztof Kozlowski wrote:
> Add new compatible for MSM8998 (compatible with MSM8996) to allow
> further customizing if needed and to accurately describe the hardware.
> 
> 

Applied to pci/dt, thanks!

[1/4] dt-bindings: PCI: qcom: add MSM8998 specific compatible
      https://git.kernel.org/lpieralisi/pci/c/c427f45c1e99
[2/4] dt-bindings: PCI: qcom: unify clock order between MSM8996 and MSM8998
      https://git.kernel.org/lpieralisi/pci/c/3617fb0d8345

Thanks,
Lorenzo
