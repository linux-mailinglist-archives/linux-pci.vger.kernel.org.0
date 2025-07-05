Return-Path: <linux-pci+bounces-31567-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DA6AFA053
	for <lists+linux-pci@lfdr.de>; Sat,  5 Jul 2025 15:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B54D77A7514
	for <lists+linux-pci@lfdr.de>; Sat,  5 Jul 2025 13:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0DF190676;
	Sat,  5 Jul 2025 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQuAMhLI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4482E370A;
	Sat,  5 Jul 2025 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751723422; cv=none; b=dQtZSOcPBqUmTma0y+MZD9nhzBWboqp6rKQnIqDA5+Z6D+2Pj3cRVvfN95AxVdKF5L5JhYpBCwWPI6D3QxWUu5M7whX6YAuHWyHfdeTycp0KzBpouZ1+n3zvLcwcNjogMK7VvZJx6NkMI/WuaeS1s0cLelZ2CpX6GqvzP5Eu7OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751723422; c=relaxed/simple;
	bh=N6/21b/LJ56j5W+2EDZp2+lVPs0r785eQOBg8YRoDw0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JThL8sKBEobjW9kD9qZq5eyEcb93R3jQpe6vXeNweYW6HP60GOtTykS0538ld2GCn3YaO7sHdEGA/btrmMJiCoFHa+3Li/oxZ9HYS2u9VPl2fT1nv6H8yaQgREIxXcynmPCe+cB5RbHCoAdEoXT+De6GHcdzCH+1ZYemtZg4HlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQuAMhLI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36600C4CEE7;
	Sat,  5 Jul 2025 13:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751723422;
	bh=N6/21b/LJ56j5W+2EDZp2+lVPs0r785eQOBg8YRoDw0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=cQuAMhLIRHiX/6deGMqSs00tsiiCdxtZzHELylpg8/2g0IbHPjVrzIEZa2FXa0hbD
	 PS8IXY0yJNTVu9jOcJjFCpSBqkp2ZVtJa7snOayu7dbOJ3jZjR5DTtQYeQOQLAHiP2
	 m/Qu4wbIOLPB/gjSJzSRqiUwz8HJifzYNM25/Pd53w1Bx1hxk5Ka1UKtk5aBPKjh7i
	 vHXj91QNu3n/WAkLtaniwa3ss7jfIu5ZLgt6ZLmqD+dZGmhQBBu7MA4Sk09JYJCmkI
	 Mia+0ASWp3rkttjtKmLVgOBcCstYmNfI/wpMNKaJC+zsYGKDrCx9s2BrHmXSBLejp/
	 puJ7S6Glp3XvQ==
Date: Sat, 5 Jul 2025 08:50:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bandhan Pramanik <bandhanpramanik06.foss@gmail.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, ath10k@lists.infradead.org,
	linux-wireless@vger.kernel.org, stable@vger.kernel.org
Subject: Re: Instability in ALL stable and LTS distro kernels (IRQ #16 being
 disabled, PCIe bus errors, ath10k_pci) in Dell Inspiron 5567
Message-ID: <20250705135020.GA2006390@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B0A6D9B4-086F-4D58-8284-485B9FF4B31A@gmail.com>

On Sat, Jul 05, 2025 at 01:00:23AM +0530, Bandhan Pramanik wrote:
> Hi everyone,
> 
> Here after a week. I did my research.
> 
> I talked to some folks on IRC and the glaring issue was basically this: 
> 
> > [ 1146.810055] pcieport 0000:00:1c.0: AER: Uncorrectable (Fatal) error message received from 0000:01:00.0

Where is the complete dmesg log from which this is extracted?

> This basically means that the root port (that 1c thing written with
> colons) of PCIe is the main problem here. 
> 
> One particular note: this issue can be reproduced on the models of
> this same laptop. Therefore, this happens in most if not all of the
> laptops of the same model.
> 
> For starters, the root port basically manages the communication
> between the CPU and the device. Now, this root port itself is
> reporting fatal errors.
> 
> This is not a Wi-Fi error, but something deeper. 

Devices that support AER have extra log registers to capture details
about an error.  A device that detects an error sends a PCIe Error
Message upstream to a Root Port.  The Root Port generates an
interrupt, which is handled by the aer driver.  In this case, the
01:00.0 device detected an error and sent an ERR_FATAL message
upstream, and the 00:1c.0 Root Port received it and generated an
interrupt.  The ERR_FATAL message doesn't contain any details about
the error itself, so the aer driver looks for the AER registers in the
01:00.0 device and logs those details to the dmesg log.  Normally
there would be a few lines after the one you quoted that would include
those details.

Bjorn

