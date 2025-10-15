Return-Path: <linux-pci+bounces-38206-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 172DFBDE5AA
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 13:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7650B19C48EF
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 11:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2913321F42;
	Wed, 15 Oct 2025 11:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zS8CtYcS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC0B3233F5
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 11:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760529520; cv=none; b=DiVUuoEcSTjkwIXyEINOaEwe+o/wh8e1+zAGyCVJa91Fm+kh1c12iZFeLzCpTfLrbsrfJhaEfgnY/p+tk61FHyofGAK+sFISTgvVbhgosdi9LU4YXIV2lOX4b9bk7J8DOsHqHQv/QwAPA4xBOL3ngBUrbtxYZI4o42NlkWdMSFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760529520; c=relaxed/simple;
	bh=U7EY7Y7ald60VwwTHjpYilDKchapDcGIvAVBZiG31y0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jylLmx5LUggPufKizyeYTu/L4abHE4OePuJFOhCPH5zlAjwemEXIt6vmZ6LIg7XrNdhiusu1AivLvMrPpf+7lTU8pECNG/Jr3Va59XQRnPc9AKab2S46godYFyAm4pA7S9TEvYwkEtcRXrCqozMEmaSmfXNX46Pn4vEVbDdOCvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zS8CtYcS; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 698E04E410D4;
	Wed, 15 Oct 2025 11:58:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2E548606F9;
	Wed, 15 Oct 2025 11:58:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 656D8102F22B7;
	Wed, 15 Oct 2025 13:58:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760529515; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ngVr3I5DRzSRPzPhih29gyOv5iZlq1zTKbFNqj3H/O8=;
	b=zS8CtYcSo0bjbwx88TkAQ99cfcIvGZQbM4CbIednNRLwO9OL7ks9kvDpW8Bbh8iDMAH5Db
	2Sm4312Nqs2oUmYuJzY0649MCmQpksodMkK39tf/BNvljX2je8abxFIyIsH8l76uKoGKeK
	bUvENmKYw1OTZH3KvRG+U+TQt+aZUKf6I51EDVXqUDTfy56k8JqOnNu44IPowaKI9xYVG6
	G7kP+4CNdwUVmjR5lDgsuQXUctlLFvyZ1wg6uVS3VqIrrmS2cT0Ij4DZ4zKWxdMk0ZqA8E
	Q7lbjOcE0v2AKjzCrDboRnFUIrnFp5KQjX/o6lkSzTvAYpW4rBtwH9+KekzUPg==
Date: Wed, 15 Oct 2025 13:58:11 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas
 <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>, Manivannan Sadhasivam
 <manivannan.sadhasivam@oss.qualcomm.com>, Ilpo =?UTF-8?B?SsOkcnZpbmVu?=
 <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org, mad skateman
 <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>, Christian
 Zigotzky <info@xenosoft.de>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 hypexed@yahoo.com.au, Darren Stevens <darren@stevens-zone.net>,
 debian-powerpc@lists.debian.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
Message-ID: <20251015135811.58b22331@bootlin.com>
In-Reply-To: <A11312DD-8A5A-4456-B0E3-BC8EF37B21A7@xenosoft.de>
References: <20251015101304.3ec03e6b@bootlin.com>
	<A11312DD-8A5A-4456-B0E3-BC8EF37B21A7@xenosoft.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Christian,

On Wed, 15 Oct 2025 13:30:44 +0200
Christian Zigotzky <chzigotzky@xenosoft.de> wrote:

> Hello Herve,
> 
> > On 15 October 2025 at 10:39 am, Herve Codina <herve.codina@bootlin.com> wrote:
> > 
> > ﻿Hi All,
> > 
> > I also observed issues with the commit f3ac2ff14834 ("PCI/ASPM: Enable all
> > ClockPM and ASPM states for devicetree platforms")  
> 
> Thanks for reporting.
> 
> > 
> > Also tried the quirk proposed in this discussion (quirk_disable_aspm_all)
> > an the quirk also fixes the timing issue.  
> 
> Where have you added quirk_disable_aspm_all?

--- 8< ---
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 214ed060ca1b..a3808ab6e92e 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2525,6 +2525,17 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
  */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
 
+static void quirk_disable_aspm_all(struct pci_dev *dev)
+{
+       pci_info(dev, "Disabling ASPM\n");
+       pci_disable_link_state(dev, PCIE_LINK_STATE_ALL);
+}
+
+/* LAN966x PCI board */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_EFAR, 0x9660, quirk_disable_aspm_all);
+
 /*
  * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
  * Link bit cleared after starting the link retrain process to allow this
--- 8< ---

Best regards,
Hervé

