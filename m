Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE368D32BC
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2019 22:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfJJUqD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Oct 2019 16:46:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32927 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfJJUqD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Oct 2019 16:46:03 -0400
Received: by mail-wm1-f67.google.com with SMTP id r17so7938301wme.0
        for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2019 13:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EF1K3iH7uJpPx+NWwLxTXPoGtwaZqLPc9PrE/hmLjdE=;
        b=UCpkSyFjCCS4AVV0JcUqzdGsR2bmzBjnNWMhm9YZ4C036ykZRqlFLYgb/mkWc7eJ+N
         09GKJmVq8CDFoLqUDStZ2FLOZhiGGkhWNjrZRrvRY/8fV6VHCq7kq7734bxGzp6GuUj0
         D6M55B+GSABiHD2FGrHsiqOEd6L0Bc1punqq4KOcRxxyOuVz8f8uVADpxcDE/mxRk9p9
         awnVb7+/qxkxQPBL+DQPm85XEZbMgj7A1MWuLsW1vaj9qyzebe2D362+z8ZiW/DmRVHr
         rBTZnQmpFSBa6KmLdDrECYfTRO+BApbeqHL08WlwvGLLmvWYyRbobm2h4YmRvTYHxvWt
         VYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EF1K3iH7uJpPx+NWwLxTXPoGtwaZqLPc9PrE/hmLjdE=;
        b=BtDWEWEZwbhC87uDBnaEBOSKQVHoU5KdUa6KFRPw+IjFJeZzkLBK9cft2OlkPerQKA
         MhslEa8jhhh806k9PgGsW36tXRi0z/MObU2v2fsNuE0ldldu4zWkEuJn6EmiQYwgo0FS
         EHsn4ds8Gn/asmpmWGlUx+YXb9U9URpUgavOyBwtH4sJcsrs33vUwcd3uFe3MElv+u+4
         0+abBbmKvbUCFdqRhDVHle6IjfCoI+MviKCiRZG5BMyir1rs7nJygzmv1CIaXdo9mu6J
         Y4BSQsVuFWAKuKqkQip1McPfI03WP5sLM45GvcDUisdSEhx27li9I3jd4Gx84Gqb4Jxq
         zqSw==
X-Gm-Message-State: APjAAAV1I69L8AMP2HN0cRPYK0BHj1TXPpQzwDUot7TNFLWVWZ5JwyKu
        DJ2yNnMtICj9ZZzxeWtwOddwHqtQ
X-Google-Smtp-Source: APXvYqzGGYrWevbYUgyZ9B1J2mE5VTgCfr+gHxTjvkndJlBUKef8oQRDANDlWcsrbP8nMlERykVK0g==
X-Received: by 2002:a1c:a444:: with SMTP id n65mr324000wme.111.1570740358441;
        Thu, 10 Oct 2019 13:45:58 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f26:6400:1d9e:f0ba:1c44:fdf8? (p200300EA8F2664001D9EF0BA1C44FDF8.dip0.t-ipconnect.de. [2003:ea:8f26:6400:1d9e:f0ba:1c44:fdf8])
        by smtp.googlemail.com with ESMTPSA id w4sm6797566wrv.66.2019.10.10.13.45.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 13:45:57 -0700 (PDT)
