Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27FBF99FA7
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2019 21:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389212AbfHVTPm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Aug 2019 15:15:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41319 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730531AbfHVTPm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Aug 2019 15:15:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id j16so6428957wrr.8
        for <linux-pci@vger.kernel.org>; Thu, 22 Aug 2019 12:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jbsGWkp23Fy8Ny0Lv/c3wFD1VqZrWVvY0ZCxMOSxp4Q=;
        b=jXdlTNQfWZwmLolEpFeMqk8D2vIEe3PH5gtOpmXhxKSwW4k/IOFR+R2atdw8ccRA9E
         +9Pt+eXSLb2BIuvpQJY6nSfTu+MfD4OwQULQS8vzYKjvYsaRpzC7EpBW/q4/2sWn6Rzt
         vqgnsxEQHqmoTM4sDZb7q72c9r6IKtC00jw7SOBOg6gMrTFx4CkOjt4IE2QSOx1fneT7
         W9XUIRDi2yyjNokVk4RyFa6F0xfFL61pwRiKknscQw/yZyt4OoOZW3g9D/buz4aMWSRd
         avSws+kL5/zRFLtQci7GCcUlYmkujAA2YSDLTypJvXIYdu2ZC8Xap9AgUfGpB2cnQd/Z
         ZQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jbsGWkp23Fy8Ny0Lv/c3wFD1VqZrWVvY0ZCxMOSxp4Q=;
        b=dBSHYK+4WHzgaSenuZkKjcQ+9O2+Qh2IBJ3EZhoc9Hfo5Ibv2XQnD0Es7S1MiM0wet
         ka/5MJl3jHMFuTcYxmrFipNObAepdjBjBHogvjKwEvmX9eduCTbpktA6cf86j5VXy4gN
         f5x/BaLKSgSYVtRNGnn/kC+agcSQsA/4jjeKFwRaAnCQJd38MqijHqc6h/DiDCH7pHwc
         84yFTFkjwjGUf5GWvG/r/JHj0A6/aUgGZSqW3tMzHnW8g9lcnDsWwBp9pS7r5sK9Q7Qf
         mzT+GPOpPSf9zk6j8E/fzkwuMbvPFh6im72RxJ8ZRefpbmVfgx1H5BaS2XQy5PBkeoGz
         IAIQ==
X-Gm-Message-State: APjAAAV4F0oUW0qgM+CqeBYT2blDFMGg77T15W8qMxUqNbxv36aUxycK
        Nlu7IQBRWtbEz+XsGJbHOg5GfJyQ
X-Google-Smtp-Source: APXvYqwjI+Hn8NhiEeOnH1jK8XWlGsRyqMEz0mahAvqsEHzv65kg7Ucobt8MWg2N4NnTrOlOcDVQHA==
X-Received: by 2002:adf:c508:: with SMTP id q8mr518705wrf.287.1566501337992;
        Thu, 22 Aug 2019 12:15:37 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f04:7c00:10fa:d7ad:8564:6aa9? (p200300EA8F047C0010FAD7AD85646AA9.dip0.t-ipconnect.de. [2003:ea:8f04:7c00:10fa:d7ad:8564:6aa9])
        by smtp.googlemail.com with ESMTPSA id b26sm770545wmj.14.2019.08.22.12.15.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 12:15:37 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] PCI/ASPM: add sysfs attributes for controlling
 ASPM
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rajat Jain <rajatja@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <b4b1518a-d0e8-9534-5211-115107e770e1@gmail.com>
 <c75fe7ef-5045-fb53-047c-b7b06d4b7fe8@gmail.com>
 <20190822130503.GD12941@kroah.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <e4a278f1-ac78-a2fd-ddfe-a4dd0d1685e3@gmail.com>
