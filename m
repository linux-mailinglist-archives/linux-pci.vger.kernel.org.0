Return-Path: <linux-pci+bounces-39276-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA0AC071BB
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 17:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 65D5635CC15
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 15:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C14E330B14;
	Fri, 24 Oct 2025 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j+0yL9Vy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Aw/vJYnY"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804C932E754;
	Fri, 24 Oct 2025 15:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761321317; cv=none; b=CxkYGhLifp16hpgvavqZi+0OApFqMygpRJP8EANrARSI+63ilvG8+hkQ+Em2vm2K5cDP3ykdhj6hQZ+ZqyZ7sen4pWtarLaKUUxQcbhNSaPL1aEigZ/dlT+y50G3ueZaZVR8mmxbceetwx83ZfgMn+sdCALHVKmoF6OtgBCYuWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761321317; c=relaxed/simple;
	bh=uLkgxYLyMUzhQXeffmdYlniLYIB/KYmdOPjZoRoTHYo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V+bIjaZUkee7H5sdP1qp49Dwdw3vRf0YGS4Yoyw8KOjySe373rKOiGIZaAG6DxQ0cbvijNWva9f6kxjbdjiiS2ANvFleqB2JxY7Zcv1y6LEG3IMKdM7QrPlT3jF0igdl92JnBcOlEF6sdQiH45HPqPClHmfzgFvuekjygPo88q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j+0yL9Vy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Aw/vJYnY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761321313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WOe5phv4TtG2VbUNjJcJ2euqfGkUkvoO3y2L/DnVFD4=;
	b=j+0yL9Vya5MvjeCiKkrp5aHA3FrPWG1ymrAS2OUElS9/ZPxiRKgv9nWBpRvoJk02/qriFz
	JJBOZpVxyF0a3pO64whKW2H9a/wLfwoFu0g2qZMA6RNLvDPCmakGlbBwfR1IpVToMBVAMd
	kPa34EsDIkZim5UGwLtCQZGqf/wGnDn0IX0DJHX46AbD1WmjrUy0U5O41F3AUCRnCgdaXq
	ox3/MD0bzdpUQz9ge0XSjmkFOIIfLal3QteHV3Pj5qFNf1IomHD7dUGbzkwgD8Gkm192ud
	OrIDwfQmwpMkcWbk7DeTW+rEvpmGmCz7Pg+F/Q8cfrHgQ4w8LEIkWZGN8WPOuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761321313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WOe5phv4TtG2VbUNjJcJ2euqfGkUkvoO3y2L/DnVFD4=;
	b=Aw/vJYnYahTo2hh0gMiFd9SCwQyMTaciHm/qxtq4yc+wjlxtj9ZsXPrM9pzho3xk8jiBUE
	h16UxEPBK7T/u9Dg==
To: Rob Herring <robh@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, Sascha Bischoff <sascha.bischoff@arm.com>,
 Scott Branden <sbranden@broadcom.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>, Frank Li
 <Frank.Li@nxp.com>, Manivannan Sadhasivam <mani@kernel.org>, Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Marc Zyngier
 <maz@kernel.org>
Subject: Re: [PATCH v4 0/5] of/irq: Misc msi-parent handling fixes/clean-ups
In-Reply-To: <CAL_JsqL5f4_qQ=YmQcYpaxsUx8vZDkuquK=G3YTw9qC1QibVrg@mail.gmail.com>
References: <20251021124103.198419-1-lpieralisi@kernel.org>
 <20251022140545.GB3390144-robh@kernel.org> <87v7k4ws58.ffs@tglx>
 <CAL_JsqL5f4_qQ=YmQcYpaxsUx8vZDkuquK=G3YTw9qC1QibVrg@mail.gmail.com>
Date: Fri, 24 Oct 2025 17:55:12 +0200
Message-ID: <87sef8wazj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24 2025 at 07:43, Rob Herring wrote:
> On Fri, Oct 24, 2025 at 4:44=E2=80=AFAM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> On Wed, Oct 22 2025 at 09:05, Rob Herring wrote:
>> > On Tue, Oct 21, 2025 at 02:40:58PM +0200, Lorenzo Pieralisi wrote:
>> >> Lorenzo Pieralisi (5):
>> >>   of/irq: Add msi-parent check to of_msi_xlate()
>> >>   of/irq: Fix OF node refcount in of_msi_get_domain()
>> >
>> > I've applied these 2 for 6.18.
>>
>> The rest of this depends on those two.
>>
>> >>   of/irq: Export of_msi_xlate() for module usage
>>
>> Can you pick the three of/irq ones up and put them into a seperate
>> branch based on rc1 so that I can pull that and apply the rest:
>
> Yes. This series is the only thing I have queued for 6.18 fixes so
> far, so I'll add the 3rd patch and Cc you on my PR to Linus.

Thanks!

