Return-Path: <linux-pci+bounces-8853-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81B1909392
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 23:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D88801C213A3
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 21:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CA617C72;
	Fri, 14 Jun 2024 21:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuOWENMm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84149393
	for <linux-pci@vger.kernel.org>; Fri, 14 Jun 2024 21:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718399180; cv=none; b=jTaORV65gTi0DQw/aE3PN9cXzrBJBzPTqKH+ipBo/57EjwTAkXW0wdC5VAv6QPIzSq44VnDVvP4xMn91AOSPQFH8YCt87yu03wgJ9pAfEpZ9GSU8H11Mig+3NrVXSFymXbGYc06Lp9fbDfF5GmLOxVMIUq3KtWaMGg6TxcYzvwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718399180; c=relaxed/simple;
	bh=e84JwZhmlRWv2FhpqzpePfHkIhFmwnWnTnrEWE581SI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jNQpVmeUQfBShw8DsMt24/i0jxk7xoRld1bI2U88JisQw3AST+FFgZodTYO+T1yuNO/V/9q+ltBMJ4Q9hRibr4m99k7Zyqedi0P2M+cHYLcYeCuxEn5rPbld+PCDgZAEfmTsAqjpTq/kNR7ND0ZVQVQH3hC1KH42cNx/YwqKh8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuOWENMm; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6f8edde24b3so1551501a34.2
        for <linux-pci@vger.kernel.org>; Fri, 14 Jun 2024 14:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718399177; x=1719003977; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IQGhHVOprOwS//03JHeYBrQtrYnrvsoXyGt9CushPCU=;
        b=VuOWENMmobUczgMb9rY36aWSCRx2htwFLhwuCJm3pO4U21ILw1elUp8fOa9gyD9Uur
         9IEIGLrkHCdQJUAdlisBwmmmg4Xq7NYqKycfkJhyGtI1hkz7UWro5ikORlca92nmCgLI
         oLe5YV1LQyj/WSriicezHvmD2N3WIbpwIoGmyIM5i3e9MyY0aN7HAfyyAIICVLvfaetY
         NWbMDJWTPJ+evQ7AIYPgS8q1ks9t6oBZP5SXu/hD/+XRBJKj10f47CHfTBFdZz7sQCxW
         YZ8QgVp4uSJGwIUPgjH5ScukqGo8JAoJAgneV6UX7oa/ToF+e6ag6Pn8bg4nFbnjyTD7
         ZZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718399177; x=1719003977;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IQGhHVOprOwS//03JHeYBrQtrYnrvsoXyGt9CushPCU=;
        b=DDidMEaiUO71XX7cP5DnAYzzn494cgP9EnsdU8Cv3FOQGQq5+Vf7K81fIesbUAkegQ
         91ht5VVtiIKJ/hfOFwA8OWJqV54gyHFnqykRhY8NuvLWQwuJmJf4BNt9h3himunSUvTr
         GOT6u8D5y41MU8pXd5vdSe4GgngOMIxr79PH12Gicmo11NTtyJJ8j2xR+gfVzjwvHzsd
         cBDzyUtZGkh+p+HwGJQP/suU9MDZ/5fkeSGURkuUEkqB0QwE7yhLARTCEZjvDj3/OkvH
         o1lWzBu0dq5hCxLGldN3X510xFOiG17PnUWwHgFzgpPLIdMUicYfzsA50leY0vLlOnzZ
         0XLw==
X-Forwarded-Encrypted: i=1; AJvYcCXk0oF9+s5H89VVN3EEE7Dn+kvEC2kIsIwSmwm2N6gzj+bGpn3usrGr5Z+bzXAk0BKL5TLDI+xRLOncF0vPDhyXrVRqIf65vie3
X-Gm-Message-State: AOJu0Yz3iv9DYTPqbq7vJQRP2luMFSl30fiKDc9e2ytrG/zsOU+9vqKo
	qvj2aYqiqT+MfcuNfti/4hgMVXYFc/6lMMGw0lOdTKwWVYt2bNu0
