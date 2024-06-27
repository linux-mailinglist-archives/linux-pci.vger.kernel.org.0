Return-Path: <linux-pci+bounces-9370-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2901491A3A4
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 12:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE8572839BB
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 10:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72CB13D296;
	Thu, 27 Jun 2024 10:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iGIVe14N"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3BE13AA31
	for <linux-pci@vger.kernel.org>; Thu, 27 Jun 2024 10:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719483651; cv=none; b=OTBSBloN42Uixf9LviFoexPXdQWV06WBgMcW1cjOlSAhr2E3ARzUJSdN41uIu1DQ84F2vnY6I89wO7uvjTR6u1DiqQvURpxCdfFRb9c2+6CsY27MtJyOrq8B/JYwedrqWxqP/8wBZb9/t7MO6KReBvENqHIPhpgJG0gVPqDuilM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719483651; c=relaxed/simple;
	bh=TlOPV9OmlItVbECmsQYmQBDklev7CTvDEPnHvGekho8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=U8aSGjpAH7yaAnrCHg1Vl0RoW1Aa+tkuAdjxxRUubssa8DZXab0+wiGc+ulJGBVZ3cpM8bKiXfOXyFQ4X96pcTPwO892kyGdSJeW9+nsUs1IcuUX4dV/SbMqF8WWLcUkKHwGg585/ZIRYEKDT2M1Khn1XpNFRLAHAq+8nPui5ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iGIVe14N; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f4c7b022f8so65855265ad.1
        for <linux-pci@vger.kernel.org>; Thu, 27 Jun 2024 03:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1719483649; x=1720088449; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/n5nX1+hgRYeeP1pCFDfKmeMaomZ/ZyMtnCsgqIkiaQ=;
        b=iGIVe14Nff7XuLMCQUF5jURgyOoQ5GkenyHR/ZhuDUFiKwwawENbLrBYrO82Gxwhc7
         ItlV3zZ0z6atxX9x7S5HUsh9g/fzbNYHfjcDqthwlG26OqsUwIGqdlYKdLh1aIcOKjwA
         bo8VWMnXf4FzXguIbQ19sTeF9kzrVzB4YF6RU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719483649; x=1720088449;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/n5nX1+hgRYeeP1pCFDfKmeMaomZ/ZyMtnCsgqIkiaQ=;
        b=UASvK3kKJpeSqrE1JJDUiLAYx1p4YStn2Vi7eLhJlhzkJ/pjdNwV1D8cpE3nuhaHNY
         Gxw3y5QTET/r6MYcXDhKYA8WPzH709yxbHDXwziVNG9WQOnXXFbRA+IfdxCtb3qUhzIC
         y7Y65AFaQB/fmKX+YPtNj+efrjwwwctui7x5YCYr0TqlEnZd3O6ESZexLuqxM5le3aZI
         rg7mN0wpaC5LixU718F95WQ+LYnx88yccvgnAeXww5dV2v3lwJyv5Uom7CooET7vhWzg
         fySUEJ+eX8ySaMuOUGhqHW7YNqjf2dpjhJ2YUg2n3IdOmJioubukTE3oNaYHENJgQJWK
         nA+w==
X-Forwarded-Encrypted: i=1; AJvYcCWCgX6ArNTqxgH3fPoKRjpR9Oc+dUb+RWNdPO76Ol96FdVA/R2vhsP9XJH4JzjorGCvO1tAIgvu2d5nTfWPE/evG2P6vcySs7T4
X-Gm-Message-State: AOJu0YwpOd7ZAHcYOGmXzSHyCA717gBRNVVk6gJKAfryK98cOiPDo7ti
	dHlmF1PkoEqUZei3cdlt5mxmX+yzUOHB0JmceVtc4v/OA91c2k4iJCuGFIbQSQ==
X-Google-Smtp-Source: AGHT+IHixb5HnApVjLH3JQHe/SRVH9e0kZAAASY33McOTu7qjbP1dJLupVteQziB8tIVJQj2mofjkQ==
X-Received: by 2002:a17:902:da84:b0:1f9:d6bf:a67e with SMTP id d9443c01a7336-1fa23f149b7mr141267185ad.69.1719483649478;
        Thu, 27 Jun 2024 03:20:49 -0700 (PDT)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faac979478sm9858495ad.180.2024.06.27.03.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 03:20:47 -0700 (PDT)
