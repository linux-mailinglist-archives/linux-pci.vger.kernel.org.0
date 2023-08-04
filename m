Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CED676FBB9
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 10:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbjHDILV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 04:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbjHDILU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 04:11:20 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136204689
        for <linux-pci@vger.kernel.org>; Fri,  4 Aug 2023 01:11:19 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-686f25d045cso1374779b3a.0
        for <linux-pci@vger.kernel.org>; Fri, 04 Aug 2023 01:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1691136678; x=1691741478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1E1XKpqY2cyPNIrSdD2Uj7Nc4s99E7VJhmNzctJ9yC0=;
        b=c0O39fOZTU05YfaE+/NuL/0+WcEvgeF+SRbGWw691gy7cFmVocxF2etSH7t09iQ51u
         3UEbdkuaKyJUzhPPqN45Zqo0unNWsOT42D144N/2zpSlHvlalss+jzFtFLVtt9xhwsV0
         2jUbfUF2kfYTbw9RIEVXY4rz7V6sB+WFFCVxDzOw2KsBpsUwDTH79BMkjXsvsUVb3P5X
         LzpSCirLqW7Wk0TiB1u1kZIxH9nUi1kBoWjxGKHCdEfn5NeYClqikNfwpL6oioZmAswK
         XT2zIoJpYPoswZJ6ZZCRE7L/qGA2OZ0LAW0uXnY2oGgsZ5rGl9ZxxHpvIpkMo6GeQdj+
         gRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691136678; x=1691741478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1E1XKpqY2cyPNIrSdD2Uj7Nc4s99E7VJhmNzctJ9yC0=;
        b=Ex51NFQ8BCHTCQjP1qu+wLD57rj4hy7bHLmYkACM1Qa2IA52sTi+YkZ/0Amoh/imfP
         BCn7BwjuH4iYK08OHH/6AYrYGgjIbCe1ofRy7fo6uupgtD0ImZV9xzK0rqZQ0FSK7/gZ
         xYWcrVp0fSFDYg4LBN4Bj0n+FYn6ldfsAcgZOP+5kwG/z5C8V+QHbUG2e9lUeFCSlQM2
         pn17/mdmqn78nAi7GeC2uVxEmWhEcKsHO+j8QVJ5lZKbum7GVRdL0OyQ0ih5efcA2TAh
         aeLnZ37G4kbRQIy35GfTQnZLmlflO/lBGdRUOpLag3maFNirMB4nT5bHo/n6jFvbcw1t
         pOww==
X-Gm-Message-State: AOJu0YzZisn/HeYCLKOpBAk2ceRzm6rxlurilRgpmThmTbW76nqyowE2
        2NuQaOkRLlZX0FvHGyYEyfEGiQ==
X-Google-Smtp-Source: AGHT+IHnx2zb6m6wrA5NnPdzIk8blklkqhpKJsWmU8/Y9MzhjmQ6IK1Rw1+MeaiexbKDwa3wkDs7Mw==
X-Received: by 2002:a05:6a00:3984:b0:682:f529:6d69 with SMTP id fi4-20020a056a00398400b00682f5296d69mr1255507pfb.7.1691136677933;
        Fri, 04 Aug 2023 01:11:17 -0700 (PDT)
Received: from sunil-laptop ([106.51.190.143])
        by smtp.gmail.com with ESMTPSA id c21-20020a62e815000000b005d22639b577sm1032647pfi.165.2023.08.04.01.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:11:17 -0700 (PDT)
Date:   Fri, 4 Aug 2023 13:41:05 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anup Patel <anup@brainfault.org>,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robert Moore <robert.moore@intel.com>,
        Haibo Xu <haibo1.xu@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>
Subject: Re: [RFC PATCH v1 11/21] swnode: Add support to create early during
 boot
Message-ID: <ZMyymUdV63g4eGaT@sunil-laptop>
References: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
 <20230803175916.3174453-12-sunilvl@ventanamicro.com>
 <ZMyWDDD6Lw8REd1r@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMyWDDD6Lw8REd1r@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andy,

