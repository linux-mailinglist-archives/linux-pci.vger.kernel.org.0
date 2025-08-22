Return-Path: <linux-pci+bounces-34619-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E625FB324BE
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 23:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00DEB01E75
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 21:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8749627057D;
	Fri, 22 Aug 2025 21:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="JqhENhGu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F42C239E8A
	for <linux-pci@vger.kernel.org>; Fri, 22 Aug 2025 21:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755899640; cv=none; b=F/GQyi2yI8RratM58PTa9uhjvudpSbhccgnqig0q6wHf6IYIeWsvaPwFaiIDN85J3R/x8P2FU0Kk49RbCJaV9xmdcX5cD2gpaO42x6Vnh0rhyhvbhPtAPvXNiPKweGVkYz957B5aYOn7qFHpYmw5Hrf9Z2wQ0x+FCmQLH9HsLC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755899640; c=relaxed/simple;
	bh=x5KMzwVFQDVQkxjB1n5nWMjhuHTK19ZjWPtHl3XuouY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbbutFzSSmO8bF2xk2NXYfq5s8URrllbXw8jlpEiwD4T+RRTQf9+ZZD3bh2DynvKuZgDdZ96XbjtVXfL/HPcTL2r0K4Oz+JnY+xltNOHbZopWLOyQc9lnkWtBfij+QzJBv210X7UyfTCSfG9jTjirVHdNLwj42r/Fge5/7kAG8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=JqhENhGu; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-30cceb382d1so2164101fac.2
        for <linux-pci@vger.kernel.org>; Fri, 22 Aug 2025 14:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1755899637; x=1756504437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kraZQwgGsqActCzVMqrdt2pTEU4/LJMkbYTSib4v1/0=;
        b=JqhENhGukBmHalcP8aXt09D3Pne9WHUmC5rXmwt1P+5KxeBKztWAJVQMo7nDXiG8Rv
         cVSgKmKmNPGh/hZ6KgqK6nrFDjgr70qRyO+BEJ/PzwhXncy4qpU5rs7TYw2yCYlLZYP2
         LR4WFYif5dM2HJswwdmSZy0fF+VGuxaI2qhb/QxyuFFbvzJfAw5zwf7CjOgfyjR6Do4A
         W2DGsUKcqaQq7DCFOoNwtQhg9ZuKE54myZFXtyU8RzTuTeZh6lOe6H26f62s/sz9oarq
         Y89HjSKNraFUcopzpVssVO4TsX4gRrppxukzNnkrGxm6s/L8aGJAWQaJYUGs/TTvo5iB
         QpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755899637; x=1756504437;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kraZQwgGsqActCzVMqrdt2pTEU4/LJMkbYTSib4v1/0=;
        b=imskmjVklFLaowozJ2csiYtWM8U25c8eFBLYs5qSpaQgr35F3r1KDd9cGpDeO/5NbN
         UHnsKVwxq+fbvKnnwEzdW7iT88DV7q3MFVS04n5gJXt/Wg/Z5CKEST78/Ye71imbvz9x
         qNHb9Liuv0EspLKqca1GLl3x8kulb2sFVuDxlOr/e4NETHn96D0NLQ7fiobN8XjzCtZA
         6fFKYFc7FhB+rtpBaLEk15TDgH2wAJExLszL36mV25ha09nDHLrAyEtshShZ1DgfR8Hh
         x+9kBZkE5P4kry5WMEjZni4pCI22GZFHORd/M4c1RgK2erk8t3l9U0VzNu9sIqJaHUNE
         d8Aw==
X-Forwarded-Encrypted: i=1; AJvYcCVhDsbRD/zyCOkzjChAhFgKO2CY7LuGDEiuuVpZHxcmWEoLg4N2WSCzKBzkdbYAaBJRW5f29sewSuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBOf43WPKKhJBoTCLXJWyeWf+DoDeQloVSyS69LAr7FY3/83fa
	B69SASTfhHHndYwrYxZYu9ujlvZ70Mll2SYwvxLB2Jz9D6H5hDwmnTW8Y072C9sahwc=
