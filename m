Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D23745CB5
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jul 2023 15:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjGCNAU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jul 2023 09:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjGCNAR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jul 2023 09:00:17 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6EFDD;
        Mon,  3 Jul 2023 06:00:16 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-570877f7838so53495357b3.0;
        Mon, 03 Jul 2023 06:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688389216; x=1690981216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWZCk4tqQMrEU/bNO08A1lLrQO0SfKho5kRVavBCHFQ=;
        b=IIq10T5h1i9DEIb/p3dlx4mW3Ye/hUp7D6R8pnmuFFPxStHsKRoaOtmZ+7t35ofv6P
         qcckLdUz1UIfcFl+DE0kmW8eE/2wbylV39IRZz+lfwkAZmdJ6GokZFXHPb/F3yu7wCZ+
         dUUQsVoIcKir3f1moSULoo176olkcVNam5vLlH7WVrLHTBULp8NY4g9DxIETK3w07l7A
         HSyvCRIa1SK/urPI+j1jPLdZjo6Kac6CFsObMuMICgzTYafylsEGndpgNQlRULozW/ow
         YIGW+15gxh6vi5yLnBRY2XK2VkLIwUX4WhbyU6esqRa5/xHYbjpfs6EXuzYnOqnFsf57
         qpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688389216; x=1690981216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWZCk4tqQMrEU/bNO08A1lLrQO0SfKho5kRVavBCHFQ=;
        b=WgQGdNqSCCGSlny2TjZXiWZKIj2e4SIcHC7u4jseLAvBM5vhaeh44t6awDpbbz04yE
         +7HNPIgvUlxgxMEthj0gb5JbnOz/rAF7QzA0DAIVj/XFDAi0x2r1OBN7K7/NowcRfo68
         J1wdl2eTD6Px9jG1KO5/SicM5VUufZYySVTAO/k7FGt43Qx3BaFPGT5NTqxyHFjxgwN8
         0lPK4nsQjKDvbkecklCjaYdD/G4NyV202WB4tD5QDZh1DY7Rq9UkNrzhnoQFH3cdinFp
         6KG0wUiCZUBig7V8yX7hAX2Fpxl5DSrv35vx7FRuv3WP7bYZ/Y4+P7EeM1Yp8Cjp0qLs
         gqew==
X-Gm-Message-State: ABy/qLbSmBYVWwUPBWwKL8dxtwHBhYJljKQiJAfoH6N7iJjyLtSgVi/z
        oCvh47pYKDioryPMkXr4sd7e30wxhdCgoO6LDtk=
X-Google-Smtp-Source: APBJJlEyUalFHbDy8iouZMbeTnSd6Nn5AoQV7EsG7RnFxiFHLGqQKAcbMK0SmOmujRKno9FLDdvZscQ3t0gkTZzj6xk=
X-Received: by 2002:a25:d888:0:b0:bc4:f495:699f with SMTP id
 p130-20020a25d888000000b00bc4f495699fmr10304687ybg.8.1688389215880; Mon, 03
 Jul 2023 06:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230703085845.2052008-1-rick.wertenbroek@gmail.com>
 <997819c6-0798-e2f9-b94b-fedfbab7fdd8@arm.com> <20230703120825.GA2375438@rocinante>
In-Reply-To: <20230703120825.GA2375438@rocinante>
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date:   Mon, 3 Jul 2023 14:59:39 +0200
Message-ID: <CAAEEuhpP+9ofqDqxL7NEfw5C5KTn-z=kQktgo_3d_w=w1pc+Eg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: rockchip: Use 64-bit mask on MSI 64-bit PCI address
To:     =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, alberto.dassatti@heig-vd.ch,
        dlemoal@kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
        stable@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 3, 2023 at 2:08=E2=80=AFPM Krzysztof Wilczy=C5=84ski <kw@linux.=
com> wrote:
>
> Hello,
>
> > > A 32-bit mask was used on the 64-bit PCI address used for mapping MSI=
s.
> > > This would result in the upper 32 bits being unintentionally zeroed a=
nd
> > > MSIs getting mapped to incorrect PCI addresses if the address had any
> > > of the upper bits set.
> > >
> > > Replace 32-bit mask by appropriate 64-bit mask.
>
> [...]
> > > +#define PCIE_ADDR_MASK                     GENMASK(63, MIN_AXI_ADDR_=
BITS_PASSED)
> >
> > Nit: this probably wants to be GENMASK_ULL(), otherwise it might throw =
a
> > warning if compile-tested for 32-bit.
>
> I can change this to GENMASK_ULL() when I apply the patch.  Unless Rick
> wants to send v3 - either way would be fine. :)
>
>         Krzysztof

Thank you, I'd appreciate that rather than sending a v3.

Regards,
Rick
