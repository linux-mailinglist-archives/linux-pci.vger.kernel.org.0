Return-Path: <linux-pci+bounces-31234-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39895AF1068
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 11:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5739B521BDF
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 09:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FBD24A066;
	Wed,  2 Jul 2025 09:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="aA8FqKUS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C7F248894
	for <linux-pci@vger.kernel.org>; Wed,  2 Jul 2025 09:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449467; cv=none; b=h0eyTucuvquFSHNCEWWVdI69E5JDsR56GexjXGd83zda60r6lQtvQ3gZGVq2fSkCVSwhGZMlT57/ADzz6vt5YooUJ+gcwpKYt07hTSdX2y7Z1tlkBvRn6J0E/B0fWN2OvKWwrhth0+/RoRYPGPKXIGU6vYxAAbfryVRGERt9Pt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449467; c=relaxed/simple;
	bh=izXeqBWJreZrGbZ23Z5+1favDNA2YVc9qT43FUNfPuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XgzmhyQnAURRQreWsis+tT7t/g/hzLls/sDOec2PzUhEp40hY1XGnbyHN/CDLc7yJr3o1Ms+67X0vsGL9xjJOZiaJ6osXlcHaEj8qQXlFBBiV7xowrtBwrQ9eS9h+wXT1R68oYwNgcsIk9+b4FZGR6mzRoj1JCEpeUVsT0T67JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=aA8FqKUS; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [10.172.195.16] (1.general.hwang4.uk.vpn [10.172.195.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 898963F702;
	Wed,  2 Jul 2025 09:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751449456;
	bh=SmpTqt0VQnUcXJEfM6K6r7Fzscg49AL9rrHWakjR7U0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=aA8FqKUSaRBH4FFwCH/lv1e8E5Y9W0eSktv1AtiRGVutquJmMwVocc1y89zEkT/RP
	 mb4Tl5ve6oU1klq3CLsM5QaZOVWoPF6pNOnMzs8nwGwSspAIdVyxQZtvH/Ik8p1lCK
	 8PicpCo4WSMJHF+VqZPw45SlAbzhm5CsUYRl+ZtAfsuj3WXHmYuM1rqrfYPeb0Cmor
	 E63B5zMTaqnEFBUhIT5RhJfjn9JbQeP7knq/+i6Kg1rT0LwEoUsRIYMnQGBNRS1HVL
	 AuXi4Vx42mHJq7GaOl54Stne1eYy5kPfLcUOSlFWba8Dn+YFQAj0pM/YNUwYGPzIiT
	 CFazge5LXHOKg==
Message-ID: <13f6c7df-9fd8-4ef4-b900-9a5173c5967f@canonical.com>
Date: Wed, 2 Jul 2025 17:43:58 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Disable RRS polling for Intel SSDPE2KX020T8 nvme
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
 raphael.norwitz@nutanix.com, alay.shah@nutanix.com,
 suresh.gumpula@nutanix.com, ilpo.jarvinen@linux.intel.com,
 Nirmal Patel <nirmal.patel@linux.intel.com>,
 Jonathan Derrick <jonathan.derrick@linux.dev>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
References: <20250701232341.GA1859056@bhelgaas>
Content-Language: en-US
From: Hui Wang <hui.wang@canonical.com>
In-Reply-To: <20250701232341.GA1859056@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/2/25 07:23, Bjorn Helgaas wrote:
> On Tue, Jun 24, 2025 at 08:58:57AM +0800, Hui Wang wrote:
>> Sorry for late response, I was OOO the past week.
>>
>> This is the log after applied your patch:
>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2111521/comments/61
>>
>> Looks like the "retry" makes the nvme work.
> Thank you!  It seems like we get 0xffffffff (probably PCIe error) for
> a long time after we think the device should be able to respond with
> RRS.
>
> I always thought the spec required that after the delays, a device
> should respond with RRS if it's not ready, but now I guess I'm not
> 100% sure.  Maybe it's allowed to just do nothing, which would lead to
> the Root Port timing out and logging an Unsupported Request error.
>
> Can I trouble you to try the patch below?  I think we might have to
> start explicitly checking for that error.  That probably would require
> some setup to enable the error, check for it, and clear it.  I hacked
> in some of that here, but ultimately some of it should go elsewhere.

OK, built a testing kernel, wait for bug reporter to test it and collect 
the log.


> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e9448d55113b..c276d0a2b522 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1264,10 +1264,13 @@ void pci_resume_bus(struct pci_bus *bus)
>   
>   static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
>   {
> -	int delay = 1;
> +	int delay = 10;
>   	bool retrain = false;
>   	struct pci_dev *root, *bridge;
> +	u16 devctl, devsta;
>   
> +	pci_info(dev, "%s: VF%c %s timeout %d\n", __func__,
> +		 dev->is_virtfn ? '+' : '-', reset_type, timeout);
>   	root = pcie_find_root_port(dev);
>   
>   	if (pci_is_pcie(dev)) {
> @@ -1276,6 +1279,19 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
>   			retrain = true;
>   	}
>   
> +	if (root) {
> +		pcie_capability_read_word(root, PCI_EXP_DEVCTL, &devctl);
> +		if (!(devctl & PCI_EXP_DEVCTL_URRE))
> +			pcie_capability_write_word(root, PCI_EXP_DEVCTL,
> +					    devctl | PCI_EXP_DEVCTL_URRE);
> +		pcie_capability_read_word(root, PCI_EXP_DEVSTA, &devsta);
> +		if (devsta & PCI_EXP_DEVSTA_URD)
> +			pcie_capability_write_word(root, PCI_EXP_DEVSTA,
> +						   PCI_EXP_DEVSTA_URD);
> +		pci_info(root, "%s: DEVCTL %#06x DEVSTA %#06x\n", __func__,
> +			 devctl, devsta);
> +	}
> +
>   	/*
>   	 * The caller has already waited long enough after a reset that the
>   	 * device should respond to config requests, but it may respond
> @@ -1305,14 +1321,33 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
>   
>   		if (root && root->config_rrs_sv) {
>   			pci_read_config_dword(dev, PCI_VENDOR_ID, &id);
> -			if (!pci_bus_rrs_vendor_id(id))
> -				break;
> +
> +			if (pci_bus_rrs_vendor_id(id)) {
> +				pci_info(dev, "%s: read %#06x (RRS)\n",
> +					 __func__, id);
> +				goto retry;
> +			}
> +
> +			if (PCI_POSSIBLE_ERROR(id)) {
> +				pcie_capability_read_word(root, PCI_EXP_DEVSTA,
> +							  &devsta);
> +				if (devsta & PCI_EXP_DEVSTA_URD)
> +					pcie_capability_write_word(root,
> +							    PCI_EXP_DEVSTA,
> +							    PCI_EXP_DEVSTA_URD);
> +				pci_info(root, "%s: read %#06x DEVSTA %#06x\n",
> +					 __func__, id, devsta);
> +				goto retry;
> +			}
> +
> +			break;
>   		} else {
>   			pci_read_config_dword(dev, PCI_COMMAND, &id);
>   			if (!PCI_POSSIBLE_ERROR(id))
>   				break;
>   		}
>   
> +retry:
>   		if (delay > timeout) {
>   			pci_warn(dev, "not ready %dms after %s; giving up\n",
>   				 delay - 1, reset_type);
> @@ -1332,7 +1367,6 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
>   		}
>   
>   		msleep(delay);
> -		delay *= 2;
>   	}
>   
>   	if (delay > PCI_RESET_WAIT)
> @@ -4670,8 +4704,10 @@ static int pcie_wait_for_link_status(struct pci_dev *pdev,
>   	end_jiffies = jiffies + msecs_to_jiffies(PCIE_LINK_RETRAIN_TIMEOUT_MS);
>   	do {
>   		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
> -		if ((lnksta & lnksta_mask) == lnksta_match)
> +		if ((lnksta & lnksta_mask) == lnksta_match) {
> +			pci_info(pdev, "%s: LNKSTA %#06x\n", __func__, lnksta);
>   			return 0;
> +		}
>   		msleep(1);
>   	} while (time_before(jiffies, end_jiffies));
>   
> @@ -4760,6 +4796,8 @@ static bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active,
>   	 * Some controllers might not implement link active reporting. In this
>   	 * case, we wait for 1000 ms + any delay requested by the caller.
>   	 */
> +	pci_info(pdev, "%s: active %d delay %d link_active_reporting %d\n",
> +		 __func__, active, delay, pdev->link_active_reporting);
>   	if (!pdev->link_active_reporting) {
>   		msleep(PCIE_LINK_RETRAIN_TIMEOUT_MS + delay);
>   		return true;
> @@ -4784,6 +4822,7 @@ static bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active,
>   			return false;
>   
>   		msleep(delay);
> +		pci_info(pdev, "%s: waited %dms\n", __func__, delay);
>   		return true;
>   	}
>   
> @@ -4960,6 +4999,7 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
>   
>   	ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
>   	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
> +	pci_info(dev, "%s: PCI_BRIDGE_CTL_BUS_RESET deasserted\n", __func__);
>   }
>   
>   void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)

