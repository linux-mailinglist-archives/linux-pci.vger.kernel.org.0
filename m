Return-Path: <linux-pci+bounces-30-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D307F2AE3
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 11:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17A0BB20F5E
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 10:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DD747779;
	Tue, 21 Nov 2023 10:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JyvFFyFp"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9F895
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 02:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700563476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D98d67dJTzwsUd9eCHHVSRFgUFPwb3mebft3YR91Jo8=;
	b=JyvFFyFpFWj7r3UuSV2KT41M7H/3yDr2W6qivYqgNhR/DNz8uaI9BqVENHizgmaSGIRWGb
	vsK/h243Wl1dDiKc/2E5mL22Th96r1CYJ4nt4zuE6q0zoA0QDqtUBxcugPV/vv8cAOGHCe
	XFcAcEeJ7IhO+eYgDUNC28G7SYKwGHs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-NuiWCwEzP4i4BIi4HGHDag-1; Tue, 21 Nov 2023 05:44:34 -0500
X-MC-Unique: NuiWCwEzP4i4BIi4HGHDag-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-41e1899175eso14491961cf.1
        for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 02:44:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700563474; x=1701168274;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D98d67dJTzwsUd9eCHHVSRFgUFPwb3mebft3YR91Jo8=;
        b=Gh5530UCE7Ba6rmEVbaTt7TEOrEgq5P/P9dSKXpSlhvt+Nkeis2iB0j50S7PjQFdLQ
         aCZ0fCJcFh1ILp3YXohOtQiLsD0L61JNpNA8ppAy7XVERaUJ1f/Ogfzb9dwkVzqbpjop
         L4Dr9IG+IFrrUjnsHYCZ3z5TaVlFqn2x9cPV1c2/f/2g1THHoJzF+8+/+tZK3dmy/0lV
         zZPkg4WtpsZRdtcHifgSMC4SO7OwqhAeYNa2x9gkJwI8yaZP6sDSk6U/PZvWxIXAznNt
         X1zOmgfyoXxGoIyikgvS8EvoXJbtKmqBIZcaPOBrsQqqM1JjR3zk9G21aSJkHcA+SEXn
         d38Q==
X-Gm-Message-State: AOJu0Yx1w5NBFXoX/nml5MfKTyYtQwSWWCeBDVdtXmx1tqC8Z9iVx2XQ
	yDog9l78r/YyO4SiCmsDCUIVrbii6vT+V/amK/Dhz2iiqgNdYtyrTOPvOpJ+vHdMO/HA00HBGON
	QghwPqzyaF0/a4Uke1ejP
X-Received: by 2002:a05:620a:1a9e:b0:770:f2bb:37c3 with SMTP id bl30-20020a05620a1a9e00b00770f2bb37c3mr12537246qkb.6.1700563473961;
        Tue, 21 Nov 2023 02:44:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/sm0My6Yyohd0alWvqDGg5Khk4AEl1+aaNBMiijwO+e8aj/4p/OGT9jR4G0cleOwT27Bbiw==
X-Received: by 2002:a05:620a:1a9e:b0:770:f2bb:37c3 with SMTP id bl30-20020a05620a1a9e00b00770f2bb37c3mr12537219qkb.6.1700563473442;
        Tue, 21 Nov 2023 02:44:33 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id vv24-20020a05620a563800b0076cda7eab11sm3478221qkn.133.2023.11.21.02.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 02:44:33 -0800 (PST)
Message-ID: <fa9a0b07c53d15df7fb9b87002a8c24d03380f24.camel@redhat.com>
Subject: Re: [PATCH 1/4] lib: move pci_iomap.c to drivers/pci/
From: Philipp Stanner <pstanner@redhat.com>
To: kernel test robot <lkp@intel.com>, Bjorn Helgaas <helgaas@kernel.org>, 
 Arnd Bergmann <arnd@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,  Jason Gunthorpe <jgg@ziepe.ca>, Eric
 Auger <eric.auger@redhat.com>, Kent Overstreet <kmo@daterainc.com>, Niklas
 Schnelle <schnelle@linux.ibm.com>, NeilBrown <neilb@suse.de>, John Sanpe
 <sanpeqf@gmail.com>, Dave Jiang <dave.jiang@intel.com>,  Yury Norov
 <yury.norov@gmail.com>, Kees Cook <keescook@chromium.org>, "Masami
 Hiramatsu (Google)" <mhiramat@kernel.org>, David Gow <davidgow@google.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Thomas Gleixner
 <tglx@linutronix.de>,  "wuqiang.matt" <wuqiang.matt@bytedance.com>, Jason
 Baron <jbaron@akamai.com>, Ben Dooks <ben.dooks@codethink.co.uk>, Danilo
 Krummrich <dakr@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Linux Memory Management List
 <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org,  pstanner@redhat.com
