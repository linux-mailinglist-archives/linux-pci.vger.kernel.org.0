Return-Path: <linux-pci+bounces-496-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6380B805759
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 15:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E21D1F2160F
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 14:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C1E54BD6;
	Tue,  5 Dec 2023 14:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OdR1wATk"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CA6B9
	for <linux-pci@vger.kernel.org>; Tue,  5 Dec 2023 06:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701786862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t1oo9wYlZR3izMsicqmb+vabDeYW3Sk3a+FflIBcT0I=;
	b=OdR1wATkGTu+1GZ3xsJlJb8xwUuCY4Xp1G28Bmjd1naayL2YNhzQh1VmfaXDWHyt5ReR4X
	cV6yndOReUKU+kqRBl+bWiSWCOBUPwe2zgix3Q7CwA7Wn5QxTHy0JOox1R6OKvDgonJaPp
	/z8V+RAmkMBBMfbMMB852MLrJ+quSm8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-LPFYlGVwMFiNVUNeLGlewQ-1; Tue, 05 Dec 2023 09:34:15 -0500
X-MC-Unique: LPFYlGVwMFiNVUNeLGlewQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40a3d918dc1so11654375e9.0
        for <linux-pci@vger.kernel.org>; Tue, 05 Dec 2023 06:34:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701786854; x=1702391654;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t1oo9wYlZR3izMsicqmb+vabDeYW3Sk3a+FflIBcT0I=;
        b=b5byJZeOC7K1ewRaS5VrRHq+oTn6KVibKAu/ty0uylM6FvrXvMXSKPTeqr2L6YpH5U
         O06etDH9JDArVQcbhiQrLFFwyqhyUa9wV5L9ZNbVNj/rScQOt5j253PktKrV515iyUc1
         HfUS8CDPpwgOxiM2vVYOv+2q3I3/MghjmIN0sgE2OrnlIil6s7Sqd2MqiWY8/73DMhmD
         EuRRPy0AncQFuBhonIgWrAlDASsevaypbNCxwBKYZRJAKjzYurk7MWcG4MPsvmWGzH30
         v+/nLF7FAS5PmSob37JoL0dWKJdvbQCM+LRK5wlQEd79iutCTfVW2T0s7DNivX8vHaq0
         K0lw==
X-Gm-Message-State: AOJu0Yzkap5kezgs0ldd4mzF4qqqdawb/E7I0UeSUkoyQ8HJaoPLaMtg
	mTNcXsB4RKNgCXG/i3iprWMMlwBRkbgS3H1JeLZh8MPfSM0bd7Ae+0vc4V5P2/GAHSqY9yn4vH1
	siN1b4j06182xMZERp0CQ
X-Received: by 2002:a05:600c:5024:b0:40a:771f:6a56 with SMTP id n36-20020a05600c502400b0040a771f6a56mr24476155wmr.4.1701786854234;
        Tue, 05 Dec 2023 06:34:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGPNdBwDu9dr6enHkkgXCOXz022qJVffHzVjL5DyqXAOhz0Bn+IqdhhmLHKvXQvWYQm8QVxw==
X-Received: by 2002:a05:600c:5024:b0:40a:771f:6a56 with SMTP id n36-20020a05600c502400b0040a771f6a56mr24476128wmr.4.1701786853892;
        Tue, 05 Dec 2023 06:34:13 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600c451100b0040b379e8526sm22411354wmo.25.2023.12.05.06.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 06:34:13 -0800 (PST)
Message-ID: <8ec1ae92206c090c79a9ab9586bd17349798b08f.camel@redhat.com>
Subject: Re: [PATCH v3 5/5] lib, pci: unify generic pci_iounmap()
From: Philipp Stanner <pstanner@redhat.com>
To: kernel test robot <lkp@intel.com>, Bjorn Helgaas <helgaas@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Hanjun Guo <guohanjun@huawei.com>, NeilBrown
 <neilb@suse.de>,  Kent Overstreet <kmo@daterainc.com>, Jakub Kicinski
 <kuba@kernel.org>, Niklas Schnelle <schnelle@linux.ibm.com>,  Uladzislau
 Koshchanka <koshchanka@gmail.com>, John Sanpe <sanpeqf@gmail.com>, Dave
 Jiang <dave.jiang@intel.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>,  Kees Cook <keescook@chromium.org>, David Gow
 <davidgow@google.com>, Herbert Xu <herbert@gondor.apana.org.au>, Shuah Khan
 <skhan@linuxfoundation.org>,  "wuqiang.matt" <wuqiang.matt@bytedance.com>,
 Yury Norov <yury.norov@gmail.com>, Jason Baron <jbaron@akamai.com>,  Andrew
 Morton <akpm@linux-foundation.org>, Ben Dooks <ben.dooks@codethink.co.uk>,
 dakr@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, Linux Memory Management List
 <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org,  linux-arch@vger.kernel.org,
 stable@vger.kernel.org
