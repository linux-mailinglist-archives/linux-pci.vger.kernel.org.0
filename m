Return-Path: <linux-pci+bounces-721-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7B780AFB5
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 23:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A11F281C11
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 22:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88865381A0;
	Fri,  8 Dec 2023 22:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="EPLaGxFe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6A0171F
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 14:36:47 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-3580b94ac2eso12313085ab.0
        for <linux-pci@vger.kernel.org>; Fri, 08 Dec 2023 14:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1702075006; x=1702679806; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTAS+mJNgWsHeBDmGbDkXiFo61BW6ChMnjWwUEpmr04=;
        b=EPLaGxFe0QTCHbCkH1Ekjm5JeEhDtRWz5wSBL1LnbI8ZWocqtvPbP4Titm6OwKI627
         q/KT9QFXRW7zHljvZicEQDn1L2NhsTQBBU/lSo0Q2GINZi0MEiEh/SMeg2eG9onGkWEW
         sUOq1cNXJfdV2zvSzxSmGc1IVWHek2DusO9uELeYvBJsF2cv4ZpTlrIg06C5tfa25B3T
         BgI9t7cjSk0+bIFNEzeMPsXLUYtq6SPRlec23H9kwvfnwrZgIwc0s69yma9eJ2i8Zyj+
         cGqbIwnw1pQ1EqshVTLkUSBMyoVQeNrb1wUjVR2NoT3Ac+L75ty2Xl7J9bovzNw/tgeS
         blTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702075006; x=1702679806;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XTAS+mJNgWsHeBDmGbDkXiFo61BW6ChMnjWwUEpmr04=;
        b=fC7XOPNZq+adpMtTLyrUjsr62ywB/1iXjAVGrwV7BqSq42Z9oxIYAumZTJAzAEB87u
         DBhZNNuXlK729vR8rsMpsS2d9Hyims0UdRESn3YdM5MmIp5t7uYbF/f+oqfMfsC8kDuo
         YhYZF9ESqjI2scQ72k7W6v1+CZ7kdWBEy1T8dR1DM/0lpkmFMB/qhEWL0pLmVOkd1gl3
         4VWT3GOXAn7zxnRh2jyiCxFGHQ9E3zeQeYBwKodlQUePTyvAX+HLgvBA10rqQjSuh0Ft
         oeWAZ4K7OquBi4u5UEdn1aNnT5k805RERcLir9CPXOTyU0ugMnYaxTbwRkRT6RV0X/eC
         Je9g==
X-Gm-Message-State: AOJu0YwZWR+p3IF7/9/uzqQgXRnYHIERf45J6TZufVkjr5jj+nlQCzJ7
	wca2u/+lz7ty+1pxifVC0XH3tA==
X-Google-Smtp-Source: AGHT+IE0a9GGo0RusRyukny5pEcJKbdHLCl5qQKAqMExsa/8JQBn7RfxzYUXAdbnM9s4AVydTwRqNA==
X-Received: by 2002:a05:6e02:1a21:b0:35d:6aa4:d5bd with SMTP id g1-20020a056e021a2100b0035d6aa4d5bdmr966364ile.34.1702075006479;
        Fri, 08 Dec 2023 14:36:46 -0800 (PST)
Received: from smtpclient.apple (76-10-188-40.dsl.teksavvy.com. [76.10.188.40])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902ed0600b001d060bb0582sm2225149pld.165.2023.12.08.14.36.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Dec 2023 14:36:45 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v4 1/1] PCI: switchtec: Fix stdev_release() crash after
 surprise hot remove
From: Daniel Stodden <dns@arista.com>
In-Reply-To: <89bb5f95-61b0-4e93-a542-49d6c1276f97@wanadoo.fr>
Date: Fri, 8 Dec 2023 14:36:32 -0800
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 dima@arista.com,
 Bjorn Helgaas <helgaas@kernel.org>,
 kurt.schwemmer@microsemi.com,
 linux-pci@vger.kernel.org,
 logang@deltatee.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <2C3DA10C-7AA2-4073-ABB0-320D4D280B7C@arista.com>
References: <20231122042316.91208-2-dns@arista.com>
 <89bb5f95-61b0-4e93-a542-49d6c1276f97@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
X-Mailer: Apple Mail (2.3731.700.6)



> On Dec 7, 2023, at 1:08 PM, Christophe JAILLET =
<christophe.jaillet@wanadoo.fr> wrote:
>=20
>> A PCI device hot removal may occur while stdev->cdev is held open. =
The call
>> to stdev_release() then happens during close or exit, at a point way =
past
>> switchtec_pci_remove(). Otherwise the last ref would vanish with the
>> trailing put_device(), just before return.
>> At that later point in time, the devm cleanup has already removed the
>> stdev->mmio_mrpc mapping. Also, the stdev->pdev reference was not a =
counted
>> one. Therefore, in DMA mode, the iowrite32() in stdev_release() will =
cause
>> a fatal page fault, and the subsequent dma_free_coherent(), if =
reached,
>> would pass a stale &stdev->pdev->dev pointer.
>> Fix by moving MRPC DMA shutdown into switchtec_pci_remove(), after
>> stdev_kill(). Counting the stdev->pdev ref is now optional, but may =
prevent
>> future accidents.
>> Reproducible via the script at
>> https://lore.kernel.org/r/20231113212150.96410-1-dns@arista.com
>> Link: https://lore.kernel.org/r/20231113212150.96410-2-dns@arista.com
>> Signed-off-by: Daniel Stodden <dns@arista.com>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
>> Reviewed-by: Dmitry Safonov <dima@arista.com>
> ---
>=20
> ...
>=20
>> @@ -1703,6 +1709,9 @@ static void switchtec_pci_remove(struct pci_dev =
*pdev)  >   ida_free(&switchtec_minor_ida, MINOR(stdev->dev.devt));
>> dev_info(&stdev->dev, "unregistered.\n");
>> stdev_kill(stdev);
>> + switchtec_exit_pci(stdev);  > + pci_dev_put(stdev->pdev); > + =
stdev->pdev =3D NULL; >   put_device(&stdev->dev);
>> }
> Hi,
>=20
> does a similarswitchtec_exit_pci() should be called in the error =
handling path of switchtec_pci_probe() if an error occurs after =
switchtec_init_pci()?
>=20

Yep, that is correct.

Looks like this is actually another regression resulting from evacuating =
stdev_release.
Previous code could rely on the trailing put_device(), past err_put. No =
more.

Cheers,
Daniel


