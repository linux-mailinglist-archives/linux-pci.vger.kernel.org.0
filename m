Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE36F27F947
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 08:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbgJAGBT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 02:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730301AbgJAGBS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2020 02:01:18 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628ECC0613D0
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2020 23:01:18 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x123so3475305pfc.7
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2020 23:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f/SkpM6tbRsXOCCJlOhKUcxkHsc04pd7BesYNpcz9ko=;
        b=Hr4FGV6nGqJjSbz4H0Au/5QtVJc9aDthW/u7I9wGVNI5HnDmdDfLkPjviw82XVFaV9
         V4UOxi7Tf60XhgASsZR4CQDRH2ON/ayKFUd/jUc0XRiRrqK5ydEnO5LSL2C2GmJKA+l2
         uuOniiF0PcrjIIHH9sEy+59CkvMtFKXh7CLO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f/SkpM6tbRsXOCCJlOhKUcxkHsc04pd7BesYNpcz9ko=;
        b=tFqfqC4OzIuUYHF9p+74FqcZVAq6DOfIxghE/u76qlfLAtTDZ7COaNcaIfKozPe8Gg
         k7g3gbBfaCmXc2S7SZ4Yb+fRGR0yOhTS07M0fxqAzhiEaW274GV08rxH8nlJN8qkYibl
         zLNT8yKyMonTTws377JE3GiHVVeEcIh3LQm9UOO+z/lhB0A6eUoQl1wL/XP6mjcQsDCj
         +W/wh9RExUIiyjWsUQwzFg6qPWcOOZE/covUHtgdIM0qugbvf4jrBNDrkZkM5sNlSdFo
         HMFOyR0aeknu8eLbFvG1B/kFNYkXgZ9pnQcpMJlZHV8uRY3TpB8vIiA+bjmjPJhEL6hj
         ux/A==
X-Gm-Message-State: AOAM532LuZhsaL6VunYflrh4xYtds1CtwnT+IVIL6gl/S1+NH6Vmp2UA
        95dcU8yVGsQ4rOzeTtXWZntFnQ==
X-Google-Smtp-Source: ABdhPJxFndR3dwJs0uQsZn3nNsaM1j+1gfIn4Aj8SpyIqST2IsmV+tbPyVYjUBVypeLV9LvI4qpUug==
X-Received: by 2002:a62:520e:0:b029:142:2501:3979 with SMTP id g14-20020a62520e0000b029014225013979mr1172795pfb.62.1601532077798;
        Wed, 30 Sep 2020 23:01:17 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id l2sm4032112pjy.3.2020.09.30.23.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 23:01:17 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Roman Bacik <roman.bacik@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v3 2/3] PCI: iproc: Invalidate correct PAXB inbound windows
Date:   Thu,  1 Oct 2020 11:30:53 +0530
Message-Id: <20201001060054.6616-3-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001060054.6616-1-srinath.mannam@broadcom.com>
References: <20201001060054.6616-1-srinath.mannam@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000009d400a05b095be44"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--0000000000009d400a05b095be44

From: Roman Bacik <roman.bacik@broadcom.com>

Second stage bootloader prior to Linux boot may use all inbound windows
including IARR1/IMAP1. We need to ensure all previous configuration of
inbound windows are invalidated during the initialization stage of the
Linux iProc PCIe driver. Add fix to define and invalidate IARR1/IMAP1
because it was missed in previous patch.

