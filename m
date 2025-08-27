Return-Path: <linux-pci+bounces-34865-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5D7B378EE
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 06:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 870F2161E59
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 04:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E8822333B;
	Wed, 27 Aug 2025 04:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="njwAZa/R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20B81E5201
	for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 04:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756267270; cv=none; b=MmHLgzq1KJnuTp8i4+Empbf6WfdAItv1bv4ezvd9BXVcg/XHwc1Tm1UnAXZ456AirdFEYGfY+u3gl6ra+MVXDz9WJ3HWSpGzPvDsUZ+gUtkGurjpwh1h3ymmnWqdwUc7ov1eFp/3tLgS0hf+5lOdzijKDF+sSZnjjBEuOVDhhkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756267270; c=relaxed/simple;
	bh=QVZUnBo6S/jr5oYJAZZGMDSYWFQ5Xa6spw2g+AgNIlw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Gnukw2IdIfJYOqbLh7CF3C1JDguXuGsbquTHhJBns1gN7tzh09eBZVesTOr9IdU1FWJnA42RIrG7eR4ug6oBFwn7pQ5aWsjFckBTvAaliOUCGxfQo5l0PesP5w3a+rSkboYecL5QnBH+Mwh1G8kFALPja/GGH8qYDNtghvVWDWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=njwAZa/R; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756267269; x=1787803269;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=QVZUnBo6S/jr5oYJAZZGMDSYWFQ5Xa6spw2g+AgNIlw=;
  b=njwAZa/RQG/D17eF/9eVjdYqucJyviPE0tdbvImmCtW3bJcXAzjFO+2U
   8Zar4pOsyXKMZvFZErdPQDovbPvNudnIP3ejErwVwIFyfSpNQIPBxH15a
   SvN76bz3uNHIqHrMJIGMrjAeH6zAZ8Xi1cK7Tho3NAMpf9pmrM6G6mElH
   qC0ilqqaiKGGrelzqU+pWNTLOD8Nm17EMkp2ZJ2DzVr8o0pbNmLc9+lDW
   4A60TrEbsZqZn5dzSpRXxNg+SX+hCE4pXKzIpDh2YrCG3P+1or7leP+RA
   1dRT/ZAOAYtjMryrNhbop28iJrDEqRI8lArsW1bYsRVPL6ZUTPAmSJEnB
   Q==;
X-CSE-ConnectionGUID: 8t/FQDiOQd+0Z+4/ooqjeA==
X-CSE-MsgGUID: 4rW8+o2tT1aujd9MDFRqaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="62330021"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="62330021"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 21:01:08 -0700
X-CSE-ConnectionGUID: iotR0nxLSKGLxJ3Ahh1kJQ==
X-CSE-MsgGUID: wiQEy1v2RfaRTmwjg0IKBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169652730"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 26 Aug 2025 21:01:06 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ur7K6-000SeR-10;
	Wed, 27 Aug 2025 04:00:14 +0000
