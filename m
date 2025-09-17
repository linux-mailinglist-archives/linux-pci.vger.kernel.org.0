Return-Path: <linux-pci+bounces-36330-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4081CB7D8E3
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 14:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F7C3BD9E5
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 08:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DB5309F10;
	Wed, 17 Sep 2025 08:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m7XaImCj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qmqevQHC"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E6A30BB8C;
	Wed, 17 Sep 2025 08:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758099162; cv=none; b=h+DTO0xU1VjQvrWyiIm8Xvw0h5hF/4CqLyCPe8873KM6x2w+lvio0SaiklUHauqHK7a2IyeCyv3Vuu+rPnjYtVyqGT+BWIB34njzXtJfZBZQbSXy57KO9JAPxBT5FFrRM1dWIcNihhWsvK2TfaQGN1JFA4j0spD1JJkpOGTUwBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758099162; c=relaxed/simple;
	bh=atzfQUupMVKU+GA+Iu1DsbU6neEf3EM253VZKHo6Rd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAOVcPJ2mv7I73x2veeL4j1EQ+uP38PLmvu+VOBFvie8ygkkNSAEGQuiMjP2zYeow5JPRkah5rCHhxOcb3ZWl2MACME7LQK8W32h75+eSW+ziXBjKZM0NIvE9cse7Fn7NMEJ/R8M8JaUB2hUiVQuqatFowL8hdemmQ5i/gVLR0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m7XaImCj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qmqevQHC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Sep 2025 10:52:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758099157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UYemsYQ6UmORVQ9ttT2LJtc7WYrQwh8a7dWRsA0dztY=;
	b=m7XaImCjj1w6bu6Q/iu/7hzN7vVejI1u/9BrJmF5jjAYM1UnNjT30A5ixhDMRWMOEfxOYw
	mFQcp7mjiwg3Ch4vDtfxFu6qjrvu7FtsgHgIyoCNgDfcDOf8hnSpaQXAG1Pt9m34aIK0p+
	/kdlAqotL1A+aeSxuuofGLGbM+Y4/sPvT95QQgCke3nxsGuWCaMBWz4XoGETl9jFXOeXCW
	tsAgNiPSPhLaAob0q35GJUuWdQG3lJcrmK1AFVjMw9em82jhDH9PoK3Nxa4DUwa6HJmmJ1
	Q0E3APNlQ2hEPlh/DZwM4tmuYAnK89bsL0OdnfwZGs0c4sBvmsLPUJE9Yw6zwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758099157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UYemsYQ6UmORVQ9ttT2LJtc7WYrQwh8a7dWRsA0dztY=;
	b=qmqevQHC0sScsGWYHXOnxVuxCrDzlz41JCRL6TK0s+1uD79dU6YDB+m0woRFcDU//o6d4I
	YiLBX/y9urXoEfDw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Keith Busch <kbusch@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	Matthew Wood <thepacketgeek@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Mario Limonciello <superm1@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND PATCH v7 1/1] PCI/sysfs: Expose PCIe device serial number
Message-ID: <20250917104859-6d38cb60-b638-4e5f-bf67-22683a441ae6@linutronix.de>
References: <20250821232239.599523-2-thepacketgeek@gmail.com>
 <20250915193904.GA1756590@bhelgaas>
 <aMnmTMsUWwTwnlWV@kbusch-mbp>
 <20250917083422.GA1467593@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250917083422.GA1467593@rocinante>

On Wed, Sep 17, 2025 at 05:34:22PM +0900, Krzysztof Wilczyński wrote:

(...)

> > It's a waste of resources to provide a handle just to say the capability
> > doesn't exist when the handle could just not exist instead.
> 
> I haven't checked how the kernfs side looks like, admittedly, but I think
> whether an attribute is visible or not, it does not unload and/or de-allocate
> any space for the accompanying kernfs object...  So, the resources saving
> here might not be in any way significant.

If I read the sysfs code correctly (create_files() in fs/sysfs/group.c),
the kernfs node should not even be allocated for invisible files.


Thomas

