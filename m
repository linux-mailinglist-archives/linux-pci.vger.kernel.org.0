Return-Path: <linux-pci+bounces-32864-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C81B0FFCA
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 07:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182FF3AD942
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 05:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A03D1E5B71;
	Thu, 24 Jul 2025 05:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMp08ly3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF6F1863E;
	Thu, 24 Jul 2025 05:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753333609; cv=none; b=GYhBjZIFRCIDqtWmBojf0zCe+bNfsOqDdQV2aPsJqDntfxXQNpeHNDlg+EUmw8sOdFd3LJd9SATYwtNFfkrKi8sfl9Ha8kRfUYbpBYnaYqVZRL3KH2IjyDloygjlFWGpSrkXuuWuQd3aM6qNks4juWoF/D+B/v5cxGOT8Yc9zkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753333609; c=relaxed/simple;
	bh=GRwVhFUmazGl4MJJVsQKOnGpl5NNR80ueDauNjAi08M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhR5+Nco/KSTPMzYSYgxVE1kg+fS/2aUTPOTPSMYXmAvhYdT0SdoUpjByQcTVJEqIqnbkIAmlReGfDNvwYy/vqb08ccMLezfpsfAdI+TimCHi4oYdggmbdF6AhL5XanpVsUkrG81bYU06novpZkjLKOpGWKdUjVa8YC63umLSug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMp08ly3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A25C4CEED;
	Thu, 24 Jul 2025 05:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753333608;
	bh=GRwVhFUmazGl4MJJVsQKOnGpl5NNR80ueDauNjAi08M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AMp08ly3f9dRPVBCAW8VTQawgw1z43o8MdzjDywYZwDL72PgTUE/ocbU5M8BCuRUo
	 Am7bi0D93Uhn5whp1lKPTkenanJ2Yq6oTCryJ04to8vWNxVMHiovDE82P/Wd0/Kdfs
	 Ve9qq6B4XZx6uJZ+wPUKlQZRl5H3OGhATheWEf1YanGezZ3MUPSKbSPCTgDk2/wbca
	 vvPT0E6aVRtuyp8AsiZOPCevrZnNSqeHFw/rp1LZXAlz/WA94MrEYPLNovKaNfVJzx
	 PU8elW/6eo23lWZwy9oXcnJOnw2RrxcVH5Yscj18ZuZorGH08PCu/wFUlxDswfNnNu
	 t0ZzFUVkmGcjw==
Date: Thu, 24 Jul 2025 10:36:42 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com, 
	chethan.tumkur.narayan@intel.com, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Subject: Re: [PATCH v5] Bluetooth: btintel_pcie: Add support for _suspend() /
 _resume()
Message-ID: <jn33hvzv6mnhij2ihkuwrwpv2nfkypdjecvjy2flfzli3dju72@44kspi4tzalw>
References: <20250723135715.1302241-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250723135715.1302241-1-kiran.k@intel.com>

On Wed, Jul 23, 2025 at 07:27:15PM GMT, Kiran K wrote:
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
> 
> Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
> changes in v5:
>      - Address review comments
> 
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
>  drivers/bluetooth/btintel_pcie.c | 102 +++++++++++++++++++++++++++++++
>  drivers/bluetooth/btintel_pcie.h |   4 ++
>  2 files changed, 106 insertions(+)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index 6e7bbbd35279..a96975a55cbe 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -540,6 +540,12 @@ static int btintel_pcie_reset_bt(struct btintel_pcie_data *data)
>  	return reg == 0 ? 0 : -ENODEV;
>  }
>  
> +static void btintel_pcie_set_persistence_mode(struct btintel_pcie_data *data)
> +{
> +	btintel_pcie_set_reg_bits(data, BTINTEL_PCIE_CSR_HW_BOOT_CONFIG,
> +				  BTINTEL_PCIE_CSR_HW_BOOT_CONFIG_KEEP_ON);
> +}
> +
>  static void btintel_pcie_mac_init(struct btintel_pcie_data *data)
>  {
>  	u32 reg;
> @@ -829,6 +835,8 @@ static int btintel_pcie_enable_bt(struct btintel_pcie_data *data)
>  	 */
>  	data->boot_stage_cache = 0x0;
>  
> +	btintel_pcie_set_persistence_mode(data);
> +
>  	/* Set MAC_INIT bit to start primary bootloader */
>  	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
>  	reg &= ~(BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_INIT |
> @@ -2573,11 +2581,105 @@ static void btintel_pcie_coredump(struct device *dev)
>  }
>  #endif
>  
> +#ifdef CONFIG_PM
> +static int btintel_pcie_suspend_late(struct device *dev, pm_message_t mesg)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct btintel_pcie_data *data;
> +	ktime_t start;
> +	u32 dxstate;
> +	s64 delta;
> +	int err;
> +
> +	data = pci_get_drvdata(pdev);
> +
> +	if (mesg.event == PM_EVENT_SUSPEND)
> +		dxstate = BTINTEL_PCIE_STATE_D3_HOT;
> +	else
> +		dxstate = BTINTEL_PCIE_STATE_D3_COLD;
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

You should use pm_sleep_ptr() to avoid the ifdef clutter. It will ensure that
the compiler drops the function definitions when CONFIG_PM_SLEEP is not enabled.

> +};
> +#define BTINTELPCIE_PM_OPS	(&btintel_pcie_pm_ops)
> +#else
> +#define BTINTELPCIE_PM_OPS	NULL
> +#endif
>  static struct pci_driver btintel_pcie_driver = {
>  	.name = KBUILD_MODNAME,
>  	.id_table = btintel_pcie_table,
>  	.probe = btintel_pcie_probe,
>  	.remove = btintel_pcie_remove,
> +	.driver.pm = BTINTELPCIE_PM_OPS,

Here, you should use pm_ptr() for the same reason.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

