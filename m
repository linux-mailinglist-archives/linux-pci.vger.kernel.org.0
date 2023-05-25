Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA2A7104EF
	for <lists+linux-pci@lfdr.de>; Thu, 25 May 2023 06:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240129AbjEYE5U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 May 2023 00:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239747AbjEYEze (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 May 2023 00:55:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BF719B3;
        Wed, 24 May 2023 21:52:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64F76642CC;
        Thu, 25 May 2023 04:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA26C433A0;
        Thu, 25 May 2023 04:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990320;
        bh=xA0iI93qR4zd9WU10Eh3RVb56HUPrQJZ8kFn4LxiFFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fe4ez2y9jYmnTTmOZ0q5TGbkShbQ7k56v8BciDQdiSxSkCJv1KYwE1kko1iITBZ5r
         8j6zkCoC60CqxtIvaoM1D/HESQyDiGgggro9+CTXOq2oJY84tDuI3aBazwwC1QXDdP
         0t7zGoOud8omhaP+jgeKRpEZXVQX9Qtm7ibKs3sfBmVYSxSDk57HZrNNcDVvdA+Va/
         pTvoTMoTRso0ZCGGJA1hVmi/PC4WOgdClgsuC9sef0rIorqA8Eze8WqtT/MYGAn6hr
         3ix5jGfGp4VuKG5J9Ipwr6uXcRnx1CjqnZxm5q3J6b8Be8XRdkE64ztBDT0qbbs8Ah
         fu1qiHaIqWQ+w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, Rohit Agarwal <quic_rohiagar@quicinc.com>,
        robh@kernel.org, bhelgaas@google.com, lpieralisi@kernel.org,
        conor+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        konrad.dybcio@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 0/5] Add PCIe EP support for SDX65
Date:   Wed, 24 May 2023 21:54:38 -0700
Message-Id: <168499048186.3998961.9705003317556607760.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <1684432073-28490-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1684432073-28490-1-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 18 May 2023 23:17:48 +0530, Rohit Agarwal wrote:
> Changes in v6:
>  - Rebased on top of 6.4-rc2.
> 
> Changes in v5:
>  - Addressed some minor comments from Konrad
>  - Rebased on top of 6.3-rc5.
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: PCI: qcom: Add SDX65 SoC
      (no commit info)
[2/5] ARM: dts: qcom: sdx65: Add support for PCIe PHY
      commit: 92543a1ef22d0270425a4dfe8efe4ab30c4a8a5e
[3/5] ARM: dts: qcom: sdx65: Add support for PCIe EP
      commit: 91dfb64ba70bab4d3517f4e7cb2e4cc8f5a8f81a
[4/5] ARM: dts: qcom: sdx65-mtp: Enable PCIe PHY
      commit: 07bb20f207cb5868a47217681e4843f566843d29
[5/5] ARM: dts: qcom: sdx65-mtp: Enable PCIe EP
      commit: e110dea61ff3f35e6d15e8c5009fb0e876a7d8ae

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