Date:   Thu, 22 Aug 2019 21:15:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822130503.GD12941@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22.08.2019 15:05, Greg KH wrote:
> On Wed, Aug 21, 2019 at 08:18:41PM +0200, Heiner Kallweit wrote:
>> Background of this extension is a problem with the r8169 network driver.
>> Several combinations of board chipsets and network chip versions have
>> problems if ASPM is enabled, therefore we have to disable ASPM per default.
>> However especially on notebooks ASPM can provide significant power-saving,
>> therefore we want to give users the option to enable ASPM. With the new sysfs
>> attributes users can control which ASPM link-states are enabled/disabled.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>> v2:
>> - use a dedicated sysfs attribute per link state
>> - allow separate control of ASPM and PCI PM L1 sub-states
>> ---
>>  Documentation/ABI/testing/sysfs-bus-pci |  13 ++
>>  drivers/pci/pci.h                       |   8 +-
>>  drivers/pci/pcie/aspm.c                 | 263 +++++++++++++++++++++++-
>>  3 files changed, 276 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
>> index 8bfee557e..38b565c30 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-pci
>> +++ b/Documentation/ABI/testing/sysfs-bus-pci
>> @@ -347,3 +347,16 @@ Description:
>>  		If the device has any Peer-to-Peer memory registered, this
>>  	        file contains a '1' if the memory has been published for
>>  		use outside the driver that owns the device.
>> +
>> +What		/sys/bus/pci/devices/.../power/aspm_l0s
>> +What		/sys/bus/pci/devices/.../power/aspm_l1
>> +What		/sys/bus/pci/devices/.../power/aspm_l1_1
>> +What		/sys/bus/pci/devices/.../power/aspm_l1_2
>> +What		/sys/bus/pci/devices/.../power/aspm_l1_1_pcipm
>> +What		/sys/bus/pci/devices/.../power/aspm_l1_2_pcipm
>> +What		/sys/bus/pci/devices/.../power/aspm_clkpm
> 
> Wait, there already is a "power" subdirectory for all devices in the
> system, are you adding another one, or files to that already-created
> directory?
> 
This is the standard "power" directory dynamically created by
dpm_sysfs_add().

