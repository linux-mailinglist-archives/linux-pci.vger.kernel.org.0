Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01054E3F61
	for <lists+linux-pci@lfdr.de>; Tue, 22 Mar 2022 14:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbiCVNV5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Mar 2022 09:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235381AbiCVNVz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Mar 2022 09:21:55 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15696A028;
        Tue, 22 Mar 2022 06:20:27 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id p15so36143720ejc.7;
        Tue, 22 Mar 2022 06:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eDfM6Q9oZjJwK8y7VoDq/V92eKRqzakAI7cbs7aB55g=;
        b=EJo/OvVx4FAubMDazS9cSiX1m+BgpQxQFd+JZjhjGiIOi09oLUO0SAmjQ1vvzbWJRC
         fsd1lUlKpnPncc0nZk8UUKpW8xQGbyekrEhlPtaoUi2nhFXUqHnwK7Zk92GSb/ehxcVn
         ERTq6DOIcr/wbxgNq8T+QnJzz1sEsqtFybk/1iB/qOnzeaby5ZqUY367rAy/e/xMAoTb
         mfUSDyLo1Jv360NcUVVUqcQQwIu2hjz/Khvv7oVWB3UEl40THHcQTeWfZ6+i83IT/i6b
         I7dkTmtrL0foFrOjaihJNSW592VmAoTrzbE+eKU+84f67PLB9C3K9N5HHU7G9p7pQEO9
         X6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eDfM6Q9oZjJwK8y7VoDq/V92eKRqzakAI7cbs7aB55g=;
        b=ylH2mP2m7VF/Ez9bmDFz9MhvCra+S6xHpLNQCOiNlwTidHrCpuXlvFkI0Lcyeey8o1
         esLI43gusnlJeCJPKgqD+KOLzVtRa7NmJiGhxraAtNQyuqFdBVv/+oS+vbGrtao0IdwH
         OZ7313tE2mJnU6Om3eF+5LXE/m679Czm+I7jo7ur5Gi/rCWXQQnDLj0kYqDfAgDEsgN0
         QGXdGce0aqvkgEc9aFKYmQD/e/Jn2n4RGYvB7ri+VI+JlWyZQJYi6JVBAxAV4Y4NZ4NL
         ry9Idf9VlGqkD29YuMholbGKb8TqOd5fB/sK9dk40okVF1p9R96wEuyhQksULWC/VBjM
         zfNg==
X-Gm-Message-State: AOAM5319JYvWVyXmFU799CcOyD99/JqDo9kxTlfXxCWzrflT08OWYCKC
        urOwmqZfFuNCp4kdrpR7yGpwaIZVPWXM+b28LkZ1NPUm
X-Google-Smtp-Source: ABdhPJxb5ANsjWbNR8ToNX6eU9m7/RTX+9CUZOkJsfhJAh2EYqflwh6spCB+NBGQPdksCYrlH3+Ho9OiHXNYrCI3pmU=
X-Received: by 2002:a17:907:1ca7:b0:6e0:346:ca6 with SMTP id
 nb39-20020a1709071ca700b006e003460ca6mr9823732ejc.311.1647955226097; Tue, 22
 Mar 2022 06:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220222162619.14645-1-christian.gmeiner@gmail.com> <CAH9NwWebh9QJ0VevG5b7pnaRnzJ6XcEmeKYgZ=NPPt9ZxTXUfA@mail.gmail.com>
In-Reply-To: <CAH9NwWebh9QJ0VevG5b7pnaRnzJ6XcEmeKYgZ=NPPt9ZxTXUfA@mail.gmail.com>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Tue, 22 Mar 2022 14:20:14 +0100
Message-ID: <CAH9NwWec6ovS1xQbuPsB5duskJdmK_qv4t+URTK6thCvGNST7w@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: cadence: Enable Controller to respond to received
 PTM Requests
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
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

Am Do., 10. M=C3=A4rz 2022 um 13:14 Uhr schrieb Christian Gmeiner
<christian.gmeiner@gmail.com>:
>
> Hi all
>
> > This enables the Controller [RP] to automatically respond with
> > Response/ResponseD messages if CDNS_PCIE_LM_TPM_CTRL_PTMRSEN
> > and PCI_PTM_CTRL_ENABLE bits are both set.
> >
> > Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> > ---
> >  drivers/pci/controller/cadence/pcie-cadence-host.c | 10 ++++++++++
> >  drivers/pci/controller/cadence/pcie-cadence.h      |  4 ++++
> >  2 files changed, 14 insertions(+)
> >
> > diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drive=
rs/pci/controller/cadence/pcie-cadence-host.c
> > index fb96d37a135c..940c7dd701d6 100644
> > --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> > +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> > @@ -123,6 +123,14 @@ static int cdns_pcie_retrain(struct cdns_pcie *pci=
e)
> >         return ret;
> >  }
> >
> > +static void cdns_pcie_host_enable_ptm_response(struct cdns_pcie *pcie)
> > +{
> > +       u32 val;
> > +
> > +       val =3D cdns_pcie_readl(pcie, CDNS_PCIE_LM_PTM_CTRL);
> > +       cdns_pcie_writel(pcie, CDNS_PCIE_LM_PTM_CTRL, val | CDNS_PCIE_L=
M_TPM_CTRL_PTMRSEN);
> > +}
> > +
> >  static int cdns_pcie_host_start_link(struct cdns_pcie_rc *rc)
> >  {
> >         struct cdns_pcie *pcie =3D &rc->pcie;
> > @@ -501,6 +509,8 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
> >         if (rc->quirk_detect_quiet_flag)
> >                 cdns_pcie_detect_quiet_min_delay_set(&rc->pcie);
> >
> > +       cdns_pcie_host_enable_ptm_response(pcie);
> > +
> >         ret =3D cdns_pcie_start_link(pcie);
> >         if (ret) {
> >                 dev_err(dev, "Failed to start link\n");
> > diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pc=
i/controller/cadence/pcie-cadence.h
> > index c8a27b6290ce..1ffa8fa77a8a 100644
> > --- a/drivers/pci/controller/cadence/pcie-cadence.h
> > +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> > @@ -116,6 +116,10 @@
> >  #define LM_RC_BAR_CFG_APERTURE(bar, aperture)          \
> >                                         (((aperture) - 2) << ((bar) * 8=
))
> >
> > +/* PTM Control Register */
> > +#define CDNS_PCIE_LM_PTM_CTRL  (CDNS_PCIE_LM_BASE + 0x0da8)
> > +#define CDNS_PCIE_LM_TPM_CTRL_PTMRSEN  BIT(17)
> > +
> >  /*
> >   * Endpoint Function Registers (PCI configuration space for endpoint f=
unctions)
> >   */
> > --
> > 2.35.1
> >
>
> This patch should be ready to land - or is anything missing?
>

Gentle ping.

--=20
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