X-Google-Smtp-Source: AGHT+IFYGlQ7Kjx6TT8JT0JzLtY/YDYXGoVy8m4OeeYPHWafi2odq8lqi8fx0Jfci7tOAOl+47QylA==
X-Received: by 2002:a05:6830:925:b0:6f9:57e5:af05 with SMTP id 46e09a7af769-6fb934d5f00mr5199652a34.2.1718399177304;
        Fri, 14 Jun 2024 14:06:17 -0700 (PDT)
Received: from [192.168.1.224] (syn-067-048-091-116.res.spectrum.com. [67.48.91.116])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6fb5b640af2sm710774a34.64.2024.06.14.14.06.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 14:06:16 -0700 (PDT)
Message-ID: <05455f36-7027-4fd6-8af7-4fe8e483f25c@gmail.com>
Date: Fri, 14 Jun 2024 16:06:14 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] PCI/NPEM: Add Native PCIe Enclosure Management
 support
To: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
 linux-pci@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Lukas Wunner
 <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>,
 Marek Behun <marek.behun@nic.cz>, Pavel Machek <pavel@ucw.cz>,
 Randy Dunlap <rdunlap@infradead.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20240528131940.16924-1-mariusz.tkaczyk@linux.intel.com>
 <20240528131940.16924-3-mariusz.tkaczyk@linux.intel.com>
