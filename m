Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439BD27F943
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 08:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgJAGBL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 02:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgJAGBK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2020 02:01:10 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A72C0613D0
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2020 23:01:10 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m34so3167032pgl.9
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2020 23:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=q3/tWPpznoYbqp/fbNV3MS1JZqzMCoiUhemnnoHkb9c=;
        b=eMhNmQ8DmhlqopE1tffCto14gwoSHZxwVWfteuSRX4sMpXJdhLvslk1t91Jj4extX0
         Ru0YUygHdxOZsecdC07zBv1tXTl0dGMDSsFgWTfZXprkF5rvrGWJZX69GVztCkMsPS3G
         ciGFY8fTbn9ImsRr1AMFN/8Cut+1tRAuEYVoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q3/tWPpznoYbqp/fbNV3MS1JZqzMCoiUhemnnoHkb9c=;
        b=VhLm/gdRczOtTTJjtspdfgM8VAMaRQ67CoNRYZ6rR1uK3FnPigDFrZntw0PR/QSPmZ
         2unA0JbQb1FQ8GkY53VeT3pUj3SdrPxVm5KBRPCcVc+XmVMsQCjORp4VMHnkHWmmDHh3
         pbH1gF/5Cogpfl9qnIaLaNNRnAR4DkkcgHJ5rMZkgAYt6rxcr0jzFgWuU6zCHU+/Uzri
         pkV0btL0h2+7LmdUcYHsY9ALOn69RRrz49fn8kQUzgri6WqTkcsaFuMR90G7zsUHGAVz
         +phDN6mPpHkUNqdtfWoj3guTpef5UGonO1EjHDCf9mPUw6+xaNlOyq5JEh/nrvm6H3dg
         Yt6A==
X-Gm-Message-State: AOAM532mBRYqRK8HeJ/LrSjxacX8ReWf5u9D/VkOj/mnNV8EW3r0LTCP
        6I24YpvbS3srUlazqHw8adzqlQ==
X-Google-Smtp-Source: ABdhPJwmcbGffPjlP6r485rkbOLTJr00urfc/ImOUlJ/uZqXYwfduo2dJPm7nMBidK2mrNuZV6GudQ==
X-Received: by 2002:a62:6287:0:b029:142:2501:3982 with SMTP id w129-20020a6262870000b029014225013982mr5717876pfb.71.1601532070061;
        Wed, 30 Sep 2020 23:01:10 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id l2sm4032112pjy.3.2020.09.30.23.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 23:01:09 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v3 0/3] PCI: iproc: Add fixes to pcie iproc 
Date:   Thu,  1 Oct 2020 11:30:51 +0530
Message-Id: <20201001060054.6616-1-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.17.1
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000029056405b095be1b"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--00000000000029056405b095be1b

This patch series contains fixes and improvements to pcie iproc driver.

This patch set is based on Linux-5.9.0-rc2.

Changes from v2:
  - Addressed Bjorn's review comments
     - Corrected subject line and commit message of Patches 1 and 2.
     
Changes from v1:
  - Addressed Bjorn's review comments
     - pcie_print_link_status is used to print Link information.
     - Added IARR1/IMAP1 window map definition.

Bharat Gooty (1):
  PCI: iproc: Fix out-of-bound array accesses

Roman Bacik (1):
  PCI: iproc: Invalidate correct PAXB inbound windows

Srinath Mannam (1):
  PCI: iproc: Display PCIe Link information

 drivers/pci/controller/pcie-iproc.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

-- 
2.17.1


--00000000000029056405b095be1b
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
IC0gRzMCDDa88tbcUKwlq6jscjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQg4N/N
iKoUZ1O33JW+rx/fdsgFFV2APX8fzjEB7ZkGEjUwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAc
BgkqhkiG9w0BCQUxDxcNMjAxMDAxMDYwMTEwWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQB
KjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkq
hkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAAnfrhJyiIiRF8EKEAaKFF5E
4DgYNRJEbkOGAGc2DYjfIWiRK3E2MQmLB6ResS0KEvSvyi3JOugobgY+N+8LV8sfOkn8YhneBUxz
l8VId43d0Xq79UHpcSewX6KCWr/fY1s23pFxPgYEdLBuh5EVvBKmq07LejSNVhKwNdBTdNGc+j30
fv7h2l4IF6R9T6OFgTHFdR85dm2qxFAX9VNvsIY1Ks/kcF64/l+5gmlUhyxnE33bAedlswCChFYU
Nv6oeNhNZ8WlJmi001kgaD17oz/l2pCtaSw9Xil17vR+9vhFgO+whCLx3dpRiR1mQ/TvdS2nQxS1
62voFQDssg3d/K0=
--00000000000029056405b095be1b--