Date: Tue, 21 Nov 2023 11:44:29 +0100
In-Reply-To: <202311211216.KqPYvOCI-lkp@intel.com>
References: <20231120215945.52027-3-pstanner@redhat.com>
	 <202311211216.KqPYvOCI-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-11-21 at 12:20 +0800, kernel test robot wrote:
> Hi Philipp,
>=20
> kernel test robot noticed the following build errors:
>=20
> [auto build test ERROR on pci/next]
> [also build test ERROR on pci/for-linus linus/master v6.7-rc2 next-
> 20231120]
> [If your patch is applied to the wrong git tree, kindly drop us a
> note.
> And when submitting patch, we suggest to use '--base' as documented
> in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:=C2=A0=C2=A0=C2=A0
> https://github.com/intel-lab-lkp/linux/commits/Philipp-Stanner/lib-move-p=
ci_iomap-c-to-drivers-pci/20231121-060258
> base:=C2=A0=C2=A0
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git=C2=A0next
> patch link:=C2=A0=C2=A0=C2=A0
> https://lore.kernel.org/r/20231120215945.52027-3-pstanner%40redhat.com
> patch subject: [PATCH 1/4] lib: move pci_iomap.c to drivers/pci/
> config: openrisc-allnoconfig
> (https://download.01.org/0day-ci/archive/20231121/202311211216.KqPYvO
> CI-lkp@intel.com/config)
> compiler: or1k-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=3D1 build):
> (https://download.01.org/0day-ci/archive/20231121/202311211216.KqPYvO
> CI-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new
> version of
> the same patch/commit), kindly add following tags
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes:
> > https://lore.kernel.org/oe-kbuild-all/202311211216.KqPYvOCI-lkp@intel.c=
om/
>=20
> All error/warnings (new ones prefixed by >>):
>=20
> > > drivers/pci/iomap.c:27:15: error: redefinition of
> > > 'pci_iomap_range'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 27 | void __iomem *pci_iomap_range(struct =
pci_dev *dev,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~=
~~~~
> =C2=A0=C2=A0 In file included from include/asm-generic/io.h:20,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from arch/openrisc/include/asm/i=
o.h:37,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from include/linux/io.h:13,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from include/linux/irq.h:20,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from include/asm-generic/hardirq=
.h:17,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from
> ./arch/openrisc/include/generated/asm/hardirq.h:1,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from include/linux/hardirq.h:11,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from include/linux/interrupt.h:1=
1,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from include/linux/pci.h:38,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from drivers/pci/iomap.c:7:
> =C2=A0=C2=A0 include/asm-generic/pci_iomap.h:44:29: note: previous defini=
tion
> of 'pci_iomap_range' with type 'void *(struct pci_dev *, int,=C2=A0 long
> unsigned int,=C2=A0 long unsigned int)'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 44 | static inline void __iomem *pci_iomap=
_range(struct pci_dev
> *dev, int bar,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~=
~~~~~~~~~~~~~
> =C2=A0=C2=A0 drivers/pci/iomap.c: In function 'pci_iomap_range':
> > > drivers/pci/iomap.c:43:24: error: implicit declaration of
> > > function '__pci_ioport_map'; did you mean 'devm_ioport_map'? [-
> > > Werror=3Dimplicit-function-declaration]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 43 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return __pci_i=
oport_map(dev, start, len);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devm_ioport_map
> > > drivers/pci/iomap.c:43:24: warning: returning 'int' from a
> > > function with return type 'void *' makes pointer from integer
> > > without a cast [-Wint-conversion]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 43 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return __pci_i=
oport_map(dev, start, len);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
> =C2=A0=C2=A0 drivers/pci/iomap.c: At top level:
> > > drivers/pci/iomap.c:67:15: error: redefinition of
> > > 'pci_iomap_wc_range'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 67 | void __iomem *pci_iomap_wc_range(stru=
ct pci_dev *dev,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~=
~~~~~~~
> =C2=A0=C2=A0 include/asm-generic/pci_iomap.h:50:29: note: previous defini=
tion
> of 'pci_iomap_wc_range' with type 'void *(struct pci_dev *, int,=C2=A0
> long unsigned int,=C2=A0 long unsigned int)'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 50 | static inline void __iomem *pci_iomap=
_wc_range(struct
> pci_dev *dev, int bar,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~=
~~~~~~~~~~~~~~~~
> > > drivers/pci/iomap.c:110:15: error: redefinition of 'pci_iomap'
> =C2=A0=C2=A0=C2=A0=C2=A0 110 | void __iomem *pci_iomap(struct pci_dev *de=
v, int bar,
> unsigned long maxlen)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~
> =C2=A0=C2=A0 include/asm-generic/pci_iomap.h:35:29: note: previous defini=
tion
> of 'pci_iomap' with type 'void *(struct pci_dev *, int,=C2=A0 long
> unsigned int)'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 35 | static inline void __iomem *pci_iomap=
(struct pci_dev *dev,
> int bar, unsigned long max)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~=
~~~~~~~
> > > drivers/pci/iomap.c:131:15: error: redefinition of 'pci_iomap_wc'
> =C2=A0=C2=A0=C2=A0=C2=A0 131 | void __iomem *pci_iomap_wc(struct pci_dev =
*dev, int bar,
> unsigned long maxlen)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~=
~
> =C2=A0=C2=A0 include/asm-generic/pci_iomap.h:40:29: note: previous defini=
tion
> of 'pci_iomap_wc' with type 'void *(struct pci_dev *, int,=C2=A0 long
> unsigned int)'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 40 | static inline void __iomem *pci_iomap=
_wc(struct pci_dev
> *dev, int bar, unsigned long max)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~=
~~~~~~~~~~
> > > drivers/pci/iomap.c:164:6: error: redefinition of 'pci_iounmap'
> =C2=A0=C2=A0=C2=A0=C2=A0 164 | void pci_iounmap(struct pci_dev *dev, void=
 __iomem *p)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^~~~~~~~~~~
