Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 977BE33A41
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2019 23:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfFCVvm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jun 2019 17:51:42 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36554 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFCVvl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jun 2019 17:51:41 -0400
Received: by mail-ed1-f68.google.com with SMTP id a8so28925180edx.3;
        Mon, 03 Jun 2019 14:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=spxbSxrpztoX+OYGfxSQU5fac10irlk+vBajDvb33D0=;
        b=iADSXB000vxOYJWwJoRtrAYRSo/dfLvDu8/qH49kJalqjkE/hRmqwTCq4kjqxxqPyz
         mt7rwocjIZSBlcJTIetx5SRB82REH/WVNBhcl/al+3Jnif0mJk2tmzdtMRWUZ/A9kT+f
         +vZRpM+tuHCzspT7CZxurPYPB5NkolL3JSOI2GggioMDa08zdzPluWWVaVkHqoXiCkaF
         QXAllhgAKLE4rh2W5lCa5VoyCUhA+VrsRxjDVyYQz3WfPeUL4nfKX1Op/PRfZenluLnr
         CDCQdYjIMW3k8Zlz8Dump4vaQY8BmqE5+lU9xzFcikpVlzg1kzyo3c4a1Az/Y6tPhB4d
         Zt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=spxbSxrpztoX+OYGfxSQU5fac10irlk+vBajDvb33D0=;
        b=bmMdPMoIggss6hKIf/XCxx8jnOB8Mg7LfFjIqJSBRK0kdLZ06RgRrSnzVWW/d6kPBi
         moSZB/5UKGjFPAxAVUJwfA2R1m50qZGCXtz5hnDeewjwNCg8cvxcHILHvypno8YH+9o+
         a1NwuL29iYB//b0uuunqu7xgOKyPks+UJcaroRcJzOttvEipAnzNOiVVNpFXfhl5E/3s
         Tsz0A46eaqkv8TMt66ebWhwd5+IXEZFqRsgbAQTpY+OX175ix55+gzdrUgiWmiL+Tn6L
         quAesuncAaaOoOru+5uFrG9GrIGXpuPqw0R/JQ60Y356CmoWAdLiry2OAxUZlNK8DXZ0
         llng==
X-Gm-Message-State: APjAAAVihVnRlXixCG/4EUqZS2P+mSezb7hHQ9c+e2DxUvkIR+511taQ
        cuHz4dd+d6vhN1SGBnYBNEc=
X-Google-Smtp-Source: APXvYqysmW+FQopVoJyDuQ/uqrAMHI1xHaH7Iwn4k4JCGIFFIXvqOIx6KZ7m/OoH/36YsKRUpIfwDQ==
X-Received: by 2002:a17:906:25c9:: with SMTP id n9mr4769934ejb.51.1559598700059;
        Mon, 03 Jun 2019 14:51:40 -0700 (PDT)
Received: from archlinux-epyc ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id p13sm4239321edm.97.2019.06.03.14.51.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 03 Jun 2019 14:51:38 -0700 (PDT)
Date:   Mon, 3 Jun 2019 14:51:36 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] PCI: rpaphp: Avoid a sometimes-uninitialized warning
Message-ID: <20190603215136.GA45181@archlinux-epyc>
References: <20190603174323.48251-1-natechancellor@gmail.com>
 <CAKwvOdkQzdZezwf51UddFVGQh0mRFMEexr1cMHx=va88T515YQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkQzdZezwf51UddFVGQh0mRFMEexr1cMHx=va88T515YQ@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Nick,

On Mon, Jun 03, 2019 at 02:07:50PM -0700, Nick Desaulniers wrote:
> On Mon, Jun 3, 2019 at 10:44 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> > Looking at the loop in a vacuum as clang would, fndit could be
> > uninitialized if entries was ever zero or the if statement was
> > always true within the loop. Regardless of whether or not this
> > warning is a problem in practice, "found" variables should always
> > be initialized to false so that there is no possibility of
> > undefined behavior.
> 
> Thanks for the patch Nathan.  fndit isn't really being used for
> anything other than a print statement outside of the loop.  How about:

Thank you for the review, this seems reasonable. I will send a v2
shortly.

> 
> ```
> diff --git a/drivers/pci/hotplug/rpaphp_core.c
> b/drivers/pci/hotplug/rpaphp_core.c
> index bcd5d357ca23..c3899ee1db99 100644
> --- a/drivers/pci/hotplug/rpaphp_core.c
> +++ b/drivers/pci/hotplug/rpaphp_core.c
> @@ -230,7 +230,7 @@ static int rpaphp_check_drc_props_v2(struct
> device_node *dn, char *drc_name,
>   struct of_drc_info drc;
>   const __be32 *value;
>   char cell_drc_name[MAX_DRC_NAME_LEN];
> - int j, fndit;
> + int j;
> 
>   info = of_find_property(dn->parent, "ibm,drc-info", NULL);
>   if (info == NULL)
> @@ -245,17 +245,13 @@ static int rpaphp_check_drc_props_v2(struct
> device_node *dn, char *drc_name,
> 
>   /* Should now know end of current entry */
> 
> - if (my_index > drc.last_drc_index)
> - continue;
> -
> - fndit = 1;
> - break;
> + /* Found it */
> + if (my_index <= drc.last_drc_index) {
> + sprintf(cell_drc_name, "%s%d", drc.drc_name_prefix,
> + my_index);
> + break;
> + }
>   }
> - /* Found it */
> -
> - if (fndit)
> - sprintf(cell_drc_name, "%s%d", drc.drc_name_prefix,
> - my_index);
> 
>   if (((drc_name == NULL) ||
>        (drc_name && !strcmp(drc_name, cell_drc_name))) &&
> ```
> (not sure my tabs were pasted properly in the above...)

Doesn't look like it but no worries.

Thanks,
Nathan
