Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03B1784DF0
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 02:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjHWAuG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Aug 2023 20:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjHWAuF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Aug 2023 20:50:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91D4CD6;
        Tue, 22 Aug 2023 17:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692751801; x=1724287801;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m74Pl3pvDh4ONwv/L1TlxRbQupn1Ollb4NPyT/C2hRQ=;
  b=fkj9W739MxCK22xQ9BpDQHdKslT5AK63yN35wn4Rm4nmxUcfUrIEpr3Z
   4uAlSs2KuIwLcs/RD2za/lm651DhToV1LBtOqN8D8N1gGHBOObztLoGLy
   ScKWMTOMezXKNXuFtT8SVqgfRbKJqfaa6W3C68V9B5RdfNXqwq27TFFYp
   bX0Ki9c4YioV9yIB4JmlAQQJdxSTzbiLYUsNtJQI+zJed/P3s1zVLhJ4b
   EPHhmlnWZQapcFdoTBOuIef98qOH6cs3sSXSQD+DCUoF4Yqjs8/GiPFYB
   4lwyTE6AnK1v0AfvzaE2eQA/mNWE+9luwmNeEM0hFlsbBKq8mZv2c9uNd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="405031973"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="405031973"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 17:50:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="801892911"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="801892911"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 22 Aug 2023 17:49:56 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYc4J-0000fk-38;
        Wed, 23 Aug 2023 00:49:55 +0000
