Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1303AB8C1
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2019 15:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392419AbfIFNCK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Sep 2019 09:02:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42945 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728507AbfIFNCJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Sep 2019 09:02:09 -0400
Received: by mail-pf1-f194.google.com with SMTP id w22so4425638pfi.9;
        Fri, 06 Sep 2019 06:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+zHYzI/5iPOeYs3eTUKrekqyoTjTQxeWg20Ye5mXe9Q=;
        b=q+lYeqNaVlpnuyxeh21+KBOysiM8Kj5jKpHdEh9IcF+7TNHr2g/sQdNTa5OWSJK4D0
         GVEDfb4hUVa1gTTAb95HQldPPbsoLuT+w9YmO4o75rKZ12iwdx9brC9b+KHpbHAfQE/R
         uKck094B32L3TQxoAwsj6cV6GyHHmrw8jvAjPtyi2NZZaKA/GVf9sKPyeR83PqnePGgr
         2lkRiTHfbGjSA+fD2mXN+OrIiaGmBpYwZzpzz1bV+YrvKPHgB/+GLVrn37WaRRPGjAE0
         h5QSzq188lqeAg8OiLyosXOzfaHgbTXts8sFp89RNW0NJR9/73x124QvZb2RvJgbvGsU
         t30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=+zHYzI/5iPOeYs3eTUKrekqyoTjTQxeWg20Ye5mXe9Q=;
        b=LIo7PppE1i5DXLMuza6mIA+cPJiuprg6i+/kwZjD04BOMJtRkgWmxzzfBeVBGmFAtX
         WbQ4AzCrJqu9igops6wz3WneQprx3pNcolN9ELMIgcsLgcSw4mWZEGc2HMYZ1k8BLhac
         Jzi9uW1fFnDnF4yn/HpQRxNZ6rzcUqKB9ZalNshEdEv8M00D1NTr0QwY2tZUvyWWHCEj
         nySMwBDP5vzZ0InRigxEHh1jfsNdpKbrvq8HDtBKN5xS0RLBXmURC9I/SLYEiLIoRPXm
         G7JpGyoI7ZmsogR/wsrU8bY9LC4XHvwKpNYEEMuz4sze3suk/HHR7luVF9f3nS+KyULt
         yCtg==
X-Gm-Message-State: APjAAAWq82UBgMV8s5HnwDVsG2g4Ia2RDZyVY5SiqwbsWFu7BKA/+9hQ
        W5rnGcenvd1R4Go1zVxuNQ8=
X-Google-Smtp-Source: APXvYqxwUxMhHY9pnysn9iFvtiJFTAh1NEwWSzixrBT1615MIffpovTY+iqWrt+fUcPlUfBFa3H2+w==
X-Received: by 2002:a63:3c5:: with SMTP id 188mr7668810pgd.394.1567774928697;
        Fri, 06 Sep 2019 06:02:08 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g1sm4643610pgg.27.2019.09.06.06.02.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 06:02:07 -0700 (PDT)
Date:   Fri, 6 Sep 2019 06:02:06 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Isaac Vaughn <isaac.vaughn@Knights.ucf.edu>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "trivial@kernel.org" <trivial@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        x86@kernel.org, linux-hwmon@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] Add PCI device IDs for family 17h, model 70h
Message-ID: <20190906130206.GB7255@roeck-us.net>
References: <BN7PR07MB5186DD5732B95B784A9D46BFCEB80@BN7PR07MB5186.namprd07.prod.outlook.com>
 <20190904215308.GA12374@zn.tnic>
 <BN7PR07MB5186E542BB3AD734262AA345CEBB0@BN7PR07MB5186.namprd07.prod.outlook.com>
 <20190905070917.GA19246@zn.tnic>
 <BN7PR07MB51864F8287CAD4847BF17A83CEBB0@BN7PR07MB5186.namprd07.prod.outlook.com>
 <20190905135408.GE19246@zn.tnic>
 <20190905215650.f8b5d22b625ddcff7d093883@knights.ucf.edu>
 <20190906091250.GB19008@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190906091250.GB19008@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 06, 2019 at 11:12:50AM +0200, Borislav Petkov wrote:
> On Fri, Sep 06, 2019 at 01:56:56AM +0000, Isaac Vaughn wrote:
> > Add the new Family 17h Model 70h PCI IDs (device 18h functions 0,3,4,6)
> > to the kernel, the hwmon module, and the AMD64 EDAC module.
> > 
> > Signed-off-by: Isaac Vaughn <isaac.vaughn@knights.ucf.edu>
> > ---
> >  arch/x86/kernel/amd_nb.c  |  3 +++
> >  drivers/edac/amd64_edac.c | 13 +++++++++++++
> >  drivers/edac/amd64_edac.h |  3 +++
> >  drivers/hwmon/k10temp.c   |  1 +
> >  include/linux/pci_ids.h   |  1 +
> >  5 files changed, 21 insertions(+)
> 
> Ok, next lessons :)
> 
> Before you send a patch, do:
> 
Also, how is this patch different to the patches already in linux-next ?

Guenter

