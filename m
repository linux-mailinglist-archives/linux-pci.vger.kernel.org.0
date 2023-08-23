Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30284784E0A
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 03:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjHWBOJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Aug 2023 21:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjHWBOI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Aug 2023 21:14:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A983CFF;
        Tue, 22 Aug 2023 18:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692753244; x=1724289244;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jm1ra//8f5527jBp/8HajCRW0Hof2wYISb78/ix82+w=;
  b=NUbnsar3zKbA2jqzGSAC4lo+Ylb4CbxWdw8N9uEuXPgOf9vO5uUXKw9K
   8fua7c9HyMnQjrk5+L0BMN57sCna7bUiicv0w53wFfcNa5OT+oqOSeUQK
   bTJHRW5gluqEGq2ZqrsYnHKbqNGZXQSSMqOejwMkz17daLP183VauBHlv
   OMwC4htkcaVolspWTmQZtImuCokTEou47bF6hmvRgiruLVgTvHdtFdlqB
   AphYRsk8IBmcx+GIdi+PQIiTfkkfhDiqH9jk3o3EDMLvEyGjjl4YgONxh
   HgnJI1umydu7+7+vk/RBJ9f0LwCXe4zebgD9TkLio0k6NhOBHWZKM2CAY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="372920731"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="372920731"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 18:14:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="765944260"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="765944260"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 22 Aug 2023 18:13:58 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYcRZ-0000gO-1A;
        Wed, 23 Aug 2023 01:13:57 +0000
Date:   Wed, 23 Aug 2023 09:13:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        manivannan.sadhasivam@linaro.org
Cc:     oe-kbuild-all@lists.linux.dev, helgaas@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, quic_parass@quicinc.com,
        krzysztof.kozlowski@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "(open list:OPERATING PERFORMANCE POINTS (OPP))" 
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] OPP: Add api to retrieve opps which is at most
 the provided level
