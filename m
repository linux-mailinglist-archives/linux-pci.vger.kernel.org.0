Return-Path: <linux-pci+bounces-32925-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1AEB11A7A
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 11:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F125E18910A2
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 09:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6208F27055F;
	Fri, 25 Jul 2025 09:05:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9A926FA6F;
	Fri, 25 Jul 2025 09:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753434301; cv=none; b=KIBho4yCUCc7c69JHqEYGHPK3t5b6hguBfZD6IfXbnUIw1LZcS61AlV7nTJ9CrXSxE5x81kmO2nLnHFNAC9JFHKEQAbAlSCZynx+uidO8VaFgj5wefWwm8SIHUDx9Y/myeCwh5JU+rCR6kX4Wn3erV7Ex3SHmH1Xv5rFr/XxH88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753434301; c=relaxed/simple;
	bh=5JMRBMZ0/9jWtiBIdp3m1UuD+sxB3Iagp+4VI8NCJiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VyQN/ODOx06kkxQdhYv7QYdNTWIi57PY6Qsk/QhaId9NNYGnhs+ItxdwwXP0u+FjJgV2vAIq4l0f3jDv4S/nIj8X3CyOiFUdFbC/tptfPecBkTs7WbZ5Qf3RrPrkxIlBftporbxu5eIt8ThpmY+/xZlQGgjGN6eFL4pUEaWKAiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.44.251] (unknown [185.238.219.118])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id ADB5461E64841;
	Fri, 25 Jul 2025 11:04:39 +0200 (CEST)
Message-ID: <fabecd3c-e715-4ef5-bf79-72e2575ee372@molgen.mpg.de>
Date: Fri, 25 Jul 2025 11:04:35 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] Bluetooth: btintel_pcie: Add support for _suspend() /
 _resume()
To: Kiran K <kiran.k@intel.com>,
 Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, bhelgaas@google.com,
 linux-pci@vger.kernel.org
References: <20250725090133.1358775-1-kiran.k@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250725090133.1358775-1-kiran.k@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Kiran,


Thank you for sending the improved version 6.

Am 25.07.25 um 11:01 schrieb Kiran K:
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
> [Fri Jul 25 11:05:37 2025] Bluetooth: hci0: device entered into d3 state from d0 in 80 us
> 
> On system resume:
> [Fri Jul 25 11:06:36 2025] Bluetooth: hci0: device entered into d0 state from d3 in 7117 us
> 
> Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
> changes in v6:
>       - s/delta/delta_us/g
>       - s/CONFIG_PM/CONFIG_PM_SLEEP/g
>       - use pm_sleep_pr()/pm_str() to avoid #ifdefs
>       - remove the code to set persistance mode as its not relevant to this patch
> 
> changes in v5:
>       - refactor _suspend() / _resume() to set the D3HOT/D3COLD based on power
>         event
>       - remove SIMPLE_DEV_PM_OPS and define the required pm_ops callback
>         functions
> 
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
>   drivers/bluetooth/btintel_pcie.c | 90 ++++++++++++++++++++++++++++++++
>   1 file changed, 90 insertions(+)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index 6e7bbbd35279..c419521493fe 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -2573,11 +2573,101 @@ static void btintel_pcie_coredump(struct device *dev)
>   }
>   #endif
>   
> +#ifdef CONFIG_PM_SLEEP
> +static int btintel_pcie_suspend_late(struct device *dev, pm_message_t mesg)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct btintel_pcie_data *data;
> +	ktime_t start;
> +	u32 dxstate;
> +	s64 delta_us;
> +	int err;
> +
> +	data = pci_get_drvdata(pdev);
> +
> +	dxstate = (mesg.event == PM_EVENT_SUSPEND ?
> +		   BTINTEL_PCIE_STATE_D3_HOT : BTINTEL_PCIE_STATE_D3_COLD);

I believe the brackets are uncommon. You actually can leave it out, or, 
if brackets need to be used, only surround the condition.

> +
> +	data->gp0_received = false;
> +
> +	start = ktime_get();
> +
> +	/* Refer: 6.4.11.7 -> Platform power management */
> +	btintel_pcie_wr_sleep_cntrl(data, dxstate);
> +	err = wait_event_timeout(data->gp0_wait_q, data->gp0_received,
> +				 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
> +	if (err == 0) {
> +		bt_dev_err(data->hdev, "Timeout (%u ms) on alive interrupt for D3 entry",
> +				BTINTEL_DEFAULT_INTR_TIMEOUT_MS);
> +		return -EBUSY;
> +	}
> +
> +	delta_us = ktime_to_ns(ktime_get() - start) / 1000;
> +	bt_dev_info(data->hdev, "device entered into d3 state from d0 in %lld us",
> +		    delta_us);
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
> +	s64 delta_us;
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
> +	if (err == 0) {
> +		bt_dev_err(data->hdev, "Timeout (%u ms) on alive interrupt for D0 entry",
> +				BTINTEL_DEFAULT_INTR_TIMEOUT_MS);
> +		return -EBUSY;
> +	}
> +
> +	delta_us = ktime_to_ns(ktime_get() - start) / 1000;
> +	bt_dev_info(data->hdev, "device entered into d0 state from d3 in %lld us",
> +		    delta_us);
> +	return 0;
> +}
> +
> +const struct dev_pm_ops btintel_pcie_pm_ops = {
> +	.suspend = pm_sleep_ptr(btintel_pcie_suspend),
> +	.resume = pm_sleep_ptr(btintel_pcie_resume),
> +	.freeze = pm_sleep_ptr(btintel_pcie_freeze),
> +	.thaw = pm_sleep_ptr(btintel_pcie_resume),
> +	.poweroff = pm_sleep_ptr(btintel_pcie_hibernate),
> +	.restore = pm_sleep_ptr(btintel_pcie_resume),
> +};
> +#endif
> +
>   static struct pci_driver btintel_pcie_driver = {
>   	.name = KBUILD_MODNAME,
>   	.id_table = btintel_pcie_table,
>   	.probe = btintel_pcie_probe,
>   	.remove = btintel_pcie_remove,
> +	.driver.pm = pm_ptr(&btintel_pcie_pm_ops),
>   #ifdef CONFIG_DEV_COREDUMP
>   	.driver.coredump = btintel_pcie_coredump
>   #endif

With the above comment fixed, please feel free to add:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

