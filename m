Return-Path: <linux-pci+bounces-15791-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B27A9B8FEB
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 12:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2537C280DF6
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 11:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E5415855D;
	Fri,  1 Nov 2024 11:04:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F681531F2
	for <linux-pci@vger.kernel.org>; Fri,  1 Nov 2024 11:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730459073; cv=none; b=LBdr88TPaYrmbLPz8jrT0KVBCDtwz8S6pm6pJ4CzshntRlDNkp2YOAA0cIeQSTZLHDGxJLh1OGWC4WNVR6TIpAgTijvq3Us7MeSIPB5rgO6IhJn3Fmy+vKpLnq4iL5elMInqvPcoOgwmLERvDqMzaWWzmADkm3QEupe4fQiGrhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730459073; c=relaxed/simple;
	bh=xzBuTlr0pYA/HJF/w8w1gpEb9hgJlGLhx87pV4m9HN8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BL6hMYRP3pSqi4mCNDLUyAJ3d04UdK/3c7oXzodOpUNVpLdWoPrcANr/Ah1jImxwLbA0w0Vm3YlGqjaSLH1WRENWj/ydVlgURVAdFSc713dXtqpI0OiZP+Lj2ifUqElxBaIFkHSGoW+AHUgjTQgVaUFUDGA3SPiD1MSwmTrCtn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xfyc35vVgz6K7BD;
	Fri,  1 Nov 2024 19:01:55 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0AB571400D3;
	Fri,  1 Nov 2024 19:04:27 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 1 Nov
 2024 12:04:26 +0100
Date: Fri, 1 Nov 2024 11:04:25 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
CC: <linux-pci@vger.kernel.org>, <kw@linux.com>
Subject: Re: [PATCH v4] Export PBEC Data register into sysfs
Message-ID: <20241101110425.00005582@Huawei.com>
In-Reply-To: <20240911012053.345286-1-kobayashi.da-06@fujitsu.com>
References: <20240911012053.345286-1-kobayashi.da-06@fujitsu.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 11 Sep 2024 10:20:53 +0900
"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com> wrote:

> This proposal aims to add a feature that outputs PCIe device power 
> consumption information to sysfs.
> 
> Add support for PBEC (Power Budgeting Extended Capability) output 
> to the PCIe driver. PBEC is defined in the 
> PCIe specification(PCIe r6.0, sec 7.8.1) and is
> a standard method for obtaining device power consumption information.
> 
> PCIe devices can significantly impact the overall power consumption of
> a system. However, obtaining PCIe device power consumption information 
> has traditionally been difficult. 
> 
> The PBEC Data register changes depending on the value of the PBEC Data 
> Select register. To obtain all PBEC Data register values defined in the 
> device, obtain the value of the PBEC Data register while changing the 
> value of the PBEC Data Select register.
> 
> Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Hi,

> ---
>  Documentation/ABI/testing/sysfs-bus-pci | 17 +++++++++++++++
>  drivers/pci/pci-sysfs.c                 | 28 +++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index ecf47559f495..be1911d948ef 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -500,3 +500,20 @@ Description:
>  		console drivers from the device.  Raw users of pci-sysfs
>  		resourceN attributes must be terminated prior to resizing.
>  		Success of the resizing operation is not guaranteed.
> +
> +What:		/sys/bus/pci/devices/.../power_budget
> +Date:		September 2024
> +Contact:	Kobayashi Daisuke <kobayashi.da-06@fujitsu.com>
> +Description:
> +		This file provides information about the PCIe power budget
> +		for the device. It is a read-only file that outputs the values
> +		of the Power Budgeting Data Register for each power state as a
> +		series of 32-bit hexadecimal values. Each line represents a
> +		single Power Budgeting Data register entry, containing the
> +		power budget for a specific power state.
> +
> +		The specific interpretation of these values depends on the
> +		device and the PCIe specification. Refer to the PCIe
> +		specification for detailed information about the Power
> +		Budgeting Data register, including the encoding	of power
> +		states and the interpretation of Base Power and Data Scale.

Is there precedence for similar register values just being available via
sysfs?  This definitely isn't in keeping with general desirable sysfs
interface characteristics.

> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 2321fdfefd7d..c52814a33597 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -182,6 +182,33 @@ static ssize_t resource_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(resource);
>  
> +static ssize_t power_budget_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct pci_dev *pci_dev = to_pci_dev(dev);
> +	size_t len = 0;
> +	int i, pos;
> +	u32 data;
> +
> +	pos = pci_find_ext_capability(pci_dev, PCI_EXT_CAP_ID_PWR);
> +	if (!pos)
> +		return -EINVAL;
> +
> +	for (i = 0; i < 0xff; i++) {
> +		pci_write_config_byte(pci_dev, pos + PCI_PWR_DSR, (u8)i);

Why not make i a u8? Would remove need for cast and otherwise make no
difference that I can see.

> +		pci_read_config_dword(pci_dev, pos + PCI_PWR_DATA, &data);
> +		if (!data) {
> +			if (len == 0)
> +				return -EINVAL;
> +			break;
> +		}
> +		len += sysfs_emit_at(buf, len, "%04x\n", data);

It's not user friendly to just output the register content, and this
is breaking the one thing per sysfs file ABI rules.

Various possible sysfs structures may make more sense.

1) Directory with files for each entry found. Each file
   is one thing so 
   power_budget/X_power - maths done to take base power and apply the data scale.
                X_pm_state
                X_pm_substate
                X_type - potentially with nice strings for each type.
                X_rail  - 12V, 3,3V , 1.5V/1.8V, 48V, 5V, thermal
                X_connector - 
	        X_connector_type

With the stuff in the extended bit only visible if flag in bit 31 is set.

> +	}
> +
> +	return len;
> +}
> +static DEVICE_ATTR_RO(power_budget);
> +
>  static ssize_t max_link_speed_show(struct device *dev,
>  				   struct device_attribute *attr, char *buf)
>  {
> @@ -629,6 +656,7 @@ static struct attribute *pcie_dev_attrs[] = {
>  	&dev_attr_current_link_width.attr,
>  	&dev_attr_max_link_width.attr,
>  	&dev_attr_max_link_speed.attr,
> +	&dev_attr_power_budget.attr,
>  	NULL,
>  };
>  


