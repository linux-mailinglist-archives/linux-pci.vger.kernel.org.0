Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1ED27F945
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 08:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgJAGBO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 02:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgJAGBO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2020 02:01:14 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEF7C0613D0
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2020 23:01:14 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id u24so3198672pgi.1
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2020 23:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n/EKXhfktXa8OD3A0+KlBuM2uKvfFs6/Sk7F67lxoIM=;
        b=J9cegQ27GhtaMCmVvEukmBJixsp27ubstP/U5uFHPQA0qAXwdYIt+Pmk9qG1fc8OtR
         mZL4wgEsbuCjkxaUBxWfCv6l9cbBMyjSAMyH211V7HkRclSmK5xD64mv3JI8k0fFuRj8
         mV9+s0u91HfRt+b27GfXkE+qyInG1y8Z5XmiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n/EKXhfktXa8OD3A0+KlBuM2uKvfFs6/Sk7F67lxoIM=;
        b=Q5ylRgYo4ShBkLIKI7IKJmtRU8D9IA704OWtBTNQ7zcxObQazW0hNQIdpObb+wowPx
         tN3XcFrxDUhgFa7kM0kOYAuIcFuivadc+yhBc5TVCPvHT7wG7ncnEer9dk0C7DHY1g/4
         zYT7qbunTa84Ny3SDPmL46xRvCCDPpQwKNvHZ7kr6M5rGNp9VJutcmzLDAeEDQLKtakY
         NY2frwTJW1SRNO/dcGGPHij+seO7tCT3Pe5Bmp+ldopTiZWFuDrppOvtEKumJ6jB9zuF
         PSE5UyKMvdeNONkxgVvz1JSkVWv48Xrvot1Xwbn+1SauovRKYsUv78kLR2Lh9pGBiYdR
         DlmQ==
X-Gm-Message-State: AOAM530nFxUS2XLpQosn7FKM4XGwyGpTtTd9tpjY+CHS3nntDNLDWE1f
        HEX+YicYbmLCKOeGH9IzaPx67A==
X-Google-Smtp-Source: ABdhPJwMOxEq67OVw9EpZDWFCHL+80TRYJXCJ4LW3yfGXNtJPqy9Altdc4qlVorZ1gdeJ4G7Ati9fg==
X-Received: by 2002:a63:8c6:: with SMTP id 189mr4976473pgi.207.1601532073802;
        Wed, 30 Sep 2020 23:01:13 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id l2sm4032112pjy.3.2020.09.30.23.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 23:01:13 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bharat Gooty <bharat.gooty@broadcom.com>
Subject: [PATCH v3 1/3] PCI: iproc: Fix out-of-bound array accesses
Date:   Thu,  1 Oct 2020 11:30:52 +0530
Message-Id: <20201001060054.6616-2-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001060054.6616-1-srinath.mannam@broadcom.com>
References: <20201001060054.6616-1-srinath.mannam@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000060b79505b095becd"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--00000000000060b79505b095becd

From: Bharat Gooty <bharat.gooty@broadcom.com>

Declare the full size array for all revisions of PAX register sets
to avoid potentially out of bound access of the register array
when they are being initialized in iproc_pcie_rev_init().

Fixes: 06324ede76cdf ("PCI: iproc: Improve core register population")
Signed-off-by: Bharat Gooty <bharat.gooty@broadcom.com>
---
 drivers/pci/controller/pcie-iproc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index 905e93808243..d901b9d392b8 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -307,7 +307,7 @@ enum iproc_pcie_reg {
 };
 
 /* iProc PCIe PAXB BCMA registers */
-static const u16 iproc_pcie_reg_paxb_bcma[] = {
+static const u16 iproc_pcie_reg_paxb_bcma[IPROC_PCIE_MAX_NUM_REG] = {
 	[IPROC_PCIE_CLK_CTRL]		= 0x000,
 	[IPROC_PCIE_CFG_IND_ADDR]	= 0x120,
 	[IPROC_PCIE_CFG_IND_DATA]	= 0x124,
@@ -318,7 +318,7 @@ static const u16 iproc_pcie_reg_paxb_bcma[] = {
 };
 
 /* iProc PCIe PAXB registers */
-static const u16 iproc_pcie_reg_paxb[] = {
+static const u16 iproc_pcie_reg_paxb[IPROC_PCIE_MAX_NUM_REG] = {
 	[IPROC_PCIE_CLK_CTRL]		= 0x000,
 	[IPROC_PCIE_CFG_IND_ADDR]	= 0x120,
 	[IPROC_PCIE_CFG_IND_DATA]	= 0x124,
@@ -334,7 +334,7 @@ static const u16 iproc_pcie_reg_paxb[] = {
 };
 
 /* iProc PCIe PAXB v2 registers */
-static const u16 iproc_pcie_reg_paxb_v2[] = {
+static const u16 iproc_pcie_reg_paxb_v2[IPROC_PCIE_MAX_NUM_REG] = {
 	[IPROC_PCIE_CLK_CTRL]		= 0x000,
 	[IPROC_PCIE_CFG_IND_ADDR]	= 0x120,
 	[IPROC_PCIE_CFG_IND_DATA]	= 0x124,
@@ -363,7 +363,7 @@ static const u16 iproc_pcie_reg_paxb_v2[] = {
 };
 
 /* iProc PCIe PAXC v1 registers */
-static const u16 iproc_pcie_reg_paxc[] = {
+static const u16 iproc_pcie_reg_paxc[IPROC_PCIE_MAX_NUM_REG] = {
 	[IPROC_PCIE_CLK_CTRL]		= 0x000,
 	[IPROC_PCIE_CFG_IND_ADDR]	= 0x1f0,
 	[IPROC_PCIE_CFG_IND_DATA]	= 0x1f4,
@@ -372,7 +372,7 @@ static const u16 iproc_pcie_reg_paxc[] = {
 };
 
 /* iProc PCIe PAXC v2 registers */
-static const u16 iproc_pcie_reg_paxc_v2[] = {
+static const u16 iproc_pcie_reg_paxc_v2[IPROC_PCIE_MAX_NUM_REG] = {
 	[IPROC_PCIE_MSI_GIC_MODE]	= 0x050,
 	[IPROC_PCIE_MSI_BASE_ADDR]	= 0x074,
 	[IPROC_PCIE_MSI_WINDOW_SIZE]	= 0x078,
-- 
2.17.1


--00000000000060b79505b095becd
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
IC0gRzMCDDa88tbcUKwlq6jscjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQg02nz
yYBEqPUh1mP2rsrjSN0THmKflAI2w18Ju1V0L40wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAc
BgkqhkiG9w0BCQUxDxcNMjAxMDAxMDYwMTE0WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQB
KjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkq
hkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBALn1z45+L1euB8Iwb2ohtClg
92gRBFY/qAYAF5kRznuzLiWwBeBTCKBh06QJo1Wngn6ZjoONFs/K+bDU3r6SPjXJ4CsTaJRcakPM
YH/daKbz/YbbznBektTZZQaENPr1MNuagwwu2E9eoIQcsbt4L0mC80OgDnm2SdJSmTy6CaMKbTZR
BxEUx+RtAsDZJfUe/+qUnf2S0ERLjGnTDfMY3DDxbtJE6gdaG7b0+jkfsIC+jOKaFR1WsU8qxGAb
a5FcuY/C1kZaTzk6jXtNxbUufAsKtmBUsZV4hvfdSFW/6DRHGq3mPJDpWrxshf9SEwBp8IHfvTPV
i6Xht5XIRyyGzSg=
--00000000000060b79505b095becd--
