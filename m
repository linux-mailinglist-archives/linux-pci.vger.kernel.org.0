Return-Path: <linux-pci+bounces-7077-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 569518BBCE4
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 17:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EF641C20F4B
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 15:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536BD3D971;
	Sat,  4 May 2024 15:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nBFZQmgd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E6A3D0A4;
	Sat,  4 May 2024 15:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714838022; cv=none; b=nmq8sN+SUE/JXepEpC2EPFAliw886bJoBEQiQITCyBbUPEH/30sQNXeU/VCx3cTj1+vMUuI1WN/ABZFIJgXXj+xtriDeNEtXxPOT9OB5zLZXc6jmDoeRBf8AxPMxT/EV/3HW1aGZbeaHuZoBqKTXBIrwKZM/kDtLqqu+xGUxmVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714838022; c=relaxed/simple;
	bh=8I8m+ARERilkFj7kIbhJ3jfl4OiynemXtq1r//9ZZG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FhBGtJyylf5iAZ88WUvs1TvitYOzHA6qS3HnljX8GG2AyunmIpAvvvn/sElD2DlUqhr0va8NDzbS/See0kuSZsNaHXRnWiH3RxlLD4JNY8fv9IOII+yfV6MeBWJWqxSKs/tzsxILgKAovJN51SkdId921R+QZYrHl/eYLou6jU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nBFZQmgd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED39C072AA;
	Sat,  4 May 2024 15:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714838021;
	bh=8I8m+ARERilkFj7kIbhJ3jfl4OiynemXtq1r//9ZZG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nBFZQmgdyX6pMsEUa7czdAYYb8afZ3p6iRVUD/H9YzuOfGgH1cZKo2dib2Jh93VK+
	 8LPWbA2+H9SGLgmogKYkxW5/Q+Vq/loJY9A+poOwUtd5I2agVivdOgQXtTwcqUx+b6
	 m+Duex3ZyppN9X/0T/ZfT4gefnqjqWMjeM41aIDI=
Date: Sat, 4 May 2024 17:53:38 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
	Jiri Slaby <jirislaby@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Subject: Re: [PATCH v5 17/17] serial: 8250: Add 8250_acpi driver
Message-ID: <2024050421-coil-payphone-f3a1@gregkh>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
 <20240501121742.1215792-18-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501121742.1215792-18-sunilvl@ventanamicro.com>

On Wed, May 01, 2024 at 05:47:42PM +0530, Sunil V L wrote:
> RISC-V has non-PNP generic 16550A compatible UART which needs to be
> enumerated as ACPI platform device. Add driver support for such devices
> similar to 8250_of.
> 
> The driver is enabled when the CONFIG_SERIAL_ACPI_PLATFORM option is
> enabled. Enable this option for RISC-V.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  arch/riscv/configs/defconfig        |  1 +
>  drivers/tty/serial/8250/8250_acpi.c | 96 +++++++++++++++++++++++++++++
>  drivers/tty/serial/8250/Kconfig     |  8 +++
>  drivers/tty/serial/8250/Makefile    |  1 +
>  4 files changed, 106 insertions(+)
>  create mode 100644 drivers/tty/serial/8250/8250_acpi.c
> 
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 3cae018f9315..bea8241f52eb 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -150,6 +150,7 @@ CONFIG_SERIAL_8250=y
>  CONFIG_SERIAL_8250_CONSOLE=y
>  CONFIG_SERIAL_8250_DW=y
>  CONFIG_SERIAL_OF_PLATFORM=y
> +CONFIG_SERIAL_ACPI_PLATFORM=y
>  CONFIG_SERIAL_SH_SCI=y
>  CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
>  CONFIG_VIRTIO_CONSOLE=y
> diff --git a/drivers/tty/serial/8250/8250_acpi.c b/drivers/tty/serial/8250/8250_acpi.c
> new file mode 100644
> index 000000000000..3682443bb69c
> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_acpi.c
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Serial Port driver for ACPI platform devices
> + *
> + * This driver is for generic 16550 compatible UART enumerated via ACPI
> + * platform bus instead of PNP bus like PNP0501. This is not a full
> + * driver but mostly provides the ACPI wrapper and uses generic
> + * 8250 framework for rest of the functionality.

No copyright line?  Odd, but ok, I'll take it, glad to see your company
finally realizes the lack of needing them :)


And as Andy said, please use the existing driver and extend what you
need, don't write a new one, we really don't need a new one.

> +static int acpi_platform_serial_probe(struct platform_device *pdev)
> +{
> +	struct acpi_serial_info *data;
> +	struct uart_8250_port port8250;
> +	struct device *dev = &pdev->dev;
> +	struct resource *regs;
> +
> +	int ret, irq;
> +
> +	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!regs) {
> +		dev_err(dev, "no registers defined\n");
> +		return -EINVAL;
> +	}
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	memset(&port8250, 0, sizeof(port8250));
> +
> +	spin_lock_init(&port8250.port.lock);

Are you sure this works?

thanks,

greg k-h

