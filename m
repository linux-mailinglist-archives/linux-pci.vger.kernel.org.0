Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE21C78153E
	for <lists+linux-pci@lfdr.de>; Sat, 19 Aug 2023 00:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240488AbjHRWMn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 18:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241368AbjHRWMm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 18:12:42 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E873ABB
        for <linux-pci@vger.kernel.org>; Fri, 18 Aug 2023 15:12:40 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-525656acf4bso1779318a12.0
        for <linux-pci@vger.kernel.org>; Fri, 18 Aug 2023 15:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20221208.gappssmtp.com; s=20221208; t=1692396759; x=1693001559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYKH/NmU6WV361FL98pZbDTKYddplM6+NEj0oVT8uKk=;
        b=Z5Zxxs0eMs94Ds3sUbkzLP7u9yfDV9lr+Z66ZxbuXlaF2dV0bTvguGofF3tLlq3e2v
         dQ0yHQjDGWRSiNVGDj1hFg10sAWFJ5b+gra5fHttSqwx5Mpn8aN5hiaqCfmodMM9q+g0
         LQbhvzUe/iqGoqAPoIVuVI3/+GoEl8JeRlUo2k3Feb0iwKyhFG3HCVSULbJwgV1QZUsO
         WQCskDq2fIy5vkov1V1A4Kz8Cus4acsm7G7wC3feapARz2XjEx1BHH80NNKOLu1yMiKZ
         g3lqH9GXAs/ABAZe8PbpgjNUZa7VQqcMaUrMhqwuD4R/4afxLyHFe/NVb1U1DCAN0BGa
         Kkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692396759; x=1693001559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYKH/NmU6WV361FL98pZbDTKYddplM6+NEj0oVT8uKk=;
        b=IkSJ4AdpGDTdA8oeAl+0Afq3O93S199cFegs8Mqt2GUrabD4Nus66FwM+eKr8af+nI
         b85KWnpZkAMArL7puAyykHUmV/9W0fdFNQjt4iSv1YpFmHJ0qqOnTXCp+hg0WH2M1GuJ
         IIeiTw3M387OtBaRS8oSHXNTluECxcsRjXyiUSCOdRihQNHTPYVXSjKONDyzHHAQR9nC
         I8Ue7EsRTsFPh1c/LtVDZrIG3PzqHbtbMFK687WyOojwkapnUTTWCb5BfK/SIxhf4ULU
         2KZGmEVD5XQ28pI2JNHfp641gdTPxrmVYYV9TZ3zIyIP5lYINoW4ZeLwg4yAPUppoEPL
         GtjA==
X-Gm-Message-State: AOJu0Yz+uivbK/O8GmHmhbWoA7vh1JJ0fJgZf6iiy6+cb3VcZL26nrsE
        4grkfXqro2QausLA+zmmDEAUnef+WmG7UYn51BOYJxJqv2L3FJx0ALE=
X-Google-Smtp-Source: AGHT+IGdg5/w55xesx3/t5IW99arRUYvtJWJpEYDA/sD/Qp4SjA3LMtC/aTcGpqUBYxuXngwtX4UXBHFldHLkDgzpvQ=
X-Received: by 2002:a17:907:7886:b0:99b:f49c:fcfa with SMTP id
 ku6-20020a170907788600b0099bf49cfcfamr329037ejc.21.1692396759089; Fri, 18 Aug
 2023 15:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230817171242.GA320904@bhelgaas> <alpine.DEB.2.21.2308180051080.8596@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2308180051080.8596@angie.orcam.me.uk>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Fri, 18 Aug 2023 15:12:26 -0700
