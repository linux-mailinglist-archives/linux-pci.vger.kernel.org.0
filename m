Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8417852C25B
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 20:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241414AbiERSb0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 14:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241418AbiERSbY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 14:31:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0B82E0A1;
        Wed, 18 May 2022 11:31:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F9CAB82180;
        Wed, 18 May 2022 18:31:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AAF9C385A9;
        Wed, 18 May 2022 18:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652898679;
        bh=oaXu9yIlzU0pF6dtsPo7/yQ20SiRrzOWWQkeerD7K40=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=NcNQiRYoeG3sUn4Vp3b5qHjhCK1FaeC2tJRRYA8VU88cqKD0Qxk6DMeXJub9uS6G1
         ee5jJUdlp60IerMnOQxnkYk8tavXcBSdi7vxpIuFOscCUc6bBOjtFTo51Vhjy7Az8M
         NY2Z6w/0krFFYFn/njGwEmL6VWNRed9IloCsKYMx/8X8WeuHtzYPyRtjg3X8mlQojy
         /lkr8lkdbS7mzcxL9JeEbEWJ4XZTKc3izOi3ocI5/5M6N2JlguBIeyokZTb0Ekm2iu
         lCI4inPBCQ/LwfrI2NAcAAEPSEob4McCvh3V6UcQiKlgSl4Pvy6jenrqP74oqIuPNQ
         VQeUBg6itP3Tg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <783bbf39-779d-3ac8-a965-9d98ec1993ec@linaro.org>
References: <20220513175339.2981959-1-dmitry.baryshkov@linaro.org> <20220513175339.2981959-4-dmitry.baryshkov@linaro.org> <CAE-0n53wjtJpUeMswrkQq1mAQEEfXiUhuvq4W4t=7gMpkbsiNQ@mail.gmail.com> <783bbf39-779d-3ac8-a965-9d98ec1993ec@linaro.org>
Subject: Re: [PATCH v6 3/5] clk: qcom: gcc-sm8450: use new clk_regmap_pipe_src_ops for PCIe pipe clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
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
Date:   Wed, 18 May 2022 11:31:17 -0700
User-Agent: alot/0.10
Message-Id: <20220518183119.9AAF9C385A9@smtp.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

- bouncing Prasad

Quoting Dmitry Baryshkov (2022-05-18 11:26:16)
> On 18/05/2022 20:59, Stephen Boyd wrote:
> > Quoting Dmitry Baryshkov (2022-05-13 10:53:37)
> >> diff --git a/drivers/clk/qcom/gcc-sm8450.c b/drivers/clk/qcom/gcc-sm84=
50.c
> >> index 593a195467ff..a140a89b73b4 100644
> >> --- a/drivers/clk/qcom/gcc-sm8450.c
> >> +++ b/drivers/clk/qcom/gcc-sm8450.c
> >> @@ -239,17 +218,21 @@ static const struct clk_parent_data gcc_parent_d=
ata_11[] =3D {
> >>          { .fw_name =3D "bi_tcxo" },
> >>   };
> >>
> >> -static struct clk_regmap_mux gcc_pcie_0_pipe_clk_src =3D {
> >> +static struct clk_regmap_phy_mux gcc_pcie_0_pipe_clk_src =3D {
> >>          .reg =3D 0x7b060,
> >>          .shift =3D 0,
> >>          .width =3D 2,
> >> -       .parent_map =3D gcc_parent_map_4,
> >> +       .phy_src_val =3D 0, /* pipe_clk */
> >=20
> > Make a define? PCIE0_PIPE_CLK_SRC_VAL and drop the comment?
>=20
> This value can change between the muxes. Thus I'd prefer not to do this.
> Compare it with the parent_maps, where we do not use defines for the=20
> 'val' part.
>=20

We don't have defines for the parent maps because they have defines for
the other side.
