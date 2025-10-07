Return-Path: <linux-pci+bounces-37684-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A77C5BC2793
	for <lists+linux-pci@lfdr.de>; Tue, 07 Oct 2025 21:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 620B03C52EA
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 19:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855D6221F24;
	Tue,  7 Oct 2025 19:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b/lIZz2R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8xsuqYX4"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE1845C0B;
	Tue,  7 Oct 2025 19:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759864132; cv=none; b=SJyFyn7gHgDe53DmR2w2h/pFjzzaGxCsRASBg1kQexRYQikwvwtdYHO91g5fnHftsINeei+y8BmByTXu3Zgk9DxXOFdLs1/j5D/m3561sotg7bspPZpJPmYro4vcnt1fKali0Sk/zE3HrOCOHBpi17qg3+HBd6dq1QuBjy6VZPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759864132; c=relaxed/simple;
	bh=LFm+xmCaNIlj16Zcb8jmjkbJhp8Jqp46kubs9OZ0c9k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z/AosKKdfTyeavyzYLq1TjtRj3i5arpoGbIxU/8p1bGCQ83EB9dWacj07WjILo7JnRXxdWmiJVHysuQbcwzerwNZuFGLVyprMxfvPZXxvu0Owz6Rt9z4usvSCFgCQqQeEWObFBbXPkT1WYGyHHVB/DD2iQ+t40C3hxGLI0LDhkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b/lIZz2R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8xsuqYX4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759864128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LFm+xmCaNIlj16Zcb8jmjkbJhp8Jqp46kubs9OZ0c9k=;
	b=b/lIZz2RC2SJ4sJMLF30Dyj0iJ1/eb84bNReacadH99Hquwb/yXcfjXk2XBhv4bbkmvQVu
	iF7uVau1Q1SoM0PDRrMQAIzRsYRBG94R/mbRF6upncmGuX4RX43GWLEUxJ7LuZyS/3L4dP
	HriQZUuGFcJYh6SRebagQy7xinU9lrZrVd2NkUymosyRhaFGRZCYwaL3sqfAJ+SFupBEEn
	1PT2HMfGfncR7eMopXrWzltG+TyEzFfNHGOlj4gubnswoQsq20e+mfYnu9zjBQoyE8nZ/f
	X3VrBUxv2fnq9uspy/3LDFDU9fezJEE9iLq8QkLksmq6GwHkzv1BBmOywy5JVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759864128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LFm+xmCaNIlj16Zcb8jmjkbJhp8Jqp46kubs9OZ0c9k=;
	b=8xsuqYX4ou34gfQrUQpI2FjGhM+fcEvMTk5aGoF3J7x0up/z7DEw7rj+uxcairRwcck3Nl
	OSp8S+r33VHkzlAA==
To: Radu Rendec <rrendec@redhat.com>, Manivannan Sadhasivam <mani@kernel.org>
Cc: Daniel Tsai <danielsftsai@google.com>, Marek =?utf-8?Q?Beh=C3=BAn?=
 <kabel@kernel.org>,
 Krishna Chaitanya Chundru <quic_krichai@quicinc.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Brian Masney <bmasney@redhat.com>, Eric
 Chanudet <echanude@redhat.com>, Alessandro Carminati
 <acarmina@redhat.com>, Jared Kangas <jkangas@redhat.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Enable MSI affinity support for dwc PCI
In-Reply-To: <20251006223813.1688637-1-rrendec@redhat.com>
References: <20251006223813.1688637-1-rrendec@redhat.com>
Date: Tue, 07 Oct 2025 21:08:47 +0200
Message-ID: <87h5wa34xs.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 06 2025 at 18:38, Radu Rendec wrote:
> Last but not least, since most of the code in these patches is your
> code, I took the liberty to add your From and Signed-off-by tags to
> properly attribute authorship. I hope that's all right, and if for any
> reason you don't want that, then please accept my apologies and I will
> remove them in a future version. Of course, you can always remove them
> yourself if you want (assuming the patches are merged at some point),
> since you are the maintainer :)

Nah. You did the heavy lifting and it's sufficient to add Originally-by
or Suggested-by.

Let me go through the pile.

