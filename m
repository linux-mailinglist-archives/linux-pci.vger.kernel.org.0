Return-Path: <linux-pci+bounces-27048-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 397DDAA4D79
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 15:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF257985324
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 13:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40D625B1E3;
	Wed, 30 Apr 2025 13:29:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B832DC774;
	Wed, 30 Apr 2025 13:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746019741; cv=none; b=tWYayngt8mNLbjk3tIynatWMdqFVmH6uxizX+pZ+odjmLEaC0Ikpr9S/DsWJdtHlOgtl11kUZqBmQDJLuiYdf+/t84CMa9hycpxIcGXBQe2y3OArxkqU+3P3iIkkuZtbhSEra9PO7gDSwxAsoQFwxm2q/d0/nz4l61otqKYBX3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746019741; c=relaxed/simple;
	bh=iepFqjTnG5ZKfsAvZMKKlCR3NMQcNm1fZnc9Ww3gYO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrZYuIPYDbUxw44Rr2CivEJ9Jya/osSDdTBHH7lbXeDlkKcA7J9j4qg6HdQMiFbtDdROouaE1pyMFrm4V0T/573ygHfnSCE+4o+iN5VFjfJBABfX6v9f1jfd4ncLSrN2B7K88OQji1JTIC+6vsFPlurYGmqeF69sezxb1PHiNyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 42B492C4CBD8;
	Wed, 30 Apr 2025 15:20:37 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 52E0D4F35C; Wed, 30 Apr 2025 15:20:43 +0200 (CEST)
Date: Wed, 30 Apr 2025 15:20:43 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Keith Busch <kbusch@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: Fix lock symmetry in pci_slot_unlock()
Message-ID: <aBIjqwn7Txl6TuP0@wunner.de>
References: <20250430083526.4276-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250430083526.4276-1-ilpo.jarvinen@linux.intel.com>

On Wed, Apr 30, 2025 at 11:35:26AM +0300, Ilpo Järvinen wrote:
> The commit a4e772898f8b ("PCI: Add missing bridge lock to
> pci_bus_lock()") made the lock function to call depend on
> dev->subordinate but left pci_slot_unlock() unmodified creating locking
> asymmetry compared with pci_slot_lock().

Worth noting that this isn't just for symmetry:  It seems the bridge
is unlocked twice because pci_bus_unlock() unlocks bus->self and
pci_slot_unlock() then unconditionally unlocks the same bridge device
again.

Thanks,

Lukas

