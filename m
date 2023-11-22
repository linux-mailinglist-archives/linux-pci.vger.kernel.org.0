Return-Path: <linux-pci+bounces-126-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2DE7F3FF2
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 09:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A91EA281041
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 08:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86D522337;
	Wed, 22 Nov 2023 08:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KxKYbUt7"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7B492
	for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2023 00:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700640957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JRmfIAx9MaydzWmtQDZrPT7gVmfLVISSD73kQtcsaEk=;
	b=KxKYbUt7Fo/yzKxT2GPU9JuWeove29xwKiGLRpcaIIQ95nn0VS+q7KqMC8A/tLKnj22R01
	QJe26/CO3k4K8YrjO/inUYSb7qnsH+EKToJB9tw1BXBP+sqW0H40Xmz2/ZtdCcEVkz0BP6
	Ot4Zz8nJ5F3B0XcCIQ9t5KfrSI2cySQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-ZewHZTDIM7mui45gC9rT4A-1; Wed, 22 Nov 2023 03:15:56 -0500
X-MC-Unique: ZewHZTDIM7mui45gC9rT4A-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9d358c03077so88749066b.1
        for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2023 00:15:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700640955; x=1701245755;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JRmfIAx9MaydzWmtQDZrPT7gVmfLVISSD73kQtcsaEk=;
        b=REegsTX1NEXQ1FNE1F/BjZ8fiy5VfbBdKSBdaMcqPXE3MZgkg/KtFZsf/bFrrB4kxv
         yosLApezXmPLhO56dySctJs67DJVHlinjCu4l3vOcB0ZgdeS9wISI6bPm8mx0MZ60z6E
         Y8NnB1ObBuxQxezN5f2W/RWm5qSziCBHQ1GKaiLKUkBMnOcBIYDazuKIMZ7nhsj4WzGb
         Ua1LdiVBsJJso1uyo7w+Ouq/8fZ1RuPQlhCDjC48986ExYLKQG9UjOnYfzCoVGK0rCDg
         qtQsScYm6G2yjGCb1wE35Ej1fVyXlG1IBGw7iBgIHFPMqsl7il5tczyR+tiWrKi+dCV5
         lhWA==
X-Gm-Message-State: AOJu0YypTM/6Mcy7ohjlTduL9IJi/xGvEPx14cxbqFDmdGZdR8PWxm3L
	Yg5fCpqz5IKoC9bSuf55b9Kiy8czsFRtZ7obTL0Ypkx4MJfXd68UkbO9QkTfaH8QDCHo30So4iy
	C2wNkt7ZGathTmKXwJ4bz
X-Received: by 2002:a17:906:ce:b0:9ae:50de:1aaf with SMTP id 14-20020a17090600ce00b009ae50de1aafmr725883eji.4.1700640955001;
        Wed, 22 Nov 2023 00:15:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiUZWGroCNriOzsL9jf8A18P1e27Cekr39FceTxV7W9j8VXU/13OQNsgXhBVeL6d6QbzamhA==
X-Received: by 2002:a17:906:ce:b0:9ae:50de:1aaf with SMTP id 14-20020a17090600ce00b009ae50de1aafmr725862eji.4.1700640954570;
        Wed, 22 Nov 2023 00:15:54 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32f5:ce00:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id s8-20020a170906354800b0099ddc81903asm6300601eja.221.2023.11.22.00.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 00:15:54 -0800 (PST)
Message-ID: <9828583bcb49e1adeaa9ac16204b2ad80bd77d4d.camel@redhat.com>
Subject: Re: [PATCH 1/4] lib: move pci_iomap.c to drivers/pci/
From: Philipp Stanner <pstanner@redhat.com>
To: "Liu, Yujie" <yujie.liu@intel.com>, lkp <lkp@intel.com>, 
 "kmo@daterainc.com" <kmo@daterainc.com>, "keescook@chromium.org"
 <keescook@chromium.org>,  "neilb@suse.de" <neilb@suse.de>,
 "mhiramat@kernel.org" <mhiramat@kernel.org>, "arnd@kernel.org"
 <arnd@kernel.org>, "yury.norov@gmail.com" <yury.norov@gmail.com>, 
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "helgaas@kernel.org" <helgaas@kernel.org>,  "herbert@gondor.apana.org.au"
 <herbert@gondor.apana.org.au>, "rdunlap@infradead.org"
 <rdunlap@infradead.org>,  "ben.dooks@codethink.co.uk"
 <ben.dooks@codethink.co.uk>, "tglx@linutronix.de" <tglx@linutronix.de>, 
 "Jiang, Dave" <dave.jiang@intel.com>, "jbaron@akamai.com"
 <jbaron@akamai.com>, "dakr@redhat.com" <dakr@redhat.com>,
 "davidgow@google.com" <davidgow@google.com>,  "schnelle@linux.ibm.com"
 <schnelle@linux.ibm.com>, "sanpeqf@gmail.com" <sanpeqf@gmail.com>, 
 "wuqiang.matt@bytedance.com" <wuqiang.matt@bytedance.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,  "jgg@ziepe.ca"
 <jgg@ziepe.ca>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-pci@vger.kernel.org"
	 <linux-pci@vger.kernel.org>, "paul@pgazz.com" <paul@pgazz.com>, 
	"fazilyildiran@gmail.com"
	 <fazilyildiran@gmail.com>, "oe-kbuild-all@lists.linux.dev"
	 <oe-kbuild-all@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Wed, 22 Nov 2023 09:15:52 +0100
