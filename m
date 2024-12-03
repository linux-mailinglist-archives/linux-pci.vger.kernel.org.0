Return-Path: <linux-pci+bounces-17604-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2D89E2EA1
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 23:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64CD616213F
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 22:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7684D1F7554;
	Tue,  3 Dec 2024 22:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bqc7qY9M"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D20A1E00BE
	for <linux-pci@vger.kernel.org>; Tue,  3 Dec 2024 22:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733263589; cv=none; b=rTzBVI7y7zOu/IN0NsoZJJnBaHe4coIkX8jsQYA3NaD6Y4q17oMsNMy4jtMJMq6x2+mq221zUUM7xbO78p0vonKNG68HcPLXZ0xKmbTpASD6PS+fxFk4Ip7BVPBeROo89RuZyTxed4uhw3G+A209R/ecxRvmu4MwFypzHdwD2fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733263589; c=relaxed/simple;
	bh=AD9m5l1akbuPM1ybWrq29tq8zaQy3+HM6xJLensm4Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=odcmvoqzBZHHNSvRdg8p1/ikLBt1WJQa24vzFpXKKKNbeH187qr6oNwv//ZZYyuP9NID58Ufk7ZGTUubznJO+ULyyr4TxT6F4Tm77474l/K4LzqH3JuKL7ylpn+d8ACfLRi69DiWeLO5hhJl5+pjjsdJIKevq5nKLY6NGs4clPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bqc7qY9M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733263586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WIePSw9erBGB0EkQKOgbCaIeXQNXPbcij9sycEa1gJw=;
	b=bqc7qY9M13k/fi+/eIXlGtXlprb+CXf1VHQJYi8cz74ZjHWY3tsF3MKiX09BHDZ1pjCAvQ
	NhQCqfPtarVJD0TtRoFfqOn84USLCHGUSE+4Dz9cyd6YTcsqIOX5CtKy0NRVVsAYPFXcgy
	vMFQo0sIUaP/GEjloQa+aQ6PjLjeFW8=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-zp9UeeQoPvmzWB4QRKnUbw-1; Tue, 03 Dec 2024 17:06:25 -0500
X-MC-Unique: zp9UeeQoPvmzWB4QRKnUbw-1
X-Mimecast-MFC-AGG-ID: zp9UeeQoPvmzWB4QRKnUbw
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-71d4b284637so959722a34.0
        for <linux-pci@vger.kernel.org>; Tue, 03 Dec 2024 14:06:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733263584; x=1733868384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIePSw9erBGB0EkQKOgbCaIeXQNXPbcij9sycEa1gJw=;
        b=gjfL2pc0Oohr5nEnfxDQo5Rl+t37Sh8pr5i7jDH5m5CtUJ8T9AdR0Qa4NpzoIgzInH
         At3EWcFJXpDrSL3sXHQta9w+wFltzq0/PyqUVJFRX0GlXaPO2wbqL2FLf3uHPzIGmoEV
         BuNo7zk/w+Wkauqw3mUJP8uZ7nrPq3bjR1uOCzVfh/+hAyt5b+6Cg2nAfElrsvBtoaiD
         TWw72c5lpyacQTTThwWayKamGB57Y5ffNbKv8xor3+HrW8KO9TEox6mME5v9v4PJu9PK
         ruQzvgPLGFzEbRiqZMktDHknHGhse0IwteZCPw5GOrhcZVxHmpeQ6v0JCQ5Vi9+2P127
         tCMA==
X-Gm-Message-State: AOJu0YyRVY519O6+AhrqHLryfEMSGe3pY4Si5Ou2CP/VtPAVzN0KUI8u
	+Mx2dboeRhOEYQz4lW7di07u2YNStc7DyPWK4z9ineW2y+0lIy5ut49XkK2jpeNAZAyMTIO39r9
	vb7+luTz3mGKUBD/uFa/KchSgMvw7OEpfBbA7vE0YtOK868zFdRyZoY4fsw==
X-Gm-Gg: ASbGncui+phBotcyulmPWrOFm5ZRotXE31QLpJKJV96H6vdeL7WLaO2xhRNddPOUYzL
	liZaWsaWwTeTxtAdf7KM5PM8JK3V/rRikDUR8VlLT4bjUIjtihS8zWjmNyAYCezkNy4FNroJ6hd
	CIr5iJApOzFYfoZJvzLWdaEsotS9YroT8zyrlbp/J8BvdTjh8ZeyJaanZz0IiMjSWV3edmTcj8I
	qLr6TtjLdTtVeOLNycI74v2mrE35Z4s/WPOuRm6lQzGWXYd/SGaQw==
X-Received: by 2002:a05:6870:82a0:b0:29e:723c:8e9d with SMTP id 586e51a60fabf-29e8864ab96mr932474fac.4.1733263584306;
        Tue, 03 Dec 2024 14:06:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7jGvGfB3Me4o3Jd6sSOMboIoUa4ByGG2+wC0X4ZrR+2bwV76NNF/fqntlqJRNv1VOTSapnA==
X-Received: by 2002:a05:6870:82a0:b0:29e:723c:8e9d with SMTP id 586e51a60fabf-29e8864ab96mr932465fac.4.1733263583944;
        Tue, 03 Dec 2024 14:06:23 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29de9945bc7sm4029719fac.43.2024.12.03.14.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 14:06:23 -0800 (PST)
