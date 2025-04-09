Return-Path: <linux-pci+bounces-25599-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20288A832BD
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 22:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F0E466006
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 20:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9198D2116FB;
	Wed,  9 Apr 2025 20:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W72S73oH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC95A21481D
	for <linux-pci@vger.kernel.org>; Wed,  9 Apr 2025 20:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744231347; cv=none; b=m1ydhjzs+Yjy14DB5YwsxmSGyVctHWVrxMTqjaN8GrWfmMMKU0QLQCEmeCt44sIoY4UYWy7L48/B8AnPZ6sVTRjeGGd3qtc1SfyP2wJ1Tnk5fIYJ9XtNFSzj4FsWCAI9SirMtYx31VCBppwMEOlDumnq8an6txCuVrwGsX3AjVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744231347; c=relaxed/simple;
	bh=XCLpyNUSsktSiA5SPX3dAt44yx0q0QgyTswjkxt0JI8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=dOx+dEURYHWJ/BAj7K3YZZ7pRYO9MoeBs4Wp+0s/Cosng8PtxN26Tqrt81YHwFkBdApAzcmNmOfBWVPmOPiSjsF21CAEdReEra0lh9BelhWjT/TmBC/pVoVrgg7AA26KFYDG0DauDcqMz0BeHwL+77UOvPYLz5sI6T/P6OB47fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W72S73oH; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac28e66c0e1so17941666b.0
        for <linux-pci@vger.kernel.org>; Wed, 09 Apr 2025 13:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744231344; x=1744836144; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFpI7/7Xdgr6CUs3O3NrJ+EbyX0VMcz/lmQ3/Q2JvVY=;
        b=W72S73oH2YIcibGyV4frrrWxBLmdRHlv4XSXfy5js7LATZYMzHVlJ4DFE8ebRyBpza
         qpEPAnhHEsrC1EKWrRxMpjvbm3SzG5uBj9Z4q81ehvb26hjl2xUsxSnpPk9nChdC1Lf7
         Ku/AQAt41GwAx5QJoqGoiqExqUaOwJ5FHDpYGuqV8XdnKZmebAZcD80EUbxNrMPsplJU
         EzA13Urcq7Z+2uM1tfF+RQZ9ZPYvqw8R32j1yfjsW+FwYY+IQ1V1RIApTT/sfgnPVrZa
         87GX/wnZ7nPJZvTrsnNkP45kb9voF7FPFMvyW3hKbGZjVbVBNdq7A/No0vVx4Srs+hJ/
         BpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744231344; x=1744836144;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zFpI7/7Xdgr6CUs3O3NrJ+EbyX0VMcz/lmQ3/Q2JvVY=;
        b=sxUfLEeitCM/0g4tA1WaHObJv5fEJYACo/izAH2tVHej9fgqjLVXesJndEWb71cwqR
         98q47wROL+eyQ91L+87f8FQuhVx9gQfWbySfnuV+QdSlu4MtwbsdC9luQYaCxtD9kffX
         5VOuynnUvR4IXPX9dG+mDHrUIxCyjxi7oKFF4E3zQzWD51ngsCrXHscIwAzik1Iu+Lj8
         QX9Ogy8upMVOYlHHAUJ1RDHKeBvRI7RGGKSZbbi4HCgItTJdFpiUzmdsHg7exn7SZ1TJ
         51/mdscPiQcfBUYaI1npmVhsXprQwCpYk6kQ77CW4vP7u51pZUjGLj5UEk9ior+QnqdY
         a5Mw==
X-Gm-Message-State: AOJu0Yywx/owZ8C4YNJ7h8py36CMQaFxHgP6gP5PeGPun0iqTsyJOHpq
	ojremuC8SvkqjuB2TebqX48MBQ11189s1hKG6q+SYCSeBwaMzzeHpM7asQ==
