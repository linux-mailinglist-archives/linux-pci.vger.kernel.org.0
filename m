Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E643409C9D
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 21:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239178AbhIMTBU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 15:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238493AbhIMTBT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Sep 2021 15:01:19 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402AEC061574;
        Mon, 13 Sep 2021 12:00:02 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u15so10196549wru.6;
        Mon, 13 Sep 2021 12:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:from:cc:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5+LC83RmeuTS2KS2km7Yt9Gh9qYvhReIuEz7j6bACag=;
        b=n+7U03F0ZGURxI67egRWlNkdKMqkbLALs0cbKqkpr2YujLJz5f4WATC4Ny/nfkpJc4
         rb3B7Bm6cZXiErlfTfNh/igwGBokuDQRrawLzrQIWNvYGdwLNz8jWEC3t5Mg1T7mK7oG
         Evvl1wdR3uSS4aF7Z79QYdq+CKdIMe1LKkODBYrY4b6v8hcYBLz4xd/Ze/r6fVjlMnIe
         sFaTumylx0us1eeEuQS8KRkVjKnE1Yd0ePAcDjaqCRjyr8zysRY0+Qkw3NAvvLUfr7//
         KOLTXa3XGmYic3AIZAi4pFw1MF3dFlxzwT07ydc4y6Re3SRq0C1gqSB/42UE2FdFvkNm
         beEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:references:from:cc:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5+LC83RmeuTS2KS2km7Yt9Gh9qYvhReIuEz7j6bACag=;
        b=CIcDLtn/RUnii0iFAkMbEXomTmjjGmSHJAGR8gbmU4diIw5TyyPGvsUVRBj/ftc37U
         MHR+RV3ovVQ2waBw1X8ihSUVzyPbuzJYg5R4Qjx/QeW6E2mH1d64tNkeKLUVuK+KuL0X
         6rBmI+Hvq6zaZxFUweKa2NdrVzU8w1rKED96H6Unup+WKW7ipbRGYd2tTCEmu8nj4SEF
         WzY6RduLKnZUCqFkP0k9Ym7sd8JHpIXOOf1PLsuX2AzM99jHCZ0628y7MXAgwxQKSxFr
         swesKsJOnjXphLmNRzCeP+hhWEdDqAP0+tUFfHqAFhNQOx2SCbGhgVixlVLEinre+T/8
         IuhQ==
X-Gm-Message-State: AOAM531LRzC9hBYmm/Ozd8p41D58LNGK8SKASkPCicbBDQD5n1nQB+f4
        s2zK4qQW8ProUXAIb/txpgXWeQWpLYM=
X-Google-Smtp-Source: ABdhPJwNTt3XYuQF3KJKOMVSn5SpK+OQFSscwZL8ZDqdu6WDhONSg5UJtHhAJA9E7qiws8pyBxz+iA==
X-Received: by 2002:a05:6000:1186:: with SMTP id g6mr14617821wrx.126.1631559600570;
        Mon, 13 Sep 2021 12:00:00 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f08:4500:2517:8cca:49d8:dcdc? (p200300ea8f08450025178cca49d8dcdc.dip0.t-ipconnect.de. [2003:ea:8f08:4500:2517:8cca:49d8:dcdc])
        by smtp.googlemail.com with ESMTPSA id n7sm4225211wms.18.2021.09.13.11.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 12:00:00 -0700 (PDT)
To:     Dave Jones <davej@codemonkey.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <CAHk-=wgbygOb3hRV+7YOpVcMPTP2oQ=iw6tf09Ydspg7o7BsWQ@mail.gmail.com>
 <20210913141818.GA27911@codemonkey.org.uk>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Linux 5.15-rc1
Message-ID: <ab571d7e-0cf5-ffb3-6bbe-478a4ed749dc@gmail.com>
Date:   Mon, 13 Sep 2021 20:59:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210913141818.GA27911@codemonkey.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 13.09.2021 16:18, Dave Jones wrote:
> [  186.595296] pci 0000:02:00.0: [144d:a800] type 00 class 0x010601
> [  186.595351] pci 0000:02:00.0: reg 0x24: [mem 0xdfc10000-0xdfc11fff]
> [  186.595361] pci 0000:02:00.0: reg 0x30: [mem 0xdfc00000-0xdfc0ffff pref]
> [  186.595425] pci 0000:02:00.0: PME# supported from D3hot D3cold
> [  186.735107] pci 0000:02:00.0: VPD access failed.  This is likely a firmware bug on this device.  Contact the card vendor for a firmware update

Thanks for the report! The stalls may be related to this one. Device is:
02:00.0 SATA controller: Samsung Electronics Co Ltd XP941 PCIe SSD (rev 01)

With an older kernel you may experience the stall when accessing the vpd
attribute of this device in sysfs.

Maybe the device indicates VPD capability but doesn't actually support it.
Could you please provide the "lspci -vv" output for this device?

And could you please test with the following applied to verify the
assumption? It disables VPD access for this device.

---
 drivers/pci/vpd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 517789205..fc92e880e 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -540,6 +540,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x002f, quirk_blacklist_vpd);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x005d, quirk_blacklist_vpd);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x005f, quirk_blacklist_vpd);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATTANSIC, PCI_ANY_ID, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SAMSUNG, 0xa800, quirk_blacklist_vpd);
 /*
  * The Amazon Annapurna Labs 0x0031 device id is reused for other non Root Port
  * device types, so the quirk is registered for the PCI_CLASS_BRIDGE_PCI class.
-- 
2.33.0






