Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7584C941F
	for <lists+linux-pci@lfdr.de>; Tue,  1 Mar 2022 20:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbiCATUO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Mar 2022 14:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiCATUN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Mar 2022 14:20:13 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE94952E03;
        Tue,  1 Mar 2022 11:19:31 -0800 (PST)
Message-ID: <b3caabef-f91e-ff4d-dfe2-8aa0869fadb6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646162368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zCGZe5KQEePlGgxnSZ6o3CK5/eGHzgzDBb+VMLpgJ8A=;
        b=QWhO0xDAbsgrBwnQI4FQnEdckf5x1GaYM6J93ZRL3fYArcjMr3EiLYkNR4Dh8aVEyMlhkn
        TCcL1mqdgaD43FJhEwcbQ7AudScncsBJg/tnlabfBWlPW9mkyL1+sPK3kYHlOV+735pqMv
        pkua33/Pf/K0gM/8Uk9EeJ2om+3uRgo=
Date:   Tue, 1 Mar 2022 12:19:26 -0700
MIME-Version: 1.0
Subject: Re: [PATCH V6 0/3] PCI: vmd: Enable PCIe ASPM and LTR
Content-Language: en-US
To:     "David E. Box" <david.e.box@linux.intel.com>,
        nirmal.patel@linux.intel.com, lorenzo.pieralisi@arm.com,
        hch@infradead.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, michael.a.bottini@linux.intel.com,
        rafael@kernel.org, me@adhityamohan.in
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220301041943.2935892-1-david.e.box@linux.intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <20220301041943.2935892-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Set looks good to me
Thanks!

Reviewed-by: Jon Derrick <jonathan.derrick@linux.dev>

On 2/28/2022 9:19 PM, David E. Box wrote:
> This series adds support for enabling PCIe ASPM and for setting PCIe LTR
> values on devices on root ports reserved by VMD. Configuration of these
> capabilities is usually done by BIOS. But for VMD ports these capabilities
> will not be configured because those ports are not visible to BIOS. For
> future products, post Alder Lake, the hardware team has agreed to do this
> enabling in BIOS.  But this will not apply to current products, so this
> work around is provided for them. Without this, laptops running in VMD mode
> will not be able to power gate roots ports, resulting in higher power
> consumption.
> 
> Since V4 we have more information from the BIOS team as to why BIOS
> needs to program device LTRs. This is something that should be done by
> devices, but there are many that don't provide LTR values causing them
> to block SoC level power management. BIOS sets an initial default LTR to
> account for such devices. This SoC specific value is the maximum latency
> required to allow the SoC to enter the deepest power state.
> 
> David E. Box (2):
>    PCI: vmd: Add vmd_device_data
>    PCI: vmd: Configure PCIe ASPM and LTR
> 
> Michael Bottini (1):
>    PCI/ASPM: Add ASPM BIOS override function
> 
>   drivers/pci/controller/vmd.c | 134 ++++++++++++++++++++++++++++-------
>   drivers/pci/pcie/aspm.c      |  54 ++++++++++++++
>   include/linux/pci.h          |   7 ++
>   3 files changed, 169 insertions(+), 26 deletions(-)
> 
> 
> base-commit: 754e0b0e35608ed5206d6a67a791563c631cec07
