Return-Path: <linux-pci+bounces-16145-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D58709BF1D5
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 16:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 138861C259D1
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 15:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBD918FDD0;
	Wed,  6 Nov 2024 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X4ikZ4wn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6rqua4yb"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781D616CD29;
	Wed,  6 Nov 2024 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730907384; cv=none; b=Vv3v+QbiVvs470EYWBpnmLF+YHol6crY/I6WebHkVcEBKtkoatP4E3kxtXOErtxbYUZ19uMIgdGhx/eJwUhWt2d/G+qUICutpvqMXQotMDimwF9hIxOC/8leYZMl07lipDubUKrUxGds3Di9Cmf2b781gE8IRAEP3CoHtOEFSjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730907384; c=relaxed/simple;
	bh=gvu+DlrdaTyOJiJCe5bkq6Jd1DrS0DApb5B0qy8AEYY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JuP80dLKztwxvzpIG9jrlh/JD5TNeycBjWcP5hExPLKQlOJ7aC1Ni6GQWYzAwfUDUrI2CHcJbuf52luTO+YE2E08Sj4UaiilhhE7I5l/KZ7QZMqQJ0ggU1Hj097/vFJrWYAXKy4ykGgfJ2A/oUiHQoBBLxd8UOfTIV2Dz6rAK8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X4ikZ4wn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6rqua4yb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730907380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qtdYKdKwHTXJuMaHWRfAi9GzxWa0wjVTqWwZaJ837uI=;
	b=X4ikZ4wn2utxMTie23bvYGlg/xa0WdyyiHLaQeu0RA5/ZE2PJ2Pmto2uWM/BmYRfM5cusZ
	xGTTysJime1Tkq5H2zlByQlAxZZRB0IqCY5mwZro6nvyFuxSCXdl4ZYRqj11G3jtRqxo7P
	g8OtrQlB0yZtIoDFHlDilnswkZeVM8ytnG6jdCXYqVO3fbHoiurw4xnv0xgVLDaw3fHYE1
	lPXtpLFY4ozMVHQfw2mipLlYOXRvRW0kaGrQhh4GWAL7id5+gghzzgRfLcPNqmslPM09Ki
	5Q9mOU7CTuI6MKtYrhIjCuTf/y9HIurBX35AsZdJm/s/cVyJLKFf7fZEeKm4hQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730907380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qtdYKdKwHTXJuMaHWRfAi9GzxWa0wjVTqWwZaJ837uI=;
	b=6rqua4ybQt6quGmOvgnPokZHhH0+yX7iB4GXIw64WWkV3ihPpTiq4XKmJYyvYtAt8xZQY0
	JxxvskTwBqSwlUCw==
To: Bjorn Helgaas <helgaas@kernel.org>, Dullfire <dullfire@yahoo.com>
Cc: davem@davemloft.net, sparclinux@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org
Subject: Re: Kernel panic with niu module
In-Reply-To: <20241104234412.GA1446170@bhelgaas>
References: <20241104234412.GA1446170@bhelgaas>
Date: Wed, 06 Nov 2024 16:36:21 +0100
Message-ID: <87fro4pe6i.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 04 2024 at 17:44, Bjorn Helgaas wrote:
> On Mon, Nov 04, 2024 at 05:34:42AM -0600, Dullfire wrote:
>> I have also bisected the kernel, and determined that  upstream commit
>> 7d5ec3d3612396dc6d4b76366d20ab9fc06f399f revealed this issue. This commit
>> adds read to the mask status before any write to PCI_MSIX_ENTRY_DATA, thus
>> provoking the issue.

7d5ec3d36123 had the mask_all() invocation _before_ setting up the the
entries and reading back the descriptors. So that commit cannot break
the niu device when your problem analysis is correct.

83dbf898a2d4 moved the mask_all() invocation after setting up MSI-X into
the success path to handle a bonkers Marvell NVME device. That then
matches your problem desription as the read proceeds the write.

I've never heard of a similiar problem, so I'm pretty sure that's truly
niu specific.

Thanks,

        tglx

