Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F81697455
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 03:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjBOCay (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 21:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBOCax (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 21:30:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C7E3018A;
        Tue, 14 Feb 2023 18:30:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D61F1B81EC2;
        Wed, 15 Feb 2023 02:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C412C433D2;
        Wed, 15 Feb 2023 02:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676428249;
        bh=AGKHwaWB4r2pf6OIJmuGGiQ7u++qJmgJ46AI7QfoCnY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=piHYo2QCCVPxHHcUu0D4PnDLzWPeCK132mCT+sFpVriDNYEPDwdRFa2norYqX4k1a
         TzozbbBPfOPqeDQuhxFqNWxsdYrjDI1KZor2ix8EvqMFHtg40MQcBaASYzCvOXGSsp
         rOGDC9jkx/3vBtL40K9iLS5KliBRMBrOKljPVHU2vTcL3DuPv0etld6jlGJp1Ax896
         9NXQW9uc/EhusGN+MX1ZtfXpXaRZVdStLsHA5wqEDpW+dpxOdOEnw1+b8IqGsQGLZC
         WaYv9ZkBPZk12BV2TynueyDaMHHznXmQ73q795w9RIBmGvBPJpdtxzY1keQ6xf/KK/
         qFtqKXfSM8pvg==
Message-ID: <f439f476121a5624b5243b0b340bd9a4.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230214164135.17039-6-quic_devipriy@quicinc.com>
References: <20230214164135.17039-1-quic_devipriy@quicinc.com> <20230214164135.17039-6-quic_devipriy@quicinc.com>
Subject: Re: [PATCH 5/7] dt-bindings: clock: Add PCIe pipe clock definitions
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, bhelgaas@google.com,
        devicetree@vger.kernel.org, kishon@kernel.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        kw@linux.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        lpieralisi@kernel.org, mani@kernel.org, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh@kernel.org, svarbanov@mm-sol.com,
        vkoul@kernel.org
Date:   Tue, 14 Feb 2023 18:30:47 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quoting Devi Priya (2023-02-14 08:41:33)
> Add PCIe clock definitions for IPQ9574 SoC
>=20
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>  include/dt-bindings/clock/qcom,ipq9574-gcc.h | 276 ++++++++++---------
>  1 file changed, 140 insertions(+), 136 deletions(-)
>=20
> diff --git a/include/dt-bindings/clock/qcom,ipq9574-gcc.h b/include/dt-bi=
ndings/clock/qcom,ipq9574-gcc.h
> index feedfdd5e00a..c89e96d568c6 100644
> --- a/include/dt-bindings/clock/qcom,ipq9574-gcc.h
> +++ b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
> @@ -74,140 +74,144 @@
>  #define GCC_PCIE3_AXI_S_BRIDGE_CLK                     65
>  #define GCC_PCIE3_AXI_S_CLK                            66
>  #define PCIE0_PIPE_CLK_SRC                             67
> -#define PCIE1_PIPE_CLK_SRC                             68

Just add the new define at the end. This number and define is ABI
forever and shouldn't change.

> -#define PCIE2_PIPE_CLK_SRC                             69
> -#define PCIE3_PIPE_CLK_SRC                             70
