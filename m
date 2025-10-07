Return-Path: <linux-pci+bounces-37680-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2265CBC20FB
	for <lists+linux-pci@lfdr.de>; Tue, 07 Oct 2025 18:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156C41894D1A
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 16:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830FC2E7BC1;
	Tue,  7 Oct 2025 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="266ML0Fu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ATuSmIO7"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D546A2E7657;
	Tue,  7 Oct 2025 16:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853557; cv=none; b=eLxOarhqtDwUnj7hNuMRrq5BmAIPniXdKe1ofcfkgA/qlaH9sT7/kiwhRthhOK8y2apq9z/91CdqH1YWVvp9CBK0t5RocH6Xmh3t0alKKhBLooc9rXm6McVE7774LgqzObaP00NrZ5onm6vXiYTlcZWuncFvkoruQoX3s2cC01c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853557; c=relaxed/simple;
	bh=hzP4HChIondr8B3ZApfMzdZDXoG3z2ygNFIMV1ielV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9AVGBMH/6qaQkUXE4FNARbixJHPWK+CsVUPJK+T2wPm6OSef8KECJhgWkP5Cs7ZNoPpWM1PRTveyKaDluuyz+DCvcyBXYofChH+GKe0QFGy72WrpwYOkOXIcXUJAwoiOzRwLiJccF00DjB36WVqZazQjDepIxZ6vKuwWGdarCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=266ML0Fu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ATuSmIO7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 7 Oct 2025 18:12:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759853550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hzP4HChIondr8B3ZApfMzdZDXoG3z2ygNFIMV1ielV0=;
	b=266ML0FuyZmn5S/tjluETahHL4QQhcTXr6w7POsK2J6hbbFi1PkrbBkf+AQZKHBtqy7l3X
	6CdUu4hOchd4bMmOXn9WqOSXRBW2gydk97pxmaycEZxuDr2tCF9r6qxqfhWfOnxhpR0iKm
	u6UXHkPgOrIINtrSpyjWm+caHc/cF+Gox3Cf5aF2NM3jwOTTobF8p0+XISejaOf4PaOdfi
	iQcBqVKHkNzxsC3RakOeYqz6jTXXKkNcVXEq1yK4kkmAXftql6ns9mdqIbiVBWGXLlQD3h
	D3K7jEVExAoMuCE4Uwt7J0xgVCcKZgHDkc7lNy4LVpNDAfDOW6pcQsUKkTbVVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759853550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hzP4HChIondr8B3ZApfMzdZDXoG3z2ygNFIMV1ielV0=;
	b=ATuSmIO7NwxFNRuxUedsmal0wwybq8DVASQ5mC6OO1PCAWyFnb2ohQCa/A7C4p4t62umG7
	fE5YI4EwCsr7fZDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: guangbo cui <jckeep.cuiguangbo@gmail.com>
Cc: Waiman Long <llong@redhat.com>, Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci/aer_inject: switching inject_lock to raw_spinlock_t
Message-ID: <20251007161229.7IT0x9Me@linutronix.de>
References: <20251007060218.57222-1-jckeep.cuiguangbo@gmail.com>
 <4ab58884-aad3-4c99-a5f9-b23e775a1514@redhat.com>
 <CAH6oFv+KYGZNzb7gySoyQAB3tn2CrH+H_-vi4E=4NS6pvTBHvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH6oFv+KYGZNzb7gySoyQAB3tn2CrH+H_-vi4E=4NS6pvTBHvw@mail.gmail.com>

On 2025-10-08 00:10:45 [+0800], guangbo cui wrote:
> As mentioned above, the list is usually short in typical use cases,
> since error injection is mainly used for debugging or development
> purposes. Perhaps we can also get some advice from the PCI folks.

Is this something that is used in "production" or more debugging/
development?

> Best regards,
> Guangbo

Sebastian

