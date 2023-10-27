Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7439D7D969E
	for <lists+linux-pci@lfdr.de>; Fri, 27 Oct 2023 13:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345761AbjJ0L3f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Oct 2023 07:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345649AbjJ0L3e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2023 07:29:34 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3129C
        for <linux-pci@vger.kernel.org>; Fri, 27 Oct 2023 04:29:32 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-280137f1a1bso247884a91.1
        for <linux-pci@vger.kernel.org>; Fri, 27 Oct 2023 04:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698406172; x=1699010972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vI28YtitrNIniIpGPiCXYWH3fIICBsHFcX18SbMwXaI=;
        b=FkLUCTFaZcySOAam9iz6DHlyvMFgwb0dciaQzfdEKzSevC6tu7bXghqDN03SvNdfXI
         TpVwftwoRNylOP52CRKkfEd+HY6JOQtmKcnBIu1bAyG/Ld23VYJTHCS830eXVN/+1WBM
         kaAWuFHIbGb+5FObTqY8EYp0t1xctpoP6eFlbLuTew1V6TZOKIBp1igLyRcrviXNXMzZ
         sLDZszDFDI7J368kdHkZ+dvHbQnlRjH9r8pmTeCi5gny46waklCU9d/weTWNNrqjP2wr
         EkuRxqDu1n98QeIm87t0zIce4WfpuNi1WOKztgx7E1VzD51Vg5wY81r+AEulrqMDvYHq
         c9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698406172; x=1699010972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vI28YtitrNIniIpGPiCXYWH3fIICBsHFcX18SbMwXaI=;
        b=bX3mV29239DG3b5qC6x/1FOVGUXlqPHk2TA2jXBjn0b1cxYM9xECBQt5pdkUkijqy/
         GeVXeCQLZN8rm+tmxqK0lIRiEq/2OfEwUV4FNMurSg0NucEoZW8jP3qlgiTZBCIOtU7T
         e1D8la9ErD5UcourUhMn6kRKRfNeMxjcROJ0v6pHH27IDNLdhHMd991WmTxY4VhQW78p
         hqYyzdL4Rvo9dK9PUoZovHpB9yBiF0yM6Cz1qwYmKQWPmJD67RiKGGtaZhfeNykqOo74
         fpWF4ge8H9L0sRJVnocYRtL423FD40UgtBdU9RWvWvytX6zfAKYedpOuAKaj1acf9Elm
         f2rQ==
X-Gm-Message-State: AOJu0Yybssutcwv9GAq6MPNkRmULD07wHQtX2rpKYkTDKQkeHLPgEfO/
        FWKHDy9AQHnEvEHwmRnwHpXzUlPORAPnX8YcVB4gsA==
X-Google-Smtp-Source: AGHT+IG13tL5qlADUCcZnk0Slm9dLAj/0ICfwInuvtA89OSHyk/VCX3hGHfCAQFvPk1ScgHB/OgdWA==
X-Received: by 2002:a17:90b:100b:b0:27d:1051:83c4 with SMTP id gm11-20020a17090b100b00b0027d105183c4mr2196967pjb.12.1698406171798;
        Fri, 27 Oct 2023 04:29:31 -0700 (PDT)
Received: from sunil-laptop ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id r65-20020a17090a43c700b0028018af8dc2sm252642pjg.23.2023.10.27.04.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 04:29:31 -0700 (PDT)
Date:   Fri, 27 Oct 2023 16:59:19 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Anup Patel <anup@brainfault.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Haibo Xu <haibo1.xu@intel.com>
Subject: Re: [RFC PATCH v2 13/21] irqchip: riscv-intc: Add ACPI support for
 AIA
Message-ID: <ZTufD/InY/gwpE+Q@sunil-laptop>
References: <20231025202344.581132-14-sunilvl@ventanamicro.com>
 <20231026165150.GA1825130@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026165150.GA1825130@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Thu, Oct 26, 2023 at 11:51:50AM -0500, Bjorn Helgaas wrote:
> On Thu, Oct 26, 2023 at 01:53:36AM +0530, Sunil V L wrote:
> > The RINTC subtype structure in MADT also has information about other
> > interrupt controllers like MMIO. So, save those information and provide
> > interfaces to retrieve them when required by corresponding drivers.
> 
> > @@ -218,7 +306,19 @@ static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
> 
> > +	 * MSI controller (IMSIC) in RISC-V is optional. So, unless
> > +	 * IMSIC is discovered, set system wide MSI support as
> > +	 * unsupported. Once IMSIC is probed, MSI support will be set.
> > +	 */
> > +	pci_no_msi();
> 
> It doesn't seem like we should have to tell the PCI core about
> functionality we *don't* have.
> 
> I would think IMSIC would be detected before enumerating PCI devices
> that might use it, and if we *haven't* found an IMSIC by the time we
> get to pci_register_host_bridge(), would/should we set
> PCI_BUS_FLAGS_NO_MSI there?
>
The check in pci_register_host_bridge() is like below.

if (bridge->msi_domain && !dev_get_msi_domain(&bus->dev) &&
            !pci_host_of_has_msi_map(parent))
                bus->bus_flags |= PCI_BUS_FLAGS_NO_MSI;

When there is no IMSIC, bridge->msi_domain is 0 and hence
PCI_BUS_FLAGS_NO_MSI will never be set. Do you recommend to set
PCI_BUS_FLAGS_NO_MSI if bridge->msi_domain is 0? Let me know if I am
missing something.

Thanks,
Sunil
