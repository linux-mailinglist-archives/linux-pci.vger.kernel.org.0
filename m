Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAB476D4DF
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 19:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjHBROP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 13:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbjHBRON (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 13:14:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDC9E42;
        Wed,  2 Aug 2023 10:14:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4471D61A55;
        Wed,  2 Aug 2023 17:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE05C433C7;
        Wed,  2 Aug 2023 17:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690996451;
        bh=F/rbjQiOyfgmgFmuIV8uZJPoftBhb6PoDzmZlYlo/mk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rMetctBa2mih8ulDzZ0ox7FtFspbLeoqpDJNHEjLQqDHnJCex0Ijhf6bQyoSlYyFG
         meh2Pu/LNy222/iMlJt20h1SIzntJ54dHf6YCbQ8MfOlAiaT2d7PC1VAapbTPXHJcj
         sForDf/cJabTCpRFm0IgQmuEmVyAgZKqQs7MG1BRSzHVI+AJpoWa81SzOPhOonnGPw
         tKV3M4aO4f/OHzZFXFdTk6OGdxX4pjB0P8slfchtqkHEmD229HxKkJCMCBp9uaNdFE
         FQcYaVEMVdg5g+sKb7HdRs9WA+2tbuZoZAMWFS1do3N6ITmFqHKtoy+BCjOmNQwHez
         WzAyOO+ItsEhw==
Date:   Wed, 2 Aug 2023 12:14:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Kevin Xie <kevin.xie@starfivetech.com>,
        Minda Chen <minda.chen@starfivetech.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH v1 8/9] PCI: PLDA: starfive: Add JH7110 PCIe controller
Message-ID: <20230802171409.GA62497@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230801071453.afaulygpczpyhopk@pali>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 01, 2023 at 09:14:53AM +0200, Pali Rohár wrote:
> On Tuesday 01 August 2023 15:05:46 Kevin Xie wrote:
> > On 2023/8/1 7:12, Bjorn Helgaas wrote:
> > ...

> > That's the point, we will add a extra 100ms after PERST# de-assert
> > in the patch-v3 according to Base Spec r6.0 - 6.6.1:
> >         msleep(100);
> >         gpiod_set_value_cansleep(pcie->reset_gpio, 0);
> > 
> > +       /* As the requirement in PCIe base spec r6.0, system must wait a
> > +        * minimum of 100 ms following exit from a Conventional Reset
> > +        * before sending a Configuration Request to the device.*/
> > +       msleep(100);
> > +
> >         if (starfive_pcie_host_wait_for_link(pcie))
> >                 return -EIO;
> 
> Maybe this information can be useful here:
> https://lore.kernel.org/linux-pci/20211022183808.jdeo7vntnagqkg7g@pali/

Yes, thank you!  That is a great summary!