X-Gm-Gg: ASbGncszmRI03S9bdhqD0aIvP9oLcxEcFtX5QFBORKTX04wQdjrtdJagbhPiPFO34DF
	68HQZsom2E/2vZpFDL0zE5F4v8D2NtzEb/1XICcmfloiUFu5S3NsCTNs+5CzdunIQe9F0ZKByaP
	b/PFa+SND0modri1yKExT+IrFgEa3m5yNSxTs5oc8aB/evaSFCpSZ5y8ZcvS3Fv+qagn7m/4j3D
	71UISEQCdFrcpIRWuSc04GuN58G/sXur32FjN1Elih0f/OV/Td7dDhfcBNEvPn4IPJXj0e+aYnW
	QcDsnr2XMDWcB/Xp+BWSEBxHJXUuVRyggUX/FvWtqrmTCXeKXOLYk+bWFVGpDNZ/eVubbVPuRqb
	wDYfFIO7lvc6IYKgePwIh6ATTK7aRH1Zq44FWF1OkpQjQxamkV5nOwbLyHS8Wjx6bAyVqiazlvp
	WjRsbcPGOlPA5GBalCwCoNhkI/Qag9wBgM
X-Google-Smtp-Source: AGHT+IEj8xyDPFzu6WZfaq6/mrE1ljRmWVKkqOAhIIpQVRszS87HchUhnP3uI29QBPcVrG2wYu+87g==
X-Received: by 2002:a17:907:9410:b0:aca:95ee:ebed with SMTP id a640c23a62f3a-acabd130c66mr11012766b.7.1744231343802;
        Wed, 09 Apr 2025 13:42:23 -0700 (PDT)
Received: from ?IPV6:2a02:3100:9c75:6000:2d50:87f4:9992:caad? (dynamic-2a02-3100-9c75-6000-2d50-87f4-9992-caad.310.pool.telefonica.de. [2a02:3100:9c75:6000:2d50:87f4:9992:caad])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-acaa1ccc135sm149020466b.157.2025.04.09.13.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 13:42:23 -0700 (PDT)
Message-ID: <8de7da4c-2b16-4ee1-8c42-0d04f3c821c6@gmail.com>
Date: Wed, 9 Apr 2025 22:43:10 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Bjorn Helgaas <bhelgaas@google.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] PCI: Remove pci_fixup_cardbus
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Since 1c7f4fe86f17 ("powerpc/pci: Remove pcibios_setup_bus_devices()")
there's no architecture left setting pci_fixup_cardbus. Therefore
remove support from PCI core.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/pci.c        | 5 -----
 drivers/pcmcia/cardbus.c | 1 -
 include/linux/pci.h      | 3 ---
 3 files changed, 9 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 4d7c9f64e..c24d6f5a1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6806,11 +6806,6 @@ int __weak pci_ext_cfg_avail(void)
 	return 1;
 }
 
-void __weak pci_fixup_cardbus(struct pci_bus *bus)
-{
-}
-EXPORT_SYMBOL(pci_fixup_cardbus);
-
 static int __init pci_setup(char *str)
 {
 	while (str) {
diff --git a/drivers/pcmcia/cardbus.c b/drivers/pcmcia/cardbus.c
index 45c8252c8..5e5cf2c3e 100644
--- a/drivers/pcmcia/cardbus.c
+++ b/drivers/pcmcia/cardbus.c
@@ -72,7 +72,6 @@ int __ref cb_alloc(struct pcmcia_socket *s)
 	pci_lock_rescan_remove();
 
 	s->functions = pci_scan_slot(bus, PCI_DEVFN(0, 0));
-	pci_fixup_cardbus(bus);
 
 	max = bus->busn_res.start;
 	for (pass = 0; pass < 2; pass++)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0e8e3fd77..d26e6611b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1139,9 +1139,6 @@ resource_size_t pcibios_align_resource(void *, const struct resource *,
 				resource_size_t,
 				resource_size_t);
 
-/* Weak but can be overridden by arch */
-void pci_fixup_cardbus(struct pci_bus *);
-
 /* Generic PCI functions used internally */
 
 void pcibios_resource_to_bus(struct pci_bus *bus, struct pci_bus_region *region,
-- 
2.49.0


