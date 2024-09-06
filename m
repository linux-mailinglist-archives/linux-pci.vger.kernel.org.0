Return-Path: <linux-pci+bounces-12905-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8F396FBB1
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 20:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F046228A691
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 18:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10C113D24E;
	Fri,  6 Sep 2024 18:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="prk3V34/"
X-Original-To: linux-pci@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717403398E;
	Fri,  6 Sep 2024 18:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725649170; cv=none; b=OYUALJs0uPLvkDkDqztbDLejLm2VaxAiYbPMlErGYt+vtVUQSulwVasM+uNATx2fcZPOX3k4rDkAoduzsB2wRP1biIGo/EVI0A0dwW2cTK5IGup91YNBQgeoWWu+zG6zBQjec5Q3miJ6R2o8i0z/KtmsV14FiQDWAHnQXttGbHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725649170; c=relaxed/simple;
	bh=FeFiU2RQCm12lf/G35s+LptqEV/4ZnlRsXE2aVu6Mm4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cm6H5b2I5VDkcNJUl99caWF2tjv9JRU+j3zs8I/re0vE554Z/rTIuyPJNBWr7taxij0KTKOlsgRg1kod59Y0QF9dOJKYBvPbZnDaWeADsB0hZy+udYrBJlamH0yvQbgB6aMSrcMVcpKZS6GynbgUrJZfh25ODQvWMVOT38j9hVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=prk3V34/; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CDF1942B32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1725648800; bh=lx6igYfktFv/HLabqfYLn2bMTPo2JbeZaHvnRymqUx0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=prk3V34/u2gYj/HwnfH+S5t85S6+9fVc543BQj2sSZh3vz2K9CYLdr5FKUCYjRU45
	 zfK7N5r/ZfpogcNNpQNs2PnTgQ2AUCYiBVPhLXJ//3Z2f+b/r08Zn38AQ2zRP6F2qY
	 NEl7rxRy1XNhpRVMH7sYPEoTwX0cVUZMe6YNT9QcJelYY+w83RwkHmPVP+ddYnX8mu
	 QKtqahiN2x75gxmzwF3IJ9MefYHt5YO6Rb3UDvxZUWbKyw/hcl09R0uCpkuF9jWhnj
	 mAeLzX5wD11X0DGMcoIGm17TNpodzMF7wDOhOy0fb6o2r5nklHZJmcJTYARrNb6gqs
	 DN073ZKLgwynw==
Received: from localhost (c-24-9-249-71.hsd1.co.comcast.net [24.9.249.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id CDF1942B32;
	Fri,  6 Sep 2024 18:53:19 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Abdul Rahim <abdul.rahim@myyahoo.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
 abdul.rahim@myyahoo.com
Subject: Re: [PATCH] PCI: Fixed spelling in Documentation/PCI/pci.rst
In-Reply-To: <i432epqedna43bnow5twmm7bdf7dlms54kt5xjewalf5koamks@6kn4bx5lrubz>
References: <20240906124518.10308-1-abdul.rahim@myyahoo.com>
 <20240906164152.GA424952@bhelgaas>
 <i432epqedna43bnow5twmm7bdf7dlms54kt5xjewalf5koamks@6kn4bx5lrubz>
Date: Fri, 06 Sep 2024 12:53:18 -0600
Message-ID: <87cylgehr5.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Abdul Rahim <abdul.rahim@myyahoo.com> writes:

> On Fri, Sep 06, 2024 at 11:41:52AM GMT, Bjorn Helgaas wrote:
>> On Fri, Sep 06, 2024 at 06:15:18PM +0530, Abdul Rahim wrote:
>> > Fixed spelling and edited for clarity.
>> > 
>> > Signed-off-by: Abdul Rahim <abdul.rahim@myyahoo.com>
>> > ---
>> >  Documentation/PCI/pci.rst | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > 
>> > diff --git a/Documentation/PCI/pci.rst b/Documentation/PCI/pci.rst
>> > index dd7b1c0c21da..344c2c2d94f9 100644
>> > --- a/Documentation/PCI/pci.rst
>> > +++ b/Documentation/PCI/pci.rst
>> > @@ -52,7 +52,7 @@ driver generally needs to perform the following initialization:
>> >    - Enable DMA/processing engines
>> >  
>> >  When done using the device, and perhaps the module needs to be unloaded,
>> > -the driver needs to take the follow steps:
>> > +the driver needs to perform the following steps:
>> 
>> I don't see a spelling fix here, and personally I wouldn't bother with
>> changing "take" to "perform" unless we have other more significant
>> changes to make at the same time.
>
> - "follow" has been corrected to "following", which is more appriopriate
> in this context.
> - I know its trivial, but can disturb the readers flow
> - do you want me to change the message to "Edited for clarity"

The problem is not s/follow/following/, it is the other, unrelated
change you made that does not improve the text.  There are reasons why
we ask people not to mix multiple changes.  If you submit just the
"following" fix, it will surely be applied.

Thanks,

jon

