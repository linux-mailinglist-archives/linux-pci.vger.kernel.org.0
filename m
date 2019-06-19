Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 130254BEF9
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2019 18:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbfFSQvd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jun 2019 12:51:33 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45464 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfFSQvd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jun 2019 12:51:33 -0400
Received: by mail-io1-f66.google.com with SMTP id e3so63253ioc.12
        for <linux-pci@vger.kernel.org>; Wed, 19 Jun 2019 09:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pIqS+MROFJjOixyioIUASebStshnulF4G/lhsIs9a1g=;
        b=VOZRNY0SYUY+xp+PFkmzaV6myp9AYxE9JPumfUZFMbB439326pahueTbaT8VVDaqdd
         wBY6BZJ3gDiXSP9r0aS1QSWZa7gW9uepa7JkIscFL06wnhaqKPk7GJwVxeyjosLXe7JN
         eKpdoAFKs1SoNAYiskEqz2IhBq2ridgreA+LmNkiNk/7S700PpgNxLXKW0PYrfVQ6+Vl
         b1JH0lLzmIkUuH4gRtMTk9iUOZNNIq5WZI5A7wuYmwyPBoo3A+aVQdH9MVl6gyMRI7aB
         hFm9TPUDF9pHwkALzeD0By4JnW0/YJn6Qh8TPhjc3reZJgJlJEHUi1cJRQzgTFlRAVJd
         r13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pIqS+MROFJjOixyioIUASebStshnulF4G/lhsIs9a1g=;
        b=IU6MKkW9JQqN5HWjAK8R5cx7UZdfR9qv4IgN639l/RoA04zLILhesHTeLFloJoyjPZ
         0oOJcfEqDbqfP27GFzYehjwU7VNnHgxnviLjPkkokoCSJTMOYApQ6a06QyuMhhjhvyMK
         un+1GagG5qsfkOVeOoi1P2EP4WrzeS17qdNRmBSRnzET3mDmtVMf1Ab0NsheqyGZGs/Q
         Vl00o7M+8jxS5y3qnPSjQYvtJhhB4YWWmi6qkyvrsy8mBG+oWEZt2lvDz2G+z/MS4n5G
         PURRCkkfBOsIgxVW4y2Wqg1pzXmIuVkgx5DZBXoNlW0p101l4DETepQPXR2Kjkol8GKs
         uVRQ==
X-Gm-Message-State: APjAAAWBkHTqGwHsKuKo+rWzXBl6uei4BPNfphp7xCOb+UHF9xcjp96w
        QUbd/NiedUA2ZG1kvnHCu5s8QxdXtU9EdQ==
X-Google-Smtp-Source: APXvYqxLNTXoLxaKKPis8X7QC+SXzik32bO+/tdrUsqGrMR20ZVaah2i4axfVuis5IyI56rgUgf30g==
X-Received: by 2002:a5d:9d42:: with SMTP id k2mr12713062iok.45.1560963092028;
        Wed, 19 Jun 2019 09:51:32 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id f4sm17863408iok.56.2019.06.19.09.51.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 09:51:31 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org, mj@ucw.cz,
        bjorn@helgaas.com, skunberg.kelsey@gmail.com
Subject: [PATCH v4 0/3] lspci: Update verbose help and show_range()
Date:   Wed, 19 Jun 2019 10:48:55 -0600
Message-Id: <20190619164858.84746-1-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes since v1:
  - Expand changes into more patches for easier review.
  - Combine three patches for lspci.c into patchset.

  * Patch 1: lspci: Include -vvv option in help
    No changes made. Added to series for review.

  * Patch 2: lspci: Remove unnecessary !verbose check in show_range()
    Move into it's own patch since v1. Dead code which checks for
    verbosity to be true.

  * Patch 3: lspci: Replace output for bridge with empty range from
    "None" to "[empty]"
    Patch builds off Patch 2 to change show_range() output to be more
    consistent between each level of verbosity.

Changes since v2:
  * Patch 1: Update commit log to imperative mood

  * Patch 2: Fix logical error
        Previous:
        (base > limit || verbose < 3)
        New:
        (base > limit && verbose < 3)

  * Patch 3: Fix logical error
        Previous:
        base > limit
        New:
        base <= limit

Changes since v3:
  * Patch 1 and 2: No change
  * Patch 3: Change output from "[empty]" to "[disabled]"

Kelsey Skunberg (3):
  lspci: Include -vvv option in help
  lspci: Remove unnecessary !verbose check in show_range()
  lspci: Change output for bridge with empty range to "[disabled]"

 lspci.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

--
2.20.1

