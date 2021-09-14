Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D36440B93F
	for <lists+linux-pci@lfdr.de>; Tue, 14 Sep 2021 22:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbhINU2Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 16:28:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232909AbhINU2P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Sep 2021 16:28:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F143161184;
        Tue, 14 Sep 2021 20:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631651218;
        bh=EhsjsWUrc5W25yzCmZ51JQIoYm6bJpCvwMElSawPp4I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Bu8ZUKKgBIQAL39iFXQxUjoBkFckt9k8DXGZ/YkTL7TXVB/K6XjvjglSaVBkUd0ov
         ZI/gWYCzrUpQPiKr/tlrbEFRyqJ9QyOaxJPtwnETDS+6NAIOaHJSMppxLH2wEgdimd
         Vb7XWESSE7LG4uBjnsM8o5EhJv38k+xFAP9bOUyxoUYi4rTq04uYje4WgTLN8rXqdp
         GV2Ddh4YxlJaEwfcxrYLh0VqDOnonLTwU9HKt+NK+XOjq1abjJmngqS4DDdZCWqCRV
         t+FUBFPi12LeOLL3MYmLs+LUWqCvax5ui3DojR1G0HnWO+t3KWRxTM7exFLkeHESGc
         IUXK1vPv2TXWA==
Date:   Tue, 14 Sep 2021 15:26:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: aardvark: Implement re-issuing config requests on
 CRS response
Message-ID: <20210914202656.GA1452540@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210823120214.24837-1-pali@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 23, 2021 at 02:02:14PM +0200, Pali Rohár wrote:
> Commit 43f5c77bcbd2 ("PCI: aardvark: Fix reporting CRS value") fixed
> handling of CRS response and when CRSSVE flag was not enabled it marked CRS
> response as failed transaction (due to simplicity).
> 
> But pci-aardvark.c driver is already waiting up to the PIO_RETRY_CNT count
> for PIO config response and implementation of re-issuing config requests
> according to PCIe base specification is therefore simple.

I think the spec is confusingly worded.  It says (PCIe r5.0, sec
2.3.2) that when handling a Completion with CRS status for a config
request (paraphrasing slightly),

  If CRS Software Visibility is enabled, for config reads of Vendor
  ID, the Root Complex returns 0x0001 for Vendor ID.

  Otherwise ... the Root Complex must re-issue the Configuration
  Request as a new Request.

BUT:

  A Root Complex implementation may choose to limit the number of
  Configuration Request/ CRS Completion Status loops before
  determining that something is wrong with the target of the Request
  and taking appropriate action, e.g., complete the Request to the
  host as a failed transaction.

So I think zero is a perfectly valid number of retries, and I'm pretty
sure there are RCs that never retry.

Is there a benefit to doing retry like this in the driver?  Can we not
simply rely on retries at a higher level?

