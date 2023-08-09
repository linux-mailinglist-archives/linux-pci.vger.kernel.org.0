Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E5C775258
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 07:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjHIFrO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 01:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjHIFrO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 01:47:14 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB2E1BF3
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 22:47:13 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bba04b9df3so56059825ad.0
        for <linux-pci@vger.kernel.org>; Tue, 08 Aug 2023 22:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1691560033; x=1692164833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YCeIptmtpKy5q98QjD4SUtd19PTpMTjSWPCM/pRkRaI=;
        b=haeX18sUQdxxqI7SQwmn8SHKct03Vake+IzrKwZQdTEOTgqFjhH0yzb6gVvecUp++M
         LMJV1cVhnL5cBk05TA0BuUeVgPeqBBT5xVYYg8Fmt6oC4KEFpsb20dfFQp1sUhdBnv+U
         Agka3B9ydKgYsr/ueR6T9DXKuK4mFb7fnEgx45MrDCaANoCelYzVXJwVJd52Zm6ffFeo
         vlwzfD2WG7skOwNLlyX+ou/s/8GC3sc0bR5XFkYBOl3Ac4CqFz3U8O83n9htUtpGlbxX
         5MHrYLjZAe/fPUGNNnFPHYXY6gLf92Ljy74BtQmvCjyQU740MtA8mhZgL163A/u/3c14
         57jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691560033; x=1692164833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCeIptmtpKy5q98QjD4SUtd19PTpMTjSWPCM/pRkRaI=;
        b=I/LANmbtOCJk1r26b4XshbyQFboL3+cGoT6+emddkjEBROpeF39ewtanhECeEgxeIZ
         sFDWprVx4TDlTdfpLRFaTowuOBUpK5VVAk7SKKSgkl1MisTeQmq2CqZuGhBsZ8oyR4ZG
         l7IYSuoytksPL3Adt+5dHi7ZnKLs8Av9VDGDzdABPWeQUx1Dls4VfcJdrA0myPmhs1CR
         Gs33TSWXydxFctUL14w4cH6uRtisxq+8hM8/ib8iLZxPW5OjIxPgC8MYD6CrKOWJpZ+4
         Ur8tW/WVJ+lZACYCx2yHJRYjf6DCcFL+JPsOfklcrwKZzsmf8Qi9c2jW59IaXeAEfnl5
         8QYg==
X-Gm-Message-State: AOJu0Yx7o5pkTpVibvYoc3Zhdx9vx2hs0PLOKcfKJDkv7xi0aBWbER9l
        nypx5P7O6r8rpRLEZ66nRRyTWw==
X-Google-Smtp-Source: AGHT+IFrTYPQ+5b8uQBjS2fcGKsPAzUjAy1/yAOVWR8AwSQ1NP6723J3EcH5VFWoXC6GPw4jT3aUkA==
X-Received: by 2002:a17:903:230d:b0:1bb:a85c:23cc with SMTP id d13-20020a170903230d00b001bba85c23ccmr2339537plh.15.1691560032814;
        Tue, 08 Aug 2023 22:47:12 -0700 (PDT)
Received: from sunil-laptop ([106.51.83.242])
        by smtp.gmail.com with ESMTPSA id r14-20020a170902be0e00b001bb381b8260sm10098918pls.100.2023.08.08.22.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 22:47:12 -0700 (PDT)
Date:   Wed, 9 Aug 2023 11:17:02 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Will Deacon <will@kernel.org>, Haibo Xu <haibo1.xu@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Scally <djrscally@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Anup Patel <anup@brainfault.org>, Len Brown <lenb@kernel.org>
Subject: Re: [RFC PATCH v1 20/21] RISC-V: ACPI: Create PLIC platform device
Message-ID: <ZNMoVgO7mEDV07OJ@sunil-laptop>
References: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
 <20230803175916.3174453-21-sunilvl@ventanamicro.com>
 <20230808-chalice-easing-1369c7386082@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808-chalice-easing-1369c7386082@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Conor,

On Tue, Aug 08, 2023 at 09:41:45AM +0100, Conor Dooley wrote:
> On Thu, Aug 03, 2023 at 11:29:15PM +0530, Sunil V L wrote:
> > Since PLIC needs to be a platform device
> 
> For the unwashed, why does the PLCI need to be a platform device?
> (And while you're at that, please try to make use of the extra ~20
> characters per line that you can use here.)
>
Sure, let me add more details and use extra characters.
 
> > probe the
> > MADT and create platform devices for each PLIC in the
> > system. Use software node framework for the fwnode
> > which allows to create properties and hence the
> > actual irqchip driver doesn't need to do anything
> > different for ACPI vs DT.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > Co-developed-by: Haibo Xu <haibo1.xu@intel.com>
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> 
> > +static struct fwnode_handle *acpi_plic_create_fwnode(struct acpi_madt_plic *plic)
> > +{
> > +	struct fwnode_handle *fwnode, *parent_fwnode;
> > +	struct riscv_irqchip_list *plic_element;
> > +	struct software_node_ref_args *refs;
> > +	struct property_entry props[8] = {};
> > +	int nr_contexts;
> > +
> > +	props[0] = PROPERTY_ENTRY_U32("riscv,gsi-base", plic->gsi_base);
> > +	props[1] = PROPERTY_ENTRY_U32("riscv,ndev", plic->num_irqs);
> > +	props[2] = PROPERTY_ENTRY_U32("riscv,max_prio", plic->max_prio);
> 
> My OCD wants to know why this gets an _ but the others have a -.
> 
It should be -. But with Marc's recommendation, this is no longer
required.

Thanks!
Sunil
