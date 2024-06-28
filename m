Return-Path: <linux-pci+bounces-9409-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C538F91C686
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 21:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FAE2B21387
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 19:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D6754662;
	Fri, 28 Jun 2024 19:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvNsh1O3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789931B94F;
	Fri, 28 Jun 2024 19:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719602733; cv=none; b=AfsAvCOk5roei9wwI462uaaugsJeWTkWVP97R0CINgICObnJONzdJ4jDkretVCVowFF3Z/w1CVvC8wa47LCYYga4WPX/yB/MkCAeW8FK8Zyo+MupRlD9kDpsPtjOScYaGRBaYBmh4nkpYnjOMHjcSED36YLBLygwnRI+3mCul8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719602733; c=relaxed/simple;
	bh=llGLbAOR77MLic+hUHRPSJLM4JDStWGvzGQNB3T9+eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7XiMHJu/6uQNttg7A2q9GVAxL5z2LgmsXXf2yPBUw6cqGLmwCl8Wrgp/wgaMrQy9AwXURCc+ZJdzzOzbFr6WK6EqXdSF2BFTC8ppggSsVXTEOoG5PC4ouD6gcOukwmN6fHUqo0j1kVDNHe6WmVtj6aUzcky3D84SyFHYHrm7Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvNsh1O3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F27C116B1;
	Fri, 28 Jun 2024 19:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719602733;
	bh=llGLbAOR77MLic+hUHRPSJLM4JDStWGvzGQNB3T9+eA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jvNsh1O39oXCd0qBNRvfvbHpttzIV4ZlCihXmETnrZQ9Erts+gSNGXIMVcXnP/i+/
	 8nC+YrH0meOx6ME9/YmTL7YHhMTduqsNcgKVMoCYidLUiloHdnriAY11Y4gdMw4Mrr
	 V4Wsvz6qt0keMCcQSOmRv4qcIqNv4xpDtsJiOwMC6K0q8Y8Cfb0FEPuk4lYpWSzP39
	 EJ9Nh311GZdqqpp4y2gZ7woe31o0SeY5f6FI90ijGKv5Co0eVYDlACvyvCLTlZbd1N
	 7vg/khebOut1A7nPYhbwHFmP8meGvPg/zxXo5Kop1S9WLAO3F21ck1pdHqZ24m/jAR
	 9EiuFDpHSyWOA==
Date: Fri, 28 Jun 2024 13:25:29 -0600
From: Keith Busch <kbusch@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: bhelgaas@google.com, Imre Deak <imre.deak@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-pci@vger.kernel.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 3/3] PCI: Add missing bridge lock to pci_bus_lock()
Message-ID: <Zn8OKeOwAR4GfWB_@kbusch-mbp.dhcp.thefacebook.com>
References: <171711745834.1628941.5259278474013108507.stgit@dwillia2-xfh.jf.intel.com>
 <171711747501.1628941.15217746952476635316.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171711747501.1628941.15217746952476635316.stgit@dwillia2-xfh.jf.intel.com>

On Thu, May 30, 2024 at 06:04:35PM -0700, Dan Williams wrote:
> @@ -5444,6 +5444,7 @@ static void pci_bus_lock(struct pci_bus *bus)
>  {
>  	struct pci_dev *dev;
>  
> +	pci_dev_lock(bus->self);
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
>  		pci_dev_lock(dev);
>  		if (dev->subordinate)

The very next line is:

	pci_bus_lock(dev->subordinate);

The code had just locked "dev". The recursive call will then lock
dev->subordinate->self, which is "dev", the same that was just locked a
moment ago: deadlocked.

Here's an idea:

---
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 46beaf1815fab..4f7cf693857f4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5487,8 +5487,9 @@ static void pci_bus_lock(struct pci_bus *bus)
 
 	pci_dev_lock(bus->self);
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		pci_dev_lock(dev);
-		if (dev->subordinate)
+		if (!dev->subordinate)
+			pci_dev_lock(dev);
+		else
 			pci_bus_lock(dev->subordinate);
 	}
 }
@@ -5501,7 +5502,8 @@ static void pci_bus_unlock(struct pci_bus *bus)
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		if (dev->subordinate)
 			pci_bus_unlock(dev->subordinate);
-		pci_dev_unlock(dev);
+		else
+			pci_dev_unlock(dev);
 	}
 	pci_dev_unlock(bus->self);
 }
--

