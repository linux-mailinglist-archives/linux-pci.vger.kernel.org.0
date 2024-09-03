Return-Path: <linux-pci+bounces-12705-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3340B96ABFC
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 00:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCEB5281238
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 22:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBBB126C16;
	Tue,  3 Sep 2024 22:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gke3Wjn5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157221EBFE4;
	Tue,  3 Sep 2024 22:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725401902; cv=none; b=T+fb1Fx0mGEaAj0deCQixlfQZRGUeMGmLJidi1bbjrxAtrXK0CYK/C4f8ukCJcFsFUP88fF9V2FKeGSPLO9pOIv1oi99g5RBKs8T3Iihm6Bu+CRATCuScTPbQdySt2I3vu3Tr4oVyPvMvx3mQY3kdZkxMz5cHSrXbFHpjnp/ojs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725401902; c=relaxed/simple;
	bh=ofGtKLeOINGZt+upXE0xfK5KYPswpVR/C0fqSZ1f660=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=f5SMD6sBdLbfBxgsh/YbaCckMUDuAkMpzykBiEaeWhg0JCt+SMRa/SEbOaiLYtpXubSyOVFiZ2mhkI8hHAWuWnBj4U+cXOZ/8Dh8zNisp6cKH6moUyMt4kBhJr72+G1nq8XK3K/wuWj/SsTjAbNaDEtO5+894yAeTBkMpix3GdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gke3Wjn5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A706DC4CEC4;
	Tue,  3 Sep 2024 22:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725401901;
	bh=ofGtKLeOINGZt+upXE0xfK5KYPswpVR/C0fqSZ1f660=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gke3Wjn5dqoKGbiIjlmeVKG/Uji8+RsT/iTji1DWda8O2EOneTnCfE9IYIQBE3xLL
	 9Hq23w02oVgePst9seHWNuObDevufpAOqki9LRTc9SsIa7fLr5xfcQcaBsfKdxZ7LQ
	 9b3Ah99gYGoaOd5srztlbqgm/o+tDoYmvGiyKrV+Pd/2/Ln8GnNHkVKEdOswfPoUFf
	 MtjadBFzjSmGfp7fMtkg1K8GFtVkHQH2VZJQdqwsdeTeoo08EuFz0qBl7R5fng2e+q
	 0GCeKDKBBdXZhRUJKSrnnpJ+dQtdqy+KmM9GbXqKMd283c0QSE78kIyWL/zN37r7aC
	 0CHE2RsDryp0A==
Date: Tue, 3 Sep 2024 17:18:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tony Hutter <hutter2@llnl.gov>
Cc: bhelgaas@google.com, minyard@acm.org, linux-pci@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Introduce Cray ClusterStor E1000 NVMe slot LED
 driver
Message-ID: <20240903221820.GA26364@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40c7776f-b168-4cbe-a352-122e56fe7b31@llnl.gov>

On Tue, Aug 27, 2024 at 02:03:48PM -0700, Tony Hutter wrote:
> Add driver to control the NVMe slot LEDs on the Cray ClusterStor E1000.
> The driver provides hotplug attention status callbacks for the 24 NVMe
> slots on the E1000.  This allows users to access the E1000's locate and
> fault LEDs via the normal /sys/bus/pci/slots/<slot>/attention sysfs
> entries.  This driver uses IPMI to communicate with the E1000 controller to
> toggle the LEDs.

I hope/assume the interface is the same as one of the others, i.e.,
the existing one added for NVMe behind VMD by
https://git.kernel.org/linus/576243b3f9ea ("PCI: pciehp: Allow
exclusive userspace control of indicators") or the new one for NPEM
and the _DSM at
https://lore.kernel.org/linux-pci/20240814122900.13525-3-mariusz.tkaczyk@linux.intel.com/

I suppose we intend that the ledmon utility will be able to drive
these LEDs?  Whatever the user, we should try to minimize the number
of different interfaces for this functionality.

A few minor random comments from a quick look below.

> +config HOTPLUG_PCI_PCIE_CRAY_E1000
> +	tristate "PCIE Hotplug extensions for Cray ClusterStor E1000"

s/PCIE/PCIe/

> +static ssize_t craye1k_show(struct kobject *kobj, struct kobj_attribute *kattr,
> +			    char *buf);
> +static ssize_t craye1k_store(struct kobject *kobj, struct kobj_attribute *kattr,
> +			     const char *buf,
> +			     size_t count);
> +static void craye1k_new_smi(int iface, struct device *dev);
> +static void craye1k_smi_gone(int iface);
> +static void craye1k_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data);

Is it possible to reorder the function implementations such that these
forward declarations are not needed?  That's the typical Linux style, so
that ordering will be more familiar to readers.

