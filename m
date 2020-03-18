Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5185D189AD1
	for <lists+linux-pci@lfdr.de>; Wed, 18 Mar 2020 12:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgCRLiX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Mar 2020 07:38:23 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:36222 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgCRLiX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Mar 2020 07:38:23 -0400
Received: by mail-ot1-f41.google.com with SMTP id 39so9699197otu.3
        for <linux-pci@vger.kernel.org>; Wed, 18 Mar 2020 04:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=eTyhRpsbG0kZyPAzv+dy/wYvyIITKWnTbwXBIUvSGbA=;
        b=oif1guY36swCU6CoNPFUeyKB4o5nBLKMzDm2eVFyaDdoJH4PfPpT2Va1c3TmAQfBYk
         iwIeIlHlLLsZ7ETT+LDvhBffsGUH3WzQJ+RrdMwIQSRSiDmetyEv0FBqdZjYS/s5B/q6
         hPAeEFTiX0ZJTeRGlOcMOhekdvEVBWRsZizjIsTGQrZwNWLcLtNeeslBXjhvbsJ7XjK3
         dVZZQS03D7w/StpJm2+/aCa0vIdyOc+le1P3gNvDm0Iv2SqSasHkNVjUpkIKxuCADOMJ
         4f9feGDgKpTARbyZRRB3h5Pb1yHFzIUEezU0eSBQZ7my7HvJci4GBVCByIHh3L7p2mOf
         d3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=eTyhRpsbG0kZyPAzv+dy/wYvyIITKWnTbwXBIUvSGbA=;
        b=l/7wlp6UVoAKD4LfC4HWk/STafYHHs3W4TQ+9/1pOqanVl/QRB6CmhWxeIDtQU4IC/
         gB0ZmPNbvxXocjaJ318/O95CcQt5xDuUGaJyGiB2AA8nen9Mok91TtGNpc8ER5v6tMNX
         X9D1f76fkIsEC0wMqeyQoNxlI3k+mOYpHNdO5G7i9ytpnQFI5RqgXONtz5kqhOe7JupH
         nq9nxvlXcZcLGXdiSx0cjW4FohfX/06QBEt8eQU0TzFarq3Stk8oHNwnBbsafrJSzQzG
         PmiIjO4Qp+AFMUwSWY5+I7Og6REfPc16peUD0yUGelGdzNrKgWHYrhALbwg9NmSmKk1p
         gP5A==
X-Gm-Message-State: ANhLgQ3MxQ8U44aVMcx7LiWJ42k2hY3zDH817fI/GZ3Lq9s90v8dewwf
        np3LNhcEw1xf1NPK5E4pukSE6AR9JR1Bv4AC3uy1Vti70wU=
X-Google-Smtp-Source: ADFU+vt802eDl6yomu15vpnLPvcS8ld8HnLbzt3u15BU1CjiB3NLVoljNzfkWSvSOnr7FkTu64rHz5SfrGHJJw0TNU4=
X-Received: by 2002:a05:6830:20c9:: with SMTP id z9mr3482440otq.44.1584531502669;
 Wed, 18 Mar 2020 04:38:22 -0700 (PDT)
MIME-Version: 1.0
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 18 Mar 2020 11:37:56 +0000
Message-ID: <CA+V-a8vOwwCjRnFZ_Cxtvep1nLMXd5AjOyJyispg1A1k_ExbSQ@mail.gmail.com>
Subject: PCIe EPF
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,

I rebased my rcar-endpoint patches on endpoint branch, which has
support for streaming DMA API support, with this  read/write/copy
tests failed, to make sure nothing hasn't changed on my driver I
reverted the streaming DMA API patch
74b9b4da84c71418ceeaaeb78dc790376df92fea "misc: pci_endpoint_test: Use
streaming DMA APIs for buffer allocation" and tests began to pass
again.

If add a GFP_DMA flag for kzalloc (with streaming DMA), the test cases
for read/write/copy pass as expected.

Could you please through some light why this could be happening.

Cheers,
--Prabhakar Lad
