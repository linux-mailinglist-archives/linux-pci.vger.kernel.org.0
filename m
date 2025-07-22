Return-Path: <linux-pci+bounces-32730-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 913BAB0DAB6
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 15:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72D431896453
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 13:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFA92E11C5;
	Tue, 22 Jul 2025 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIMiSyOw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AB8DDC3;
	Tue, 22 Jul 2025 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753190815; cv=none; b=KQ2VzrJkjoJ8Ab3R7xAa1B+d9WfkROcJ2KCvCXpHX8FD9s2hjrGKWr2MtHm0XmqXjD2AFiTYEgRxYsU7vuyIJnvWkZPHaBbiSrXIR+UtIll7G9hL+/wRMYsT5McRV+PNhf1ZZjetqMJF1b+PlMWATOLgJtrJer4fZEgS8aKxbpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753190815; c=relaxed/simple;
	bh=920Ca2ouMMHxRdAAUWeWoX9aUz6BMIrpWi9RTdL86rg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UUgDTG48aDDgOo9nAotIDfk6txHHoRdiSTax4inVnPe3UbjVnAfb4x7tCFZU+Ua78/wbBOnI0ZL0vGHqLhB5wA44xZXjwq/ebLpRFHHR/V4YJTc0aaqi29kXAVrg4I4Gm97+UdANCLsAbSrtJfYWlgtz5Uui5Vh3a2jV1cZZMks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIMiSyOw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1215C4CEF1;
	Tue, 22 Jul 2025 13:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753190815;
	bh=920Ca2ouMMHxRdAAUWeWoX9aUz6BMIrpWi9RTdL86rg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qIMiSyOweINPcFI7ATAonMAECBG/QwDPtxozhYz1HEi+KIZAJDrvbF0KrLP3my+ee
	 Ufdvh4ab8i5uZeE3tYdElEhmzChIl0BR0kjxVHAjQaeajK2oalFBW0MrwM4XTjYxM5
	 dhmYw00eJAomhQ6eAXBMOdko0Ox6xTZFMJl4WUjM+2cUYUrCJVLtN+0Ysardl5kU+v
	 MAlN+2AhMP/FlkF1iLDeOm4KBj2oYQLRCUtWrQpd2dHQwaVvsmfGE+uXCWzlPeuRMa
	 HcHn05cwyWvkhH5TPdcUm3eHhwhceKje9kz/TCEbCorYX1+oIDJUnzdFTWdT7Oiclx
	 6neytYnhfE8Mg==
Date: Tue, 22 Jul 2025 08:26:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Colin Ian King <colin.i.king@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ACPI: pci_link: Remove space before \n newline
Message-ID: <20250722132653.GA2781885@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gT1X9zuoAfxGS5XP0s1TD1tyP2shbC_cbiRJPjDg4=jA@mail.gmail.com>

On Tue, Jul 22, 2025 at 11:48:07AM +0200, Rafael J. Wysocki wrote:
> On Mon, Jul 21, 2025 at 11:40 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> ...
> >
> > Fixes for more ACPI-related typos below, feel free to squash or I can
> > send separately.
> 
> If I can assume your sign-off on this, no need to resend.

Of course, sorry, my fault:

commit 9cdbf361a40d ("ACPI: Fix typos")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon Jul 21 16:37:14 2025 -0500

    ACPI: Fix typos
    
    Fix typos in documentation and comments.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>


diff --git a/Documentation/ABI/testing/sysfs-firmware-acpi b/Documentation/ABI/testing/sysfs-firmware-acpi
index f4de60c4134d..72e7c9161ce7 100644
--- a/Documentation/ABI/testing/sysfs-firmware-acpi
+++ b/Documentation/ABI/testing/sysfs-firmware-acpi
@@ -108,15 +108,15 @@ Description:
 		number of a "General Purpose Events" (GPE).
 
 		A GPE vectors to a specified handler in AML, which
-		can do a anything the BIOS writer wants from
+		can do anything the BIOS writer wants from
 		OS context.  GPE 0x12, for example, would vector
 		to a level or edge handler called _L12 or _E12.
 		The handler may do its business and return.
-		Or the handler may send send a Notify event
+		Or the handler may send a Notify event
 		to a Linux device driver registered on an ACPI device,
 		such as a battery, or a processor.
 
-		To figure out where all the SCI's are coming from,
+		To figure out where all the SCIs are coming from,
 		/sys/firmware/acpi/interrupts contains a file listing
 		every possible source, and the count of how many
 		times it has triggered::
diff --git a/Documentation/firmware-guide/acpi/gpio-properties.rst b/Documentation/firmware-guide/acpi/gpio-properties.rst
index db0c0b1f3700..1e603189b5b1 100644
--- a/Documentation/firmware-guide/acpi/gpio-properties.rst
+++ b/Documentation/firmware-guide/acpi/gpio-properties.rst
@@ -92,8 +92,8 @@ and polarity settings. The table below shows the expectations:
 |             | Low         | as low, assuming active                       |
 +-------------+-------------+-----------------------------------------------+
 
-That said, for our above example the both GPIOs, since the bias setting
-is explicit and _DSD is present, will be treated as active with a high
+That said, for our above example, since the bias setting is explicit and
+_DSD is present, both GPIOs will be treated as active with a high
 polarity and Linux will configure the pins in this state until a driver
 reprograms them differently.
 
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index c2ab2783303f..a984ccd4a2a0 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1406,7 +1406,7 @@ static int __init acpi_bus_init(void)
 		goto error1;
 
 	/*
-	 * Register the for all standard device notifications.
+	 * Register for all standard device notifications.
 	 */
 	status =
 	    acpi_install_notify_handler(ACPI_ROOT_OBJECT, ACPI_SYSTEM_NOTIFY,

