Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50BD352950
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 12:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731283AbfFYKXb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 06:23:31 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33032 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726301AbfFYKXb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Jun 2019 06:23:31 -0400
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 8453260D02D8B346C6FA;
        Tue, 25 Jun 2019 11:23:29 +0100 (IST)
Received: from [127.0.0.1] (10.202.227.157) by LHREML712-CAH.china.huawei.com
 (10.201.108.35) with Microsoft SMTP Server id 14.3.408.0; Tue, 25 Jun 2019
 11:23:22 +0100
From:   Wei Xu <xuwei5@hisilicon.com>
Subject: [GIT PULL] Hisilicon fixes for v5.2
To:     <arm@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>, <arnd@arndb.de>
CC:     <linuxarm@huawei.com>, "xuwei (O)" <xuwei5@huawei.com>,
        John Garry <john.garry@huawei.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhangyi ac <zhangyi.ac@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        <jinying@hisilicon.com>, huangdaode <huangdaode@hisilicon.com>,
        Tangkunshan <tangkunshan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>
Message-ID: <b89ef8f0-d102-7f78-f373-cbcc7faddee3@hisilicon.com>
Date:   Tue, 25 Jun 2019 11:23:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.157]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi ARM-SoC team,

Please consider to pull the following changes.
Thanks!

Best Regards,
Wei

---

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hisi-fixes-for-5.2

for you to fetch changes up to 07c811af1c00d7b4212eac86900b023b6405a954:

  lib: logic_pio: Enforce LOGIC_PIO_INDIRECT region ops are set at registration (2019-06-25 09:40:42 +0100)

----------------------------------------------------------------
Hisilicon fixes for v5.2-rc

- fixed RCU usage in logical PIO
- Added a function to unregister a logical PIO range in logical PIO
  to support the fixes in the hisi-lpc driver
- fixed and optimized hisi-lpc driver to avoid potential use-after-free
  and driver unbind crash

----------------------------------------------------------------
John Garry (6):
      lib: logic_pio: Fix RCU usage
      lib: logic_pio: Avoid possible overlap for unregistering regions
      lib: logic_pio: Add logic_pio_unregister_range()
      bus: hisi_lpc: Unregister logical PIO range to avoid potential use-after-free
      bus: hisi_lpc: Add .remove method to avoid driver unbind crash
      lib: logic_pio: Enforce LOGIC_PIO_INDIRECT region ops are set at registration

 drivers/bus/hisi_lpc.c    | 43 ++++++++++++++++++++----
 include/linux/logic_pio.h |  1 +
 lib/logic_pio.c           | 86 +++++++++++++++++++++++++++++++++--------------
 3 files changed, 99 insertions(+), 31 deletions(-)