In-Reply-To: <02aebbffd1b70820648c93efa1003df321b3b19b.camel@intel.com>
References: <20231120215945.52027-3-pstanner@redhat.com>
	 <202311212316.a0awwkaE-lkp@intel.com>
	 <02aebbffd1b70820648c93efa1003df321b3b19b.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-11-22 at 01:51 +0000, Liu, Yujie wrote:
> Please kindly ignore these duplicate reports. There seems to be a bug
> in the robot and we will fix this ASAP. Sorry for the noise.

They are not exactly duplicates, I think. You notice that by the mails'
bottoms:

Mail N:
   WARNING: unmet direct dependencies detected for GENERIC_PCI_IOMAP
     Depends on [n]: PCI [=3Dn]
     Selected by [y]:
     - SPARC [=3Dy]

Mail N-1:
   WARNING: unmet direct dependencies detected for GENERIC_PCI_IOMAP
     Depends on [n]: PCI [=3Dn]
     Selected by [y]:
     - PARISC [=3Dy]

etc...

So it seems to me that it's testing all the architectures and then
sends an email for each one where the build fails.

P.

>=20
> On Tue, 2023-11-21 at 23:56 +0800, kernel test robot wrote:
> > Hi Philipp,
> >=20
> > kernel test robot noticed the following build warnings:
> >=20
> > [auto build test WARNING on pci/next]
> > [also build test WARNING on pci/for-linus linus/master v6.7-rc2
> > next-
> > 20231121]
> > [If your patch is applied to the wrong git tree, kindly drop us a
> > note.
> > And when submitting patch, we suggest to use '--base' as documented
> > in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >=20
> > url:=C2=A0=C2=A0=C2=A0
> > https://github.com/intel-lab-lkp/linux/commits/Philipp-Stanner/lib-move=
-pci_iomap-c-to-drivers-pci/20231121-060258
> > base:=C2=A0=C2=A0
> > https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git=C2=A0next
> > patch link:=C2=A0=C2=A0=C2=A0
> > https://lore.kernel.org/r/20231120215945.52027-3-pstanner%40redhat.com
> > patch subject: [PATCH 1/4] lib: move pci_iomap.c to drivers/pci/
> > config: sparc64-kismet-CONFIG_GENERIC_PCI_IOMAP-CONFIG_SPARC-0-0
> > (
> > https://download.01.org/0day-ci/archive/20231121/202311212316.a0awwk
> > aE-lkp@intel.com/config)
> > reproduce:
> > (
> > https://download.01.org/0day-ci/archive/20231121/202311212316.a0awwk
> > aE-lkp@intel.com/reproduce)
> >=20
> > If you fix the issue in a separate patch/commit (i.e. not just a
> > new
> > version of
> > the same patch/commit), kindly add following tags
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes:
> > > https://lore.kernel.org/oe-kbuild-all/202311212316.a0awwkaE-lkp@intel=
.com/
> >=20
> > kismet warnings: (new ones prefixed by >>)
> > > > kismet: WARNING: unmet direct dependencies detected for
> > > > GENERIC_PCI_IOMAP when selected by SPARC
> > =C2=A0=C2=A0 /usr/bin/grep: /db/releases/20231121182703/kernel-
> > tests/etc/kcflags: No such file or directory
> > =C2=A0=C2=A0 {"timestamp":"2023-11-21 22:16:15 +0800", "level":"WARN",
> > "event":"kbuild.sh:3942:in `add_etc_kcflags': grep exit 2
> > (ShellError)", "detail":"cmd: '/usr/bin/grep' '-v' '-e' '^#' '-e'
> > '^$' '/db/releases/20231121182703/kernel-tests/etc/kcflags'
> > \nstderr:
> > /usr/bin/grep: /db/releases/20231121182703/kernel-
> > tests/etc/kcflags:
> > No such file or directory\n\n", "hostname":"community-kbuild-
> > consumer-123", "host_hostname":"lkp-worker50",
> > "call_stack":"/zday/kernel-tests/lib/kbuild.sh:3942:in
> > `add_etc_kcflags': /usr/bin/grep:
> > /db/releases/20231121182703/kernel-
> > tests/etc/kcflags: No such file or directory (ShellError 2)\n=C2=A0 fro=
m
> > /zday/kernel-tests/lib/kbuild.sh:3971: setup_kcflags\n=C2=A0 from
> > /zday/kernel-tests/lib/kbuild.sh:4016: invoke_make\n=C2=A0 from
> > /zday/kernel-tests/lib/kbuild.sh:4122: make\n=C2=A0 from /zday/kernel-
> > tests/lib/kbuild.sh:5623: make_config_allyes\n=C2=A0 from /zday/kernel-
> > tests/common.sh:209: redirect_error_to_screen\n=C2=A0 from /zday/kernel=
-
> > tests/common.sh:217: redirect_command_errors\n=C2=A0 from /zday/kernel-
> > tests/lib/kbuild.sh:5630: make_config\n=C2=A0 from /zday/kernel-
> > tests/lib/builder/kismet.sh:156:
> > generate_make_olddefconfig_warnings\n=C2=A0 from /zday/kernel-
> > tests/lib/builder/kismet.sh:297: builder_compile\n=C2=A0 from
> > /zday/kernel-tests/bisect-test-build-error.sh:94: main\n"}
> > =C2=A0=C2=A0=20
> > =C2=A0=C2=A0 WARNING: unmet direct dependencies detected for
> > GENERIC_PCI_IOMAP
> > =C2=A0=C2=A0=C2=A0=C2=A0 Depends on [n]: PCI [=3Dn]
> > =C2=A0=C2=A0=C2=A0=C2=A0 Selected by [y]:
> > =C2=A0=C2=A0=C2=A0=C2=A0 - SPARC [=3Dy]
> >=20
>=20


