Return-Path: <linux-pci+bounces-9743-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D743292679B
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 20:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58DD31F2354B
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 18:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C1F187553;
	Wed,  3 Jul 2024 18:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gRtiwjED"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AD2187332
	for <linux-pci@vger.kernel.org>; Wed,  3 Jul 2024 18:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720029789; cv=none; b=PtPITAtaiGm2a3Y5HiOwpLmPsEtKj1KpdpHZNYCXzZDg4Z3QLkfyegb/jR0Dnr8llLLH0xn9roRcGkPWeS77OSiPKgh6npMYwgpHent9VSiz8Xscxm9N6iE7zvkmYxb0y/jEp9jaEjJV9bByjQVa9o78OjkpG9OFpzQ6nGb/axQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720029789; c=relaxed/simple;
	bh=SxTWWnKZ3Jquv0yQqy5Cjmw2w6voQWMsqKoCLAYK7vY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type; b=QgDHmuaLkY3iZNNvme0tCUvpuaB513zxpIe8e6Trm9rV82OKm5Vs23INM6YvvGBD3lJa6uklEvxf2nbWtxvjTCwEIK6tGCZ1KkMx8akkNcfWR1Eb2nUdxXByTb1z0K/AWKpzI5Ep+xMZUMy7jFB1JD6GUDsYffvejgE3P4o/8ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gRtiwjED; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b06e63d288so25899366d6.0
        for <linux-pci@vger.kernel.org>; Wed, 03 Jul 2024 11:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720029786; x=1720634586; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y5/pT8UjT4qEj77dLwdu69QLEGTUCYR3T3aPoKm7b+o=;
        b=gRtiwjEDGSBgAqUmO8SS4lgHrjbAuorgnYGRBaoQJnTWJZTTn8WwvkRzUt/03ptbSC
         el+qnZiyiKZBjsXQuvSXQY5iwIrBWCtDibvzRK0vbs6QLpVbGyCOv3iNPfYwzaEp/Ifa
         pkiLez1BHNY1goQWrUZoFbkTVpSmxUac4+NnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720029786; x=1720634586;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5/pT8UjT4qEj77dLwdu69QLEGTUCYR3T3aPoKm7b+o=;
        b=B7+dMyF8qSEPnP3w8oQ4GW6OG6+nZs6wKvh/AlzhT2tJ4TJeZ5YMwLPlFh/GxHdOzU
         AeIqp1NBbkviwrTBXx08MwdoqeFwBGs8YYNQJXuhBt84Dk++1WjWd8bV9Gpv0xqBuW+W
         eKcHsLdzdbZ6xZ/IccBnyTlRj7CZFUudSDyjzUWZNcJS+H4NaKmvlKdyvSm3IRAMWyRn
         A6uQQivCWxbKZec+eBBln+DAwKW9hG99G9CW6lkjKfYoNKh9bWPk+qcaFOBSTX5BO/FZ
         M7qsQGaI8N6JliAYNRrlUgzwfSe+PEBit8xLt/bgee0eiP5IpqUBrldNbbmylxDQZw7X
         ug6w==
X-Gm-Message-State: AOJu0Yxn642OiH9yJHX6RZanwlHZp89R+GRn8YqBFGDW7zRMnaJl8jlH
	Hkzrh/tS/tqIRXaAsGeudx6t9NBcq1Qw4Zy+74AZJxP7kIEYAw11Mx5GFiEzNOkIgKMJGTD+c1B
	z4d6hCzcu0Kp3fuR5e3O37x9/ugOXPXMVHooGJ/ElT10GEPIinJsX7U9IUmJaTps0ieFovAjNRC
	8WqAF4/JmRbEWs+WBmPp45XzLCAC2FKsIrPwEHEqecWpcjxkfc
X-Google-Smtp-Source: AGHT+IH++y0W0znIk1Hi5gEZgLkMjB2ShRsmrwwCbtpcKXrMa9A7R4aXh6zLAAoOlNjDpiR5I9VVSA==
X-Received: by 2002:a05:6214:3005:b0:6b5:42b7:122 with SMTP id 6a1803df08f44-6b5b717b58bmr147088576d6.60.1720029785897;
        Wed, 03 Jul 2024 11:03:05 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e5f1a6dsm55589626d6.83.2024.07.03.11.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 11:03:05 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 01/12] dt-bindings: PCI: Add Broadcom STB 7712 SOC, update maintainer
Date: Wed,  3 Jul 2024 14:02:45 -0400
Message-Id: <20240703180300.42959-2-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240703180300.42959-1-james.quinlan@broadcom.com>
References: <20240703180300.42959-1-james.quinlan@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006dad83061c5ba4c2"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

--0000000000006dad83061c5ba4c2

- Update maintainer; Nicolas hasn't been active and it
  makes more sense to have a Broadcom maintainer
- Add a driver compatible string for the new STB SOC 7712
- Add two new resets for the 7712: "bridge", for the
  the bridge between the PCIe core and the memory bus;
  "swinit", the PCIe core reset.
- Order the compatible strings alphabetically
- Restructure the reset controllers so that the definitions
  appear first before any rules that govern them.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 .../bindings/pci/brcm,stb-pcie.yaml           | 44 +++++++++++++++----
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 11f8ea33240c..a070f35d28d7 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Brcmstb PCIe Host Controller
 
 maintainers:
-  - Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
+  - Jim Quinlan <james.quinlan@broadcom.com>
 
 properties:
   compatible:
