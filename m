Return-Path: <linux-pci+bounces-13740-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C991798E72D
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 01:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 935F82864F2
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 23:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8B11991C9;
	Wed,  2 Oct 2024 23:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="L5ZbTv/f"
X-Original-To: linux-pci@vger.kernel.org
Received: from dormouse.elm.relay.mailchannels.net (dormouse.elm.relay.mailchannels.net [23.83.212.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FECA194A6C
	for <linux-pci@vger.kernel.org>; Wed,  2 Oct 2024 23:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.83.212.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727912389; cv=fail; b=j7OpSWWJ2SH2qlfRjg+xmHVLlzQjnBtrVsBe8RUcCh4uyAp0kwGIumM/q3dp7NkDvNW0GfGse3Z/HaGJ+FfUFx+UNhy1GzcI+b6VAzhJB3KlsH2LZyCRVkgs6czqzwUENXdFYhrrRai2gbB0sck78u+m0I2NtjlO2HOOHJ9XXoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727912389; c=relaxed/simple;
	bh=yyDkFWFCGRwoA97mjo8B81Y5PAE8y0/1JZAimepb72o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StGBOCJuL5p/9RJ4zydEYfOYOrbDQ9xGNX+vTAXItoxOPHAcfTBFrDfU+xwPXQn7eRuiLlLyS21CB67V+SZXBl/zo2O5zXsnzZSE9ECiEhiRxNcEf1BnpboyJdXEfiJZQ3F6Mhe7zW0WXYEYykwMQgkPhyVjODwAvS/VNYJ/R1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=L5ZbTv/f; arc=fail smtp.client-ip=23.83.212.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 61BC17815E7;
	Wed,  2 Oct 2024 23:39:41 +0000 (UTC)
Received: from pdx1-sub0-mail-a289.dreamhost.com (100-96-80-58.trex-nlb.outbound.svc.cluster.local [100.96.80.58])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id AE3C97816D8;
	Wed,  2 Oct 2024 23:39:40 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1727912380; a=rsa-sha256;
	cv=none;
	b=adJyIE9toxwy61XccVzB0EBwcZZKtMOANQo3n98964KDAva10yqfOUU0Kp96E9lI9tXDTS
	CTQjuyEMDBgYrCsufWMtBM9p6AdoXlMMoArsO1GUdPMX6AUIulZPjMfnhwaTHT1u4M40oZ
	19nUHJHL87q7jKlIr9LicMYSWideJyjDbw+PmLXgyJd5bo53dJ5St1E6g9qh+gjAjCI7jk
	G03I0rkA6kAkQ5qenvh7/SUOjJlOETKKL0gL8ygVkG00QC17MhlpfDMbIU9mQ/Ux3PM/hm
	HWP9+DfC4wKLPcdH9CgxrRA6pG03u1HzC2/IdVCOS52QZzsTQf/dW2D9ocva4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1727912380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=H4JgY3mFduhtpdkdU57Vekw8/3/9HZt2EnrJa2V84CA=;
	b=riGPyBgxj+aEuOyCLVPGHE+JPpCUkJLYbnyUfx5XQB0A83RBLLvoo+7efyFSp7pJwqIWgy
	w3W8KJ9ebZ4QSJfrug5m8pPgHJkyt4uPlIgxP8Fw3jscJ7R9RCF2zA81mOiMMzrNr8pnP3
	nq5X+3RwA+4ZyWkDp2isvbxFJxKuXMte5/ObcldmT7bJl60JMAf3OZuYHCj36wZ/8s8hYl
	e57b1W7Lfj2hc5T/UDy0iiPUTBIXoUMFbCR4rG8VTm+IyIWwTh9G++H/c0Xds9qJ3Zv+v4
	incBDrLN/NZnmBiejg8yVX4ALOvFU5C4IeILZ+No/SIZC9ngVW9GnELk0D+Dmw==
ARC-Authentication-Results: i=1;
	rspamd-84548c8bbb-9dvp4;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Plucky-Shelf: 4d645d2355b32930_1727912381160_952955500
X-MC-Loop-Signature: 1727912381160:530231767
X-MC-Ingress-Time: 1727912381160
Received: from pdx1-sub0-mail-a289.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.80.58 (trex/7.0.2);
	Wed, 02 Oct 2024 23:39:41 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a289.dreamhost.com (Postfix) with ESMTPSA id 4XJrrD1mhJz3X;
	Wed,  2 Oct 2024 16:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1727912380;
	bh=KC0iy2oFha/BFUYJ9sXsmjEoQXkJCGGJaax+kH7w9/0=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=L5ZbTv/f9DDWSRuYOv8F6AsfgjL+q8+B6xmLv54T3nSTunTg6TUtcP4p61We3gQoM
	 adwYOM4x9DAbixBIM8mERtzQVAHy/3mETleFm35KmYDN3SUnKOe+LpY9c/su1eQLs/
	 s+8dCOtqCn4E7qhwKU8mmKdfIbtaUBwjQU7mssf/+TuZhePc8U7NLfuFcBjCBQ+I5q
	 HU0yyc16FkRlfiiQ3aiU1aaqTl5mKByuwYO4QWjcaSwlf+s9PVvr9KHdcXzKJVPTg1
	 5emYI7UrLj4rGK8dmsCX0oviJMY1xX6xO1xfMvBGIpgNysmM41uUv6m3aSvDrGw8q+
	 27Zh6yLKobWlQ==
Date: Wed, 2 Oct 2024 16:39:37 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Keith Busch <kbusch@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCHv2 1/5] pci: make pci_stop_dev concurrent safe
Message-ID: <20241002233937.jvudgfhxjqbspq6n@offworld>
References: <20240827192826.710031-1-kbusch@meta.com>
 <20240827192826.710031-2-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240827192826.710031-2-kbusch@meta.com>
User-Agent: NeoMutt/20220429

On Tue, 27 Aug 2024, Keith Busch wrote:

>diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
>index 55c8536860518..e41dfece0d969 100644
>--- a/drivers/pci/bus.c
>+++ b/drivers/pci/bus.c
>@@ -348,7 +348,7 @@ void pci_bus_add_device(struct pci_dev *dev)
>	if (retval < 0 && retval != -EPROBE_DEFER)
>		pci_warn(dev, "device attach failed (%d)\n", retval);
>
>-	pci_dev_assign_added(dev, true);
>+	pci_dev_assign_added(dev);
>
>	if (dev_of_node(&dev->dev) && pci_is_bridge(dev)) {
>		retval = of_platform_populate(dev_of_node(&dev->dev), NULL, NULL,
>diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>index 0e9b1c7b94a5a..802f7eac53115 100644
>--- a/drivers/pci/pci.h
>+++ b/drivers/pci/pci.h
>@@ -444,9 +444,14 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
> #define PCI_DPC_RECOVERED 1
> #define PCI_DPC_RECOVERING 2
>
>-static inline void pci_dev_assign_added(struct pci_dev *dev, bool added)
>+static inline void pci_dev_assign_added(struct pci_dev *dev)
> {
>-	assign_bit(PCI_DEV_ADDED, &dev->priv_flags, added);
>+	set_bit(PCI_DEV_ADDED, &dev->priv_flags);
>+}

So set_bit does not imply any barriers. Does this matter in the future
when breaking up pci_rescan_remove_lock? For example, what prevents
things like:

pci_bus_add_device()			pci_stop_dev()
     pci_dev_assign_added()
	dev->priv_flags [S]
					    pci_dev_test_and_clear_added() // true
						dev->priv_flags [L]
     device_attach(&dev->dev)
					    device_release_driver(&dev->dev)

... I guess that implied barrier from that device_lock() in device_attach().
I am not familiar with this code, but overall I think any locking rework should
explain more about the ordering implications in the changes if the end result
is finer grained locking.

Thanks,
Davidlohr

