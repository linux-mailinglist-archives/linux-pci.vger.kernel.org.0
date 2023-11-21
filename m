Return-Path: <linux-pci+bounces-35-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661F67F2E1E
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 14:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20646281A5C
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 13:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4909138F8E;
	Tue, 21 Nov 2023 13:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j2aGYhK2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2941BC;
	Tue, 21 Nov 2023 05:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700572508; x=1732108508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Q57j+/7EOZ2McPZUaRMs1eswmFrkicqhN5cjKHJxX14=;
  b=j2aGYhK2qatwtfXpAj33PrATVz2IHNIJn57ZhmVqBBHGYfqHfMfBdXT/
   jqycNNOCW3sxTaOB0fK48VexMGjfsPhUOtRiNGiZYy01rKL68kBJ1glVg
   stfxYpckwuIMYrfa3fbnOg4i/1OAVmH5jIO0OH9TzePGRWwiyG0N7s9hf
   gBBbdWuvpJ3E2xBechlji4iBdxf+7wPC68HmTChxocXzc/hvGsgLXoPFQ
   c3sMuKwfiGBQCCLmMXnlqzxitO4HORFJUSU6PV5TH9n0jFhzIFZ0nC387
   U2OC0iziCQIlgUOWL7DDW++4e0JJq6CLQcLdNBZqQuiCP7PwPXZIEL1S0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="4965680"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="4965680"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 05:15:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="801524175"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="801524175"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 21 Nov 2023 05:15:00 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r5Qag-0007on-1H;
	Tue, 21 Nov 2023 13:14:58 +0000
Date: Tue, 21 Nov 2023 21:14:04 +0800
From: kernel test robot <lkp@intel.com>
To: Philipp Stanner <pstanner@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Eric Auger <eric.auger@redhat.com>,
	Kent Overstreet <kmo@daterainc.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>, NeilBrown <neilb@suse.de>,
	John Sanpe <sanpeqf@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
	Yury Norov <yury.norov@gmail.com>,
	Kees Cook <keescook@chromium.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	David Gow <davidgow@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Thomas Gleixner <tglx@linutronix.de>,
	"wuqiang.matt" <wuqiang.matt@bytedance.com>,
	Jason Baron <jbaron@akamai.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Danilo Krummrich <dakr@redhat.com>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] lib: move pci_iomap.c to drivers/pci/
Message-ID: <202311212127.jeMnVg3Y-lkp@intel.com>
References: <20231120215945.52027-3-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231120215945.52027-3-pstanner@redhat.com>

Hi Philipp,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.7-rc2 next-202311=
21]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Philipp-Stanner/lib-=
move-pci_iomap-c-to-drivers-pci/20231121-060258
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20231120215945.52027-3-pstanner%40=
redhat.com
patch subject: [PATCH 1/4] lib: move pci_iomap.c to drivers/pci/
config: microblaze-kismet-CONFIG_GENERIC_PCI_IOMAP-CONFIG_MICROBLAZE-0-0 (h=
ttps://download.01.org/0day-ci/archive/20231121/202311212127.jeMnVg3Y-lkp@i=
ntel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20231121/202311212127.j=
eMnVg3Y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311212127.jeMnVg3Y-lkp@i=
ntel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for GENERIC_PCI_IOMA=
P when selected by MICROBLAZE
   /usr/bin/grep: /db/releases/20231121182703/kernel-tests/etc/kcflags: No =
such file or directory
   {"timestamp":"2023-11-21 19:25:22 +0800", "level":"WARN", "event":"kbuil=
d.sh:3942:in `add_etc_kcflags': grep exit 2 (ShellError)", "detail":"cmd: '=
/usr/bin/grep' '-v' '-e' '^#' '-e' '^$' '/db/releases/20231121182703/kernel=
-tests/etc/kcflags' \nstderr: /usr/bin/grep: /db/releases/20231121182703/ke=
rnel-tests/etc/kcflags: No such file or directory\n\n", "hostname":"communi=
ty-kbuild-consumer-171", "host_hostname":"lkp-worker56", "call_stack":"/zda=
y/kernel-tests/lib/kbuild.sh:3942:in `add_etc_kcflags': /usr/bin/grep: /db/=
releases/20231121182703/kernel-tests/etc/kcflags: No such file or directory=
 (ShellError 2)\n  from /zday/kernel-tests/lib/kbuild.sh:3971: setup_kcflag=
s\n  from /zday/kernel-tests/lib/kbuild.sh:4016: invoke_make\n  from /zday/=
kernel-tests/lib/kbuild.sh:4122: make\n  from /zday/kernel-tests/lib/kbuild=
=2Esh:5623: make_config_allyes\n  from /zday/kernel-tests/common.sh:209: re=
direct_error_to_screen\n  from /zday/kernel-tests/common.sh:217: redirect_c=
ommand_errors\n  from /zday/kernel-tests/lib/kbuild.sh:5630: make_config\n =
 from /zday/kernel-tests/lib/builder/kismet.sh:156: generate_make_olddefcon=
fig_warnings\n  from /zday/kernel-tests/lib/builder/kismet.sh:297: builder_=
compile\n  from /zday/kernel-tests/bisect-test-build-error.sh:94: main\n"}
  =20
   WARNING: unmet direct dependencies detected for GENERIC_PCI_IOMAP
     Depends on [n]: PCI [=3Dn]
     Selected by [y]:
     - MICROBLAZE [=3Dy]

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