>> +date:		August 2019
>> +Contact:	Heiner Kallweit <hkallweit1@gmail.com>
>> +Description:	If ASPM is supported for an endpoint, then these files
>> +		can be used to disable or enable the individual
>> +		power management states.
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 3f126f808..e51c91f38 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -525,17 +525,13 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev);
>>  void pcie_aspm_exit_link_state(struct pci_dev *pdev);
>>  void pcie_aspm_pm_state_change(struct pci_dev *pdev);
>>  void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
>> +void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev);
>> +void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev);
>>  #else
>>  static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
>>  static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
>>  static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
>>  static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
>> -#endif
>> -
>> -#ifdef CONFIG_PCIEASPM_DEBUG
>> -void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev);
>> -void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev);
>> -#else
>>  static inline void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev) { }
>>  static inline void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev) { }
>>  #endif
>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> index 149b876c9..e7dfcd1bd 100644
>> --- a/drivers/pci/pcie/aspm.c
>> +++ b/drivers/pci/pcie/aspm.c
>> @@ -1275,38 +1275,297 @@ static ssize_t clk_ctl_store(struct device *dev,
>>  
>>  static DEVICE_ATTR_RW(link_state);
>>  static DEVICE_ATTR_RW(clk_ctl);
>> +#endif
>> +
>> +static const char power_group[] = "power";
>> +
>> +static struct pcie_link_state *aspm_get_parent_link(struct pci_dev *pdev)
>> +{
>> +	struct pci_dev *parent = pdev->bus->self;
>> +
>> +	if (pdev->has_secondary_link)
>> +		parent = pdev;
>> +
>> +	return parent ? parent->link_state : NULL;
>> +}
>> +
>> +static bool pcie_check_valid_aspm_endpoint(struct pci_dev *pdev)
>> +{
>> +	struct pcie_link_state *link;
>> +
>> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
>> +		return false;
>> +
>> +	link = aspm_get_parent_link(pdev);
>> +
>> +	return link && link->aspm_capable;
>> +}
>> +
>> +static ssize_t aspm_attr_show_common(struct device *dev,
>> +				     struct device_attribute *attr,
>> +				     char *buf, int state)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +	struct pcie_link_state *link;
>> +	int val;
>> +
>> +	link = aspm_get_parent_link(pdev);
>> +	if (!link)
>> +		return -EOPNOTSUPP;
>> +
>> +	mutex_lock(&aspm_lock);
>> +	val = !!(link->aspm_enabled & state);
>> +	mutex_unlock(&aspm_lock);
>> +
>> +	return snprintf(buf, PAGE_SIZE, "%d\n", val);
> 
> For sysfs files, you never need to use snprintf() as you "know" the size
> of the buffer is big, and you are just printing out a single number.  So
> that can be cleaned up in all of these attribute files.
> 
>> +}
>> +
>> +static ssize_t aspm_l0s_show(struct device *dev,
>> +			     struct device_attribute *attr, char *buf)
>> +{
>> +	return aspm_attr_show_common(dev, attr, buf, ASPM_STATE_L0S);
>> +}
>> +
>> +static ssize_t aspm_l1_show(struct device *dev,
>> +			    struct device_attribute *attr, char *buf)
>> +{
>> +	return aspm_attr_show_common(dev, attr, buf, ASPM_STATE_L1);
>> +}
>> +
>> +static ssize_t aspm_l1_1_show(struct device *dev,
>> +			      struct device_attribute *attr, char *buf)
>> +{
>> +	return aspm_attr_show_common(dev, attr, buf, ASPM_STATE_L1_1);
>> +}
>> +
>> +static ssize_t aspm_l1_2_show(struct device *dev,
>> +			      struct device_attribute *attr, char *buf)
>> +{
>> +	return aspm_attr_show_common(dev, attr, buf, ASPM_STATE_L1_2);
>> +}
>> +
>> +static ssize_t aspm_l1_1_pcipm_show(struct device *dev,
>> +				    struct device_attribute *attr, char *buf)
>> +{
>> +	return aspm_attr_show_common(dev, attr, buf, ASPM_STATE_L1_1_PCIPM);
>> +}
>> +
>> +static ssize_t aspm_l1_2_pcipm_show(struct device *dev,
>> +				    struct device_attribute *attr, char *buf)
>> +{
>> +	return aspm_attr_show_common(dev, attr, buf, ASPM_STATE_L1_2_PCIPM);
>> +}
>> +
>> +static ssize_t aspm_attr_store_common(struct device *dev,
>> +				      struct device_attribute *attr,
>> +				      const char *buf, size_t len, int state)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +	struct pcie_link_state *link;
>> +	bool state_enable;
>> +
>> +	if (aspm_disabled)
>> +		return -EPERM;
>> +
>> +	link = aspm_get_parent_link(pdev);
>> +	if (!link)
>> +		return -EOPNOTSUPP;
>> +
>> +	if (!(link->aspm_capable & state))
>> +		return -EOPNOTSUPP;
>> +
>> +	if (strtobool(buf, &state_enable) < 0)
>> +		return -EINVAL;
>> +
>> +	down_read(&pci_bus_sem);
>> +	mutex_lock(&aspm_lock);
>> +
>> +	if (state_enable)
>> +		link->aspm_disable &= ~state;
>> +	else
>> +		link->aspm_disable |= state;
>> +
>> +	if (link->aspm_disable & ASPM_STATE_L1)
>> +		link->aspm_disable |= ASPM_STATE_L1SS;
>> +
>> +	pcie_config_aspm_link(link, policy_to_aspm_state(link));
> 
> This function can't fail?
> 
It has no return value.

