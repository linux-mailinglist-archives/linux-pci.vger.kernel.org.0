Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62DB040A6A3
	for <lists+linux-pci@lfdr.de>; Tue, 14 Sep 2021 08:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239936AbhINGXN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 02:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239868AbhINGXN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Sep 2021 02:23:13 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEE9C061574;
        Mon, 13 Sep 2021 23:21:55 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u15so12254169wru.6;
        Mon, 13 Sep 2021 23:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x2qvffBwLVhkvh10Fn/+lTMA8EOR0q54Uhzl0vsV9Yo=;
        b=AP9cwhkc1TbKM2NZOIKJct4ix6L7UBHSJr1GaDi5+VzH6x1cJzzaXzhexQhnPq18IA
         RQtHZEebx3MeaHJ7sUduN4f7ICKb68QhNB6A0kHkFhhSc5+V+g9r2hWQxUYZB809phVW
         tErFNS6tXyb77zdwClXVwjA1UGG4PrS+R01S1nm66vAHC9ziXWh1X6nFbDQlrU5WSmkN
         lv3f60Zv1mbnmU3/0+S8P3xnUQlRGJT3MW8QMQQvxHvQ0opixV0rbSXmdNPNj9+KLNCF
         gBWyrmyQ4XrejIEKmdJGe13X8JqzwyXkXFD58pqRtrXX+Cqh10OQ2nr8S2hBrq8FjfCa
         SPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x2qvffBwLVhkvh10Fn/+lTMA8EOR0q54Uhzl0vsV9Yo=;
        b=lrPILsH+2qi3DgAxV7bOBxUHzNP1w8Pgr2S98ux5Ca58KFNTZTmjinInm1p622pXrK
         xVZDfDSQspt8Vtx+8AyZuXHGmSaEgubV2LsmZnbFEdiD+YCCgtdOpZvE8uTCyRXgLBjl
         69QirBVRp3qaTZtldihfmTCBh3vJOIps4HvBX2vwULkiubKwtBXI3J8FpW6ii/NN0Vhw
         gM3IDfZBRgiIa5HAoBX7zOFGCzlEmC/23LpUl7bb7RFRgBW9xxtReJ+5eh3NDmqjWaJC
         McwhQBX44/2qHhcAnDbgEWHhB+elr3Wmm0WwOqHot8PyDM5zfcYLEbgBPLrGSO5c1F9r
         FBSQ==
X-Gm-Message-State: AOAM530/GRCQhQxCRGkNsh5k8JVVzlLtF40J6ns6DauvPnfxpwHFri+Q
        hDw5WWsIIiEcZGyjXqkuW4ySWv0951w=
X-Google-Smtp-Source: ABdhPJzWcJletegZpS1AmoVfps+zU3sLjLE8JfUkUmehCqsvDSi+98Cv8juIu8w1PCcuo9ilQ56ISg==
X-Received: by 2002:adf:e603:: with SMTP id p3mr16382829wrm.357.1631600514169;
        Mon, 13 Sep 2021 23:21:54 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f08:4500:d493:df4c:6694:d298? (p200300ea8f084500d493df4c6694d298.dip0.t-ipconnect.de. [2003:ea:8f08:4500:d493:df4c:6694:d298])
        by smtp.googlemail.com with ESMTPSA id n3sm146175wmi.0.2021.09.13.23.21.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 23:21:53 -0700 (PDT)
