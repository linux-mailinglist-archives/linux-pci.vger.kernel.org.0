Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36EA7D810D
	for <lists+linux-pci@lfdr.de>; Thu, 26 Oct 2023 12:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjJZKrj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Oct 2023 06:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjJZKrj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Oct 2023 06:47:39 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757F5195
        for <linux-pci@vger.kernel.org>; Thu, 26 Oct 2023 03:47:35 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c50ec238aeso10418031fa.0
        for <linux-pci@vger.kernel.org>; Thu, 26 Oct 2023 03:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698317253; x=1698922053; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zARtYhe8iofTNi9oUIWhel0XKe8pA8fsGQ6TZX749AM=;
        b=h/kI//wpeIXTKh9Yxbd7z7B3SptYh7FLI7bpeO2DBb+ZRX50IXHgU1nuo7PyozAFma
         NeRc5NWVI6rJBzLdH3zERIxeaJ0m8jZzX5uILNDaENwXx3DyBL+9ZDzhcPQUO2CVU/JM
         l2gPXcYizmz7qS7y/kgmVqV/E4tj73kvsieo30eOHvWkKG4h11w1zQgztfEQWH61qmHi
         eD3/mAulkztQx1ZsgrZKmjqCERq1X1ZCeMVf5KHuEI4EFDy+Pu00qSLAsmbmXPHi89sz
         q9nSIDSSX2hfIVOAVYQbVynoRjvpqhcGj1iw4SYZddGBy0XcsDOIFYSUeG7oIBboVjOY
         DPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698317253; x=1698922053;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zARtYhe8iofTNi9oUIWhel0XKe8pA8fsGQ6TZX749AM=;
        b=jcjUU+U3LIgAmMJNYcpMfCdB65FD3Maor9k93mucpHNi0X9k9AwkZklBxz35Is3BnE
         p3jh6lonGAtaG5bwpGlpnaSIEx9YWyyQvPTrDVDSqYxBVmZkkCerAofRZkeFAr8C3TL6
         sqAx+tfK0mfR55OaMnjT/tfmVIAObFkIskXFoP9+l/GZKiU2zr36jX5LfHbHFNhPkhKh
         6ze6soiX+yBrHfTrDP2ZZ5KLGZCYZmZ6Z2pmbpGNIokOaKLlxw4YKI3N2PjVYtya6yWm
         fBzv3oSOWnzLlhk/2NfDqIm6DXo0Zt6iZ3MD17J1dMa3OfAjVHlC2ZrATH5MfiUxRbAj
         ue8Q==
X-Gm-Message-State: AOJu0YwOuFUeVyKaRqGilaa+2ApSegJYuiWSP8Xw9lKuuKERodD2rkeQ
        smp5PZD/ecFf1W4zBgi0FAaSQg==
X-Google-Smtp-Source: AGHT+IGmxzfDQpaW9n6+VyxCuLkhAmG3EoFq/lPNhAkHV71yn+1V0RyR8hD7hkbdqONXHHeDunN5Vg==
X-Received: by 2002:a05:651c:1038:b0:2c5:1bd9:f95c with SMTP id w24-20020a05651c103800b002c51bd9f95cmr11798854ljm.53.1698317253615;
        Thu, 26 Oct 2023 03:47:33 -0700 (PDT)
