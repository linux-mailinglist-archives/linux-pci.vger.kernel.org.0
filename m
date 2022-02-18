Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729C34BC270
	for <lists+linux-pci@lfdr.de>; Fri, 18 Feb 2022 23:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiBRWGG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Feb 2022 17:06:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbiBRWGF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Feb 2022 17:06:05 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5781712BE
        for <linux-pci@vger.kernel.org>; Fri, 18 Feb 2022 14:05:46 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id l9so8232988plg.0
        for <linux-pci@vger.kernel.org>; Fri, 18 Feb 2022 14:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vvUsBk8WOyHWPnfmlJUYHHjEnYQBDUZG873sZWj142g=;
        b=K4s9vs2YZWhm+MEIFx3oIqxhn2FvZQ6dkjYcFCVQa0VrvblHEWi+u/adBMkp683Wf5
         mULhbASkbQbVwiOBSavb35xHh+4vNOxePt1U9y6NKDKDKQs8GaNdw4m2qKSF4nCQuouC
         rhd7+wky5+6uxalrFoJ4YHiUX/5CAQRnpRfv1BVDms0xfRVz4dpQBY+ed+4Q54jdG98g
         RLZ6x/dtrOtLcwbqk0wJG4ElefoLKPKlbdGpq73HJNfXsdValYIijqBIfJC/14hIGmiv
         c1zhMRkE4PMR6pPwvZEc2Q/SPJNc0ylpoK5IGFXubPDncT9pKX3+5PDev2DtwQ7xGp0B
         nt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vvUsBk8WOyHWPnfmlJUYHHjEnYQBDUZG873sZWj142g=;
        b=eJshPWZEAqx2fYxE8PZTzgX2NJ8849AtiLU6h9Nm9MLDhTp75C7c7u04ndUJUDXRnF
         pqd3zReMKBoX8TTVUzHN11Z2zRdzP99yJHgJ3KDwLz3yq9Bpshqw8bVc2zz/TAvWIqy0
         Ads1XSBmHEx7Qb68PvQCN0PfAjQDxL7uTwCP2LG6hc4Lif7oZWP5iD6Wqma5piarRIYE
         7wPqB/ogy5UBmMudVr9iL69zoUg8JAW3d48yxk32s+lLfH6p1fITIbTNHXxULjqjloLd
         LPom03Kq/3rLqWijZJ3uBH7SmDIhWk5qKz/3ImL06XJLuGBVAD2+7oecoRVYeVDKNWl5
         9ykQ==
X-Gm-Message-State: AOAM533wZiy0JizILWMSLwo40slGN/gxaTqbe9wic1KTfgXmA0iadXec
        ocsH4BdRTu55rK0my0Oy42lby5d0FGETK6TzwTsefQ==
X-Google-Smtp-Source: ABdhPJyXDciKyO7mjGd2xYKr0AiM1W/M7sz3B7BSgqp5Vv+OSUq8q6jdOz+Q9YgFsMHh7MHyP4i9xutC6svUK1/BZEk=
X-Received: by 2002:a17:902:7296:b0:14b:4bc6:e81 with SMTP id
 d22-20020a170902729600b0014b4bc60e81mr9291198pll.132.1645221945889; Fri, 18
 Feb 2022 14:05:45 -0800 (PST)
MIME-Version: 1.0
References: <20210804161839.3492053-1-Jonathan.Cameron@huawei.com> <20210804161839.3492053-3-Jonathan.Cameron@huawei.com>
In-Reply-To: <20210804161839.3492053-3-Jonathan.Cameron@huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 18 Feb 2022 14:05:35 -0800
Message-ID: <CAPcyv4iiZMd6GmyRG+SMcYF_5JEqj8zrti_gjffTvOE27srbUw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] spdm: Introduce a library for DMTF SPDM
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Linuxarm <linuxarm@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        David E Box <david.e.box@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 4, 2021 at 9:23 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> The Security Protocol and Data Model (SPDM) defines messages,
> data objects and sequences for performing message exchanges between
> devices over various transports and physical media.
>
> As the kernel supports several possible transports (mctp, PCI DOE)
> introduce a library than can in turn be used with all those transports.
>
> There are a large number of open questions around how we do this that
> need to be resolved. These include:
> *  Key chain management
>    - Current approach is to use a keychain provide as part of per transport
>      initialization for the root certificates which are assumed to be
>      loaded into that keychain, perhaps in an initrd script.
>    - Each SPDM instance then has its own keychain to manage its
>      certificates. It may make sense to drop this, but that looks like it
>      will make a lot of the standard infrastructure harder to use.
>  *  ECC algorithms needing ASN1 encoded signatures.  I'm struggling to find
>     any specification that actual 'requires' that choice vs raw data, so my
>     guess is that this is a question of existing usecases (x509 certs seem
>     to use this form, but CHALLENGE_AUTH SPDM seems to use raw data).
>     I'm not sure whether we are better off just encoding the signature in
>     ASN1 as currently done in this series, or if it is worth a tweaking
>     things in the crypto layers.
>  *  Lots of options in actual implementation to look at.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  lib/Kconfig  |    3 +
>  lib/Makefile |    2 +
>  lib/spdm.c   | 1196 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1201 insertions(+)
>
> diff --git a/lib/Kconfig b/lib/Kconfig
> index ac3b30697b2b..0aa2fef6a592 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -704,3 +704,6 @@ config PLDMFW
>
>  config ASN1_ENCODER
>         tristate
> +
> +config SPDM
> +       tristate
> diff --git a/lib/Makefile b/lib/Makefile
> index 2cc359ec1fdd..566166d6936e 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -282,6 +282,8 @@ obj-$(CONFIG_PERCPU_TEST) += percpu_test.o
>  obj-$(CONFIG_ASN1) += asn1_decoder.o
>  obj-$(CONFIG_ASN1_ENCODER) += asn1_encoder.o
>
> +obj-$(CONFIG_SPDM) += spdm.o
> +
>  obj-$(CONFIG_FONT_SUPPORT) += fonts/
>
>  hostprogs      := gen_crc32table
> diff --git a/lib/spdm.c b/lib/spdm.c
> new file mode 100644
> index 000000000000..3ce2341647f8
> --- /dev/null
> +++ b/lib/spdm.c
> @@ -0,0 +1,1196 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DMTF Security Protocol and Data Model
> + *
> + * Copyright (C) 2021 Huawei
> + *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
> + */
> +
> +#include <linux/asn1_encoder.h>
> +#include <linux/asn1_ber_bytecode.h>
> +#include <linux/bitfield.h>
> +#include <linux/cred.h>
> +#include <linux/dev_printk.h>
> +#include <linux/digsig.h>
> +#include <linux/idr.h>
> +#include <linux/key.h>
> +#include <linux/module.h>
> +#include <linux/random.h>
> +#include <linux/spdm.h>
> +
> +#include <crypto/akcipher.h>
> +#include <crypto/hash.h>
> +#include <crypto/public_key.h>
> +#include <keys/asymmetric-type.h>
> +#include <keys/user-type.h>
> +#include <asm/unaligned.h>
> +
> +/*
> + * Todo
> + * - Secure channel setup.
> + * - Multiple slot support.
> + * - Measurement support (over secure channel or within CHALLENGE_AUTH.
> + * - Support more core algorithms (not CMA does not require them, but may use
> + *   them if present.
> + * - Extended algorithm, support.
> + */
> +/*
> + * Discussions points
> + * 1. Worth adding an SPDM layer around a transport layer?

I came here to say yes to this question. I am seeing interest in SPDM
outside of a DOE transport.

Hope to find my way back to testing these bits out soon...
