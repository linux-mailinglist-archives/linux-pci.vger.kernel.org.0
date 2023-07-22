Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C7175DA25
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jul 2023 07:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjGVFPG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Jul 2023 01:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjGVFOb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Jul 2023 01:14:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6A53C24;
        Fri, 21 Jul 2023 22:14:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB9C760AFB;
        Sat, 22 Jul 2023 05:14:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF92C433C8;
        Sat, 22 Jul 2023 05:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690002865;
        bh=4ofCngG6gP1um5SzZmIDgDMUwhzcsEFwqF+1KFyEiYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oSn847ano+FpQBXb1xEELtte5HDJkZfpa1Yx0RaLjITk+GvwBwRvGHRUsVxK6lF5S
         6z3SFXkjPR5veOyMNa9wzTz3/I5yKBIXoOBFPujgsVQXh5TnfDgQFfI8ESagpywFvZ
         /ZEkErLWqIfkQLhKD4CsjGRmHURNznmlu8WAroQvp4Be4ZonQPRDHplniMqNDubBGK
         d68RgyFpIFvWxc1+mBKQ8P7W5xtCCIR6KB8buBWLAZi6nUNC81ZeSYlWUnpUa9vuTT
         NF/nWGlsRyedJrjW6F2Ok9iV/WRqMqCraakwzR/n62LUzfoZZj2vxIClBgTvOhqLcb
         DWsbrb95F3pSw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org, mani@kernel.org,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/4] arm64: qcom: sa8775p: add support for PCIe
Date:   Fri, 21 Jul 2023 22:17:22 -0700
Message-ID: <169000304222.3611206.893707906283849131.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <1689960276-29266-1-git-send-email-quic_msarkar@quicinc.com>
References: <1689960276-29266-1-git-send-email-quic_msarkar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Fri, 21 Jul 2023 22:54:31 +0530, Mrinmay Sarkar wrote:
> Update the relavent DT bindings for PCIe, add new config to the phy
> driver add pcie and phy nodes to the .dtsi file and enable then in
> board .dts file for the sa8775p-ride platform.
> 
> v2 -> v3:
> - to align with dt-bindings rectified pcie default state
> - dropped PCIe PHY dt-bindings and PHY driver in this series as its
>   already applied [1]
> - To verify DTS against bindings for this series we required [2]
> 
> [...]

Applied, thanks!

[3/4] arm64: dts: qcom: sa8775p: Add pcie0 and pcie1 nodes
      commit: 489f14be0e0a19225ef8575e4a04b0f9ee77ab3e
[4/4] arm64: dts: qcom: sa8775p-ride: enable pcie nodes
      commit: bf3ee3db23ed2e72ee61141ade9a3964b509a8d4

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
