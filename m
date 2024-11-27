Return-Path: <linux-pci+bounces-17425-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A63E69DAC58
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 18:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2331E1668F8
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 17:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22C120102C;
	Wed, 27 Nov 2024 17:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TFrxwoSZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103D4200BBA
	for <linux-pci@vger.kernel.org>; Wed, 27 Nov 2024 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732728171; cv=none; b=KYpq/Yh2MqAJvdYLN7DtFiA0Ht5o27raqSdsCl40/RIni7tIuOCxiKmeHmpatnAP6iWQp7cGw0uCAOfEijHAiJOcWhxRq0R59CXWrVzSU98oVyCynUchwzjpi5DcllAVApOzoKUwE5HmOPnpuIpzxBmTHIVui/0IRHHygbnGrBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732728171; c=relaxed/simple;
	bh=udRSauQ8v0m45QJa02tpuWABp6MhR6MgqKOiA1qUWyg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lX+hu8n8FQVA2pmK9X6KJEkaIUhg6bAN4hMvQamPp6OKFefa1OSzZ+3Y30H0TkxlRgqjjdgd0jeOn/jm1Dr/E0mXenjYjoEu1zDUGc6iMX7Bo3Fq4FORgmHq/Ir6wENLT8Y3bg/mxbe5AAuzj78dHPaJ3X1dkRebbEngPjlJ+ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TFrxwoSZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732728169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W9zax/CHaztlMaSgeA0GgU43P1mgjhVVVedx0D3zKOY=;
	b=TFrxwoSZ4fgUQaOoWITnc+WOHu0yt3AsG4TMlb/ZqPquNE8Ouq7uLAy8cb3+scFGoNkf6U
	RvHM0CKBiWGRTqielQ2TkBVv4BYZHm11o5zmEDaFU9L3nnDFTRuTp3shELnDKdM3Leh3Sm
	7Ph4ZId2G/FV3XY/NQnnzA9r0lFOChw=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-c8glAXJLNcaynxsNsDnuRQ-1; Wed, 27 Nov 2024 12:22:47 -0500
X-MC-Unique: c8glAXJLNcaynxsNsDnuRQ-1
X-Mimecast-MFC-AGG-ID: c8glAXJLNcaynxsNsDnuRQ
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a7c836fda9so291325ab.0
        for <linux-pci@vger.kernel.org>; Wed, 27 Nov 2024 09:22:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732728166; x=1733332966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9zax/CHaztlMaSgeA0GgU43P1mgjhVVVedx0D3zKOY=;
        b=gKu+bxlAYaY5LMPQ9J45dAGW11a5cZILDxpgxxOWnnbc6K3PcBzL0ZEZV7ty4Ah1T9
         W0lcyiunfQT23u8YlVSWkEwx/HNcpDvCbLeTWHAwRQBuaoPDeQE0AC1zdIA4B7W+0q2F
         XJYfeGulW7VDrhO1vOimohSZJrOxjD8UMY6OyQhMeeC2N/G+PSfzlWZYCETWv2f1QxlK
         uQtqJ4yD+27OMyfsc7dUUkQ5qnxI2EF9Q2vFvyF1oWq2d+qPHq/NIsa2eH38exYpkh4B
         6/s37n6ANAfKmI/DAlNTTmfCDwbLZtV+kg0NR+pWcTBW7ej4ulScZU5or0LcSAK+xT3W
         HmiQ==
X-Gm-Message-State: AOJu0YxvXdoznflpx2RBFSo80xPDwtxd6J6yex8B8a0KnosrgzZt3lLc
	PseJUr7cUkVWGAbPR8mY6Daa7CTN1qSK9J3qxqiSb3CRsL7FrQ+Hs/ldK+jBQiGLtHjDiscCaai
	JptPCOgPOI8u1QUKr1dhX64dBG02bNzJyS0tWEKR1V3IFPrQA0+xJkBE1ZAZSHH2AKg==