Received: from mutt (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id t13-20020a2e8e6d000000b002c4faf47378sm2822174ljk.28.2023.10.26.03.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 03:47:33 -0700 (PDT)
Date:   Thu, 26 Oct 2023 12:47:31 +0200
From:   Anders Roxell <anders.roxell@linaro.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     D Scott Phillips <scott@os.amperecomputing.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
        Darren Hart <darren@os.amperecomputing.com>,
        patches@amperecomputing.com, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: hotplug: Add extension driver for Ampere
 Altra hotplug LED control
Message-ID: <20231026104731.GA1296512@mutt>
References: <86ttqe4n1h.fsf@scott-ph-mail.amperecomputing.com>
 <20231025180627.GA1756475@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231025180627.GA1756475@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023-10-25 13:06, Bjorn Helgaas wrote:
> On Wed, Oct 25, 2023 at 10:41:46AM -0700, D Scott Phillips wrote:
> > Bjorn Helgaas <helgaas@kernel.org> writes:
> > 
> > > On Fri, Sep 29, 2023 at 05:20:36PM -0700, D Scott Phillips wrote:
> > >> On Ampere Altra, PCIe hotplug is handled through ACPI. A side interface is
> > >> also present to request system firmware control of attention LEDs. Add an
> > >> ACPI PCI Hotplug companion driver to support attention LED control.
> > >> ...
> > >
> > >> +	arm_smccc_smc(REQUEST, LED_CMD, led_status(status), LED_ATTENTION,
> > >> +		      pci_domain_nr(bus) | (PCI_SLOT(root_port->devfn) << 4), 0, 0,
> > >
> > > pci_domain_nr() returns "int" (normally 32 bits), but since this is an
> > > ACPI system, the domain comes from _SEG, which is defined to be 16
> > > bits (ACPI r6.5, sec 6.5.6).
> > >
> > > So it looks like ORing in the "slot << 4" clobbers the upper 12 bits
> > > of _SEG.
> > >
> > > Is this code doing the right thing?
> > 
> > Hi Bjorn,
> > 
> > on these Altra platforms _SEG is limited within 0-11. I can add an `&
> > 0xf` to pci_domain_nr() to make it clear that the segment number is
> > encoded down into 4 bits in the smc request.
> 
> If the following looks OK, we're all set.  I put these on pci/hotplug
> for v6.7, thanks!
> 
> +static int set_attention_status(struct hotplug_slot *slot, u8 status)
> +{
> +	struct arm_smccc_res res;
> +	struct pci_bus *bus;
> +	struct pci_dev *root_port;
> +	unsigned long flags;
> +	u32 handle;
> +	int ret = 0;
> +
> +	bus = slot->pci_slot->bus;
> +	root_port = pcie_find_root_port(bus->self);
> +	if (!root_port)
> +		return -ENODEV;
> +
> +	local_irq_save(flags);
> +	arm_smccc_smc(HANDLE_OPEN, led_service_id[0], led_service_id[1],
> +		      led_service_id[2], led_service_id[3], 0, 0, 0, &res);
> +	if (res.a0) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +	handle = res.a1 & 0xffff0000;
> +
> +	arm_smccc_smc(REQUEST, LED_CMD, led_status(status), LED_ATTENTION,
> +		     PCI_SLOT(root_port->devfn) << 4 | pci_domain_nr(bus) & 0xf,
> +		     0, 0, handle, &res);
> +	if (res.a0)
> +		ret = -ENODEV;
> +
> +	arm_smccc_smc(HANDLE_CLOSE, handle, 0, 0, 0, 0, 0, 0, &res);
> +
> + out:
> +	local_irq_restore(flags);
> +	return ret;
> +}

Hi,

Building todays linux-next tag next-20231026 for arm64 with
CONFIG_HOTPLUG_PCI_ACPI_AMPERE_ALTRA=m I see the following build error.

drivers/pci/hotplug/acpiphp_ampere_altra.c: In function 'set_attention_status':
drivers/pci/hotplug/acpiphp_ampere_altra.c:63:75: error: suggest parentheses around arithmetic in operand of '|' [-Werror=parentheses]
   63 |                      PCI_SLOT(root_port->devfn) << 4 | pci_domain_nr(bus) & 0xf,
      |                                                        ~~~~~~~~~~~~~~~~~~~^~~~~
include/linux/arm-smccc.h:382:44: note: in definition of macro 'arm_smccc_smc'
  382 | #define arm_smccc_smc(...) __arm_smccc_smc(__VA_ARGS__, NULL)
      |                                            ^~~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [scripts/Makefile.build:243: drivers/pci/hotplug/acpiphp_ampere_altra.o] Error 1

Looks like this is the problematic patch
13ba8a09c4f6 ("PCI: hotplug: Add Ampere Altra Attention Indicator extension driver")

Cheers,
Anders