On Fri, Aug 04, 2023 at 09:09:16AM +0300, Andy Shevchenko wrote:
> On Thu, Aug 03, 2023 at 11:29:06PM +0530, Sunil V L wrote:
> > From: Anup Patel <apatel@ventanamicro.com>
> > 
> > swnode framework can be used to create fwnode for interrupt
> > controllers.
> 
> Why? What is this for?
> Can you elaborate? This commit message is poorly written...
> 
> And why firmware node is not enough for ACPI case?
> I assume the fwnode in DT case is already provided by OF.
> 
Thanks a lot for the review!.

You are right, OF provides the fwnode for irqchip drivers. However, for
ACPI case, it is typically created using irq_domain_alloc_named_fwnode
or irq_domain_alloc_fwnode since these are not ACPI devices in the
namespace but from MADT. The fwnode created using
irq_domain_alloc_fwnode() is a simple one which doesn't support properties
similar to the one created by OF framework or software node framework.
Hence, lot of data from the MADT structures need to be cached as
separate structures in the drivers and also would need several ifdefs to
check for ACPI and some amount of code duplication is also required due
to the way DT driver gets the information vs ACPI.

The beauty of software node framework is, it supports adding properties
and also is a supported fwnode type in __irq_domain_create(). So, if we
can create the fwnode for these irqchip using software node, we can
attach the same properties and the actual irqchip driver which uses the
fwnode doesn't need to have any ACPI vs DT checks. Same driver will work
seamlessly on both DT and ACPI platforms.  But the challenge is,
currently swnode expects to be created with sysfs which won't be
available during early boot when irqchip drivers need to be probed. So,
adding support to create without dependency on sysfs help us to reuse
the same framework for irqchip use case also.

Apologies for not descriptive in the commit message. Please let us know
your feedback on this approach.

> > This helps in keeping the drivers same for both
> > DT and ACPI. To enable this, enhance the swnode framework so
> > that it can be created early during boot without dependency
> > on sysfs.
> 
> ...
> 
> > -	swnode->kobj.kset = swnode_kset;
> > +	swnode->kobj.kset = (!early) ? swnode_kset : NULL;
> 
> Too many unneeded characters. Why parentheses? Why negative check?
> 
Sure, will update in next version.

> ...
> 
> > +	if (early) {
> > +		ret = 0;
> > +		kobject_init(&swnode->kobj, &software_node_type_early);
> > +		swnode->kobj.parent = parent ? &parent->kobj : NULL;
> > +		if (node->name)
> > +			ret = kobject_set_name(&swnode->kobj,
> > +					       "%s", node->name);
> > +		else
> > +			ret = kobject_set_name(&swnode->kobj,
> > +					       "node%d", swnode->id);
> > +		if (!ret) {
> > +			spin_lock(&swnode_early_lock);
> > +			list_add_tail(&swnode->early, &swnode_early_list);
> > +			spin_unlock(&swnode_early_lock);
> > +		}
> > +	} else {
> > +		if (node->name)
> > +			ret = kobject_init_and_add(&swnode->kobj, &software_node_type,
> > +						   parent ? &parent->kobj : NULL,
> 
> This looks like have a duplication.
> 
> > +						   "%s", node->name);
> > +		else
> > +			ret = kobject_init_and_add(&swnode->kobj, &software_node_type,
> > +						   parent ? &parent->kobj : NULL,
> > +						   "node%d", swnode->id);
> > +	}
> 
> Maybe it's possible to refactor this piece to be more compact?
> 
The issue is, kobject_init_and_add() expects sysfs. Let me try to
compact this in next version. Thanks!
> ...
> 
> > -	return PTR_ERR_OR_ZERO(swnode_register(node, parent, 0));
> > +	return PTR_ERR_OR_ZERO(swnode_register(node, parent, 0, 0));
> 
> In one case you use boolean, here is unsigned int for early flag, why is the
> inconsistency added?
> 
Yeah, it should be bool. Let me fix it in next version.

> ...
> 
> > -struct fwnode_handle *
> > -fwnode_create_software_node(const struct property_entry *properties,
> > -			    const struct fwnode_handle *parent)
> > +static struct fwnode_handle *
> > +fwnode_create_software_node_common(const struct property_entry *properties,
> > +				   const struct fwnode_handle *parent,
> > +				   bool early)
> 
> Why would you need this API in early stages?
> 
Hope I answered the question above. 

Thanks!
Sunil
