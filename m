Return-Path: <linux-pci+bounces-9987-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EA392B2CB
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 10:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4930A1C222F2
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 08:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E500155725;
	Tue,  9 Jul 2024 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A/8c7ZnS"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C274115382F
	for <linux-pci@vger.kernel.org>; Tue,  9 Jul 2024 08:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720515394; cv=none; b=Ct0FX2eU9l8Sc4X6qu+URHWi4ecSMs3kYAxGUwrJirl+qNv6BHB/BAg+7t/2VOFTCB4CLHKF/UGlwpj2/p+AlveBhdkBqTYB574vgewPb+1c9aElcsMADEuNoUQ7W0uBynmoYw/fq2VtXyxj42jhFmdtf88SmQ40kCfgOs2McC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720515394; c=relaxed/simple;
	bh=ZjleyqreNzd5N6niM8JfYISv9RvH3ugjN68S6yfTxpM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CvWGNvMIMxFyVhYfEa1w6QRrdqjyf+ul/R2QC2u0hSuOb4clTKZoutY+kSrlkL8Fr8l39nUNFLGqqd0WYz+/1LB9d6aNOXL8N5pt3F3i3hO9/aW2MDjQk/GF88VfZu18xDJSfacN9mqYXD/GFTmQd8gsRuVlrqluRPaeQt0wISE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A/8c7ZnS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720515391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mZo3i4FrLDziFrzuVJBLT1zQ9UdyZZW5nDEeprPuspY=;
	b=A/8c7ZnSyClGgmVZO6pefIL+cDKIHqkgZEpykFISNPy2BeoRpNJ+usyevLuQQLa9shwujs
	rurpoCS3XOdzoyuRWSjiZ57UheV3y2+hKsm904roSZCI1whV2xRQx6e6FzqQfk5L12YAMV
	0e1WM7OGeF91pKcLMp+BHh/gS43PIV8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412--lC-96rMPma8apDsw7YDIw-1; Tue, 09 Jul 2024 04:56:29 -0400
X-MC-Unique: -lC-96rMPma8apDsw7YDIw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52e9df289b4so744507e87.2
        for <linux-pci@vger.kernel.org>; Tue, 09 Jul 2024 01:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720515388; x=1721120188;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mZo3i4FrLDziFrzuVJBLT1zQ9UdyZZW5nDEeprPuspY=;
        b=tGyY46f+Pijlye+NkHGvvmnEgmWCP/UxY23NM/WacLEsKuOOMmY1dNjss716DgZCBH
         75nBAFN6LVp5REAJyL7ZXztBJcrMIRaFHXJYGETMnR9Ur4xjQtR4usUwUMGn9SXdQPET
         H55uQSe25crsoOD6o+YNIyJ4lIjkEtOZQh7BbeYNe7OEo1BVI6b+karnbFbALNWdlazl
         hFRsH4hPQjx4luNY5Z2ZaRzuvlmbGJYek3Nmsz3LAeWajmzd6+lDftE4HsoDXz3O79m7
         SA1yBMZMgWVaPZWAfLpbUEirrQnBCmkVdC8K9mzUtGxMkZ7hHAazqGTD2Ol8UpTB8Tkg
         mneA==
X-Forwarded-Encrypted: i=1; AJvYcCWkl22U4Trx/K73BaZZyJAMqqvRUvUfU+M9bu0DQpVUaayKv5e+zY2WX3oLtsSKduxhgHMY3LTtIkJ8moCxrWXBI9t7PBEmx51p
X-Gm-Message-State: AOJu0Yx2xEZKZiY3jcJJM1WI9NN2gIHwDqu1KIsIe9ePK+7AXz2Ih+hw
	CM5XAH/7cFBlEBURjYTV1iFB0lF9qFhXZ1oJ21T+ChlmVWbrGC7usMzza6WJ/5VoS5oE7w717O+
	PzEwx8q0b9XqA81xf748EbZTQx8tK8KC5eYQetebC3n43deG9Sm46aL+sbw==
X-Received: by 2002:a2e:a594:0:b0:2ec:4287:26ac with SMTP id 38308e7fff4ca-2eeb3191af2mr13488411fa.4.1720515388430;
        Tue, 09 Jul 2024 01:56:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJFO85FdSpN/tGtIniVZthBrr5afzWmwuyHHpTqaBS39B1vWHCFm7f/iojSiOOVOD1vzLidg==
