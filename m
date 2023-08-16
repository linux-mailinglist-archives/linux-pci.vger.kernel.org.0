Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E46B77E780
	for <lists+linux-pci@lfdr.de>; Wed, 16 Aug 2023 19:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242857AbjHPRWD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 13:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345229AbjHPRVn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 13:21:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB412709
        for <linux-pci@vger.kernel.org>; Wed, 16 Aug 2023 10:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692206501; x=1723742501;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ANmMxD17e41soOPq9NMDsVaWbYaUwLNNqqoK5nsDsDo=;
  b=VNV4bc8pHOKOsUz6Y7Mga9ocrI3ztU0m9fvi9nsoC0nwdRgqxtyxbocK
   p9jfzpFIyiqPQTbxDsAw5IbTQuuKj5//H6D3Pxvq/f0iUIfH8pUVSGE2B
   giAE/CSAA/Zo7nPKTs+VUj8FuAGD5W1VncFRLfax5mQsQb4MWtk9+2zAW
   mb479zHDhRot/iDpnR8NssPM068i9jwhDODrHqDi4ZiJmdECVFgEkqTqW
   BIYyWmAklufJreMSb6NNo2xG9r2cS94HDidV5sXtvpGExdk/I4T+08gBJ
   9NWk1SfhQBCycZdOUS8LsXsY4CSNNSRO0mZswxYTUuCBSK/FUZP1eGVXY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="372596270"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="372596270"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 10:21:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="769280019"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="769280019"
Received: from bartoszp-dev.igk.intel.com ([10.91.3.51])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 10:21:36 -0700
From:   Bartosz Pawlowski <bartosz.pawlowski@intel.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com
Cc:     sheenamo@google.com, justai@google.com,
        andriy.shevchenko@intel.com, joel.a.gibson@intel.com,
        emil.s.tantilov@intel.com, gaurav.s.emmanuel@intel.com,
        mike.conover@intel.com, shaopeng.he@intel.com,
        anthony.l.nguyen@intel.com, pavan.kumar.linga@intel.com,
        Bartosz Pawlowski <bartosz.pawlowski@intel.com>
Subject: [PATCH 0/2] PCI: Disable ATS for specific Intel IPU E2000 devices
Date:   Wed, 16 Aug 2023 17:21:13 +0000
Message-ID: <20230816172115.1375716-1-bartosz.pawlowski@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series addresses the problem with A an B steppings of
Intel IPU E2000 which expects incorrect endianness in data field of ATS
invalidation request TLP by disabling ATS capability for vulnerable
devices.

Bartosz Pawlowski (2):
  PCI: Extract ATS disabling to a helper function
  PCI: Disable ATS for specific Intel IPU E2000 devices

 drivers/pci/quirks.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

-- 
2.41.0

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