> This change implements re-issuing of config requests when response is CRS.
> And to prevent infinite loop set upper bound to around PIO_RETRY_CNT value,
> after which is transaction marked as failed and 0xFFFFFFFF is returned like
> before.
> 
> Implementation is done by returning appropriate error codes from function
> advk_pcie_check_pio_status(). On CRS is returned -EAGAIN and caller then
> reissue transaction up to the PIO_RETRY_CNT count. As advk_pcie_wait_pio()
> function waits some cycles, return number of these cycles and add them to
> the retry count. So the total time for config request would be only linear
> O(PIO_RETRY_CNT) and not quadratic O(PIO_RETRY_CNT^2) in the worst case.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Fixes: 43f5c77bcbd2 ("PCI: aardvark: Fix reporting CRS value")
> ---
>  drivers/pci/controller/pci-aardvark.c | 36 ++++++++++++++++++++++-----
>  1 file changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index abc93225ba20..99f244190eae 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -470,6 +470,7 @@ static int advk_pcie_check_pio_status(struct advk_pcie *pcie, bool allow_crs, u3
>  	u32 reg;
>  	unsigned int status;
>  	char *strcomp_status, *str_posted;
> +	int ret;
>  
>  	reg = advk_readl(pcie, PIO_STAT);
>  	status = (reg & PIO_COMPLETION_STATUS_MASK) >>
> @@ -494,6 +495,7 @@ static int advk_pcie_check_pio_status(struct advk_pcie *pcie, bool allow_crs, u3
>  	case PIO_COMPLETION_STATUS_OK:
>  		if (reg & PIO_ERR_STATUS) {
>  			strcomp_status = "COMP_ERR";
> +			ret = -EFAULT;
>  			break;
>  		}
>  		/* Get the read result */
> @@ -501,9 +503,11 @@ static int advk_pcie_check_pio_status(struct advk_pcie *pcie, bool allow_crs, u3
>  			*val = advk_readl(pcie, PIO_RD_DATA);
>  		/* No error */
>  		strcomp_status = NULL;
> +		ret = 0;
>  		break;
>  	case PIO_COMPLETION_STATUS_UR:
>  		strcomp_status = "UR";
> +		ret = -EOPNOTSUPP;
>  		break;
>  	case PIO_COMPLETION_STATUS_CRS:
>  		if (allow_crs && val) {
> @@ -521,6 +525,7 @@ static int advk_pcie_check_pio_status(struct advk_pcie *pcie, bool allow_crs, u3
>  			 */
>  			*val = CFG_RD_CRS_VAL;
>  			strcomp_status = NULL;
> +			ret = 0;
>  			break;
>  		}
>  		/* PCIe r4.0, sec 2.3.2, says:
> @@ -536,21 +541,24 @@ static int advk_pcie_check_pio_status(struct advk_pcie *pcie, bool allow_crs, u3
>  		 * Request and taking appropriate action, e.g., complete the
>  		 * Request to the host as a failed transaction.
>  		 *
> -		 * To simplify implementation do not re-issue the Configuration
> -		 * Request and complete the Request as a failed transaction.
> +		 * So return -EAGAIN and caller (pci-aardvark.c driver) will
> +		 * re-issue request again up to the PIO_RETRY_CNT retries.
>  		 */
>  		strcomp_status = "CRS";
> +		ret = -EAGAIN;
>  		break;
>  	case PIO_COMPLETION_STATUS_CA:
>  		strcomp_status = "CA";
> +		ret = -ECANCELED;
>  		break;
>  	default:
>  		strcomp_status = "Unknown";
> +		ret = -EINVAL;
>  		break;
>  	}
>  
>  	if (!strcomp_status)
> -		return 0;
> +		return ret;
>  
>  	if (reg & PIO_NON_POSTED_REQ)
>  		str_posted = "Non-posted";
> @@ -560,7 +568,7 @@ static int advk_pcie_check_pio_status(struct advk_pcie *pcie, bool allow_crs, u3
>  	dev_err(dev, "%s PIO Response Status: %s, %#x @ %#x\n",
>  		str_posted, strcomp_status, reg, advk_readl(pcie, PIO_ADDR_LS));
>  
> -	return -EFAULT;
> +	return ret;
>  }
>  
>  static int advk_pcie_wait_pio(struct advk_pcie *pcie)
> @@ -568,13 +576,13 @@ static int advk_pcie_wait_pio(struct advk_pcie *pcie)
>  	struct device *dev = &pcie->pdev->dev;
>  	int i;
>  
> -	for (i = 0; i < PIO_RETRY_CNT; i++) {
> +	for (i = 1; i <= PIO_RETRY_CNT; i++) {
>  		u32 start, isr;
>  
>  		start = advk_readl(pcie, PIO_START);
>  		isr = advk_readl(pcie, PIO_ISR);
>  		if (!start && isr)
> -			return 0;
> +			return i;
>  		udelay(PIO_RETRY_DELAY);
>  	}
>  
> @@ -764,6 +772,7 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
>  			     int where, int size, u32 *val)
>  {
>  	struct advk_pcie *pcie = bus->sysdata;
> +	int retry_count;
>  	bool allow_crs;
>  	u32 reg;
>  	int ret;
> @@ -816,6 +825,9 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
>  	/* Program the data strobe */
>  	advk_writel(pcie, 0xf, PIO_WR_DATA_STRB);
>  
> +	retry_count = 0;
> +
> +retry:
>  	/* Clear PIO DONE ISR and start the transfer */
>  	advk_writel(pcie, 1, PIO_ISR);
>  	advk_writel(pcie, 1, PIO_START);
> @@ -834,8 +846,12 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
>  		return PCIBIOS_SET_FAILED;
>  	}
>  
> +	retry_count += ret;
> +
>  	/* Check PIO status and get the read result */
>  	ret = advk_pcie_check_pio_status(pcie, allow_crs, val);
> +	if (ret == -EAGAIN && retry_count < PIO_RETRY_CNT)
> +		goto retry;
>  	if (ret < 0) {
>  		*val = 0xffffffff;
>  		return PCIBIOS_SET_FAILED;
> @@ -855,6 +871,7 @@ static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
>  	struct advk_pcie *pcie = bus->sysdata;
>  	u32 reg;
>  	u32 data_strobe = 0x0;
> +	int retry_count;
>  	int offset;
>  	int ret;
>  
> @@ -896,6 +913,9 @@ static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
>  	/* Program the data strobe */
>  	advk_writel(pcie, data_strobe, PIO_WR_DATA_STRB);
>  
> +	retry_count = 0;
> +
> +retry:
>  	/* Clear PIO DONE ISR and start the transfer */
>  	advk_writel(pcie, 1, PIO_ISR);
>  	advk_writel(pcie, 1, PIO_START);
> @@ -904,7 +924,11 @@ static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
>  	if (ret < 0)
>  		return PCIBIOS_SET_FAILED;
>  
> +	retry_count += ret;
> +
>  	ret = advk_pcie_check_pio_status(pcie, false, NULL);
> +	if (ret == -EAGAIN && retry_count < PIO_RETRY_CNT)
> +		goto retry;
>  	if (ret < 0)
>  		return PCIBIOS_SET_FAILED;
>  
> -- 
> 2.20.1
> 
