Return-Path: <linux-pci+bounces-8902-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD4690C692
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 12:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 547B41F2157D
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 10:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A73D153BF5;
	Tue, 18 Jun 2024 07:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+3TLkaE"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CB713E025
	for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 07:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718697403; cv=none; b=kak9FNgfP+3tafYzGDbkn9VTgnqUsf6KLU2pJYvX+Wir6xh+v34oZHZ38IgdlF2hffeoJF6XG1jX3bPbOGnA9qp1uFewv6wg/VFAaKhZTQvjDq63T48Pf005Y4RnLs4xaJJi6D7NW7Kzsbq/37OyGr1GqtT7qxmpKSqAZ6QcP1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718697403; c=relaxed/simple;
	bh=X7oXfGqsaROPIv0d321bPJMWdfKZBHlFilMIFo4qMew=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pc4SD+H21fncY8MnnLy/fZtXecFiC8dUE3uvuuGFlTebDjf26p49nryArF8cFEiwPCq5MHslJJk6aNLLPA3SEz4uWCYdW+oFHGPdCfol/aZRx+v4F+9UWBKPg+6x7VLojAjdo0Miu8HZtnTVn1fGpul9uBQT6/Np+QqidpXNZwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L+3TLkaE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718697401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X7oXfGqsaROPIv0d321bPJMWdfKZBHlFilMIFo4qMew=;
	b=L+3TLkaEbxO01GLiGcySaA+Skoia7OmZ23cNtQOzDaK2yj7Ad9lW8SDqCSebvLg7SQ8+xA
	ykdvWJmuN/9wB+NMGYm6rkuC2TMxvQZazCc8RgfXFrMTUwhAz+C72gQWAY99sbFj3sEvzN
	C59D/+tWYLbTCTLIzfTqRwbr3ujuiI4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-3v-Ag7kNO2KbGEQvzeVMxA-1; Tue, 18 Jun 2024 03:56:39 -0400
X-MC-Unique: 3v-Ag7kNO2KbGEQvzeVMxA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42472e64cd8so321225e9.2
        for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 00:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718697398; x=1719302198;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X7oXfGqsaROPIv0d321bPJMWdfKZBHlFilMIFo4qMew=;
        b=HpjrOocHewSv+R/H+88djzeDThXZVYNOR519+uMI/g0oGRsfQyNrTih/1J0pPh37NZ
         9TELqXl8OV0M2wxV6mCRXARIwOt4waikmuOKaUzdWsjHFqmZYQG1WFr7Hh1csFitUOjr
         N2Yenc1oKNCqG1IeiXJXxIxs2IXINNr1SbDdw2neMqL5g7Gf6H395cwK8wC727lyDWmy
         DcYf3iJ7yJlsUfeyJNI4CIXbBXcwwK4tAjHUXc++KQD0JnpQ8qbyh9gT020Cqe6/jBuY
         cDSB6MEL/gWYG63o7BOx9ub+D3q7d4tJY5qps9Ibxe3qsaOFjJj8CmOzjXTNiAmCgJOz
         dlcA==
X-Forwarded-Encrypted: i=1; AJvYcCUG6I2qy4zYAFCUXNfeUfY7WWppZo1Nu8zUVZsFYPqeG4dsk2tcFXa4GADbC6ife8JlglcAicwJmDgEXi3yWA2uVKmqIBO3IGDe
X-Gm-Message-State: AOJu0YzLrsUZ6IqpFfkdhrLaJfyYytuM+2ohjDSXXUATKJa0EoBLClhu
	MOdvvLKj3j9ihBK4HuvID0B7dQz4DE5U7h0cDITeLEe2qeVs3w2XL1quWJd8nQn8b9jbIUvjkrg
	Pj+AQ9q5FYkfvLbHq9x9liJokvca4hrOLRWWyxkEoBqA1epNkqRGvCT3nDQ==
X-Received: by 2002:a05:600c:4fc9:b0:422:2f06:92d1 with SMTP id 5b1f17b1804b1-4230484ea73mr83191005e9.2.1718697398459;
        Tue, 18 Jun 2024 00:56:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElQg2MnML4c3e9aZwFA6IJ+FN0+5pNCUzrjPBudpNMYeXrjO8WNPBPXb35SYsoR8Fe93j85g==
X-Received: by 2002:a05:600c:4fc9:b0:422:2f06:92d1 with SMTP id 5b1f17b1804b1-4230484ea73mr83190795e9.2.1718697398070;
        Tue, 18 Jun 2024 00:56:38 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f602e802sm181674215e9.11.2024.06.18.00.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 00:56:37 -0700 (PDT)
Message-ID: <0d9fe3d3c52fa618b6c4e1d3414373b2e5417f32.camel@redhat.com>
Subject: Re: [PATCH v9 10/13] PCI: Give pci_intx() its own devres callback
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Hans de Goede
 <hdegoede@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>, Sam
 Ravnborg <sam@ravnborg.org>,  dakr@redhat.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org
Date: Tue, 18 Jun 2024 09:56:36 +0200
In-Reply-To: <20240617164604.GA1217529@bhelgaas>
References: <20240617164604.GA1217529@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-17 at 11:46 -0500, Bjorn Helgaas wrote:
> On Mon, Jun 17, 2024 at 10:21:10AM +0200, Philipp Stanner wrote:
> > On Fri, 2024-06-14 at 11:14 -0500, Bjorn Helgaas wrote:
> > > On Fri, Jun 14, 2024 at 10:09:46AM +0200, Philipp Stanner wrote:
> > ...
>=20
> > > > Apparently INTx is "old IRQ management" and should be done
> > > > through
> > > > pci_alloc_irq_vectors() nowadays.
> > >=20
> > > Do we have pcim_ support for pci_alloc_irq_vectors()?
> >=20
> > Nope.
>=20
> Should we?=C2=A0 Or is IRQ support not amenable to devm?

I don't see why it wouldn't work, AFAIU you just register a callback
that deregisters the interrupts again.

This series here, though, stems from me trying to clean up drivers in
DRM. That's when I discovered that regions / IO-mappings (which I need)
are broken.

Adding further stuff to pci/devres.c is no problem at all and
independent from this series; one just has to add the code and call the
appropriate devm_ functions.

>=20
> Happened to see this new driver:
> https://lore.kernel.org/all/20240617100359.2550541-3-Basavaraj.Natikar@am=
d.com/
> that uses devm and the only PCI-related part of .remove() is cleaning
> up the IRQs.
>=20

OK. They also use pcim_iomap_table() and stuff. I think we should
inform about the deprecation.

I don't have a user for IRQ at hand for my DRM work right now. I'd try
to upstream new infrastructure we need there as I did for vboxvideo.


Gr=C3=BC=C3=9Fe,
P.