X-Gm-Gg: ASbGncu+d0ISzz9x2NqxyhHjpIR6eWGcb4B5166ZoERluNKOiJiYPiFfq0nI9UYb7nx
	fTUmqzp1157hz79lmO2LZNBCIiwVF9IVAA3Hau95q29YDrJdR+dT4CZiM6W+Cbf79rmc6nlUUmC
	FbpuLxgjmBDDiCbh7MeOTzdfXk0IM6/J+JkFQ6MQxMWAjWgdnGXPqkuAyNHali5hd/wlrf3Rl0R
	9saioouI1mfjLNKuQVHOZJIKU+EImnnXOQsPg4CzelE4kowkvpH2g==
X-Received: by 2002:a05:6e02:1785:b0:3a7:bd4c:b17e with SMTP id e9e14a558f8ab-3a7c544a689mr11641905ab.0.1732728166282;
        Wed, 27 Nov 2024 09:22:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgahiLZdXLot24IB4E3W1bQXNAY3TqwQBGglHBYwgd/Sn9n6D44soFsrc5jyVRxyY14SiM6Q==
X-Received: by 2002:a05:6e02:1785:b0:3a7:bd4c:b17e with SMTP id e9e14a558f8ab-3a7c544a689mr11641795ab.0.1732728165925;
        Wed, 27 Nov 2024 09:22:45 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a79acbdf6asm27282405ab.77.2024.11.27.09.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 09:22:45 -0800 (PST)
Date: Wed, 27 Nov 2024 10:22:43 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Mitchell Augustin <mitchell.augustin@canonical.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, linux-kernel@vger.kernel.org
Subject: Re: drivers/pci: (and/or KVM): Slow PCI initialization during VM
 boot with passthrough of large BAR Nvidia GPUs on DGX H100
Message-ID: <20241127102243.57cddb78.alex.williamson@redhat.com>
In-Reply-To: <CAHTA-uY3pyDLH9-hy1RjOqrRR+OU=Ko6hJ4xWmMTyoLwHhgTOQ@mail.gmail.com>
References: <CAHTA-uYp07FgM6T1OZQKqAdSA5JrZo0ReNEyZgQZub4mDRrV5w@mail.gmail.com>
	<20241126103427.42d21193.alex.williamson@redhat.com>
	<CAHTA-ubXiDePmfgTdPbg144tHmRZR8=2cNshcL5tMkoMXdyn_Q@mail.gmail.com>
	<20241126154145.638dba46.alex.williamson@redhat.com>
	<CAHTA-uZp-bk5HeE7uhsR1frtj9dU+HrXxFZTAVeAwFhPen87wA@mail.gmail.com>
	<20241126170214.5717003f.alex.williamson@redhat.com>
	<CAHTA-uY3pyDLH9-hy1RjOqrRR+OU=Ko6hJ4xWmMTyoLwHhgTOQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Nov 2024 19:12:35 -0600
Mitchell Augustin <mitchell.augustin@canonical.com> wrote:

> Thanks for the breakdown!
> 
> > That alone calls __pci_read_base() three separate times, each time
> > disabling and re-enabling decode on the bridge. [...] So we're
> > really being bitten that we toggle decode-enable/memory enable
> > around reading each BAR size  
> 
> That makes sense to me. Is this something that could theoretically be
> done in a less redundant way, or is there some functional limitation
> that would prevent that or make it inadvisable? (I'm still new to pci
> subsystem debugging, so apologies if that's a bit vague.)

The only requirement is that decode should be disabled while sizing
BARs, the fact that we repeat it around each BAR is, I think, just the
way the code is structured.  It doesn't take into account that toggling
the command register bit is not a trivial operation in a virtualized
environment.  IMO we should push the command register manipulation up a
layer so that we only toggle it once per device rather than once per
BAR.  Thanks,

Alex