Date: Tue, 3 Dec 2024 15:06:20 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Mitchell Augustin <mitchell.augustin@canonical.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, linux-kernel@vger.kernel.org
Subject: Re: drivers/pci: (and/or KVM): Slow PCI initialization during VM
 boot with passthrough of large BAR Nvidia GPUs on DGX H100
Message-ID: <20241203150620.15431c5c.alex.williamson@redhat.com>
In-Reply-To: <CAHTA-uZWGmoLr0R4L608xzvBAxnr7zQPMDbX0U4MTfN3BAsfTQ@mail.gmail.com>
References: <CAHTA-uYp07FgM6T1OZQKqAdSA5JrZo0ReNEyZgQZub4mDRrV5w@mail.gmail.com>
	<20241126103427.42d21193.alex.williamson@redhat.com>
	<CAHTA-ubXiDePmfgTdPbg144tHmRZR8=2cNshcL5tMkoMXdyn_Q@mail.gmail.com>
	<20241126154145.638dba46.alex.williamson@redhat.com>
	<CAHTA-uZp-bk5HeE7uhsR1frtj9dU+HrXxFZTAVeAwFhPen87wA@mail.gmail.com>
	<20241126170214.5717003f.alex.williamson@redhat.com>
	<CAHTA-uY3pyDLH9-hy1RjOqrRR+OU=Ko6hJ4xWmMTyoLwHhgTOQ@mail.gmail.com>
	<20241127102243.57cddb78.alex.williamson@redhat.com>
	<CAHTA-uaGZkQ6rEMcRq6JiZn8v9nZPn80NyucuSTEXuPfy+0ccw@mail.gmail.com>
	<20241203122023.21171712.alex.williamson@redhat.com>
	<CAHTA-uZWGmoLr0R4L608xzvBAxnr7zQPMDbX0U4MTfN3BAsfTQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Dec 2024 14:33:10 -0600
Mitchell Augustin <mitchell.augustin@canonical.com> wrote:

> Thanks.
> 
> I'm thinking about the cleanest way to accomplish this:
> 
> 1. I'm wondering if replacing the pci_info() calls with equivalent
> printk_deferred() calls might be sufficient here. This works in my
> initial test, but I'm not sure if this is definitive proof that we
> wouldn't have any issues in all deployments, or if my configuration is
> just not impacted by this kind of deadlock.

Just switching to printk_deferred() alone seems like wishful thinking,
but if you were also to wrap the code in console_{un}lock(), that might
be a possible low-impact solution.

> 2. I did also draft a patch that would just eliminate the redundancy
> and disable the impacted logs by default, and allow them to be
> re-enabled with a new kernel command line option
> "pci=bar_logging_enabled" (at the cost of the performance gains due to
> reduced redundancy). This works well in all of my tests.

I suspect Bjorn would prefer not to add yet another pci command line
option and as we've seen here, the logs are useful by default.
 
> Do you think either of those approaches would work / be appropriate?
> Ultimately I am trying to avoid messy changes that would require
> actually propagating all of the info needed for these logs back up to
> pci_read_bases(), if at all possible, since there seems like no
> obvious way to do that without changing the signature of
> __pci_read_base() or tracking additional state.

The calling convention of __pci_read_base() is already changing if
we're having the caller disable decoding and it doesn't have a lot of
callers, so I don't think I'd worry about changing the signature.

I think maybe another alternative that doesn't hold off the console
would be to split the BAR sizing and resource processing into separate
steps.  For example pci_read_bases() might pass arrays like:

        u32 bars[PCI_STD_NUM_BARS] = { 0 };
        u32 romsz = 0;

To a function like:

void __pci_read_bars(struct pci_dev *dev, u32 *bars, u32 *romsz,
                     int num_bars, int rom)
{
        u16 orig_cmd;
        u32 tmp;
        int i;

        if (!dev->mmio_always_on) {
                pci_read_config_word(dev, PCI_COMMAND, &orig_cmd);
                if (orig_cmd & PCI_COMMAND_DECODE_ENABLE) {
                        pci_write_config_word(dev, PCI_COMMAND,
                                orig_cmd & ~PCI_COMMAND_DECODE_ENABLE);
                }
        }

        for (i = 0; i < num_bars; i++) {
                unsigned int pos = PCI_BASE_ADDRESS_0 + (i << 2);

                pci_read_config_dword(dev, pos, &tmp);
                pci_write_config_dword(dev, pos, ~0);
                pci_read_config_dword(dev, pos, &bars[i]);
                pci_write_config_dword(dev, pos, tmp);
        }
                
        if (rom) {
                pci_read_config_dword(dev, rom, &tmp);
                pci_write_config_dword(dev, rom, PCI_ROM_ADDRESS_MASK);
                pci_read_config_dword(dev, rom, romsz);
                pci_write_config_dword(dev, rom, tmp);
        }

        if (!dev->mmio_always_on && (orig_cmd & PCI_COMMAND_DECODE_ENABLE))
                pci_write_config_word(dev, PCI_COMMAND, orig_cmd);
}

pci_read_bases() would then iterate in a similar way that it does now,
passing pointers to the stashed data to __pci_read_base(), which would
then only do the resource processing and could freely print.

To me that seems better than blocking the console... Maybe there are
other ideas on the list.  Thanks,

Alex