X-Gm-Gg: ASbGncsYAB9ZBYiAfeInprs2XcGkWRmWp+RY1peY3F/fWL//NwOHBP6n0JG/s1nht8r
	YPxqbvdcaXhdFeAz5qV8usimfpIEydLrMCN6jQiQFZhZlzq/1euNc70OlbFczsI7lFj328ZZDsK
	NFh7vjolZ2eNDvrJjQyAnAAqZSSFh7746AQjf9l+UENXliZKrxv1Iwj0j5nldAwDUF+NW95Q9XA
	QDnmu2Uix92qv5SjIlMEFv8GcmU34e1iCVjD2k+Kiy0T55Sjtt5HQNDns1Uf42CXOtt9kTry7py
	JtGn0ThFNZOMBRvNoKvX/Cqvux+p0ln4Lw6RLCuWeB51o/DJWXw5GDTaoD+QthIUqHs5JVdQ2pw
	g8NKO/oQ7uOnUdjq3MLULxJOdEg==
X-Google-Smtp-Source: AGHT+IGle2jw1xd8dLQ862DWWobTWUfXHknafLz25LxA22r/5hTCow0Z0ePt+9doHwWtGNnn7+KGwQ==
X-Received: by 2002:a05:6871:7a16:b0:30b:ae56:576d with SMTP id 586e51a60fabf-314dce737c0mr2423251fac.29.1755899637328;
        Fri, 22 Aug 2025 14:53:57 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:fb40:1612:1e27:b18a])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-314f7a24047sm186723fac.9.2025.08.22.14.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 14:53:55 -0700 (PDT)
Date: Fri, 22 Aug 2025 16:53:50 -0500
From: Corey Minyard <corey@minyard.net>
To: Tony Hutter <hutter2@llnl.gov>
Cc: alok.a.tiwari@oracle.com, Bjorn Helgaas <helgaas@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, mariusz.tkaczyk@linux.intel.com,
	minyard@acm.org, linux-pci@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] PCI: Introduce Cray ClusterStor E1000 NVMe slot LED
 driver
Message-ID: <aKjm7mBDQ6VR8kWl@mail.minyard.net>
Reply-To: corey@minyard.net
References: <e5a6290a-7dc4-43b1-838d-bf43edae1faa@llnl.gov>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5a6290a-7dc4-43b1-838d-bf43edae1faa@llnl.gov>

