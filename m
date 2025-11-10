Return-Path: <linux-pci+bounces-40766-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62144C49304
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 21:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441C018812A5
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 20:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5925D33F8A1;
	Mon, 10 Nov 2025 20:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yxlk29Eb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C4F33F39C
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 20:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762805201; cv=none; b=R//jKm9/EjlwGrHUEO5zhP9MsAGFodgCYBYVw7L+46ENPUQcdJiIcJ2pwv2/xRVaQDid0JYYViSftbMGySsC4ehPeVEqTpxg0nUC4Ecxn0sLDXXk3jcI3WYHe0wrtUAQrXg/D6qqVVIi/vAKUYKo6TrTafc8iHRfZcV0qo5TZAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762805201; c=relaxed/simple;
	bh=YQvkilVeX7KE92tb/5qyPZuA6JRO5mhDSze3Le3Wwso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZO9m7Z0P33KN2VWi0wUUEgz72IrTWvxkXJfPZpDAFB+CI5JutLCQZ0yURNf78UhvDFHjkMtsB0KlnHY6TYy/MHhgtv1yTnEBTeIsuoHC8N2KrkIkyAKBsdzliU44kmFx6aeO/AUs+YOlRuBeqlpdPduYo59B7NHIRV/aZPoeqpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yxlk29Eb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E322C19421;
	Mon, 10 Nov 2025 20:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762805200;
	bh=YQvkilVeX7KE92tb/5qyPZuA6JRO5mhDSze3Le3Wwso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yxlk29EbBrKT+5FKxnOEkk3Tb5f2y+2plLLV02OQ5PkS7Y4GGcB9Az348MhYEcaoB
	 qQKPNXh76BCzJ2lXmQ2YyBhQ60i+bDrMFW+57DFc3JhzSXzu+S7oN0kN8fknsBYWXH
	 rWy68CNN34Vkyv/YUMXWigc/URk6Zg0XhS23pWXH0FiCdLMLMDhwlnbaiRBlrTKLj6
	 s3NMHzF3af+PG9DxXi8DiboWJtrIZKXHDGfYGstQN7rsdcIDCSn1dQGuGvkFxA5rxK
	 4i0LNQC3j3NRnoQFh1fRIJ6VJ1RDjKSXOi68W7QqrKnlTkYPVeGDP3LmLZxWAxJLN9
	 wivGlZWxctn9w==
Date: Mon, 10 Nov 2025 21:06:36 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Mahesh Vaidya <mahesh.vaidya@altera.com>
Cc: joyce.ooi@intel.com, linux-pci@vger.kernel.org,
	subhransu.sekhar.prusty@altera.com,
	krishna.kumar.simmadhari.ramadass@altera.com,
	nanditha.jayarajan@altera.com, Hans Zhang <18255117159@163.com>
Subject: Re: [PATCH] PCI: pcie-altera: Set MPS to MPSS on Agilex 7 Root Ports
Message-ID: <aRJFzI-VCqDeEqTN@ryzen>
References: <20251110170045.16106-1-mahesh.vaidya@altera.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110170045.16106-1-mahesh.vaidya@altera.com>

Hello Mahesh,

On Mon, Nov 10, 2025 at 09:00:45AM -0800, Mahesh Vaidya wrote:
> The Altera Agilex 7 Root Port (RP) defaults its Device Control
> (DEVCTL) register's MPS setting to 128 bytes upon power-on.
> When the kernel's PCIe core enumerates the bus (using the default
> PCIE_BUS_DEFAULT policy), it observes this 128-byte current setting
> and limits all downstream Endpoints to 128 bytes.
> This occurs even if both the RP and the Endpoint support a higher MPSS
> (e.g., 256 or 512 bytes), resulting in sub-optimal DMA performance.
> 
> This patch fixes the issue by reading the RP's actual MPSS from its
> Device Capability (DEVCAP) register and writing this value into the
> DEVCTL register, overriding the 128-byte default value.
> As this fix is called in driver's probe function before the PCI bus
> is scanned, it ensures that when the kernel's PCI core enumerates the
> downstream port, it reads the correct, maximum-supported MPS from the
> RP's DEVCTL and can negotiate the optimal MPS for the Endpoint.

Could you please review and test this series from Hans:
https://lore.kernel.org/linux-pci/20251104165125.174168-1-18255117159@163.com/

It tries to address the exact same problem that you are describing here.


Kind regards,
Niklas

