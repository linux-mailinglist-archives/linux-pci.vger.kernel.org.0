Return-Path: <linux-pci+bounces-1687-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6EC824930
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 20:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0407A286204
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 19:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2652C1A8;
	Thu,  4 Jan 2024 19:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VHPpOMv3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E912C19E;
	Thu,  4 Jan 2024 19:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704397373; x=1735933373;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BqyzbMM13Y5zOlYIwvUzYCIaGHm3b5tUQ+nNjWlVCrE=;
  b=VHPpOMv3Ueshk15WXamzSjqu+yAp+bS/KuSqGZzZ5f0b7D8xNmhMNyYb
   Cxvyll0inlCGiUQanW/0uij4t5rk8hTAyku211L0dxEHesqM93xSeVQ00
   F60XaWEWy+alzFlmjfdKD3RP/pjJp6RqvK7v7u/oz0fpLZEqIMZ/+ljFh
   +C5eZbVbNDXw7JoPXeo6xj07/N787rzk1pD6TP9341AYJCEmq0nwgdVms
   K5qIQ/sta3m8XdWFnNTgHw151JBCee+EIe9FmJtLcTm77s3U3bP8yIzQ6
   xhYeYYGrJG3F5CnL53XTJd2JGfCVM7rMswaWucDsrbHUlpeTWzoQSFc3b
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="400110189"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="400110189"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 11:42:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="22608141"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.35.85])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 11:42:50 -0800
Message-ID: <b21cded2-df3c-473f-a414-3651c2f6681a@intel.com>
Date: Thu, 4 Jan 2024 21:42:44 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: GL975x: Mask rootport's replay
 timer timeout during suspend
Content-Language: en-US
To: Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Victor Shih <victor.shih@genesyslogic.com.tw>,
 Ben Chuang <benchuanggli@gmail.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci <linux-pci@vger.kernel.org>
References: <20231221032147.434647-1-kai.heng.feng@canonical.com>
 <CAPDyKFo6SGV=Zsqmq=dO09tGNsJAURXuvXfbzLwf-4J3KUsC+w@mail.gmail.com>
 <CAAd53p7k2oBkzKv_RrNUm9rhJB5htV79sUjbdRxWHHJ46ps6HQ@mail.gmail.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAAd53p7k2oBkzKv_RrNUm9rhJB5htV79sUjbdRxWHHJ46ps6HQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/01/24 06:10, Kai-Heng Feng wrote:
> On Wed, Jan 3, 2024 at 6:53 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>> On Thu, 21 Dec 2023 at 04:23, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>>>
>>> Spamming `lspci -vv` can still observe the replay timer timeout error
>>> even after commit 015c9cbcf0ad ("mmc: sdhci-pci-gli: GL9750: Mask the
>>> replay timer timeout of AER"), albeit with a lower reproduce rate.
>>>
>>> Such AER interrupt can still prevent the system from suspending, so let
>>> root port mask and unmask replay timer timeout during suspend and
>>> resume, respectively.
>>>
>>> Cc: Victor Shih <victor.shih@genesyslogic.com.tw>
>>> Cc: Ben Chuang <benchuanggli@gmail.com>
>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>> ---
>>> v2:
>>>  - Change subject to reflect it works on GL9750 & GL9755
>>>  - Fix when aer_cap is missing
>>>
>>>  drivers/mmc/host/sdhci-pci-core.c |  2 +-
>>>  drivers/mmc/host/sdhci-pci-gli.c  | 55 +++++++++++++++++++++++++++++--
>>>  drivers/mmc/host/sdhci-pci.h      |  1 +
>>>  3 files changed, 55 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
>>> index 025b31aa712c..59ae4da72974 100644
>>> --- a/drivers/mmc/host/sdhci-pci-core.c
>>> +++ b/drivers/mmc/host/sdhci-pci-core.c
>>> @@ -68,7 +68,7 @@ static int sdhci_pci_init_wakeup(struct sdhci_pci_chip *chip)
>>>         return 0;
>>>  }
>>>
>>> -static int sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
>>> +int sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
>>>  {
>>>         int i, ret;
>>>
>>> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
>>> index 77911a57b12c..54943e9df835 100644
>>> --- a/drivers/mmc/host/sdhci-pci-gli.c
>>> +++ b/drivers/mmc/host/sdhci-pci-gli.c
>>> @@ -1429,6 +1429,55 @@ static int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
>>>         return sdhci_pci_resume_host(chip);
>>>  }
>>>
>>> +#ifdef CONFIG_PCIEAER
>>> +static void mask_replay_timer_timeout(struct pci_dev *pdev)
>>> +{
>>> +       struct pci_dev *parent = pci_upstream_bridge(pdev);
>>> +       u32 val;
>>> +
>>> +       if (!parent || !parent->aer_cap)
>>
>> Wouldn't it be more correct to use pci_aer_available(), rather than
>> just checking the aer_cap?
> 
> pci_aer_available() is more of a global check, so checking aer_cap is
> still required for the device.

It is not obvious whether aer_cap is meant to be used outside PCI
internal code.  Maybe reading the offset directly is more
appropriate?

	aer_pos = pci_find_ext_capability(root, PCI_EXT_CAP_ID_ERR);


> 
>>
>> If pci_aer_available() can be used, we wouldn't even need the stubs as
>> the is already stubs for pci_aer_available().
> 
> A helper that checks both aer_cap and  pci_aer_available() can be
> added for such purpose, but there aren't many users of that.
> 
> Kai-Heng
> 
>>
>>> +               return;
>>> +
>>> +       pci_read_config_dword(parent, parent->aer_cap + PCI_ERR_COR_MASK, &val);
>>> +       val |= PCI_ERR_COR_REP_TIMER;
>>> +       pci_write_config_dword(parent, parent->aer_cap + PCI_ERR_COR_MASK, val);
>>> +}
>>> +
>>> +static void unmask_replay_timer_timeout(struct pci_dev *pdev)
>>> +{
>>> +       struct pci_dev *parent = pci_upstream_bridge(pdev);
>>> +       u32 val;
>>> +
>>> +       if (!parent || !parent->aer_cap)
>>> +               return;
>>> +
>>> +       pci_read_config_dword(pdev, parent->aer_cap + PCI_ERR_COR_MASK, &val);
>>> +       val &= ~PCI_ERR_COR_REP_TIMER;
>>> +       pci_write_config_dword(pdev, parent->aer_cap + PCI_ERR_COR_MASK, val);
>>> +}
>>> +#else
>>> +static inline void mask_replay_timer_timeout(struct pci_dev *pdev) { }
>>> +static inline void unmask_replay_timer_timeout(struct pci_dev *pdev) {  }
>>> +#endif
>>> +
>>> +static int sdhci_pci_gl975x_suspend(struct sdhci_pci_chip *chip)
>>> +{
>>> +       mask_replay_timer_timeout(chip->pdev);
>>> +
>>> +       return sdhci_pci_suspend_host(chip);
>>> +}
>>> +
>>> +static int sdhci_pci_gl975x_resume(struct sdhci_pci_chip *chip)
>>> +{
>>> +       int ret;
>>> +
>>> +       ret = sdhci_pci_gli_resume(chip);
>>> +
>>> +       unmask_replay_timer_timeout(chip->pdev);
>>> +
>>> +       return ret;
>>> +}
>>> +
>>>  static int gl9763e_resume(struct sdhci_pci_chip *chip)
>>>  {
>>>         struct sdhci_pci_slot *slot = chip->slots[0];
>>> @@ -1547,7 +1596,8 @@ const struct sdhci_pci_fixes sdhci_gl9755 = {
>>>         .probe_slot     = gli_probe_slot_gl9755,
>>>         .ops            = &sdhci_gl9755_ops,
>>>  #ifdef CONFIG_PM_SLEEP
>>> -       .resume         = sdhci_pci_gli_resume,
>>> +       .suspend        = sdhci_pci_gl975x_suspend,
>>> +       .resume         = sdhci_pci_gl975x_resume,
>>>  #endif
>>>  };
>>>
>>> @@ -1570,7 +1620,8 @@ const struct sdhci_pci_fixes sdhci_gl9750 = {
>>>         .probe_slot     = gli_probe_slot_gl9750,
>>>         .ops            = &sdhci_gl9750_ops,
>>>  #ifdef CONFIG_PM_SLEEP
>>> -       .resume         = sdhci_pci_gli_resume,
>>> +       .suspend        = sdhci_pci_gl975x_suspend,
>>> +       .resume         = sdhci_pci_gl975x_resume,
>>>  #endif
>>>  };
>>>
>>> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
>>> index 153704f812ed..19253dce687d 100644
>>> --- a/drivers/mmc/host/sdhci-pci.h
>>> +++ b/drivers/mmc/host/sdhci-pci.h
>>> @@ -190,6 +190,7 @@ static inline void *sdhci_pci_priv(struct sdhci_pci_slot *slot)
>>>  }
>>>
>>>  #ifdef CONFIG_PM_SLEEP
>>> +int sdhci_pci_suspend_host(struct sdhci_pci_chip *chip);
>>>  int sdhci_pci_resume_host(struct sdhci_pci_chip *chip);
>>>  #endif
>>>  int sdhci_pci_enable_dma(struct sdhci_host *host);
>>
>> Kind regards
>> Uffe