@@ -16,11 +16,12 @@ properties:
           - brcm,bcm2711-pcie # The Raspberry Pi 4
           - brcm,bcm4908-pcie
           - brcm,bcm7211-pcie # Broadcom STB version of RPi4
-          - brcm,bcm7278-pcie # Broadcom 7278 Arm
           - brcm,bcm7216-pcie # Broadcom 7216 Arm
-          - brcm,bcm7445-pcie # Broadcom 7445 Arm
+          - brcm,bcm7278-pcie # Broadcom 7278 Arm
           - brcm,bcm7425-pcie # Broadcom 7425 MIPs
           - brcm,bcm7435-pcie # Broadcom 7435 MIPs
+          - brcm,bcm7445-pcie # Broadcom 7445 Arm
+          - brcm,bcm7712-pcie # STB sibling SOC of Raspberry Pi 5
 
   reg:
     maxItems: 1
@@ -95,6 +96,20 @@ properties:
       minItems: 1
       maxItems: 3
 
+  resets:
+    items:
+      - description: reset for phy calibration
+      - description: reset for PCIe/CPU bus bridge
+      - description: reset for soft PCIe core reset
+      - description: reset for PERST# PCIe signal
+
+  reset-names:
+    items:
+      - const: rescal
+      - const: bridge
+      - const: swinit
+      - const: perst
+
 required:
   - compatible
   - reg
@@ -118,13 +133,10 @@ allOf:
     then:
       properties:
         resets:
-          items:
-            - description: reset controller handling the PERST# signal
-
+          minItems: 1
         reset-names:
           items:
             - const: perst
-
       required:
         - resets
         - reset-names
@@ -136,12 +148,28 @@ allOf:
     then:
       properties:
         resets:
+          minItems: 1
+        reset-names:
           items:
-            - description: phandle pointing to the RESCAL reset controller
+            - const: rescal
+      required:
+        - resets
+        - reset-names
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: brcm,bcm7712-pcie
+    then:
+      properties:
+        resets:
+          minItems: 3
 
         reset-names:
           items:
             - const: rescal
+            - const: bridge
+            - const: swinit
 
       required:
         - resets
-- 
2.17.1


--0000000000006dad83061c5ba4c2
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQbgYJKoZIhvcNAQcCoIIQXzCCEFsCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3FMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBU0wggQ1oAMCAQICDEjuN1Vuw+TT9V/ygzANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMjE3MTNaFw0yNTA5MTAxMjE3MTNaMIGO
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFDASBgNVBAMTC0ppbSBRdWlubGFuMSkwJwYJKoZIhvcNAQkB
FhpqYW1lcy5xdWlubGFuQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBAKtQZbH0dDsCEixB9shqHxmN7R0Tywh2HUGagri/LzbKgXsvGH/LjKUjwFOQwFe4EIVds/0S
hNqJNn6Z/DzcMdIAfbMJ7juijAJCzZSg8m164K+7ipfhk7SFmnv71spEVlo7tr41/DT2HvUCo93M
7Hu+D3IWHBqIg9YYs3tZzxhxXKtJW6SH7jKRz1Y94pEYplGQLM+uuPCZaARbh+i0auVCQNnxgfQ/
mOAplh6h3nMZUZxBguxG3g2p3iD4EgibUYneEzqOQafIQB/naf2uetKb8y9jKgWJxq2Y4y8Jqg2u
uVIO1AyOJjWwqdgN+QhuIlat+qZd03P48Gim9ZPEMDUCAwEAAaOCAdswggHXMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJQYDVR0R
BB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYD
VR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFGx/E27aeGBP2eJktrILxlhK
z8f6MA0GCSqGSIb3DQEBCwUAA4IBAQBdQQukiELsPfse49X4QNy/UN43dPUw0I1asiQ8wye3nAuD
b3GFmf3SZKlgxBTdWJoaNmmUFW2H3HWOoQBnTeedLtV9M2Tb9vOKMncQD1f9hvWZR6LnZpjBIlKe
+R+v6CLF07qYmBI6olvOY/Rsv9QpW9W8qZYk+2RkWHz/fR5N5YldKlJHP0NDT4Wjc5fEzV+mZC8A
AlT80qiuCVv+IQP08ovEVSLPhUp8i1pwsHT9atbWOfXQjbq1B/ditFIbPzwmwJPuGUc7n7vpmtxB
75sSFMj27j4JXl5W9vORgHR2YzuPBzfzDJU1ul0DIofSWVF6E1dx4tZohRED1Yl/T/ZGMYICbTCC
AmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UE
AxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMSO43VW7D5NP1X/KD
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDgQL/HC4GmXJTdy0bZS+kPkuZXNizz
uceAAnHuDuln0zAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA3
MDMxODAzMDZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAO01egNO+37iriN2jEK+W6vdMW8kVWHiirGq7vu1d3qYPaNgF
mBpMmg5e9xRluFp4COxIcOl6IgJgnXu474WQqPGXiDrZtxuGQ0joA1EwU1fVqCwKMACG25ZqHLtB
qsv9zw+Gqcs1ZAqcmDH36w9fnj7H3ugEn9SyCf1OkldB7tWpT2fvYGSVHR09je5zbY6Q90BgO/tf
JXr7TGTPWxxd4dRvfeP3WJjSbrT0cLx7GlUyn6d5LIGKBjMvW1QRMxABg4VB1Ocov7muOU1Ri8WB
aZvzsJ16XyKlC2m2KcjHvFlS/fJeZyD17FcHK/uRaPR3wEHc4E48axhIX0HMOe6KXQ==
--0000000000006dad83061c5ba4c2--

