Return-Path: <linux-pci+bounces-16285-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A189C1134
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 22:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 028AC1F24DFE
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 21:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64354218321;
	Thu,  7 Nov 2024 21:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaXnsB3S"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335A8215F58;
	Thu,  7 Nov 2024 21:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731015754; cv=none; b=MhPj9q4OSNBN0IjxGLIlNZXYqbtEJQrratqzJuZ87vyQ3MRER41+n19XaBsTpiRvqcHadr5qg9EDfSYON/YzSygD4ONbpaUO9+PUQfIzV3jm7zVD48GuErXZKaNa3Ec73Ng+CFzBZFIfNb9BzKLwiWPUGRgHqLLakSMzwLkAnhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731015754; c=relaxed/simple;
	bh=FcYUJ+4GHUv5Sh3L9Zfp/K9Lszu8SjF/reZwZ+dZ5Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3qa8cVtbyO/zbT6iRoUOoDWJiII9kNQGN7Zg/1QjJvjn/dKC5Vt4mDBVqAo0UoR7VA3tV5hfCPzdnCmlhaFsga61JaUvt6pxcsiRv013Rc2+4ZYntGxorFR/K91GfQ7B/TZBgz98n4vWYGVCm4ENy9emGizNldbSSqAFpe9XTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PaXnsB3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BCDC4CECC;
	Thu,  7 Nov 2024 21:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731015753;
	bh=FcYUJ+4GHUv5Sh3L9Zfp/K9Lszu8SjF/reZwZ+dZ5Tg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PaXnsB3Sc87nO3crdOU8BzjayFNgEzJEf4RqyMksB6DZkkylCfmXpUSiJ0ped+Hsc
	 5i78TKYpDLpEaoPKHHSkrVT3OOGoxttjg0DVGQydSrNuRkq2PSWSErJKhI8J7xDHST
	 qrWU0cPjOBPPvjDts9xBMpgxsxNt+jDibO5Fzy+mg9FLZGRhMzkiCzM8qrQjgHJf+B
	 YBZ3EMbSjsqj57HcPh5kxm40db02b62qGPAtECBHpU78oFzHdFRnyxZzhRLzLGEUn+
	 Kf3EGJoBMtRzQEOmL/v7FEMa14miyvcrR5bzI0vJbyHe9Vi2aUioGgwyLKaQC+hsw5
	 Q1edN0W42c/Cg==
Date: Thu, 7 Nov 2024 22:42:28 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, dlemoal@kernel.org, maz@kernel.org,
	tglx@linutronix.de, jdmason@kudzu.us
Subject: Re: [PATCH v4 4/5] misc: pci_endpoint_test: Add doorbell test case
Message-ID: <Zy00REIOJlijfmPW@ryzen>
References: <20241031-ep-msi-v4-0-717da2d99b28@nxp.com>
 <20241031-ep-msi-v4-4-717da2d99b28@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031-ep-msi-v4-4-717da2d99b28@nxp.com>

On Thu, Oct 31, 2024 at 12:27:03PM -0400, Frank Li wrote:
> Add three registers: PCIE_ENDPOINT_TEST_DB_BAR, PCIE_ENDPOINT_TEST_DB_ADDR,
> and PCIE_ENDPOINT_TEST_DB_DATA.
> 
> Trigger the doorbell by writing data from PCI_ENDPOINT_TEST_DB_DATA to the
> address provided by PCI_ENDPOINT_TEST_DB_ADDR and wait for endpoint
> feedback.
> 
> Add two command to COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL
> to enable EP side's doorbell support and avoid compatible problem.
> 
> 		Host side new driver	Host side old driver
> EP: new driver		S			F
> EP: old driver		F			F
> 
> S: If EP side support MSI, 'pcitest -B' return success.
>    If EP side doesn't support MSI, the same to 'F'.
> 
> F: 'pcitest -B' return failure, other case as usual.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change from v3 to v4
> - Add COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL.
> - Remove new DID requirement.
> ---
>  drivers/misc/pci_endpoint_test.c | 63 ++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/pcitest.h     |  1 +
>  2 files changed, 64 insertions(+)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 3aaaf47fa4ee2..d8193626c8965 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -42,6 +42,8 @@
>  #define COMMAND_READ				BIT(3)
>  #define COMMAND_WRITE				BIT(4)
>  #define COMMAND_COPY				BIT(5)
> +#define COMMAND_ENABLE_DOORBELL			BIT(6)
> +#define COMMAND_DISABLE_DOORBELL		BIT(7)
>  
>  #define PCI_ENDPOINT_TEST_STATUS		0x8
>  #define STATUS_READ_SUCCESS			BIT(0)
> @@ -53,6 +55,11 @@
>  #define STATUS_IRQ_RAISED			BIT(6)
>  #define STATUS_SRC_ADDR_INVALID			BIT(7)
>  #define STATUS_DST_ADDR_INVALID			BIT(8)
> +#define STATUS_DOORBELL_SUCCESS			BIT(9)
> +#define STATUS_DOORBELL_ENABLE_SUCCESS		BIT(10)
> +#define STATUS_DOORBELL_ENABLE_FAIL		BIT(11)
> +#define STATUS_DOORBELL_DISABLE_SUCCESS		BIT(12)
> +#define STATUS_DOORBELL_DISABLE_FAIL		BIT(13)
>  
>  #define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
>  #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
> @@ -67,7 +74,12 @@
>  #define PCI_ENDPOINT_TEST_IRQ_NUMBER		0x28
>  
>  #define PCI_ENDPOINT_TEST_FLAGS			0x2c
> +#define PCI_ENDPOINT_TEST_DB_BAR		0x30
> +#define PCI_ENDPOINT_TEST_DB_ADDR		0x34
> +#define PCI_ENDPOINT_TEST_DB_DATA		0x38
> +
>  #define FLAG_USE_DMA				BIT(0)
> +#define FLAG_SUPPORT_DOORBELL			BIT(1)

