Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03827788222
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 10:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjHYIfK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 04:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbjHYIeh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 04:34:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2B619AC;
        Fri, 25 Aug 2023 01:34:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9822A64BF7;
        Fri, 25 Aug 2023 08:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E9DC433C8;
        Fri, 25 Aug 2023 08:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692952475;
        bh=FCtRh2nslorTFJV46o2tCNp1DvRCnNrBaxwZsCG8tak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YjUNLrJPPiUJlG4lIcryD4r6V7wD8BPdtN0Ru12DQxleU4yaYHjuDkNDBDT/NXTYM
         foQVACKGxnBJNgqBD/Ws8daYb96WqoJeu+rQzFCM8cvktNR5z2N++6A+E3jjn+YTAk
         /ohehroDPeQdRm3mrlNgtQcwknIF7kyqIjYcOUr7lMgoGGxKSzTTPFWneav12hT9IU
         WqRprG4dHsJr+lkGpeZsLMMhIPlg+Nz8tV1LqqtAbqdnMFIsqCcX/tfh33E5TUCo2s
         hqXsqYxB2vEcU5tvL5c/JAWCneZdAKxec1eKgxrMUnLZGQ3TZeMpuEsuEMk6YWDGr0
         kP+8Ix7YnG26w==
Date:   Fri, 25 Aug 2023 14:04:22 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Frank Li <Frank.li@nxp.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "kishon@ti.com" <kishon@ti.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>, "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>,
        Peng Fan <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: Re: [PATCH 0/3] Add RC-to-EP doorbell with platform MSI controller
Message-ID: <20230825083422.GB6005@thinkpad>
References: <20230426203436.1277307-1-Frank.Li@nxp.com>
 <AM6PR04MB483849BE4788EE893306F38E88759@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <ZIdFFV5TdAy//Aat@lizhi-Precision-Tower-5810>
 <ZLVK7xX7kPjNaah+@lizhi-Precision-Tower-5810>
 <ZOepCkqSnUmTdGHX@lizhi-Precision-Tower-5810>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZOepCkqSnUmTdGHX@lizhi-Precision-Tower-5810>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 24, 2023 at 03:01:30PM -0400, Frank Li wrote:
> On Mon, Jul 17, 2023 at 10:06:39AM -0400, Frank Li wrote:
> > On Mon, Jun 12, 2023 at 12:17:25PM -0400, Frank Li wrote:
> > > On Fri, May 12, 2023 at 02:45:12PM +0000, Frank Li wrote:
> > > > > 
> > > > > This patches add new API to pci-epf-core, so any EP driver can use it.
> > > > > 
> > > > > The key point is comments from Thomas Gleixner, who suggest use new
> > > > > PCI/IMS. But arm platform change still not be merged yet.
> > > > > 
> > > > > git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git devmsi-v2-arm
> > > > > 
> > > > > So I still use existed method implement RC to EP doorbell.
> > > > > 
> > > > > If Thomas Gleixner want to continue work on devmsi-v2-arm, I can help test
> > > > > and update this patch.
> > > > > 
> > > > 
> > > > Ping?
> > > 
> > > Ping? 
> > 
> > ping? 
> 
> @Mani
>      Do you have chance to review these patches? It provide a common
> method with GIC ITS to implement notification from RC to EP.
> 

Sorry for the delay. I was wating for a review from Thomas. But since this
series hasn't caught his attention, I'll provide my review next week.

- Mani

> Frank
> 
> > 
> > > 
> > > > 
> > > > > Frank Li (3):
> > > > >   PCI: endpoint: Add RC-to-EP doorbell support using platform MSI
> > > > >     controller
> > > > >   misc: pci_endpoint_test: Add doorbell test case
> > > > >   tools: PCI: Add 'B' option for test doorbell
> > > > > 
> > > > >  drivers/misc/pci_endpoint_test.c    |  41 +++++++++++
> > > > >  drivers/pci/endpoint/pci-epf-core.c | 109
> > > > > ++++++++++++++++++++++++++++
> > > > >  include/linux/pci-epf.h             |  16 ++++
> > > > >  include/uapi/linux/pcitest.h        |   1 +
> > > > >  tools/pci/pcitest.c                 |  16 +++-
> > > > >  5 files changed, 182 insertions(+), 1 deletion(-)
> > > > > 
> > > > > --
> > > > > 2.34.1
> > > > 

-- 
மணிவண்ணன் சதாசிவம்