Date:   Wed, 23 Aug 2023 08:48:56 +0800
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
Message-ID: <202308230848.SzyPhc6B-lkp@intel.com>
References: <1692717141-32743-4-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1692717141-32743-4-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krishna,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/for-linus]
[also build test WARNING on robh/for-next rafael-pm/linux-next linus/master v6.5-rc7 next-20230822]
[cannot apply to pci/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-chaitanya-chundru/dt-bindings-pci-qcom-Add-opp-table/20230822-232104
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
patch link:    https://lore.kernel.org/r/1692717141-32743-4-git-send-email-quic_krichai%40quicinc.com
patch subject: [PATCH v4 3/4] OPP: Add api to retrieve opps which is at most the provided level
config: um-defconfig (https://download.01.org/0day-ci/archive/20230823/202308230848.SzyPhc6B-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230823/202308230848.SzyPhc6B-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308230848.SzyPhc6B-lkp@intel.com/

All warnings (new ones prefixed by >>):

         | ^
   include/linux/unaligned/packed_struct.h:17:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      17 | {
         | ^
   include/linux/unaligned/packed_struct.h:23:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      23 | {
         | ^
   include/linux/unaligned/packed_struct.h:29:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      29 | {
         | ^
   include/linux/unaligned/packed_struct.h:35:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      35 | {
         | ^
   include/linux/unaligned/packed_struct.h:41:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      41 | {
         | ^
   include/asm-generic/unaligned.h:26:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      26 | {
         | ^
   include/asm-generic/unaligned.h:31:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      31 | {
         | ^
   include/asm-generic/unaligned.h:36:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      36 | {
         | ^
   include/asm-generic/unaligned.h:41:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      41 | {
         | ^
   include/asm-generic/unaligned.h:46:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      46 | {
         | ^
   include/asm-generic/unaligned.h:51:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      51 | {
         | ^
   include/asm-generic/unaligned.h:56:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      56 | {
         | ^
   include/asm-generic/unaligned.h:61:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      61 | {
         | ^
   include/asm-generic/unaligned.h:66:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      66 | {
         | ^
   include/asm-generic/unaligned.h:71:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      71 | {
         | ^
   include/asm-generic/unaligned.h:76:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      76 | {
         | ^
   include/asm-generic/unaligned.h:81:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      81 | {
         | ^
   include/asm-generic/unaligned.h:86:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      86 | {
         | ^
   include/asm-generic/unaligned.h:91:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      91 | {
         | ^
   include/asm-generic/unaligned.h:96:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      96 | {
         | ^
   include/asm-generic/unaligned.h:101:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     101 | {
         | ^
   include/asm-generic/unaligned.h:106:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     106 | {
         | ^
   include/asm-generic/unaligned.h:113:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     113 | {
         | ^
   include/asm-generic/unaligned.h:118:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     118 | {
         | ^
   include/asm-generic/unaligned.h:125:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     125 | {
         | ^
   include/asm-generic/unaligned.h:130:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     130 | {
         | ^
   include/asm-generic/unaligned.h:140:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     140 | {
         | ^
   include/asm-generic/unaligned.h:145:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     145 | {
         | ^
   include/asm-generic/unaligned.h:151:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     151 | {
         | ^
   arch/um/include/asm/uaccess.h:25:22: error: storage class specified for parameter 'raw_copy_from_user'
      25 | extern unsigned long raw_copy_from_user(void *to, const void __user *from, unsigned long n);
         |                      ^~~~~~~~~~~~~~~~~~
   arch/um/include/asm/uaccess.h:26:22: error: storage class specified for parameter 'raw_copy_to_user'
      26 | extern unsigned long raw_copy_to_user(void __user *to, const void *from, unsigned long n);
         |                      ^~~~~~~~~~~~~~~~
   arch/um/include/asm/uaccess.h:27:22: error: storage class specified for parameter '__clear_user'
      27 | extern unsigned long __clear_user(void __user *mem, unsigned long len);
         |                      ^~~~~~~~~~~~
   arch/um/include/asm/uaccess.h:28:19: error: storage class specified for parameter '__access_ok'
      28 | static inline int __access_ok(const void __user *ptr, unsigned long size);
         |                   ^~~~~~~~~~~
>> arch/um/include/asm/uaccess.h:28:19: warning: parameter '__access_ok' declared 'inline'
>> arch/um/include/asm/uaccess.h:28:1: warning: 'gnu_inline' attribute ignored [-Wattributes]
      28 | static inline int __access_ok(const void __user *ptr, unsigned long size);
         | ^~~~~~
   arch/um/include/asm/uaccess.h:28:19: error: 'no_instrument_function' attribute applies only to functions
      28 | static inline int __access_ok(const void __user *ptr, unsigned long size);
         |                   ^~~~~~~~~~~
   In file included from arch/um/include/asm/uaccess.h:37:
   include/asm-generic/uaccess.h:136:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     136 | {
         | ^
   include/asm-generic/uaccess.h:144:12: error: storage class specified for parameter '__put_user_bad'
     144 | extern int __put_user_bad(void) __attribute__((noreturn));
         |            ^~~~~~~~~~~~~~
   include/asm-generic/uaccess.h:197:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     197 | {
         | ^
   include/asm-generic/uaccess.h:205:12: error: storage class specified for parameter '__get_user_bad'
     205 | extern int __get_user_bad(void) __attribute__((noreturn));
         |            ^~~~~~~~~~~~~~
   include/asm-generic/uaccess.h:221:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     221 | {
         | ^
   In file included from ./arch/um/include/generated/asm/extable.h:1,
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
   arch/um/include/asm/uaccess.h:40:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      40 | {
         | ^
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
--
         | ^
   include/linux/page_ref.h:88:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      88 | {
         | ^
   include/linux/page_ref.h:93:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      93 | {
         | ^
   include/linux/page_ref.h:98:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      98 | {
         | ^
   include/linux/page_ref.h:105:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     105 | {
         | ^
   include/linux/page_ref.h:114:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     114 | {
         | ^
   include/linux/page_ref.h:119:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     119 | {
         | ^
   include/linux/page_ref.h:126:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     126 | {
         | ^
   include/linux/page_ref.h:131:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     131 | {
         | ^
   include/linux/page_ref.h:138:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     138 | {
         | ^
   include/linux/page_ref.h:143:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     143 | {
         | ^
   include/linux/page_ref.h:152:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     152 | {
         | ^
   include/linux/page_ref.h:157:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     157 | {
         | ^
   include/linux/page_ref.h:164:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     164 | {
         | ^
   include/linux/page_ref.h:169:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     169 | {
         | ^
   include/linux/page_ref.h:176:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     176 | {
         | ^
   include/linux/page_ref.h:181:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     181 | {
         | ^
   include/linux/page_ref.h:190:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     190 | {
         | ^
   include/linux/page_ref.h:195:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     195 | {
         | ^
   include/linux/page_ref.h:204:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     204 | {
         | ^
   include/linux/page_ref.h:209:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     209 | {
         | ^
   include/linux/page_ref.h:218:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     218 | {
         | ^
   include/linux/page_ref.h:223:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     223 | {
         | ^
   include/linux/page_ref.h:232:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     232 | {
         | ^
   include/linux/page_ref.h:237:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     237 | {
         | ^
   include/linux/page_ref.h:246:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     246 | {
         | ^
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
   In file included from arch/um/include/asm/pgtable.h:11,
                    from include/linux/pgtable.h:6,
                    from include/linux/mm.h:29:
>> arch/um/include/asm/fixmap.h:35:1: warning: empty declaration
      35 | enum fixed_addresses {
         | ^~~~
   arch/um/include/asm/fixmap.h:39:13: error: storage class specified for parameter '__set_fixmap'
      39 | extern void __set_fixmap (enum fixed_addresses idx,
         |             ^~~~~~~~~~~~
   In file included from arch/um/include/asm/fixmap.h:54:
   include/asm-generic/fixmap.h:31:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      31 | {
         | ^
   include/asm-generic/fixmap.h:37:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      37 | {
         | ^
   In file included from include/asm-generic/pgtable-nopud.h:7,
                    from arch/um/include/asm/pgtable-3level.h:10,
                    from arch/um/include/asm/pgtable.h:28:
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
   arch/um/include/asm/pgtable-3level.h:64:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      64 | {
         | ^
   arch/um/include/asm/pgtable-3level.h:68:46: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      68 | static inline void pgd_mkuptodate(pgd_t pgd) { pgd_val(pgd) &= ~_PAGE_NEWPAGE; }
         |                                              ^
   arch/um/include/asm/pgtable-3level.h:72:31: error: expected declaration specifiers or '...' before 'pud_t'
      72 | static inline void pud_clear (pud_t *pud)
         |                               ^~~~~
   arch/um/include/asm/pgtable-3level.h:81:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      81 | {
         | ^
   arch/um/include/asm/pgtable-3level.h:86:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      86 | {
         | ^
   arch/um/include/asm/pgtable-3level.h:95:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      95 | {
         | ^
   arch/um/include/asm/pgtable.h:33:14: error: storage class specified for parameter 'swapper_pg_dir'
      33 | extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
         |              ^~~~~~~~~~~~~~
   arch/um/include/asm/pgtable.h:36:23: error: storage class specified for parameter 'empty_zero_page'
      36 | extern unsigned long *empty_zero_page;
         |                       ^~~~~~~~~~~~~~~
   arch/um/include/asm/pgtable.h:46:22: error: storage class specified for parameter 'end_iomem'
      46 | extern unsigned long end_iomem;
         |                      ^~~~~~~~~
   arch/um/include/asm/pgtable.h:112:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     112 | {
         | ^
   arch/um/include/asm/pgtable.h:121:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     121 | {
         | ^
   arch/um/include/asm/pgtable.h:126:38: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     126 | static inline int pte_exec(pte_t pte){
         |                                      ^
   arch/um/include/asm/pgtable.h:132:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     132 | {
         | ^
   arch/um/include/asm/pgtable.h:138:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     138 | {
         | ^
   arch/um/include/asm/pgtable.h:143:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     143 | {
         | ^
   arch/um/include/asm/pgtable.h:148:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     148 | {
         | ^
   arch/um/include/asm/pgtable.h:153:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     153 | {
         | ^
   arch/um/include/asm/pgtable.h:164:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     164 | {
         | ^
   arch/um/include/asm/pgtable.h:170:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     170 | {
         | ^
   arch/um/include/asm/pgtable.h:176:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     176 | {
         | ^
   arch/um/include/asm/pgtable.h:182:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     182 | {
         | ^
   arch/um/include/asm/pgtable.h:191:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     191 | {
         | ^
   arch/um/include/asm/pgtable.h:199:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     199 | {
         | ^
   arch/um/include/asm/pgtable.h:205:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     205 | {
         | ^
   arch/um/include/asm/pgtable.h:211:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     211 | {
         | ^
   arch/um/include/asm/pgtable.h:219:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     219 | {
         | ^
   arch/um/include/asm/pgtable.h:227:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     227 | {
         | ^
   arch/um/include/asm/pgtable.h:233:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     233 | {
         | ^
   arch/um/include/asm/pgtable.h:247:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     247 | {
         | ^
   arch/um/include/asm/pgtable.h:253:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     253 | {
         | ^
   arch/um/include/asm/pgtable.h:276:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     276 | {
         | ^
>> arch/um/include/asm/pgtable.h:289:1: warning: empty declaration
     289 | struct mm_struct;
         | ^~~~~~
   arch/um/include/asm/pgtable.h:290:15: error: storage class specified for parameter 'virt_to_pte'
     290 | extern pte_t *virt_to_pte(struct mm_struct *mm, unsigned long addr);
         |               ^~~~~~~~~~~
   arch/um/include/asm/pgtable.h:317:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     317 | {
         | ^
   arch/um/include/asm/pgtable.h:322:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     322 | {
         | ^
   arch/um/include/asm/pgtable.h:328:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     328 | {
         | ^
   In file included from include/linux/pgtable.h:14:
   include/asm-generic/pgtable_uffd.h:6:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
       6 | {
         | ^
   include/asm-generic/pgtable_uffd.h:11:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      11 | {
         | ^
   include/asm-generic/pgtable_uffd.h:16:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      16 | {
         | ^
   include/asm-generic/pgtable_uffd.h:21:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      21 | {
         | ^
   include/asm-generic/pgtable_uffd.h:26:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      26 | {
         | ^
   include/asm-generic/pgtable_uffd.h:31:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      31 | {
         | ^
   include/asm-generic/pgtable_uffd.h:36:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      36 | {
         | ^
   include/asm-generic/pgtable_uffd.h:41:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      41 | {
         | ^
   include/asm-generic/pgtable_uffd.h:46:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      46 | {
         | ^
   include/asm-generic/pgtable_uffd.h:51:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      51 | {
         | ^
   include/asm-generic/pgtable_uffd.h:56:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      56 | {
         | ^
   include/asm-generic/pgtable_uffd.h:61:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      61 | {
         | ^
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
   include/linux/page_table_check.h:133:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     133 | {
         | ^
   include/linux/page_table_check.h:137:67: error: expected declaration specifiers or '...' before 'pud_t'
     137 |                                               unsigned long addr, pud_t pud)
         |                                                                   ^~~~~
   include/linux/page_table_check.h:144:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     144 | {
         | ^
   include/linux/page_table_check.h:150:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     150 | {
         | ^
   include/linux/page_table_check.h:154:65: error: expected declaration specifiers or '...' before 'pud_t'
     154 |                                             unsigned long addr, pud_t *pudp,
         |                                                                 ^~~~~
   include/linux/page_table_check.h:155:45: error: expected declaration specifiers or '...' before 'pud_t'
     155 |                                             pud_t pud)
         |                                             ^~~~~
   include/linux/page_table_check.h:162:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     162 | {
         | ^
   include/linux/pgtable.h:63:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      63 | {
         | ^
   include/linux/pgtable.h:70:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      70 | {
         | ^
   include/linux/pgtable.h:78:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      78 | {
         | ^
   include/linux/pgtable.h:91:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      91 | {
         | ^
   include/linux/pgtable.h:106:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     106 | {
         | ^
   include/linux/pgtable.h:110:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     110 | {
         | ^
..


vim +28 arch/um/include/asm/uaccess.h

^1da177e4c3f41 include/asm-um/uaccess.h      Linus Torvalds     2005-04-16  12  
fced95cacfc21b arch/um/include/asm/uaccess.h Al Viro            2011-08-18  13  #define __under_task_size(addr, size) \
fced95cacfc21b arch/um/include/asm/uaccess.h Al Viro            2011-08-18  14  	(((unsigned long) (addr) < TASK_SIZE) && \
fced95cacfc21b arch/um/include/asm/uaccess.h Al Viro            2011-08-18  15  	 (((unsigned long) (addr) + (size)) < TASK_SIZE))
fced95cacfc21b arch/um/include/asm/uaccess.h Al Viro            2011-08-18  16  
f8d65d27e677da arch/um/include/asm/uaccess.h Richard Weinberger 2015-05-12  17  #define __access_ok_vsyscall(addr, size) \
f8d65d27e677da arch/um/include/asm/uaccess.h Richard Weinberger 2015-05-12  18  	  (((unsigned long) (addr) >= FIXADDR_USER_START) && \
fced95cacfc21b arch/um/include/asm/uaccess.h Al Viro            2011-08-18  19  	  ((unsigned long) (addr) + (size) <= FIXADDR_USER_END) && \
fced95cacfc21b arch/um/include/asm/uaccess.h Al Viro            2011-08-18  20  	  ((unsigned long) (addr) + (size) >= (unsigned long)(addr)))
fced95cacfc21b arch/um/include/asm/uaccess.h Al Viro            2011-08-18  21  
fced95cacfc21b arch/um/include/asm/uaccess.h Al Viro            2011-08-18  22  #define __addr_range_nowrap(addr, size) \
fced95cacfc21b arch/um/include/asm/uaccess.h Al Viro            2011-08-18  23  	((unsigned long) (addr) <= ((unsigned long) (addr) + (size)))
fced95cacfc21b arch/um/include/asm/uaccess.h Al Viro            2011-08-18  24  
a668ce3a001fe0 arch/um/include/asm/uaccess.h Al Viro            2017-03-28  25  extern unsigned long raw_copy_from_user(void *to, const void __user *from, unsigned long n);
a668ce3a001fe0 arch/um/include/asm/uaccess.h Al Viro            2017-03-28 @26  extern unsigned long raw_copy_to_user(void __user *to, const void *from, unsigned long n);
f8d65d27e677da arch/um/include/asm/uaccess.h Richard Weinberger 2015-05-12 @27  extern unsigned long __clear_user(void __user *mem, unsigned long len);
12700c17fc2861 arch/um/include/asm/uaccess.h Arnd Bergmann      2022-02-15 @28  static inline int __access_ok(const void __user *ptr, unsigned long size);
f8d65d27e677da arch/um/include/asm/uaccess.h Richard Weinberger 2015-05-12  29  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