On Fri, Aug 22, 2025 at 02:36:34PM -0700, Tony Hutter wrote:
> Add driver to control the NVMe slot LEDs on the Cray ClusterStor E1000.
> The driver provides hotplug attention status callbacks for the 24 NVMe
> slots on the E1000.  This allows users to access the E1000's locate and
> fault LEDs via the normal /sys/bus/pci/slots/<slot>/attention sysfs
> entries.  This driver uses IPMI to communicate with the E1000 controller
> to toggle the LEDs.
> 
> Signed-off-by: Tony Hutter <hutter2@llnl.gov>
> ---
> Changes in v4:
>  - Fix typo in Kconfig: "is it" ->  "it is"
>  - Rename some #defines to CRAYE1K_SUBCMD_*
>  - Use IS_ERR() check in craye1k_debugfs_init()
>  - Return -EIO instead of -EINVAL when LED value check fails
> 
> Changes in v3:
>  - Add 'attention' values in Documentation/ABI/testing/sysfs-bus-pci.
>  - Remove ACPI_PCI_SLOT dependency.
>  - Cleanup craye1k_do_message() error checking.
>  - Skip unneeded memcpy() on failure in __craye1k_do_command().
>  - Merge craye1k_do_command_and_netfn() code into craye1k_do_command().
>  - Make craye1k_is_primary() return boolean.
>  - Return negative error code on failure in craye1k_set_primary().
> 
> Changes in v2:
>  - Integrated E1000 code into the pciehp driver as an built-in
>    extention rather than as a standalone module.
>  - Moved debug tunables and counters to debugfs.
>  - Removed forward declarations.
>  - Kept the /sys/bus/pci/slots/<slot>/attention interface rather
>    than using NPEM/_DSM or led_classdev as suggested.  The "attention"
>    interface is more beneficial for our site, since it allows us to
>    control the NVMe slot LEDs agnostically across different enclosure
>    vendors and kernel versions using the same scripts.  It is also
>    nice to use the same /sys/bus/pci/slots/<slot>/ sysfs directory for
>    both slot LED toggling ("attention") and slot power control
>    ("power").
> ---
>  Documentation/ABI/testing/sysfs-bus-pci |  21 +
>  MAINTAINERS                             |   5 +
>  drivers/pci/hotplug/Kconfig             |  10 +
>  drivers/pci/hotplug/Makefile            |   3 +
>  drivers/pci/hotplug/pciehp.h            |   7 +
>  drivers/pci/hotplug/pciehp_core.c       |  12 +
>  drivers/pci/hotplug/pciehp_craye1k.c    | 659 ++++++++++++++++++++++++
>  7 files changed, 717 insertions(+)
>  create mode 100644 drivers/pci/hotplug/pciehp_craye1k.c
> 
...snip
> diff --git a/drivers/pci/hotplug/pciehp_craye1k.c b/drivers/pci/hotplug/pciehp_craye1k.c
> new file mode 100644
> index 000000000000..72c636ceb976
> --- /dev/null
> +++ b/drivers/pci/hotplug/pciehp_craye1k.c
> @@ -0,0 +1,659 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2022-2024 Lawrence Livermore National Security, LLC
> + */
> +/*
> + * Cray ClusterStor E1000 hotplug slot LED driver extensions
> + *
> + * This driver controls the NVMe slot LEDs on the Cray ClusterStore E1000.
> + * It provides hotplug attention status callbacks for the 24 NVMe slots on
> + * the E1000.  This allows users to access the E1000's locate and fault
> + * LEDs via the normal /sys/bus/pci/slots/<slot>/attention sysfs entries.
> + * This driver uses IPMI to communicate with the E1000 controller to toggle
> + * the LEDs.
> + *
> + * This driver is based off of ibmpex.c
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/delay.h>
> +#include <linux/errno.h>
> +#include <linux/dmi.h>
> +#include <linux/ipmi.h>
> +#include <linux/ipmi_smi.h>

You shouldn't need to include ipmi_smi.h.  If you do, that's a bug on my
part.

> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/pci_hotplug.h>
> +#include <linux/random.h>
> +#include "pciehp.h"
> +
...snip
> +/*
> + * craye1k_send_message() - Send the message already setup in 'craye1k'
> + *
> + * Context: craye1k->lock is already held.
> + * Return: 0 on success, non-zero on error.
> + */
> +static int craye1k_send_message(struct craye1k *craye1k)
> +{
> +	int rc;
> +
> +	rc = ipmi_validate_addr(&craye1k->address, sizeof(craye1k->address));
> +	if (rc) {
> +		dev_err_ratelimited(craye1k->dev, "validate_addr() = %d\n", rc);
> +		return rc;
> +	}
> +
> +	craye1k->tx_msg_id++;
> +
> +	rc = ipmi_request_settime(craye1k->user, &craye1k->address,
> +				  craye1k->tx_msg_id, &craye1k->tx_msg, craye1k,
> +				  0, craye1k->ipmi_retries,
> +				  craye1k->ipmi_timeout_ms);
> +
> +	if (rc) {
> +		craye1k->request_failed++;
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * craye1k_do_message() - Send the message in 'craye1k' and wait for a response
> + *
> + * Context: craye1k->lock is already held.
> + * Return: 0 on success, non-zero on error.
> + */
> +static int craye1k_do_message(struct craye1k *craye1k)
> +{
> +	int rc;
> +	struct completion *read_complete = &craye1k->read_complete;
> +	unsigned long tout = msecs_to_jiffies(craye1k->completion_timeout_ms);

I don't see anything that will prevent multiple messages from being sent
at one time.  What happens if two things send a message at the same time
here?

-corey

> +
> +	rc = craye1k_send_message(craye1k);
> +	if (rc)
> +		return rc;
> +
> +	rc = wait_for_completion_killable_timeout(read_complete, tout);
> +	if (rc == 0) {
> +		/* timed out */
> +		craye1k->completion_timeout++;
> +		return -ETIME;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * __craye1k_do_command() - Do an IPMI command
> + *
> + * Send a command with optional data bytes, and read back response bytes.
> + * Context: craye1k->lock is already held.
> + * Returns: 0 on success, non-zero on error.
> + */
> +static int __craye1k_do_command(struct craye1k *craye1k, u8 netfn, u8 cmd,
> +				u8 *send_data, u8 send_data_len, u8 *recv_data,
> +				u8 recv_data_len)
> +{
> +	int rc;
> +
> +	craye1k->tx_msg.netfn = netfn;
> +	craye1k->tx_msg.cmd = cmd;
> +
> +	if (send_data) {
> +		memcpy(&craye1k->tx_msg_data[0], send_data, send_data_len);
> +		craye1k->tx_msg.data_len = send_data_len;
> +	} else {
> +		craye1k->tx_msg_data[0] = 0;
> +		craye1k->tx_msg.data_len = 0;
> +	}
> +
> +	rc = craye1k_do_message(craye1k);
> +	if (rc == 0)
> +		memcpy(recv_data, craye1k->rx_msg_data, recv_data_len);
> +
> +	return rc;
> +}
> +
> +/*
> + * craye1k_do_command() - Do a Cray E1000 specific IPMI command.
> + * @cmd: Cray E1000 specific command
> + * @send_data:  Data to send after the command
> + * @send_data_len: Data length
> + *
> + * Context: craye1k->lock is already held.
> + * Returns: the last byte from the response or 0 if response had no response
> + * data bytes, else -1 on error.
> + */
> +static int craye1k_do_command(struct craye1k *craye1k, u8 cmd, u8 *send_data,
> +			      u8 send_data_len)
> +{
> +	int rc;
> +
> +	rc = __craye1k_do_command(craye1k, CRAYE1K_CMD_NETFN, cmd, send_data,
> +				  send_data_len, NULL, 0);
> +	if (rc != 0) {
> +		/* Error attempting command */
> +		return -1;
> +	}
> +
> +	if (craye1k->tx_msg.data_len == 0)
> +		return 0;
> +
> +	/* Return last received byte value */
> +	return craye1k->rx_msg_data[craye1k->rx_msg_len - 1];
> +}
> +
> +/*
> + * __craye1k_set_primary() - Tell the BMC we want to be the primary server
> + *
> + * An E1000 board has two physical servers on it.  In order to set a slot
> + * NVMe LED, this server needs to first tell the BMC that it's the primary
> + * server.
> + *
> + * Returns: 0 on success, non-zero on error.
> + */
> +static int __craye1k_set_primary(struct craye1k *craye1k)
> +{
> +	u8 bytes[2] = {CRAYE1K_SUBCMD_SET_PRIMARY, 1};	/* set primary to 1 */
> +
> +	craye1k->set_primary++;
> +	return craye1k_do_command(craye1k, CRAYE1K_CMD_PRIMARY, bytes, 2);
> +}
> +
> +/*
> + * craye1k_is_primary() - Are we the primary server?
> + *
> + * Returns: true if we are the primary server, false otherwise.
> + */
> +static bool craye1k_is_primary(struct craye1k *craye1k)
> +{
> +	u8 byte = 0;
> +	int rc;
> +
> +	/* Response byte is 0x1 on success */
> +	rc = craye1k_do_command(craye1k, CRAYE1K_CMD_PRIMARY, &byte, 1);
> +	craye1k->check_primary++;
> +	if (rc == 0x1)
> +		return true;   /* success */
> +
> +	craye1k->check_primary_failed++;
> +	return false;   /* We are not the primary server node */
> +}
> +
> +/*
> + * craye1k_set_primary() - Attempt to set ourselves as the primary server
> + *
> + * Returns: 0 on success, -1 otherwise.
> + */
> +static int craye1k_set_primary(struct craye1k *craye1k)
> +{
> +	int tries = 10;
> +
> +	if (craye1k_is_primary(craye1k)) {
> +		craye1k->was_already_primary++;
> +		return 0;
> +	}
> +	craye1k->was_not_already_primary++;
> +
> +	/* delay found through experimentation */
> +	msleep(300);
> +
> +	if (__craye1k_set_primary(craye1k) != 0) {
> +		craye1k->set_initial_primary_failed++;
> +		return -1;	/* error */
> +	}
> +
> +	/*
> +	 * It can take 2 to 3 seconds after setting primary for the controller
> +	 * to report that it is the primary.
> +	 */
> +	while (tries--) {
> +		msleep(500);
> +		if (craye1k_is_primary(craye1k))
> +			break;
> +	}
> +
> +	if (tries == 0) {
> +		craye1k->set_primary_failed++;
> +		return -1;	/* never reported that it's primary */
> +	}
> +
> +	/* Wait for primary switch to finish */
> +	msleep(1500);
> +
> +	return 0;
> +}
> +
> +/*
> + * craye1k_get_slot_led() - Get slot LED value
> + * @slot: Slot number (1-24)
> + * @is_locate_led: 0 = get fault LED value, 1 = get locate LED value
> + *
> + * Returns: slot value on success, -1 on failure.
> + */
> +static int craye1k_get_slot_led(struct craye1k *craye1k, unsigned char slot,
> +				bool is_locate_led)
> +{
> +	u8 bytes[2];
> +	u8 cmd;
> +
> +	bytes[0] = CRAYE1K_SUBCMD_GET_LED;
> +	bytes[1] = slot;
> +
> +	cmd = is_locate_led ? CRAYE1K_CMD_LOCATE_LED : CRAYE1K_CMD_FAULT_LED;
> +
> +	return craye1k_do_command(craye1k, cmd, bytes, 2);
> +}
> +
> +/*
> + * craye1k_set_slot_led() - Attempt to set the locate/fault LED to a value
> + * @slot: Slot number (1-24)
> + * @is_locate_led: 0 = use fault LED, 1 = use locate LED
> + * @value: Value to set (0 or 1)
> + *
> + * Check the LED value after calling this function to ensure it has been set
> + * properly.
> + *
> + * Returns: 0 on success, non-zero on failure.
> + */
> +static int craye1k_set_slot_led(struct craye1k *craye1k, unsigned char slot,
> +				unsigned char is_locate_led,
> +				unsigned char value)
> +{
> +	u8 bytes[3];
> +	u8 cmd;
> +
> +	bytes[0] = CRAYE1K_SUBCMD_SET_LED;
> +	bytes[1] = slot;
> +	bytes[2] = value;
> +
> +	cmd = is_locate_led ? CRAYE1K_CMD_LOCATE_LED : CRAYE1K_CMD_FAULT_LED;
> +
> +	return craye1k_do_command(craye1k, cmd, bytes, 3);
> +}
> +
> +static int __craye1k_get_attention_status(struct hotplug_slot *hotplug_slot,
> +					  u8 *status, bool set_primary)
> +{
> +	unsigned char slot;
> +	int locate, fault;
> +	struct craye1k *craye1k;
> +
> +	craye1k = craye1k_global;
> +	slot = PSN(to_ctrl(hotplug_slot));
> +
> +	if (set_primary) {
> +		if (craye1k_set_primary(craye1k) != 0) {
> +			craye1k->get_led_failed++;
> +			return -EIO;
> +		}
> +	}
> +
> +	locate = craye1k_get_slot_led(craye1k, slot, true);
> +	if (locate == -1) {
> +		craye1k->get_led_failed++;
> +		return -EIO;
> +	}
> +	msleep(CRAYE1K_POST_CMD_WAIT_MS);
> +
> +	fault = craye1k_get_slot_led(craye1k, slot, false);
> +	if (fault == -1) {
> +		craye1k->get_led_failed++;
> +		return -EIO;
> +	}
> +	msleep(CRAYE1K_POST_CMD_WAIT_MS);
> +
> +	*status = locate << 1 | fault;
> +
> +	return 0;
> +}
> +
> +int craye1k_get_attention_status(struct hotplug_slot *hotplug_slot,
> +				 u8 *status)
> +{
> +	int rc;
> +	struct craye1k *craye1k;
> +
> +	craye1k = craye1k_global;
> +
> +	if (mutex_lock_interruptible(&craye1k->lock) != 0)
> +		return -EINTR;
> +
> +	rc =  __craye1k_get_attention_status(hotplug_slot, status, true);
> +
> +	mutex_unlock(&craye1k->lock);
> +	return rc;
> +}
> +
> +int craye1k_set_attention_status(struct hotplug_slot *hotplug_slot,
> +				 u8 status)
> +{
> +	unsigned char slot;
> +	int tries = 4;
> +	int rc;
> +	u8 new_status;
> +	struct craye1k *craye1k;
> +	bool locate, fault;
> +
> +	craye1k = craye1k_global;
> +
> +	slot = PSN(to_ctrl(hotplug_slot));
> +
> +	if (mutex_lock_interruptible(&craye1k->lock) != 0)
> +		return -EINTR;
> +
> +	/* Retry to ensure all LEDs are set */
> +	while (tries--) {
> +		/*
> +		 * The node must first set itself to be the primary node before
> +		 * setting the slot LEDs (each board has two nodes, or
> +		 * "servers" as they're called by the manufacturer).  This can
> +		 * lead to contention if both nodes are trying to set the LEDs
> +		 * at the same time.
> +		 */
> +		rc = craye1k_set_primary(craye1k);
> +		if (rc != 0) {
> +			/* Could not set as primary node.  Just retry again. */
> +			continue;
> +		}
> +
> +		/* Write value twice to increase success rate */
> +		locate = (status & 0x2) >> 1;
> +		craye1k_set_slot_led(craye1k, slot, 1, locate);
> +		if (craye1k_set_slot_led(craye1k, slot, 1, locate) != 0) {
> +			craye1k->set_led_locate_failed++;
> +			continue;	/* fail, retry */
> +		}
> +
> +		msleep(CRAYE1K_POST_CMD_WAIT_MS);
> +
> +		fault = status & 0x1;
> +		craye1k_set_slot_led(craye1k, slot, 0, fault);
> +		if (craye1k_set_slot_led(craye1k, slot, 0, fault) != 0) {
> +			craye1k->set_led_fault_failed++;
> +			continue;	/* fail, retry */
> +		}
> +
> +		msleep(CRAYE1K_POST_CMD_WAIT_MS);
> +
> +		rc = __craye1k_get_attention_status(hotplug_slot, &new_status,
> +						    false);
> +
> +		msleep(CRAYE1K_POST_CMD_WAIT_MS);
> +
> +		if (rc == 0 && new_status == status)
> +			break;	/* success */
> +
> +		craye1k->set_led_readback_failed++;
> +
> +		/*
> +		 * At this point we weren't successful in setting the LED and
> +		 * need to try again.
> +		 *
> +		 * Do a random back-off to reduce contention with other server
> +		 * node in the unlikely case that both server nodes are trying to
> +		 * trying to set a LED at the same time.
> +		 *
> +		 * The 500ms minimum in the back-off reduced the chance of this
> +		 * whole retry loop failing from 1 in 700 to none in 10000.
> +		 */
> +		msleep(500 + (get_random_long() % 500));
> +	}
> +	mutex_unlock(&craye1k->lock);
> +	if (tries == 0) {
> +		craye1k->set_led_failed++;
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool is_craye1k_board(void)
> +{
> +	return dmi_match(DMI_PRODUCT_NAME, "VSSEP1EC");
> +}
> +
> +bool is_craye1k_slot(struct controller *ctrl)
> +{
> +	return (PSN(ctrl) >= 1 && PSN(ctrl) <= 24 && is_craye1k_board());
> +}
> +
> +int craye1k_init(void)
> +{
> +	if (!is_craye1k_board())
> +		return 0;
> +
> +	return ipmi_smi_watcher_register(&craye1k_smi_watcher);
> +}
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Tony Hutter <hutter2@llnl.gov>");
> +MODULE_DESCRIPTION("Cray E1000 NVMe Slot LED driver");
> -- 
> 2.43.7

