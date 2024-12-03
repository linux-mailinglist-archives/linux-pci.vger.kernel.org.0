Return-Path: <linux-pci+bounces-17605-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AE89E2F98
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 00:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEDF9B472AB
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 22:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF0A1F471E;
	Tue,  3 Dec 2024 22:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hhK5/zg4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QK96Kw7V"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8671DE4ED;
	Tue,  3 Dec 2024 22:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733264131; cv=none; b=fgyevD4iAWNduTZhdCiq5o/EpBGrW9ehj7tX5pigpnRh3skxsMARUnN2Pqa7y5fTFhqgAg255c93SAwbUKT8EHAXiCS1ueIsihg3loAZeRC3h4R80YkL+mBw77x3iZZmvgV+PgB/qwQ/2IlaCLEMFQE1diBDrTUv5fNTfGOMurs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733264131; c=relaxed/simple;
	bh=8XuFcFnDcJL7u534/BtVROTSEJaBWvv2JGMbPhdQamU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oR/MYK8RDjXltg8AGzDrPf7Tw7b81xjGXdXaFnV53M48XaVoLny3lMFYG60a0RpM9PpNEqsPY3CK9QzFRZ2toO24knkJYHpVBqC3M+rkf3zZHuNYPa958SEbId4yXut6x/Fx1vFcz0u44N7aAvqynCf7sNqAjzg0mp396btpV7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hhK5/zg4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QK96Kw7V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733264128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V31hYngk1/z1337VHAKio+Kr+AiCQmhz4fdflOnNyHU=;
	b=hhK5/zg48RnP9TlQD1XZ8GRUf0ubPSZc0uimaCTZhMJB9K3n0EYZ/habXisOdTLuJ4/Ebu
	ULYXH1pcMm1AIPQtiy3VOVladF0OFcPBKkJiuz3sGA9uOA/5Yaa6lYn+qT3deN89jRswvz
	YGuen/tbeJXoJ3WiRmVba7wN4nb9KhqRmK8kofSBBv0VRA3lsWlCise46i1sshKEDtbH/k
	lWlYskSKf9PcUEsA3b1JlGY5DjiQJPfaFu6xf7ONLqLchn98B8weJ9Or1FgWFD0LeWqgnP
	hjntlE76YzX5w/6s7L32IE0VmP0gNgd7i2TAnaXGxLroLqm9r4++t03JldGXog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733264128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V31hYngk1/z1337VHAKio+Kr+AiCQmhz4fdflOnNyHU=;
	b=QK96Kw7Ve+EsFrjOp0cfmyMGrsHCDxCkwE9Q653JhZorYo8ZHRQBnZfSL6vEIZuBI1nR6N
	7d6bqwDQqsn2pNCA==
To: Frank Li <Frank.Li@nxp.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Anup Patel <apatel@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>,
 dlemoal@kernel.org, maz@kernel.org, jdmason@kudzu.us, Frank Li
 <Frank.Li@nxp.com>
Subject: Re: [PATCH v9 2/6] PCI: endpoint: Add RC-to-EP doorbell support
 using platform MSI controller
In-Reply-To: <20241203-ep-msi-v9-2-a60dbc3f15dd@nxp.com>
References: <20241203-ep-msi-v9-0-a60dbc3f15dd@nxp.com>
 <20241203-ep-msi-v9-2-a60dbc3f15dd@nxp.com>
Date: Tue, 03 Dec 2024 23:15:27 +0100
Message-ID: <87v7w0s9a8.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Dec 03 2024 at 15:36, Frank Li wrote:
> +static void pci_epc_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> +{
> +	struct pci_epc *epc;
> +	struct pci_epf *epf;
> +
> +	epc = pci_epc_get(dev_name(msi_desc_to_dev(desc)));
> +	if (!epc)

This is wrong as pci_epc_get() never returns NULL on failure. It returns
an error pointer.

> +		return;
> +
> +	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);

How can the list be empty?

> +	if (epf && epf->db_msg && desc->msi_index < epf->num_db)
> +		memcpy(&epf->db_msg[desc->msi_index].msg, msg, sizeof(*msg));

So now the message is copied out into that db_msg array which is
somewhere in the memory which was allocated on the EP side.

How is the host side supposed to know about the change of the message?

This only works reliably if:

  1) the message address/data pair is immutable once it is set up and
     subsequent affinity changes are not affecting it

  2) The ordering on the EP driver is:

     request_irq()
     publish_msg_to_host()
     tell_host_that_message_is_ready()

#2 is a documentation problem, but #1 needs some thought.

It only works for MSI parent domains which use a translation table and
affinity changes only happen at the translation table level, which means
the address/data pair is unaffected.

Sure GIC-ITS, AMD/Intel remap domains work that way, but what happens if
the underlying MSI parent domain actually changes the message
(address/data pair) during an affinity change?

These domains expect that the message is known to the other side at the
time when irq_set_affinity() returns. In case of regular PCI/MSI this is
not a problem because the message is written to the device before the
function returns, but in this EP case nothing guarantees that the
modified message is host visible at that point.

The fact that a MSI parent domain supports DOMAIN_BUS_DEVICE_MSI does
not guarantee that the parent is translation table based.

As this is intended to be a generic library for all sorts of EP
implementations, there needs to be

  - either a mechanism to prevent the initialization if the underlying
    MSI parent domain does not provide immutable messages

  - or support for endpoint specific msi_write_msg() implementations

Thanks,

        tglx


