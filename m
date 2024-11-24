Return-Path: <linux-pci+bounces-17241-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1279D6C82
	for <lists+linux-pci@lfdr.de>; Sun, 24 Nov 2024 03:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42C0281654
	for <lists+linux-pci@lfdr.de>; Sun, 24 Nov 2024 02:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854AD33F3;
	Sun, 24 Nov 2024 02:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y/YOOkjd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB6A36C
	for <linux-pci@vger.kernel.org>; Sun, 24 Nov 2024 02:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732415970; cv=none; b=c4J5cIP+sWZzTOevM13hQBm2RIKbO4JohmKPX0i21JPQmNfUhYh2EiN97mgzO0XzM68hkOov6Xsjuqhq1/uvJKEj83dVY+N+5+fcI+2DMk1EtAddBP3aE6ffAIlETDdC8FWNWpLpyXrLjsFDJp+WladP6vEZ7gPL5fEqKbEAnG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732415970; c=relaxed/simple;
	bh=gtr+ngDgcrAj6X3gZV6gwMLw1XfTpSDJKwKIfJJdvwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HI2X2PXhkNzI6kz/Hn8+pt3wdKeWisf+7+Z298E9Gsijs7n7jXcZ6j/h32EkNWdgivwIwRUn6koN/hCvH262zbfAMF3EEE6ihLR5Sjkq2kaktcyOBiZNky/usekqaWDRTe2Ii+x8Nv4CtWq/dZ5vycPnlcSW7WUVvZGSv6rvV8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y/YOOkjd; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-720cb6ac25aso2801496b3a.3
        for <linux-pci@vger.kernel.org>; Sat, 23 Nov 2024 18:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732415968; x=1733020768; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lhUhdIMSKTjtT/QAt7R3zjry+fBZIZGfBwA5CoMtvWg=;
        b=Y/YOOkjdpwF0VeVfa26U/p63elxU+LL8OINooLby5G1iFDne2kOeTOyhLHoQbqU8KC
         h2j2kgL8G6boDXkoxT4cb/Go57J8aN/TOrHI8j/VHrkT0SrdXcCwPt5Fso2Fv0aVGYbv
         ofmpQGpYCG5W1ecSQE6NJ0Gy+LoJ1uAcHhXc/MM47aNdwJz1kP30wk8247mB91WaXDvE
         AB1Q5Jbb1RDuR8ciQ6WUEy9z2Rd/ACPEL3qnMB1K6hhdsaOKA52nViYhWyUysK67gAnr
         m4H74/IM26LmSCLHsAtoFLr1AIQ5Jwq70QOZ8MYx/1yeQb5/E6TmZXRMbxFOWJsqPr+5
         mlkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732415968; x=1733020768;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lhUhdIMSKTjtT/QAt7R3zjry+fBZIZGfBwA5CoMtvWg=;
        b=cR+GQCaAI29IdjxF5OziwV6NlcuPo1W09Gj64nFUhYEJlXgUBIP/F+M5idQrmAdNkw
         0BmDhRGigOb3NpgEINIKw+o/YVdBkKhIYj3VbpMU60d3tqkd5yP71V6YAScNlpCY2n78
         yHEjDo0ZtytNwEpTMuB+rwV+mJ39DeYLBoEW67yYMatMbvx0ZH4XNtRmIelEOIqqyqmD
         DhfmnEBfoaD1gyvwT+hX+ZQOIBPAt8950RXWrDM4wt+klw0G7CtGUmBh5xTRsb38x0Pp
         wIeGc2K52aVfGgCDAvcX5YI0SfgqfW2OdMUktVloiTCZUSx/WCUGxpKP+zv1o4Br+gcj
         gVaw==
X-Forwarded-Encrypted: i=1; AJvYcCWlmB2TVS0FNd32dD2Wwi+2dn4mn6urs1Nhj2UAEDXri+8OKGBbIIyOTi+LNc4wVNfNv4e7HU2mlbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxMUjMTHXs8mpHfODEGogAC5BzvQo3/RVAk7yLQS23Kr6uBhkb
	2m5WabKc64L5wA6Oln4Tlb2kT4sDaG9xhSm3Zzz/po93UaBFMXJsYqJaTY7sGw==
X-Gm-Gg: ASbGncsw1H9/+Jn/WLqpo8O3Mtd29oOr7Q4zxAQtygko/a0pL4+ez21smGvRz6KZwbl
	5aNPe+Os074XQbVH/QsOD6kWnVHneezICieiSBjliG7fC3IDmF7ok8JoMY5EiBlJBnOZYNi5Z08
	12150crNBrmadn3YmjuvNIJjI+UL7DeD1s6PwRn/QRFx78FCbK6GhA8bWZ27wAVTxBksFZwfEaR
	WELsl5bjk+QP4uepdE/4W8LroMe1gv09ulKZhxF6RHAee+FmJ4m7OiIp4a2