Content-Language: en-US
From: stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <20240528131940.16924-3-mariusz.tkaczyk@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/28/2024 8:19 AM, Mariusz Tkaczyk wrote:
> Native PCIe Enclosure Management (NPEM, PCIe r6.1 sec 6.28) allows
> managing LED in storage enclosures. NPEM is indication oriented
> and it does not give direct access to LED. Although each of
> the indications *could* represent an individual LED, multiple
> indications could also be represented as a single,
> multi-color LED or a single LED blinking in a specific interval.
> The specification leaves that open.
> 
> Each enabled indication (capability register bit on) is represented as a
> ledclass_dev which can be controlled through sysfs. For every ledclass
> device only 2 brightness states are allowed: LED_ON (1) or LED_OFF (0).
> It is corresponding to NPEM control register (Indication bit on/off).
> 
> Ledclass devices appear in sysfs as child devices (subdirectory) of PCI
> device which has an NPEM Extended Capability and indication is enabled
> in NPEM capability register. For example, these are leds created for
> pcieport "10000:02:05.0" on my setup:
> 
> leds/
> ├── 10000:02:05.0:enclosure:fail
> ├── 10000:02:05.0:enclosure:locate
> ├── 10000:02:05.0:enclosure:ok
> └── 10000:02:05.0:enclosure:rebuild
> 
> They can be also found in "/sys/class/leds" directory. Parent PCIe device
> bdf is used to guarantee uniqueness across leds subsystem.
> 
> To enable/disable fail indication "brightness" file can be edited:
> echo 1 > ./leds/10000:02:05.0:enclosure:fail/brightness
> echo 0 > ./leds/10000:02:05.0:enclosure:fail/brightness
> 
> PCIe r6.1, sec 7.9.19.2 defines the possible indications.
> 
> Multiple indications for same parent PCIe device can conflict and
> hardware may update them when processing new request. To avoid issues,
> driver refresh all indications by reading back control register.
> 
> Driver is projected to be exclusive NPEM extended capability manager.
> It waits up to 1 second after imposing new request, it doesn't verify if
> controller is busy before write, assuming that mutex lock gives protection
> from concurrent updates. Driver is not registered if _DSM LED management
> is available.
> 
> NPEM is a PCIe extended capability so it should be registered in
> pcie_init_capabilities() but it is not possible due to LED dependency.
> Parent pci_device must be added earlier for led_classdev_register()
> to be successful. NPEM does not require configuration on kernel side, it
> is safe to register LED devices later.
> 
> Link: https://members.pcisig.com/wg/PCI-SIG/document/19849 [1]
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
> ---
>   drivers/pci/Kconfig           |   9 +
>   drivers/pci/Makefile          |   1 +
>   drivers/pci/npem.c            | 410 ++++++++++++++++++++++++++++++++++
>   drivers/pci/pci.h             |   8 +
>   drivers/pci/probe.c           |   2 +
>   drivers/pci/remove.c          |   2 +
>   include/linux/pci.h           |   3 +
>   include/uapi/linux/pci_regs.h |  34 +++
>   8 files changed, 469 insertions(+)
>   create mode 100644 drivers/pci/npem.c
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index d35001589d88..e696e69ad516 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -143,6 +143,15 @@ config PCI_IOV
>   
>   	  If unsure, say N.
>   
> +config PCI_NPEM
> +	bool "Native PCIe Enclosure Management"
> +	depends on LEDS_CLASS=y
> +	help
> +	  Support for Native PCIe Enclosure Management. It allows managing LED
> +	  indications in storage enclosures. Enclosure must support following
> +	  indications: OK, Locate, Fail, Rebuild, other indications are
> +	  optional.
> +
>   config PCI_PRI
>   	bool "PCI PRI support"
>   	select PCI_ATS
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 175302036890..cd5f655d4be9 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>   obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
>   obj-$(CONFIG_PCI_DOE)		+= doe.o
>   obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
> +obj-$(CONFIG_PCI_NPEM)		+= npem.o
>   
>   # Endpoint library must be initialized before its users
>   obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
> diff --git a/drivers/pci/npem.c b/drivers/pci/npem.c
> new file mode 100644
> index 000000000000..a76a2044dab2
> --- /dev/null
> +++ b/drivers/pci/npem.c
> @@ -0,0 +1,410 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCIe Enclosure management driver created for LED interfaces based on
> + * indications. It says *what indications* blink but does not specify *how*
> + * they blink - it is hardware defined.
> + *
> + * The driver name refers to Native PCIe Enclosure Management. It is
> + * first indication oriented standard with specification.
> + *
> + * Native PCIe Enclosure Management (NPEM)
> + *	PCIe Base Specification r6.1 sec 6.28
> + *	PCIe Base Specification r6.1 sec 7.9.19
> + *
> + * Copyright (c) 2023-2024 Intel Corporation
> + *	Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/bitops.h>
> +#include <linux/errno.h>
> +#include <linux/iopoll.h>
> +#include <linux/leds.h>
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +#include <linux/pci_regs.h>
> +#include <linux/types.h>
> +#include <linux/uleds.h>
> +
> +#include "pci.h"
> +
> +struct indication {
> +	u32 bit;
> +	const char *name;
> +};
> +
> +static const struct indication npem_indications[] = {
> +	{PCI_NPEM_IND_OK,	"enclosure:ok"},
> +	{PCI_NPEM_IND_LOCATE,	"enclosure:locate"},
> +	{PCI_NPEM_IND_FAIL,	"enclosure:fail"},
> +	{PCI_NPEM_IND_REBUILD,	"enclosure:rebuild"},
> +	{PCI_NPEM_IND_PFA,	"enclosure:pfa"},
> +	{PCI_NPEM_IND_HOTSPARE,	"enclosure:hotspare"},
> +	{PCI_NPEM_IND_ICA,	"enclosure:ica"},
> +	{PCI_NPEM_IND_IFA,	"enclosure:ifa"},
> +	{PCI_NPEM_IND_IDT,	"enclosure:idt"},
> +	{PCI_NPEM_IND_DISABLED,	"enclosure:disabled"},
> +	{PCI_NPEM_IND_SPEC_0,	"enclosure:specific_0"},
> +	{PCI_NPEM_IND_SPEC_1,	"enclosure:specific_1"},
> +	{PCI_NPEM_IND_SPEC_2,	"enclosure:specific_2"},
> +	{PCI_NPEM_IND_SPEC_3,	"enclosure:specific_3"},
> +	{PCI_NPEM_IND_SPEC_4,	"enclosure:specific_4"},
> +	{PCI_NPEM_IND_SPEC_5,	"enclosure:specific_5"},
> +	{PCI_NPEM_IND_SPEC_6,	"enclosure:specific_6"},
> +	{PCI_NPEM_IND_SPEC_7,	"enclosure:specific_7"},
> +	{0,			NULL}
> +};
> +
> +#define for_each_indication(ind, inds) \
> +	for (ind = inds; ind->bit; ind++)
> +
> +/* To avoid confusion, do not keep any special bits in indications */
> +static u32 reg_to_indications(u32 caps, const struct indication *inds)
> +{
> +	const struct indication *ind;
> +	u32 supported_indications = 0;
> +
> +	for_each_indication(ind, inds)
> +		supported_indications |= ind->bit;
> +
> +	return caps & supported_indications;
> +}
> +
> +/**
> + * struct npem_led - LED details
> + * @indication: indication details
> + * @npem: npem device
> + * @name: LED name
> + * @led: LED device
> + */
> +struct npem_led {
> +	const struct indication *indication;
> +	struct npem *npem;
> +	char name[LED_MAX_NAME_SIZE];
> +	struct led_classdev led;
> +};
> +
> +/**
> + * struct npem_ops - backend specific callbacks
> + * @inds: supported indications array
> + * @get_active_indications: get active indications
> + *	npem: npem device
> + *	buf: response buffer
> + * @set_active_indications: set new indications
> + *	npem: npem device
> + *	val: bit mask to set
> + *
> + * Handle communication with hardware. set_active_indications updates
> + * npem->active_indications.
> + */
> +struct npem_ops {
> +	const struct indication *inds;
> +	int (*get_active_indications)(struct npem *npem, u32 *buf);
> +	int (*set_active_indications)(struct npem *npem, u32 val);
> +};
> +
> +/**
> + * struct npem - NPEM device properties
> + * @dev: PCIe device this driver is attached to
> + * @ops: Backend specific callbacks
> + * @npem_lock: to keep concurrent updates serialized
> + * @pos: NPEM capability offset (only relevant for NPEM direct register access,
> + *	 not DSM access method)
> + * @supported_indications: bit mask of supported indications
> + *			   non-indication and reserved bits are cleared
> + * @active_indications: bit mask of active indications
> + *			non-indication and reserved bits are cleared
> + * @led_cnt: Supported LEDs count
> + * @leds: supported LEDs
> + */
> +struct npem {
> +	struct pci_dev *dev;
> +	const struct npem_ops *ops;
> +	struct mutex npem_lock;
> +	u16 pos;
> +	u32 supported_indications;
> +	u32 active_indications;
> +	int led_cnt;
> +	struct npem_led leds[];
> +};
> +
> +static int npem_read_reg(struct npem *npem, u16 reg, u32 *val)
> +{
> +	int ret = pci_read_config_dword(npem->dev, npem->pos + reg, val);
> +
> +	return pcibios_err_to_errno(ret);
> +}
> +
> +static int npem_write_ctrl(struct npem *npem, u32 reg)
> +{
> +	int pos = npem->pos + PCI_NPEM_CTRL;
> +	int ret = pci_write_config_dword(npem->dev, pos, reg);
> +
> +	return pcibios_err_to_errno(ret);
> +}
> +
> +static int npem_get_active_indications(struct npem *npem, u32 *buf)
> +{
> +	int ret;
> +
> +	ret = npem_read_reg(npem, PCI_NPEM_CTRL, buf);
> +	if (ret)
> +		return ret;
> +
> +	/* If PCI_NPEM_CTRL_ENABLE is not set then no indication should blink */
> +	if (!(*buf & PCI_NPEM_CTRL_ENABLE))
> +		*buf = 0;
> +
> +	/* Filter out not supported indications in response */
> +	*buf &= npem->supported_indications;
> +	return 0;
> +}
> +
> +static int npem_set_active_indications(struct npem *npem, u32 val)
> +{
> +	int ret, ret_val;
> +	u32 cc_status;
> +
> +	lockdep_assert_held(&npem->npem_lock);
> +
> +	/* This bit is always required */
> +	val |= PCI_NPEM_CTRL_ENABLE;
> +	ret = npem_write_ctrl(npem, val);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * For the case where a NPEM command has not completed immediately,
> +	 * it is recommended that software not continuously “spin” on polling
> +	 * the status register, but rather poll under interrupt at a reduced
> +	 * rate; for example at 10 ms intervals.
> +	 *
> +	 * PCIe r6.1 sec 6.28 "Implementation Note: Software Polling of NPEM
> +	 * Command Completed"
> +	 */
> +	ret = read_poll_timeout(npem_read_reg, ret_val,
> +				ret_val || (cc_status & PCI_NPEM_STATUS_CC),
> +				10 * USEC_PER_MSEC, USEC_PER_SEC, false, npem,
> +				PCI_NPEM_STATUS, &cc_status);
> +	if (ret)
> +		return ret_val;
> +
> +	/*
> +	 * All writes to control register, including writes that do not change
> +	 * the register value, are NPEM commands and should eventually result
> +	 * in a command completion indication in the NPEM Status Register.
> +	 *
> +	 * PCIe Base Specification r6.1 sec 7.9.19.3
> +	 *
> +	 * Register may not be updated, or other conflicting bits may be
> +	 * cleared. Spec is not strict here. Read NPEM Control register after
> +	 * write to keep cache in-sync.
> +	 */
> +	return npem_get_active_indications(npem, &npem->active_indications);
> +}
> +
> +static const struct npem_ops npem_ops = {
> +	.inds = npem_indications,
> +	.get_active_indications = npem_get_active_indications,
> +	.set_active_indications = npem_set_active_indications,
> +};
> +
> +#define DSM_GUID GUID_INIT(0x5d524d9d, 0xfff9, 0x4d4b,  0x8c, 0xb7, 0x74, 0x7e,\
> +			   0xd5, 0x1e, 0x19, 0x4d)
> +#define GET_SUPPORTED_STATES_DSM	BIT(1)
> +#define GET_STATE_DSM			BIT(2)
> +#define SET_STATE_DSM			BIT(3)
> +
> +static const guid_t dsm_guid = DSM_GUID;
> +
> +static bool npem_has_dsm(struct pci_dev *pdev)
> +{
> +	acpi_handle handle;
> +
> +	handle = ACPI_HANDLE(&pdev->dev);
> +	if (!handle)
> +		return false;
> +
> +	return acpi_check_dsm(handle, &dsm_guid, 0x1, GET_SUPPORTED_STATES_DSM |
> +			      GET_STATE_DSM | SET_STATE_DSM);
> +}
> +

