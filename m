Return-Path: <linux-pci+bounces-15099-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D929AC007
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 09:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55396B24452
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 07:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7959D1531F0;
	Wed, 23 Oct 2024 07:19:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60DB14B942;
	Wed, 23 Oct 2024 07:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729667951; cv=none; b=U2KQ/SHl8wu0G+A2NWuJ3CAQHxDf9IptvnoFHWIG/odCn40YrZyBS6gAJB6rSbcaU69m8vfSreObWVK9MmqTVQYdaN88zBPEjJqAwOGpiBbYOh7IG6DvdZ89WsiDKqjmdLpTweXKle760fwjshsaDO5UIFgmDpUcrhnRgn2hGi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729667951; c=relaxed/simple;
	bh=VlzBZICalXL7+uRPigHr2hG8Cd22KtoBbGOuEnObFbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Omnfzu9P9Qx6b6Qw4nG25+sUsl1ZeuMZoPiAFysvUSxqPspvBdoZ6lgqzINb3YMJEUY1B7iXwokVtKz3Iygz7AoQA/UQjRZdfbIVj389CxqRAG/NaG2Sx7FMSRdO4O5W5lKVYf64x1cXVN3DjWdubpByc3ES6Ubx1e73vBPXqNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5aeec7.dynamic.kabel-deutschland.de [95.90.238.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0349C61E5FE05;
	Wed, 23 Oct 2024 09:18:46 +0200 (CEST)
Message-ID: <e6bd065d-0b9b-4c37-958c-fc2a09ea0475@molgen.mpg.de>
Date: Wed, 23 Oct 2024 09:18:46 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Device suspend-resume support
 added
To: ChandraShekar <chandrashekar.devegowda@intel.com>,
 Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org
References: <20241023114647.1011886-1-chandrashekar.devegowda@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20241023114647.1011886-1-chandrashekar.devegowda@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[Cc: +Bjorn, +linux-pci]

Dear Chandra,


Thank you for the patch.

First something minor: Should there be a space in your name?

ChandraShekar → Chandra Shekar

`git config --global user.name "…"` can configure this for your git setup.

Also for the summary/title, it’d be great if you used a statement by 
using a verb (in imperative mood):

Add device suspend-resume support

or shorter

Support suspend-resume

Am 23.10.24 um 13:46 schrieb ChandraShekar:
> This patch contains the changes in driver to support the suspend and
> resume i.e move the controller to D3 state when the platform is entering
> into suspend and move the controller to D0 on resume.

It’d be great if you elaborated. Please start by the history, since when 
Intel Bluetooth PCIe have been there, and why until now this support was 
missing.

Then please describe, what is needed, and what documentation you used to 
implement the support.

Also, please document, how you tested this, including the log messages, 
and also the time it takes to resume.

Is it also possible to use Bluetooth as a wakeup source from suspend?

> Signed-off-by: Kiran K <kiran.k@intel.com>
> Signed-off-by: ChandraShekar <chandrashekar.devegowda@intel.com>
> ---
>   drivers/bluetooth/btintel_pcie.c | 52 ++++++++++++++++++++++++++++++++
>   drivers/bluetooth/btintel_pcie.h |  4 +++
>   2 files changed, 56 insertions(+)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index fd4a8bd056fa..f2c44b9d7328 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -273,6 +273,12 @@ static int btintel_pcie_reset_bt(struct btintel_pcie_data *data)
>   	return reg == 0 ? 0 : -ENODEV;
>   }
>   
> +static void btintel_pcie_set_persistence_mode(struct btintel_pcie_data *data)
> +{
> +	btintel_pcie_set_reg_bits(data, BTINTEL_PCIE_CSR_HW_BOOT_CONFIG,
> +				  BTINTEL_PCIE_CSR_HW_BOOT_CONFIG_KEEP_ON);
> +}
> +
>   /* This function enables BT function by setting BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_INIT bit in
>    * BTINTEL_PCIE_CSR_FUNC_CTRL_REG register and wait for MSI-X with
>    * BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0.
> @@ -297,6 +303,8 @@ static int btintel_pcie_enable_bt(struct btintel_pcie_data *data)
>   	 */
>   	data->boot_stage_cache = 0x0;
>   
> +	btintel_pcie_set_persistence_mode(data);
> +
>   	/* Set MAC_INIT bit to start primary bootloader */
>   	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
>   	reg &= ~(BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_INIT |
> @@ -1653,11 +1661,55 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
>   	pci_set_drvdata(pdev, NULL);
>   }
>   
> +static int btintel_pcie_suspend(struct device *dev)
> +{
> +	struct btintel_pcie_data *data;
> +	int err;
> +	struct  pci_dev *pdev = to_pci_dev(dev);
> +
> +	data = pci_get_drvdata(pdev);
> +	btintel_pcie_wr_sleep_cntrl(data, BTINTEL_PCIE_STATE_D3_HOT);
> +	data->gp0_received = false;
> +	err = wait_event_timeout(data->gp0_wait_q, data->gp0_received,
> +				 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
> +	if (!err) {
> +		bt_dev_err(data->hdev, "failed to receive gp0 interrupt for suspend");

Please include the timeout in the message.

> +		goto fail;
> +	}
> +	return 0;
> +fail:
> +	return -EBUSY;
> +}
> +
> +static int btintel_pcie_resume(struct device *dev)
> +{
> +	struct btintel_pcie_data *data;
> +	struct  pci_dev *pdev = to_pci_dev(dev);
> +	int err;
> +
> +	data = pci_get_drvdata(pdev);
> +	btintel_pcie_wr_sleep_cntrl(data, BTINTEL_PCIE_STATE_D0);
> +	data->gp0_received = false;
> +	err = wait_event_timeout(data->gp0_wait_q, data->gp0_received,
> +				 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
> +	if (!err) {
> +		bt_dev_err(data->hdev, "failed to receive gp0 interrupt for resume");

Ditto.

> +		goto fail;
> +	}
> +	return 0;
> +fail:
> +	return -EBUSY;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(btintel_pcie_pm_ops, btintel_pcie_suspend,
> +		btintel_pcie_resume);
> +
>   static struct pci_driver btintel_pcie_driver = {
>   	.name = KBUILD_MODNAME,
>   	.id_table = btintel_pcie_table,
>   	.probe = btintel_pcie_probe,
>   	.remove = btintel_pcie_remove,
> +	.driver.pm = &btintel_pcie_pm_ops,
>   };
>   module_pci_driver(btintel_pcie_driver);
>   
> diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
> index f9aada0543c4..38d0c8ea2b6f 100644
> --- a/drivers/bluetooth/btintel_pcie.h
> +++ b/drivers/bluetooth/btintel_pcie.h
> @@ -8,6 +8,7 @@
>   
>   /* Control and Status Register(BTINTEL_PCIE_CSR) */
>   #define BTINTEL_PCIE_CSR_BASE			(0x000)
> +#define BTINTEL_PCIE_CSR_HW_BOOT_CONFIG		(BTINTEL_PCIE_CSR_BASE + 0x000)
>   #define BTINTEL_PCIE_CSR_FUNC_CTRL_REG		(BTINTEL_PCIE_CSR_BASE + 0x024)
>   #define BTINTEL_PCIE_CSR_HW_REV_REG		(BTINTEL_PCIE_CSR_BASE + 0x028)
>   #define BTINTEL_PCIE_CSR_RF_ID_REG		(BTINTEL_PCIE_CSR_BASE + 0x09C)
> @@ -48,6 +49,9 @@
>   #define BTINTEL_PCIE_CSR_MSIX_IVAR_BASE		(BTINTEL_PCIE_CSR_MSIX_BASE + 0x0880)
>   #define BTINTEL_PCIE_CSR_MSIX_IVAR(cause)	(BTINTEL_PCIE_CSR_MSIX_IVAR_BASE + (cause))
>   
> +/* CSR HW BOOT CONFIG Register */
> +#define BTINTEL_PCIE_CSR_HW_BOOT_CONFIG_KEEP_ON		(BIT(31))
> +
>   /* Causes for the FH register interrupts */
>   enum msix_fh_int_causes {
>   	BTINTEL_PCIE_MSIX_FH_INT_CAUSES_0	= BIT(0),	/* cause 0 */


Kind regards,

Paul

