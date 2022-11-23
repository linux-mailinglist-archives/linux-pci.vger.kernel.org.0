Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D166635A65
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 11:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236342AbiKWKnN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 05:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237953AbiKWKmY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 05:42:24 -0500
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F3D769FC;
        Wed, 23 Nov 2022 02:27:25 -0800 (PST)
Received: by mail-pj1-f53.google.com with SMTP id o5-20020a17090a678500b00218cd5a21c9so1425739pjj.4;
        Wed, 23 Nov 2022 02:27:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pwpkG9G3xkjOyzikzQ4T/gV3SMpUqELfzhIlK43yLpY=;
        b=jQXLGvDVVqf0LTqxfMq535ZmBr0TkT6RB8p0K8w8T4X78ujUSLrRE1BiKXSaqWNkmw
         cAkayP69927XFP5BW+z1irjuWY5mWxL4XQ507eTgf2AzwJhLDBEP2gNyowTAh+MWX5YJ
         DvlEpF45NCRkz+8Gm7+Cz4tyS2l9/XAiVpA7UMj0ODEclCcxmeXJwkN1+Z/oqKyAeSbw
         3+W9WGzmfnnF16NWn5dQpa3a8WYifXYRCN4bydwZ326GLbvuH8Zdo11ZhikVrjDkZ9vA
         UHat2k1hFjfe0oXg7Vvg1dokDaesqRyGFwEHZSuiPBVZN3X5ZtEvPC9ueBWj3baE/vNn
         vDVg==
X-Gm-Message-State: ANoB5pmNpoOo2LNpR3OgzqqEeSYg/jELrMBlhcX2HhIdcA9xj7wx9aA2
        v2LitFYUz66ji4yIFNDP7sk=
X-Google-Smtp-Source: AA0mqf79gqmDL9stZaRGjrZHLamllSmaeTB+6NNa9TcOtJrVW/NC2LzyXTItQ7A2l8c6qcAq/OLfbA==
X-Received: by 2002:a17:90b:484:b0:218:9d3d:71f4 with SMTP id bh4-20020a17090b048400b002189d3d71f4mr19624100pjb.148.1669199244920;
        Wed, 23 Nov 2022 02:27:24 -0800 (PST)
Received: from [192.168.0.247] (61-227-110-150.dynamic-ip.hinet.net. [61.227.110.150])
        by smtp.gmail.com with ESMTPSA id i8-20020a170902c94800b00172fad607b3sm13969212pla.207.2022.11.23.02.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 02:27:24 -0800 (PST)
Message-ID: <5c766840-e092-45ea-0664-7bbdb78b933a@canonical.com>
Date:   Wed, 23 Nov 2022 18:27:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V8 0/4] PCI: vmd: Enable PCIe ASPM and LTR on select
 hardware
Content-Language: en-US
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     michael.a.bottini@intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, me@adhityamohan.in,
        rafael@kernel.org, hch@infradead.org, robh@kernel.org,
        bhelgaas@google.com, kw@linux.com, lorenzo.pieralisi@arm.com,
        nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev
References: <20221103021822.308586-1-david.e.box@linux.intel.com>
From:   You-Sheng Yang <vicamo.yang@canonical.com>
In-Reply-To: <20221103021822.308586-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi David,

On 11/3/22 10:18, David E. Box wrote:
> This series adds a work around for enabling PCIe ASPM and for setting PCIe
> LTR values on VMD reserved root ports on select platforms. While
> configuration of these capabilities is usually done by BIOS, on these
> platforms these capabilities will not be configured because the ports are
> not visible to BIOS. This was part of an initial design that expected the
> driver to completely handle the ports, including power management. However
> on Linux those ports are still managed by the PCIe core, which has the
> expectation that they adhere to device standards including BIOS
> configuration, leading to this problem.
>
> The target platforms are Tiger Lake, Alder Lake, and Raptor Lake though the
> latter has already implemented support for configuring the LTR values.
> Meteor Lake is expected add BIOS ASPM support, eliminating the future need
> for this work around.


It appears to me that this patch series works only on Tiger Lake. We 
have tried to revert our current work-arounds in Ubuntu kernels 
generic-5.15/oem-5.17/oem-6.0/unstable-6.1 and apply this series, the 
prebuilt kernels can be found in:

   https://launchpad.net/~vicamo/+archive/ubuntu/ppa-1996620

However, only TGL can still enter PC10 as before.


ADL-M, RPL platforms will stay in PC3 with vmd LTR set, but ASPM 
disabled. i915 RC6 blocked, too:

$ sudo cat /sys/kernel/debug/dri/

0/i915_dmc_info
...
DC3CO count: 0
DC3 -> DC5 count: 100
DC5 -> DC6 count: 0


> Note, the driver programs the LTRs because BIOS would also normally do this
> for devices that do not set them by default. Without this, SoC power
> management would be blocked on those platform. This SoC specific value is
> the maximum latency required to allow the SoC to enter the deepest power
> state.
>
> This patch addresses the following open bugzillas on VMD enabled laptops
> that cannot enter low power states.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=212355
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215063
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=213717
>
> David E. Box (3):
>    PCI: vmd: Use PCI_VDEVICE in device list
>    PCI: vmd: Create feature grouping for client products
>    PCI: vmd: Add quirk to configure PCIe ASPM and LTR
>
> Michael Bottini (1):
>    PCI/ASPM: Add pci_enable_link_state()
>
>   drivers/pci/controller/vmd.c | 96 ++++++++++++++++++++++++++----------
>   drivers/pci/pcie/aspm.c      | 54 ++++++++++++++++++++
>   include/linux/pci.h          |  7 +++
>   3 files changed, 131 insertions(+), 26 deletions(-)
>
>
> base-commit: 247f34f7b80357943234f93f247a1ae6b6c3a740


Regards,
You-Sheng Yang

