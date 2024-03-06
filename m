Return-Path: <linux-pci+bounces-4548-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4B8872FCF
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 08:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82151F24E8F
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 07:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC759DDA8;
	Wed,  6 Mar 2024 07:37:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9076517745;
	Wed,  6 Mar 2024 07:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709710620; cv=none; b=V/weEFfm3CFJBu5NNr71bUDfqzhVQFhn409Hnc2wBOdxKFEwcWXc5+KQmMJnyCgLfeKEL58AlITn8d+KpeQ9MYXZOYN1tHDG5G5YS5hz1sQ4gzioJhslOkoESWNFQZHNLDWH7u7Ok2lsseSdJ7yt7Ahn10WlVjxgheYM3BDm5tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709710620; c=relaxed/simple;
	bh=9dgdi3onNdqBCuripreHkAtGlscINxvox0JMaGq1b64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KDhQ1RpK/56EQUzsB3YEAico/CYYlpn8j1KaCxIBeW5ltwyyjb8JtNxAcA3lxtF7DaooMzIna+77LgDIMZNxgwccOppWtr8lB8XUtgs94cUiwqwqVdHkcQpo85ov2oxoXJy5dssUDJDCSDTMan7M4Tg+qexKNo1z/Xfao1pN6zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5aedd4.dynamic.kabel-deutschland.de [95.90.237.212])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9829A61E5FE01;
	Wed,  6 Mar 2024 08:36:07 +0100 (CET)
Message-ID: <2ee68ccd-4c95-4d1e-ac12-9d792b84f699@molgen.mpg.de>
Date: Wed, 6 Mar 2024 08:36:07 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 1/2] igb: simplify pci ops declaration
Content-Language: en-US
To: Heiner Kallweit <hkallweit1@gmail.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 horms@kernel.org, Alan Brady <alan.brady@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-pci@vger.kernel.org
References: <20240306025023.800029-1-jesse.brandeburg@intel.com>
 <20240306025023.800029-2-jesse.brandeburg@intel.com>
 <788f0d6b-107b-4d7b-813d-89db82a78e59@molgen.mpg.de>
 <8e2ef99f-1a3d-44b6-9b3d-c612e43a33c4@gmail.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <8e2ef99f-1a3d-44b6-9b3d-c612e43a33c4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Linux folks,


Am 06.03.24 um 07:46 schrieb Heiner Kallweit:
> On 06.03.2024 07:24, Paul Menzel wrote:
>> [Cc: +linux-pci@vger.kernel.org]

