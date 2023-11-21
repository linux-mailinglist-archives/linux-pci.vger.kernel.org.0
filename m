Return-Path: <linux-pci+bounces-49-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EAB7F3283
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 16:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B7A51C20A93
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 15:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7834D4A9BB;
	Tue, 21 Nov 2023 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QliQtl2Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C4A11A;
	Tue, 21 Nov 2023 07:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700581278; x=1732117278;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=hp2/itkYHGLatqqut+LfjX0mAXpYpgJyMjjE1s8y8h4=;
  b=QliQtl2Y6WuVOM0q9MGMmcdl2H7TmopyZlS72zqH3prqAfgRzSt5+A5g
   2W9G6VmGbvsvmWgG1q2K5TsjVlq86xd8wxltXC+qN/B4GbleB1ItQx2G9
   0Ksk96TkTT5HdTyc6VdtYvB9xJSk2JzmyHC/TBkLtV3L/+yl9Vdflg3tL
   rCRCYvb1SaKjLdm7KD/JwzPIa3BSQMH2QyMxaiBYpGHPEA7IKNGDqKTZE
   Z0FGyYDElvG0UKHLd8Gw4dqBnFKSLgpUj6Apr+lKX0MI/51Pwaxtb6OiK
   /ElBPdmRe/JrdUMALmohv+CtgBaNxLk+fOhc4ibfObt15nanpWgb0jFMH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="458357690"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="458357690"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 07:41:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="8119408"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 21 Nov 2023 07:41:11 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r5Ss8-0007y0-17;
	Tue, 21 Nov 2023 15:41:08 +0000
Date: Tue, 21 Nov 2023 23:40:24 +0800
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
Message-ID: <202311212322.TOIJ8Pcg-lkp@intel.com>
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
config: parisc-kismet-CONFIG_GENERIC_PCI_IOMAP-CONFIG_PARISC-0-0 (https://d=
ownload.01.org/0day-ci/archive/20231121/202311212322.TOIJ8Pcg-lkp@intel.com=
/config)
reproduce: (https://download.01.org/0day-ci/archive/20231121/202311212322.T=
OIJ8Pcg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311212322.TOIJ8Pcg-lkp@i=
ntel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for GENERIC_PCI_IOMA=
P when selected by PARISC
   /usr/bin/grep: /db/releases/20231121182703/kernel-tests/etc/kcflags: No =
such file or directory
   {"timestamp":"2023-11-21 21:16:41 +0800", "level":"WARN", "event":"kbuil=
d.sh:3942:in `add_etc_kcflags': grep exit 2 (ShellError)", "detail":"cmd: '=
/usr/bin/grep' '-v' '-e' '^#' '-e' '^$' '/db/releases/20231121182703/kernel=
-tests/etc/kcflags' \nstderr: /usr/bin/grep: /db/releases/20231121182703/ke=
rnel-tests/etc/kcflags: No such file or directory\n\n", "hostname":"communi=
ty-kbuild-consumer-161", "host_hostname":"lkp-worker22", "call_stack":"/zda=
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
     - PARISC [=3Dy]

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

