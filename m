Return-Path: <linux-pci+bounces-30884-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0706AEABBF
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 02:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5657564AFA
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 00:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3A82F30;
	Fri, 27 Jun 2025 00:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="cVlqaiR2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D33417BA5
	for <linux-pci@vger.kernel.org>; Fri, 27 Jun 2025 00:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750984036; cv=none; b=O5Dt1aCscy6nTEYR4qD7m5oyaKvIQFE36w+3+H1/EUx6QykVIp35GF6aUmlcK/0Rn8bryy7Rhc9cqcdEQznCwhCNWq5gK76wT9MVP2zdPsdxNhxOR9e09+Az5bho3YpCEyh+7xZXl+FAfUXqZF9Xiv5VS0lzFqaavlBGmvhPj8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750984036; c=relaxed/simple;
	bh=LhoaiHA2QPBXXNrvl0cjxOzOIIr+jW/62VuMs62fhSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TOQwNR1RDVet2/AqrY43kn10xrhb+0SRb0SXB5lCwCfP8HnYnV1PqGtk1kyxmxTZekZ0Hy+d5bHs4tPCeINN87aWYd2TwQXOPTTfwsSUGQECbOdNSdSEAFUkC+75NQf5MD8qXmen0C4egUrfOoq5mpsGvOhUkVdCrkzRHM6Cm6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=cVlqaiR2; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-748feca4a61so1062391b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 17:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1750984034; x=1751588834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+L9ybrzvDULso9rMlfXfjb9fFb8snBfGBy7jz7olxIs=;
        b=cVlqaiR2Ow6KsP25X3RjImu1kO3flIO+Tac92u7nv1uVQG1DSuV0fxu7PL/L8VFukz
         4LX35Eti1eBq+RNspkmNe043HrtDGY2vEPYOCiXhf+JEBzkroFfqg4rrzlK8x6jvDp4q
         +z6iSdg+bwKoj0CjRK5GzqkmhPYGLDIp6s0PTMQrw1lTkP8qyKdxhAxkuaktr+BxdnCX
         6FoL3qzphmAXgN+X0ydm5RWJ+Dajzpmm21tk9j6UQviiHds72x4ggyrXQi6npbvWv65O
         /18J8E3E+Vlw0cNK6sE78LGd2lJCulJwZHYCI4ONGJCO+ts68GQ+LrqF3/AropUCjHDV
         sTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750984034; x=1751588834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+L9ybrzvDULso9rMlfXfjb9fFb8snBfGBy7jz7olxIs=;
        b=V8W/S9NzIRCsqTrx6saRa6EVTUnIAKkJITz4rw9KtJGDFkuvappty00xa87I9UT7we
         EexyyTkmnpMheVXNLtEIFZIagfY6PjrdYRyVqXD32Mfsi5UF7trJ3b06DVzHdQJ6AKn2
         Gpj4U0I2qG5EVhnGxYCTBahd82iI8tr6WG2xiK0Z8nb51JW4MQ+HqnTyzyplMVY7dy6B
         t1AW39pMs0JfHidjXBDrNr9g5W3HkpYuxsKD62cPlbkM2Fyvts4Uo8SG4TFi0MPJhwTa
         xMifjau+Oxl5G2JnQkf1fdPI2RhfgfXxQn2PIZ50EuXPwiAuNnIDT0NRNf0FlhCbFU6d
         lBAQ==
X-Gm-Message-State: AOJu0YwSvF8DiuVd9YouXofe4sXuxsWedzYKkEQGURWXlaxYoYS9Phwf
	0JfUwkSAm5OLWOeOExzbRZQbrl+4dWELIjZSf/rmBaYjzLd5kkV/9lZK/LjTRmhvc+h3Ytb9i9s
	7AdBOLvyNZ85OANNi+FlilCVziwP8lbxZjTvloqw8LCQTkZDZaqPn+snoMotfpjtisbw+3al3Gi
	Ue2/W6D32CrflU+SVByaJhv8zu8/JUiSxHzLJ9NZlT5m/BGg==
