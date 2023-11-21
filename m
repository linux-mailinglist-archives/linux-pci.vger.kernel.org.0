Return-Path: <linux-pci+bounces-52-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB127F35DD
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 19:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D8261C208FF
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 18:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F5815C1;
	Tue, 21 Nov 2023 18:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="HkX4eD+b"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9544E191
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 10:24:05 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5c18a3387f5so3558178a12.1
        for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 10:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700591045; x=1701195845; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoFy+5zY8AzZfi/p4KTXL2InlOSTkvBEaJ8keEbwN3k=;
        b=HkX4eD+b+qTwGOkKrsTGWu5/RQImWqhDpobhYWqUVjtqhY+7fjXC/axL4d9qhS2T4y
         n2mx1ZqHZnDIMMjZ2f4fFsdZ3UT5o0IRA1fRM+srgofNvh4lHA6I4yaNzz2oTtU3IrOB
         NZj7ApJxwnlp2SdcLg0bTwHle1tH1Hz2QId77fpyx2aYme43bSj9dEVwo8En1zvM2sBt
         5Vv+ugQ0ZRBTrlLDceS59NCNTHUWfDjkdaPb5Oqixk19f5zpaxY8eSWaC2aUfClgaXQ3
         xJ1Op0h3fdYQl9Ov/cUkxs/utKidlpE+zyvRkK15TN0/IVFX+2HFnBKqQbRYh5Oe32Sg
         5KcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700591045; x=1701195845;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qoFy+5zY8AzZfi/p4KTXL2InlOSTkvBEaJ8keEbwN3k=;
        b=UwlSVlurfLJ/OppGWmd62Bifd6H2aw8rCklc2/Q/qLriyQMCmv91rIlpw0LCC0OJ2D
         SIncebc4ffCEWIha65EO1T2g1ntVEswdm5N9deYjYFUJzHyddXIOtk6VpQ0qve2CKG6C
         aMoudXD34gR3qkZ9iMFK57wud/B37fdo/c0lEmy0sqR47nTWgjVkwB/OcbQA3lG6Z8FF
         vRFfAoGYWzDswKjDbOliPH4AEag/kxURAYrnjS+9d6vPSIJw3hRv6vXap2gV+HmxGnJY
         5bGcbjtjd+waEBZJ6IwKc9jqnnJRRq6PS0C9TyffG4Bw+jC+tB2hbyCjcCogAffkmpAc
         IjBQ==
X-Gm-Message-State: AOJu0YxEzhufdl6qbAEHI0lgMFUElhciE2Qplz609vMw9VOqJnXmyszm
	I0g4NsPReZgvSQAEPBHZbFeMaQ==
X-Google-Smtp-Source: AGHT+IG6OkIIcO0IRlOnM5fzxmAxocqkNaraTJ+KE8Wz+S3+NSqQe0j/ivRcctj26rW5HFV0iP1J7A==
X-Received: by 2002:a05:6a20:bea5:b0:187:652d:95b5 with SMTP id gf37-20020a056a20bea500b00187652d95b5mr6257220pzb.62.1700591044871;
        Tue, 21 Nov 2023 10:24:04 -0800 (PST)
Received: from smtpclient.apple (76-10-188-40.dsl.teksavvy.com. [76.10.188.40])
        by smtp.gmail.com with ESMTPSA id s23-20020a056a00179700b006cb6119f516sm6032937pfg.163.2023.11.21.10.24.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Nov 2023 10:24:04 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v3] switchtec: Fix stdev_release crash after suprise
 device loss.
From: Daniel Stodden <dns@arista.com>
In-Reply-To: <20231120212546.GA215889@bhelgaas>
Date: Tue, 21 Nov 2023 10:23:51 -0800
Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
 Logan Gunthorpe <logang@deltatee.com>,
 linux-pci@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BDEC1856-B689-433B-9227-4CCA5969C2F2@arista.com>
References: <20231120212546.GA215889@bhelgaas>
To: Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: Apple Mail (2.3731.700.6)

Hi.

