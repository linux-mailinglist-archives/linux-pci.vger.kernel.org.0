Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7651A296F
	for <lists+linux-pci@lfdr.de>; Wed,  8 Apr 2020 21:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgDHTmN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Apr 2020 15:42:13 -0400
Received: from mga01.intel.com ([192.55.52.88]:36087 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbgDHTmM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Apr 2020 15:42:12 -0400
IronPort-SDR: dPmuqIvuGqchaJ1Bmlf0+RnrUNkJ7KdL/FJGUeCdGkYAjuZsEjT3vhLRO0wE6Ejxsq03KWqkF/
 2e0HBKweV22w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 12:42:12 -0700
IronPort-SDR: Hrl9SKo0H24KxPjD0M2aHXLOsn2+UsXwA2dsmJFb/OjNKFbGKRiHoxmD3WNBlGMPzI3X9bMrVv
 3KGbrKHVhV3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,359,1580803200"; 
   d="scan'208";a="254345502"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 08 Apr 2020 12:42:08 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jMGaO-0009Rz-1A; Thu, 09 Apr 2020 03:42:08 +0800
Date:   Thu, 9 Apr 2020 03:41:26 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, bp@alien8.de, james.morse@arm.com,
        helgaas@kernel.org, lenb@kernel.org, tony.luck@intel.com,
        dan.carpenter@oracle.com, gregkh@linuxfoundation.org,
        zhangliguang@linux.alibaba.com, tglx@linutronix.de
Subject: Re: [v7 PATCH 1/6] ACPI / APEI: Add support to queuing up the
 non-fatal HW errors and notify
Message-ID: <202004090342.eexW97It%lkp@intel.com>
References: <20200407120045.958-2-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407120045.958-2-shiju.jose@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Shiju,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v5.6]
[also build test WARNING on next-20200408]
[cannot apply to pm/linux-next pci/next linus/master linux/master]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Shiju-Jose/ACPI-APEI-Add-support-to-notify-non-fatal-HW-errors/20200408-014447
base:    7111951b8d4973bda27ff663f2cf18b663d15b48
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-188-g79f7ac98-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/acpi/apei/ghes.c:210:5: sparse: sparse: symbol 'ghes_gdata_pool_init' was not declared. Should it be static?
   drivers/acpi/apei/ghes.c:715:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/acpi/apei/ghes.c:715:25: sparse:    struct ghes_estatus_cache [noderef] <asn:4> *
   drivers/acpi/apei/ghes.c:715:25: sparse:    struct ghes_estatus_cache *
   drivers/acpi/apei/ghes.c:795:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/acpi/apei/ghes.c:795:25: sparse:    struct ghes_estatus_cache [noderef] <asn:4> *
   drivers/acpi/apei/ghes.c:795:25: sparse:    struct ghes_estatus_cache *

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