X-Received: by 2002:a2e:a594:0:b0:2ec:4287:26ac with SMTP id 38308e7fff4ca-2eeb3191af2mr13488161fa.4.1720515387987;
        Tue, 09 Jul 2024 01:56:27 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f741624sm29991115e9.41.2024.07.09.01.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 01:56:27 -0700 (PDT)
Message-ID: <426645d40776198e0fcc942f4a6cac4433c7a9aa.camel@redhat.com>
Subject: Re: [PATCH v9 10/13] PCI: Give pci_intx() its own devres callback
From: Philipp Stanner <pstanner@redhat.com>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: airlied@gmail.com, bhelgaas@google.com, dakr@redhat.com,
 daniel@ffwll.ch,  dri-devel@lists.freedesktop.org, hdegoede@redhat.com, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, sam@ravnborg.org, 
 tzimmermann@suse.de, thomas.lendacky@amd.com, mario.limonciello@amd.com
Date: Tue, 09 Jul 2024 10:56:26 +0200
In-Reply-To: <20240708214656.4721-1-Ashish.Kalra@amd.com>
References: <20240613115032.29098-11-pstanner@redhat.com>
	 <20240708214656.4721-1-Ashish.Kalra@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

From c24bd5b66e798a341caf183fb7cdbdf235502d90 Mon Sep 17 00:00:00 2001
From: Philipp Stanner <pstanner@redhat.com>
Date: Tue, 9 Jul 2024 09:45:48 +0200
Subject: [PATCH] PCI: Fix pcim_intx() recursive calls

pci_intx() calls into pcim_intx() in managed mode, i.e., when
pcim_enable_device() had been called. This recursive call causes a bug
by re-registering the device resource in the release callback.

This is the same phenomenon that made it necessary to implement some
functionality a second time, see __pcim_request_region().

Implement __pcim_intx() to bypass the hybrid nature of pci_intx() on
driver detach.

Fixes: https://lore.kernel.org/all/20240708214656.4721-1-Ashish.Kalra@amd.c=
om/
Reported-by: Ashish Kalra <Ashish.Kalra@amd.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
Hi Ashish,
I hacked down this fix that should be applyable on top.
Could you maybe have a first quick look whether this fixes the issue?
---
 drivers/pci/devres.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 2f0379a4e58f..dcef049b72fe 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -408,12 +408,31 @@ static inline bool mask_contains_bar(int mask, int ba=
r)
 	return mask & BIT(bar);
 }
=20
+/*
+ * This is a copy of pci_intx() used to bypass the problem of occuring
+ * recursive function calls due to the hybrid nature of pci_intx().
+ */
+static void __pcim_intx(struct pci_dev *pdev, int enable)
+{
+	u16 pci_command, new;
+
+	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
+
+	if (enable)
+		new =3D pci_command & ~PCI_COMMAND_INTX_DISABLE;
+	else
+		new =3D pci_command | PCI_COMMAND_INTX_DISABLE;
+
+	if (new !=3D pci_command)
+		pci_write_config_word(pdev, PCI_COMMAND, new);
+}
+
 static void pcim_intx_restore(struct device *dev, void *data)
 {
 	struct pci_dev *pdev =3D to_pci_dev(dev);
 	struct pcim_intx_devres *res =3D data;
=20
-	pci_intx(pdev, res->orig_intx);
+	__pcim_intx(pdev, res->orig_intx);
 }
=20
 static struct pcim_intx_devres *get_or_create_intx_devres(struct device *d=
ev)
@@ -443,7 +462,6 @@ static struct pcim_intx_devres *get_or_create_intx_devr=
es(struct device *dev)
  */
 int pcim_intx(struct pci_dev *pdev, int enable)
 {
-	u16 pci_command, new;
 	struct pcim_intx_devres *res;
=20
 	res =3D get_or_create_intx_devres(&pdev->dev);
@@ -451,16 +469,7 @@ int pcim_intx(struct pci_dev *pdev, int enable)
 		return -ENOMEM;
=20
 	res->orig_intx =3D !enable;
-
-	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
-
-	if (enable)
-		new =3D pci_command & ~PCI_COMMAND_INTX_DISABLE;
-	else
-		new =3D pci_command | PCI_COMMAND_INTX_DISABLE;
-
-	if (new !=3D pci_command)
-		pci_write_config_word(pdev, PCI_COMMAND, new);
+	__pcim_intx(pdev, enable);
=20
 	return 0;
 }
--=20
2.45.0


