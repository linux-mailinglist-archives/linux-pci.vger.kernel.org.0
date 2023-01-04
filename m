Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CFB65D61A
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jan 2023 15:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbjADOkm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Jan 2023 09:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239730AbjADOkD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2023 09:40:03 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FC4FCEF;
        Wed,  4 Jan 2023 06:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672843201; x=1704379201;
  h=message-id:date:mime-version:from:subject:to:cc:
   content-transfer-encoding;
  bh=6ZofUMm+cxxUEzHHPkg7Pjvp3X9FLpspJ38PZ2T64bE=;
  b=d7+jhHiNGseyYNMEicxWdbL3SQW78RCCUCtR5j/YITsihLPyX7ErA1Vo
   9bMjVjFlOlvG7tP2j9vS79Z5TmOeCCtfHyLgW0vHolBeqgIjJoJHYwzvU
   IgElgIaZFDr2L93z45qFOgUiK26PyKUgAu2+McTK3M9unGhBNHGDeofGj
   iGlrtFv9XkU84josEzp86dT2lxZpdTKZxTATB5/M4e0tJieY9eV2cjrPi
   Ad1hwM3a84vFDdRE8lrF+6oKJWsWHaEdrxT+P0HgtLqFD24lmYUJsviCy
   oIy4Qa34cpCNXHHXElV+0OwB6lcmHxopYSPNQ/ErBHYTqtdfBcjCWNkXy
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="384237996"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="384237996"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 06:40:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="900574761"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="900574761"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jan 2023 06:40:00 -0800
Received: from [10.252.212.169] (kliang2-mobl1.ccr.corp.intel.com [10.252.212.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id C36E4580A8B;
        Wed,  4 Jan 2023 06:39:57 -0800 (PST)
Message-ID: <ac2693d8-8ba3-72e0-5b66-b3ae008d539d@linux.intel.com>
Date:   Wed, 4 Jan 2023 09:39:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Subject: Bug report: the extended PCI config space is missed with 6.2-rc2
To:     bhelgaas@google.com
Cc:     hdegoede@redhat.com, kernelorg@undead.fr, kjhambrick@gmail.com,
        2lprbe78@duck.com, nicholas.johnson-opensource@outlook.com.au,
        benoitg@coeus.ca, mika.westerberg@linux.intel.com,
        wse@tuxedocomputers.com, mumblingdrunkard@protonmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        david.e.box@intel.com, yunying.sun@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Happy new year!

We found some PCI issues with the latest 6.2-rc2.

- Using the lspci -xxxx, the extended PCI config space of all PCI
devices are missed with the latest 6.2-rc2. The system we used had 932
PCI devices, at least 800 which have extended space as seen when booted
into a 5.15 kernel. But none of them appeared in 6.2-rc2.
- The drivers which rely on the information in the extended PCI config
space don't work anymore. We have confirmed that the perf uncore driver
(uncore performance monitoring) and Intel VSEC driver (telemetry) don't
work in 6.2-rc2. There could be more drivers which are impacted.

After a bisect, we found the regression is caused by the below commit
07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map").
After reverting the commit, the issues are gone.

Could you please take a look at the issues?

Thanks,
Kan
