Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7947D2A6B
	for <lists+linux-pci@lfdr.de>; Mon, 23 Oct 2023 08:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbjJWG3P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Oct 2023 02:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbjJWG3O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Oct 2023 02:29:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD23D67;
        Sun, 22 Oct 2023 23:29:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876F3C433CC;
        Mon, 23 Oct 2023 06:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698042551;
        bh=UzV9yMbqCPVXQQpeocsDp/J2O4jHQPgJtVBvMmlCVgE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=djO/kBUSwTiAuTbMrLkHAxEYombleyFJ5H0cXRy+NqKXFFKldm36vRKzb5Oq27ZiI
         QGUDqrhTz0vpyypORVsCJbtANVnA5DXx3w+bNBf+sA3tyDCpOisZfz5JDoT8pbKlIo
         v9x94mFT9OJ9DMW1lUFin06ARQK/znad3ytk06n4YgpXylSAAlV0mP8veyPda4X3Zc
         PYIgHt16MZabGCzD4rgFgn+ivN+IgrRkWxsi9CeTU4ntui+oEYQUfhnULXs2mcXAQY
         QZu4jhpilDbkTRt/gCze99F4AFZI7aZNOpvrUEHsa3VUktcyoS471szjbAo1WbRAOW
         xhj7SkZXVnIOw==
From:   Vinod Koul <vkoul@kernel.org>
To:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, mani@kernel.org,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org, robh@kernel.org,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_parass@quicinc.com, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhi@lists.linux.dev, linux-phy@lists.infradead.org
In-Reply-To: <1697715430-30820-1-git-send-email-quic_msarkar@quicinc.com>
References: <1697715430-30820-1-git-send-email-quic_msarkar@quicinc.com>
Subject: Re: (subset) [PATCH v3 0/5] arm64: qcom: sa8775p: add support for
 EP PCIe
Message-Id: <169804254205.383714.18423881810869732517.b4-ty@kernel.org>
Date:   Mon, 23 Oct 2023 11:59:02 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Thu, 19 Oct 2023 17:07:05 +0530, Mrinmay Sarkar wrote:
> This series adds the relavent DT bindings, new compatible string,
> update PHY, add support to EPF driver and add EP PCIe node in dtsi
> file for ep pcie0 controller.
> 
> v2 -> v3:
> - removed if/then schemas, added minItems for reg,
>   reg-bnames, interrupt and interrupt-names instead.
> - adding qcom,sa8775p-pcie-ep compitable for sa8775p
>   as we have some specific change to add.
> - reusing sm8450's pcs_misc num table as it is same as sa8775p.
>   used appropriate namespace for pcs.
> - remove const from sa8775p_header as kernel test robot
>   throwing some warnings due to this.
> - remove fallback compatiable as we are adding compatiable for sa8775p.
> 
> [...]

Applied, thanks!

[3/5] phy: qcom-qmp-pcie: add endpoint support for sa8775p
      commit: 8e11a94e15a49221510dd4737a70c8dd56eb9678

Best regards,
-- 
~Vinod