Date: Wed, 27 Aug 2025 11:59:32 +0800
From: kernel test robot <lkp@intel.com>
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Subject: [pci:wip/2508-david-aspm-api 1/2] drivers/firewire/ohci.c:745:36:
 warning: implicit conversion from 'unsigned long' to '__u16' (aka 'unsigned
 short') changes value from 65536 to 0
Message-ID: <202508271142.h1iibk0C-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git wip/2508-david-aspm-api
head:   a373462082599403e030c605ff260fd45429fe66
commit: 5ea26ba40d978b9f34faec2ca92c60e6d9db11c5 [1/2] PCI/ASPM: Add pci_host_set_default_pcie_link_state()
config: arm64-randconfig-003-20250827 (https://download.01.org/0day-ci/archive/20250827/202508271142.h1iibk0C-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project d26ea02060b1c9db751d188b2edb0059a9eb273d)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250827/202508271142.h1iibk0C-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508271142.h1iibk0C-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/ftrace.h:23:
   In file included from arch/arm64/include/asm/ftrace.h:41:
   include/linux/compat.h:454:10: warning: array index 7 is past the end of the array (that has type 'compat_sigset_word[2]' (aka 'unsigned int[2]')) [-Warray-bounds]
     454 |         case 4: v.sig[7] = (set->sig[3] >> 32); v.sig[6] = set->sig[3];
         |                 ^     ~
   include/linux/compat.h:130:2: note: array 'sig' declared here
     130 |         compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
         |         ^
   include/linux/compat.h:454:42: warning: array index 6 is past the end of the array (that has type 'compat_sigset_word[2]' (aka 'unsigned int[2]')) [-Warray-bounds]
     454 |         case 4: v.sig[7] = (set->sig[3] >> 32); v.sig[6] = set->sig[3];
         |                                                 ^     ~
   include/linux/compat.h:130:2: note: array 'sig' declared here
     130 |         compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
         |         ^
   include/linux/compat.h:454:53: warning: array index 3 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     454 |         case 4: v.sig[7] = (set->sig[3] >> 32); v.sig[6] = set->sig[3];
         |                                                            ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/firewire/ohci.c:51:
   In file included from include/trace/events/firewire_ohci.h:101:
   In file included from include/trace/define_trace.h:132:
   In file included from include/trace/trace_events.h:21:
   In file included from include/linux/trace_events.h:10:
   In file included from include/linux/perf_event.h:43:
   In file included from include/linux/ftrace.h:23:
   In file included from arch/arm64/include/asm/ftrace.h:41:
   include/linux/compat.h:456:22: warning: array index 2 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     456 |         case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
         |                             ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/firewire/ohci.c:51:
   In file included from include/trace/events/firewire_ohci.h:101:
   In file included from include/trace/define_trace.h:132:
   In file included from include/trace/trace_events.h:21:
   In file included from include/linux/trace_events.h:10:
   In file included from include/linux/perf_event.h:43:
   In file included from include/linux/ftrace.h:23:
   In file included from arch/arm64/include/asm/ftrace.h:41:
   include/linux/compat.h:456:10: warning: array index 5 is past the end of the array (that has type 'compat_sigset_word[2]' (aka 'unsigned int[2]')) [-Warray-bounds]
     456 |         case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
         |                 ^     ~
   include/linux/compat.h:130:2: note: array 'sig' declared here
     130 |         compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
         |         ^
   include/linux/compat.h:456:42: warning: array index 4 is past the end of the array (that has type 'compat_sigset_word[2]' (aka 'unsigned int[2]')) [-Warray-bounds]
     456 |         case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
         |                                                 ^     ~
   include/linux/compat.h:130:2: note: array 'sig' declared here
     130 |         compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
         |         ^
   include/linux/compat.h:456:53: warning: array index 2 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     456 |         case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
         |                                                            ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/firewire/ohci.c:51:
   In file included from include/trace/events/firewire_ohci.h:101:
   In file included from include/trace/define_trace.h:132:
   In file included from include/trace/trace_events.h:21:
   In file included from include/linux/trace_events.h:10:
   In file included from include/linux/perf_event.h:43:
   In file included from include/linux/ftrace.h:23:
   In file included from arch/arm64/include/asm/ftrace.h:41:
   include/linux/compat.h:458:22: warning: array index 1 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     458 |         case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
         |                             ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/firewire/ohci.c:51:
   In file included from include/trace/events/firewire_ohci.h:101:
   In file included from include/trace/define_trace.h:132:
   In file included from include/trace/trace_events.h:21:
   In file included from include/linux/trace_events.h:10:
   In file included from include/linux/perf_event.h:43:
   In file included from include/linux/ftrace.h:23:
   In file included from arch/arm64/include/asm/ftrace.h:41:
   include/linux/compat.h:458:10: warning: array index 3 is past the end of the array (that has type 'compat_sigset_word[2]' (aka 'unsigned int[2]')) [-Warray-bounds]
     458 |         case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
         |                 ^     ~
   include/linux/compat.h:130:2: note: array 'sig' declared here
     130 |         compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
         |         ^
   include/linux/compat.h:458:42: warning: array index 2 is past the end of the array (that has type 'compat_sigset_word[2]' (aka 'unsigned int[2]')) [-Warray-bounds]
     458 |         case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
         |                                                 ^     ~
   include/linux/compat.h:130:2: note: array 'sig' declared here
     130 |         compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
         |         ^
   include/linux/compat.h:458:53: warning: array index 1 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     458 |         case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
         |                                                            ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
>> drivers/firewire/ohci.c:745:36: warning: implicit conversion from 'unsigned long' to '__u16' (aka 'unsigned short') changes value from 65536 to 0 [-Wconstant-conversion]
     745 |         d->res_count       =  cpu_to_le16(PAGE_SIZE);
         |                               ~~~~~~~~~~~~^~~~~~~~~~
   include/vdso/page.h:15:30: note: expanded from macro 'PAGE_SIZE'
      15 | #define PAGE_SIZE       (_AC(1,UL) << CONFIG_PAGE_SHIFT)
         |                                    ^
   include/uapi/linux/byteorder/big_endian.h:36:53: note: expanded from macro '__cpu_to_le16'
      36 | #define __cpu_to_le16(x) ((__force __le16)__swab16((x)))
         |                                           ~~~~~~~~~~^~~
   include/uapi/linux/swab.h:107:12: note: expanded from macro '__swab16'
     107 |         __fswab16(x))
         |         ~~~~~~~~~ ^
   drivers/firewire/ohci.c:821:37: warning: implicit conversion from 'unsigned long' to '__u16' (aka 'unsigned short') changes value from 65536 to 0 [-Wconstant-conversion]
     821 |                 if (next_res_count == cpu_to_le16(PAGE_SIZE)) {
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
   include/vdso/page.h:15:30: note: expanded from macro 'PAGE_SIZE'
      15 | #define PAGE_SIZE       (_AC(1,UL) << CONFIG_PAGE_SHIFT)
         |                                    ^
   include/uapi/linux/byteorder/big_endian.h:36:53: note: expanded from macro '__cpu_to_le16'
      36 | #define __cpu_to_le16(x) ((__force __le16)__swab16((x)))
         |                                           ~~~~~~~~~~^~~
   include/uapi/linux/swab.h:107:12: note: expanded from macro '__swab16'
     107 |         __fswab16(x))
         |         ~~~~~~~~~ ^
   include/linux/compiler.h:55:47: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:57:86: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                                     ~~~~~~~~~~~~~~~~~^~~~~
   include/linux/compiler.h:68:3: note: expanded from macro '__trace_if_value'
      68 |         (cond) ?                                        \
         |          ^~~~
   drivers/firewire/ohci.c:821:37: warning: implicit conversion from 'unsigned long' to '__u16' (aka 'unsigned short') changes value from 65536 to 0 [-Wconstant-conversion]
     821 |                 if (next_res_count == cpu_to_le16(PAGE_SIZE)) {
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
   include/vdso/page.h:15:30: note: expanded from macro 'PAGE_SIZE'
      15 | #define PAGE_SIZE       (_AC(1,UL) << CONFIG_PAGE_SHIFT)
         |                                    ^
   include/uapi/linux/byteorder/big_endian.h:36:53: note: expanded from macro '__cpu_to_le16'
      36 | #define __cpu_to_le16(x) ((__force __le16)__swab16((x)))
         |                                           ~~~~~~~~~~^~~
   include/uapi/linux/swab.h:107:12: note: expanded from macro '__swab16'
     107 |         __fswab16(x))
         |         ~~~~~~~~~ ^
   include/linux/compiler.h:55:47: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:57:52: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   drivers/firewire/ohci.c:821:37: warning: implicit conversion from 'unsigned long' to '__u16' (aka 'unsigned short') changes value from 65536 to 0 [-Wconstant-conversion]
     821 |                 if (next_res_count == cpu_to_le16(PAGE_SIZE)) {
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
   include/vdso/page.h:15:30: note: expanded from macro 'PAGE_SIZE'
      15 | #define PAGE_SIZE       (_AC(1,UL) << CONFIG_PAGE_SHIFT)
         |                                    ^
   include/uapi/linux/byteorder/big_endian.h:36:53: note: expanded from macro '__cpu_to_le16'
      36 | #define __cpu_to_le16(x) ((__force __le16)__swab16((x)))
         |                                           ~~~~~~~~~~^~~
   include/uapi/linux/swab.h:107:12: note: expanded from macro '__swab16'
     107 |         __fswab16(x))
         |         ~~~~~~~~~ ^
   include/linux/compiler.h:55:47: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:57:61: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                             ^~~~
   drivers/firewire/ohci.c:833:39: warning: implicit conversion from 'unsigned long' to '__u16' (aka 'unsigned short') changes value from 65536 to 0 [-Wconstant-conversion]
     833 |                                 if (next_res_count != cpu_to_le16(PAGE_SIZE))
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
   include/vdso/page.h:15:30: note: expanded from macro 'PAGE_SIZE'
      15 | #define PAGE_SIZE       (_AC(1,UL) << CONFIG_PAGE_SHIFT)
         |                                    ^
   include/uapi/linux/byteorder/big_endian.h:36:53: note: expanded from macro '__cpu_to_le16'
      36 | #define __cpu_to_le16(x) ((__force __le16)__swab16((x)))
         |                                           ~~~~~~~~~~^~~
   include/uapi/linux/swab.h:107:12: note: expanded from macro '__swab16'
     107 |         __fswab16(x))
         |         ~~~~~~~~~ ^
   include/linux/compiler.h:55:47: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:57:86: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                                     ~~~~~~~~~~~~~~~~~^~~~~
   include/linux/compiler.h:68:3: note: expanded from macro '__trace_if_value'
      68 |         (cond) ?                                        \
         |          ^~~~
   drivers/firewire/ohci.c:833:39: warning: implicit conversion from 'unsigned long' to '__u16' (aka 'unsigned short') changes value from 65536 to 0 [-Wconstant-conversion]
     833 |                                 if (next_res_count != cpu_to_le16(PAGE_SIZE))
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
   include/vdso/page.h:15:30: note: expanded from macro 'PAGE_SIZE'
      15 | #define PAGE_SIZE       (_AC(1,UL) << CONFIG_PAGE_SHIFT)
         |                                    ^
   include/uapi/linux/byteorder/big_endian.h:36:53: note: expanded from macro '__cpu_to_le16'
      36 | #define __cpu_to_le16(x) ((__force __le16)__swab16((x)))
         |                                           ~~~~~~~~~~^~~
   include/uapi/linux/swab.h:107:12: note: expanded from macro '__swab16'
     107 |         __fswab16(x))