Subject: Re: Linux 5.15-rc1
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Dave Jones <davej@codemonkey.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20210913234608.GA1381155@bjorn-Precision-5520>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <870c3332-db60-9cf5-0439-247f91ce7808@gmail.com>
Date:   Tue, 14 Sep 2021 08:21:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210913234608.GA1381155@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14.09.2021 01:46, Bjorn Helgaas wrote:
> On Mon, Sep 13, 2021 at 10:18:18AM -0400, Dave Jones wrote:
>> On Sun, Sep 12, 2021 at 04:58:27PM -0700, Linus Torvalds wrote:
>>  > So 5.15 isn't shaping up to be a particularly large release, at least
>>  > in number of commits. At only just over 10k non-merge commits, this is
>>  > in fact the smallest rc1 we have had in the 5.x series. We're usually
>>  > hovering in the 12-14k commit range.
>>
>> This release takes over two minutes longer to boot on one my
>> machines than 5.14.  The time just seems to be unaccounted for, even
>> with initcall_debug
> 
>> ...
>> [    2.194093] pci 0000:01:00.0: calling  quirk_f0_vpd_link+0x0/0x60 @ 1
>> [    2.194097] pci 0000:01:00.0: quirk_f0_vpd_link+0x0/0x60 took 0 usecs
>> [    2.194100] pci 0000:01:00.0: [8086:10fb] type 00 class 0x020000
>> [    2.194109] pci 0000:01:00.0: reg 0x10: [mem 0xd0080000-0xd00fffff 64bit pref]
>> [    2.194113] pci 0000:01:00.0: reg 0x18: [io  0xe020-0xe03f]
>> [    2.194121] pci 0000:01:00.0: reg 0x20: [mem 0xd0104000-0xd0107fff 64bit pref]
>> [    2.194126] pci 0000:01:00.0: reg 0x30: [mem 0xdfd80000-0xdfdfffff pref]
>> [    2.194136] pci 0000:01:00.0: calling  quirk_igfx_skip_te_disable+0x0/0x50 @ 1
>> [    2.194139] pci 0000:01:00.0: quirk_igfx_skip_te_disable+0x0/0x50 took 0 usecs
>> [    2.194164] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
>>
>> * stall here for 86 seconds *
>>
>> [   88.675114] pci 0000:01:00.0: reg 0x184: [mem 0x00000000-0x00003fff 64bit pref]
>> ...
> 
> 
>> 7bac54497c3e3b2ca37b7043f1fa78586540f10e is the first bad commit
>> commit 7bac54497c3e3b2ca37b7043f1fa78586540f10e
>> Author: Heiner Kallweit <hkallweit1@gmail.com>
>> Date:   Sun Aug 8 19:22:52 2021 +0200
>>
>>     PCI/VPD: Determine VPD size in pci_vpd_init()
>>
>>     Determine VPD size in pci_vpd_init().
>>
>>     Quirks set dev->vpd.len to a non-zero value, so they cause us to skip the
>>     dynamic size calculation.  Prerequisite is that we move the quirks from
>>     FINAL to HEADER so they are run before pci_vpd_init().
>>
>>     Link: https://lore.kernel.org/r/cc4a6538-557a-294d-4f94-e6d1d3c91589@gmail.com
>>     Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>
>>
>> Which unfortunately doesn't revert cleanly I can't test it reverted in
>> isolation.
>>
>> My guess is there's something quirky about the PCI bus on this machine
>> that causes stalls until we hit timeout, but I'm not sure where to begin
>> debugging this.
> 
> Sorry for the inconvenience of this, and thank you very much for doing
> the bisection to track it down.
> 
> We *could* revert 7bac54497c3e, but it'd be messy because a bunch of
> follow-up stuff depends on it.
> 
> I propose something like the patch below.  Would you mind trying it
> out?
> 
> 
> commit 4ede9949b93c ("PCI/VPD: Defer VPD sizing until first access")
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Mon Sep 13 16:13:26 2021 -0500
> 
>     PCI/VPD: Defer VPD sizing until first access
>     
>     7bac54497c3e ("PCI/VPD: Determine VPD size in pci_vpd_init()") reads VPD at
>     enumeration-time to find the size.  But this is quite slow, and we don't
>     need the size until we actually need data from VPD.  Dave reported a boot
>     slowdown of more than two minutes [1].
>     
>     Defer the VPD sizing until a driver or the user requests information from
>     VPD.  If devices are quirked because VPD is known not to work, clear the
>     vpd.cap pointer so we don't access it at all.
>     
>     [1] https://lore.kernel.org/r/20210913141818.GA27911@codemonkey.org.uk/
>     Fixes: 7bac54497c3e ("PCI/VPD: Determine VPD size in pci_vpd_init()")
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index 25557b272a4f..ca823ceee10c 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -46,13 +46,12 @@ static struct pci_dev *pci_get_func0_dev(struct pci_dev *dev)
>  }
>  
>  #define PCI_VPD_MAX_SIZE	(PCI_VPD_ADDR_MASK + 1)
> -#define PCI_VPD_SZ_INVALID	UINT_MAX
>  
>  /**
>   * pci_vpd_size - determine actual size of Vital Product Data
>   * @dev:	pci device struct
>   */
> -static size_t pci_vpd_size(struct pci_dev *dev)
> +static void pci_vpd_size(struct pci_dev *dev)
>  {
>  	size_t off = 0, size;
>  	unsigned char tag, header[1+2];	/* 1 byte tag, 2 bytes length */
> @@ -71,7 +70,7 @@ static size_t pci_vpd_size(struct pci_dev *dev)
>  			if (pci_read_vpd(dev, off + 1, 2, &header[1]) != 2) {
>  				pci_warn(dev, "failed VPD read at offset %zu\n",
>  					 off + 1);
> -				return off ?: PCI_VPD_SZ_INVALID;
> +				goto finish;
>  			}
>  			size = pci_vpd_lrdt_size(header);
>  			if (off + size > PCI_VPD_MAX_SIZE)
> @@ -87,16 +86,19 @@ static size_t pci_vpd_size(struct pci_dev *dev)
>  
>  			off += PCI_VPD_SRDT_TAG_SIZE + size;
>  			if (tag == PCI_VPD_STIN_END)	/* End tag descriptor */
> -				return off;
> +				goto finish;
>  		}
>  	}
> -	return off;
> +	goto finish;
>  
>  error:
>  	pci_info(dev, "invalid VPD tag %#04x (size %zu) at offset %zu%s\n",
>  		 header[0], size, off, off == 0 ?
>  		 "; assume missing optional EEPROM" : "");
> -	return off ?: PCI_VPD_SZ_INVALID;
> +finish:
> +	dev->vpd.len = off;
> +	if (off == 0)
> +		dev->vpd.cap = 0;		/* No VPD at all */
>  }
>  
>  /*
> @@ -145,9 +147,6 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
>  	loff_t end = pos + count;
>  	u8 *buf = arg;
>  
> -	if (!vpd->cap)
> -		return -ENODEV;
> -
>  	if (pos < 0)
>  		return -EINVAL;
>  
> @@ -206,9 +205,6 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
>  	loff_t end = pos + count;
>  	int ret = 0;
>  
> -	if (!vpd->cap)
> -		return -ENODEV;
> -
>  	if (pos < 0 || (pos & 3) || (count & 3))
>  		return -EINVAL;
>  
> @@ -244,12 +240,6 @@ void pci_vpd_init(struct pci_dev *dev)
>  {
>  	dev->vpd.cap = pci_find_capability(dev, PCI_CAP_ID_VPD);
>  	mutex_init(&dev->vpd.lock);
> -
> -	if (!dev->vpd.len)
> -		dev->vpd.len = pci_vpd_size(dev);
> -
> -	if (dev->vpd.len == PCI_VPD_SZ_INVALID)
> -		dev->vpd.cap = 0;
>  }
>  
>  static ssize_t vpd_read(struct file *filp, struct kobject *kobj,
> @@ -294,25 +284,29 @@ const struct attribute_group pci_dev_vpd_attr_group = {
>  
>  void *pci_vpd_alloc(struct pci_dev *dev, unsigned int *size)
>  {
> -	unsigned int len = dev->vpd.len;
> +	struct pci_vpd *vpd = &dev->vpd;
> +	unsigned int len;
>  	void *buf;
>  	int cnt;
>  
> -	if (!dev->vpd.cap)
> +	if (!vpd->cap)
>  		return ERR_PTR(-ENODEV);
>  
>  	buf = kmalloc(len, GFP_KERNEL);
>  	if (!buf)
>  		return ERR_PTR(-ENOMEM);
>  
> -	cnt = pci_read_vpd(dev, 0, len, buf);
> +	if (vpd->len == 0)
> +		pci_vpd_size(dev);
> +
> +	cnt = pci_read_vpd(dev, 0, vpd->len, buf);
>  	if (cnt != len) {
>  		kfree(buf);
>  		return ERR_PTR(-EIO);
>  	}
>  
>  	if (size)
> -		*size = len;
> +		*size = vpd->len;
>  
>  	return buf;
>  }
> @@ -374,6 +368,7 @@ static int pci_vpd_find_info_keyword(const u8 *buf, unsigned int off,
>   */
>  ssize_t pci_read_vpd(struct pci_dev *dev, loff_t pos, size_t count, void *buf)
>  {
> +	struct pci_vpd *vpd;
>  	ssize_t ret;
>  
>  	if (dev->dev_flags & PCI_DEV_FLAGS_VPD_REF_F0) {
> @@ -381,11 +376,27 @@ ssize_t pci_read_vpd(struct pci_dev *dev, loff_t pos, size_t count, void *buf)
>  		if (!dev)
>  			return -ENODEV;
>  
> +		vpd = &dev->vpd;
> +		if (!vpd->cap) {
> +			pci_dev_put(dev);
> +			return -ENODEV;
> +		}
> +
> +		if (vpd->len == 0)
> +			pci_vpd_size(dev);
> +
>  		ret = pci_vpd_read(dev, pos, count, buf);
>  		pci_dev_put(dev);
>  		return ret;
>  	}
>  
> +	vpd = &dev->vpd;
> +	if (!vpd->cap)
> +		return -ENODEV;
> +
> +	if (vpd->len == 0)
> +		pci_vpd_size(dev);
> +
>  	return pci_vpd_read(dev, pos, count, buf);
>  }
>  EXPORT_SYMBOL(pci_read_vpd);
> @@ -399,6 +410,7 @@ EXPORT_SYMBOL(pci_read_vpd);
>   */
>  ssize_t pci_write_vpd(struct pci_dev *dev, loff_t pos, size_t count, const void *buf)
>  {
> +	struct pci_vpd *vpd;
>  	ssize_t ret;
>  
>  	if (dev->dev_flags & PCI_DEV_FLAGS_VPD_REF_F0) {
> @@ -406,11 +418,26 @@ ssize_t pci_write_vpd(struct pci_dev *dev, loff_t pos, size_t count, const void
>  		if (!dev)
>  			return -ENODEV;
>  
> +		vpd = &dev->vpd;
> +		if (!vpd->cap) {
> +			pci_dev_put(dev);
> +			return -ENODEV;
> +		}
> +
> +		if (vpd->len == 0)
> +			pci_vpd_size(dev);
> +
>  		ret = pci_vpd_write(dev, pos, count, buf);
>  		pci_dev_put(dev);
>  		return ret;
>  	}
>  
> +	if (!vpd->cap)
> +		return -ENODEV;
> +
> +	if (vpd->len == 0)
> +		pci_vpd_size(dev);
> +
>  	return pci_vpd_write(dev, pos, count, buf);
>  }
>  EXPORT_SYMBOL(pci_write_vpd);
> @@ -500,27 +527,27 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
>   */
>  static void quirk_blacklist_vpd(struct pci_dev *dev)
>  {
> -	dev->vpd.len = PCI_VPD_SZ_INVALID;
> +	dev->vpd.cap = 0;
>  	pci_warn(dev, FW_BUG "disabling VPD access (can't determine size of non-standard VPD format)\n");
>  }
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x0060, quirk_blacklist_vpd);
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x007c, quirk_blacklist_vpd);
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x0413, quirk_blacklist_vpd);
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x0078, quirk_blacklist_vpd);
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x0079, quirk_blacklist_vpd);
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x0073, quirk_blacklist_vpd);
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x0071, quirk_blacklist_vpd);
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x005b, quirk_blacklist_vpd);
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x002f, quirk_blacklist_vpd);
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x005d, quirk_blacklist_vpd);
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x005f, quirk_blacklist_vpd);
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATTANSIC, PCI_ANY_ID, quirk_blacklist_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0060, quirk_blacklist_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x007c, quirk_blacklist_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0413, quirk_blacklist_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0078, quirk_blacklist_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0079, quirk_blacklist_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0073, quirk_blacklist_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0071, quirk_blacklist_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005b, quirk_blacklist_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x002f, quirk_blacklist_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005d, quirk_blacklist_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005f, quirk_blacklist_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, PCI_ANY_ID, quirk_blacklist_vpd);
>  /*

Leaving the quirks in FIXUP_HEADER stage would have the advantage that for
blacklisted devices the vpd sysfs attribute isn't visibale. The needed
changes to the patch are minimal.

>   * The Amazon Annapurna Labs 0x0031 device id is reused for other non Root Port
>   * device types, so the quirk is registered for the PCI_CLASS_BRIDGE_PCI class.
>   */
> -DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031,
> -			       PCI_CLASS_BRIDGE_PCI, 8, quirk_blacklist_vpd);
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031,
> +			      PCI_CLASS_BRIDGE_PCI, 8, quirk_blacklist_vpd);
>  
>  static void quirk_chelsio_extend_vpd(struct pci_dev *dev)
>  {
> @@ -545,7 +572,7 @@ static void quirk_chelsio_extend_vpd(struct pci_dev *dev)
>  		dev->vpd.len = 2048;
>  }
>  
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
> -			 quirk_chelsio_extend_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
> +			quirk_chelsio_extend_vpd);
>  
>  #endif
> 

