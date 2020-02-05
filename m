Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65CC915387B
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2020 19:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgBESvB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Feb 2020 13:51:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:33712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbgBESvB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Feb 2020 13:51:01 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59F382072B;
        Wed,  5 Feb 2020 18:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580928659;
        bh=gRNXIpOTr9I3us/dMaucqB1GRVvRskh476Qst8YvB74=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=V7MPqcYaWQwEQLTEtz07vS2DhYGuhLVRuaGrEzTuH8H1JCucxHBXndOPEojG26DgT
         ANfWoT7ocxPpsLbYMlXpARq2dJNcnmvER8L7SpGtihu51KJavBqN4BrCOwAQq/5EjY
         4YVycY1f1uF5mPgD7lwazU9arkNrt0ysZAJxtYb4=
Date:   Wed, 5 Feb 2020 12:50:57 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     linux-pci@vger.kernel.org, f.fangjian@huawei.com
Subject: Re: [PATCH 4/6] PCI: Improve and rename PCIE_SPEED2STR macro
Message-ID: <20200205185057.GA230486@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579079063-5668-5-git-send-email-yangyicong@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 15, 2020 at 05:04:21PM +0800, Yicong Yang wrote:
> Use pci_bus_speed_strings[] array to refactor PCIE_SPEED2STR macro.
> Rename PCIE_SPEED2STR with PCI_SPEED2STR as it's also used to
> decode non-PCIe speeds. Modify bus_speed_read() and
> __pcie_print_link_status() with PCI_SPEED2STR macro.

This looks like it should be split into two or three patches.

  - Rename
  - Fiddle with the "PCIe" suffix
  - Refactor with pci_bus_speed_strings[]

I don't know the right order for these.

> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
> 
> I don't add a boundary check in PCI_SPEED2STR macro because:
> 1. we cannot get the array size of an extern one using ARRAY_SIZE
> 2. It is the *speed* should be check valid or not when assigned,
> rather than checking it here. Actually we do make it valid when
> assigned, the speed is either a valid value or PCI_SPEED_UNKNOWN.
> And it's ensured in pcie_get_speed_cap(), pci_set_bus_speed()
> when probe, and pcie_link_speed[] array. Please check again for
> sure.

I'm a little nervous about this because bus->cur_bus_speed and
bus->max_bus_speed are set several places where we can't validate them
(powerpc, s390, faraday_pci_probe(), cpqhpc_probe(), get_max_bus_speed
(ibmphp), shpc_get_max_bus_speed(), etc).

I don't think we can avoid out-of-bounds references by relying on all
those places to get it right, especially since some of these can read
speeds from hardware, so new hardware can give us a bus speed that old
software won't know about.

>  drivers/pci/pci-sysfs.c |  2 +-
>  drivers/pci/pci.c       |  6 +++---
>  drivers/pci/pci.h       | 10 +++-------
>  drivers/pci/slot.c      | 10 +++-------
>  4 files changed, 10 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 13f766d..f4eafbc 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -156,7 +156,7 @@ static ssize_t max_link_speed_show(struct device *dev,
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> 
> -	return sprintf(buf, "%s\n", PCIE_SPEED2STR(pcie_get_speed_cap(pdev)));
> +	return sprintf(buf, "%s\n", PCI_SPEED2STR(pcie_get_speed_cap(pdev)));
>  }
>  static DEVICE_ATTR_RO(max_link_speed);
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e87196c..dce32ce 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5868,14 +5868,14 @@ void __pcie_print_link_status(struct pci_dev *dev, bool verbose)
>  	if (bw_avail >= bw_cap && verbose)
>  		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth (%s x%d link)\n",
>  			 bw_cap / 1000, bw_cap % 1000,
> -			 PCIE_SPEED2STR(speed_cap), width_cap);
> +			 PCI_SPEED2STR(speed_cap), width_cap);
>  	else if (bw_avail < bw_cap)
>  		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth, limited by %s x%d link at %s (capable of %u.%03u Gb/s with %s x%d link)\n",
>  			 bw_avail / 1000, bw_avail % 1000,
> -			 PCIE_SPEED2STR(speed), width,
> +			 PCI_SPEED2STR(speed), width,
>  			 limiting_dev ? pci_name(limiting_dev) : "<unknown>",
>  			 bw_cap / 1000, bw_cap % 1000,
> -			 PCIE_SPEED2STR(speed_cap), width_cap);
> +			 PCI_SPEED2STR(speed_cap), width_cap);
>  }
> 
>  /**
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 5fb1d76..5e1f810 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -291,13 +291,9 @@ struct pci_bus *pci_bus_get(struct pci_bus *bus);
>  void pci_bus_put(struct pci_bus *bus);
> 
>  /* PCIe link information */
> -#define PCIE_SPEED2STR(speed) \
> -	((speed) == PCIE_SPEED_32_0GT ? "32 GT/s" : \
> -	 (speed) == PCIE_SPEED_16_0GT ? "16 GT/s" : \
> -	 (speed) == PCIE_SPEED_8_0GT ? "8 GT/s" : \
> -	 (speed) == PCIE_SPEED_5_0GT ? "5 GT/s" : \
> -	 (speed) == PCIE_SPEED_2_5GT ? "2.5 GT/s" : \
> -	 "Unknown speed")
> +#define PCI_SPEED2STR(speed) \
> +	((speed) == PCI_SPEED_UNKNOWN ? "Unknown speed" : \
> +	 pci_bus_speed_strings[speed])
> 
>  /* PCIe speed to Mb/s reduced by encoding overhead */
>  #define PCIE_SPEED2MBS_ENC(speed) \
> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
> index 140dafb..871d598 100644
> --- a/drivers/pci/slot.c
> +++ b/drivers/pci/slot.c
> @@ -51,14 +51,10 @@ static ssize_t address_read_file(struct pci_slot *slot, char *buf)
> 
>  static ssize_t bus_speed_read(enum pci_bus_speed speed, char *buf)
>  {
> -	const char *speed_string;
> +	if (speed <= PCI_SPEED_133MHz_PCIX_533)
> +		return sprintf(buf, "%s\n", PCI_SPEED2STR(speed));
> 
> -	if (speed == PCI_SPEED_UNKNOWN)
> -		speed_string = "Unknown";
> -	else
> -		speed_string = pci_bus_speed_strings[speed];
> -
> -	return sprintf(buf, "%s\n", speed_string);
> +	return sprintf(buf, "%s PCIe\n", PCI_SPEED2STR(speed));
>  }
> 
>  static ssize_t max_speed_read_file(struct pci_slot *slot, char *buf)
> --
> 2.8.1
> 