Fixes: 9415743e4c8a ("PCI: iproc: Invalidate PAXB address mapping")
Signed-off-by: Roman Bacik <roman.bacik@broadcom.com>
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 drivers/pci/controller/pcie-iproc.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index d901b9d392b8..cc5b7823edeb 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -192,8 +192,15 @@ static const struct iproc_pcie_ib_map paxb_v2_ib_map[] = {
 		.imap_window_offset = 0x4,
 	},
 	{
-		/* IARR1/IMAP1 (currently unused) */
-		.type = IPROC_PCIE_IB_MAP_INVALID,
+		/* IARR1/IMAP1 */
+		.type = IPROC_PCIE_IB_MAP_MEM,
+		.size_unit = SZ_1M,
+		.region_sizes = { 8 },
+		.nr_sizes = 1,
+		.nr_windows = 8,
+		.imap_addr_offset = 0x4,
+		.imap_window_offset = 0x8,
+
 	},
 	{
 		/* IARR2/IMAP2 */
@@ -351,6 +358,8 @@ static const u16 iproc_pcie_reg_paxb_v2[IPROC_PCIE_MAX_NUM_REG] = {
 	[IPROC_PCIE_OMAP3]		= 0xdf8,
 	[IPROC_PCIE_IARR0]		= 0xd00,
 	[IPROC_PCIE_IMAP0]		= 0xc00,
+	[IPROC_PCIE_IARR1]		= 0xd08,
+	[IPROC_PCIE_IMAP1]		= 0xd70,
 	[IPROC_PCIE_IARR2]		= 0xd10,
 	[IPROC_PCIE_IMAP2]		= 0xcc0,
 	[IPROC_PCIE_IARR3]		= 0xe00,
-- 
2.17.1


--0000000000009d400a05b095be44
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
vmErFPzoLCSoF131XRIpgrbhLNi9IkOfU7tmNn6cdkoxASiobSGkkio2N1PWTZBPpKfik+OOAo8H
kQIDAQABo4IB0jCCAc4wDgYDVR0PAQH/BAQDAgWgMIGeBggrBgEFBQcBAQSBkTCBjjBNBggrBgEF
BQcwAoZBaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NwZXJzb25hbHNpZ24y
c2hhMmczb2NzcC5jcnQwPQYIKwYBBQUHMAGGMWh0dHA6Ly9vY3NwMi5nbG9iYWxzaWduLmNvbS9n
c3BlcnNvbmFsc2lnbjJzaGEyZzMwTQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUH
AgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwRAYD
VR0fBD0wOzA5oDegNYYzaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc3BlcnNvbmFsc2lnbjJz
aGEyZzMuY3JsMCYGA1UdEQQfMB2BG3NyaW5hdGgubWFubmFtQGJyb2FkY29tLmNvbTATBgNVHSUE
DDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBRpcoJiMWeVRIV3kYDEBDZJnXsLYTAdBgNVHQ4EFgQU
zNITc3dFEkM+jmMQc3Lwyyi3bSEwDQYJKoZIhvcNAQELBQADggEBAID0zJzfCJvIXZdUQvaJ2R8K
PqH211/mV+mEOqJsd0nM9XA/3QfXg1CSTt5d9dMrhUNqtbebI53ls4lA/r4p+D6/gS53cbNd+xxF
1lTbpXwrbPqa8h3oRDmttKWPeE4tGq6Npt5AgsVYgsKQCeiDicN2QfHSr+vLO1XnP/HHAZtdpwOw
fdegvyqihabnO/m+F5oMaBPUmzE+iQDKHmK2R3btmrFkZ8mIPEPM97mUf2J8LUrrThang9TN6edm
+X3T4mIB0kCJfTYzyaZ2zhYx2kDVdOfMO4HbkqHQc2fRuFTuVKgUf8xa5BK6Q8QV5sD1YxLGb+XL
TIRpMXJNiJf6eEMxggJvMIICawIBATBtMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxT
aWduIG52LXNhMTMwMQYDVQQDEypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hBMjU2
IC0gRzMCDDa88tbcUKwlq6jscjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQg18JS
wwluu3tOEYHirjq+vTvZCMg5JnDyrk3mqlzwmkMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAc
BgkqhkiG9w0BCQUxDxcNMjAxMDAxMDYwMTE4WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQB
KjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkq
hkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAFXHFNoF0pMBef121Sh3PoB6
BMY3cCGPclI7CLPg6cNyP1T0As5bE7dole6Ywn2Oi9HPcBMaUCT1jkRy6o/S6isk/FmEjaKArGb3
HOJwnx8luEZi/dFt94gGHBJ+uWGA+eAZ2xje/bAVnP9uytbh+UI2ak7Pa6309d0xososd7wGj3t2
OOn0c9/2ydM27FWd6OyqpEJqj262y2bgJSpuj+luq/t89A4T5sjaZ/WDZhnLllf5/MOIFMIJ3rFg
11aUbflr6B6F7/wZB7pXNEp6IdCHMD5I90t5d4wQs4NmNCIleysEGMSyvjsWmo7faHbcNaHAmSgx
R3KbFWHBV7+UmRU=
--0000000000009d400a05b095be44--
