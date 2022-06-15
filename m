Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34C454D200
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jun 2022 21:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348732AbiFOTvZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 15:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238210AbiFOTvS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 15:51:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09482DA81;
        Wed, 15 Jun 2022 12:51:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84C38B82170;
        Wed, 15 Jun 2022 19:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD7BC34115;
        Wed, 15 Jun 2022 19:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655322674;
        bh=DvCoug6k0YHjr6paVnzjlnU0KUa/Qy+FPEoMUzOSv8A=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=uWcm6gficM94Z2trgG+4gpRl0et8A+4nG31OItJK/2s+1mVJqWG8B1/9p4xZbKV4K
         DbnDACubuXRbmXSGd1dsT0lmlj8rdpYQvlWZKLCiUoug4n/v7bYX3k2sx2GFQ+nomE
         NAqw6Jg532850TOvhyTy99qHuQUie9IlQ3Rzw/+jgtfP9kdP3PJt6A9nBPgGXj2W8c
         BCvQ95w9sDcbVxhxQMbnagSs2bky1rw9/6vamTJTpHLGm0l4jLeX7YzKKI68zj7TJd
         dj5SizQVh5k8UQPRXIlXmLyA/vUvvg5eXvEBsW6HgEj+bubZMTpHYNFiKw+i9gOACl
         QxtR/PdgDKHEA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220608105238.2973600-6-dmitry.baryshkov@linaro.org>
References: <20220608105238.2973600-1-dmitry.baryshkov@linaro.org> <20220608105238.2973600-6-dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v11 5/5] PCI: qcom: Drop manual pipe_clk_src handling
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org, Johan Hovold <johan@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof =?utf-8?q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>
Date:   Wed, 15 Jun 2022 12:51:12 -0700
User-Agent: alot/0.10
Message-Id: <20220615195114.1FD7BC34115@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quoting Dmitry Baryshkov (2022-06-08 03:52:38)
> Manual reparenting of pipe_clk_src is being replaced with the parking of
> the clock with clk_disable()/clk_enable() in the phy driver. Drop
> redundant code switching of the pipe clock between the PHY clock source
> and the safe bi_tcxo.
>=20
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Tested-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