> =C2=A0=C2=A0 include/asm-generic/pci_iomap.h:56:20: note: previous defini=
tion
> of 'pci_iounmap' with type 'void(struct pci_dev *, void *)'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 56 | static inline void pci_iounmap(struct=
 pci_dev *dev, void
> __iomem *addr)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~
> =C2=A0=C2=A0 cc1: some warnings being treated as errors
>=20
> Kconfig warnings: (for reference only)
> =C2=A0=C2=A0 WARNING: unmet direct dependencies detected for GENERIC_PCI_=
IOMAP
> =C2=A0=C2=A0 Depends on [n]: PCI [=3Dn]
> =C2=A0=C2=A0 Selected by [y]:
> =C2=A0=C2=A0 - OPENRISC [=3Dy]


OK, so the issue here seems to be that you can not have
GENERIC_PCI_IOMAP depend on PCI.

Previously, #ifdef CONFIG_PCI made the (in this case) redundant
function definitions disappear, which is not the case anymore for
configs that want GENERIC_PCI_IOMAP but not PCI.

My bad.
I'll address that in the next version.


P.


>=20
>=20
> vim +/pci_iomap_range +27 drivers/pci/iomap.c
>=20
> 66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24=C2=A0=C2=A0 =
11=C2=A0=20
> 66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24=C2=A0=C2=A0 =
12=C2=A0
> /**
> eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29=C2=A0=C2=A0 =
13=C2=A0=C2=A0 *
> pci_iomap_range - create a virtual mapping cookie for a PCI BAR
> 66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24=C2=A0=C2=A0 =
14=C2=A0=C2=A0 *
> @dev: PCI device that owns the BAR
> 66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24=C2=A0=C2=A0 =
15=C2=A0=C2=A0 *
> @bar: BAR number
> eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29=C2=A0=C2=A0 =
16=C2=A0=C2=A0 *
> @offset: map memory at the given offset in BAR
> eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29=C2=A0=C2=A0 =
17=C2=A0=C2=A0 *
> @maxlen: max length of the memory to map
> 66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24=C2=A0=C2=A0 =
18=C2=A0=C2=A0 *
> 66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24=C2=A0=C2=A0 =
19=C2=A0=C2=A0 *
> Using this function you will get a __iomem address to your device
> BAR.
> 66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24=C2=A0=C2=A0 =
20=C2=A0=C2=A0 *
> You can access it using ioread*() and iowrite*(). These functions
> hide
> 66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24=C2=A0=C2=A0 =
21=C2=A0=C2=A0 *
> the details if this is a MMIO or PIO address space and will just do
> what
> 66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24=C2=A0=C2=A0 =
22=C2=A0=C2=A0 *
> you expect from them in the correct way.
> 66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24=C2=A0=C2=A0 =
23=C2=A0=C2=A0 *
> 66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24=C2=A0=C2=A0 =
24=C2=A0=C2=A0 *
> @maxlen specifies the maximum length to map. If you want to get
> access to
> eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29=C2=A0=C2=A0 =
25=C2=A0=C2=A0 *
> the complete BAR from offset to the end, pass %0 here.
> 66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24=C2=A0=C2=A0 =
26=C2=A0=C2=A0 *
> */
> eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29=C2=A0 @27=C2=
=A0
> void __iomem *pci_iomap_range(struct pci_dev *dev,
> eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29=C2=A0=C2=A0
> 28=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 int bar,
> eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29=C2=A0=C2=A0
> 29=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long offset,
> eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29=C2=A0=C2=A0
> 30=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long maxlen)
> 66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24=C2=A0=C2=A0 =
31=C2=A0 {
> 66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24=C2=A0=C2=A0
> 32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0resource_size_t start =3D pci=
_resource_start(dev, bar);
> 66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24=C2=A0=C2=A0
> 33=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0resource_size_t len =3D pci_r=
esource_len(dev, bar);
> 66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24=C2=A0=C2=A0
> 34=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long flags =3D pci_r=
esource_flags(dev, bar);
> 66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24=C2=A0=C2=A0 =
35=C2=A0=20
> eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29=C2=A0=C2=A0
> 36=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (len <=3D offset || !start=
)
> 66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24=C2=A0=C2=A0
> 37=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return NULL;
> eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29=C2=A0=C2=A0
> 38=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0len -=3D offset;
> eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29=C2=A0=C2=A0
> 39=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0start +=3D offset;
> 66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24=C2=A0=C2=A0
> 40=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (maxlen && len > maxlen)
> 66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24=C2=A0=C2=A0
> 41=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0len =3D maxlen;
> 66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24=C2=A0=C2=A0
> 42=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (flags & IORESOURCE_IO)
> b923650b84068b lib/pci_iomap.c Michael S. Tsirkin 2012-01-30=C2=A0
> @43=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return __pci_ioport_map(dev, start, len);
> 92b19ff50e8f24 lib/pci_iomap.c Dan Williams=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 2015-08-10=C2=A0=C2=A0
> 44=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (flags & IORESOURCE_MEM)
> 66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24=C2=A0=C2=A0
> 45=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return ioremap(start, len);
> 66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24=C2=A0=C2=A0
> 46=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* What? */
> 66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24=C2=A0=C2=A0
> 47=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return NULL;
> 66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24=C2=A0=C2=A0 =
48=C2=A0 }
> eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29=C2=A0=C2=A0 =
49=C2=A0
> EXPORT_SYMBOL(pci_iomap_range);
> 66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24=C2=A0=C2=A0 =
50=C2=A0=20
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0 51=C2=A0
> /**
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0 52=C2=A0=C2=A0 *
> pci_iomap_wc_range - create a virtual WC mapping cookie for a PCI BAR
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0 53=C2=A0=C2=A0 *
> @dev: PCI device that owns the BAR
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0 54=C2=A0=C2=A0 *
> @bar: BAR number
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0 55=C2=A0=C2=A0 *
> @offset: map memory at the given offset in BAR
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0 56=C2=A0=C2=A0 *
> @maxlen: max length of the memory to map
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0 57=C2=A0=C2=A0 *
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0 58=C2=A0=C2=A0 *
> Using this function you will get a __iomem address to your device
> BAR.
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0 59=C2=A0=C2=A0 *
> You can access it using ioread*() and iowrite*(). These functions
> hide
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0 60=C2=A0=C2=A0 *
> the details if this is a MMIO or PIO address space and will just do
> what
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0 61=C2=A0=C2=A0 *
> you expect from them in the correct way. When possible write
> combining
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0 62=C2=A0=C2=A0 *
> is used.
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0 63=C2=A0=C2=A0 *
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0 64=C2=A0=C2=A0 *
> @maxlen specifies the maximum length to map. If you want to get
> access to
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0 65=C2=A0=C2=A0 *
> the complete BAR from offset to the end, pass %0 here.
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0 66=C2=A0=C2=A0 *
> */
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0 @=
67=C2=A0
> void __iomem *pci_iomap_wc_range(struct pci_dev *dev,
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0
> 68=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int bar,
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0
> 69=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long offset,
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0
> 70=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long maxlen)
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0 71=C2=A0 {
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0
> 72=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0resource_size_t start =3D pci=
_resource_start(dev, bar);
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0
> 73=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0resource_size_t len =3D pci_r=
esource_len(dev, bar);
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0
> 74=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long flags =3D pci_r=
esource_flags(dev, bar);
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0 75=C2=A0=20
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0 76=C2=A0=20
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0
> 77=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (flags & IORESOURCE_IO)
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0
> 78=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return NULL;
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0 79=C2=A0=20
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0
> 80=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (len <=3D offset || !start=
)
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0
> 81=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return NULL;
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0 82=C2=A0=20
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0
> 83=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0len -=3D offset;
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0
> 84=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0start +=3D offset;
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0
> 85=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (maxlen && len > maxlen)
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0
> 86=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0len =3D maxlen;
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0 87=C2=A0=20
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0
> 88=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (flags & IORESOURCE_MEM)
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0
> 89=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return ioremap_wc(start, len);
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0 90=C2=A0=20
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0
> 91=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* What? */
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0
> 92=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return NULL;
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0 93=C2=A0 }
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0 94=C2=A0
> EXPORT_SYMBOL_GPL(pci_iomap_wc_range);
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0=
=C2=A0 95=C2=A0=20
> eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29=C2=A0=C2=A0 =
96=C2=A0
> /**
> eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29=C2=A0=C2=A0 =
97=C2=A0=C2=A0 *
> pci_iomap - create a virtual mapping cookie for a PCI BAR
> eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29=C2=A0=C2=A0 =
98=C2=A0=C2=A0 *
> @dev: PCI device that owns the BAR
> eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29=C2=A0=C2=A0 =
99=C2=A0=C2=A0 *
> @bar: BAR number
> eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29=C2=A0 100=C2=
=A0=C2=A0 *
> @maxlen: length of the memory to map
> eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29=C2=A0 101=C2=
=A0=C2=A0 *
> eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29=C2=A0 102=C2=
=A0=C2=A0 *
> Using this function you will get a __iomem address to your device
> BAR.
> eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29=C2=A0 103=C2=
=A0=C2=A0 *
> You can access it using ioread*() and iowrite*(). These functions
> hide
> eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29=C2=A0 104=C2=
=A0=C2=A0 *
> the details if this is a MMIO or PIO address space and will just do
> what
> eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29=C2=A0 105=C2=
=A0=C2=A0 *
> you expect from them in the correct way.
> eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29=C2=A0 106=C2=
=A0=C2=A0 *
> eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29=C2=A0 107=C2=
=A0=C2=A0 *
> @maxlen specifies the maximum length to map. If you want to get
> access to
> eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29=C2=A0 108=C2=
=A0=C2=A0 *
> the complete BAR without checking for its length first, pass %0 here.
> eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29=C2=A0 109=C2=
=A0=C2=A0 *
> */
> eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29 @110=C2=A0
> void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long
> maxlen)
> eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29=C2=A0 111=C2=
=A0 {
> eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29=C2=A0
> 112=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return pci_iomap_range(dev, =
bar, 0, maxlen);
> eb29d8d2aad706 lib/pci_iomap.c Michael S. Tsirkin 2013-05-29=C2=A0 113=C2=
=A0 }
> 66eab4df288aae lib/pci_iomap.c Michael S. Tsirkin 2011-11-24=C2=A0 114=C2=
=A0
> EXPORT_SYMBOL(pci_iomap);
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0 1=
15=C2=A0=20
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0 1=
16=C2=A0
> /**
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0 1=
17=C2=A0=C2=A0 *
> pci_iomap_wc - create a virtual WC mapping cookie for a PCI BAR
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0 1=
18=C2=A0=C2=A0 *
> @dev: PCI device that owns the BAR
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0 1=
19=C2=A0=C2=A0 *
> @bar: BAR number
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0 1=
20=C2=A0=C2=A0 *
> @maxlen: length of the memory to map
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0 1=
21=C2=A0=C2=A0 *
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0 1=
22=C2=A0=C2=A0 *
> Using this function you will get a __iomem address to your device
> BAR.
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0 1=
23=C2=A0=C2=A0 *
> You can access it using ioread*() and iowrite*(). These functions
> hide
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0 1=
24=C2=A0=C2=A0 *
> the details if this is a MMIO or PIO address space and will just do
> what
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0 1=
25=C2=A0=C2=A0 *
> you expect from them in the correct way. When possible write
> combining
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0 1=
26=C2=A0=C2=A0 *
> is used.
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0 1=
27=C2=A0=C2=A0 *
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0 1=
28=C2=A0=C2=A0 *
> @maxlen specifies the maximum length to map. If you want to get
> access to
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0 1=
29=C2=A0=C2=A0 *
> the complete BAR without checking for its length first, pass %0 here.
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0 1=
30=C2=A0=C2=A0 *
> */
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24 @131=C2=
=A0
> void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned
> long maxlen)
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0 1=
32=C2=A0 {
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0
> 133=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return pci_iomap_wc_range(de=
v, bar, 0, maxlen);
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0 1=
34=C2=A0 }
> 1b3d4200c1e00a lib/pci_iomap.c Luis R. Rodriguez=C2=A0 2015-08-24=C2=A0 1=
35=C2=A0
> EXPORT_SYMBOL_GPL(pci_iomap_wc);
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0 136=C2=A0=20
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0 137=C2=A0 /*
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0 138=C2=A0=C2=A0 *
> pci_iounmap() somewhat illogically comes from lib/iomap.c for the
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0 139=C2=A0=C2=A0 *
> CONFIG_GENERIC_IOMAP case, because that's the code that knows about
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0 140=C2=A0=C2=A0 *
> the different IOMAP ranges.
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0 141=C2=A0=C2=A0 *
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0 142=C2=A0=C2=A0 *
> But if the architecture does not use the generic iomap code, and if
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0 143=C2=A0=C2=A0 *
> it has _not_ defined it's own private pci_iounmap function, we define
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0 144=C2=A0=C2=A0 *
> it here.
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0 145=C2=A0=C2=A0 *
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0 146=C2=A0=C2=A0 *
> NOTE! This default implementation assumes that if the architecture
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0 147=C2=A0=C2=A0 *
> support ioport mapping (HAS_IOPORT_MAP), the ioport mapping will
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0 148=C2=A0=C2=A0 *
> be fixed to the range [ PCI_IOBASE, PCI_IOBASE+IO_SPACE_LIMIT [,
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0 149=C2=A0=C2=A0 *
> and does not need unmapping with 'ioport_unmap()'.
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0 150=C2=A0=C2=A0 *
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0 151=C2=A0=C2=A0 *
> If you have different rules for your architecture, you need to
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0 152=C2=A0=C2=A0 *
> implement your own pci_iounmap() that knows the rules for where
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0 153=C2=A0=C2=A0 *
> and how IO vs MEM get mapped.
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0 154=C2=A0=C2=A0 *
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0 155=C2=A0=C2=A0 *
> This code is odd, and the ARCH_HAS/ARCH_WANTS #define logic comes
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0 156=C2=A0=C2=A0 *
> from legacy <asm-generic/io.h> header file behavior. In particular,
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0 157=C2=A0=C2=A0 *
> it would seem to make sense to do the iounmap(p) for the non-IO-space
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0 158=C2=A0=C2=A0 *
> case here regardless, but that's not what the old header file code
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0 159=C2=A0=C2=A0 *
> did. Probably incorrectly, but this is meant to be bug-for-bug
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0 160=C2=A0=C2=A0 *
> compatible.
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0 161=C2=A0=C2=A0
> */
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0 162=C2=A0
> #if defined(ARCH_WANTS_GENERIC_PCI_IOUNMAP)
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0 163=C2=A0=20
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19 @164=C2=A0
> void pci_iounmap(struct pci_dev *dev, void __iomem *p)
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0 165=C2=A0 {
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0 166=C2=A0
> #ifdef ARCH_HAS_GENERIC_IOPORT_MAP
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0
> 167=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uintptr_t start =3D (uintptr=
_t) PCI_IOBASE;
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0
> 168=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uintptr_t addr =3D (uintptr_=
t) p;
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0 169=C2=A0=20
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0
> 170=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (addr >=3D start && addr =
< start + IO_SPACE_LIMIT)
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0
> 171=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return;
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0
> 172=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iounmap(p);
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0 173=C2=A0
> #endif
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0 174=C2=A0 }
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0 175=C2=A0
> EXPORT_SYMBOL(pci_iounmap);
> 316e8d79a0959c lib/pci_iomap.c Linus Torvalds=C2=A0=C2=A0=C2=A0=C2=A0 202=
1-09-19=C2=A0 176=C2=A0=20
>=20


