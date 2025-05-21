Return-Path: <linux-pci+bounces-28218-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B32C7ABF65E
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 15:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0245C1BA7A67
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 13:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0542857DA;
	Wed, 21 May 2025 13:39:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E7D27C17F;
	Wed, 21 May 2025 13:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747834767; cv=none; b=ubPf7/BrxDhoZfiDQtLY03jiY8kZ067rObDALVJFpMw5oBt9j0CTWSA1r/K82rz87ZQ3jaLCydq+3C0vFy6qOj8Snjk777rBY6nbK7rYL0ZjRhNEKbDICRXalADxPKfhJqyt6nQL8zNvQn9u/mI4g9XBnNsVU0wuWo7TIU2LyJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747834767; c=relaxed/simple;
	bh=ZNCQrlgbIpQW0vNrYiX2HSmQduvs48RcI5Q8Cd3eeqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcUbtON78Ey4fY6uQbCMSgrWhy51f0B+J24+oq0jNWLzmZTF26AFOigIv5yo9uRjuaG10gEGGnV/rrnv2mJReV07ThDoyEiWi+7hqOooOFd2JxN3xVQeu3SH3lKN3FgJPUnZZ9r7oychrhu3UCWkvMn+QCqweDHOwMUazd40zt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 9F5372C06E7F;
	Wed, 21 May 2025 15:39:22 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 66B091B829F; Wed, 21 May 2025 15:39:22 +0200 (CEST)
Date: Wed, 21 May 2025 15:39:22 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Denis Benato <benato.denis96@gmail.com>
Cc: Mario Limonciello <superm1@kernel.org>,
	Raag Jadav <raag.jadav@intel.com>, rafael@kernel.org,
	mahesh@linux.ibm.com, oohall@gmail.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	aravind.iddamsetty@linux.intel.com
Subject: Re: [PATCH v4] PCI: Prevent power state transition of erroneous
 device
Message-ID: <aC3XiuOPVYB2EX18@wunner.de>
References: <20250519102808.4130271-1-raag.jadav@intel.com>
 <aCsK743YSuahPtnH@black.fi.intel.com>
 <85ed0b91-c84f-4d24-8e19-a8cb3ba02b14@gmail.com>
 <aCxP6vQ8Ep9LftPv@black.fi.intel.com>
 <a8c83435-4c91-495c-950c-4d12b955c54c@kernel.org>
 <aCyj9nbnIRet93O-@black.fi.intel.com>
 <552d75b2-2736-419f-887e-ce2692616578@kernel.org>
 <ee1117cf-6367-4e9a-aa85-ccfc6c63125d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee1117cf-6367-4e9a-aa85-ccfc6c63125d@gmail.com>

On Tue, May 20, 2025 at 07:22:04PM +0200, Denis Benato wrote:
> This is the very same exact kernel, minus the patch in question:
> https://pastebin.com/rwMYgG7C
> 
> Both previous kernel and this one have CONFIG_PCI_DEBUG=y.

This log excerpt shows that the ASMedia Thunderbolt controller
below the Intel Thunderbolt controller couldn't be enumerated
on boot:

mag 20 18:42:20 denis-pc kernel: pci 0000:03:01.0: broken device, retraining non-functional downstream link at 2.5GT/s
mag 20 18:42:20 denis-pc kernel: pci 0000:03:01.0: retraining failed

However, the Thunderbolt tunnel goes up and the devices are
enumerated 24 seconds later:

mag 20 18:42:44 denis-pc kernel: pcieport 0000:03:01.0: pciehp: Slot(1-1): Card present
mag 20 18:42:44 denis-pc kernel: pcieport 0000:03:01.0: pciehp: Slot(1-1): Link Up

Thanks,

Lukas

