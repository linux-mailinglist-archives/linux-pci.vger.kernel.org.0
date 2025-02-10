Return-Path: <linux-pci+bounces-21099-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 393E9A2F558
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 18:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06E573A2015
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 17:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449D024FBE9;
	Mon, 10 Feb 2025 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smii7riq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2CD256C99;
	Mon, 10 Feb 2025 17:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739208825; cv=none; b=Qy4eYf8JaxQMMmwWNvEfA2BcVaHV5FcAOJ7d2b51LQ/mxAFGcgvCJXxOiBzt5BtOBIE61eaFe+LsXXOLszpJMcX+4rVUeJxe8M/ThvgGphkf2zpPSXkd2wuVgglqnQu/Vhvbex+POSrD3bY7sjJz6UOs5rbYHnvbY03Me9ljVJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739208825; c=relaxed/simple;
	bh=tO3Guscc95WPFoPROdLzEo457HPxMwe9CZi05WokzcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VDUBrS+bV41GDdzB7uefNkjrBavPmAoxRLymZv/UsKMMPJGKqsQPtIKdnHc7ElRLcpbaaWg6FagVSY/BrMVAnU7k1l7B0DAUYUczzzA02J/S5aT7VTakbCwpaZ+TVWGD/zwptDsZdHFn/hXNeDi9Bz/Pup2f8tn4BTXMWVU3weM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smii7riq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95167C4CED1;
	Mon, 10 Feb 2025 17:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739208824;
	bh=tO3Guscc95WPFoPROdLzEo457HPxMwe9CZi05WokzcQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=smii7riqpQ0quJWcaR8DagaVTQl4m8sJxmVpsmu2v5erGuohuBjfWEXDFimCiV4IB
	 iqMxaM+u0Inp0o60xdecaUa7qZVM/CcNfDEsesFHG4GiZ7zJW8E53gfz3eXWGze98p
	 Z9xp4DtnAy74f/fUrlZKnAzgC0SXBWrBlodYMCcRm4o+/gG3GtvitQ3mQa0VGq2eFt
	 ccJ4KMq7KtpjSJc/QgglNQ+aF6QEXnzOQPOuH5xy8WKkZDlzPa2PMxphvWzeBKmKj/
	 5njoVUsfy7bXU76SFpNyvzEbWy/nHSoEaxd5cHmN774A67y/Yh7xZWyMBBTAyiNh9i
	 luEb9jlGd+YdQ==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3f3ac204922so1041184b6e.3;
        Mon, 10 Feb 2025 09:33:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUW3TQ4KrlJGz5JKZx1ExFZzpPySoo8ba2JpXrH4iiHZpMIVxhNkp7sksluxcRezVuOz4B3a/qO1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxwHbpP3gkDpX31JyCowwOpbUnyzNKObLtXLS8Cug51MUwPn9Ew
	nrIkL1GlI5+k09XweV1K2KB+DnxooosoJAaQs4V3Q+B2K6Hb14JhV4IMWTifLTLgG22Nwz906h6
	fMCG2FDuuG/n5fANRlzVxTsfa2kc=
X-Google-Smtp-Source: AGHT+IE4+tNyo58Hej1ysA+6WihZxi9pGZgdElcv3voHwVJOtvmf9hLcR8nfz3bWVVrpNL/lxvM593rePdphS0WDNTg=
X-Received: by 2002:a05:6808:3505:b0:3ea:64cc:4954 with SMTP id
 5614622812f47-3f392363e82mr10737868b6e.35.1739208823861; Mon, 10 Feb 2025
 09:33:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210170715.GA8877@bhelgaas>
In-Reply-To: <20250210170715.GA8877@bhelgaas>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 10 Feb 2025 18:33:31 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gN=Go7kg=hhEDCpOhbw7H0hQYow_TW7G1wZRXs4jAkVA@mail.gmail.com>
X-Gm-Features: AWEUYZn0aWcI97OmZ0wFIN8JAXg0-n1SY20MXJeZSglqp7KG0irQCVz9tPQ8jak
Message-ID: <CAJZ5v0gN=Go7kg=hhEDCpOhbw7H0hQYow_TW7G1wZRXs4jAkVA@mail.gmail.com>
Subject: Re: [bugzilla-daemon@kernel.org: [Bug 219765] New: Regression: VFIO
 NVIDIA GPU Passthrough Fails in Linux 6.13.0 (GPU Reset & Audio Controller Disappears)]
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, 
	linux-pm@vger.kernel.org, regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 6:07=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=3D219765
>
> I don't see an obvious culprit between v6.12 and v6.13, suggested
> bisection if possible.
>
> Workaround: boot with pcie_port_pm=3Doff
>
> Given the workaround, maybe it's worth trying a revert of this:
>
>   dc421bb3c0db ("PCI: Enable runtime PM of the host bridge")

I would ask the reporter to revert it and see if that helps.

The

vfio-pci 0000:01:00.1: Unable to change power state from D0 to D3hot,
device inaccessible

message in the failing case is kind of unexpected.

Overall, it would be good to understand what's going on so we don't
miss an opportunity to fix something.

> ----- Forwarded message from bugzilla-daemon@kernel.org -----
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D219765
>
> Created attachment 307599
>   --> https://bugzilla.kernel.org/attachment.cgi?id=3D307599&action=3Dedi=
t
> dmesg logs for the kernel in which gpu passthrough works
>
> After upgrading from Linux 6.12.10 to Linux 6.13.0, VFIO GPU passthrough =
fails
> for an NVIDIA GPU (AD107). The GPU is not passed through to the VM, and i=
ts
> audio device (01:00.1) disappears from Virt-Manager. This issue does not =
occur
> in Linux 6.12.10.
>
> I have attached the logs.
>

