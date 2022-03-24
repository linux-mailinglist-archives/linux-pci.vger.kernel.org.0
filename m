Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62814E674E
	for <lists+linux-pci@lfdr.de>; Thu, 24 Mar 2022 17:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245224AbiCXQ4J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Mar 2022 12:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352141AbiCXQz4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2022 12:55:56 -0400
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [IPv6:2001:67c:2050:1::465:204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE90220F
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 09:53:00 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4KPWVy166Zz9sWt;
        Thu, 24 Mar 2022 17:52:58 +0100 (CET)
Message-ID: <a1cb00f8-175e-a9c8-4d01-9ae8baa963e5@denx.de>
Date:   Thu, 24 Mar 2022 17:52:54 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/2] Add support to register platform service IRQ
Content-Language: en-US
From:   Stefan Roese <sr@denx.de>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
References: <20220114075834.1938409-1-sr@denx.de>
In-Reply-To: <20220114075834.1938409-1-sr@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/14/22 08:58, Stefan Roese wrote:
> Some platforms have dedicated IRQ lines for platform-specific System Errors
> like AER/PME etc. The root complex on these platform will use these seperate
> IRQ lines to report AER/PME etc., interrupts and will not generate
> MSI/MSI-X/INTx interrupts for these services.
> 
> These patches will add new method for these kind of platforms to register the
> platform IRQ number with respective PCIe services.
> 
> Changes in v4 (Stefan):
> - Remove 2nd check for PCI_EXP_TYPE_ROOT_PORT
> - Change init_platform_service_irqs() from void to return int
> 
> Changes in v3 (Stefan):
> - Restructure patches from 4 patches in v2 to now 2 patches in v3
> - Rename of functions names
> - init_platform_service_irqs() now uses "struct pci_dev *" instead of
>    "struct pci_host_bridge *"
> - pcie_init_platform_service_irqs() is called before pcie_init_service_irqs()
> - Use more PCIe spec terminology as suggested by Bjorn (hopefully enough, I
>    don't have the spec at hand)

Bjorn, what's the status of this patchset? I was under the impression,
that it would make it into v5.18. Please let me know if something is
missing.

Thanks,
Stefan

> Bharat Kumar Gogada (2):
>    PCI/portdrv: Add option to setup IRQs for platform-specific Service
>      Errors
>    PCI: xilinx-nwl: Add method to init_platform_service_irqs hook
> 
>   drivers/pci/controller/pcie-xilinx-nwl.c | 18 +++++++++++
>   drivers/pci/pcie/portdrv_core.c          | 39 +++++++++++++++++++++++-
>   include/linux/pci.h                      |  2 ++
>   3 files changed, 58 insertions(+), 1 deletion(-)
> 

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
