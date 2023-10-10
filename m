Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C31E7C01F1
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 18:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbjJJQtR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 12:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbjJJQtQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 12:49:16 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EF98E;
        Tue, 10 Oct 2023 09:49:12 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3248ac76acbso5246599f8f.1;
        Tue, 10 Oct 2023 09:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696956550; x=1697561350; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kRoUi3Xaj9/vW3JOic0lJo9yZRKzDYlftz3mCeomBqs=;
        b=bDM4fMv7ppte/XSybaEPCimlr+eajN+9Sv4DpZdrMFTXUwu3yJ8qlZz7ZCZJYw/L3O
         NBuZnaHWe2PwxXljDE8txvc6Ynd4WRMzZ285di8+P/vqFNKwjhRyWSwcrNkRWXrthqHj
         SR/PI02iTJizfXXCymI02MFGC8puVr4dsadbQM67jFl/y7uXkrW7p9VpjZhod9SuWIOT
         TMTTLiq5hIxTN+AGhhhZ1Fqm/NDu+951gU+FDf2Aq6gt9d3KoSV2+5nTQgr+RFM5f8C5
         QsnlKRE8WITlR7Jdm33ynW7evr7aWkvL22ipnRGMT+pTqjUFm/ZMWXksx1+dU0moRXCp
         Vxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696956550; x=1697561350;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kRoUi3Xaj9/vW3JOic0lJo9yZRKzDYlftz3mCeomBqs=;
        b=g8+CfYa95KRiu3ZklH9CyRRNRqt+K/xarUg/CEK9vXbgby39w3cQdqFd8d8sEivCMu
         RiS9/ApgqixS52r9IfqJv71ZUktO7m/OL6uVrVDb+PTSSzfKoDXtLtlhT70St7FS3ysQ
         3nNcH4RdfQDRQbahUvVmBVjlgm53xEx26P2tLmeQErCW3yAjZbxGKO+LI/WgG4+/U4Y6
         fLFq5L98d7kW0VMeinjacMSkpEyzn0qn3I+eaUKXcyndxKMWmlFuwtVtDDLFkkdmqBgP
         0UbqIaGWn04O7Wd0q3g2GIYEBIAQt7i+0eYiSJCasNDiWerbPmwZVieMRWNaM2K9F+jQ
         9hVw==
X-Gm-Message-State: AOJu0Yy535Ja41Dz530TYT2pn4koIAPNYWBKrokrgSJVRKnPQZn8eGRW
        S6zDb/jyW4IXhovlbx0O8v4=
X-Google-Smtp-Source: AGHT+IH+JUkcLf/ecz4OOARVhnPjr2KCLrmDW4cCzSkY9RxtXFVqBpwDpNO/TOhJBJQT5jok2aD36g==
X-Received: by 2002:a5d:674a:0:b0:317:e68f:e1b2 with SMTP id l10-20020a5d674a000000b00317e68fe1b2mr15338549wrw.28.1696956550228;
        Tue, 10 Oct 2023 09:49:10 -0700 (PDT)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id t4-20020a0560001a4400b0032763287473sm13276997wry.75.2023.10.10.09.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 09:49:09 -0700 (PDT)
Message-ID: <65258085.050a0220.dfda3.2518@mx.google.com>
X-Google-Original-Message-ID: <ZSWAhEDlKhBIbZxk@Ansuel-xps.>
Date:   Tue, 10 Oct 2023 18:49:08 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Daniel Golle <daniel@makrotopia.org>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        John Crispin <john@phrozen.org>
Subject: Re: [PATCH] PCI: mediatek-gen3: fix PCIe #PERST being de-asserted
 too early
References: <20231010160423.GA977719@bhelgaas>
 <1E611A63-AD66-4E61-90F9-F1DB41BD6466@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1E611A63-AD66-4E61-90F9-F1DB41BD6466@fw-web.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 10, 2023 at 06:42:07PM +0200, Frank Wunderlich wrote:
> Am 10. Oktober 2023 18:04:23 MESZ schrieb Bjorn Helgaas <helgaas@kernel.org>:
> >On Fri, Oct 06, 2023 at 09:45:58AM +0200, Daniel Golle wrote:
> >> The driver for MediaTek gen3 PCIe hosts de-asserts all reset
> >> signals at the same time using a single register write operation.
> >> Delay the de-assertion of the #PERST signal by 100ms as required by
> >> PCIe CEM clause 2.2, some PCIe devices fail to come up otherwise.
> >> 
> >> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> >> ---
> >>  drivers/pci/controller/pcie-mediatek-gen3.c | 8 +++++++-
> >>  1 file changed, 7 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> >> index e0e27645fdf4..ba8cfce03aad 100644
> >> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> >> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> >> @@ -350,7 +350,13 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
> >
> >I feel like I'm missing something because this patch seems to be
> >adding a delay for T_PVPERL, but the comment before the existing
> >msleep() claims *it* is the T_PVPERL delay:
> >
> >         * Described in PCIe CEM specification sections 2.2 (PERST# Signal)
> >         * and 2.2.1 (Initial Power-Up (G3 to S0)).
> >         * The deassertion of PERST# should be delayed 100ms (TPVPERL)
> >         * for the power and clock to become stable.
> >
> >>  	msleep(100);
> >>  
> >>  	/* De-assert reset signals */
> >> -	val &= ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB);
> >> +	val &= ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB);
> >> +	writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> >> +
> >> +	msleep(100);
> >
> >So I'm confused about these two sleeps.  Are they for different
> >parameters?
> >
> >T_PVPERL is defined from "Power stable to PERST# inactive".  Do we
> >have any actual indication of when to start that delay, i.e., do we
> >have a clue about when power became stable?
> >
> >> +	/* De-assert PERST# signals */
> >> +	val &= ~(PCIE_PE_RSTB);
> >>  	writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> >>  
> >>  	/* Check if the link is up or not */
> >> -- 
> >> 2.42.0
> >> 
> >> 
> >> _______________________________________________
> >> linux-arm-kernel mailing list
> >> linux-arm-kernel@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> Hi
> 
> Seems it is same as the patch i've sent some time ago and which was rejected because of the additional delay...
> 
> https://patchwork.kernel.org/project/linux-mediatek/patch/20230402131347.99268-1-linux@fw-web.de/
> 
> Or am i wrong?
> regards Frank

Reading the other series, I smell this can only be handled by a quirk...
This might be a defect or the board not following PCIE hw specs.

Thing is that the bug/limitation is there and we have enough info to
find way to fix this and lots of tester.

Eventually even a fixup based on a specific compatible.

-- 
	Ansuel