Unused.


>  
>  #define PCI_DEVICE_ID_TI_AM654			0xb00c
>  #define PCI_DEVICE_ID_TI_J7200			0xb00f
> @@ -75,6 +87,7 @@
>  #define PCI_DEVICE_ID_TI_J721S2		0xb013
>  #define PCI_DEVICE_ID_LS1088A			0x80c0
>  #define PCI_DEVICE_ID_IMX8			0x0808
> +#define PCI_DEVICE_ID_IMX8_DB			0x080c

Unused.


>  
>  #define is_am654_pci_dev(pdev)		\
>  		((pdev)->device == PCI_DEVICE_ID_TI_AM654)
> @@ -108,6 +121,7 @@ enum pci_barno {
>  	BAR_3,
>  	BAR_4,
>  	BAR_5,
> +	NO_BAR = -1,
>  };
>  
>  struct pci_endpoint_test {
> @@ -746,6 +760,52 @@ static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
>  	return false;
>  }
>  
> +static bool pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
> +{
> +	enum pci_barno bar;
> +	u32 data, status;
> +	u32 addr;


You need to do:
pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);

Before sending the COMMAND_ENABLE_DOORBELL command.

Otherwise, when EP sends an IRQ in response to COMMAND_ENABLE_DOORBELL
being done, it will send it using type reg->irq_type, which will be 0,
since you haven't initialized it. Thus the EP will trigger a INTx IRQ.


You probably also want to have a variable:
int irq_type = test->irq_type;

So that you initialize irq_type to test->irq_type, instead of using the
global variable irq_type.

(This matches how it is done in pci_endpoint_test_write(),
pci_endpoint_test_read(), and pci_endpoint_test_write().)


> +
> +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
> +				 COMMAND_ENABLE_DOORBELL);
> +
> +	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
> +
> +	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
> +	if (status & STATUS_DOORBELL_ENABLE_FAIL)
> +		return false;
> +
> +	data = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_DATA);
> +	addr = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_ADDR);
> +	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
> +
> +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
> +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
> +
> +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS, 0);
> +
> +	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
> +
> +	writel(data, test->bar[bar] + addr);
> +
> +	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
> +
> +	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
> +
> +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
> +				 COMMAND_DISABLE_DOORBELL);
> +
> +	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
> +
> +	status |= pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
> +
> +	if ((status & STATUS_DOORBELL_SUCCESS) &&
> +	    (status & STATUS_DOORBELL_DISABLE_SUCCESS))
> +		return true;
> +
> +	return false;
> +}
> +
>  static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
>  				    unsigned long arg)
>  {
> @@ -793,6 +853,9 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
>  	case PCITEST_CLEAR_IRQ:
>  		ret = pci_endpoint_test_clear_irq(test);
>  		break;
> +	case PCITEST_DOORBELL:
> +		ret = pci_endpoint_test_doorbell(test);
> +		break;
>  	}
>  
>  ret:
> diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
> index 94b46b043b536..06d9f548b510e 100644
> --- a/include/uapi/linux/pcitest.h
> +++ b/include/uapi/linux/pcitest.h
> @@ -21,6 +21,7 @@
>  #define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
>  #define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
>  #define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
> +#define PCITEST_DOORBELL	_IO('P', 0x11)
>  
>  #define PCITEST_FLAGS_USE_DMA	0x00000001
>  
> 
> -- 
> 2.34.1
> 