From: Sumit Saxena <sumit.saxena@broadcom.com>
To: martin.petersen@oracle.com,
	helgaas@kernel.org,
	sathya.prakash@broadcom.com,
	sumit.saxena@broadcom.com,
	chandrakanth.patil@broadcom.com,
	ranjan.kumar@broadcom.com,
	prayas.patel@broadcom.com
Cc: linux-scsi@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v5 0/3] mpi3mr: Support PCI Error Recovery
Date: Thu, 27 Jun 2024 15:47:32 +0530
Message-Id: <20240627101735.18286-1-sumit.saxena@broadcom.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000026a24e061bdc7c3d"

--00000000000026a24e061bdc7c3d
Content-Transfer-Encoding: 8bit

This patch series contains the changes done in the driver to support
PCI error recovery. It is rework of older patch series from Ranjan Kumar,
see [1].
 
[1] https://lore.kernel.org/all/20231214205900.270488-1-ranjan.kumar@broadcom.com/
 
v1->v2:
- AER patch split as suggested by Bjorn Helgaas.
- Updated driver version to a new value.

v2->v3:
- Addressed the feedback from Bjorn Helgaas.
- Simplified and dropped few patches.

v3->v4:
- Addressed the feedback from Bjorn Helgaas about dropping
  null pointer checks for shost and mrioc.

v3->v5:
- Replace sprintf with sysfs_emit and simplification in adp_state_show().

Sumit Saxena (3):
  mpi3mr: Support PCI Error Recovery callback handlers
  mpi3mr: Prevent PCI writes from driver during PCI  error recovery
  mpi3mr: driver version update

 drivers/scsi/mpi3mr/mpi3mr.h           |  11 +-
 drivers/scsi/mpi3mr/mpi3mr_app.c       |  10 +-
 drivers/scsi/mpi3mr/mpi3mr_fw.c        |  22 ++-
 drivers/scsi/mpi3mr/mpi3mr_os.c        | 248 ++++++++++++++++++++++++-
 drivers/scsi/mpi3mr/mpi3mr_transport.c |  39 +++-
 5 files changed, 311 insertions(+), 19 deletions(-)

-- 
2.31.1


--00000000000026a24e061bdc7c3d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
1J8x62/iEVbCstJaE1Nt3oXnL5yBlqX1Ihp8cZLe1weS7Wp/v5Jg2Ks13jeYOKW45xXExpqPPd1f
3meFjTf9K+rGZHb63htWaJtf0NYbE+5yIbXFv21cBxECAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZc3VtaXQuc2F4ZW5hQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUTIFIrhFDaoMEbXuV9O+Y+XgS
kVwwDQYJKoZIhvcNAQELBQADggEBAFyioHqB2PHWcQ5cU8nprPRk37uSWK2x0w7W50jjc0cooz6G
G6pltJ+DvbG7XIzCU8cKHmuyAxoe1+/vhB8yJH78MVdfKDDND7zL/IqfhZedxHcHG5jVqbVH/ufu
H19y4fHxo5bLkybX3UxkN9b3bMsBZ4FFCLSCFgFfjI0BmTx6IoGyi0R89rzD0H1rURy7WTn0ijl1
nERsqENeyGfUTJLcDSURb49qpFqqWweJ7ifC64Iak8wCK2CxCe8lHfTyEgC9MuEa586NMQJDguvw
jlC7kxrgwf4sZ/9Wj/GS2HLzZPkxWCcQIrgNJm2wceHQwPBpM0ZoqL1D2tsFgOA8BvYxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwdgevXLIdo6fbCNI8w
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILHL5ejsodBXzXaPOsTqItwvO0Rcku7z
MfsV+eDQ4qD2MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYy
NzEwMjA0OVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCaAKIP//JMYkEnb3HvR/68bPIdOH15dJUAxYsDA/bOvIxMSXJ9
AIn/1mn9VvBxDzUnu9KSEexPoMgMC0PaKmgsCPL5EAInRuSKR+GDUPN+UBJgL8KwWAjFgjTew2z4
jtcD4aD8RbLsG2PJMtLWqV7pojQlIW7clBduJ4ElsyZAliOuCEKnoytTDmBkMiYv7zz7SLDX8I4d
4XSl3tioiX4YCaUfu7hZy9osDWxDPCMvZ4NbR2KSMhkNzBegYW3yEop9ntyxbm6Wf72WcLI7eLrc
UpOoC2k39oZAmIhdWnpcarHOvBZ9uHPR+2y5BFL/Ir+ptNIQKDIbqQalFKb06vAY
--00000000000026a24e061bdc7c3d--

