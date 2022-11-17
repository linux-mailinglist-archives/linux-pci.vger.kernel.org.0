Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FC562E20D
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 17:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240726AbiKQQft (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 11:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239529AbiKQQfM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 11:35:12 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4B240456
        for <linux-pci@vger.kernel.org>; Thu, 17 Nov 2022 08:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668702882; x=1700238882;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I8FtnqGRw7xhM/jGkYFBkKYtoa4+KC/THndE7SN6I2k=;
  b=doPfzSsKbnuNW+bcFJFZ53ZrOokXdXs3dJnToBcZxiaRqFYqaDpL4mS9
   XQfZHWcBShxELh/9qIA1pWhwHGYwQ+GmUyzwbuVc4xiW6XAFWi/n8NIkv
   j2oo8NLlidMWOit2Y4rMD8nnqdzTyKh79DeTK4SoMmoOPoNx1Zl2ZBHbF
   bvtRFmhuphorVeatDMYKQXxMV5qpqQkgFlaH22laNEjv9AyAXs/AGWLEs
   D74foN2kxoz19J5/Mmmbtx/h1zXLUTOczeDe/qjEsk3NyTQOGO/poqeVg
   ajndxSyR4PD5jr0GCPTnujCZ9J2iqC08NGpdB//wxuumQqsE0k6UqImBs
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="296262845"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="296262845"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 08:34:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="642155433"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="642155433"
Received: from mtkaczyk-devel.elements.local ([10.102.105.40])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 08:34:40 -0800
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, stuart.w.hayes@gmail.com,
        dan.j.williams@intel.com
Subject: [PATCH 0/3] Enclosure sysfs refactor
Date:   Thu, 17 Nov 2022 17:34:04 +0100
Message-Id: <20221117163407.28472-1-mariusz.tkaczyk@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,
I agreed with Stuart to take over the NPEM implementation[1].
First part I want to share is a small refactor around enclosure interface.

The one sysfs change introduced is changing active LED to write-only.
get_active() callback is not implemented for SES which is the
only one enclosure API consumer now.

[1] https://lore.kernel.org/linux-pci/cover.1643822289.git.stuart.w.hayes@gmail.com/

Mariusz Tkaczyk (3):
  misc: enclosure: remove get_active() callback
  misc: enclosure, ses: simplify some get callbacks
  misc: enclosure: update sysfs api

 drivers/misc/enclosure.c  | 96 ++++++++++++++++-----------------------
 drivers/scsi/ses.c        | 33 ++++++++------
 include/linux/enclosure.h | 14 ++----
 3 files changed, 61 insertions(+), 82 deletions(-)

-- 
2.26.2

