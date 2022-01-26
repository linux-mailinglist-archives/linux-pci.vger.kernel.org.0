Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB57449C303
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jan 2022 06:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbiAZFYA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jan 2022 00:24:00 -0500
Received: from mga17.intel.com ([192.55.52.151]:46665 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229691AbiAZFX7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Jan 2022 00:23:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643174639; x=1674710639;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VAAD+TueKcO3yWsENF5eR+Zwzsq2qza8sccWNpnGYbo=;
  b=LyY9CrpJIEc4SBerVeAUegGsc6jBfHW4oR54UVeM4KzVXM84pD6zS23U
   lS9SnJhW2vN46ltchOwzdvplEAf8ZSSnZajaUBfdXvLmVQ1+284kX/wq6
   upie6BROaRqfjVBPYHaaah1DENshMeOudGCybLffjSadSaWypaHejW31Y
   jj+CKJxHZrqjji6evGWe8nxnLSIUIB8DZ0m3m3twpcMQPwqV0bP4gNrvZ
   rsudHswgWUWUEOKRgc/llpNI8RSkdzaOQKsbsn8PdPtKwMSbTpXX/3+jT
   rXBCN3fbommYCRuwZrjjShXEQSx+YhI4ff8UJ3td5mxHlET3bqgspaCzc
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="227156681"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="227156681"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 21:23:59 -0800
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="628195580"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 21:23:59 -0800
Subject: [PATCH 0/2] cxl/port: Robustness fixes for decoder enumeration
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, nvdimm@lists.linux.dev,
        ben.widawsky@intel.com
Date:   Tue, 25 Jan 2022 21:23:58 -0800
Message-ID: <164317463887.3438644.4087819721493502301.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Further testing of the decoder toplogy enumeration patches found cases
where the driver is too strict about what it accepts. First, there is no
expectation that the decoder's target list is valid when the decoder is
disabled. Make decoder_populate_targets() failures non-fatal on disabled
decoders. Second, if the decoder emits out-of-bounds / reserved values
at init warn and continue if at least one valid decoder was found. This
future-proofs the driver against changes to the interleave_ways
encoding, at least for continuing to operate decoders that conform to
current expectations.

Applies on top of:

https://lore.kernel.org/r/164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com

---

Dan Williams (2):
      cxl/core/port: Fix / relax decoder target enumeration
      cxl/core/port: Handle invalid decoders


 drivers/cxl/acpi.c      |    2 +-
 drivers/cxl/core/hdm.c  |   36 ++++++++++++++++++++++++++++++------
 drivers/cxl/core/port.c |    5 ++++-
 3 files changed, 35 insertions(+), 8 deletions(-)
