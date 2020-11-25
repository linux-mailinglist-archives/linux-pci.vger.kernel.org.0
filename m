Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C352C482D
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 20:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgKYTYf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 14:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbgKYTYe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Nov 2020 14:24:34 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240DAC0613D4
        for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2020 11:24:34 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id bj5so1601672plb.4
        for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2020 11:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X2BciFTBNQh+5keBn/0j7kOgDK11dj9Kh5HRhyPm5OA=;
        b=McUPBIgwXP0qtgPre/p1PQEuymXo1iJpwbxIPU4Jxh1LRlUvY1FAwveG1WY9eUo9DR
         FMg6YueGxf7ZAE8tuxiZw7okNhooOfFMONSnaDOAbokrdNItZfzM11no5KxN+nOxH/G7
         whxoBb0emGiAsq0gbRkySIsod+Og9gFH+VS4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X2BciFTBNQh+5keBn/0j7kOgDK11dj9Kh5HRhyPm5OA=;
        b=pMfokWq/B96a2NT9lgDYpf+jp7Hz3rfTOCFUbQKZfnL+9ubwKBeTJaQayAVYN2whOy
         0UOSJTCeOGLzF4WavXZaPjFuHTY1Os7aZyEvfXFUMwXJ/eTviKh2s6ynrzXimLJGRAe0
         FDRFDkBqCbG45m0RxqygEdUikDEdB8ISUkZPhgm60fTNL6JwdH8Tk8ckzUwWMxtHsb1O
         jYuyUb+w56P3dlL275B6veFw0vRa6a3EU204hATrB4+fSwffk+bhJi1IiI4E9c8olgRQ
         7Fm1w9Xqw61MaUxUqkUehos8Hq7U5qV4nSQ1u8EyoKYCAmE6O0aUAg1I7ZBeKZcxwN1T
         1seQ==
X-Gm-Message-State: AOAM5329n0PlhJpJaEk6M1KSjAd3OPw++qVcuW+Kq30rQnBp5NVaiwPG
        whrkLM0D2WUeFgAKcceMJywC/FZi9nJogAerMbf8KHKr6SlvXcUXL2sziyt7eU3GFnCn1/fd7V0
        pYjw6Mrc3knCwEnHOrAM2SB4j4fsUbTMZIxcnttFZ3zGrc4XLzfQoWWoOc61qx+uBe6d4eI2Rj6
        i189OL
X-Google-Smtp-Source: ABdhPJxPLxZb3s/ES5uemueP4EenbHb5P3Owo/n9t/o0K7PrsAAD+FMxSpKgJJODQecG/h9GSI7t7Q==
X-Received: by 2002:a17:902:a608:b029:d6:a1fc:ab75 with SMTP id u8-20020a170902a608b02900d6a1fcab75mr4249463plq.18.1606332273173;
        Wed, 25 Nov 2020 11:24:33 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id j69sm2574885pfd.37.2020.11.25.11.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 11:24:32 -0800 (PST)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 1/6] dt-bindings: PCI: Add bindings for Brcmstb EP voltage regulators
Date:   Wed, 25 Nov 2020 14:24:18 -0500
Message-Id: <20201125192424.14440-2-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201125192424.14440-1-james.quinlan@broadcom.com>
References: <20201125192424.14440-1-james.quinlan@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000008fe1ab05b4f360fd"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--0000000000008fe1ab05b4f360fd

Quite similar to the regulator bindings found in "rockchip-pcie-host.txt",
this allows optional regulators to be attached and controlled by the
PCIe RC driver.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 .../devicetree/bindings/pci/brcm,stb-pcie.yaml       | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 807694b4f41f..baacc3d7ec87 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -85,6 +85,18 @@ properties:
       minItems: 1
       maxItems: 3
 
+  vpcie12v-supply:
+    description: 12v regulator phandle for the endpoint device
+
+  vpcie3v3-supply:
+    description: 3.3v regulator phandle for the endpoint device
+
+  vpcie1v8-supply:
+    description: 1.8v regulator phandle for the endpoint device
+
+  vpcie0v9-supply:
+    description: 0.9v regulator phandle for the endpoint device
+
 required:
   - reg
   - ranges
-- 
2.17.1


--0000000000008fe1ab05b4f360fd
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOxPm7sNHsn0TVdPryi9+T2d8fVC/kUmuEdTYP/Hdu4W4b4T9BcW57fInYrmaJ+uotS6X59rAgMB
AAGjggHRMIIBzTAOBgNVHQ8BAf8EBAMCBaAwgZ4GCCsGAQUFBwEBBIGRMIGOME0GCCsGAQUFBzAC
hkFodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc3BlcnNvbmFsc2lnbjJzaGEy
ZzNvY3NwLmNydDA9BggrBgEFBQcwAYYxaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL2dzcGVy
c29uYWxzaWduMnNoYTJnMzBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYm
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBEBgNVHR8E
PTA7MDmgN6A1hjNodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzcGVyc29uYWxzaWduMnNoYTJn
My5jcmwwJQYDVR0RBB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYI
KwYBBQUHAwQwHwYDVR0jBBgwFoAUaXKCYjFnlUSFd5GAxAQ2SZ17C2EwHQYDVR0OBBYEFNYm4GDl
4WOt3laB3gNKFfYyaM8bMA0GCSqGSIb3DQEBCwUAA4IBAQBD+XYEgpG/OqeRgXAgDF8sa+lQ/00T
wCP/3nBzwZPblTyThtDE/iaL/YZ5rdwqXwdCnSFh9cMhd/bnA+Eqw89clgTixvz9MdL9Vuo8LACI
VpHO+sxZ2Cu3bO5lpK+UVCyr21y1zumOICsOuu4MJA5mtkpzBXQiA7b/ogjGxG+5iNjt9FAMX4JP
V6GuAMmRknrzeTlxPy40UhUcRKk6Nm8mxl3Jh4KB68z7NFVpIx8G5w5I7S5ar1mLGNRjtFZ0RE4O
lcCwKVGUXRaZMgQGrIhxGVelVgrcBh2vjpndlv733VI2VKE/TvV5MxMGU18RnogYSm66AEFA/Zb+
5ztz1AtIMYICbzCCAmsCAQEwbTBdMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBu
di1zYTEzMDEGA1UEAxMqR2xvYmFsU2lnbiBQZXJzb25hbFNpZ24gMiBDQSAtIFNIQTI1NiAtIEcz
AgwTv2xmtR4KOmK4QvMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIHZ682fwVMlJ
Jlzxa97Bd4tt+xrNv/m/eieyNuutpUQNMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIwMTEyNTE5MjQzM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDnOVi28sdaULeyLYfUhKdVHuLffnXD
gJ+PeN2MLTlKIYShMX+/Jn6CqcgII473RsH0FSYCFSvFSMfTNfByLb9N7v9VaurIhjBDCeKKZVvX
jxFG8KUAlSwIB/g1MKOpcXZNGthMqkhFDdzfQNHrP0mYffWeVuWU/Do1hznnIgnqHXBsD9GKvzyY
pdE1yp9ljRdW1j37yDVXzknbQJGAIJ5ecVxxkX/7jAR7Tl50/hMw51BAm0VfR9oFFaEFlurhK3Kj
ae8CDjSLqNrRbzh+w1EMZsxLOeAb4Mzp5NKOCuA90IDJ4qP+uJRvOI6dALzzGM1kDpx3WLF5wzLJ
9sbv/a7z
--0000000000008fe1ab05b4f360fd--
