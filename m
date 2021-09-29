Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B8141CD82
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 22:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346690AbhI2Ume (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 16:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbhI2Ume (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 16:42:34 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF5DC06161C
        for <linux-pci@vger.kernel.org>; Wed, 29 Sep 2021 13:40:53 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id o124so4609097vsc.6
        for <linux-pci@vger.kernel.org>; Wed, 29 Sep 2021 13:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gigaio-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=2r1W/Qcm7qhhKF/KPOtAce3RPxHcy+HJCfpzFHM6WT4=;
        b=hVpcUC5yzowqW75GLv4RNafTgpHxqs7+rv9kpee4sH3RRHBesK3QIxEzw4RSYgctXe
         zvpMMTf2tdZRgBicD8yI92WHZ6D5fheCqDSl6e2WOzG8wiFc33qNVS0QqxogMbFIR9ay
         lQGnqstmU8LRNcuBWBYRt6plWcu6hntesShfgrihIrDfUiOnZRsQg+hMawmqYfinkg8X
         bBIIeh4et5seRxPdoNbbpPjW8dKSgDlR09q8+TLTZuVfkoAZ0Ai3vkQR09s99O5TEXJO
         JwEq225/y07DCer6HH2llK0NenSZVyZoM79Gxz1xepqOXo6bUdgjPzmhVjuYfh1zoPBl
         O05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2r1W/Qcm7qhhKF/KPOtAce3RPxHcy+HJCfpzFHM6WT4=;
        b=n42Z9CoPFc+rQiusT7WnZTs97j5uU+AIGLFOABqtJGt36StW3DxbuSsnBmTEa5MuYX
         2qeKZzaYjg1uMhsE2ZcTA9YQJ1on+WhSFCT57Pgm2V3M/fLP9pbAcJk81z0atc3lQTsv
         KNwZFNGDeMu5Rr6GuydIzf3jzlbfW2OaRnzoBL3gnxZaV+09Ht39wURtskdLfGxvp6++
         kLmzTTHEwgovpZPKkGRxPW6YFv++kc1hFMAtsGxbiqBkVpefjNs0Jk6F7UxL0q7Xcp6d
         0Iu0AMrNdERQNiMEg0MrENkf44K8oHXjIZzGuSIAW5JV8jageYra72ajikFBOkJ1pirF
         thOg==
X-Gm-Message-State: AOAM532Jxjb+S03myURUvpM1dpdZ9QzGaovxGmdO/vyLpUeICgna5DZi
        86XkZzUKK9k/XpnJcH5gj9Lw61E9SJDV2JDLvEq2Rc335e4wzg==
X-Google-Smtp-Source: ABdhPJxId+ZL5czZpOxR29NboAV2QB2N01g5alvS2o4DTTOiQYQ2MkoAoWMVw1c5x9bYYQfUz6NnE5ZvFoD5gBSMZ0U=
X-Received: by 2002:a05:6102:b13:: with SMTP id b19mr313473vst.37.1632948051936;
 Wed, 29 Sep 2021 13:40:51 -0700 (PDT)
MIME-Version: 1.0
From:   Eric Pilmore <epilmore@gigaio.com>
Date:   Wed, 29 Sep 2021 13:40:41 -0700
Message-ID: <CAOQPn8upeB5aCaDM7k5nLBg6Gya-tE2xUSA_VHxQgXcRBaoLKQ@mail.gmail.com>
Subject: Ice Lake PCIe Read TLPs with random RequesterIDs (RIDs)
To:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I am curious to know if anybody working with Ice Lake has seen this
behavior where the MemRD TLPs, from a "cpu(s)" issuing I/O Reads
to an I/O device, are carrying varying RequesterID (RID) values that
don't represent any enumerated devices (per lspci) in the system?
The particular system in use is a Supermicro box with 2 CPU sockets,
each socket comprised of a 16 core (2 thread/core) processor. I have
not seen any correlation between issuing the I/O Read operation from
a particular core and the RID that shows up in the respective MemRD
TLP. Normally, I would have expected the RID to have been either 0x0000
or the BDF of the respective Root Port into which the device being
read was plugged into.

I assume this behavior is intended to increase I/O bandwidth and reduce
latency by allowing even more outstanding I/O Reads than is normally
afforded by the (per-device) Tag field of a MemRD TLP.

I have been searching around, but having trouble finding specifics about
this behavior in any specs or micro-architecture documents. If anybody
knows of any pointers it would be greatly appreciated.

Thanks in advance!

Eric



-- 
Eric Pilmore
epilmore@gigaio.com
http://gigaio.com
Phone: (858) 775 2514

This e-mail message is intended only for the individual(s) to whom
it is addressed and may contain information that is privileged,
confidential, proprietary, or otherwise exempt from disclosure under
applicable law. If you believe you have received this message in
error, please advise the sender by return e-mail and delete it from
your mailbox.
Thank you.
