Return-Path: <linux-pci+bounces-44733-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6588DD1DFD8
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 11:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8785C306B660
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 10:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960B8350D57;
	Wed, 14 Jan 2026 10:18:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5633254B6;
	Wed, 14 Jan 2026 10:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385929; cv=none; b=sNKkU5BdOygR9Et2TJ2U6GP7FWm06sK6ygSjvHAiXwKmKgbDZf3+KtK8fcU9BqduA7h1qZN1RAGOYQO1M5QB/381SkhE+e8bI7uJCk0gLESfMFz6XXpuuQFkPJgCoePuv1bPwIzMOxbK0OlTF+qgx0iMbnShyiqs0f0QZDF7RVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385929; c=relaxed/simple;
	bh=fRd+6dYlKysyW77m3kkZP8DrWxjzh/ee/xcPxzObOA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rbbz6EA4IXun4hifwF8V8c+YYISooUeZidyZ1zkuNjJMVIZqZbiqLENndoKosU4bkqUyealrMsZA5S68LaY4YHCF1PZjjmwbyY0YUZ+7OjWsdvxAm9sSe1IrZnYjToViLAoK01CByGEZf9aLpBIK5VC13ZiGanI0ZT4de1TQWNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id BF22E2C06ABA;
	Wed, 14 Jan 2026 11:18:38 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B9F82AEB1; Wed, 14 Jan 2026 11:18:38 +0100 (CET)
Date: Wed, 14 Jan 2026 11:18:38 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Kangfenglong <kangfenglong@huawei.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"shenyang (M)" <shenyang39@huawei.com>,
	"Zengtao (B)" <prime.zeng@hisilicon.com>,
	"shenjian (K)" <shenjian15@huawei.com>,
	"Wangyu (Eric)" <seven.wangyu@huawei.com>
Subject: Re: [BUG] PCI/DPC: NULL pointer dereference in
 pci_bus_read_config_dword during DPC recovery racing with hotplug
Message-ID: <aWdtfj2ubHp41fRT@wunner.de>
References: <fe8a89b501e44737821fe8b0ab4492e9@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe8a89b501e44737821fe8b0ab4492e9@huawei.com>

On Wed, Jan 14, 2026 at 09:49:44AM +0000, Kangfenglong wrote:
> Kernel Version: 5.10.0

That's ancient.

The bug you're seeing was fixed upstream with 11a1f4bc4736 ("PCI/DPC:
Fix use-after-free on concurrent DPC and hot-removal").  It was
backported to 5.10.224.

> 1. Existing synchronization between DPC and hotplug?

That was introduced by a97396c6eb13 ("PCI: pciehp: Ignore Link Down/Up
caused by DPC"), which went into v5.14.

Thanks,

Lukas

