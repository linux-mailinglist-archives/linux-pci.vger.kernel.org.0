Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DCD6D6DA9
	for <lists+linux-pci@lfdr.de>; Tue,  4 Apr 2023 22:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbjDDULv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Apr 2023 16:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjDDULu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Apr 2023 16:11:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC85B1FE8;
        Tue,  4 Apr 2023 13:11:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 664916381D;
        Tue,  4 Apr 2023 20:11:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF5CC433D2;
        Tue,  4 Apr 2023 20:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680639104;
        bh=6ehy8G3pD6IYMdwCFbrMYKYPGv4TXuD5wVAph2mLKS0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=iuZEXUqZ9ZwxZvj7eZoUbOiQ+cu047t6Quefhy5dMvtSvhC4S3YsPk/e4pyh6c7+M
         3aUtAv+50FpMovtZZrgulMWV2Yq1OK2iYyyzkoOrk7ROs/WfcJAuhFXko71PpAWv5q
         bx0/FghLYgahH5Sq44vFjONX+Rg8HWcrWOmkKX4HFhiYJLzgjW0HKGzqwfJvuH5wnS
         BEbPTPeUhyu7l+VUz96pQRRukOekbAGkDZxkPbpnOTEyhtsBqgVSIHV3EZuMG0YXk8
         etzNmtUNHXDuWlcnwfHBRKmu/ZjISwbK4xM+LaIGdY9C77ZXQYnpqpuRK5KoX70kRe
         ifU3lGCiLKm5A==
Message-ID: <2f8d6e564d8f0b8ea90b5c1046152efa.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230404164828.8031-2-quic_devipriy@quicinc.com>
References: <20230404164828.8031-1-quic_devipriy@quicinc.com> <20230404164828.8031-2-quic_devipriy@quicinc.com>
Subject: Re: [PATCH V2 1/9] dt-bindings: clock: Add PCIe pipe clock definitions
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
Date:   Tue, 04 Apr 2023 13:11:42 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quoting Devi Priya (2023-04-04 09:48:20)
> Add PCIe pipe clock definitions for IPQ9574 SoC
>=20
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