> +static atomic64_t *craye1k_lookup_stat(struct kobject *kobj, const char *name)
> +{
> +	struct craye1k *craye1k;
> +	struct device *dev;
> +	int i;
> +
> +	/* Lookup table for name -> atomic64_t offset */
> +	const struct {
> +		const char *name;
> +		size_t offset;
> +	} table[] = {
> +		CRAYE1K_TABLE(check_primary),
> +		CRAYE1K_TABLE(check_primary_failed),
> +		CRAYE1K_TABLE(was_already_primary),
> +		CRAYE1K_TABLE(was_not_already_primary),
> +		CRAYE1K_TABLE(set_primary),
> +		CRAYE1K_TABLE(set_initial_primary_failed),
> +		CRAYE1K_TABLE(set_primary_failed),
> +		CRAYE1K_TABLE(set_led_locate_failed),
> +		CRAYE1K_TABLE(set_led_fault_failed),
> +		CRAYE1K_TABLE(set_led_readback_failed),
> +		CRAYE1K_TABLE(set_led_failed),
> +		CRAYE1K_TABLE(get_led_failed),
> +		CRAYE1K_TABLE(completion_timeout),
> +		CRAYE1K_TABLE(wrong_msgid),
> +		CRAYE1K_TABLE(request_failed)
> +	};

Looks like possibly this table could be static instead of being on the
stack?

> + * __craye1k_set_primary() - Tell the BMC we want to be the primary server
> + *
> + * An E1000 board has two physical servers on it.  In order to set a slot
> + * NVMe LED, this server needs to first tell the BMC that it's the primary
> + * server.
> + *
> + * Returns: 0 on success, 1 otherwise.
> + */
> +

Spurious blank line.

> +static int __craye1k_set_primary(struct craye1k *craye1k)

> + * craye1k_is_primary() - Are we the primary server?
> + *
> + * Returns: 1 if we are the primary server, 0 otherwise.
> + */
> +static int craye1k_is_primary(struct craye1k *craye1k)
> +{
> +	u8 byte = 0;
> +	int rc;
> +
> +	/* Response byte is 0x1 on success */
> +	rc = craye1k_do_command(craye1k, CRAYE1K_CMD_PRIMARY, &byte, 1);
> +	atomic64_inc(&craye1k->check_primary);
> +	if (rc == 0x1)
> +		return 1;   /* success */
> +
> +	atomic64_inc(&craye1k->check_primary_failed);
> +	return 0;   /* We are not the primary server node */
> +}
> +
> +/*
> + * craye1k_set_primary() - Attempt to set ourselves as the primary server
> + *
> + * Returns: 0 on success, 1 otherwise.

Maybe return a negative error value like -EIO for failure?  Then the
caller can simply pass that return value up.  Same for
__craye1k_set_primary().

> +	 * We know that our attention status callback functions have been swapped
> +	 * into the PCI device's hotplug_slot->ops values.  We can use that
> +	 * knowledge to lookup our craye1k.
> +	 *
> +	 * To do that, we use the current hotplug_slot->ops value, which is going
> +	 * to be one of the entries in craye1k->ops[], and offset our slot number
> +	 * to get the address of craye1k->ops[0].  We then use that with
> +	 * container_of() to get craye1k.  Slots start at 1, so account for that.

99% of this file fits in 80 columns.  This and one or two other
comments use 81, which seems like a random width.  Can you reflow
these to fit in 80?

> +static int __craye1k_get_attention_status(struct hotplug_slot *hotplug_slot,
> +					  u8 *status, bool set_primary)
> +{
> +	unsigned char slot;
> +	int locate, fault;
> +	int rc = 0;
> +	struct craye1k *craye1k;
> +
> +	slot = PSN(to_ctrl(hotplug_slot));
> +	if (!(slot >= 1 && slot <= 24)) {
> +		rc = -EINVAL;
> +		goto out;

There's no cleanup at "out", so drop the "rc" and the label, use
"return -EINVAL/-EIO/etc " directly here, and then "return 0" at the
end.

> +	}
> +
> +	craye1k = craye1k_from_hotplug_slot(hotplug_slot);
> +
> +	if (set_primary) {
> +		if (craye1k_set_primary(craye1k) != 0) {
> +			rc = -EIO;
> +			goto out;
> +		}
> +	}
> +
> +	locate = craye1k_get_slot_led(craye1k, slot, true);
> +	if (locate == -1) {
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +
> +	fault = craye1k_get_slot_led(craye1k, slot, false);
> +	if (fault == -1) {
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (rc != 0)
> +		atomic64_inc(&craye1k->get_led_failed);
> +
> +	*status = locate << 1 | fault;
> +
> +out:
> +	return rc;
> +}

