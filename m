Return-Path: <linux-pci+bounces-32684-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C1CB0CCCB
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 23:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26AE71889AAF
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 21:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E4523C8CE;
	Mon, 21 Jul 2025 21:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbCgsvrI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19FE1D63C5;
	Mon, 21 Jul 2025 21:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753134006; cv=none; b=WWeWXJxhWGIkDfCf6mpYJkUdQwdcxmRPTnMaEjpAFBXxcVzJ1qfGWVxCCKiw5RG/m41xR7YWzTRGsDE/Phla6946GTwKuUUhYOcCv2pPVLs7k7XvuydsoIe6cMI9nhUPsGEr6h7nGe2hUfGphbt8+s21rel33O0/a5Lu/7XiBJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753134006; c=relaxed/simple;
	bh=ClyfYCr1u9jQfmH2abra/H4JduOhfim5mQuRYUsYzzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=k9PLvCCwKS4V3om72l08TwF0i6FHJXuyFVEG9YGJPGOhCB71z4p4CnhHlSCvDTt7HzahEUxhsbM84TUPwNpN71+oJVeAgWZgiCiAnSZa3FqrUbpXDI3w2FNMauab8r0h3rb2kyb95A/vnv5DsYHaQsJidXNK3XnXhnLdG/OxhU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbCgsvrI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D812C4CEED;
	Mon, 21 Jul 2025 21:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753134006;
	bh=ClyfYCr1u9jQfmH2abra/H4JduOhfim5mQuRYUsYzzQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QbCgsvrI61SVfv3SiAF8AjqkuXjJadTNEWKg3yy7vo9KW0wK65sjO+y4RhPgg+vc2
	 R7OHLZmwv1Gr35ADp+Rvf254UtfaiBpNJYlcoKjnxDmBTWCwlch4hcikeMzEg0OyV+
	 PzMMHBPYyygXayguf5doyyPG7q0mNdN9+KJfADB/YUqGVBrWQctmWnX/7mgFqdQqjV
	 1nN5P4njedGr5kDvRTiw+9xuK8Tr0VXUyMDatTpsHVMCjx8oZfPSLgGFXQt3hVRJAa
	 RFgm74xv6mX9+qdsL/l7Ohzpr0Pu802Ntk4y75fE0tA1n5NAEijPU5ykMr3ChXQ2D/
	 L1XqBN0Rig6Xg==
Date: Mon, 21 Jul 2025 16:40:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ACPI: pci_link: Remove space before \n newline
Message-ID: <20250721214004.GA2756360@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721145952.2601422-1-colin.i.king@gmail.com>

On Mon, Jul 21, 2025 at 03:59:52PM +0100, Colin Ian King wrote:
> There is an extraneous space before a newline in an acpi_handle_debug
> message.  Remove it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

FWIW,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Fixes for more ACPI-related typos below, feel free to squash or I can
send separately.

> ---
>  drivers/acpi/pci_link.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index 08e10b6226dc..e4560b33b8ad 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -268,7 +268,7 @@ static int acpi_pci_link_get_current(struct acpi_pci_link *link)
>  
>  	link->irq.active = irq;
>  
> -	acpi_handle_debug(handle, "Link at IRQ %d \n", link->irq.active);
> +	acpi_handle_debug(handle, "Link at IRQ %d\n", link->irq.active);
>  
>        end:
>  	return result;

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