X-Google-Smtp-Source: AGHT+IFOL55nNkDbUXkmgMxxntzrtVoaZlJgzC0kO1MnvyPLyWv81CM6PiIg0YlHdU3oE1UHW7u8gA==
X-Received: by 2002:a17:902:f693:b0:20c:7661:dce8 with SMTP id d9443c01a7336-2129fd5c829mr134918435ad.36.1732415967934;
        Sat, 23 Nov 2024 18:39:27 -0800 (PST)
Received: from thinkpad ([49.207.202.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba174fsm39520155ad.67.2024.11.23.18.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 18:39:27 -0800 (PST)
Date: Sun, 24 Nov 2024 08:09:22 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] misc: pci_endpoint_test: Add consecutive BAR test
Message-ID: <20241124023922.dpdjublabfnfxrd4@thinkpad>
References: <20241116032045.2574168-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241116032045.2574168-2-cassel@kernel.org>

On Sat, Nov 16, 2024 at 04:20:45AM +0100, Niklas Cassel wrote:
> Add a more advanced BAR test that writes all BARs in one go, and then reads
> them back and verifies that the value matches the BAR number bitwise OR:ed
> with offset, this allows us to verify:
> -The BAR number was what we intended to read.
> -The offset was what we intended to read.
> 
> This allows us to detect potential address translation issues on the EP.
> 
> Reading back the BAR directly after writing will not allow us to detect the
> case where inbound address translation on the endpoint incorrectly causes
> multiple BARs to be redirected to the same memory region (within the EP).
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/misc/pci_endpoint_test.c | 88 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/pcitest.h     |  1 +
>  tools/pci/pcitest.c              | 16 +++++-
>  tools/pci/pcitest.sh             |  1 +
>  4 files changed, 105 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 3aaaf47fa4ee2..34cb54aef3d8b 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -322,6 +322,91 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>  	return true;
>  }
>  
> +static u32 bar_test_pattern_with_offset(enum pci_barno barno, int offset)
> +{
> +	u32 val;
> +
> +	/* Keep the BAR pattern in the top byte. */
> +	val = bar_test_pattern[barno] & 0xff000000;
> +	/* Store the (partial) offset in the remaining bytes. */
> +	val |= offset & 0x00ffffff;
> +
> +	return val;
> +}
> +
> +static bool pci_endpoint_test_bars_write_bar(struct pci_endpoint_test *test,
> +					     enum pci_barno barno)
> +{
> +	struct pci_dev *pdev = test->pdev;
> +	int j, size;
> +
> +	size = pci_resource_len(pdev, barno);
> +
> +	if (barno == test->test_reg_bar)
> +		size = 0x4;
> +
> +	for (j = 0; j < size; j += 4)
> +		writel_relaxed(bar_test_pattern_with_offset(barno, j),
> +			       test->bar[barno] + j);
> +
> +	return true;
> +}
> +
> +static bool pci_endpoint_test_bars_read_bar(struct pci_endpoint_test *test,
> +					    enum pci_barno barno)
> +{
> +	struct pci_dev *pdev = test->pdev;
> +	struct device *dev = &pdev->dev;
> +	int j, size;
> +	u32 val;
> +
> +	size = pci_resource_len(pdev, barno);
> +
> +	if (barno == test->test_reg_bar)
> +		size = 0x4;
> +
> +	for (j = 0; j < size; j += 4) {
> +		u32 expected = bar_test_pattern_with_offset(barno, j);
> +
> +		val = readl_relaxed(test->bar[barno] + j);
> +		if (val != expected) {
> +			dev_err(dev,
> +				"BAR%d incorrect data at offset: %#x, got: %#x expected: %#x\n",
> +				barno, j, val, expected);
> +			return false;
> +		}
> +	}
> +
> +	return true;
> +}
> +
> +static bool pci_endpoint_test_bars(struct pci_endpoint_test *test)
> +{
> +	enum pci_barno bar;
> +	bool ret;
> +
> +	/* Write all BARs in order (without reading). */
> +	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
> +		if (test->bar[bar])
> +			pci_endpoint_test_bars_write_bar(test, bar);
> +
> +	/*
> +	 * Read all BARs in order (without writing).
> +	 * If there is an address translation issue on the EP, writing one BAR
> +	 * might have overwritten another BAR. Ensure that this is not the case.
> +	 * (Reading back the BAR directly after writing can not detect this.)
> +	 */
> +	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
> +		if (test->bar[bar]) {
> +			ret = pci_endpoint_test_bars_read_bar(test, bar);
> +			if (!ret)
> +				return ret;
> +		}
> +	}
> +
> +	return true;
> +}
> +
>  static bool pci_endpoint_test_intx_irq(struct pci_endpoint_test *test)
>  {
>  	u32 val;
> @@ -768,6 +853,9 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
>  			goto ret;
>  		ret = pci_endpoint_test_bar(test, bar);
>  		break;
> +	case PCITEST_BARS:
> +		ret = pci_endpoint_test_bars(test);
> +		break;
>  	case PCITEST_INTX_IRQ:
>  		ret = pci_endpoint_test_intx_irq(test);
>  		break;
> diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
> index 94b46b043b536..acd261f498666 100644
> --- a/include/uapi/linux/pcitest.h
> +++ b/include/uapi/linux/pcitest.h
> @@ -20,6 +20,7 @@
>  #define PCITEST_MSIX		_IOW('P', 0x7, int)
>  #define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
>  #define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
> +#define PCITEST_BARS		_IO('P', 0xa)
>  #define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
>  
>  #define PCITEST_FLAGS_USE_DMA	0x00000001
> diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
> index 470258009ddc2..2ce56ea56202c 100644
> --- a/tools/pci/pcitest.c
> +++ b/tools/pci/pcitest.c
> @@ -22,6 +22,7 @@ static char *irq[] = { "LEGACY", "MSI", "MSI-X" };
>  struct pci_test {
>  	char		*device;
>  	char		barnum;
> +	bool		consecutive_bar_test;
>  	bool		legacyirq;
>  	unsigned int	msinum;
>  	unsigned int	msixnum;
> @@ -57,6 +58,15 @@ static int run_test(struct pci_test *test)
>  			fprintf(stdout, "%s\n", result[ret]);
>  	}
>  
> +	if (test->consecutive_bar_test) {
> +		ret = ioctl(fd, PCITEST_BARS);
> +		fprintf(stdout, "Consecutive BAR test:\t\t");
> +		if (ret < 0)
> +			fprintf(stdout, "TEST FAILED\n");
> +		else
> +			fprintf(stdout, "%s\n", result[ret]);
> +	}
> +
>  	if (test->set_irqtype) {
>  		ret = ioctl(fd, PCITEST_SET_IRQTYPE, test->irqtype);
>  		fprintf(stdout, "SET IRQ TYPE TO %s:\t\t", irq[test->irqtype]);
> @@ -172,7 +182,7 @@ int main(int argc, char **argv)
>  	/* set default endpoint device */
>  	test->device = "/dev/pci-endpoint-test.0";
>  
> -	while ((c = getopt(argc, argv, "D:b:m:x:i:deIlhrwcs:")) != EOF)
> +	while ((c = getopt(argc, argv, "D:b:Cm:x:i:deIlhrwcs:")) != EOF)
>  	switch (c) {
>  	case 'D':
>  		test->device = optarg;
> @@ -182,6 +192,9 @@ int main(int argc, char **argv)
>  		if (test->barnum < 0 || test->barnum > 5)
>  			goto usage;
>  		continue;
> +	case 'C':
> +		test->consecutive_bar_test = true;
> +		continue;
>  	case 'l':
>  		test->legacyirq = true;
>  		continue;
> @@ -230,6 +243,7 @@ int main(int argc, char **argv)
>  			"Options:\n"
>  			"\t-D <dev>		PCI endpoint test device {default: /dev/pci-endpoint-test.0}\n"
>  			"\t-b <bar num>		BAR test (bar number between 0..5)\n"
> +			"\t-C			Consecutive BAR test\n"
>  			"\t-m <msi num>		MSI test (msi number between 1..32)\n"
>  			"\t-x <msix num>	\tMSI-X test (msix number between 1..2048)\n"
>  			"\t-i <irq type>	\tSet IRQ type (0 - Legacy, 1 - MSI, 2 - MSI-X)\n"
> diff --git a/tools/pci/pcitest.sh b/tools/pci/pcitest.sh
> index 75ed48ff29900..770f4d6df34b6 100644
> --- a/tools/pci/pcitest.sh
> +++ b/tools/pci/pcitest.sh
> @@ -11,6 +11,7 @@ do
>  	pcitest -b $bar
>  	bar=`expr $bar + 1`
>  done
> +pcitest -C
>  echo
>  
>  echo "Interrupt tests"
> -- 
> 2.47.0
> 

-- 
மணிவண்ணன் சதாசிவம்

