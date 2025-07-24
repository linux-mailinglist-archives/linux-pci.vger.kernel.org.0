Return-Path: <linux-pci+bounces-32868-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA51B10074
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 08:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C49A51618D3
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 06:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C38E1A2396;
	Thu, 24 Jul 2025 06:18:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CFA204592;
	Thu, 24 Jul 2025 06:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753337883; cv=none; b=r1pTzR5FlWmrX3ivUQTf3Rl29Xn0YROotI+EsTPOoXf0p41FsT6luoupK9HeRgmWEWI+WWOmL5nZNvZqb63Vhl5XAR8d74CXN6aUTB0OIt7RFPybK/MeviL2C6lr1eQlpyExJU/kCFsB03pYzJS84wrq9Qwq8RByN4Z6l/eDbOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753337883; c=relaxed/simple;
	bh=HW22suxYwW1XYKqwuKLqzZPfVaa5+jy4K+9JpWivrqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HlSyeeaNCCh39bHOo2r+niRWJOCUm7jaVu0gEd6dd0na5UJ/NrQa+QUlvVLH9yL68Qe7kRJFnOtCqOxIn8roysC4MGXcJlWxOSUompYBSXJs7JRtUt3YFtijRmhwXjQ468JF580kUh0/U72IFFZ/TSmCBCkGkri52vY+kX5jMpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af79a.dynamic.kabel-deutschland.de [95.90.247.154])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id E4AB761E647A8;
	Thu, 24 Jul 2025 08:17:43 +0200 (CEST)
Message-ID: <5323f487-0060-4396-b08e-b68a18f1893d@molgen.mpg.de>
Date: Thu, 24 Jul 2025 08:17:43 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] Bluetooth: btintel_pcie: Add support for _suspend() /
 _resume()
To: Kiran K <kiran.k@intel.com>,
 Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, bhelgaas@google.com,
 linux-pci@vger.kernel.org
References: <20250723135715.1302241-1-kiran.k@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250723135715.1302241-1-kiran.k@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Kiran, dear Chandrashekar,


Thank you for your patch.

Am 23.07.25 um 15:57 schrieb Kiran K:
> From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
> 
> This patch implements _suspend() and _resume() functions for the
> Bluetooth controller. When the system enters a suspended state, the
> driver notifies the controller to perform necessary housekeeping tasks
> by writing to the sleep control register and waits for an alive
> interrupt. The firmware raises the alive interrupt when it has
> transitioned to the D3 state. The same flow occurs when the system
> resumes.
> 
> Command to test host initiated wakeup after 60 seconds
> sudo rtcwake -m mem -s 60
> 
> dmesg log (tested on Whale Peak2 on Panther Lake platform)
> On system suspend:
> [  516.418316] Bluetooth: hci0: device entered into d3 state from d0 in 81 us
> 
> On system resume:
> [  542.174128] Bluetooth: hci0: device entered into d0 state from d3 in 357 us

Just to avoid confusion, is the timestamp correct, as this is only a 26 
s difference and your command says 60 s. (I am only aware of inaccurate 
timestamps using human-readable format (`dmesg -T`).)

> Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
> changes in v5:
>       - Address review comments

This should be more detailed, if code was changed.

