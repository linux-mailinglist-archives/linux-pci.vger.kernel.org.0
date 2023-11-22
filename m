Return-Path: <linux-pci+bounces-135-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4760E7F4C56
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 17:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0926281395
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 16:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC64F24B3E;
	Wed, 22 Nov 2023 16:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CHGuVvkM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8612CA2;
	Wed, 22 Nov 2023 08:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700670540; x=1732206540;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bagruS5CXrz6mOWB6COGHqS1jlKmltZBn+nUJ6YlRfc=;
  b=CHGuVvkMltNsrvh0eAqgxIVDewD+WVIdJUZsJ2IkpO5lHrSn4UbwWPBX
   bpxa/Zr5s20kbZw/hu9l381mf/cqIuKZjUNiVUCnsQmTSZejS4TnZBFTQ
   ttIJrTDDZHKtxOQ+V/2lvL1rk2UCPDja4FhSw1qH6s7Ymxkwij4Fh8tBu
   fftWG6kxgIQ4ms/eYgop0ppBYv6nI2xwF7vMoTFevna4yLtkqX/2K49NL
   JonJpMCy3vy4/528RRPcPVxO3HaS5lY+cZ5feuz/TmIM0158y8gG2vKbq
   eeg+oGvdzQkx67EEbg8Ty0K0VmE55njHwi5cGXff8aDrxGR2L/aVmxPqo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="394921013"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="394921013"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 08:28:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="8531683"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 22 Nov 2023 08:28:53 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r5q5r-0000gb-0J;
	Wed, 22 Nov 2023 16:28:51 +0000
Date: Thu, 23 Nov 2023 00:28:40 +0800
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
Message-ID: <202311222251.miLTgMyd-lkp@intel.com>
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
22]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Philipp-Stanner/lib-=
move-pci_iomap-c-to-drivers-pci/20231121-060258
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20231120215945.52027-3-pstanner%40=
redhat.com
patch subject: [PATCH 1/4] lib: move pci_iomap.c to drivers/pci/
config: csky-kismet-CONFIG_GENERIC_PCI_IOMAP-CONFIG_CSKY-0-0 (https://downl=
oad.01.org/0day-ci/archive/20231122/202311222251.miLTgMyd-lkp@intel.com/con=
fig)
reproduce: (https://download.01.org/0day-ci/archive/20231122/202311222251.m=
iLTgMyd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311222251.miLTgMyd-lkp@i=
ntel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for GENERIC_PCI_IOMA=
P when selected by CSKY
   /usr/bin/grep: /db/releases/20231122101355/kernel-tests/etc/kcflags: No =
such file or directory
   {"timestamp":"2023-11-22 12:45:55 +0800", "level":"WARN", "event":"kbuil=
d.sh:3942:in `add_etc_kcflags': grep exit 2 (ShellError)", "detail":"cmd: '=
/usr/bin/grep' '-v' '-e' '^#' '-e' '^$' '/db/releases/20231122101355/kernel=
-tests/etc/kcflags' \nstderr: /usr/bin/grep: /db/releases/20231122101355/ke=
rnel-tests/etc/kcflags: No such file or directory\n\n", "hostname":"communi=
ty-kbuild-consumer-56", "host_hostname":"lkp-worker31", "call_stack":"/zday=
/kernel-tests/lib/kbuild.sh:3942:in `add_etc_kcflags': /usr/bin/grep: /db/r=
eleases/20231122101355/kernel-tests/etc/kcflags: No such file or directory =
(ShellError 2)\n  from /zday/kernel-tests/lib/kbuild.sh:3971: setup_kcflags=
\n  from /zday/kernel-tests/lib/kbuild.sh:4016: invoke_make\n  from /zday/k=
ernel-tests/lib/kbuild.sh:4122: make\n  from /zday/kernel-tests/lib/kbuild.=
sh:5623: make_config_allyes\n  from /zday/kernel-tests/common.sh:209: redir=
ect_error_to_screen\n  from /zday/kernel-tests/common.sh:217: redirect_comm=
and_errors\n  from /zday/kernel-tests/lib/kbuild.sh:5630: make_config\n  fr=
om /zday/kernel-tests/lib/builder/kismet.sh:156: generate_make_olddefconfig=
_warnings\n  from /zday/kernel-tests/lib/builder/kismet.sh:297: builder_com=
pile\n  from /zday/kernel-tests/bisect-test-build-error.sh:94: main\n"}
  =20
   WARNING: unmet direct dependencies detected for GENERIC_PCI_IOMAP
     Depends on [n]: PCI [=3Dn]
     Selected by [y]:
     - CSKY [=3Dy]

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

