Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EACDC1745AF
	for <lists+linux-pci@lfdr.de>; Sat, 29 Feb 2020 10:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgB2JKG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Feb 2020 04:10:06 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11122 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726671AbgB2JKG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 29 Feb 2020 04:10:06 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 71B57A3709A10591C0BB;
        Sat, 29 Feb 2020 17:10:02 +0800 (CST)
Received: from [127.0.0.1] (10.65.58.147) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Sat, 29 Feb 2020
 17:09:55 +0800
Subject: Re: [PATCH v5 3/4] PCI: Use pci_speed_string() for all PCI/PCI-X/PCIe
 strings
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20200229030706.17835-1-helgaas@kernel.org>
 <20200229030706.17835-4-helgaas@kernel.org>
CC:     Jay Fang <f.fangjian@huawei.com>, <huangdaode@huawei.com>,
        <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <4592a4cc-8064-2575-3a15-ae61dd03c23e@hisilicon.com>
Date:   Sat, 29 Feb 2020 17:10:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200229030706.17835-4-helgaas@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,


On 2020/2/29 11:07, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Previously some PCI speed strings came from pci_speed_string(), some came
> from the PCIe-specific PCIE_SPEED2STR(), and some came from a PCIe-specific
> switch statement.  These methods were inconsistent:
>
>   pci_speed_string()     PCIE_SPEED2STR()     switch
>   ------------------     ----------------     ------
>   33 MHz PCI
>   ...
>   2.5 GT/s PCIe          2.5 GT/s             2.5 GT/s
>   5.0 GT/s PCIe          5 GT/s               5 GT/s
>   8.0 GT/s PCIe          8 GT/s               8 GT/s
>   16.0 GT/s PCIe         16 GT/s              16 GT/s
>   32.0 GT/s PCIe         32 GT/s              32 GT/s
>
> Standardize on pci_speed_string() as the single source of these strings.
>
> Note that this adds ".0" and "PCIe" to some messages, including sysfs
> "max_link_speed" files, a brcmstb "link up" message, and the link status
> dmesg logging, e.g.,
>
>   nvme 0000:01:00.0: 16.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x4 link at 0000:00:01.1 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
>
> I think it's better to standardize on a single version of the speed text.
> Previously we had strings like this:
>
>   /sys/bus/pci/slots/0/cur_bus_speed: 8.0 GT/s PCIe
>   /sys/bus/pci/slots/0/max_bus_speed: 8.0 GT/s PCIe
>   /sys/devices/pci0000:00/0000:00:1c.0/current_link_speed: 8 GT/s
>   /sys/devices/pci0000:00/0000:00:1c.0/max_link_speed: 8 GT/s
>
> This changes the latter two to match the slots files:
>
>   /sys/devices/pci0000:00/0000:00:1c.0/current_link_speed: 8.0 GT/s PCIe
>   /sys/devices/pci0000:00/0000:00:1c.0/max_link_speed: 8.0 GT/s PCIe
>
> Based-on-patch by: Yicong Yang <yangyicong@hisilicon.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c |  3 +--
>  drivers/pci/pci-sysfs.c               | 27 +++++----------------------
>  drivers/pci/pci.c                     |  6 +++---
>  drivers/pci/pci.h                     |  9 ---------
>  4 files changed, 9 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index d20aabc26273..41e88f1667bf 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -823,8 +823,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  	lnksta = readw(base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKSTA);
>  	cls = FIELD_GET(PCI_EXP_LNKSTA_CLS, lnksta);
>  	nlw = FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
> -	dev_info(dev, "link up, %s x%u %s\n",
> -		 PCIE_SPEED2STR(cls + PCI_SPEED_133MHz_PCIX_533),
> +	dev_info(dev, "link up, %s x%u %s\n", pci_speed_string(cls),
>  		 nlw, ssc_good ? "(SSC)" : "(!SSC)");

Here comes the problem. cls is not a pci_bus_speed enumerate. The PCIe link speed decodes
from PCI_EXP_LNKSTA is from 0x000, we'll get the *wrong* string if passing cls directly to
pci_speed_string(). pcie_link_speed[](drivers/pci/probe.c, line 662) array should be used
here to do the conversion.

+ dev_info(dev, "link up, %s x%u %s\n", pci_speed_string(pcie_link_speed[cls]),
           nlw, ssc_good ? "(SSC)" : "(!SSC)";

The other parts of the series are fine with me.

Regards,
Yicong Yang


>  
>  	/* PCIe->SCB endian mode for BAR */
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 13f766db0684..d123d1087061 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -156,7 +156,8 @@ static ssize_t max_link_speed_show(struct device *dev,
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  
> -	return sprintf(buf, "%s\n", PCIE_SPEED2STR(pcie_get_speed_cap(pdev)));
> +	return sprintf(buf, "%s\n",
> +		       pci_speed_string(pcie_get_speed_cap(pdev)));
>  }
>  static DEVICE_ATTR_RO(max_link_speed);
>  
> @@ -175,33 +176,15 @@ static ssize_t current_link_speed_show(struct device *dev,
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
>  	u16 linkstat;
>  	int err;
> -	const char *speed;
> +	enum pci_bus_speed speed;
>  
>  	err = pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &linkstat);
>  	if (err)
>  		return -EINVAL;
>  
> -	switch (linkstat & PCI_EXP_LNKSTA_CLS) {
> -	case PCI_EXP_LNKSTA_CLS_32_0GB:
> -		speed = "32 GT/s";
> -		break;
> -	case PCI_EXP_LNKSTA_CLS_16_0GB:
> -		speed = "16 GT/s";
> -		break;
> -	case PCI_EXP_LNKSTA_CLS_8_0GB:
> -		speed = "8 GT/s";
> -		break;
> -	case PCI_EXP_LNKSTA_CLS_5_0GB:
> -		speed = "5 GT/s";
> -		break;
> -	case PCI_EXP_LNKSTA_CLS_2_5GB:
> -		speed = "2.5 GT/s";
> -		break;
> -	default:
> -		speed = "Unknown speed";
> -	}
> +	speed = pcie_link_speed[linkstat & PCI_EXP_LNKSTA_CLS];
>  
> -	return sprintf(buf, "%s\n", speed);
> +	return sprintf(buf, "%s\n", pci_speed_string(speed));
>  }
>  static DEVICE_ATTR_RO(current_link_speed);
>  
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d828ca835a98..421587badecf 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5872,14 +5872,14 @@ void __pcie_print_link_status(struct pci_dev *dev, bool verbose)
>  	if (bw_avail >= bw_cap && verbose)
>  		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth (%s x%d link)\n",
>  			 bw_cap / 1000, bw_cap % 1000,
> -			 PCIE_SPEED2STR(speed_cap), width_cap);
> +			 pci_speed_string(speed_cap), width_cap);
>  	else if (bw_avail < bw_cap)
>  		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth, limited by %s x%d link at %s (capable of %u.%03u Gb/s with %s x%d link)\n",
>  			 bw_avail / 1000, bw_avail % 1000,
> -			 PCIE_SPEED2STR(speed), width,
> +			 pci_speed_string(speed), width,
>  			 limiting_dev ? pci_name(limiting_dev) : "<unknown>",
>  			 bw_cap / 1000, bw_cap % 1000,
> -			 PCIE_SPEED2STR(speed_cap), width_cap);
> +			 pci_speed_string(speed_cap), width_cap);
>  }
>  
>  /**
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 809753b10fad..01f5d7f449a5 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -292,15 +292,6 @@ void pci_disable_bridge_window(struct pci_dev *dev);
>  struct pci_bus *pci_bus_get(struct pci_bus *bus);
>  void pci_bus_put(struct pci_bus *bus);
>  
> -/* PCIe link information */
> -#define PCIE_SPEED2STR(speed) \
> -	((speed) == PCIE_SPEED_32_0GT ? "32 GT/s" : \
> -	 (speed) == PCIE_SPEED_16_0GT ? "16 GT/s" : \
> -	 (speed) == PCIE_SPEED_8_0GT ? "8 GT/s" : \
> -	 (speed) == PCIE_SPEED_5_0GT ? "5 GT/s" : \
> -	 (speed) == PCIE_SPEED_2_5GT ? "2.5 GT/s" : \
> -	 "Unknown speed")
> -
>  /* PCIe speed to Mb/s reduced by encoding overhead */
>  #define PCIE_SPEED2MBS_ENC(speed) \
>  	((speed) == PCIE_SPEED_32_0GT ? 32000*128/130 : \


