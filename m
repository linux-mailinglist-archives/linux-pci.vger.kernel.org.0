Return-Path: <linux-pci+bounces-18047-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 228A19EBA0A
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 20:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50C7167784
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 19:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5671D214227;
	Tue, 10 Dec 2024 19:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYOTZdqG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE4D214231;
	Tue, 10 Dec 2024 19:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858502; cv=none; b=HBzuwo2IchfxhRh/DspxcXCvmXnkODTmag4DUJnMuqCj/WNiO4VuI1DPsZlnYY55u81ULm0ZijunDqSxergXd9wVVPwZPoUDfRURbOrvP0sLXwFEjg1m0BSQ8XQ/kjlN/auI9U7Of/+TplhP0rQrL6Cz8LilgW/i1Ar9kshMR70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858502; c=relaxed/simple;
	bh=230wSQ1wYeQaQouNCrsTwnLI6v3KuSOxEyYSkJf45H8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PPE7Fvo40lj89bt+oorzw3rvx4vcE8uNzFsvZJz1O+qyrG2xyppaXYy5oeKW9oGQPnz8r3zeLMZ3vSElRAlfQN0mAz3t1SPkXU+hN1hNnwzoS/bflo9K3mKupg4ZSZ+xPgbG2Ldg6ohWXmHZqQO5jojvK7v3oQhaRk7a6QEVFao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYOTZdqG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8707DC4CED6;
	Tue, 10 Dec 2024 19:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733858501;
	bh=230wSQ1wYeQaQouNCrsTwnLI6v3KuSOxEyYSkJf45H8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JYOTZdqGXDurHfjZ7OK1P+GAUVX34qsCrNS8oivNtlGejwYDeUFmMEc9xo+YQ/Dhc
	 UGKqBr5ljQq6FmLcAm7rCZOlDcB8BGiY7/pwDt1e5Og2jXsXuTxm9vSgfdCpZygmMH
	 GwDNAoOwOfIke227UPl0OE15smllVujQUUim5PO55h5mr3cc5Lo0VW6RTCLwe09M7+
	 M4+7C5LV5pWvzf4wrKmJeVdp98afINhGjG/LH/dCB9b6+RPUbTbQ0XO5nXleH8sajv
	 IVSjUpzwZewG5S5ZmEiv8YRfuvLbYK54ezUlOhvT0/H0xpvgvhowHB1MEux1bg8Gba
	 c1hSuC4UTp+xQ==
Date: Tue, 10 Dec 2024 13:21:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, Lukas Wunner <lukas@wunner.de>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 07/11] PCI: Add PCIe Device 3 Extended Capability
 enumeration
Message-ID: <20241210192140.GA3079633@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173343743678.1074769.15403889527436764173.stgit@dwillia2-xfh.jf.intel.com>

On Thu, Dec 05, 2024 at 02:23:56PM -0800, Dan Williams wrote:
> PCIe 6.2 Section 7.7.9 Device 3 Extended Capability Structure,
> enumerates new link capabilities and status added for Gen 6 devices. One
> of the link details enumerated in that register block is the "Segment
> Captured" status in the Device Status 3 register. That status is
> relevant for enabling IDE (Integrity & Data Encryption) whereby
> Selective IDE streams can be limited to a given requester id range
> within a given segment.

s/requester id/Requester ID/ to match spec usage

> +++ b/include/uapi/linux/pci_regs.h
> @@ -749,6 +749,7 @@
>  #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
>  #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
>  #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
> +#define PCI_EXT_CAP_ID_DEV3	0x2F	/* Device 3 Capability/Control/Status */

It doesn't look like lspci knows about this; is there something in
progress to add that?

https://git.kernel.org/pub/scm/utils/pciutils/pciutils.git/tree/lib/header.h?id=v3.13.0#n257

>  #define PCI_EXT_CAP_ID_IDE	0x30    /* Integrity and Data Encryption */
>  #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_IDE

