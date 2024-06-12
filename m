Return-Path: <linux-pci+bounces-8666-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB305905179
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 13:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 782341F22549
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 11:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F043316F292;
	Wed, 12 Jun 2024 11:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KaZm++LC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C6416F27B
	for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 11:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718192302; cv=none; b=KnUH4PJ2dKeb8cZSVooBuDOfWNKkVKxeUJ5ktuBcralChz6fCSNDZZP9Q8M0N7l6w92ZuUo7WXzfLyVWdQsxOEpaILDuCOvpScuMXBZWPB9v2kCUTDjbOGbHrGvwMIIVgw4E2ujhKAYXWi5aTkzeI/4oC8vRe5h3A4lJfXBn1c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718192302; c=relaxed/simple;
	bh=2Kq2+dxCxqy2vBLR6aMK3CS1B+4OMZwLLqdvtyedUPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type; b=ms5YgtE8b8nlv1Jkpc8iQ3nYMZsFhMzqmOv2sncv+aeGBWT5dSEBKjcX47v0RxfTGiFTLKz4T9iDV6TOc8ZJjKaZ9SFwpGShy86yisJjAH/9Nfs1APNqbSQyTfJiJTZzyNmVYo/jhQqBCKEJiNqFJhHhSbL4oZwwqknwBsZ7TtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KaZm++LC; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c2edc2611bso502867a91.0
        for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 04:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1718192300; x=1718797100; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Why58SAdP5Y6rkV+8qgdzmMz3htYTE6s2TGPcruv6C4=;
        b=KaZm++LCZO4h8u5u7+fqzbFgUlAQ3rB5I0sFQqC8Hr1MW0al1gBcvGh54hLqwy+JmS
         YTy5uveZZU9IozUs59GZZNp5kaFDUfkCqxfoIVN10CO54G1ysk1/Isp+DWMyP8qwC/zi
         ca82+mO5ivlTl5sBl3Xv8RhB3afvkYLn0tgGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718192300; x=1718797100;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Why58SAdP5Y6rkV+8qgdzmMz3htYTE6s2TGPcruv6C4=;
        b=YTXsEqlv6xgUuUoMdro/oPahXYCeXfg46zJOyuGL6VXBvgNGVfcAvGEVirbTDfEzq7
         SQecuFsp0XU2V5pquXOnXsnyDo5q9gkqps4xYjvre35oqEIBN6Wc1cBh7KmMvaNIbAXh
         MwVlZRKddl0VMRtnA4tNQ8wSWZCYQv5qLOfHiFiN0wPE8D0BJNZp5Vws8mQO+oytZl2z
         /VT3wMi2od2i640g4YM7Wt5SJIuu1GdRv++ivgvMpMT3MQs3vO8Sghl/bGdug3mdDFO6
         dKuccC+TDHRuPIxgzqz3mm4yLETb689DWcumVp/zFU3a0jHDZViAQBUkHaQGEg+jTlCj
         PmUg==
X-Gm-Message-State: AOJu0YxztNxHAqLg0A5RVBt9OBjq/5qsoyPfNs5vZzqAN2FbtPIwdzMt
	VfyTpGiFjCjQs/Jf7rfNaAF+WX7VXgI/9/t3vMfnHdbOpEhm88WXSC60ignTa4F6SQPDDtGhT6B
	6O+WqWOuadkgMKlGCSTLS2IxvUMo7uSEFMbau5rT6nh4xhD9d3VN84aGV3Sj85fOaFo5qxFHWIq
	Qb+2HiD4stJUK68CIqftpTuwNMY4rwRleh20ibMKp5UBnphU/B9a3P7X19kw+ZEfE=
X-Google-Smtp-Source: AGHT+IEjaVszanpa6z6YEttWLZ90J+Gma8mpQUbnjH8hOYOBjk1f3iQxxx4ijVssFyXOzqK82vDI4A==
X-Received: by 2002:a17:903:2285:b0:1f7:12c9:9426 with SMTP id d9443c01a7336-1f83b7e071dmr16950195ad.3.1718192300192;
        Wed, 12 Jun 2024 04:38:20 -0700 (PDT)
Received: from dhcp-135-24-192-142.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6fc06a5d2sm74392305ad.306.2024.06.12.04.38.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2024 04:38:19 -0700 (PDT)
From: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
To: linux-pci@vger.kernel.org,
	bhelgaas@google.com
Cc: linux-kernel@vger.kernel.org,
	sumanesh.samanta@broadcom.com,
	sathya.prakash@broadcom.com,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: [PATCH 2/2] pci/p2pdma: Modify p2p_dma_distance to detect virtual P2P links
Date: Wed, 12 Jun 2024 04:27:36 -0700
Message-Id: <1718191656-32714-3-git-send-email-shivasharan.srikanteshwara@broadcom.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1718191656-32714-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
References: <1718191656-32714-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000bd6fda061aafd124"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

--000000000000bd6fda061aafd124

Update the p2p_dma_distance() to determine virtual inter-switch P2P links
existing between two switches and use this to calculate the DMA distance
between two devices.

Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
---
 drivers/pci/Kconfig  |  1 +
 drivers/pci/p2pdma.c | 18 +++++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index d35001589d88..3e6226ec91fd 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -174,6 +174,7 @@ config PCI_P2PDMA
 	depends on 64BIT
 	select GENERIC_ALLOCATOR
 	select NEED_SG_DMA_FLAGS
+	select PCI_SW_DISCOVERY
 	help
 	  Enables drivers to do PCI peer-to-peer transactions to and from
 	  BARs that are exposed in other devices that are the part of
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 4f47a13cb500..780e649b3a1d 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -21,6 +21,8 @@
 #include <linux/seq_buf.h>
 #include <linux/xarray.h>
 