> On Nov 20, 2023, at 1:25 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>=20
> On Mon, Nov 13, 2023 at 01:21:50PM -0800, Daniel Stodden wrote:
>> A pci device hot removal may occur while stdev->cdev is held open. =
The
>> call to stdev_release is then delivered during close or exit, at a
>> point way past switchtec_pci_remove. Otherwise the last ref would
>> vanish with the trailing put_device, just before return.
>>=20
>> At that later point in time, the device layer has alreay removed
>> stdev->mrpc_mmio map. Also, the stdev->pdev reference was not a
>=20
> I guess this should say the "stdev->mmio_mrpc" (not "mrpc_mmio")?

Eww. My fault. Could you still correct that?

>=20
>> counted one. Therefore, in dma mode, the iowrite32 in stdev_release
>> will cause a fatal page fault, and the subsequent dma_free_coherent,
>> if reached, would pass a stale &stdev->pdev->dev pointer.
>>=20
>> Fixed by moving mrpc dma shutdown into switchtec_pci_remove, after
>> stdev_kill. Counting the stdev->pdev ref is now optional, but may
>> prevent future accidents.
>>=20
>> Signed-off-by: Daniel Stodden <dns@arista.com>
>> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
>=20
> Thanks, applied to "switchtec" for v6.8

Thank you.

Daniel

>> ---
>> drivers/pci/switch/switchtec.c | 24 ++++++++++++++++--------
>> 1 file changed, 16 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/drivers/pci/switch/switchtec.c =
b/drivers/pci/switch/switchtec.c
>> index e69cac84b605..d8718acdb85f 100644
>> --- a/drivers/pci/switch/switchtec.c
>> +++ b/drivers/pci/switch/switchtec.c
>> @@ -1251,13 +1251,6 @@ static void stdev_release(struct device *dev)
>> {
>> struct switchtec_dev *stdev =3D to_stdev(dev);
>>=20
>> - if (stdev->dma_mrpc) {
>> - iowrite32(0, &stdev->mmio_mrpc->dma_en);
>> - flush_wc_buf(stdev);
>> - writeq(0, &stdev->mmio_mrpc->dma_addr);
>> - dma_free_coherent(&stdev->pdev->dev, sizeof(*stdev->dma_mrpc),
>> - stdev->dma_mrpc, stdev->dma_mrpc_dma_addr);
>> - }
>> kfree(stdev);
>> }
>>=20
>> @@ -1301,7 +1294,7 @@ static struct switchtec_dev =
*stdev_create(struct pci_dev *pdev)
>> return ERR_PTR(-ENOMEM);
>>=20
>> stdev->alive =3D true;
>> - stdev->pdev =3D pdev;
>> + stdev->pdev =3D pci_dev_get(pdev);
>> INIT_LIST_HEAD(&stdev->mrpc_queue);
>> mutex_init(&stdev->mrpc_mutex);
>> stdev->mrpc_busy =3D 0;
>> @@ -1587,6 +1580,18 @@ static int switchtec_init_pci(struct =
switchtec_dev *stdev,
>> return 0;
>> }
>>=20
>> +static void switchtec_exit_pci(struct switchtec_dev *stdev)
>> +{
>> + if (stdev->dma_mrpc) {
>> + iowrite32(0, &stdev->mmio_mrpc->dma_en);
>> + flush_wc_buf(stdev);
>> + writeq(0, &stdev->mmio_mrpc->dma_addr);
>> + dma_free_coherent(&stdev->pdev->dev, sizeof(*stdev->dma_mrpc),
>> +  stdev->dma_mrpc, stdev->dma_mrpc_dma_addr);
>> + stdev->dma_mrpc =3D NULL;
>> + }
>> +}
>> +
>> static int switchtec_pci_probe(struct pci_dev *pdev,
>>       const struct pci_device_id *id)
>> {
>> @@ -1646,6 +1651,9 @@ static void switchtec_pci_remove(struct pci_dev =
*pdev)
>> ida_simple_remove(&switchtec_minor_ida, MINOR(stdev->dev.devt));
>> dev_info(&stdev->dev, "unregistered.\n");
>> stdev_kill(stdev);
>> + switchtec_exit_pci(stdev);
>> + pci_dev_put(stdev->pdev);
>> + stdev->pdev =3D NULL;
>> put_device(&stdev->dev);
>> }
>>=20
>> --=20
>> 2.41.0
>>=20