I had to change the DSM definitions to be 1/2/3 rather than BIT(1)/BIT(2)/BIT(3), since
the numbers 1/2/3 (not 2/4/8) need to be passed to acpi_evaluate_dsm_typed()... I just
changed it to:

#define GET_SUPPORTED_STATES_DSM	1
#define GET_STATE_DSM			2
#define SET_STATE_DSM			3

...and

	return acpi_check_dsm(handle, &dsm_guid, 0x1,
			      BIT(GET_SUPPORTED_STATES_DSM) |
			      BIT(GET_STATE_DSM) | BIT(SET_STATE_DSM));

After I changed this (and one other thing, below), it worked great.

> +/*
> + * This function does not use ops->get_active_indications().
> + * It returns cached value, npem->npem_lock is held and it is safe.
> + */
> +static enum led_brightness brightness_get(struct led_classdev *led)
> +{
> +	struct npem_led *nled = container_of(led, struct npem_led, led);
> +	struct npem *npem = nled->npem;
> +	int ret, val = LED_OFF;
> +
> +	ret = mutex_lock_interruptible(&npem->npem_lock);
> +	if (ret)
> +		return ret;
> +
> +	if (npem->active_indications & nled->indication->bit)
> +		val = LED_ON;
> +
> +	mutex_unlock(&npem->npem_lock);
> +
> +	return val;
> +}
> +
> +static int brightness_set(struct led_classdev *led,
> +			  enum led_brightness brightness)
> +{
> +	struct npem_led *nled = container_of(led, struct npem_led, led);
> +	struct npem *npem = nled->npem;
> +	u32 indications;
> +	int ret;
> +
> +	ret = mutex_lock_interruptible(&npem->npem_lock);
> +	if (ret)
> +		return ret;
> +
> +	if (brightness == LED_OFF)
> +		indications = npem->active_indications & ~(nled->indication->bit);
> +	else
> +		indications = npem->active_indications | nled->indication->bit;
> +
> +	ret = npem->ops->set_active_indications(npem, indications);
> +
> +	mutex_unlock(&npem->npem_lock);
> +	return ret;
> +}
> +
> +static void npem_free(struct npem *npem)
> +{
> +	struct npem_led *nled;
> +	int cnt;
> +
> +	for (cnt = 0; cnt < npem->led_cnt; cnt++) {
> +		nled = &npem->leds[cnt];
> +
> +		if (nled->name[0])
> +			led_classdev_unregister(&nled->led);
> +	}
> +
> +	mutex_destroy(&npem->npem_lock);
> +	kfree(npem);
> +}
> +
> +static int pci_npem_set_led_classdev(struct npem *npem, struct npem_led *nled)
> +{
> +	struct led_classdev *led = &nled->led;
> +	struct led_init_data init_data = {};
> +	char *name = nled->name;
> +	int ret;
> +
> +	init_data.devicename = pci_name(npem->dev);
> +	init_data.default_label = nled->indication->name;
> +
> +	ret = led_compose_name(&npem->dev->dev, &init_data, name);
> +	if (ret)
> +		return ret;
> +
> +	led->name = name;
> +	led->brightness_set_blocking = brightness_set;
> +	led->brightness_get = brightness_get;
> +	led->max_brightness = LED_ON;
> +	led->default_trigger = "none";
> +	led->flags = 0;
> +
> +	ret = led_classdev_register(&npem->dev->dev, led);
> +	if (ret)
> +		/* Clear the name to indicate that it is not registered. */
> +		name[0] = 0;
> +	return ret;
> +}
> +
> +static int pci_npem_init(struct pci_dev *dev, const struct npem_ops *ops,
> +			 int pos, u32 caps)
> +{
> +	u32 supported = reg_to_indications(caps, ops->inds);
> +	int supported_cnt = hweight32(supported);
> +	const struct indication *indication;
> +	struct npem_led *nled;
> +	struct npem *npem;
> +	int led_idx = 0;
> +	u32 active;
> +	int ret;
> +
> +	npem = kzalloc(struct_size(npem, leds, supported_cnt), GFP_KERNEL);
> +
> +	if (!npem)
> +		return -ENOMEM;
> +
> +	npem->supported_indications = supported;
> +	npem->led_cnt = supported_cnt;
> +	npem->pos = pos;
> +	npem->dev = dev;
> +	npem->ops = ops;
> +
> +	ret = ops->get_active_indications(npem, &active);
> +	if (ret) {
> +		npem_free(npem);
> +		return -EACCES;
> +	}

Failing pci_npem_init() if this ops->get_active_indications() fails will keep this
from working on most (all?) Dell servers, because the _DSM get/set functions use an
IPMI operation region to get/set the active LEDs, and this is getting run before the
IPMI drivers and acpi_ipmi module (which provides ACPI access to IPMI operation
regions) get loaded.  (GET_SUPPORTED_STATES works without IPMI.)

For testing, I just changed this to ignore the error returned from
get_active_indications() if it is using DSM ops.  That still results in a string of
errors ("ACPI Error: Region IPMI (ID=7) has no handler" etc), but once the system is
up and I can log in, everything is loaded, and i can see & change brightness in sysfs.

I'm not sure if ignoring the error is the best fix for that.  Solutions I
can think of are:
(1) ignoring an error result from get_active_indications during init (as mentioned)
(2) providing a mechanism to trigger this driver to rescan a PCI device later from
     user space
(3) don't cache the active LEDs--just get the active states using NPEM/DSM when
     brightness is read, and do a get/modify/set when setting the brightness... then
     get_active_indications() wouldn't need to be called during init.


Thank you for including DSM support, Mariusz!

> +
> +	npem->active_indications = reg_to_indications(active, ops->inds);
> +
> +	/*
> +	 * Do not take npem->npem_lock, get_brightness() is called on
> +	 * registration path.
> +	 */
> +	mutex_init(&npem->npem_lock);
> +
> +	for_each_indication(indication, npem_indications) {
> +		if ((npem->supported_indications & indication->bit) == 0)
> +			/* Do not register unsupported indication */
> +			continue;
> +
> +		nled = &npem->leds[led_idx++];
> +		nled->indication = indication;
> +		nled->npem = npem;
> +
> +		ret = pci_npem_set_led_classdev(npem, nled);
> +		if (ret) {
> +			npem_free(npem);
> +			return ret;
> +		}
> +	}
> +
> +	dev->npem = npem;
> +	return 0;
> +}
> +
> +void pci_npem_remove(struct pci_dev *dev)
> +{
> +	if (dev->npem)
> +		npem_free(dev->npem);
> +}
> +
> +void pci_npem_create(struct pci_dev *dev)
> +{
> +	const struct npem_ops *ops = &npem_ops;
> +	int pos = 0, ret;
> +	u32 cap;
> +
> +	if (!npem_has_dsm(dev)) {
> +		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_NPEM);
> +		if (pos == 0)
> +			return;
> +
> +		if (pci_read_config_dword(dev, pos + PCI_NPEM_CAP, &cap) != 0 ||
> +		    (cap & PCI_NPEM_CAP_CAPABLE) == 0)
> +			return;
> +	} else {
> +		/*
> +		 * OS should use the DSM for LED control if it is available
> +		 * PCI Firmware Spec r3.3 sec 4.7.
> +		 */
> +		return;
> +	}
> +
> +	ret = pci_npem_init(dev, ops, pos, cap);
> +	if (ret)
> +		pci_err(dev, "Failed to register PCIe Enclosure Management driver, err: %d\n",
> +			ret);
> +}
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index fd44565c4756..9dea8c7353ab 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -333,6 +333,14 @@ static inline void pci_doe_destroy(struct pci_dev *pdev) { }
>   static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
>   #endif
>   
> +#ifdef CONFIG_PCI_NPEM
> +void pci_npem_create(struct pci_dev *dev);
> +void pci_npem_remove(struct pci_dev *dev);
> +#else
> +static inline void pci_npem_create(struct pci_dev *dev) { }
> +static inline void pci_npem_remove(struct pci_dev *dev) { }
> +#endif
> +
>   /**
>    * pci_dev_set_io_state - Set the new error state if possible.
>    *
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 8e696e547565..b8ea6353e27a 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2582,6 +2582,8 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>   	dev->match_driver = false;
>   	ret = device_add(&dev->dev);
>   	WARN_ON(ret < 0);
> +
> +	pci_npem_create(dev);
>   }
>   
>   struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index d749ea8250d6..1436f9cf1fea 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -33,6 +33,8 @@ static void pci_destroy_dev(struct pci_dev *dev)
>   	if (!dev->dev.kobj.parent)
>   		return;
>   
> +	pci_npem_remove(dev);
> +
>   	device_del(&dev->dev);
>   
>   	down_write(&pci_bus_sem);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index fb004fd4e889..c327c2dd4527 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -517,6 +517,9 @@ struct pci_dev {
>   #endif
>   #ifdef CONFIG_PCI_DOE
>   	struct xarray	doe_mbs;	/* Data Object Exchange mailboxes */
> +#endif
> +#ifdef CONFIG_PCI_NPEM
> +	struct npem	*npem;		/* Native PCIe Enclosure Management */
>   #endif
>   	u16		acs_cap;	/* ACS Capability offset */
>   	phys_addr_t	rom;		/* Physical address if not from BAR */
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 94c00996e633..97e8b7ed9998 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -740,6 +740,7 @@
>   #define PCI_EXT_CAP_ID_DVSEC	0x23	/* Designated Vendor-Specific */
>   #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
>   #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
> +#define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
>   #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
>   #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
>   #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE
> @@ -1121,6 +1122,39 @@
>   #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_MASK		0x000000F0
>   #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_SHIFT	4
>   
> +/* Native PCIe Enclosure Management */
> +#define PCI_NPEM_CAP	0x04 /* NPEM capability register */
> +#define	 PCI_NPEM_CAP_CAPABLE		0x00000001 /* NPEM Capable */
> +
> +#define PCI_NPEM_CTRL	0x08 /* NPEM control register */
> +#define	 PCI_NPEM_CTRL_ENABLE		0x00000001 /* NPEM Enable */
> +
> +#define PCI_NPEM_STATUS	0x0c /* NPEM status register */
> +#define	 PCI_NPEM_STATUS_CC		0x00000001 /* NPEM Command completed */
> +/*
> + * Native PCIe Enclosure Management indication bits and Reset command bit
> + * are corresponding for capability and control registers.
> + */
> +#define  PCI_NPEM_CMD_RESET		0x00000002 /* NPEM Reset Command */
> +#define  PCI_NPEM_IND_OK		0x00000004 /* NPEM indication OK */
> +#define  PCI_NPEM_IND_LOCATE		0x00000008 /* NPEM indication Locate */
> +#define  PCI_NPEM_IND_FAIL		0x00000010 /* NPEM indication Fail */
> +#define  PCI_NPEM_IND_REBUILD		0x00000020 /* NPEM indication Rebuild */
> +#define  PCI_NPEM_IND_PFA		0x00000040 /* NPEM indication Predicted Failure Analysis */
> +#define  PCI_NPEM_IND_HOTSPARE		0x00000080 /* NPEM indication Hot Spare */
> +#define  PCI_NPEM_IND_ICA		0x00000100 /* NPEM indication In Critical Array */
> +#define  PCI_NPEM_IND_IFA		0x00000200 /* NPEM indication In Failed Array */
> +#define  PCI_NPEM_IND_IDT		0x00000400 /* NPEM indication Invalid Device Type */
> +#define  PCI_NPEM_IND_DISABLED		0x00000800 /* NPEM indication Disabled */
> +#define  PCI_NPEM_IND_SPEC_0		0x00800000
> +#define  PCI_NPEM_IND_SPEC_1		0x01000000
> +#define  PCI_NPEM_IND_SPEC_2		0x02000000
> +#define  PCI_NPEM_IND_SPEC_3		0x04000000
> +#define  PCI_NPEM_IND_SPEC_4		0x08000000
> +#define  PCI_NPEM_IND_SPEC_5		0x10000000
> +#define  PCI_NPEM_IND_SPEC_6		0x20000000
> +#define  PCI_NPEM_IND_SPEC_7		0x40000000
> +
>   /* Data Object Exchange */
>   #define PCI_DOE_CAP		0x04    /* DOE Capabilities Register */
>   #define  PCI_DOE_CAP_INT_SUP			0x00000001  /* Interrupt Support */

