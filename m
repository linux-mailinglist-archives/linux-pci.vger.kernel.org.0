Return-Path: <linux-pci+bounces-142-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B02877F501E
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 20:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE8E21C20A0D
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 19:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EB35C8F2;
	Wed, 22 Nov 2023 19:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="f5FYTGOF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEF083
	for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2023 11:03:33 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6cb55001124so897030b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2023 11:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700679813; x=1701284613; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOLdYcijIO7thn8jsDetINRnFijJW1e4OH9zLA5Yvvw=;
        b=f5FYTGOFrb4YOB0OTxPmZly0Bav5YcwohrNO/c9unqtQvmKB5j6TNmBcuJQbQhTlIH
         59qXFcbnPoSBQvUrARYeBNHbwhw+WSJv67KwtB0ePVqeueiY7PyanH1kWkbO6y6kIbEH
         XFsUHSsis20+WWAcdhT5byE6SBdX0zZ1o8cBAh8AXmE+hzdlBzDcudt5zuI05XBRnka4
         5238pdmek6GygfAM4z09A5seASREhM9+vDJvy0XczQglTIx7J9HnEZYYxr1OYO7kx70Q
         unoiW/1eZJW7Xc71LT9U7pdluX6O8loJI1YftmwIbjDykffPljnlxL9+x6kRjcVC00ZK
         kGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700679813; x=1701284613;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOLdYcijIO7thn8jsDetINRnFijJW1e4OH9zLA5Yvvw=;
        b=gLpbvXbNs1tMhDx1+AZ7e4M6R08eu0jIq9XR7CXh+Xhg2+GpGopRMgOca7bBbRfbg3
         gh0N2NIOwTOw7rKxSGQKWm/abFXjdxdft8h+RD8Rq9j7XTDylLgFiHeJ7tx7o6Gfbslh
         9Fc0afThzT8fiPyecg9wXiCZsQnJ7jNF60FixVyFUBXtU7T2N9TTMMVOrBaGoYbZLA/N
         bJJJsv7lpFyfq3zTpuixvZZkAGZxsyxQPnEkn+HPvnYFJNqKafR29fft2/Mo+V5H2m4B
         E3nO1QS+XLXK+zf+EbMqbfQ5nRH376ThoNR9efxfeeT1nyn2eGnhUQmeXBKYrI4im/vF
         SQWA==
X-Gm-Message-State: AOJu0YwIFGEWkEk1CXpGzMNIQfGmvvyWY87k/Wdayc8t3Wyp7MhUdaX7
	aezkjH8cMl5xqJA5cXxT9VfGkg==
X-Google-Smtp-Source: AGHT+IFtg8UhB/IW893ev1ejFzLCjzIDe0vE+PhAUIZrEsvxLPF4/bAYxeM1DsjneYPxE/CTC10KiA==
X-Received: by 2002:a05:6a20:7346:b0:187:4e8c:ac5c with SMTP id v6-20020a056a20734600b001874e8cac5cmr598810pzc.1.1700679813325;
        Wed, 22 Nov 2023 11:03:33 -0800 (PST)
Received: from smtpclient.apple (76-10-188-40.dsl.teksavvy.com. [76.10.188.40])
        by smtp.gmail.com with ESMTPSA id s20-20020a056a00195400b006c0fe2cf26csm62152pfk.107.2023.11.22.11.03.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Nov 2023 11:03:32 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v4 1/1] PCI: switchtec: Fix stdev_release() crash after
 surprise hot remove
From: Daniel Stodden <dns@arista.com>
In-Reply-To: <20231122155531.GA300313@bhelgaas>
Date: Wed, 22 Nov 2023 11:03:19 -0800
Cc: Dmitry Safonov <dima@arista.com>,
 Logan Gunthorpe <logang@deltatee.com>,
 Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
 linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9E735FE1-5AF4-44F5-BDCC-A4AAE5799269@arista.com>
References: <20231122155531.GA300313@bhelgaas>
To: Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: Apple Mail (2.3731.700.6)



> On Nov 22, 2023, at 7:55 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>=20
> On Tue, Nov 21, 2023 at 08:23:16PM -0800, Daniel Stodden wrote:
>> A PCI device hot removal may occur while stdev->cdev is held open. =
The call
>> to stdev_release() then happens during close or exit, at a point way =
past
>> switchtec_pci_remove(). Otherwise the last ref would vanish with the
>> trailing put_device(), just before return.
>>=20
>> At that later point in time, the devm cleanup has already removed the
>> stdev->mmio_mrpc mapping. Also, the stdev->pdev reference was not a =
counted
>> one. Therefore, in DMA mode, the iowrite32() in stdev_release() will =
cause
>> a fatal page fault, and the subsequent dma_free_coherent(), if =
reached,
>> would pass a stale &stdev->pdev->dev pointer.
>>=20
>> Fix by moving MRPC DMA shutdown into switchtec_pci_remove(), after
>> stdev_kill(). Counting the stdev->pdev ref is now optional, but may =
prevent
>> future accidents.
>>=20
>> Reproducible via the script at
>> https://lore.kernel.org/r/20231113212150.96410-1-dns@arista.com
>>=20
>> Link: https://lore.kernel.org/r/20231113212150.96410-2-dns@arista.com
>> Signed-off-by: Daniel Stodden <dns@arista.com>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
>> Reviewed-by: Dmitry Safonov <dima@arista.com>
>=20
> Oh, I forgot to mention: for future reference, you should only add
> Signed-off-by when you create the patch or you receive it from
> somebody else and are passing it on.
>=20
> You should not add the Signed-off-by of the person you're sending it
> *to*, because that person will add their own Signed-off-by when they
> process it.  E.g., I apply patches with "git am --signoff" which adds
> my Signed-off-by, which would result in a duplicate.
>=20
> No worries, I took care of it so there's no duplicate for me :)

Foremost thanks for rolling the thing back again. Much appreciated.

It did occur to me before emailing thatI might as well remove it again. =
However, since the v4  change notice
explictly mentioned that v4 was re-made from your prior v3 commit =E2=80=94=
 to not lose the commentary updates =E2=80=94
it seemed more like a passing-it-on---again. So I left it.

If it risks messing with your workflow =E2=80=94 sorry.

Then again, since the whole thing made a loop out of what=E2=80=99s =
normally a fairly linear process,
seemed, to me, potentially messy either way. At that point.

Daniel





