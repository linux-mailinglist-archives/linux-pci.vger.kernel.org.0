Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF505B20A3
	for <lists+linux-pci@lfdr.de>; Thu,  8 Sep 2022 16:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbiIHOgB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Sep 2022 10:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiIHOgA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Sep 2022 10:36:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3438A571B;
        Thu,  8 Sep 2022 07:35:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 267B361D2F;
        Thu,  8 Sep 2022 14:35:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E98C433D6;
        Thu,  8 Sep 2022 14:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662647758;
        bh=RSS/EckZiDCtJ8I6CYD9L89Lsobvazkg89mOZsPZhBU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A2c6rL033b+mQy0wmpPz5qgaqvRBIzJM0dNnzyp4RDf1zdpr+PpuTUH+0kOSk7lSz
         DZNaZkbUbWDeo/538T4oC3g60hg/OYEbTFG59ksky2wlh+W46PCvLIBFd9gc0Boz+a
         olsFuYLldf/Z56r28DK9wC6iuomOV1Cjirybymw4geCLlbHRplLcDoj+cnRqSB8pQe
         XsEw2LegYNHDSh5NLMWrfyklXAr5Atu6U36/Gf02irugnW6UNeRZaZRlfns0hYUKO+
         OXVXVZE+9C77yGP5CmIlhuMR79xFdBnjt51KMKp5HroQ+mcCo8Jd5NOHs6e36usiES
         hq+OeD9Rv1ljw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1oWIdI-008wTI-9p;
        Thu, 08 Sep 2022 15:35:56 +0100
Date:   Thu, 08 Sep 2022 15:35:55 +0100
Message-ID: <878rmuue5w.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Frank Li <frank.li@nxp.com>
Cc:     kernel test robot <lkp@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>,
        "lznuaa@gmail.com" <lznuaa@gmail.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
Subject: Re: [EXT] Re: [PATCH v9 2/4] irqchip: Add IMX MU MSI controller driver
In-Reply-To: <AM9PR04MB87938383F2FB0299CE228B4C88409@AM9PR04MB8793.eurprd04.prod.outlook.com>
References: <20220907034856.3101570-3-Frank.Li@nxp.com>
        <202209080757.hQMfrrfm-lkp@intel.com>
        <87h71iqrgg.wl-maz@kernel.org>
        <AM9PR04MB87938383F2FB0299CE228B4C88409@AM9PR04MB8793.eurprd04.prod.outlook.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: frank.li@nxp.com, lkp@intel.com, tglx@linutronix.de, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com, kbuild-all@lists.01.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev, lznuaa@gmail.com, imx@lists.linux.dev, manivannan.sadhasivam@linaro.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 08 Sep 2022 15:26:50 +0100,
Frank Li <frank.li@nxp.com> wrote:
> 
> > >    s390-linux-ld: drivers/irqchip/irq-imx-mu-msi.o: in function
> > `imx_mu_of_init':
> > > >> drivers/irqchip/irq-imx-mu-msi.c:316: undefined reference to
> > `devm_platform_ioremap_resource_byname'
> > 
> > This is about the 4th time this breakage gets reported. You keep
> > reposting this series without addressing it. What is it going to take
> > for you to finally fix it? Clearly, I'm not going to bother taking a
> > series that has pending build breakages.
> 
> [Frank Li] I also frustrate it now.  Robot use random config and can't 
> Report all problems once.  Recently update to gcc 12.x.  Build broken
> Happen at other place at my environment.  

Well, that's your job to address them. Honestly, cross-compiling for a
few extra architectures isn't that hard.

	M.

-- 
Without deviation from the norm, progress is not possible.
