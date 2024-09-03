Return-Path: <linux-pci+bounces-12673-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4627096A315
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 17:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29055B2598E
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 15:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93BE187552;
	Tue,  3 Sep 2024 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="clImB4B3"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC9E18453F
	for <linux-pci@vger.kernel.org>; Tue,  3 Sep 2024 15:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725378278; cv=none; b=J99X49pfWJvJU7SxOXRnbsym438NAPftK5sMKy52ZpPimJMT3wxm9YzwVi/KELrQtJsK27q4Bokx7E4SXYfzOXEKytfWaVIJBHd7ZMQXdl/Hl0JfsR84NDZGV38qfkYyH67TSz/cYvW8Z3okyneLFO5xtck6LS//1NU9KiH1k2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725378278; c=relaxed/simple;
	bh=YSq32GfMlhmuNdybuInc1CL8iZGTkph6QJD/3HTy2+o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wh6R5uOX33gFIi6O2CinTHLz9A8KZSy5sq34uK88Pzm5KooY8TPA/4gDwAmqgEdQRqTvIUAx6CbV0Q45hX9SlMVG2IktKOYm5KxLVTh2ktW/7oSVThFCg81rOoE1lA7+hFArreiOe3YRWUgbnz4ZjVF2Sas7AqQ6gQK6WbL0FAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=clImB4B3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725378276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+QimBow/BvCY+AE/CxrMAHJY8zR4V1ypAbI4yMInkz0=;
	b=clImB4B3eE4FB+WnlpHNScjp5hthYmz6zdS2qYPMrHXwsT8+stfeMPY1Q0nxOkdHKrgSzA
	R2rZuq7O0/HeMq+f6iiSK+g32E4dBaPphEcs9mNHkFqkxEhLF2CRnGTj+Yf3Q3CzIMLjqi
	0D3odcpUdHIV9XlFaL8/OkvyomiVu08=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-U78WClUtNO-BIdWyl9FUKg-1; Tue, 03 Sep 2024 11:44:34 -0400
X-MC-Unique: U78WClUtNO-BIdWyl9FUKg-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82a06d38241so82328439f.3
        for <linux-pci@vger.kernel.org>; Tue, 03 Sep 2024 08:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725378274; x=1725983074;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+QimBow/BvCY+AE/CxrMAHJY8zR4V1ypAbI4yMInkz0=;
        b=ueoGm0tyHEWnEq60OV6GfMGgNYJa7hJBxpQNH6fyKY2bfhsYnjAY73KGcWVI7csYtD
         y496jQvv3T73kZx1vLkovY5bxhnT4uaQl3cNvdwEOuYbBMIWsu6ubRBfm3UzMVfmlZPq
         r4JEzdRIoRY+BgczHEnpuq0f2xx7uIUyZUa9eCi+cHs4ELm59cY6q8Lx6o0CJY+LEMoC
         AAD1IJAqdfpnV7u7BGZk7Htr8LoKjlerD36Zz0CKdfLmnUq079G4ic3p8/YzslZfwSBa
         wRh5VZvep+Le3m+97VJRE3rKggIgtPbwOVfQHSwQzALO4+onYpaIQuofILqUoHaqjue/
         q2Tg==
X-Forwarded-Encrypted: i=1; AJvYcCUisnPj/cu6yofGID/kq80uQ0KPD3LsgTCjX4nWwt7cZzA+tzB8Sn5COfutdaxPfWHyEVyEnzRce88=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8YyCRYz7KZzeX/m/y7cKN71OUqnTPGAfhvTLY1QkAn4IJi3wq
	J8/LChNNUuNsWr//7Qx3zPVS2zeNfCt2iRMIbxfgN2HcJk2zCjHylpuuR1sD15PMFxTXoWzDBwL
	2hXA36CQbFrnvlfEOEZnKk1D9EexRt7VFezw2SZy/9ESGX6T+vMLa0sRqpQ==
X-Received: by 2002:a05:6602:208b:b0:7f6:85d1:f81a with SMTP id ca18e2360f4ac-82a262d0071mr812239539f.2.1725378273853;
        Tue, 03 Sep 2024 08:44:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMvRV3guba7VGOM0kEfa6x8urs9RiHqtbO3k0Njp08Y9LFP8gcyIAjS13QnK5TlBD8QPVfmQ==
X-Received: by 2002:a05:6602:208b:b0:7f6:85d1:f81a with SMTP id ca18e2360f4ac-82a262d0071mr812238039f.2.1725378273418;
        Tue, 03 Sep 2024 08:44:33 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82a1a411e84sm310663939f.12.2024.09.03.08.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:44:32 -0700 (PDT)
Date: Tue, 3 Sep 2024 09:44:31 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Krzysztof =?UTF-8?B?V2lsY3p5xYRz?=
 =?UTF-8?B?a2k=?= <kwilczynski@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH] PCI: Fix devres regression in pci_intx()
Message-ID: <20240903094431.63551744.alex.williamson@redhat.com>
In-Reply-To: <20240725120729.59788-2-pstanner@redhat.com>
References: <20240725120729.59788-2-pstanner@redhat.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jul 2024 14:07:30 +0200
Philipp Stanner <pstanner@redhat.com> wrote:

> pci_intx() is a function that becomes managed if pcim_enable_device()
> has been called in advance. Commit 25216afc9db5 ("PCI: Add managed
> pcim_intx()") changed this behavior so that pci_intx() always leads to
> creation of a separate device resource for itself, whereas earlier, a
> shared resource was used for all PCI devres operations.
> 
> Unfortunately, pci_intx() seems to be used in some drivers' remove()
> paths; in the managed case this causes a device resource to be created
> on driver detach.
> 
> Fix the regression by only redirecting pci_intx() to its managed twin
> pcim_intx() if the pci_command changes.
> 
> Fixes: 25216afc9db5 ("PCI: Add managed pcim_intx()")

I'm seeing another issue from this, which is maybe a more general
problem with managed mode.  In my case I'm using vfio-pci to assign an
ahci controller to a VM.  ahci_init_one() calls pcim_enable_device()
which sets is_managed = true.  I notice that nothing ever sets
is_managed to false.  Therefore now when I call pci_intx() from vfio-pci
under spinlock, I get a lockdep warning as I no go through pcim_intx()
code after 25216afc9db5 since the previous driver was managed.  It seems
like we should be setting is_managed to false is the driver release
path, right?  Thanks,

Alex