+extern bool sw_disc_check_virtual_link(struct pci_dev *a, struct pci_dev *b);
+
 struct pci_p2pdma {
 	struct gen_pool *pool;
 	bool p2pmem_published;
@@ -576,7 +578,7 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 		int *dist, bool verbose)
 {
 	enum pci_p2pdma_map_type map_type = PCI_P2PDMA_MAP_THRU_HOST_BRIDGE;
-	struct pci_dev *a = provider, *b = client, *bb;
+	struct pci_dev *a = provider, *b = client, *bb, *b_virtual_link = NULL;
 	bool acs_redirects = false;
 	struct pci_p2pdma *p2pdma;
 	struct seq_buf acs_list;
@@ -606,6 +608,17 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 			if (a == bb)
 				goto check_b_path_acs;
 
+			// Physical Broadcom PEX switches can be provisioned into
+			// multiple virtual switches.
+			// if both upstream bridges belong to the same physical
+			// switch, and the switch supports P2P,
+			// p2p_dma_distance() should take into account of such
+			// scenarios.
+			if (sw_disc_check_virtual_link(a, bb)) {
+				b_virtual_link = bb;
+				goto check_b_path_acs;
+			}
+
 			bb = pci_upstream_bridge(bb);
 			dist_b++;
 		}
@@ -629,6 +642,9 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 			acs_cnt++;
 		}
 
+		if (b_virtual_link && bb == b_virtual_link)
+			break;
+
 		bb = pci_upstream_bridge(bb);
 	}
 
-- 
2.43.0


--000000000000bd6fda061aafd124
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBXYwggReoAMCAQICDFr9U6igf1QRzoaH1TANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwOTMyNDhaFw0yNTA5MTAwOTMyNDhaMIGq
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xIzAhBgNVBAMTGlNoaXZhc2hhcmFuIFNyaWthbnRlc2h3YXJh
MTYwNAYJKoZIhvcNAQkBFidzaGl2YXNoYXJhbi5zcmlrYW50ZXNod2FyYUBicm9hZGNvbS5jb20w
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDulAFNbtc+tsB1JubfhUwbq5745iWy0PqA
tUlf8OsSpnKZPtpZ/P9TJL8MrXyDJN5GdKeVAvh1YAvXb2S0i90gW5qWZtFQ4MRMQwXKHvwdVCTj
NBVuju4wvuIk8TWSSWryDIa/KUmQEFgRethHXcwAGKVM2LV19E+RJxjbqcqBXqT20XVYJ+86q3gC
pKeDdMqs49aS4NkFAulUXfKMvwayi1/al6l6H6NjkYI9V+VAhd2Pw5dVGT1UGNnGenU1ASxrICxB
p1may//a5w+WwgjNTKaKkyc6n0c4ds/TIbS/qi/G87n1VXSpcJHiebcJy8WZCbvo6g9j0Ipsx9mZ
ZyjVAgMBAAGjggHoMIIB5DAOBgNVHQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsG
AQUFBzAChkJodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29u
YWxzaWduMmNhMjAyMC5jcnQwQQYIKwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29t
L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIG
CCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRME
AjAAMEkGA1UdHwRCMEAwPqA8oDqGOGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3Bl
cnNvbmFsc2lnbjJjYTIwMjAuY3JsMDIGA1UdEQQrMCmBJ3NoaXZhc2hhcmFuLnNyaWthbnRlc2h3
YXJhQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdb
NHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUOXk95+zAtIGGWGU9q37iyIJKcYMwDQYJKoZIhvcNAQEL
BQADggEBABd5fRmxw/2mYuimst/fZaHYCHDoiYauRKIOm2YcV+s/4xhvXJx0fFit4LzpW8EgTXQv
GQCCaJeSArd/ad3NUOhuQtVB5xOO5cHcCYpdb9gvRPzSZss4mN5OrQsOD6iH0lyg9zIQfhReghMc
Y0C0m8ndFGSil396kqXLgxfPWJ8LChptV9z3iLmGoxJa/gqhi4xu+Ql3ZcQqcP6YItbGOmGjXF/p
uwxVuxQ2ZLaLPPZF5H6t1UPCJRYZXbcjPQHXqFTijI0/1PIUtJy3gUmAsxZe+1n/rCqqCHE4rM+q
Xm1kxB5u/2AMUovVed0IK1+1PFQLP47vY8PfDbSkU4UXH0YxggJtMIICaQIBATBrMFsxCzAJBgNV
BAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdD
QyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxa/VOooH9UEc6Gh9UwDQYJYIZIAWUDBAIBBQCg
gdQwLwYJKoZIhvcNAQkEMSIEIOX7iw8VjpkiWq6Z1S+ccSRFUoOUrhiPxfgM2XD9qJzmMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYxMjExMzgyMFowaQYJKoZI
hvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG
9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQBHSsrXCc/uVzKakYiUtxTLKAZnK0+Qig+prJ1BvmAWSlq/ghJwQiW2ieDKo62OWdbV1p3d
55ZO6x/+3TdkOH2s6bu9/yEHklz9FmyulixbkErlDkJ8sNVCsr7RQGNXacFmehbniM+SiIA3Y7yT
LSA8VuG71SwgpymwGXx5/B+uZZhhwzDc6uanTxxg0BCr96r1Ta7BEPriNiXhYh0BlPsjzTMTm3p1
40gZwOxdikJHrvSJfk9SZn2QIsyW+EcmkSD4+qS5UfBDriw+K28virHLKEvSvY2TloD9cOVEBF/K
W+jQT/HWRXzeaEO/bxF46KgLDGfSOvz+HpaBpnl1BLZ8
--000000000000bd6fda061aafd124--

