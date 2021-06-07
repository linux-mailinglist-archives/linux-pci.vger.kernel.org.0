Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E61439DB4A
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jun 2021 13:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhFGLbG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Jun 2021 07:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbhFGLbG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jun 2021 07:31:06 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59343C061766;
        Mon,  7 Jun 2021 04:29:02 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id d5-20020a17090ab305b02901675357c371so11383874pjr.1;
        Mon, 07 Jun 2021 04:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s2L4tYN9T2oQX4O1kr58WBVXgDkzYtStMb3pXHicmtE=;
        b=hw1jcRVoZfd8OCg2rNy1L04fHgqFfCamU2TaDAyBteW1Uk48qkDn4Bv3Vlt8xJhFHm
         TEItYgqZuY1UzhOl+6bGjrwQXGqN+uhfZHHUhYdrYfauzFBBci/TCFrNIO4ft6/I38JS
         izSQdMjuvJoN+4HMkYBadqAcY/Zyqmnk3So5CzMuXuDxAi3YrMgaC12UFkHdwNltGLKN
         iuvANy880xa4Aaa6AkeeGkD64FAfAC494/VUnO8yR9fXZYICLO9CqdIrJGj6wFKdbUU8
         PJWIO79xVVHmwVjpsbf2JxqOVYpTzDlqPuCULsCWJP7Q8BLihsmvrfSr4alRTEEKsdhm
         YjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s2L4tYN9T2oQX4O1kr58WBVXgDkzYtStMb3pXHicmtE=;
        b=q8KDWDjdablDQZeildpR/+OWukftmo/Bc1uglfIeqBvk4rwCCoiSYakCGOSqrLEH2D
         SeAs2/tGZSkMElWHsh6Guk/XPAVF33qo7gYJ1QAQy+MOVFYFo0R3ZMvbDw+IF7kGfmoL
         cGaFtbaVquVVmhjKZyu3Zm1RA1k84LgmjAv3PtPEYnqidB+AdZUj6p3skl88Vd3Wkgb2
         Zw9UG+zc8P052SjrNQ4n6NMxuljKO/f8oU0yZWmBKIzRYfePLAPDu5tUabRU0OUDOx4F
         Vlpy+Lihy/eHUPdP32eNvmJ0S6t/S3ecR5CRybHjddroIZ9meTQJP0FAdn82sWgJAlQT
         AcxQ==
X-Gm-Message-State: AOAM533JXF9rWF3/q1H2Yz7wi/CSmRRlPKeyHlFBX9BkeoWzx3uLn8kV
        V9pTbthkd1CYIHSgxF3L2nZY4LhwiLdSTA==
X-Google-Smtp-Source: ABdhPJzO65vTHb75QGy1Uo3TQ6gGFz3uqNg849yGqzhCnOb+mkkqAalUvxzKttOrbVxACJ4ONOkqeQ==
X-Received: by 2002:a17:902:b58a:b029:fe:735f:ddbf with SMTP id a10-20020a170902b58ab02900fe735fddbfmr17056776pls.68.1623065341806;
        Mon, 07 Jun 2021 04:29:01 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id k6sm1576398pfa.215.2021.06.07.04.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 04:29:00 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     helgaas@kernel.org, robh+dt@kernel.org
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, alexandru.elisei@arm.com, wqu@suse.com,
        robin.murphy@arm.com, pgwipeout@gmail.com, ardb@kernel.org,
        briannorris@chromium.org, shawn.lin@rock-chips.com
Subject: [PATCH v3 0/4] PCI: of: Improvements to handle 64-bit attribute for non-prefetchable ranges
Date:   Mon,  7 Jun 2021 20:28:52 +0900
Message-Id: <20210607112856.3499682-1-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

This is the third iteration to improve handling of the 64-bit
attribute on non-prefetchable host bridge ranges. Previous version can
be found at [0][1].

This version is a small update over the previous version - changelog
below. If there is no futher feedback on the patches, please consider
merging them.

Thanks,
Punit

Changes:
v3:
* Improved commit log for clarity (Patch 1)
* Added Tested-by tags

v2:
* Check ranges PCI / bus addresses rather than CPU addresses
* (new) Restrict 32-bit size warnings on ranges that don't have the 64-bit attribute set
* Refactor the 32-bit size warning to the range parsing loop. This
  change also prints the warnings right after the window mappings are
  logged.


[0] https://lore.kernel.org/linux-arm-kernel/20210527150541.3130505-1-punitagrawal@gmail.com/
[1] https://lore.kernel.org/linux-pci/20210531221057.3406958-1-punitagrawal@gmail.com/

Punit Agrawal (4):
  PCI: of: Clear 64-bit flag for non-prefetchable memory below 4GB
  PCI: of: Relax the condition for warning about non-prefetchable memory
    aperture size
  PCI: of: Refactor the check for non-prefetchable 32-bit window
  arm64: dts: rockchip: Update PCI host bridge window to 32-bit address
    memory

 arch/arm64/boot/dts/rockchip/rk3399.dtsi |  2 +-
 drivers/pci/of.c                         | 17 ++++++++++++-----
 2 files changed, 13 insertions(+), 6 deletions(-)

-- 
2.30.2