Subject: Re: [PATCH v7 0/5] PCI/ASPM: Add sysfs attributes for controlling
 ASPM
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20191010132224.GA5080@google.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <4a13d431-2b6f-4874-c959-9d0bad4fba53@gmail.com>
Date:   Thu, 10 Oct 2019 22:45:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191010132224.GA5080@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10.10.2019 15:22, Bjorn Helgaas wrote:
> On Tue, Oct 08, 2019 at 05:10:40PM -0500, Bjorn Helgaas wrote:
>> On Sat, Oct 05, 2019 at 02:02:29PM +0200, Heiner Kallweit wrote:
>>> Background of this extension is a problem with the r8169 network driver.
>>> Several combinations of board chipsets and network chip versions have
>>> problems if ASPM is enabled, therefore we have to disable ASPM per
>>> default. However especially on notebooks ASPM can provide significant
>>> power-saving, therefore we want to give users the option to enable
>>> ASPM. With the new sysfs attributes users can control which ASPM
>>> link-states are disabled.
>>>
>>> v2:
>>> - use a dedicated sysfs attribute per link state
>>> - allow separate control of ASPM and PCI PM L1 sub-states
>>>
>>> v3:
>>> - patch 3: statically allocate the attribute group
>>> - patch 3: replace snprintf with printf
>>> - add patch 4
>>>
>>> v4:
>>> - patch 3: add call to sysfs_update_group because is_visible callback
>>>            returns false always at file creation time
>>> - patch 3: simplify code a little
>>>
>>> v5:
>>> - rebased to latest pci/next
>>>
>>> v6:
>>> - patch 3: consider several review comments from Bjorn
>>> - patch 4: add discussion link to commit message
>>>
>>> v7:
>>> - Move adding pcie_aspm_get_link() to separate patch 3
>>> - patch 4: change group name from aspm to link_pm
>>> - patch 4: control visibility of attributes individually
>>>
>>> Heiner Kallweit (5):
>>>   PCI/ASPM: add L1 sub-state support to pci_disable_link_state
>>>   PCI/ASPM: allow to re-enable Clock PM
>>>   PCI/ASPM: Add and use helper pcie_aspm_get_link
>>>   PCI/ASPM: Add sysfs attributes for controlling ASPM link states
>>>   PCI/ASPM: Remove Kconfig option PCIEASPM_DEBUG and related code
>>>
>>>  Documentation/ABI/testing/sysfs-bus-pci |  14 ++
>>>  drivers/pci/pci-sysfs.c                 |   6 +-
>>>  drivers/pci/pci.h                       |  12 +-
>>>  drivers/pci/pcie/Kconfig                |   7 -
>>>  drivers/pci/pcie/aspm.c                 | 252 ++++++++++++++++--------
>>>  include/linux/pci.h                     |  10 +-
>>>  6 files changed, 199 insertions(+), 102 deletions(-)
>>
>> I applied these to pci/aspm for v5.5.  Thank you very much for all the
>> work you put into this!
>>
>> There are a couple questions that are still open, but I have no
>> problem if we want to make minor tweaks before the merge window opens.
> 
> To resolve these open questions, I propose the diff below, which:
> 
>   - Makes pcie_aspm_get_link() work only when called for an Upstream
>     Port (Endpoint, Switch Upstream Port, or other component at the
>     downstream end of a Link).  I don't think there's any caller that
>     needs to supply the upstream end.
> 
>   - Makes pcie_aspm_get_link() check that both ends are PCIe devices.
>     This might be overkill, but we can't rely on the PCI topology
>     being "correct", e.g., we have to deal gracefully with a
>     virtualization or similar scenario where a bridge is PCI and the
>     child is PCIe.  In that case, we shouldn't try to manage ASPM, so
>     we don't need a link_state, but I couldn't quite convince myself
>     that pcie_aspm_init_link_state() handles these cases.
> 
>   - Removes the aspm_lock from the sysfs show functions.  Per the
>     discussion with Rafael, I don't think it's necessary there:
> 
>       https://lore.kernel.org/r/20191007223428.GA72605@google.com
> 
>     I didn't remove it from the store functions because they do ASPM
>     reconfiguration and I didn't try to figure out the locking there.
> 
> Let me know what you think about this.  If it looks right, I'll just
> squash these changes into the relevant patches.
> 
Looks good to me. Thanks, Heiner

> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 200ec994299d..83a169a196f5 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1078,24 +1078,22 @@ void pcie_aspm_powersave_config_link(struct pci_dev *pdev)
>  
>  static struct pcie_link_state *pcie_aspm_get_link(struct pci_dev *pdev)
>  {
> -	struct pci_dev *upstream;
> +	struct pci_dev *bridge;
>  
> -	if (pcie_downstream_port(pdev))
> -		upstream = pdev;
> -	else
> -		upstream = pci_upstream_bridge(pdev);
> +	if (!pci_is_pcie(pdev))
> +		return NULL;
> +
> +	bridge = pci_upstream_bridge(pdev);
> +	if (!bridge || !pci_is_pcie(bridge))
> +		return NULL;
>  
> -	return upstream ? upstream->link_state : NULL;
> +	return bridge->link_state;
>  }
>  
>  static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
>  {
> -	struct pcie_link_state *link;
> -
> -	if (!pci_is_pcie(pdev))
> -		return 0;
> +	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
>  
> -	link = pcie_aspm_get_link(pdev);
>  	if (!link)
>  		return -EINVAL;
>  	/*
> @@ -1225,16 +1223,9 @@ static ssize_t aspm_attr_show_common(struct device *dev,
>  				     char *buf, u8 state)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> -	struct pcie_link_state *link;
> -	bool enabled;
> -
> -	link = pcie_aspm_get_link(pdev);
> -
> -	mutex_lock(&aspm_lock);
> -	enabled = link->aspm_enabled & state;
> -	mutex_unlock(&aspm_lock);
> +	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
>  
> -	return sprintf(buf, "%d\n", enabled ? 1 : 0);
> +	return sprintf(buf, "%d\n", (link->aspm_enabled & state) ? 1 : 0);
>  }
>  
>  static ssize_t aspm_attr_store_common(struct device *dev,
> @@ -1242,11 +1233,9 @@ static ssize_t aspm_attr_store_common(struct device *dev,
>  				      const char *buf, size_t len, u8 state)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> -	struct pcie_link_state *link;
> +	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
>  	bool state_enable;
>  
> -	link = pcie_aspm_get_link(pdev);
> -
>  	if (strtobool(buf, &state_enable) < 0)
>  		return -EINVAL;
>  
> @@ -1291,16 +1280,9 @@ static ssize_t clkpm_show(struct device *dev,
>  			  struct device_attribute *attr, char *buf)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> -	struct pcie_link_state *link;
> -	int val;
> -
> -	link = pcie_aspm_get_link(pdev);
> -
> -	mutex_lock(&aspm_lock);
> -	val = link->clkpm_enabled;
> -	mutex_unlock(&aspm_lock);
> +	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
>  
> -	return sprintf(buf, "%d\n", val);
> +	return sprintf(buf, "%d\n", link->clkpm_enabled);
>  }
>  
>  static ssize_t clkpm_store(struct device *dev,
> @@ -1308,11 +1290,9 @@ static ssize_t clkpm_store(struct device *dev,
>  			   const char *buf, size_t len)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> -	struct pcie_link_state *link;
> +	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
>  	bool state_enable;
>  
> -	link = pcie_aspm_get_link(pdev);
> -
>  	if (strtobool(buf, &state_enable) < 0)
>  		return -EINVAL;
>  
> @@ -1352,7 +1332,7 @@ static umode_t aspm_ctrl_attrs_are_visible(struct kobject *kobj,
>  {
>  	struct device *dev = kobj_to_dev(kobj);
>  	struct pci_dev *pdev = to_pci_dev(dev);
> -	struct pcie_link_state *link = NULL;
> +	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
>  	static const u8 aspm_state_map[] = {
>  		ASPM_STATE_L0S,
>  		ASPM_STATE_L1,
> @@ -1362,19 +1342,13 @@ static umode_t aspm_ctrl_attrs_are_visible(struct kobject *kobj,
>  		ASPM_STATE_L1_2_PCIPM,
>  	};
>  
> -	if (aspm_disabled)
> -		return 0;
> -
> -	if (pci_is_pcie(pdev))
> -		link = pcie_aspm_get_link(pdev);
> -
> -	if (!link)
> +	if (aspm_disabled || !link)
>  		return 0;
>  
> -	if (n)
> -		return link->aspm_capable & aspm_state_map[n - 1] ? a->mode : 0;
> -	else
> +	if (n == 0)
>  		return link->clkpm_capable ? a->mode : 0;
> +
> +	return link->aspm_capable & aspm_state_map[n - 1] ? a->mode : 0;
>  }
>  
>  const struct attribute_group aspm_ctrl_attr_group = {
> 

