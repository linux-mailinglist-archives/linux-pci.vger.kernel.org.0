Return-Path: <linux-pci+bounces-20397-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B151A1D252
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 09:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 034661658B3
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 08:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FBC1FC0ED;
	Mon, 27 Jan 2025 08:26:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF48183CB0;
	Mon, 27 Jan 2025 08:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737966417; cv=none; b=j1EjZro4hHOuKuhKOgYRhr3z7PIDn0wmEOgL8dzMfEw8RotaZlsgQT+8tQ5wVIlbPtfDCJVe6HnJNXMzWhb2n9fubu/FZNfGBTZs37zlxwcpJo7UjWrfNgsQZCb/jfU3o+hw5gx6/s5xRtA5nmnaJ7VBshdttx2b9FCq8WH+Asg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737966417; c=relaxed/simple;
	bh=H0/Ezlx02x4YqZXtnWLu8vBQIVRh2TGu1v9oSd8ge7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A9KAftRl2wDABg0S18+O9fU7Kvdpx5TTrW07cTCyZbJv0DtdmnYNSC7PR0uTZFfq1lxp3PBLn/aFp2Ixsbel1bqvO3V26txvQdo0MUlGN/xSjEo+eFflacBk2v502Fj5GcF4+8dLK2v1w78BAgS8ROzau4WozJ9lv6XkdRxA874=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5aeeed.dynamic.kabel-deutschland.de [95.90.238.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id A397861E64869;
	Mon, 27 Jan 2025 09:26:31 +0100 (CET)
Message-ID: <4dbe15ea-eb68-4096-b900-e30c3d114735@molgen.mpg.de>
Date: Mon, 27 Jan 2025 09:26:29 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Bluetooth: btintel_pcie: Support suspend-resume
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Cc: linux-bluetooth@vger.kernel.org, linux-pci@vger.kernel.org,
 bhelgaas@google.com, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, Kiran K <kiran.k@intel.com>
References: <20250127124908.1510559-1-chandrashekar.devegowda@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250127124908.1510559-1-chandrashekar.devegowda@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Chandrashekar,


Thank you for your patch. Some more minor things.


Am 27.01.25 um 13:49 schrieb Chandrashekar Devegowda:
> From: chandrashekar Devegowda <chandrashekar.devegowda@intel.com>

Please capatilize the first name.

> This patch contains the changes in driver for vendor specific handshake
> during enter of D3 and D0 exit.

Maybe state the problem at the very beginning, and say that all Intel 
Bluetooth devices do not enter D0.

> Command to test host initiated wakeup after 60 seconds
>      sudo rtcwake -m mem -s 60
> 
> logs from testing:
>      Bluetooth: hci0: BT device resumed to D0 in 1016 usecs

On what device did you test this? Were you able to measure a power 
consumption reduction?

I am also asking this, thinking that recent Intel devices only support 
ACPI S0ix and not ACPI S3.

> Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
> changes in v4:
>      - Moved document and section details from the commit message as comment in code.
> 
> changes in v3:
>      - Corrected the typo's
>      - Updated the CC list as suggested.
>      - Corrected the format specifiers in the logs.
> 
> changes in v2:
>      - Updated the commit message with test steps and logs.
>      - Added logs to include the timeout message.
>      - Fixed a potential race condition during suspend and resume.
> 
>   drivers/bluetooth/btintel_pcie.c | 66 ++++++++++++++++++++++++++++++++
>   drivers/bluetooth/btintel_pcie.h |  4 ++
>   2 files changed, 70 insertions(+)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index 63eca52c0e0b..4627544a2a52 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -274,6 +274,12 @@ static int btintel_pcie_reset_bt(struct btintel_pcie_data *data)
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
> @@ -298,6 +304,8 @@ static int btintel_pcie_enable_bt(struct btintel_pcie_data *data)
>   	 */
>   	data->boot_stage_cache = 0x0;
>   
> +	btintel_pcie_set_persistence_mode(data);
> +
>   	/* Set MAC_INIT bit to start primary bootloader */
>   	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
>   	reg &= ~(BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_INIT |
> @@ -1649,11 +1657,69 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
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
> +	data->gp0_received = false;
> +	/* The implementation is as per the Intel SAS document:
> +	 * BT Platform Power Management SAS - IOSF and the specific sections are
> +	 * 3.1 D0Exit (D3 Entry) Flow.
> +	 */
> +	btintel_pcie_wr_sleep_cntrl(data, BTINTEL_PCIE_STATE_D3_HOT);
> +	err = wait_event_timeout(data->gp0_wait_q, data->gp0_received,
> +				 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
> +	if (!err) {
> +		bt_dev_err(data->hdev, "failed to receive gp0 interrupt for suspend in %d msecs",
> +			   BTINTEL_DEFAULT_INTR_TIMEOUT_MS);
> +		return -EBUSY;
> +	}
> +	return 0;
> +}
> +
> +static int btintel_pcie_resume(struct device *dev)
> +{
> +	struct btintel_pcie_data *data;
> +	struct  pci_dev *pdev = to_pci_dev(dev);
> +	ktime_t calltime, delta, rettime;
> +	unsigned long long duration;
> +	int err;
> +
> +	data = pci_get_drvdata(pdev);
> +	data->gp0_received = false;
> +	/* The implementation is as per the Intel SAS document:
> +	 * BT Platform Power Management SAS - IOSF and the specific sections are
> +	 * 3.2 D0Entry (D3 Exit) Flow

Missing space in D0 Entry.

> +	 */
> +	calltime = ktime_get();
> +	btintel_pcie_wr_sleep_cntrl(data, BTINTEL_PCIE_STATE_D0);
> +	err = wait_event_timeout(data->gp0_wait_q, data->gp0_received,
> +				 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
> +	if (!err) {
> +		bt_dev_err(data->hdev, "failed to receive gp0 interrupt for resume in %d msecs",
> +			   BTINTEL_DEFAULT_INTR_TIMEOUT_MS);
> +		return -EBUSY;
> +	}
> +	rettime = ktime_get();
> +	delta = ktime_sub(rettime, calltime);
> +	duration = (unsigned long long)ktime_to_ns(delta) >> 10;
> +	bt_dev_info(data->hdev, "BT device resumed to D0 in %llu usecs", duration);

Maybe also add *from D3*.

> +
> +	return 0;
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

