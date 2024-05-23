Return-Path: <linux-pci+bounces-7804-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8838CDC70
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 23:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E76781C23A9E
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 21:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5A8127E32;
	Thu, 23 May 2024 21:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlf+g2x0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CA1B662;
	Thu, 23 May 2024 21:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716501546; cv=none; b=BWwCEyteqtuROFugrLSgEtv9fTBAbXTAdS5TTWf2DMrfdWcTgldpQe7Wp8VKNfjr9LTUjMpIOajkMQZFyjlfQTh1JreuMlCLBPAa6ZmEmMzYjGdMDRnJLR/JbDi1+F8g658Tgf63Bc/L9WaXMLZJRP/lLou4UgBun3Rg3fYrAts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716501546; c=relaxed/simple;
	bh=QZ7Ne6Y6VxRzARq/sM9xQGLKOxgu4KxELYwAPQWlY/o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kWnxK99MvQrXDr7LJEugONkFj0AFNF0VbPK0hlBjIyT8DhkNssG6ZLu+/Akx5MEvs8RotyJ1hLwx0FRrYBI8ynfFj0xhKOFsVofE6v6XEAtkuJLspv8PN+Zj0JObfDylYKHDaD/+424N5yU56MUaNaFV4jtgEt34I1PeYbuDkJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlf+g2x0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346A9C2BD10;
	Thu, 23 May 2024 21:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716501545;
	bh=QZ7Ne6Y6VxRzARq/sM9xQGLKOxgu4KxELYwAPQWlY/o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rlf+g2x0my/tsSc572EXkgu9g5zzNMzCe1Um7GaPWPhja1AdmVcvHfJ5JFWWXo5Kl
	 DyCOt/h5cmh09lihD9eOwLfZtmJX08u9JSM6g8APDYjLueOGZIH7LkztD0Y3K/QX/O
	 otr708MxWtJNd4mrV0gKGNxLgtB8nAEWdACtUFkQ/3Lltvl88JxF0vSAYYCBVDrsk/
	 7bmzPYpBa/kaRVXRoiGWS7wOjysFJQh1z4WOCmjhJ8ymFqfWDb7mN6lYnhRPf4FJYG
	 lnhd4c/KRzpPVGeZscRsYjWLBTRznptGmkCQQQgislE8Vk0xUyGRjZ2LnxSs2acNAm
	 4Fm9PNLsPbUig==
Date: Thu, 23 May 2024 16:59:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Subject: Re: [PATCH v5 07/17] ACPI: bus: Add RINTC IRQ model for RISC-V
Message-ID: <20240523215903.GA138985@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501121742.1215792-8-sunilvl@ventanamicro.com>

On Wed, May 01, 2024 at 05:47:32PM +0530, Sunil V L wrote:
> Add the IRQ model for RISC-V INTC so that acpi_set_irq_model can use this
> for RISC-V.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  drivers/acpi/bus.c   | 3 +++
>  include/linux/acpi.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 17ee483c3bf4..6739db258a95 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -1190,6 +1190,9 @@ static int __init acpi_bus_init_irq(void)
>  	case ACPI_IRQ_MODEL_LPIC:
>  		message = "LPIC";
>  		break;
> +	case ACPI_IRQ_MODEL_RINTC:
> +		message = "RINTC";
> +		break;
>  	default:
>  		pr_info("Unknown interrupt routing model\n");
>  		return -ENODEV;
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 846a4001b5e0..c1a01fd02873 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -107,6 +107,7 @@ enum acpi_irq_model_id {
>  	ACPI_IRQ_MODEL_PLATFORM,
>  	ACPI_IRQ_MODEL_GIC,
>  	ACPI_IRQ_MODEL_LPIC,
> +	ACPI_IRQ_MODEL_RINTC,

Is the ACPI_IRQ_MODEL_RINTC value documented somewhere?  Maybe an ECR
for the ACPI spec?

acpi_bus_init_irq() is going to pass ACPI_IRQ_MODEL_RINTC to _PIC, and
ACPI r6.5, sec 5.8.1 only mentions the ACPI_IRQ_MODEL_PIC,
ACPI_IRQ_MODEL_IOAPIC, and ACPI_IRQ_MODEL_IOSAPIC values.

Even the existing ACPI_IRQ_MODEL_PLATFORM, ACPI_IRQ_MODEL_GIC, and
ACPI_IRQ_MODEL_LPIC values aren't mentioned in ACPI r6.5.

>  	ACPI_IRQ_MODEL_COUNT
>  };
>  
> -- 
> 2.40.1
> 