> changes in v4:
>       - Moved document and section details from the commit message as comment in code.
> 
> changes in v3:
>       - Corrected the typo's
>       - Updated the CC list as suggested.
>       - Corrected the format specifiers in the logs.
> 
> changes in v2:
>       - Updated the commit message with test steps and logs.
>       - Added logs to include the timeout message.
>       - Fixed a potential race condition during suspend and resume.
> 
>   drivers/bluetooth/btintel_pcie.c | 102 +++++++++++++++++++++++++++++++
>   drivers/bluetooth/btintel_pcie.h |   4 ++
>   2 files changed, 106 insertions(+)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index 6e7bbbd35279..a96975a55cbe 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -540,6 +540,12 @@ static int btintel_pcie_reset_bt(struct btintel_pcie_data *data)
>   	return reg == 0 ? 0 : -ENODEV;
>   }
>   
> +static void btintel_pcie_set_persistence_mode(struct btintel_pcie_data *data)
> +{
> +	btintel_pcie_set_reg_bits(data, BTINTEL_PCIE_CSR_HW_BOOT_CONFIG,
> +				  BTINTEL_PCIE_CSR_HW_BOOT_CONFIG_KEEP_ON);
> +}
> +
>   static void btintel_pcie_mac_init(struct btintel_pcie_data *data)
>   {
>   	u32 reg;
> @@ -829,6 +835,8 @@ static int btintel_pcie_enable_bt(struct btintel_pcie_data *data)
>   	 */
>   	data->boot_stage_cache = 0x0;
>   
> +	btintel_pcie_set_persistence_mode(data);
> +

This hunk is not described in the commit message.

>   	/* Set MAC_INIT bit to start primary bootloader */
>   	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
>   	reg &= ~(BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_INIT |
> @@ -2573,11 +2581,105 @@ static void btintel_pcie_coredump(struct device *dev)
>   }
>   #endif
>   
> +#ifdef CONFIG_PM
> +static int btintel_pcie_suspend_late(struct device *dev, pm_message_t mesg)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct btintel_pcie_data *data;
> +	ktime_t start;
> +	u32 dxstate;
> +	s64 delta;

Append the unit to the name? `delta_us`?

> +	int err;
> +
> +	data = pci_get_drvdata(pdev);
> +
> +	if (mesg.event == PM_EVENT_SUSPEND)
> +		dxstate = BTINTEL_PCIE_STATE_D3_HOT;
> +	else
> +		dxstate = BTINTEL_PCIE_STATE_D3_COLD;

I’d use the ternary operator.

> +
> +	data->gp0_received = false;
> +
> +	start = ktime_get();
> +
> +	/* Refer: 6.4.11.7 -> Platform power management */
> +	btintel_pcie_wr_sleep_cntrl(data, dxstate);
> +	err = wait_event_timeout(data->gp0_wait_q, data->gp0_received,
> +				 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
> +	delta = ktime_to_ns(ktime_get() - start) / 1000;

Move it below right before `bt_dev_info`?

> +
> +	if (err == 0) {
> +		bt_dev_err(data->hdev, "Timeout (%u ms) on alive interrupt for D3 entry",
> +				BTINTEL_DEFAULT_INTR_TIMEOUT_MS);
> +		return -EBUSY;
> +	}
> +	bt_dev_info(data->hdev, "device entered into d3 state from d0 in %lld us",
> +		    delta);
> +	return 0;
> +}
> +
> +static int btintel_pcie_suspend(struct device *dev)
> +{
> +	return btintel_pcie_suspend_late(dev, PMSG_SUSPEND);
> +}
> +
> +static int btintel_pcie_hibernate(struct device *dev)
> +{
> +	return btintel_pcie_suspend_late(dev, PMSG_HIBERNATE);
> +}
> +
> +static int btintel_pcie_freeze(struct device *dev)
> +{
> +	return btintel_pcie_suspend_late(dev, PMSG_FREEZE);
> +}
> +
> +static int btintel_pcie_resume(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct btintel_pcie_data *data;
> +	ktime_t start;
> +	int err;
> +	s64 delta;
> +
> +	data = pci_get_drvdata(pdev);
> +	data->gp0_received = false;
> +
> +	start = ktime_get();
> +
> +	/* Refer: 6.4.11.7 -> Platform power management */
> +	btintel_pcie_wr_sleep_cntrl(data, BTINTEL_PCIE_STATE_D0);
> +	err = wait_event_timeout(data->gp0_wait_q, data->gp0_received,
> +				 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
> +	delta = ktime_to_ns(ktime_get() - start) / 1000;
> +
> +	if (err == 0) {
> +		bt_dev_err(data->hdev, "Timeout (%u ms) on alive interrupt for D0 entry",
> +				BTINTEL_DEFAULT_INTR_TIMEOUT_MS);
> +		return -EBUSY;
> +	}
> +	bt_dev_info(data->hdev, "device entered into d0 state from d3 in %lld us",
> +		    delta);
> +	return 0;
> +}
> +
> +const struct dev_pm_ops btintel_pcie_pm_ops = {
> +	.suspend = btintel_pcie_suspend,
> +	.resume = btintel_pcie_resume,
> +	.freeze = btintel_pcie_freeze,
> +	.thaw = btintel_pcie_resume,
> +	.poweroff = btintel_pcie_hibernate,
> +	.restore = btintel_pcie_resume,
> +};
> +#define BTINTELPCIE_PM_OPS	(&btintel_pcie_pm_ops)
> +#else
> +#define BTINTELPCIE_PM_OPS	NULL
> +#endif
>   static struct pci_driver btintel_pcie_driver = {
>   	.name = KBUILD_MODNAME,
>   	.id_table = btintel_pcie_table,
>   	.probe = btintel_pcie_probe,
>   	.remove = btintel_pcie_remove,
> +	.driver.pm = BTINTELPCIE_PM_OPS,
>   #ifdef CONFIG_DEV_COREDUMP
>   	.driver.coredump = btintel_pcie_coredump
>   #endif
> diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
> index 0fa876c5b954..5bc69004b692 100644
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
> @@ -55,6 +56,9 @@
>   #define BTINTEL_PCIE_CSR_BOOT_STAGE_ALIVE		(BIT(23))
>   #define BTINTEL_PCIE_CSR_BOOT_STAGE_D3_STATE_READY	(BIT(24))
>   
> +/* CSR HW BOOT CONFIG Register */
> +#define BTINTEL_PCIE_CSR_HW_BOOT_CONFIG_KEEP_ON		(BIT(31))
> +
>   /* Registers for MSI-X */
>   #define BTINTEL_PCIE_CSR_MSIX_BASE		(0x2000)
>   #define BTINTEL_PCIE_CSR_MSIX_FH_INT_CAUSES	(BTINTEL_PCIE_CSR_MSIX_BASE + 0x0800)


Kind regards,

Paul

