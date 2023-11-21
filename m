Return-Path: <linux-pci+bounces-71-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA107F3A87
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 00:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88E961C208E4
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 23:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD162BAF4;
	Tue, 21 Nov 2023 23:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="emOxbQV1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14626D47
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 15:58:36 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cf50cc2f85so30758635ad.1
        for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 15:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700611115; x=1701215915; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDEfmsPJVwTEPggSSNFb6ShzjQpZbR38A7DZ6XZ2q80=;
        b=emOxbQV18fa6u5MG98QwU1aX2IsgrF70q90vQNgwhLqRDIhQUSc4TbOHeWYik61/uB
         SRRvinv+7+pFF1DMnmy8j7z6F/I4+0ZgcuVItDY9/CCNkFlLYz0m75mB98ICZzeWyFwr
         LKhnahgZQqDBa3RFgh61O+Be46FZInJrEvZ8/6IOR+eRlsD7UL1ZOe+ZV2W3AnwNMTxD
         7ak5hJTnVp/8itN4TCrOjKeXcEjznAUDI44VcYd/afOULhK9wxFaY9w9eKty4vd62skC
         s0V3elQfX/Is8iqRsIXDY0uW77mtSiZElFZ9JwbqyJvowz1aHNG3u2vSse9aGhDSzCwX
         3KHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700611115; x=1701215915;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JDEfmsPJVwTEPggSSNFb6ShzjQpZbR38A7DZ6XZ2q80=;
        b=wVOY6td/fq0niMWv0f9TNL3nFgC+bU4BZVs2VQU6qMnJptNidC/dDEuoKJBJl65fEb
         QHPgI7wa5pf3HffSk2tWHrkHbMCzaQY0tR2loqHa6mzSrFUWNH5N/XF0hK3YY3yeUo3d
         Bas7Djts38MJr+jOGdFocqgHhkDZj7CLx3KiebmWMf4v8obsHiGaBUNIomEP+ZjWG9aC
         JBsqevRyF3jmivZe0MkhYEV3q/eCKI73GfZ7TCyw03hf2KiRXneHM4v8xe4bxt841Y5X
         3fhK4Kx+IpA3dejvN0t6bVJtba6PNjrhfc8C9xzaDq5H/xbJC6wAw+JV/cZfQc2G5f9U
         BExQ==
X-Gm-Message-State: AOJu0YwbMBehNWouWZHQ5SdMvAFsIhjDAGhNmgHwWKy+IA4Y2IskTiOD
	q6x5Btb6yx8mAJbfTuqEe3AKGg==
X-Google-Smtp-Source: AGHT+IGp+BtUlQALUJJLsla+qeJzXa7pmzoyhcQrQA6HAbjosvcX7jOpb51SbfBYSr+OWQT8JQ1pug==
X-Received: by 2002:a17:903:2312:b0:1cc:4559:f5 with SMTP id d18-20020a170903231200b001cc455900f5mr898790plh.14.1700611115452;
        Tue, 21 Nov 2023 15:58:35 -0800 (PST)
Received: from smtpclient.apple (76-10-188-40.dsl.teksavvy.com. [76.10.188.40])
        by smtp.gmail.com with ESMTPSA id jw19-20020a170903279300b001b9da42cd7dsm8483523plb.279.2023.11.21.15.58.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Nov 2023 15:58:34 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v3] switchtec: Fix stdev_release crash after suprise
 device loss.
From: Daniel Stodden <dns@arista.com>
In-Reply-To: <20231121184008.GA249064@bhelgaas>
Date: Tue, 21 Nov 2023 15:58:22 -0800
Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
 Logan Gunthorpe <logang@deltatee.com>,
 linux-pci@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D34BC819-ACC4-4709-8464-73EEDDC64328@arista.com>
References: <20231121184008.GA249064@bhelgaas>
To: Bjorn Helgaas <helgaas@kernel.org>,
 Dmitry Safonov <dima@arista.com>
X-Mailer: Apple Mail (2.3731.700.6)



> On Nov 21, 2023, at 10:40 AM, Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>=20
> On Tue, Nov 21, 2023 at 10:23:51AM -0800, Daniel Stodden wrote:
>>> On Nov 20, 2023, at 1:25 PM, Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>>> On Mon, Nov 13, 2023 at 01:21:50PM -0800, Daniel Stodden wrote:
>>>> A pci device hot removal may occur while stdev->cdev is held open. =
The
>>>> call to stdev_release is then delivered during close or exit, at a
>>>> point way past switchtec_pci_remove. Otherwise the last ref would
>>>> vanish with the trailing put_device, just before return.
>>>>=20
>>>> At that later point in time, the device layer has alreay removed
>>>> stdev->mrpc_mmio map. Also, the stdev->pdev reference was not a
>>>=20
>>> I guess this should say the "stdev->mmio_mrpc" (not "mrpc_mmio")?
>>=20
>> Eww. My fault. Could you still correct that?
>=20
> Yep, I speculatively made that change already, so thanks for
> confirming it :)
>=20
> =
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=3Dsw=
itchtec&id=3Df9724598e29d

Thanks. And sorry for what=E2=80=99s next.=20

Look what I just found in my internal review inbox.

Signed-off/Reviewed-by: dima@arista.com

Want a v4, a follow-up, or can you re-edit that once more too, please?

Thanks + sorry,
Daniel


diff --git a/drivers/pci/switch/switchtec.c =
b/drivers/pci/switch/switchtec.c
index a82576205..ddaf87e10 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1331,6 +1331,7 @@ static struct switchtec_dev *stdev_create(struct =
pci_dev *pdev)

 err_put:
        put_device(&stdev->dev);
+       put_device(&stdev->pdev);
        return ERR_PTR(rc);
 }