> $ git diff | ./scripts/get_maintainer.pl
> 
> or if you've committed it already:
> 
> $ git log -p -1 | ./scripts/get_maintainer.pl
> 
> to know who to Cc.
> 
> I've added the respective mailing lists to Cc because this is a trivial
> addition of PCI IDs and generally maintainers want to see it as an FYI
> thing, thus Ccing the mailing list only. But you can just as well Cc the
> maintainers too - they can manage the mail volume. :)
> 
> And last but *definitely* not least, the most important lesson: *always*
> - I can't stress this enough - *always* build *and* test your patch
> before sending:
> 
> drivers/edac/amd64_edac.c:2326:19: error: ‘f17_base_addr_to_cs_size’ undeclared here (not in a function); did you mean ‘f17_addr_mask_to_cs_size’?
>     .dbam_to_cs  = f17_base_addr_to_cs_size,
>                    ^~~~~~~~~~~~~~~~~~~~~~~~
>                    f17_addr_mask_to_cs_size
> make[2]: *** [scripts/Makefile.build:273: drivers/edac/amd64_edac.o] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [scripts/Makefile.build:490: drivers/edac] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1076: drivers] Error 2
> make: *** Waiting for unfinished jobs....
> 
> If it is any consolation: we have all done this mistake in a hurry at
> least once in the past but pls do take your time.
> 
> Thx.
> 
> Leaving in the rest for reference for the newly CCed.
> 
> > diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> > index d63e63b7d1d9..0a8b816857c1 100644
> > --- a/arch/x86/kernel/amd_nb.c
> > +++ b/arch/x86/kernel/amd_nb.c
> > @@ -21,6 +21,7 @@
> >  #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
> >  #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
> >  #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494
> > +#define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
> >  
> >  /* Protect the PCI config register pairs used for SMN and DF indirect access. */
> >  static DEFINE_MUTEX(smn_mutex);
> > @@ -49,6 +50,7 @@ const struct pci_device_id amd_nb_misc_ids[] = {
> >  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
> >  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
> >  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
> >  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
> >  	{}
> >  };
> > @@ -63,6 +65,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
> >  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F4) },
> >  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F4) },
> >  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F4) },
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F4) },
> >  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
> >  	{}
> >  };
> > diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> > index 873437be86d9..a35c97f9100a 100644
> > --- a/drivers/edac/amd64_edac.c
> > +++ b/drivers/edac/amd64_edac.c
> > @@ -2253,6 +2253,15 @@ static struct amd64_family_type family_types[] = {
> >  			.dbam_to_cs		= f17_base_addr_to_cs_size,
> >  		}
> >  	},
> > +	[F17_M70H_CPUS] = {
> > +		.ctl_name = "F17h_M70h",
> > +		.f0_id = PCI_DEVICE_ID_AMD_17H_M70H_DF_F0,
> > +		.f6_id = PCI_DEVICE_ID_AMD_17H_M70H_DF_F6,
> > +		.ops = {
> > +			.early_channel_count	= f17_early_channel_count,
> > +			.dbam_to_cs		= f17_base_addr_to_cs_size,
> > +		}
> > +	},
> >  };
> >  
> >  /*
> > @@ -3241,6 +3250,10 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
> >  			fam_type = &family_types[F17_M30H_CPUS];
> >  			pvt->ops = &family_types[F17_M30H_CPUS].ops;
> >  			break;
> > +		} else if (pvt->model >= 0x70 && pvt->model <= 0x7f) {
> > +			fam_type = &family_types[F17_M70H_CPUS];
> > +			pvt->ops = &family_types[F17_M70H_CPUS].ops;
> > +			break;
> >  		}
> >  		/* fall through */
> >  	case 0x18:
> > diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
> > index 8f66472f7adc..1adf7ddbf744 100644
> > --- a/drivers/edac/amd64_edac.h
> > +++ b/drivers/edac/amd64_edac.h
> > @@ -119,6 +119,8 @@
> >  #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F6 0x15ee
> >  #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F0 0x1490
> >  #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F6 0x1496
> > +#define PCI_DEVICE_ID_AMD_17H_M70H_DF_F0 0x1440
> > +#define PCI_DEVICE_ID_AMD_17H_M70H_DF_F6 0x1446
> >  
> >  /*
> >   * Function 1 - Address Map
> > @@ -285,6 +287,7 @@ enum amd_families {
> >  	F17_CPUS,
> >  	F17_M10H_CPUS,
> >  	F17_M30H_CPUS,
> > +	F17_M70H_CPUS,
> >  	NUM_FAMILIES,
> >  };
> >  
> > diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> > index c77e89239dcd..5c1dddde193c 100644
> > --- a/drivers/hwmon/k10temp.c
> > +++ b/drivers/hwmon/k10temp.c
> > @@ -349,6 +349,7 @@ static const struct pci_device_id k10temp_id_table[] = {
> >  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
> >  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
> >  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
> > +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
> >  	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
> >  	{}
> >  };
> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > index c842735a4f45..4b97f427cc92 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -548,6 +548,7 @@
> >  #define PCI_DEVICE_ID_AMD_17H_DF_F3	0x1463
> >  #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F3 0x15eb
> >  #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F3 0x1493
> > +#define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
> >  #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
> >  #define PCI_DEVICE_ID_AMD_LANCE		0x2000
> >  #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
> > -- 
> > 2.23.0
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