Message-ID: <202308230954.jyXY61U7-lkp@intel.com>
References: <1692717141-32743-4-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1692717141-32743-4-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krishna,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/for-linus]
[also build test ERROR on robh/for-next rafael-pm/linux-next linus/master v6.5-rc7 next-20230822]
[cannot apply to pci/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-chaitanya-chundru/dt-bindings-pci-qcom-Add-opp-table/20230822-232104
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
patch link:    https://lore.kernel.org/r/1692717141-32743-4-git-send-email-quic_krichai%40quicinc.com
patch subject: [PATCH v4 3/4] OPP: Add api to retrieve opps which is at most the provided level
config: arc-allnoconfig (https://download.01.org/0day-ci/archive/20230823/202308230954.jyXY61U7-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230823/202308230954.jyXY61U7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308230954.jyXY61U7-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

     263 | {
         | ^
   include/linux/signal.h:268:13: error: storage class specified for parameter 'flush_sigqueue'
     268 | extern void flush_sigqueue(struct sigpending *queue);
         |             ^~~~~~~~~~~~~~
   include/linux/signal.h:272:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     272 | {
         | ^
   include/linux/signal.h:276:1: warning: empty declaration
     276 | struct timespec;
         | ^~~~~~
   include/linux/signal.h:277:1: warning: empty declaration
     277 | struct pt_regs;
         | ^~~~~~
   include/linux/signal.h:278:1: warning: empty declaration
     278 | enum pid_type;
         | ^~~~
   include/linux/signal.h:280:12: error: storage class specified for parameter 'next_signal'
     280 | extern int next_signal(struct sigpending *pending, sigset_t *mask);
         |            ^~~~~~~~~~~
   include/linux/signal.h:281:12: error: storage class specified for parameter 'do_send_sig_info'
     281 | extern int do_send_sig_info(int sig, struct kernel_siginfo *info,
         |            ^~~~~~~~~~~~~~~~
   include/linux/signal.h:283:12: error: storage class specified for parameter 'group_send_sig_info'
     283 | extern int group_send_sig_info(int sig, struct kernel_siginfo *info,
         |            ^~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:285:12: error: storage class specified for parameter 'send_signal_locked'
     285 | extern int send_signal_locked(int sig, struct kernel_siginfo *info,
         |            ^~~~~~~~~~~~~~~~~~
   include/linux/signal.h:287:12: error: storage class specified for parameter 'sigprocmask'
     287 | extern int sigprocmask(int, sigset_t *, sigset_t *);
         |            ^~~~~~~~~~~
   include/linux/signal.h:288:13: error: storage class specified for parameter 'set_current_blocked'
     288 | extern void set_current_blocked(sigset_t *);
         |             ^~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:289:13: error: storage class specified for parameter '__set_current_blocked'
     289 | extern void __set_current_blocked(const sigset_t *);
         |             ^~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:290:12: error: storage class specified for parameter 'show_unhandled_signals'
     290 | extern int show_unhandled_signals;
         |            ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:292:13: error: storage class specified for parameter 'get_signal'
     292 | extern bool get_signal(struct ksignal *ksig);
         |             ^~~~~~~~~~
   include/linux/signal.h:293:13: error: storage class specified for parameter 'signal_setup_done'
     293 | extern void signal_setup_done(int failed, struct ksignal *ksig, int stepping);
         |             ^~~~~~~~~~~~~~~~~
   include/linux/signal.h:294:13: error: storage class specified for parameter 'exit_signals'
     294 | extern void exit_signals(struct task_struct *tsk);
         |             ^~~~~~~~~~~~
   include/linux/signal.h:295:13: error: storage class specified for parameter 'kernel_sigaction'
     295 | extern void kernel_sigaction(int, __sighandler_t);
         |             ^~~~~~~~~~~~~~~~
   include/linux/signal.h:301:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     301 | {
         | ^
   include/linux/signal.h:311:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     311 | {
         | ^
   include/linux/signal.h:321:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     321 | {
         | ^
   include/linux/signal.h:325:27: error: storage class specified for parameter 'sighand_cachep'
     325 | extern struct kmem_cache *sighand_cachep;
         |                           ^~~~~~~~~~~~~~
   include/linux/signal.h:327:13: error: storage class specified for parameter 'unhandled_signal'
     327 | extern bool unhandled_signal(struct task_struct *tsk, int sig);
         |             ^~~~~~~~~~~~~~~~
   include/linux/signal.h:470:56: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     470 | static inline bool sigaltstack_size_valid(size_t size) { return true; }
         |                                                        ^
   include/linux/signal.h:474:1: warning: empty declaration
     474 | struct seq_file;
         | ^~~~~~
   include/linux/signal.h:475:13: error: storage class specified for parameter 'render_sigset_t'
     475 | extern void render_sigset_t(struct seq_file *, const char *, sigset_t *);
         |             ^~~~~~~~~~~~~~~
   include/linux/signal.h:487:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     487 | {
         | ^
   In file included from include/linux/sched/signal.h:8:
   include/linux/sched/jobctl.h:7:1: warning: empty declaration
       7 | struct task_struct;
         | ^~~~~~
   include/linux/sched/jobctl.h:43:13: error: storage class specified for parameter 'task_set_jobctl_pending'
      43 | extern bool task_set_jobctl_pending(struct task_struct *task, unsigned long mask);
         |             ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/sched/jobctl.h:44:13: error: storage class specified for parameter 'task_clear_jobctl_trapping'
      44 | extern void task_clear_jobctl_trapping(struct task_struct *task);
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/sched/jobctl.h:45:13: error: storage class specified for parameter 'task_clear_jobctl_pending'
      45 | extern void task_clear_jobctl_pending(struct task_struct *task, unsigned long mask);
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/uaccess.h:5,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9:
   include/linux/fault-inject-usercopy.h:18:47: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      18 | static inline bool should_fail_usercopy(void) { return false; }
         |                                               ^
   In file included from include/linux/uaccess.h:11:
>> arch/arc/include/asm/uaccess.h:140:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     140 | {
         | ^
   arch/arc/include/asm/uaccess.h:367:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     367 | {
         | ^
   arch/arc/include/asm/uaccess.h:588:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     588 | {
         | ^
   In file included from include/asm-generic/uaccess.h:11,
                    from arch/arc/include/asm/uaccess.h:641:
   include/asm-generic/access_ok.h:32:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      32 | {
         | ^
   include/asm-generic/uaccess.h:144:12: error: storage class specified for parameter '__put_user_bad'
     144 | extern int __put_user_bad(void) __attribute__((noreturn));
         |            ^~~~~~~~~~~~~~
   include/asm-generic/uaccess.h:205:12: error: storage class specified for parameter '__get_user_bad'
     205 | extern int __get_user_bad(void) __attribute__((noreturn));
         |            ^~~~~~~~~~~~~~
   include/asm-generic/uaccess.h:221:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     221 | {
         | ^
   In file included from ./arch/arc/include/generated/asm/extable.h:1,
                    from include/asm-generic/uaccess.h:229:
   include/asm-generic/extable.h:18:1: warning: empty declaration
      18 | struct exception_table_entry
         | ^~~~~~
   include/asm-generic/extable.h:24:1: warning: empty declaration
      24 | struct pt_regs;
         | ^~~~~~
   include/asm-generic/extable.h:25:12: error: storage class specified for parameter 'fixup_exception'
      25 | extern int fixup_exception(struct pt_regs *regs);
         |            ^~~~~~~~~~~~~~~
   In file included from include/linux/compiler_types.h:80,
                    from <command-line>:
   include/linux/compiler_attributes.h:356:41: error: expected declaration specifiers before '__attribute__'
     356 | #define __must_check                    __attribute__((__warn_unused_result__))
         |                                         ^~~~~~~~~~~~~
   include/asm-generic/uaccess.h:231:1: note: in expansion of macro '__must_check'
     231 | __must_check long strncpy_from_user(char *dst, const char __user *src,
         | ^~~~~~~~~~~~
   include/linux/compiler_attributes.h:356:41: error: expected declaration specifiers before '__attribute__'
     356 | #define __must_check                    __attribute__((__warn_unused_result__))
         |                                         ^~~~~~~~~~~~~
   include/asm-generic/uaccess.h:233:1: note: in expansion of macro '__must_check'
     233 | __must_check long strnlen_user(const char __user *src, long n);
         | ^~~~~~~~~~~~
   include/linux/uaccess.h:82:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      82 | {
         | ^
   include/linux/uaccess.h:94:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      94 | {
         | ^
   include/linux/uaccess.h:122:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     122 | {
         | ^
   include/linux/uaccess.h:132:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     132 | {
         | ^
   include/linux/uaccess.h:144:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     144 | {
         | ^
   include/linux/uaccess.h:164:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     164 | {
         | ^
   include/linux/uaccess.h:181:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     181 | {
         | ^
   include/linux/uaccess.h:189:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     189 | {
         | ^
   include/linux/uaccess.h:202:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     202 | {
         | ^
   include/linux/uaccess.h:209:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     209 | {
         | ^
   include/linux/uaccess.h:214:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     214 | {
         | ^
   include/linux/uaccess.h:226:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     226 | {
         | ^
   include/linux/uaccess.h:236:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     236 | {
         | ^
   include/linux/uaccess.h:249:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     249 | {
         | ^
   include/linux/uaccess.h:281:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     281 | {
         | ^
   include/linux/uaccess.h:292:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     292 | {
         | ^
   include/linux/uaccess.h:298:25: error: storage class specified for parameter 'check_zeroed_user'
     298 | extern __must_check int check_zeroed_user(const void __user *from, size_t size);
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/uaccess.h:350:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     350 | {
--
   include/linux/page_ref.h:262:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     262 | {
         | ^
   include/linux/page_ref.h:267:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     267 | {
         | ^
   include/linux/page_ref.h:312:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     312 | {
         | ^
   include/linux/page_ref.h:317:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     317 | {
         | ^
   include/linux/page_ref.h:326:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     326 | {
         | ^
   include/linux/page_ref.h:331:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     331 | {
         | ^
   include/linux/page_ref.h:341:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     341 | {
         | ^
   In file included from include/asm-generic/pgtable-nopud.h:7,
                    from include/asm-generic/pgtable-nopmd.h:7,
                    from arch/arc/include/asm/pgtable-levels.h:95,
                    from arch/arc/include/asm/pgtable.h:11,
                    from include/linux/pgtable.h:6,
                    from include/linux/mm.h:29:
   include/asm-generic/pgtable-nop4d.h:9:31: error: storage class specified for parameter 'p4d_t'
       9 | typedef struct { pgd_t pgd; } p4d_t;
         |                               ^~~~~
   include/asm-generic/pgtable-nop4d.h:21:49: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      21 | static inline int pgd_none(pgd_t pgd)           { return 0; }
         |                                                 ^
   include/asm-generic/pgtable-nop4d.h:22:49: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      22 | static inline int pgd_bad(pgd_t pgd)            { return 0; }
         |                                                 ^
   include/asm-generic/pgtable-nop4d.h:23:49: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      23 | static inline int pgd_present(pgd_t pgd)        { return 1; }
         |                                                 ^
   include/asm-generic/pgtable-nop4d.h:24:49: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      24 | static inline void pgd_clear(pgd_t *pgd)        { }
         |                                                 ^
   include/asm-generic/pgtable-nop4d.h:35:21: error: expected '=', ',', ';', 'asm' or '__attribute__' before '*' token
      35 | static inline p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)
         |                     ^
   include/asm-generic/pgtable-nopud.h:16:18: error: expected specifier-qualifier-list before 'p4d_t'
      16 | typedef struct { p4d_t p4d; } pud_t;
         |                  ^~~~~
   include/asm-generic/pgtable-nopud.h:16:31: error: storage class specified for parameter 'pud_t'
      16 | typedef struct { p4d_t p4d; } pud_t;
         |                               ^~~~~
   include/asm-generic/pgtable-nopud.h:28:28: error: expected declaration specifiers or '...' before 'p4d_t'
      28 | static inline int p4d_none(p4d_t p4d)           { return 0; }
         |                            ^~~~~
   include/asm-generic/pgtable-nopud.h:29:27: error: expected declaration specifiers or '...' before 'p4d_t'
      29 | static inline int p4d_bad(p4d_t p4d)            { return 0; }
         |                           ^~~~~
   include/asm-generic/pgtable-nopud.h:30:31: error: expected declaration specifiers or '...' before 'p4d_t'
      30 | static inline int p4d_present(p4d_t p4d)        { return 1; }
         |                               ^~~~~
   include/asm-generic/pgtable-nopud.h:31:30: error: expected declaration specifiers or '...' before 'p4d_t'
      31 | static inline void p4d_clear(p4d_t *p4d)        { }
         |                              ^~~~~
   include/asm-generic/pgtable-nopud.h:42:21: error: expected '=', ',', ';', 'asm' or '__attribute__' before '*' token
      42 | static inline pud_t *pud_offset(p4d_t *p4d, unsigned long address)
         |                     ^
   include/asm-generic/pgtable-nopmd.h:9:1: warning: empty declaration
       9 | struct mm_struct;
         | ^~~~~~
   include/asm-generic/pgtable-nopmd.h:18:18: error: expected specifier-qualifier-list before 'pud_t'
      18 | typedef struct { pud_t pud; } pmd_t;
         |                  ^~~~~
   include/asm-generic/pgtable-nopmd.h:18:31: error: storage class specified for parameter 'pmd_t'
      18 | typedef struct { pud_t pud; } pmd_t;
         |                               ^~~~~
   include/asm-generic/pgtable-nopmd.h:30:28: error: expected declaration specifiers or '...' before 'pud_t'
      30 | static inline int pud_none(pud_t pud)           { return 0; }
         |                            ^~~~~
   include/asm-generic/pgtable-nopmd.h:31:27: error: expected declaration specifiers or '...' before 'pud_t'
      31 | static inline int pud_bad(pud_t pud)            { return 0; }
         |                           ^~~~~
   include/asm-generic/pgtable-nopmd.h:32:31: error: expected declaration specifiers or '...' before 'pud_t'
      32 | static inline int pud_present(pud_t pud)        { return 1; }
         |                               ^~~~~
   include/asm-generic/pgtable-nopmd.h:33:28: error: expected declaration specifiers or '...' before 'pud_t'
      33 | static inline int pud_user(pud_t pud)           { return 0; }
         |                            ^~~~~
   include/asm-generic/pgtable-nopmd.h:34:28: error: expected declaration specifiers or '...' before 'pud_t'
      34 | static inline int pud_leaf(pud_t pud)           { return 0; }
         |                            ^~~~~
   include/asm-generic/pgtable-nopmd.h:35:30: error: expected declaration specifiers or '...' before 'pud_t'
      35 | static inline void pud_clear(pud_t *pud)        { }
         |                              ^~~~~
   include/asm-generic/pgtable-nopmd.h:46:21: error: expected '=', ',', ';', 'asm' or '__attribute__' before '*' token
      46 | static inline pmd_t * pmd_offset(pud_t * pud, unsigned long address)
         |                     ^
   include/asm-generic/pgtable-nopmd.h:63:51: error: expected declaration specifiers or '...' before 'pmd_t'
      63 | static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
         |                                                   ^~~~~
   In file included from arch/arc/include/asm/pgtable.h:12:
>> arch/arc/include/asm/pgtable-bits-arcv2.h:86:49: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      86 |         static inline pte_t pte_##fn(pte_t pte) { pte_val(pte) op; return pte; }
         |                                                 ^
   arch/arc/include/asm/pgtable-bits-arcv2.h:88:1: note: in expansion of macro 'PTE_BIT_FUNC'
      88 | PTE_BIT_FUNC(mknotpresent,     &= ~(_PAGE_PRESENT));
         | ^~~~~~~~~~~~
>> arch/arc/include/asm/pgtable-bits-arcv2.h:88:52: error: expected declaration specifiers before ';' token
      88 | PTE_BIT_FUNC(mknotpresent,     &= ~(_PAGE_PRESENT));
         |                                                    ^
>> arch/arc/include/asm/pgtable-bits-arcv2.h:86:49: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      86 |         static inline pte_t pte_##fn(pte_t pte) { pte_val(pte) op; return pte; }
         |                                                 ^
   arch/arc/include/asm/pgtable-bits-arcv2.h:89:1: note: in expansion of macro 'PTE_BIT_FUNC'
      89 | PTE_BIT_FUNC(wrprotect, &= ~(_PAGE_WRITE));
         | ^~~~~~~~~~~~
   arch/arc/include/asm/pgtable-bits-arcv2.h:89:43: error: expected declaration specifiers before ';' token
      89 | PTE_BIT_FUNC(wrprotect, &= ~(_PAGE_WRITE));
         |                                           ^
>> arch/arc/include/asm/pgtable-bits-arcv2.h:86:49: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      86 |         static inline pte_t pte_##fn(pte_t pte) { pte_val(pte) op; return pte; }
         |                                                 ^
   arch/arc/include/asm/pgtable-bits-arcv2.h:90:1: note: in expansion of macro 'PTE_BIT_FUNC'
      90 | PTE_BIT_FUNC(mkwrite,   |= (_PAGE_WRITE));
         | ^~~~~~~~~~~~
   arch/arc/include/asm/pgtable-bits-arcv2.h:90:42: error: expected declaration specifiers before ';' token
      90 | PTE_BIT_FUNC(mkwrite,   |= (_PAGE_WRITE));
         |                                          ^
>> arch/arc/include/asm/pgtable-bits-arcv2.h:86:49: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      86 |         static inline pte_t pte_##fn(pte_t pte) { pte_val(pte) op; return pte; }
         |                                                 ^
   arch/arc/include/asm/pgtable-bits-arcv2.h:91:1: note: in expansion of macro 'PTE_BIT_FUNC'
      91 | PTE_BIT_FUNC(mkclean,   &= ~(_PAGE_DIRTY));
         | ^~~~~~~~~~~~
   arch/arc/include/asm/pgtable-bits-arcv2.h:91:43: error: expected declaration specifiers before ';' token
      91 | PTE_BIT_FUNC(mkclean,   &= ~(_PAGE_DIRTY));
         |                                           ^
>> arch/arc/include/asm/pgtable-bits-arcv2.h:86:49: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      86 |         static inline pte_t pte_##fn(pte_t pte) { pte_val(pte) op; return pte; }
         |                                                 ^
   arch/arc/include/asm/pgtable-bits-arcv2.h:92:1: note: in expansion of macro 'PTE_BIT_FUNC'
      92 | PTE_BIT_FUNC(mkdirty,   |= (_PAGE_DIRTY));
         | ^~~~~~~~~~~~
   arch/arc/include/asm/pgtable-bits-arcv2.h:92:42: error: expected declaration specifiers before ';' token
      92 | PTE_BIT_FUNC(mkdirty,   |= (_PAGE_DIRTY));
         |                                          ^
>> arch/arc/include/asm/pgtable-bits-arcv2.h:86:49: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      86 |         static inline pte_t pte_##fn(pte_t pte) { pte_val(pte) op; return pte; }
         |                                                 ^
   arch/arc/include/asm/pgtable-bits-arcv2.h:93:1: note: in expansion of macro 'PTE_BIT_FUNC'
      93 | PTE_BIT_FUNC(mkold,     &= ~(_PAGE_ACCESSED));
         | ^~~~~~~~~~~~
   arch/arc/include/asm/pgtable-bits-arcv2.h:93:46: error: expected declaration specifiers before ';' token
      93 | PTE_BIT_FUNC(mkold,     &= ~(_PAGE_ACCESSED));
         |                                              ^
>> arch/arc/include/asm/pgtable-bits-arcv2.h:86:49: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      86 |         static inline pte_t pte_##fn(pte_t pte) { pte_val(pte) op; return pte; }
         |                                                 ^
   arch/arc/include/asm/pgtable-bits-arcv2.h:94:1: note: in expansion of macro 'PTE_BIT_FUNC'
      94 | PTE_BIT_FUNC(mkyoung,   |= (_PAGE_ACCESSED));
         | ^~~~~~~~~~~~
   arch/arc/include/asm/pgtable-bits-arcv2.h:94:45: error: expected declaration specifiers before ';' token
      94 | PTE_BIT_FUNC(mkyoung,   |= (_PAGE_ACCESSED));
         |                                             ^
>> arch/arc/include/asm/pgtable-bits-arcv2.h:86:49: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      86 |         static inline pte_t pte_##fn(pte_t pte) { pte_val(pte) op; return pte; }
         |                                                 ^
   arch/arc/include/asm/pgtable-bits-arcv2.h:95:1: note: in expansion of macro 'PTE_BIT_FUNC'
      95 | PTE_BIT_FUNC(mkspecial, |= (_PAGE_SPECIAL));
         | ^~~~~~~~~~~~
   arch/arc/include/asm/pgtable-bits-arcv2.h:95:44: error: expected declaration specifiers before ';' token
      95 | PTE_BIT_FUNC(mkspecial, |= (_PAGE_SPECIAL));
         |                                            ^
>> arch/arc/include/asm/pgtable-bits-arcv2.h:86:49: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      86 |         static inline pte_t pte_##fn(pte_t pte) { pte_val(pte) op; return pte; }
         |                                                 ^
   arch/arc/include/asm/pgtable-bits-arcv2.h:96:1: note: in expansion of macro 'PTE_BIT_FUNC'
      96 | PTE_BIT_FUNC(mkhuge,    |= (_PAGE_HW_SZ));
         | ^~~~~~~~~~~~
   arch/arc/include/asm/pgtable-bits-arcv2.h:96:42: error: expected declaration specifiers before ';' token
      96 | PTE_BIT_FUNC(mkhuge,    |= (_PAGE_HW_SZ));
         |                                          ^
   arch/arc/include/asm/pgtable-bits-arcv2.h:99:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      99 | {
         | ^
   arch/arc/include/asm/pgtable-bits-arcv2.h:105:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     105 | {
         | ^
   arch/arc/include/asm/pgtable-bits-arcv2.h:136:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     136 | {
         | ^
>> arch/arc/include/asm/pgtable-bits-arcv2.h:86:49: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      86 |         static inline pte_t pte_##fn(pte_t pte) { pte_val(pte) op; return pte; }
         |                                                 ^
   arch/arc/include/asm/pgtable-bits-arcv2.h:140:1: note: in expansion of macro 'PTE_BIT_FUNC'
     140 | PTE_BIT_FUNC(swp_mkexclusive, |= (_PAGE_SWP_EXCLUSIVE));
         | ^~~~~~~~~~~~
   arch/arc/include/asm/pgtable-bits-arcv2.h:140:56: error: expected declaration specifiers before ';' token
     140 | PTE_BIT_FUNC(swp_mkexclusive, |= (_PAGE_SWP_EXCLUSIVE));
         |                                                        ^
>> arch/arc/include/asm/pgtable-bits-arcv2.h:86:49: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      86 |         static inline pte_t pte_##fn(pte_t pte) { pte_val(pte) op; return pte; }
         |                                                 ^
   arch/arc/include/asm/pgtable-bits-arcv2.h:141:1: note: in expansion of macro 'PTE_BIT_FUNC'
     141 | PTE_BIT_FUNC(swp_clear_exclusive, &= ~(_PAGE_SWP_EXCLUSIVE));
         | ^~~~~~~~~~~~
   arch/arc/include/asm/pgtable-bits-arcv2.h:141:61: error: expected declaration specifiers before ';' token
     141 | PTE_BIT_FUNC(swp_clear_exclusive, &= ~(_PAGE_SWP_EXCLUSIVE));
         |                                                             ^
>> arch/arc/include/asm/pgtable.h:24:13: error: storage class specified for parameter 'empty_zero_page'
      24 | extern char empty_zero_page[PAGE_SIZE];
         |             ^~~~~~~~~~~~~~~
>> arch/arc/include/asm/pgtable.h:27:14: error: storage class specified for parameter 'swapper_pg_dir'
      27 | extern pgd_t swapper_pg_dir[] __aligned(PAGE_SIZE);
         |              ^~~~~~~~~~~~~~
>> arch/arc/include/asm/pgtable.h:27:14: error: alignment may not be specified for 'swapper_pg_dir'
   In file included from include/linux/pgtable.h:14:
   include/asm-generic/pgtable_uffd.h:6:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
       6 | {
         | ^
   include/asm-generic/pgtable_uffd.h:10:40: error: expected declaration specifiers or '...' before 'pmd_t'
      10 | static __always_inline int pmd_uffd_wp(pmd_t pmd)
         |                                        ^~~~~
   include/asm-generic/pgtable_uffd.h:16:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      16 | {
         | ^
   include/asm-generic/pgtable_uffd.h:20:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'pmd_mkuffd_wp'
      20 | static __always_inline pmd_t pmd_mkuffd_wp(pmd_t pmd)
         |                              ^~~~~~~~~~~~~
   include/asm-generic/pgtable_uffd.h:26:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      26 | {
         | ^
   include/asm-generic/pgtable_uffd.h:30:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'pmd_clear_uffd_wp'
      30 | static __always_inline pmd_t pmd_clear_uffd_wp(pmd_t pmd)
         |                              ^~~~~~~~~~~~~~~~~
   include/asm-generic/pgtable_uffd.h:36:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      36 | {
         | ^
   include/asm-generic/pgtable_uffd.h:41:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      41 | {
         | ^
   include/asm-generic/pgtable_uffd.h:46:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      46 | {
         | ^
   include/asm-generic/pgtable_uffd.h:50:21: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'pmd_swp_mkuffd_wp'
      50 | static inline pmd_t pmd_swp_mkuffd_wp(pmd_t pmd)
         |                     ^~~~~~~~~~~~~~~~~
   include/asm-generic/pgtable_uffd.h:55:35: error: expected declaration specifiers or '...' before 'pmd_t'
      55 | static inline int pmd_swp_uffd_wp(pmd_t pmd)
         |                                   ^~~~~
   include/asm-generic/pgtable_uffd.h:60:21: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'pmd_swp_clear_uffd_wp'
      60 | static inline pmd_t pmd_swp_clear_uffd_wp(pmd_t pmd)
         |                     ^~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/pgtable.h:15:
   include/linux/page_table_check.h:119:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     119 | {
         | ^
   include/linux/page_table_check.h:123:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     123 | {
         | ^
   include/linux/page_table_check.h:128:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     128 | {
         | ^
   include/linux/page_table_check.h:132:67: error: expected declaration specifiers or '...' before 'pmd_t'
     132 |                                               unsigned long addr, pmd_t pmd)
         |                                                                   ^~~~~
   include/linux/page_table_check.h:137:67: error: expected declaration specifiers or '...' before 'pud_t'
     137 |                                               unsigned long addr, pud_t pud)
         |                                                                   ^~~~~
   include/linux/page_table_check.h:144:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     144 | {
         | ^
   include/linux/page_table_check.h:148:65: error: expected declaration specifiers or '...' before 'pmd_t'
     148 |                                             unsigned long addr, pmd_t *pmdp,
         |                                                                 ^~~~~
   include/linux/page_table_check.h:149:45: error: expected declaration specifiers or '...' before 'pmd_t'
     149 |                                             pmd_t pmd)
         |                                             ^~~~~
   include/linux/page_table_check.h:154:65: error: expected declaration specifiers or '...' before 'pud_t'
     154 |                                             unsigned long addr, pud_t *pudp,
         |                                                                 ^~~~~
   include/linux/page_table_check.h:155:45: error: expected declaration specifiers or '...' before 'pud_t'
     155 |                                             pud_t pud)
         |                                             ^~~~~
   include/linux/page_table_check.h:161:53: error: expected declaration specifiers or '...' before 'pmd_t'
     161 |                                                     pmd_t pmd)
         |                                                     ^~~~~
   include/linux/pgtable.h:63:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      63 | {
         | ^
   include/linux/pgtable.h:70:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      70 | {
         | ^
   include/linux/pgtable.h:78:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      78 | {
         | ^
   include/linux/pgtable.h:90:40: error: expected declaration specifiers or '...' before 'pmd_t'
      90 | static inline pte_t *pte_offset_kernel(pmd_t *pmd, unsigned long address)
         |                                        ^~~~~
   include/linux/pgtable.h:105:32: error: expected declaration specifiers or '...' before 'pmd_t'
     105 | static inline pte_t *__pte_map(pmd_t *pmd, unsigned long address)
         |                                ^~~~~
   include/linux/pgtable.h:110:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     110 | {
         | ^
   include/linux/pgtable.h:133:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     133 | {
         | ^
   include/linux/pgtable.h:135:2: error: expected declaration specifiers before ';' token
     135 | };
         |  ^
   include/linux/pgtable.h:159:21: error: expected '=', ',', ';', 'asm' or '__attribute__' before '*' token
     159 | static inline pmd_t *pmd_off(struct mm_struct *mm, unsigned long va)
         |                     ^
   include/linux/pgtable.h:164:21: error: expected '=', ',', ';', 'asm' or '__attribute__' before '*' token
     164 | static inline pmd_t *pmd_off_k(unsigned long va)
..


vim +140 arch/arc/include/asm/uaccess.h

0a5eae458e923a Vineet Gupta 2013-01-18  100  
0a5eae458e923a Vineet Gupta 2013-01-18  101  #define __arc_put_user_one(src, dst, op, ret)	\
0a5eae458e923a Vineet Gupta 2013-01-18  102  	__asm__ __volatile__(                   \
0a5eae458e923a Vineet Gupta 2013-01-18  103  	"1:	"op"    %1,[%2]\n"		\
0a5eae458e923a Vineet Gupta 2013-01-18  104  	"2:	;nop\n"				\
0a5eae458e923a Vineet Gupta 2013-01-18  105  	"	.section .fixup, \"ax\"\n"	\
0a5eae458e923a Vineet Gupta 2013-01-18  106  	"	.align 4\n"			\
0a5eae458e923a Vineet Gupta 2013-01-18  107  	"3:	mov %0, %3\n"			\
0a5eae458e923a Vineet Gupta 2013-01-18  108  	"	j   2b\n"			\
0a5eae458e923a Vineet Gupta 2013-01-18  109  	"	.previous\n"			\
0a5eae458e923a Vineet Gupta 2013-01-18  110  	"	.section __ex_table, \"a\"\n"	\
0a5eae458e923a Vineet Gupta 2013-01-18  111  	"	.align 4\n"			\
0a5eae458e923a Vineet Gupta 2013-01-18  112  	"	.word 1b,3b\n"			\
0a5eae458e923a Vineet Gupta 2013-01-18  113  	"	.previous\n"			\
0a5eae458e923a Vineet Gupta 2013-01-18  114  						\
0a5eae458e923a Vineet Gupta 2013-01-18  115  	: "+r" (ret)				\
0a5eae458e923a Vineet Gupta 2013-01-18  116  	: "r" (src), "r" (dst), "ir" (-EFAULT))
0a5eae458e923a Vineet Gupta 2013-01-18  117  
0a5eae458e923a Vineet Gupta 2013-01-18  118  #define __arc_put_user_one_64(src, dst, ret)	\
0a5eae458e923a Vineet Gupta 2013-01-18  119  	__asm__ __volatile__(                   \
0a5eae458e923a Vineet Gupta 2013-01-18  120  	"1:	st   %1,[%2]\n"			\
0a5eae458e923a Vineet Gupta 2013-01-18  121  	"4:	st  %R1,[%2, 4]\n"		\
0a5eae458e923a Vineet Gupta 2013-01-18  122  	"2:	;nop\n"				\
0a5eae458e923a Vineet Gupta 2013-01-18  123  	"	.section .fixup, \"ax\"\n"	\
0a5eae458e923a Vineet Gupta 2013-01-18  124  	"	.align 4\n"			\
0a5eae458e923a Vineet Gupta 2013-01-18  125  	"3:	mov %0, %3\n"			\
0a5eae458e923a Vineet Gupta 2013-01-18  126  	"	j   2b\n"			\
0a5eae458e923a Vineet Gupta 2013-01-18  127  	"	.previous\n"			\
0a5eae458e923a Vineet Gupta 2013-01-18  128  	"	.section __ex_table, \"a\"\n"	\
0a5eae458e923a Vineet Gupta 2013-01-18  129  	"	.align 4\n"			\
0a5eae458e923a Vineet Gupta 2013-01-18  130  	"	.word 1b,3b\n"			\
0a5eae458e923a Vineet Gupta 2013-01-18  131  	"	.word 4b,3b\n"			\
0a5eae458e923a Vineet Gupta 2013-01-18  132  	"	.previous\n"			\
0a5eae458e923a Vineet Gupta 2013-01-18  133  						\
0a5eae458e923a Vineet Gupta 2013-01-18  134  	: "+r" (ret)				\
0a5eae458e923a Vineet Gupta 2013-01-18  135  	: "r" (src), "r" (dst), "ir" (-EFAULT))
0a5eae458e923a Vineet Gupta 2013-01-18  136  
0a5eae458e923a Vineet Gupta 2013-01-18  137  
43697cb0973da1 Vineet Gupta 2013-01-18  138  static inline unsigned long
e13909a4acc4b6 Vineet Gupta 2017-03-29  139  raw_copy_from_user(void *to, const void __user *from, unsigned long n)
43697cb0973da1 Vineet Gupta 2013-01-18 @140  {
43697cb0973da1 Vineet Gupta 2013-01-18  141  	long res = 0;
43697cb0973da1 Vineet Gupta 2013-01-18  142  	char val;
43697cb0973da1 Vineet Gupta 2013-01-18  143  	unsigned long tmp1, tmp2, tmp3, tmp4;
43697cb0973da1 Vineet Gupta 2013-01-18  144  	unsigned long orig_n = n;
43697cb0973da1 Vineet Gupta 2013-01-18  145  
43697cb0973da1 Vineet Gupta 2013-01-18  146  	if (n == 0)
43697cb0973da1 Vineet Gupta 2013-01-18  147  		return 0;
43697cb0973da1 Vineet Gupta 2013-01-18  148  
43697cb0973da1 Vineet Gupta 2013-01-18  149  	/* unaligned */
43697cb0973da1 Vineet Gupta 2013-01-18  150  	if (((unsigned long)to & 0x3) || ((unsigned long)from & 0x3)) {
43697cb0973da1 Vineet Gupta 2013-01-18  151  
43697cb0973da1 Vineet Gupta 2013-01-18  152  		unsigned char tmp;
43697cb0973da1 Vineet Gupta 2013-01-18  153  
43697cb0973da1 Vineet Gupta 2013-01-18  154  		__asm__ __volatile__ (
43697cb0973da1 Vineet Gupta 2013-01-18  155  		"	mov.f   lp_count, %0		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  156  		"	lpnz 2f				\n"
43697cb0973da1 Vineet Gupta 2013-01-18  157  		"1:	ldb.ab  %1, [%3, 1]		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  158  		"	stb.ab  %1, [%2, 1]		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  159  		"	sub     %0,%0,1			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  160  		"2:	;nop				\n"
43697cb0973da1 Vineet Gupta 2013-01-18  161  		"	.section .fixup, \"ax\"		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  162  		"	.align 4			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  163  		"3:	j   2b				\n"
43697cb0973da1 Vineet Gupta 2013-01-18  164  		"	.previous			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  165  		"	.section __ex_table, \"a\"	\n"
43697cb0973da1 Vineet Gupta 2013-01-18  166  		"	.align 4			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  167  		"	.word   1b, 3b			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  168  		"	.previous			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  169  
43697cb0973da1 Vineet Gupta 2013-01-18  170  		: "+r" (n),
43697cb0973da1 Vineet Gupta 2013-01-18  171  		/*
43697cb0973da1 Vineet Gupta 2013-01-18  172  		 * Note as an '&' earlyclobber operand to make sure the
43697cb0973da1 Vineet Gupta 2013-01-18  173  		 * temporary register inside the loop is not the same as
43697cb0973da1 Vineet Gupta 2013-01-18  174  		 *  FROM or TO.
43697cb0973da1 Vineet Gupta 2013-01-18  175  		*/
43697cb0973da1 Vineet Gupta 2013-01-18  176  		  "=&r" (tmp), "+r" (to), "+r" (from)
43697cb0973da1 Vineet Gupta 2013-01-18  177  		:
d5e3c55e01d8b1 Vineet Gupta 2019-02-05  178  		: "lp_count", "memory");
43697cb0973da1 Vineet Gupta 2013-01-18  179  
43697cb0973da1 Vineet Gupta 2013-01-18  180  		return n;
43697cb0973da1 Vineet Gupta 2013-01-18  181  	}
43697cb0973da1 Vineet Gupta 2013-01-18  182  
43697cb0973da1 Vineet Gupta 2013-01-18  183  	/*
43697cb0973da1 Vineet Gupta 2013-01-18  184  	 * Hand-crafted constant propagation to reduce code sz of the
43697cb0973da1 Vineet Gupta 2013-01-18  185  	 * laddered copy 16x,8,4,2,1
43697cb0973da1 Vineet Gupta 2013-01-18  186  	 */
43697cb0973da1 Vineet Gupta 2013-01-18  187  	if (__builtin_constant_p(orig_n)) {
43697cb0973da1 Vineet Gupta 2013-01-18  188  		res = orig_n;
43697cb0973da1 Vineet Gupta 2013-01-18  189  
43697cb0973da1 Vineet Gupta 2013-01-18  190  		if (orig_n / 16) {
43697cb0973da1 Vineet Gupta 2013-01-18  191  			orig_n = orig_n % 16;
43697cb0973da1 Vineet Gupta 2013-01-18  192  
43697cb0973da1 Vineet Gupta 2013-01-18  193  			__asm__ __volatile__(
43697cb0973da1 Vineet Gupta 2013-01-18  194  			"	lsr   lp_count, %7,4		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  195  			"	lp    3f			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  196  			"1:	ld.ab   %3, [%2, 4]		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  197  			"11:	ld.ab   %4, [%2, 4]		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  198  			"12:	ld.ab   %5, [%2, 4]		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  199  			"13:	ld.ab   %6, [%2, 4]		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  200  			"	st.ab   %3, [%1, 4]		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  201  			"	st.ab   %4, [%1, 4]		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  202  			"	st.ab   %5, [%1, 4]		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  203  			"	st.ab   %6, [%1, 4]		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  204  			"	sub     %0,%0,16		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  205  			"3:	;nop				\n"
43697cb0973da1 Vineet Gupta 2013-01-18  206  			"	.section .fixup, \"ax\"		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  207  			"	.align 4			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  208  			"4:	j   3b				\n"
43697cb0973da1 Vineet Gupta 2013-01-18  209  			"	.previous			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  210  			"	.section __ex_table, \"a\"	\n"
43697cb0973da1 Vineet Gupta 2013-01-18  211  			"	.align 4			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  212  			"	.word   1b, 4b			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  213  			"	.word   11b,4b			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  214  			"	.word   12b,4b			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  215  			"	.word   13b,4b			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  216  			"	.previous			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  217  			: "+r" (res), "+r"(to), "+r"(from),
43697cb0973da1 Vineet Gupta 2013-01-18  218  			  "=r"(tmp1), "=r"(tmp2), "=r"(tmp3), "=r"(tmp4)
43697cb0973da1 Vineet Gupta 2013-01-18  219  			: "ir"(n)
43697cb0973da1 Vineet Gupta 2013-01-18  220  			: "lp_count", "memory");
43697cb0973da1 Vineet Gupta 2013-01-18  221  		}
43697cb0973da1 Vineet Gupta 2013-01-18  222  		if (orig_n / 8) {
43697cb0973da1 Vineet Gupta 2013-01-18  223  			orig_n = orig_n % 8;
43697cb0973da1 Vineet Gupta 2013-01-18  224  
43697cb0973da1 Vineet Gupta 2013-01-18  225  			__asm__ __volatile__(
43697cb0973da1 Vineet Gupta 2013-01-18  226  			"14:	ld.ab   %3, [%2,4]		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  227  			"15:	ld.ab   %4, [%2,4]		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  228  			"	st.ab   %3, [%1,4]		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  229  			"	st.ab   %4, [%1,4]		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  230  			"	sub     %0,%0,8			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  231  			"31:	;nop				\n"
43697cb0973da1 Vineet Gupta 2013-01-18  232  			"	.section .fixup, \"ax\"		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  233  			"	.align 4			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  234  			"4:	j   31b				\n"
43697cb0973da1 Vineet Gupta 2013-01-18  235  			"	.previous			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  236  			"	.section __ex_table, \"a\"	\n"
43697cb0973da1 Vineet Gupta 2013-01-18  237  			"	.align 4			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  238  			"	.word   14b,4b			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  239  			"	.word   15b,4b			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  240  			"	.previous			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  241  			: "+r" (res), "+r"(to), "+r"(from),
43697cb0973da1 Vineet Gupta 2013-01-18  242  			  "=r"(tmp1), "=r"(tmp2)
43697cb0973da1 Vineet Gupta 2013-01-18  243  			:
43697cb0973da1 Vineet Gupta 2013-01-18  244  			: "memory");
43697cb0973da1 Vineet Gupta 2013-01-18  245  		}
43697cb0973da1 Vineet Gupta 2013-01-18  246  		if (orig_n / 4) {
43697cb0973da1 Vineet Gupta 2013-01-18  247  			orig_n = orig_n % 4;
43697cb0973da1 Vineet Gupta 2013-01-18  248  
43697cb0973da1 Vineet Gupta 2013-01-18  249  			__asm__ __volatile__(
43697cb0973da1 Vineet Gupta 2013-01-18  250  			"16:	ld.ab   %3, [%2,4]		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  251  			"	st.ab   %3, [%1,4]		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  252  			"	sub     %0,%0,4			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  253  			"32:	;nop				\n"
43697cb0973da1 Vineet Gupta 2013-01-18  254  			"	.section .fixup, \"ax\"		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  255  			"	.align 4			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  256  			"4:	j   32b				\n"
43697cb0973da1 Vineet Gupta 2013-01-18  257  			"	.previous			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  258  			"	.section __ex_table, \"a\"	\n"
43697cb0973da1 Vineet Gupta 2013-01-18  259  			"	.align 4			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  260  			"	.word   16b,4b			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  261  			"	.previous			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  262  			: "+r" (res), "+r"(to), "+r"(from), "=r"(tmp1)
43697cb0973da1 Vineet Gupta 2013-01-18  263  			:
43697cb0973da1 Vineet Gupta 2013-01-18  264  			: "memory");
43697cb0973da1 Vineet Gupta 2013-01-18  265  		}
43697cb0973da1 Vineet Gupta 2013-01-18  266  		if (orig_n / 2) {
43697cb0973da1 Vineet Gupta 2013-01-18  267  			orig_n = orig_n % 2;
43697cb0973da1 Vineet Gupta 2013-01-18  268  
43697cb0973da1 Vineet Gupta 2013-01-18  269  			__asm__ __volatile__(
43697cb0973da1 Vineet Gupta 2013-01-18  270  			"17:	ldw.ab   %3, [%2,2]		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  271  			"	stw.ab   %3, [%1,2]		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  272  			"	sub      %0,%0,2		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  273  			"33:	;nop				\n"
43697cb0973da1 Vineet Gupta 2013-01-18  274  			"	.section .fixup, \"ax\"		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  275  			"	.align 4			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  276  			"4:	j   33b				\n"
43697cb0973da1 Vineet Gupta 2013-01-18  277  			"	.previous			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  278  			"	.section __ex_table, \"a\"	\n"
43697cb0973da1 Vineet Gupta 2013-01-18  279  			"	.align 4			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  280  			"	.word   17b,4b			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  281  			"	.previous			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  282  			: "+r" (res), "+r"(to), "+r"(from), "=r"(tmp1)
43697cb0973da1 Vineet Gupta 2013-01-18  283  			:
43697cb0973da1 Vineet Gupta 2013-01-18  284  			: "memory");
43697cb0973da1 Vineet Gupta 2013-01-18  285  		}
43697cb0973da1 Vineet Gupta 2013-01-18  286  		if (orig_n & 1) {
43697cb0973da1 Vineet Gupta 2013-01-18  287  			__asm__ __volatile__(
43697cb0973da1 Vineet Gupta 2013-01-18  288  			"18:	ldb.ab   %3, [%2,2]		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  289  			"	stb.ab   %3, [%1,2]		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  290  			"	sub      %0,%0,1		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  291  			"34:	; nop				\n"
43697cb0973da1 Vineet Gupta 2013-01-18  292  			"	.section .fixup, \"ax\"		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  293  			"	.align 4			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  294  			"4:	j   34b				\n"
43697cb0973da1 Vineet Gupta 2013-01-18  295  			"	.previous			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  296  			"	.section __ex_table, \"a\"	\n"
43697cb0973da1 Vineet Gupta 2013-01-18  297  			"	.align 4			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  298  			"	.word   18b,4b			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  299  			"	.previous			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  300  			: "+r" (res), "+r"(to), "+r"(from), "=r"(tmp1)
43697cb0973da1 Vineet Gupta 2013-01-18  301  			:
43697cb0973da1 Vineet Gupta 2013-01-18  302  			: "memory");
43697cb0973da1 Vineet Gupta 2013-01-18  303  		}
43697cb0973da1 Vineet Gupta 2013-01-18  304  	} else {  /* n is NOT constant, so laddered copy of 16x,8,4,2,1  */
43697cb0973da1 Vineet Gupta 2013-01-18  305  
43697cb0973da1 Vineet Gupta 2013-01-18  306  		__asm__ __volatile__(
43697cb0973da1 Vineet Gupta 2013-01-18  307  		"	mov %0,%3			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  308  		"	lsr.f   lp_count, %3,4		\n"  /* 16x bytes */
43697cb0973da1 Vineet Gupta 2013-01-18  309  		"	lpnz    3f			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  310  		"1:	ld.ab   %5, [%2, 4]		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  311  		"11:	ld.ab   %6, [%2, 4]		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  312  		"12:	ld.ab   %7, [%2, 4]		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  313  		"13:	ld.ab   %8, [%2, 4]		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  314  		"	st.ab   %5, [%1, 4]		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  315  		"	st.ab   %6, [%1, 4]		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  316  		"	st.ab   %7, [%1, 4]		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  317  		"	st.ab   %8, [%1, 4]		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  318  		"	sub     %0,%0,16		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  319  		"3:	and.f   %3,%3,0xf		\n"  /* stragglers */
43697cb0973da1 Vineet Gupta 2013-01-18  320  		"	bz      34f			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  321  		"	bbit0   %3,3,31f		\n"  /* 8 bytes left */
43697cb0973da1 Vineet Gupta 2013-01-18  322  		"14:	ld.ab   %5, [%2,4]		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  323  		"15:	ld.ab   %6, [%2,4]		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  324  		"	st.ab   %5, [%1,4]		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  325  		"	st.ab   %6, [%1,4]		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  326  		"	sub.f   %0,%0,8			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  327  		"31:	bbit0   %3,2,32f		\n"  /* 4 bytes left */
43697cb0973da1 Vineet Gupta 2013-01-18  328  		"16:	ld.ab   %5, [%2,4]		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  329  		"	st.ab   %5, [%1,4]		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  330  		"	sub.f   %0,%0,4			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  331  		"32:	bbit0   %3,1,33f		\n"  /* 2 bytes left */
43697cb0973da1 Vineet Gupta 2013-01-18  332  		"17:	ldw.ab  %5, [%2,2]		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  333  		"	stw.ab  %5, [%1,2]		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  334  		"	sub.f   %0,%0,2			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  335  		"33:	bbit0   %3,0,34f		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  336  		"18:	ldb.ab  %5, [%2,1]		\n"  /* 1 byte left */
43697cb0973da1 Vineet Gupta 2013-01-18  337  		"	stb.ab  %5, [%1,1]		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  338  		"	sub.f   %0,%0,1			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  339  		"34:	;nop				\n"
43697cb0973da1 Vineet Gupta 2013-01-18  340  		"	.section .fixup, \"ax\"		\n"
43697cb0973da1 Vineet Gupta 2013-01-18  341  		"	.align 4			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  342  		"4:	j   34b				\n"
43697cb0973da1 Vineet Gupta 2013-01-18  343  		"	.previous			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  344  		"	.section __ex_table, \"a\"	\n"
43697cb0973da1 Vineet Gupta 2013-01-18  345  		"	.align 4			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  346  		"	.word   1b, 4b			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  347  		"	.word   11b,4b			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  348  		"	.word   12b,4b			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  349  		"	.word   13b,4b			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  350  		"	.word   14b,4b			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  351  		"	.word   15b,4b			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  352  		"	.word   16b,4b			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  353  		"	.word   17b,4b			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  354  		"	.word   18b,4b			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  355  		"	.previous			\n"
43697cb0973da1 Vineet Gupta 2013-01-18  356  		: "=r" (res), "+r"(to), "+r"(from), "+r"(n), "=r"(val),
43697cb0973da1 Vineet Gupta 2013-01-18  357  		  "=r"(tmp1), "=r"(tmp2), "=r"(tmp3), "=r"(tmp4)
43697cb0973da1 Vineet Gupta 2013-01-18  358  		:
43697cb0973da1 Vineet Gupta 2013-01-18  359  		: "lp_count", "memory");
43697cb0973da1 Vineet Gupta 2013-01-18  360  	}
43697cb0973da1 Vineet Gupta 2013-01-18  361  
43697cb0973da1 Vineet Gupta 2013-01-18  362  	return res;
43697cb0973da1 Vineet Gupta 2013-01-18  363  }
43697cb0973da1 Vineet Gupta 2013-01-18  364  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
