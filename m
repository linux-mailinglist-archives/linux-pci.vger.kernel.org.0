Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9521569789A
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 10:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbjBOJEr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Feb 2023 04:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjBOJEn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2023 04:04:43 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D40C29E33;
        Wed, 15 Feb 2023 01:04:37 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-16e55be7c76so795435fac.6;
        Wed, 15 Feb 2023 01:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uwa6xK/yGoAax/0OsXHRKw57tyZBvF5xhqokekA1410=;
        b=GDNghYFolCi/Hr9GJz4CtFq5HIGPlsnHond8PtR6gzV+AKOQI0c5ta1t8Ys+Vo1+1+
         LqR0SIWfHg+uDEfxg3zJoWLWm+ItSFe3B/rEqWrQZlX8B9RIJfiCtFlsbhgzY8FgqvEi
         alHGClndUJRnWimlqeV7L6aFizOTLqkXT5HyOUbMaVK7Vy//g4Mmwg5Q36vb4NCDj/co
         B07mudnoacRsfm9fjD1ljLv2fMgc/j3hXmfPcMJScf97NTnxM8z5LIiQoFWpSKwojuo0
         OCM9Zu/SqB1cpmsXSsKi9j4VQqxFPXnlpkqwRp99noQIh0KsEt4vaXVB2SobFL1Q8SNP
         cGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uwa6xK/yGoAax/0OsXHRKw57tyZBvF5xhqokekA1410=;
        b=blKySwFw6HkUnwsrrvpWWvy+6hUENJFSnvWStbdUZkGUpCDTmmDpmoDFTefQoBexfW
         ctC+MtiEkgsxA6OXchl0FfyFzflU3f7JLncOf+/fe9SzxUNFoLgsfEsZ57+bxiwVXZz0
         m/6CoyWOxf/QXXZW1uUORFo0paSR+8XWRejQyCfPVktIil6c8MZWbZn13Y4YyQNkfN/D
         A0koeeqTV6BOor4njU1sAKpXU9dlELEhxZe13dwk4EcpfOI7WMYFpR7qTNks114upkNS
         Bq7eyJdTODOT6ehbYkrgvjV34p9J7hy20NIqwHsOq0ByIUbc0mDProaxDdtRl8WUCW+3
         bozg==
X-Gm-Message-State: AO0yUKVRhdfqaWf6y9yBwFNgld+TxJRlLKgITtigmPtkXfO6fbfZFZLO
        0Ifi0i8/i+sEuaaS3ysIUpgA+Mm+juw/vI5wMpY=
X-Google-Smtp-Source: AK7set8M3FNYNbgcQtYa5GBece8pIU/sBsIHK/rNnMAtR/NLp0PkALLbNqbe2utTTajf92iToM7B0At0xEH85Sc6K/0=
X-Received: by 2002:a05:6870:10d7:b0:163:9dc0:78f1 with SMTP id
 23-20020a05687010d700b001639dc078f1mr206361oar.265.1676451876492; Wed, 15 Feb
 2023 01:04:36 -0800 (PST)
MIME-Version: 1.0
References: <20230214140858.1133292-1-rick.wertenbroek@gmail.com>
 <20230214140858.1133292-2-rick.wertenbroek@gmail.com> <2ebd33e2-46ef-356d-ff4c-81b74950d02f@opensource.wdc.com>
In-Reply-To: <2ebd33e2-46ef-356d-ff4c-81b74950d02f@opensource.wdc.com>
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date:   Wed, 15 Feb 2023 10:04:00 +0100
Message-ID: <CAAEEuhr273bKFBWiTVyTjhHhxjuTK=TVd+5K2B07WfWMD+N7mA@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] PCI: rockchip: Remove writes to unused registers
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     alberto.dassatti@heig-vd.ch, xxm@rock-chips.com,
        rick.wertenbroek@heig-vd.ch, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 15, 2023 at 12:56 AM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> I checked the TRM and indeed these registers are listed as unused.
> However, with this patch, nothing work for me using a Pine rockpro64
> board. Keeping this patch, your series (modulo some other fixes, more
> emails coming) is making things work !

Hello, Thank you for testing the driver and commenting, I'll incorporate your
suggestions in the next version of this series.

This patch alone does not make the driver work. Without the fixes to the
address windows and translation found in [PATCH v2 6/9] ("PCI: rockchip:
Fix window mapping and address translation for endpoint") transfers will not
work. However, as you said, with the patch series, the driver works.
Good to see that you have the driver working on the rockpro64 which is a
very similar but different board than the one I used (FriendlyElec NanoPC-T4).

> So I think the bug is with the TRM, not the code. THinking logically about
> htis, it makes sense: this is programming the address translation unit to
> translate mmio & dma between host PCI address and local CPU space address.
> If we never set the PU address, how can that unit possibly ever translate
> anything ?

No, the bug is not in the TRM:
The RK3399 PCIe endpoint core has the physical address space of 64MB
@ 0xF800'0000 to access the PCIe address space (TRM 17.5.4).
This space is split into 33 windows, one of 32MBytes and 32 of 1MByte.
Read-write accesses by the CPU to that region will be translated. Each
window has a mapping that is configured through the ATR Configuration
Register Address Map (TRM 17.6.8) and the registers addr0 and addr1
will dictate the translation between the window (a physical CPU addr)
into a PCI space address (with this the unit can translate). The other
registers are for the PCIe header descriptor.
The translation process is documented in TRM 17.5.5.1.1
The core will translate all read-write accesses to the windows that fall
in the 64MB space @ 0xF800'0000 and generate the PCIe addresses
and headers according to the values in the registers in the ATR
Configuration Register Address Map (@ 0xFDC0'0000).

Translation does indeed take place and works
but requires the changes in [PATCH v2 6/9] ("PCI: rockchip:
Fix window mapping and address translation for endpoint")
because it was broken from the start...

The two writes that were removed are to unused (read-only) registers.
The writes don't do anything, manually writing and reading back these
addresses will always lead to 0 (they are read-only). So they are removed.