>> Am 06.03.24 um 03:50 schrieb Jesse Brandeburg:
>>> The igb driver was pre-declaring tons of functions just so that it could
>>> have an early declaration of the pci_driver struct.
>>>
>>> Delete a bunch of the declarations and move the struct to the bottom of the
>>> file, after all the functions are declared.
>>>
>>> Reviewed-by: Alan Brady <alan.brady@intel.com>
>>> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
>>> ---
>>> v2: address compilation failure when CONFIG_PM=n, which is then updated
>>>       in patch 2/2, fix alignment.
>>>       changes in v1 reviewed by Simon Horman
>>>       changes in v1 reviewed by Paul Menzel
>>> v1: original net-next posting
>>> ---
>>>    drivers/net/ethernet/intel/igb/igb_main.c | 53 ++++++++++-------------
>>>    1 file changed, 24 insertions(+), 29 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
>>> index 518298bbdadc..e749bf5164b8 100644
>>> --- a/drivers/net/ethernet/intel/igb/igb_main.c
>>> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
>>> @@ -106,8 +106,6 @@ static int igb_setup_all_rx_resources(struct igb_adapter *);
>>>    static void igb_free_all_tx_resources(struct igb_adapter *);
>>>    static void igb_free_all_rx_resources(struct igb_adapter *);
>>>    static void igb_setup_mrqc(struct igb_adapter *);
>>> -static int igb_probe(struct pci_dev *, const struct pci_device_id *);
>>> -static void igb_remove(struct pci_dev *pdev);
>>>    static void igb_init_queue_configuration(struct igb_adapter *adapter);
>>>    static int igb_sw_init(struct igb_adapter *);
>>>    int igb_open(struct net_device *);
>>> @@ -178,20 +176,6 @@ static int igb_vf_configure(struct igb_adapter *adapter, int vf);
>>>    static int igb_disable_sriov(struct pci_dev *dev, bool reinit);
>>>    #endif
>>>    -static int igb_suspend(struct device *);
>>> -static int igb_resume(struct device *);
>>> -static int igb_runtime_suspend(struct device *dev);
>>> -static int igb_runtime_resume(struct device *dev);
>>> -static int igb_runtime_idle(struct device *dev);
>>> -#ifdef CONFIG_PM
>>> -static const struct dev_pm_ops igb_pm_ops = {
>>> -    SET_SYSTEM_SLEEP_PM_OPS(igb_suspend, igb_resume)
>>> -    SET_RUNTIME_PM_OPS(igb_runtime_suspend, igb_runtime_resume,
>>> -            igb_runtime_idle)
>>> -};
>>> -#endif
>>> -static void igb_shutdown(struct pci_dev *);
>>> -static int igb_pci_sriov_configure(struct pci_dev *dev, int num_vfs);
>>>    #ifdef CONFIG_IGB_DCA
>>>    static int igb_notify_dca(struct notifier_block *, unsigned long, void *);
>>>    static struct notifier_block dca_notifier = {
>>> @@ -219,19 +203,6 @@ static const struct pci_error_handlers igb_err_handler = {
>>>      static void igb_init_dmac(struct igb_adapter *adapter, u32 pba);
>>>    -static struct pci_driver igb_driver = {
>>> -    .name     = igb_driver_name,
>>> -    .id_table = igb_pci_tbl,
>>> -    .probe    = igb_probe,
>>> -    .remove   = igb_remove,
>>> -#ifdef CONFIG_PM
>>> -    .driver.pm = &igb_pm_ops,
>>> -#endif
>>> -    .shutdown = igb_shutdown,
>>> -    .sriov_configure = igb_pci_sriov_configure,
>>> -    .err_handler = &igb_err_handler
>>> -};
>>> -
>>>    MODULE_AUTHOR("Intel Corporation, <e1000-devel@lists.sourceforge.net>");
>>>    MODULE_DESCRIPTION("Intel(R) Gigabit Ethernet Network Driver");
>>>    MODULE_LICENSE("GPL v2");
>>
>> A lot of other drivers also have this at the end.
>>
>>> @@ -647,6 +618,8 @@ struct net_device *igb_get_hw_dev(struct e1000_hw *hw)
>>>        return adapter->netdev;
>>>    }
>>>    +static struct pci_driver igb_driver;
>>> +
>>>    /**
>>>     *  igb_init_module - Driver Registration Routine
>>>     *
>>> @@ -10170,4 +10143,26 @@ static void igb_nfc_filter_restore(struct igb_adapter *adapter)
>>>          spin_unlock(&adapter->nfc_lock);
>>>    }
>>> +
>>> +#ifdef CONFIG_PM
>>> +static const struct dev_pm_ops igb_pm_ops = {
>>> +    SET_SYSTEM_SLEEP_PM_OPS(igb_suspend, igb_resume)
>>> +    SET_RUNTIME_PM_OPS(igb_runtime_suspend, igb_runtime_resume,
>>> +               igb_runtime_idle)
>>> +};
>>> +#endif
>>> +
>>> +static struct pci_driver igb_driver = {
>>> +    .name     = igb_driver_name,
>>> +    .id_table = igb_pci_tbl,
>>> +    .probe    = igb_probe,
>>> +    .remove   = igb_remove,
>>> +#ifdef CONFIG_PM
>>> +    .driver.pm = &igb_pm_ops,
>>> +#endif
>>> +    .shutdown = igb_shutdown,
>>> +    .sriov_configure = igb_pci_sriov_configure,
>>> +    .err_handler = &igb_err_handler
>>> +};
>>> +
>>>    /* igb_main.c */
>>
>> I looked through `drivers/` and .driver.pm is unguarded there.
>> Example `drivers/video/fbdev/geode/gxfb_core.c`: >>
>>      static const struct dev_pm_ops gxfb_pm_ops = {
>>      #ifdef CONFIG_PM_SLEEP
>>              .suspend        = gxfb_suspend,
>>              .resume         = gxfb_resume,
>>              .freeze         = NULL,
>>              .thaw           = gxfb_resume,
>>              .poweroff       = NULL,
>>              .restore        = gxfb_resume,
>>      #endif
>>      };
>>
>>      static struct pci_driver gxfb_driver = {
>>              .name           = "gxfb",
>>              .id_table       = gxfb_id_table,
>>              .probe          = gxfb_probe,
>>              .remove         = gxfb_remove,
>>              .driver.pm      = &gxfb_pm_ops,
>>      };
>>
>> No idea, what driver follows the best practices though, and if it
>> would belong into a separate commit.
> 
> The geode fbdev driver may be a bad example as it's ancient. There's
> pm_sleep_ptr, SYSTEM_SLEEP_PM_OPS et al to avoid the conditional 
> compiling and use of __maybe_unused. And yes, I also think this
> should be a separate patch.

Sorry for the noise. I should looked at or remembered patch 2/2, doing 
exactly that.


Kind regards,

Paul