Date: Tue, 05 Dec 2023 15:34:12 +0100
In-Reply-To: <202312051813.09WbvusW-lkp@intel.com>
References: <20231204123834.29247-6-pstanner@redhat.com>
	 <202312051813.09WbvusW-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Alright, so it seems that not all architectures provide ioport_unmap().
So I'll provide yet another preprocessor guard in v4. Wohooo, we love
them...

P.

On Tue, 2023-12-05 at 18:44 +0800, kernel test robot wrote:
> Hi Philipp,
>=20
> kernel test robot noticed the following build errors:
>=20
> [auto build test ERROR on pci/next]
> [also build test ERROR on pci/for-linus arnd-asm-generic/master
> kees/for-next/pstore kees/for-next/kspp linus/master v6.7-rc4 next-
> 20231205]
> [If your patch is applied to the wrong git tree, kindly drop us a
> note.
> And when submitting patch, we suggest to use '--base' as documented
> in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:=C2=A0=C2=A0=C2=A0
> https://github.com/intel-lab-lkp/linux/commits/Philipp-Stanner/lib-pci_io=
map-c-fix-cleanup-bugs-in-pci_iounmap/20231204-204128
> base:=C2=A0=C2=A0
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git=C2=A0next
> patch link:=C2=A0=C2=A0=C2=A0
> https://lore.kernel.org/r/20231204123834.29247-6-pstanner%40redhat.com
> patch subject: [PATCH v3 5/5] lib, pci: unify generic pci_iounmap()
> config: openrisc-virt_defconfig
> (https://download.01.org/0day-ci/archive/20231205/202312051813.09Wbvu
> sW-lkp@intel.com/config)
> compiler: or1k-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=3D1 build):
> (https://download.01.org/0day-ci/archive/20231205/202312051813.09Wbvu
> sW-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new
> version of
> the same patch/commit), kindly add following tags
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes:
> > https://lore.kernel.org/oe-kbuild-all/202312051813.09WbvusW-lkp@intel.c=
om/
>=20
> All errors (new ones prefixed by >>):
>=20
> =C2=A0=C2=A0 drivers/pci/iomap.c: In function 'pci_iounmap':
> > > drivers/pci/iomap.c:155:17: error: implicit declaration of
> > > function 'ioport_unmap'; did you mean 'devm_ioport_unmap'? [-
> > > Werror=3Dimplicit-function-declaration]
> =C2=A0=C2=A0=C2=A0=C2=A0 155 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ioport_unmap(addr);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ^~~~~~~~~~~~
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 devm_ioport_unmap
> =C2=A0=C2=A0 cc1: some warnings being treated as errors
>=20
>=20
> vim +155 drivers/pci/iomap.c
>=20
> =C2=A0=C2=A0 144=C2=A0=C2=A0
> =C2=A0=C2=A0 145=C2=A0=C2=A0/**
> =C2=A0=C2=A0 146=C2=A0=C2=A0 * pci_iounmap - Unmapp a mapping
> =C2=A0=C2=A0 147=C2=A0=C2=A0 * @dev: PCI device the mapping belongs to
> =C2=A0=C2=A0 148=C2=A0=C2=A0 * @addr: start address of the mapping
> =C2=A0=C2=A0 149=C2=A0=C2=A0 *
> =C2=A0=C2=A0 150=C2=A0=C2=A0 * Unmapp a PIO or MMIO mapping.
> =C2=A0=C2=A0 151=C2=A0=C2=A0 */
> =C2=A0=C2=A0 152=C2=A0=C2=A0void pci_iounmap(struct pci_dev *dev, void __=
iomem *addr)
> =C2=A0=C2=A0 153=C2=A0=C2=A0{
> =C2=A0=C2=A0 154=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0if (iomem_is_ioport(addr)) {
> =C2=A0> 155=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ioport_unmap(addr);
> =C2=A0=C2=A0 156=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
> =C2=A0=C2=A0 157=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0}
> =C2=A0=C2=A0 158=C2=A0=C2=A0
> =C2=A0=C2=A0 159=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0iounmap(addr);
> =C2=A0=C2=A0 160=C2=A0=C2=A0}
> =C2=A0=C2=A0 161=C2=A0=C2=A0EXPORT_SYMBOL(pci_iounmap);
> =C2=A0=C2=A0 162=C2=A0=C2=A0
>=20