>> +
>> +	mutex_unlock(&aspm_lock);
>> +	up_read(&pci_bus_sem);
>> +
>> +	return len;
>> +}
>> +
>> +static ssize_t aspm_l0s_store(struct device *dev,
>> +			      struct device_attribute *attr,
>> +			      const char *buf, size_t len)
>> +{
>> +	return aspm_attr_store_common(dev, attr, buf, len, ASPM_STATE_L0S);
>> +}
>> +
>> +static ssize_t aspm_l1_store(struct device *dev,
>> +			     struct device_attribute *attr,
>> +			     const char *buf, size_t len)
>> +{
>> +	return aspm_attr_store_common(dev, attr, buf, len, ASPM_STATE_L1);
>> +}
>> +
>> +static ssize_t aspm_l1_1_store(struct device *dev,
>> +			       struct device_attribute *attr,
>> +			       const char *buf, size_t len)
>> +{
>> +	return aspm_attr_store_common(dev, attr, buf, len, ASPM_STATE_L1_1);
>> +}
>> +
>> +static ssize_t aspm_l1_2_store(struct device *dev,
>> +			       struct device_attribute *attr,
>> +			       const char *buf, size_t len)
>> +{
>> +	return aspm_attr_store_common(dev, attr, buf, len, ASPM_STATE_L1_2);
>> +}
>> +
>> +static ssize_t aspm_l1_1_pcipm_store(struct device *dev,
>> +				     struct device_attribute *attr,
>> +				     const char *buf, size_t len)
>> +{
>> +	return aspm_attr_store_common(dev, attr, buf, len,
>> +				      ASPM_STATE_L1_1_PCIPM);
>> +}
>> +
>> +static ssize_t aspm_l1_2_pcipm_store(struct device *dev,
>> +				     struct device_attribute *attr,
>> +				     const char *buf, size_t len)
>> +{
>> +	return aspm_attr_store_common(dev, attr, buf, len,
>> +				      ASPM_STATE_L1_2_PCIPM);
>> +}
>> +
>> +static ssize_t aspm_clkpm_show(struct device *dev,
>> +			       struct device_attribute *attr, char *buf)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +	struct pcie_link_state *link;
>> +	int val;
>> +
>> +	link = aspm_get_parent_link(pdev);
>> +	if (!link)
>> +		return -EOPNOTSUPP;
>> +
>> +	mutex_lock(&aspm_lock);
>> +	val = link->clkpm_enabled;
>> +	mutex_unlock(&aspm_lock);
>> +
>> +	return snprintf(buf, PAGE_SIZE, "%d\n", val);
>> +}
>> +
>> +static ssize_t aspm_clkpm_store(struct device *dev,
>> +				struct device_attribute *attr,
>> +				const char *buf, size_t len)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +	struct pcie_link_state *link;
>> +	bool state_enable;
>> +
>> +	if (aspm_disabled)
>> +		return -EPERM;
>> +
>> +	link = aspm_get_parent_link(pdev);
>> +	if (!link)
>> +		return -EOPNOTSUPP;
>> +
>> +	if (!link->clkpm_capable)
>> +		return -EOPNOTSUPP;
>> +
>> +	if (strtobool(buf, &state_enable) < 0)
>> +		return -EINVAL;
>> +
>> +	down_read(&pci_bus_sem);
>> +	mutex_lock(&aspm_lock);
>> +
>> +	link->clkpm_disable = !state_enable;
>> +	pcie_set_clkpm(link, policy_to_clkpm_state(link));
>> +
>> +	mutex_unlock(&aspm_lock);
>> +	up_read(&pci_bus_sem);
>> +
>> +	return len;
>> +}
>> +
>> +static DEVICE_ATTR_RW(aspm_l0s);
>> +static DEVICE_ATTR_RW(aspm_l1);
>> +static DEVICE_ATTR_RW(aspm_l1_1);
>> +static DEVICE_ATTR_RW(aspm_l1_2);
>> +static DEVICE_ATTR_RW(aspm_l1_1_pcipm);
>> +static DEVICE_ATTR_RW(aspm_l1_2_pcipm);
>> +static DEVICE_ATTR_RW(aspm_clkpm);
>>  
>> -static char power_group[] = "power";
>>  void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev)
>>  {
>>  	struct pcie_link_state *link_state = pdev->link_state;
>>  
>> +	if (pcie_check_valid_aspm_endpoint(pdev)) {
>> +		sysfs_add_file_to_group(&pdev->dev.kobj,
>> +			&dev_attr_aspm_l0s.attr, power_group);
>> +		sysfs_add_file_to_group(&pdev->dev.kobj,
>> +			&dev_attr_aspm_l1.attr, power_group);
>> +		sysfs_add_file_to_group(&pdev->dev.kobj,
>> +			&dev_attr_aspm_l1_1.attr, power_group);
>> +		sysfs_add_file_to_group(&pdev->dev.kobj,
>> +			&dev_attr_aspm_l1_2.attr, power_group);
>> +		sysfs_add_file_to_group(&pdev->dev.kobj,
>> +			&dev_attr_aspm_l1_1_pcipm.attr, power_group);
>> +		sysfs_add_file_to_group(&pdev->dev.kobj,
>> +			&dev_attr_aspm_l1_2_pcipm.attr, power_group);
>> +		sysfs_add_file_to_group(&pdev->dev.kobj,
>> +			&dev_attr_aspm_clkpm.attr, power_group);
> 
> Huh?  First of, if you are ever in a driver, and you have to call a
> sysfs_* function, you know something is wrong.
> 
> Why are you dynamically adding files to a group?  These should all be
> statically allocated and then at creation time you can dynamically
> determine if you need to show them or not.  Use the is_visable callback
> for that.
> 

The "power" group is dynamically created by the base driver core
(dpm_sysfs_add). Not sure how the ASPM sysfs files could be statically
allocated. We could add an attribute group to the "pci" bus_type,
but this doesn't feel right.
What we could do to make it simpler:
Create an attribute group and then use sysfs_merge_group().
But I see no way not to use sysfs_xxx functions. Also functions
like device_add_groups() are just very simple wrappers around sysfs_
functions.

Alternatively we could not use the existing "power" group but create
our own group with device_add_group(). But I don't see that we gain much.

>> +	}
>> +
>>  	if (!link_state)
>>  		return;
>>  
>> +#ifdef CONFIG_PCIEASPM_DEBUG
>>  	if (link_state->aspm_support)
>>  		sysfs_add_file_to_group(&pdev->dev.kobj,
>>  			&dev_attr_link_state.attr, power_group);
>>  	if (link_state->clkpm_capable)
>>  		sysfs_add_file_to_group(&pdev->dev.kobj,
>>  			&dev_attr_clk_ctl.attr, power_group);
> 
> Same here.
> 
>> +#endif
>>  }
>>  
>>  void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev)
>>  {
>>  	struct pcie_link_state *link_state = pdev->link_state;
>>  
>> +	if (pcie_check_valid_aspm_endpoint(pdev)) {
>> +		sysfs_remove_file_from_group(&pdev->dev.kobj,
>> +			&dev_attr_aspm_l0s.attr, power_group);
>> +		sysfs_remove_file_from_group(&pdev->dev.kobj,
>> +			&dev_attr_aspm_l1.attr, power_group);
>> +		sysfs_remove_file_from_group(&pdev->dev.kobj,
>> +			&dev_attr_aspm_l1_1.attr, power_group);
>> +		sysfs_remove_file_from_group(&pdev->dev.kobj,
>> +			&dev_attr_aspm_l1_2.attr, power_group);
>> +		sysfs_remove_file_from_group(&pdev->dev.kobj,
>> +			&dev_attr_aspm_l1_1_pcipm.attr, power_group);
>> +		sysfs_remove_file_from_group(&pdev->dev.kobj,
>> +			&dev_attr_aspm_l1_2_pcipm.attr, power_group);
>> +		sysfs_remove_file_from_group(&pdev->dev.kobj,
>> +			&dev_attr_aspm_clkpm.attr, power_group);
> 
> And then you never have to do this type of messy logic at all.
> 
> Ick.
> 
>> +	}
>> +
>>  	if (!link_state)
>>  		return;
>>  
>> +#ifdef CONFIG_PCIEASPM_DEBUG
>>  	if (link_state->aspm_support)
>>  		sysfs_remove_file_from_group(&pdev->dev.kobj,
>>  			&dev_attr_link_state.attr, power_group);
>>  	if (link_state->clkpm_capable)
>>  		sysfs_remove_file_from_group(&pdev->dev.kobj,
>>  			&dev_attr_clk_ctl.attr, power_group);
> 
> And you get to drop this nonsense as well.
> 
Right, with the new attributes CONFIG_PCIEASPM_DEBUG and all
related stuff could be removed most likely.

> thanks,
> 
> greg k-h
> 

Heiner
