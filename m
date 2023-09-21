Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28FC7A9962
	for <lists+linux-pci@lfdr.de>; Thu, 21 Sep 2023 20:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjIUSOJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Sep 2023 14:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjIUSNi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Sep 2023 14:13:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B2E8613D;
        Thu, 21 Sep 2023 10:37:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DA4C4E761;
        Thu, 21 Sep 2023 15:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695308896;
        bh=L0Y9YCcXIfYgNBjuyvMWPQWu9ej2m027Mk4wviryPFc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gFqOvKwD82XZsHe76trqDACk/ukmKSHQJwz7bCZ7MJEH6nifbgBEjKRk6FWVzvDum
         ooqrhdbeY3pDtPMG4uXEcnIVGNJGRkxhdeX81V/m+WYU6IG4sOSGXuQOwEfFfHhY8/
         cQ3dnRizGPzyY24kv5ahl5Qxo2rqKrpqZqQNU6zkqXhBy36+wTFXYaYfAH9NH3701w
         3tk7aPFDVUmL5+XcB13lGwt7TITWrmlIM+um0rBia3JEQEPMyQWXUXGogl03F+zXUs
         I6fouyBEvFdignF5f+LWfr7ti9Gvs6tWnXCG+Y0wACYnSmQvrXmLQf/FjekRCApaKS
         lwKCQM68yqdAg==
Date:   Thu, 21 Sep 2023 10:08:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Minda Chen <minda.chen@starfivetech.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v6 08/19] PCI: plda: Add event interrupt codes and IRQ
 domain ops
Message-ID: <20230921150814.GA330660@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230916-rescuer-enroll-dd4fb1320676@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 16, 2023 at 01:11:29AM +0100, Conor Dooley wrote:
> On Fri, Sep 15, 2023 at 06:22:32PM +0800, Minda Chen wrote:
> > For PolarFire implements non-PLDA local interrupt events, most of
> > event interrupt process codes can not be re-used. PLDA implements
> > new codes and IRQ domain ops like PolarFire.
> > 
> > plda_get_events() adds a new IRQ num to event num mapping codes for
> > PLDA local event except DMA engine interrupt events. The DMA engine
> > interrupt events are implemented by vendors.
> > 
> > Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> 
> Perhaps not important as they will go away in the next patch, but for
> this patch the riscv patchwork stuff noticed:
> drivers/pci/controller/plda/pcie-plda-host.c:114:36: warning: unused variable 'plda_evt_dom_ops' [-Wunused-const-variable]
> drivers/pci/controller/plda/pcie-plda-host.c:118:36: warning: unused variable 'plda_event_ops' [-Wunused-const-variable]

Details like this *are* important because fixing them makes the
individual patches more readable, thanks for noticing!

Bjorn
