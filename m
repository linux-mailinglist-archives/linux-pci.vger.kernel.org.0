Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678C86D6DAF
	for <lists+linux-pci@lfdr.de>; Tue,  4 Apr 2023 22:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjDDUMN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Apr 2023 16:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbjDDUML (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Apr 2023 16:12:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BB91BE2;
        Tue,  4 Apr 2023 13:12:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 338E1633EC;
        Tue,  4 Apr 2023 20:12:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E94EC433D2;
        Tue,  4 Apr 2023 20:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680639125;
        bh=3QRJlwqia2QDWk/e0n89D0bcrqXQfIZCY1IoEbSO2IE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=n8Mq0qza7dwTNwPm0nIIDwj6E/Gjsoqi8BwFRJviM5zeek6Y544V4IUOncLBLsXrx
         yir2J11YboyfJb8uLDWZGO5kaedpkYcrwMhu3QGTtA2EjbXaOlsPbyaj/f9PVQSopt
         cp2a9lJEPwKES/zLJVVozX7jiK6tqNmM1lwsWGu1nJsKBcmfGxOiFEAaOcEk+Tg5dh
         68rnzYotyjpbyrBOvLwtuaCaRNGuB8UKPsH9M1YyJYDsF2nMA/5jd+2H9soaCCym5W
         NwyNMUdP/luC2md/JKNLcw6nbFRj8Cux20os2XRY6H+1QOQ998HSQ+xjNfBWKV1dCj
         dmDNOdISwT8sA==
Message-ID: <1d7dae8417d7978eccdc01d7f60107f8.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230404164828.8031-3-quic_devipriy@quicinc.com>
References: <20230404164828.8031-1-quic_devipriy@quicinc.com> <20230404164828.8031-3-quic_devipriy@quicinc.com>
Subject: Re: [PATCH V2 2/9] clk: qcom: gcc-ipq9574: Add PCIe pipe clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_ipkumar@quicinc.com
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, bhelgaas@google.com,
        devicetree@vger.kernel.org, kishon@kernel.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        kw@linux.com, linus.walleij@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        lpieralisi@kernel.org, mani@kernel.org, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh@kernel.org, vkoul@kernel.org
Date:   Tue, 04 Apr 2023 13:12:03 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quoting Devi Priya (2023-04-04 09:48:21)
> Add the PCIe pipe clocks needed for enabling PCIe in IPQ9574
>=20
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