X-Gm-Gg: ASbGncsoSPXfpQLSvJLBuDpsfE+RnP52skjTlMektz8RN8J0EaEznJ8LOCGy+8Ku8N5
	8+Sik/wkB1vvOfWIaMriQP1j99q1ELTaUAM455O0PiHlCa9xUuSikBEF0ltOns+Z8606gHRVW6Q
	QjpAwW0duSG52HBxYPGgw8Ah8dfM7Ruolevu15UlEtauFCK0HWlfWcSzFAryl/GdyF4JbYMDOF0
	Q9gFGBBhCSUruLncJSbj4LArlrtzNzUyWSoMds75RvlTVXIdZKJmZqt6KUAugw18elnsdrIUvL7
	GZNKL7tEVhfYlJsLZGCyDUm1hNXMjPVdx9EnxRnd7NlrpgZ/cHsrilluQATomSrz8gulsEX2eUL
	ngY1gQgt24/p9
X-Google-Smtp-Source: AGHT+IGAOpkiF6fZLeeKyRvLRShXnirVeewyMyJja19yxBEe0SFzTXRtF8dzSPuJEJjocawy/XcXmA==
X-Received: by 2002:a05:6a00:a07:b0:73e:10ea:b1e9 with SMTP id d2e1a72fcca58-74af6ebae86mr1484166b3a.6.1750984033483;
        Thu, 26 Jun 2025 17:27:13 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-74af56ce9f3sm769330b3a.122.2025.06.26.17.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 17:27:13 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com,
	ashishk@purestorage.com,
	macro@orcam.me.uk,
	msaggi@purestorage.com,
	sconnor@purestorage.com,
	Matthew W Carlis <mattc@purestorage.com>
Subject: [PATCH 1/1] PCI: pcie_failed_link_retrain() return if dev is not ASM2824
Date: Thu, 26 Jun 2025 18:26:51 -0600
Message-ID: <20250627002652.22920-2-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250627002652.22920-1-mattc@purestorage.com>
References: <20250627002652.22920-1-mattc@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

  The pcie_failed_link_retrain() was added due to a behavior observed with
a very specific set of circumstances which are in a comment above the
function. The "quirk" is supposed to force the link down to Gen1 in the
case where LTSSM is stuck in a loop or failing to train etc. The problem
is that this "quirk" is applied to any bridge & it can often write the
Gen1 TLS (Target Link Speed) when it should not. Leaving the port in
a state that will result in a device linking up at Gen1 when it should not.
  Incorrect action by pcie_failed_link_retrain() has been observed with a
variety of different NVMe drives using U.2 connectors & in multiple different
hardware designs. Directly attached to the root port, downstream of a
PCIe switch (Microchip/Broadcom) with different generations of Intel CPU.
All of these systems were configured without power controller capability.
They were also all in compliance with the Async Hot-Plug Reference model in
PCI Express® Base Specification Revision 6.0 Appendix I. for OS controlled
DPC Hot-Plug.
  The issue appears to be more likely to hit to be applied when using
OOB PD (out-of band presence detect), but has also been observed without
OOB PD support ('DLL State Changed' or 'In-Band PD').
  Powering off or power cycling the slot via an out-of-band power control
mechanism with OOB PD is extremely likely to hit since the kernel would
see that slot presence is true. Physical Hot-insertion is also extremly
likely to hit this issue with OOB PD with U.2 drives due to timing
between presence assertion and the actual power-on/link-up of the NVMe
drive itself. When the device eventually does power-up the TLS would
have been left forced to Gen1. This is similarly true to the case of
power cycling or powering off the slot.
  Exact circumstances for when this issue has been hit in a system without
OOB PD due hasn't been fully understood to due having less reproductions
as well as having reverted this patch for this configurations.

Signed-off-by: Matthew W Carlis <mattc@purestorage.com>

 100.0% drivers/pci/
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d7f4ee634263..497e4acc52c8 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -100,6 +100,8 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
 	};
 	u16 lnksta, lnkctl2;
 	int ret = -ENOTTY;
+	if (!pci_match_id(ids, dev)
+		return ret;
 
 	if (!pci_is_pcie(dev) || !pcie_downstream_port(dev) ||
 	    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting)
@@ -124,8 +126,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
 	}
 
 	if ((lnksta & PCI_EXP_LNKSTA_DLLLA) &&
-	    (lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT &&
-	    pci_match_id(ids, dev)) {
+	    (lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT) {
 		u32 lnkcap;
 
 		pci_info(dev, "removing 2.5GT/s downstream link speed restriction\n");
-- 
2.46.0


