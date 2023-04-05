Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3236D731D
	for <lists+linux-pci@lfdr.de>; Wed,  5 Apr 2023 06:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236980AbjDEEH2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Apr 2023 00:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236898AbjDEEG4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Apr 2023 00:06:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057C63C32;
        Tue,  4 Apr 2023 21:06:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6F8463978;
        Wed,  5 Apr 2023 04:06:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5756FC4339E;
        Wed,  5 Apr 2023 04:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680667592;
        bh=sNA4A5/xKx0W9W6Lq1bQvUn8Rezdt89XpeseR2IV4Nc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D3r9iwlj8n0dPE9RGV5R+U+YmJ2IMHc7ikzKiPefza0bvI2lY1JNZZvu+DtA5BNFz
         wyY7sqTA9NcSCF56H1odxa/ePyLDXp+T54k3enzRExeOz/EILPRvb7WK+2u6G91ZpJ
         TRgXB9xGTYj/kkflpE+mF4zx2oh3hPhjnpj1E82e61v0T64jTw1SRGdCcs22D957mz
         00aVslhgJmyyHi0BIB4peHGWpTIC8Tuy45ohTA5weXVrE/k2fD/aTdIV7cdDwR0gla
         pRN8wbKnPQtxx1Caea8VhhIoS9ydMo4rvOnom8wCEmIBoAek1U27tFBPtadKYjjgo+
         vZpve3mNvB8Lw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lpieralisi@kernel.org, robh@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_srichara@quicinc.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, konrad.dybcio@linaro.org
Subject: Re: (subset) [PATCH v5 00/19] Qcom PCIe cleanups and improvements
Date:   Tue,  4 Apr 2023 21:09:03 -0700
Message-Id: <168066774422.443656.18294133309436698061.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230316081117.14288-1-manivannan.sadhasivam@linaro.org>
References: <20230316081117.14288-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 16 Mar 2023 13:40:58 +0530, Manivannan Sadhasivam wrote:
> This series brings in several code cleanups and improvements to the
> Qualcomm PCIe controller drivers (RC and EP). The cleanup part mostly
> cleans up the bitfield definitions and transitions to bulk APIs for clocks,
> and resets. The improvement part adds the debugfs entries to track link
> transition counts in RC driver.
> 
> Testing
> -------
> 
> [...]

Applied, thanks!

[16/19] arm64: dts: qcom: sdm845: Add "mhi" region to the PCIe nodes
        commit: b8e0ed06d1a569694c8976c3563bbd0aae728e1d
[17/19] arm64: dts: qcom: sm8250: Add "mhi" region to the PCIe nodes
        commit: 89210342406b91954c514d171baeabb91f85f0a5
[18/19] arm64: dts: qcom: sc8280xp: Add "mhi" region to the PCIe nodes
        commit: de7d3d2f9ddef9a3305decccdd3b95b09fd2bd46

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
