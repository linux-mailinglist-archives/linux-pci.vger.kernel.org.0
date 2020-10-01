Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A308727F949
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 08:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbgJAGBY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 02:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAGBW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2020 02:01:22 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D468C061755
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2020 23:01:22 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w7so3492964pfi.4
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2020 23:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XKniDKpGWozCfELydEqWMvqFyRW+NfHyXg+2i7qbqqg=;
        b=dhx/8554h34hwQVX55dDeA0n6onL+orcGNWROsIte/RfnpAvBWt2IQ9QbSKoS9Q6ZS
         kbcDXPRu2BswviYaM8KDc3va0CJgwk7P7ZIOVKYKO5rDvoiSm79gDLU+4oR1Pij79UM7
         IIDD1pyVDvNf/dY/pRLZR9m0hxdNNT65RiRrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XKniDKpGWozCfELydEqWMvqFyRW+NfHyXg+2i7qbqqg=;
        b=P7/QLwmnWhdzuC4zweOaid27X5MXmGCWcjPPiMwSp9EsZI7fOc0+eK6+WBZ7ZY7pEl
         FXCz7B0HXvb+tagHR10wpOAZpx5gmS7+R0jxYoQrCa+j7tEklVWyUvovsUeeTgCKvisS
         Bt3nvL2jQ9/evErVRlS2ZhUwYa4nIEWBup0WhlbeUgSQ1L2dm1dfHIeYgaJdAVpLOG2i
         AppYLAEpLDxjoQ4JEky7UFNWXaI/KVwdiDOFaJ+UemDNHfyyVw4k2+wl0Ui5j70JvthG
         QXEHSk19d/qeUUo8oavhMzC6EnuQ6iV5covjlqMZ2HDrdLCTigaEsJHBVWLHb7xABDVP
         mcuw==
X-Gm-Message-State: AOAM530FTDUNqTr86qRlXuJaTE72BuW3o1Y3dHi6LJFLCKt969tXelFB
        gQvRnOwgysRLiLwStbAE6O9ECQ==
X-Google-Smtp-Source: ABdhPJwxM5L57TJZwmSnlRWv9mXMAi+RegGmDTyfFRPx7V+QrmL6rajMd24B+gMKgq1ovvMtJvJgsQ==
X-Received: by 2002:a17:902:64c2:b029:d2:6356:867e with SMTP id y2-20020a17090264c2b02900d26356867emr5792617pli.32.1601532081551;
        Wed, 30 Sep 2020 23:01:21 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id l2sm4032112pjy.3.2020.09.30.23.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 23:01:20 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v3 3/3] PCI: iproc: Display PCIe Link information
Date:   Thu,  1 Oct 2020 11:30:54 +0530
Message-Id: <20201001060054.6616-4-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001060054.6616-1-srinath.mannam@broadcom.com>
References: <20201001060054.6616-1-srinath.mannam@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000d7b65205b095be39"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--000000000000d7b65205b095be39

After successful linkup more comprehensive information about PCIe link
speed and link width will be displayed to the console.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 drivers/pci/controller/pcie-iproc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index cc5b7823edeb..8ef2d1fe392c 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -1479,6 +1479,7 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 {
 	struct device *dev;
 	int ret;
+	struct pci_dev *pdev;
 	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
 
 	dev = pcie->dev;
@@ -1542,6 +1543,11 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 		goto err_power_off_phy;
 	}
 
+	for_each_pci_bridge(pdev, host->bus) {
+		if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT)
+			pcie_print_link_status(pdev);
+	}
+
 	return 0;
 
 err_power_off_phy:
-- 
2.17.1


--000000000000d7b65205b095be39
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
IC0gRzMCDDa88tbcUKwlq6jscjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgzyFS
jhtPptTYkLTLEKsCSQ7UTWmBCxNTP49JAoww+pYwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAc
BgkqhkiG9w0BCQUxDxcNMjAxMDAxMDYwMTIxWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQB
KjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkq
hkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAA8JFMfgKxLJqN2MwsPp0ef4
eodhO5J4VqsI8FTbN7bsHaZnoPo0sXGVYcj8+3F7m7XZuoahJm6JbrXcSL1VtbOCx/5nggBfkABd
imTh36uGG3WhasVRcf5bA1flfw3XvnvmH6nRovfIWQLnKwxniZjTyOB98bVpP370ms8Tx1aJ5p56
OadtkmMKw6AoO1M6zSZHKrhRmEfCOuwWyaWstjDVBcUsVHr3Fi9uhM3IwOeByfs+kEt9KfMufAHh
i5DYBtmWg/+y3m+F+SWMuUSPsW0rkvr91vG2mmcImdlwJ41JfzURLDHRrmp04674+1ebZb6lVD0N
reVT1+W5nA/0SmM=
--000000000000d7b65205b095be39--
