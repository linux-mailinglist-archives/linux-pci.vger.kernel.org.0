Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB25A7F1C47
	for <lists+linux-pci@lfdr.de>; Mon, 20 Nov 2023 19:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjKTSXy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Nov 2023 13:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjKTSXx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Nov 2023 13:23:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BF8C8;
        Mon, 20 Nov 2023 10:23:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA3EC433C7;
        Mon, 20 Nov 2023 18:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700504629;
        bh=eglYaIQ/qtU51O7/Tl79eYRTbxeBJ9UX1J/7CgEKMp8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=o6e+CUPFOXvGngNNWHM9X1PLe9PzMUguk0FCo6af1DPRNJ0p+OepiuLwS7AR5KlZ2
         eakxW+7UEsZuUod6rTu0DKOh7tcfLE6bXTYE1iw3n/kMBFk0UbajUZeu6GoDKN4M3t
         VKhbtXzLK8ghNFU2I80Ncclrv5FKPKqgNxX/uI8+GAcwxlrDTuCohrSL3cZXDsgQcM
         wfpZhvWCvQUwMyN5tVCbMHPHMO22NWWBh9SCrOW4Rm9IAgoZ21fzobRc2A7iGXkhlt
         Y8PjAxr6YZq527RKNFptB80cmQq4RqGgqe6c29UD1Rf03Dz1U8hq9rxNYpyS2+eb3Q
         eYQMD4+/wUcjg==
Date:   Mon, 20 Nov 2023 12:23:47 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v11 19/20] PCI: starfive: Add JH7110 PCIe controller
Message-ID: <20231120182347.GA207554@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c69c1b5-7183-4d34-9689-27cd126a4f4c@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 20, 2023 at 06:07:31PM +0800, Minda Chen wrote:
> On 2023/11/15 19:49, Minda Chen wrote:
> > Add StarFive JH7110 SoC PCIe controller platform driver codes, JH7110
> > with PLDA host PCIe core.
> ...

> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -22,6 +22,13 @@
> >   */
> >  #define PCIE_PME_TO_L2_TIMEOUT_US	10000
> >  
> > +/*
> > + * PCIe r6.0, sec 6.6.1, <Conventional Reset>
> > + * Requires a minimum waiting of 100ms before sending a configuration
> > + * request to the device.
> > + */
> > +#define PCIE_BEFORE_CONFIG_REQUEST_WAIT_MS	100
> > +
> >  extern const unsigned char pcie_link_speed[];
> >  extern bool pci_early_dump;
> >  
> Hi Bjorn
>   I have not checked this carefully.
>   I think the change of pci.h should be moved to a indepent patch.
>   Could you approve this? Kevin will commit a new patch for this.
>   Next version I will remove this change. 

Yes, I think it makes sense to add that #define in a separate patch.

Please trim out the unnecessary context; there's no need for readers
to scroll through the entire driver to get to the useful part, which
is just the last dozen lines or so.

Bjorn