vim +745 drivers/firewire/ohci.c

32b46093a07698 drivers/firewire/fw-ohci.c Kristian Høgsberg 2007-02-06  738  
7a39d8b8216546 drivers/firewire/ohci.c    Clemens Ladisch   2010-11-26  739  static void ar_context_link_page(struct ar_context *ctx, unsigned int index)
7a39d8b8216546 drivers/firewire/ohci.c    Clemens Ladisch   2010-11-26  740  {
7a39d8b8216546 drivers/firewire/ohci.c    Clemens Ladisch   2010-11-26  741  	struct descriptor *d;
7a39d8b8216546 drivers/firewire/ohci.c    Clemens Ladisch   2010-11-26  742  
7a39d8b8216546 drivers/firewire/ohci.c    Clemens Ladisch   2010-11-26  743  	d = &ctx->descriptors[index];
7a39d8b8216546 drivers/firewire/ohci.c    Clemens Ladisch   2010-11-26  744  	d->branch_address  &= cpu_to_le32(~0xf);
7a39d8b8216546 drivers/firewire/ohci.c    Clemens Ladisch   2010-11-26 @745  	d->res_count       =  cpu_to_le16(PAGE_SIZE);
7a39d8b8216546 drivers/firewire/ohci.c    Clemens Ladisch   2010-11-26  746  	d->transfer_status =  0;
32b46093a07698 drivers/firewire/fw-ohci.c Kristian Høgsberg 2007-02-06  747  
071595ebdc66d7 drivers/firewire/ohci.c    Stefan Richter    2010-07-27  748  	wmb(); /* finish init of new descriptors before branch_address update */
7a39d8b8216546 drivers/firewire/ohci.c    Clemens Ladisch   2010-11-26  749  	d = &ctx->descriptors[ctx->last_buffer_index];
7a39d8b8216546 drivers/firewire/ohci.c    Clemens Ladisch   2010-11-26  750  	d->branch_address  |= cpu_to_le32(1);
7a39d8b8216546 drivers/firewire/ohci.c    Clemens Ladisch   2010-11-26  751  
7a39d8b8216546 drivers/firewire/ohci.c    Clemens Ladisch   2010-11-26  752  	ctx->last_buffer_index = index;
32b46093a07698 drivers/firewire/fw-ohci.c Kristian Høgsberg 2007-02-06  753  
a77754a75d58d5 drivers/firewire/fw-ohci.c Kristian Høgsberg 2007-05-07  754  	reg_write(ctx->ohci, CONTROL_SET(ctx->regs), CONTEXT_WAKE);
837596a61ba8f9 drivers/firewire/ohci.c    Clemens Ladisch   2010-10-25  755  }
837596a61ba8f9 drivers/firewire/ohci.c    Clemens Ladisch   2010-10-25  756  

:::::: The code at line 745 was first introduced by commit
:::::: 7a39d8b82165462729d09066bddb395a19025acd firewire: ohci: Asynchronous Reception rewrite

:::::: TO: Clemens Ladisch <clemens@ladisch.de>
:::::: CC: Stefan Richter <stefanr@s5r6.in-berlin.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