Message-ID: <CAJ+vNU3DNgJXWN7KebD89zJvNqr_4QF_vnxFwN7LytNVFc-i-A@mail.gmail.com>
Subject: Re: imx8mp pci hang during init
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Bjorn Helgaas <helgaas@kernel.org>, Marek Vasut <marex@denx.de>
Cc:     linux-pci@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 17, 2023 at 5:05=E2=80=AFPM Maciej W. Rozycki <macro@orcam.me.u=
k> wrote:
>
> On Thu, 17 Aug 2023, Bjorn Helgaas wrote:
>
> > [+cc Maciej, smells similar to a89c82249c37 ("PCI: Work around PCIe
> > link training failures") ]
>
>  Quite so indeed.
>
> > > [ 0.499660] imx6q-pcie 33800000.pcie: host bridge /soc@0/pcie@3380000=
0 ranges:
> > > [ 0.500276] clk: Not disabling unused clocks
> > > [ 0.506960] imx6q-pcie 33800000.pcie: IO 0x001ff80000..0x001ff8ffff -=
>
> > > 0x0000000000
> > > [ 0.519401] imx6q-pcie 33800000.pcie: MEM 0x0018000000..0x001fefffff
> > > -> 0x0018000000
> > > [ 0.743554] imx6q-pcie 33800000.pcie: iATU: unroll T, 4 ob, 4 ib,
> > > align 64K, limit 16G
> > > [ 0.851578] imx6q-pcie 33800000.pcie: PCIe Gen.1 x1 link up
> > > ^^^ hang at this point until watchdog resets
>

Maciej and Bjorn,

Thank you for the responses!

>  So I think it's important to figure out where exactly in the kernel code
> the hang happens; this is presumably in host-bridge-specific link bring-u=
p
> code polling link status, which may have to be updated according to or
> otherwise make use of a89c82249c37.  It may also be something completely
> different of course.
>

It's hanging in imx6_pcie_start_link() after the PCI_EXP_LNKCAP
register is updated to allow gen2 during the subsequent
dw_pcie_wait_for_link, specifically within the dw_pcie_read_dbi
function that does a memory read. Due to the mem read hanging the CPU
this tells me that the DWC core has crashed at this point.

What I found is that if I essentially revert the effect of commit
fa33a6d87eac ("PCI: imx6: Start link in Gen1 before negotiating for
Gen2 mode") to start linking at gen3 (or forced to gen2) it appears to
downgrade to gen2 (due to the PI7C9X2G608GPB being a gen2 switch) and
work fine:
diff --git a/drivers/pci/controller/dwc/pci-imx6.c
b/drivers/pci/controller/dwc/pci-imx6.c
index 27aaa2a6bf39..81caaef76e8a 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -876,6 +876,7 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
        u32 tmp;
        int ret;

+#if 0
        /*
         * Force Gen1 operation when starting the link.  In case the link i=
s
         * started in Gen2 mode, there is a possibility the devices on the
@@ -887,6 +888,7 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
        tmp |=3D PCI_EXP_LNKCAP_SLS_2_5GB;
        dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, tmp);
        dw_pcie_dbi_ro_wr_dis(pci);
+#endif

        /* Start LTSSM. */
        imx6_pcie_ltssm_enable(dev);
@@ -895,6 +897,7 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
        if (ret)
                goto err_reset_phy;

+#if 0
        if (pci->link_gen > 1) {
                /* Allow faster modes after the link is up */
                dw_pcie_dbi_ro_wr_en(pci);
@@ -937,6 +940,7 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
        } else {
                dev_info(dev, "Link: Only Gen1 is enabled\n");
        }
+#endif

        imx6_pcie->link_is_up =3D true;
        tmp =3D dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);

So I think you are correct in that I need to do the same thing that
was done in a89c82249c37 for the imx6 dwc driver which essentially
forces it the other way going from gen1->gen2->gen3 (upward) instead
of gen3->gen2->gen1 (downard).

I've cc'd Marek who authored commit fa33a6d87eac ("PCI: imx6: Start
link in Gen1 before negotiating for Gen2 mode") in hopes that he might
remember what switch or switches he needed this change for. I'm not
even clear what IMX6 SoC 10 years ago even had gen2 capability.

I found that the PI7C9X2G608GPB used here has an errata "E11: GEN2
Change-Rate Issue with Certain Root Complex Platforms" that describes
an issue observed in certain PCIe gen3 platforms during a rate change
from 2.5Gbps to 5Gbps caused by the switch entering a recovery state
that can timeout at which point according to the errata "After the
link-down process, all the registers are reset to the default values"
which is likely whats causing the DWC controller to hang.

My gut feel is that commit a89c82249c37 ("PCI: Work around PCIe link
training failures") likely would resolve the issues that Marek had
which prompted him to make the imx6 driver go from gen1 upward and
that if we changed the driver to go from gen3 downward it would
resolve my issue as well. However, I don't know what the 'correct'
link training sequence should really be (upward or downward) so it's
hard to say what the right workaround is. Is there a correct link
training sequence and if so how many controllers are using it vs
having to reverse it to workaround hardware quirks?

>  Can you see if you can bump the link up beyond 2.5GT/s by poking at host
> bridge registers by hand with `setpci' once the link been successfully
> established at 2.5GT/s?
>

I'll have to try that. Instead of using the PCI_EXP_LNKCTL like the
pcie_retrain_link() function does the imx6 driver touches some DWC
register that I don't have documentation for so essentially what your
asking will test retraining the more standard way using the config
registers:
                /*
                 * Start Directed Speed Change so the best possible
                 * speed both link partners support can be negotiated.
                 */
                tmp =3D dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTRO=
L);
                tmp |=3D PORT_LOGIC_SPEED_CHANGE;
                dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp)=
;
                dw_pcie_dbi_ro_wr_dis(pci);

Best regards,

Tim
