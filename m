Return-Path: <linux-pci+bounces-21232-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32814A3177D
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 22:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 392E47A4D13
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 21:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701B0266565;
	Tue, 11 Feb 2025 21:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YE4q+tW5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46781266560;
	Tue, 11 Feb 2025 21:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739308715; cv=none; b=PKYoPrqbAoDdJzKgvnBwa1aexP+DZ/arEDBEsyVmA1JIbeMRJ4PUjdPtvKBhYHaB9ND00yhry1gn+eKFjaqPMjfcYyRMFK+9YmpOwzB+cIdz0h/kzx7z9W7RJaBcruEiKDAw0sW7PjWBdaOO+P4h9e8YW+Dh+rd2T90jPJcrZ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739308715; c=relaxed/simple;
	bh=niRgakkeVYEZO90yrPCbx5Safpxkl7Iz3fDgq+LzRGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+Dx1Hf1tAXgeRx89QjuF96QP2WzijXjSCvXuliW1iVJ6SanpZTrFYebhfZErdGtGM8O9GnQPcXUnJmO5LgrZZJg7Jt4bxdmEDboqm1eg8qCKjUQtgpeq/PLddQh1OYHk/aQXDTOnlX89+qO6/D2fAAcEnEbLk1OfcoE5sV2QRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YE4q+tW5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4001AC4CEE2;
	Tue, 11 Feb 2025 21:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739308713;
	bh=niRgakkeVYEZO90yrPCbx5Safpxkl7Iz3fDgq+LzRGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YE4q+tW5nSiQxX7O/OcIKdUD2jVBW/hVR3RoHuho3lVh3JQvsuonH9UpvoWgkykrH
	 rIAgj7l4nZ7TRekU+4nE2RoX/YlzpkSD/CZ+b+RJMjlfXVgUv29PRTEgp2zC0yH9lB
	 rICIQMEYznQVyzC9rFrewTMjFQRlQJIXZoayQ55EYbmnEl8/Zvf/Bt+lX87FAEODNL
	 R+ETLwUQnMDENCV//oPzsWTi+Ej/r8jA8iq6a+f03SLuCwk3RMthJh0fRrrKBNg4C9
	 ZJXJ7b05i6QkMxbfDvNytC0wY+wwLdfpaLRkijvOVTkrTyR7ssBKwm3z5EizassWNr
	 7Z7iVv6mnUW2Q==
Date: Tue, 11 Feb 2025 14:18:31 -0700
From: Keith Busch <kbusch@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Purva Yeshi <purvayeshi550@gmail.com>, bhelgaas@google.com,
	skhan@linuxfoundation.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] drivers: pci: Fix flexible array usage
Message-ID: <Z6u-pwlktLnPZNF-@kbusch-mbp>
References: <Z6qFvrf1gsZGSIGo@kbusch-mbp>
 <20250211210235.GA54524@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211210235.GA54524@bhelgaas>

On Tue, Feb 11, 2025 at 03:02:35PM -0600, Bjorn Helgaas wrote:
> This is kind of a complicated data structure.  IIUC, a struct
> pci_saved_state is allocated only in pci_store_saved_state(), where
> the size is determined by the sum of the sizes of all the entries in
> the dev->saved_cap_space list.
> 
> The pci_saved_state is filled by copying from entries in the
> dev->saved_cap_space list.  The entries need not be all the same size
> because we copy each entry manually based on its size.
> 
> So cap[] is really just the base of this buffer of variable-sized
> entries.  Maybe "struct pci_cap_saved_data cap[]" is not the best
> representation of this, but *cap (a pointer) doesn't seem better.

The original code is actually correct despite using a flexible array of
a struct that contains a flexible array. That arrangement just means you
can't index into it, but the code is only doing pointer arithmetic, so
should be fine.

With this struct:

struct pci_saved_state {
 	u32 config_space[16];
	struct pci_cap_saved_data cap[];
};

Accessing "cap" field returns the address right after the config_space[]
member. When it's changed to a pointer type, though, it needs to be
initialized to *something* but the code doesn't do that. The code just
expects the cap to follow right after the config.

Anyway, to silence the warning we can just make it an anonymous member
and add 1 to the state to get to the same place in memory as before.

---
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 869d204a70a37..e562037644fd0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1929,7 +1929,6 @@ EXPORT_SYMBOL(pci_restore_state);
 
 struct pci_saved_state {
 	u32 config_space[16];
-	struct pci_cap_saved_data cap[];
 };
 
 /**
@@ -1961,7 +1960,7 @@ struct pci_saved_state *pci_store_saved_state(struct pci_dev *dev)
 	memcpy(state->config_space, dev->saved_config_space,
 	       sizeof(state->config_space));
 
-	cap = state->cap;
+	cap = (void *)(state + 1);
 	hlist_for_each_entry(tmp, &dev->saved_cap_space, next) {
 		size_t len = sizeof(struct pci_cap_saved_data) + tmp->cap.size;
 		memcpy(cap, &tmp->cap, len);
@@ -1991,7 +1990,7 @@ int pci_load_saved_state(struct pci_dev *dev,
 	memcpy(dev->saved_config_space, state->config_space,
 	       sizeof(state->config_space));
 
-	cap = state->cap;
+	cap = (void *)(state + 1);
 	while (cap->size) {
 		struct pci_cap_saved_state *tmp;
 
--

