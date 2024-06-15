Return-Path: <linux-pci+bounces-8858-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93460909869
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jun 2024 15:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 488751F224FD
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jun 2024 13:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B6145C1C;
	Sat, 15 Jun 2024 13:05:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0251B285;
	Sat, 15 Jun 2024 13:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718456735; cv=none; b=jFtJ7a7sEpMqazBLItNP8mVizp7/Q4K7fNnjp6rgqN5ucuyff2c8ak4HakIsZY20B2uVheisSKBhvvZO+ZuhXVGyo+cdgk7QqkiN98eFPymftkO30PxFRTtrFdKrcBqIeEgudZGZ3aSl7ASj9861mOTC6zKmeK/IOnqYZUSvy4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718456735; c=relaxed/simple;
	bh=PxvYVUDmSnJy5C0v0jn32DnB33DAEZOJYRfL5ECT/Qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epXA1qU8NRftWJBmNNCTT2YoLHQpSPUXtUlBDjbbBmumL+5b/lEqi10psThKXsg2+Rp7wQBzjeAXqDbNv1zsZdbhHuXMgRAc4OOahEcOJ4R2lrETftXCnL1nsweAwzqVE0rGHYtiZZUx5g/oyd8Czn24sBP7c64yQRzDyi48k4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 576F33000D7C9;
	Sat, 15 Jun 2024 15:05:29 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 3D6E62EE137; Sat, 15 Jun 2024 15:05:29 +0200 (CEST)
Date: Sat, 15 Jun 2024 15:05:29 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Alistair Francis <alistair23@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com, alex.williamson@redhat.com,
	christian.koenig@amd.com, kch@nvidia.com,
	gregkh@linuxfoundation.org, logang@deltatee.com,
	linux-kernel@vger.kernel.org, chaitanyak@nvidia.com,
	rdunlap@infradead.org, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v11 3/4] PCI/DOE: Expose the DOE features via sysfs
Message-ID: <Zm2RmWnSWEEX8WtV@wunner.de>
References: <20240614001244.925401-1-alistair.francis@wdc.com>
 <20240614001244.925401-3-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614001244.925401-3-alistair.francis@wdc.com>

On Fri, Jun 14, 2024 at 10:12:43AM +1000, Alistair Francis wrote:
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
[...]
> +#ifdef CONFIG_SYSFS
> +static ssize_t doe_discovery_show(struct device *dev,
> +				  struct device_attribute *attr,
> +				  char *buf)
> +{
> +	return sysfs_emit(buf, "0001:00\n");
> +}
> +DEVICE_ATTR_RO(doe_discovery);

If you want to use "0001:00" as filename but can't because
"0001:00_show()" would not be a valid function name in C,
I think there's no harm in manually expanding the macro to:

struct device_attribute dev_attr_doe_discovery = \
	__ATTR(0001:00, 0444, pci_doe_sysfs_feature_show, NULL);

That also avoids the need to have an extra doe_discovery_show()
function.

Intuitively, when I saw there's a "doe_discovery" attribute,
my first thought was: "Oh maybe I need to write something there
to (re-)initiate DOE discovery?"


> +static umode_t pci_doe_features_sysfs_attr_visible(struct kobject *kobj,
> +						   struct attribute *a, int n)
> +{
> +	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
> +	struct pci_doe_mb *doe_mb;
> +	unsigned long index, j;
> +	unsigned long vid, type;
> +	void *entry;
> +
> +	xa_for_each(&pdev->doe_mbs, index, doe_mb) {
> +		xa_for_each(&doe_mb->feats, j, entry) {
> +			vid = xa_to_value(entry) >> 8;
> +			type = xa_to_value(entry) & 0xFF;
> +
> +			if (vid == 0x01 && type == 0x00) {

Wherever possible, PCI_VENDOR_ID_PCI_SIG and PCI_DOE_PROTOCOL_DISCOVERY
macros should be used in lieu of 0x0001 and 0x00.

> +				/*
> +				 * This is the DOE discovery protocol
> +				 * Every DOE instance must support this, so we
> +				 * give it a useful name.
> +				 */
> +				return a->mode;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}

I agree with Jonathan that at first glance one would assume that
this function just always returns a->mode.


> +static bool pci_doe_features_sysfs_group_visible(struct kobject *kobj)
> +{
> +	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
> +	struct pci_doe_mb *doe_mb;
> +	unsigned long index;
> +
> +	xa_for_each(&pdev->doe_mbs, index, doe_mb) {
> +		if (!xa_empty(&doe_mb->feats))
> +			return true;
> +	}
> +
> +	return false;

So in principle, doe_mb->feats should never be empty because the
discovery protocol is always supported, right?  Wouldn't it then
suffice to just check for:

+	if (!xa_empty(&pdev->doe_mbs))
+		return true;

Or alternatively:

+	return !xa_empty(&pdev->doe_mbs);

Thanks,

Lukas

