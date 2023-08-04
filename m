Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE8076FD5B
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 11:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjHDJdr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 05:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjHDJdo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 05:33:44 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4365C49CB
        for <linux-pci@vger.kernel.org>; Fri,  4 Aug 2023 02:33:41 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686f38692b3so1773367b3a.2
        for <linux-pci@vger.kernel.org>; Fri, 04 Aug 2023 02:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1691141621; x=1691746421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E6pJFE+LbN3t9KX562ET/U8O9x6jKkVFfcHxU4OoKLU=;
        b=GaIVrBlWNau1bDYf593GlJiU6Af7nAeBxxB4u4JryuWCHG8sEeuZrKeXi0Jkc5ydvg
         f5XIIJXgZ6tFqSs1y6JJluCYxHah8cYi2iM/peqn9wrByAlUjT+T5EwQdGIKOSObiBdh
         vXZrFjRXul+2bYCK0XU0x719gMWrepNiI/ld1MZjlcvoWzgIWyqD4vQWEGTYvdAlr4vl
         yOuYWt4cBHch29OVlaSlUWs+NHFRivXWHfPcmPSAIcRaXJrYop/kZMlqspmCLYJAq1TM
         RzOhjzIV+E8WdLg0Scjri0wwQ7hnaraeQULqXHImH4YHHGDqMS4OttacG9d3If/bcmxc
         an/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691141621; x=1691746421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6pJFE+LbN3t9KX562ET/U8O9x6jKkVFfcHxU4OoKLU=;
        b=jgXE8VmuRsKXDymSxV0WpkdXVtylDpP0qjbe4UZiNZ2FFPEO/7xh9IZKxn1SCUEpev
         2mjeCCmS4ASbqPe1a8A9rhSTG5EdsQwAXSknUTMl5zUjkQkXR60dOfP2Wj1lf5VwZnso
         pdqXiMQeUrjc3dEnuY8Fuf2i/Ep+zfWWxAbLurvzqnNAX2X2s/Bs3V5b77qujbgpKce4
         Dd1PrDveWiaQ4TshZjBO7BfD+Tk7MU6V5mbqROjFWc7TvU8Zj3jOWTaLYfv4fD4RSuSq
         HjMer8EATtvCqOiDgJe7+AaV7fc6m6S/uLaP0fILg0UFxkWo8Ngds6T7dpYFOBBoxo8R
         aYsw==
X-Gm-Message-State: AOJu0YzevkHBYKhTJjMDwFEHxBK1bHWdowk5AvaLy60jAZoylxBaFvFf
        Dd23ZgYhd3jgDLQ79+zpnm6vjQ==
X-Google-Smtp-Source: AGHT+IE9uAGKFQAVKKVyBKP+6lj+Wv4xxWX0reh7x6nnrpB1UJCiBCXbpcTB9CxHE+g7R/t5zY0Rzw==
X-Received: by 2002:a05:6a00:21d5:b0:687:7d09:c0f with SMTP id t21-20020a056a0021d500b006877d090c0fmr1517925pfj.12.1691141620733;
        Fri, 04 Aug 2023 02:33:40 -0700 (PDT)
Received: from sunil-laptop ([106.51.190.143])
        by smtp.gmail.com with ESMTPSA id v13-20020a62a50d000000b00686ee7ba3easm1180143pfm.216.2023.08.04.02.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 02:33:40 -0700 (PDT)
Date:   Fri, 4 Aug 2023 15:03:29 +0530
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
        Atish Kumar Patra <atishp@rivosinc.com>
Subject: Re: [RFC PATCH v1 08/21] RISC-V: ACPI: RHCT: Add function to get CBO
 block sizes
Message-ID: <ZMzF6e8jjGY2YNjm@sunil-laptop>
References: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
 <20230803175916.3174453-9-sunilvl@ventanamicro.com>
 <ZMyUDZE0SxoOC696@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMyUDZE0SxoOC696@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 04, 2023 at 09:00:45AM +0300, Andy Shevchenko wrote:
> On Thu, Aug 03, 2023 at 11:29:03PM +0530, Sunil V L wrote:
> > CBO related block size in ACPI is provided by RHCT. Add
> > support to read the CMO node in RHCT to get this information.
> 
> ...
> 
> > +	if (!table) {
> 
> Why not positive conditional?
> 
Sure.

> > +		rhct = (struct acpi_table_rhct *)acpi_get_rhct();
> > +		if (!rhct)
> > +			return -ENOENT;
> > +	} else {
> > +		rhct = (struct acpi_table_rhct *)table;
> > +	}
> 
> ...
> 
> > +	end = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct, rhct->header.length);
> 
> > +
> 
> Blank line here is not needed.
> 
Okay.

> > +	for (node = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct, rhct->node_offset);
> > +	     node < end;
> > +	     node = ACPI_ADD_PTR(struct acpi_rhct_node_header, node, node->length)) {
> 
> > +			for (int i = 0; i < hart_info->num_offsets; i++) {
> > +				ref_node = ACPI_ADD_PTR(struct acpi_rhct_node_header,
> > +							rhct, hart_info_node_offset[i]);
> > +				if (ref_node->type == ACPI_RHCT_NODE_TYPE_CMO) {
> > +					cmo_node = ACPI_ADD_PTR(struct acpi_rhct_cmo_node,
> > +								ref_node, size_hdr);
> > +					if (cbom_size)
> > +						*cbom_size = 1 << cmo_node->cbom_size;
> > +
> > +					if (cboz_size)
> > +						*cboz_size = 1 << cmo_node->cboz_size;
> > +
> > +					if (cbop_size)
> > +						*cbop_size = 1 << cmo_node->cbop_size;
> 
> BIT() in all three cases?
>
Sure.
 
> But how you guarantee it will not overflow? I mean who prevents cboX_size to be
> bigger than 30 (note also that 31 in your case is Undefined Behaviour in
> accordance with the C standard).
> 
Good catch!. Let me add a check that the value is not more than 30.

Thanks!
Sunil
