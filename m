Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA0652F5DD
	for <lists+linux-pci@lfdr.de>; Sat, 21 May 2022 00:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241949AbiETWtW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 May 2022 18:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiETWtU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2022 18:49:20 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31D1179C1A;
        Fri, 20 May 2022 15:49:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3374BCE2B14;
        Fri, 20 May 2022 22:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56AA5C385A9;
        Fri, 20 May 2022 22:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653086956;
        bh=QUSuhqBatMv8a5rfEeAnWy70VQgOK4AIq2PZHng3jEo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hnN5/2oY8U65cCyKnn/alQ9Tsc5vqCKaACJJVs6QupvrwF7Lb2r/78IBzIFN8Rm2s
         j0R7HfW6Di/h4KZNeyN5J6SdKklckpd4pbO86hPNcVUS/I4yLIjNLwZReDtK9/MIWI
         2X1D60VXtd/WzylqG03HYtx9tGQTro9ZXuPhp2Md5LFb1mEMT87PHMWmTwKOnQT/nE
         EFcXophlTAocIBVwGqTnjMsKRX2awH9skaIdk50vG18BsN3KSeZ/ngO9xNKYrl2UUi
         qWxjp7KqXUrT4rnkzcKOw5bBl1INz7iVqSUz2PsQV7uyyCT8bNC9bDqIPKRoGPdYLK
         rmmCjrm3vzpXg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <fa94b8f3-a88d-5d9c-9d8a-7c0316f15cfa@linaro.org>
References: <20220513175339.2981959-1-dmitry.baryshkov@linaro.org> <20220513175339.2981959-3-dmitry.baryshkov@linaro.org> <20220518175808.EC29AC385A5@smtp.kernel.org> <fa94b8f3-a88d-5d9c-9d8a-7c0316f15cfa@linaro.org>
Subject: Re: [PATCH v6 2/5] clk: qcom: regmap: add PHY clock source implementation
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-clk@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof =?utf-8?q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Date:   Fri, 20 May 2022 15:49:14 -0700
User-Agent: alot/0.10
Message-Id: <20220520224916.56AA5C385A9@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quoting Dmitry Baryshkov (2022-05-19 04:16:19)
> On 18/05/2022 20:58, Stephen Boyd wrote:
> > Quoting Dmitry Baryshkov (2022-05-13 10:53:36)
> >> diff --git a/drivers/clk/qcom/clk-regmap-phy-mux.c b/drivers/clk/qcom/=
clk-regmap-phy-mux.c
> >> new file mode 100644
> >> index 000000000000..d7a45f7fa1aa
> >> --- /dev/null
> >> +++ b/drivers/clk/qcom/clk-regmap-phy-mux.c
[...]
> >> +
> >> +#include "clk-regmap-phy-mux.h"
> >=20
> > Same for clk-regmap.h, avoid include hell.
>=20
> I couldn't catch this comment. I think we need clk-regmap.h in=20
> clk-regmap-phy-mux.h as clk_regmap is a part of defined structure.
>=20

Don't rely on implicit includes. It makes changing header files error
prone. Also, please trim replies.
