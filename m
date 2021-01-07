Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4670A2EE7D7
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jan 2021 22:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbhAGVsO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jan 2021 16:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbhAGVsO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jan 2021 16:48:14 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23578C0612F4
        for <linux-pci@vger.kernel.org>; Thu,  7 Jan 2021 13:47:34 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id t30so7080647wrb.0
        for <linux-pci@vger.kernel.org>; Thu, 07 Jan 2021 13:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=8dITAzHZYs/du4VcpqJHmUAvO8/IHxBA4t9PFARdWoM=;
        b=unsc7FvRQfwAAZ/mmtVuQv60+pEWfEB3wLVqcB7hPX6rCMeIWLSEF8m7AaBq0Xt4n+
         usdK8Mjs/lyXHkSucJHop4hxXjjyrUrxqikqjTHZyDcpIbBIIHW86y7xSBsLOn7Gz9xT
         qLAXsK8IDgOxYa1GpaT6vUfeyRu/GcHM+akxsNkgK/ovECJwIEPSBzIoUgicVNj6OXKY
         MVomjL7X3rnydndL8fsw/P7ODZe7hjoERMk6DCaOM9le4h3vpZBZ76xn1K5m/EAlRQyL
         cSe4DHzMYRJwcpYhjMK/eeeTiVcAH1/iNX8WMUyNF1EKng07IXNT28Turw+t89LxFTMo
         dHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=8dITAzHZYs/du4VcpqJHmUAvO8/IHxBA4t9PFARdWoM=;
        b=OBPRsHwCAANeWkH/6b3iXwrtRz/385rm/bQfCc24RRdGblsmTLr0RvNKSfyhB25Ckd
         WrVp0SJD6X4gMFtrGpC487B15lFiymp5H4+KGCYztvevrqQIN8zKUOb2zt3X1BIIsKq9
         iO0cstvfeNSKeGF4pPyq9TYta2I8i+oUnon7RLAr10Z9xHgQC6odfMYqtMADIDDtSpry
         xQsXxCiKaOZmuxDJZ/jibjuSgQGgBwTtPc3LCazp3l3optKD/9EXmp03wFbgyWxwWKBE
         VwIaqvWSTJ3fN034BHN8yE2zVpmQgGNg5zmnR+8y3mS1E/HK71AQ8nCNbQzTKIudRf0F
         sthA==
X-Gm-Message-State: AOAM533j1tNbWpLDSlCekBjk6Unt7mxolYs7RjqRkFsT/Uh/oAFemT0v
        56KBRqEWh5rxg0Dh3pChQ0BV37hUMew=
X-Google-Smtp-Source: ABdhPJyVVGVXKH2LTu1VMRF2rlwUoj8nmAw5mrXZUqXtV0q6EKzZL7RR2iHepe9TdXYVo0WmCy98ew==
X-Received: by 2002:adf:82c8:: with SMTP id 66mr570634wrc.420.1610056052676;
        Thu, 07 Jan 2021 13:47:32 -0800 (PST)
Received: from ?IPv6:2003:ea:8f06:5500:bc23:c288:f1cf:8157? (p200300ea8f065500bc23c288f1cf8157.dip0.t-ipconnect.de. [2003:ea:8f06:5500:bc23:c288:f1cf:8157])
        by smtp.googlemail.com with ESMTPSA id r1sm10410632wrl.95.2021.01.07.13.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 13:47:32 -0800 (PST)
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 0/2] PCI/VPD: Improve handling binary sysfs attribute
Message-ID: <dba8e8ad-5243-ee84-38bd-f2b131f4b86f@gmail.com>
Date:   Thu, 7 Jan 2021 22:47:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since 104daa71b396 ("PCI: Determine actual VPD size on first access")
there's nothing that keeps us from using a static attribute.
This allows to significantly simplify the code.

Heiner Kallweit (2):
  PCI/VPD: Remove dead code from sysfs access functions
  PCI/VPD: Improve handling binary sysfs attribute

 drivers/pci/vpd.c | 56 ++++++++++-------------------------------------
 1 file changed, 11 insertions(+), 45 deletions(-)

-- 
2.30.0

