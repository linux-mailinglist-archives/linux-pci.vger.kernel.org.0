Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11564E675C
	for <lists+linux-pci@lfdr.de>; Thu, 24 Mar 2022 17:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350897AbiCXQ4v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Mar 2022 12:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352052AbiCXQ4t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2022 12:56:49 -0400
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [IPv6:2001:67c:2050:1::465:204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E9858389
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 09:55:08 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4KPWYR1XyCz9sSG;
        Thu, 24 Mar 2022 17:55:07 +0100 (CET)
Message-ID: <cdcf6b43-7baf-c247-8943-1883dde5460c@denx.de>
Date:   Thu, 24 Mar 2022 17:55:02 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/3] Fully enable AER
Content-Language: en-US
From:   Stefan Roese <sr@denx.de>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Yao Hongbo <yaohongbo@linux.alibaba.com>,
        Naveen Naidu <naveennaidu479@gmail.com>
References: <20220125071820.2247260-1-sr@denx.de>
In-Reply-To: <20220125071820.2247260-1-sr@denx.de>
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

On 1/25/22 08:18, Stefan Roese wrote:
> While working on AER support on a ZynqMP based system, which has some
> PCIe Device connected via a PCIe switch, problems with AER enabling in
> the Device Control registers of all PCIe devices but the Root Port. In
> fact, only the Root Port has AER enabled right now. This patch set now
> fixes this problem by first fixing the AER enabing in the
> interconnected PCIe switches between the Root Port and the PCIe
> devices and in a 2nd patch, also enabling AER in the PCIe Endpoints.
> 
> Please note that these changes are quite invasive, as with these
> patches applied, AER now will be enabled in the Device Control
> registers of all available PCIe Endpoints, which currently is not the
> case.
> 
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Pali Rohár <pali@kernel.org>
> Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Yao Hongbo <yaohongbo@linux.alibaba.com>
> Cc: Naveen Naidu <naveennaidu479@gmail.com>
> 
> Stefan Roese (3):
>    PCI/AER: Call pcie_set_ecrc_checking() for each PCIe device
>    PCI/portdrv: Don't disable AER reporting in
>      get_port_device_capability()
>    PCI/AER: Enable AER on all PCIe devices supporting it
> 
>   drivers/pci/pcie/aer.c          | 10 +++++++---
>   drivers/pci/pcie/portdrv_core.c |  9 +--------
>   2 files changed, 8 insertions(+), 11 deletions(-)
> 

Bjorn, what's the status of this patchset? I know this is sensible
stuff, to fully enable PCIe AER. How should be handle this? Do you
plan to pull this soon'ish? Please let me know if something is missing.

Thanks,
Stefan
