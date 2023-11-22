Return-Path: <linux-pci+bounces-79-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E13A07F3AFA
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 02:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69736282A0B
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 01:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21041381;
	Wed, 22 Nov 2023 01:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Imy3rUzv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B96199
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 17:02:36 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ce95f96edcso28882305ad.0
        for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 17:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700614955; x=1701219755; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uLPxZdGdtAkndi+EClYkjFxG6VGmX6APmFGKHZxiS4=;
        b=Imy3rUzvhnI8U3n3B6lTil3W3GjunJ0RxofZlCFY88W0S7UC7ZM7LQ2WyRbrIatBWn
         SBg4si+QJHrY1+sKTKflNzdR6mygzSavV02aQyrAsIo9InF4vX+zxjFqcNBSHu0Z40D5
         uCTJFYvVmrCT9RyRVh0qU/M8wr2bYF7Zj8URqzH/5PiWQDfPkg/WZ9bP2hJaC0adK7lg
         Haoxv/q7NVr7iT9ZJ/Q+SCKDSYBQdoeU6+vdTC/2qCiAJ0N9g+wjGwYy4VNXopBzTWxJ
         QNk92gMbaFV3Li+QRM62Y+Tar/pgh27nZEGPBBJ322Koc3JcaSgduJzSBwAozz0JWakd
         OuMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700614955; x=1701219755;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7uLPxZdGdtAkndi+EClYkjFxG6VGmX6APmFGKHZxiS4=;
        b=D4ILCDL+oTnpNnT7BqpslkxfM5TUVPLMXO7R/zpeuDInObSD+kJf8V7ApatV18Gzu9
         mDUuhWLqUHkBgT53ZEVINPBgjxLwnCj938lS1TTAp3UkOWVyVWUEhVgYNyn4BHoMWBcq
         5zgJpTd6xkh62iDtAMr1pbw3BAhv0Eu3SJtHH4HTAcdQpA0Rd8Pwj5JSINBnlGOpSzHK
         4CWaRslciNbUK7WwIuHSfq4hy2VPb0XFWMLpwFRvZEdSss3pPH4QCCXZiN3EbjrMCO3U
         rV7Uvfn2MkidbPc15cHKv9wHZLSAKDO+/5qxoi3dHH/j0SIft+ySCIgMi5ahR6igDaqr
         /yjw==
X-Gm-Message-State: AOJu0Ywx957lsc/KI27yUEttC7ysqbWHKdo4Ue/q/XBa/kfjJrch9Sno
	CFHDJn/ZwrpoSfT2aHTc07xb9w==
X-Google-Smtp-Source: AGHT+IF+syiaRyuCU4h7cAhhhzZj7oz7Oxl3vK4FGuhsRvyH+Gve8e7Nq/yQUm/zIbj398BsM0gpIg==
X-Received: by 2002:a17:902:d312:b0:1cf:531c:f5da with SMTP id b18-20020a170902d31200b001cf531cf5damr655724plc.60.1700614955370;
        Tue, 21 Nov 2023 17:02:35 -0800 (PST)
Received: from smtpclient.apple (76-10-188-40.dsl.teksavvy.com. [76.10.188.40])
        by smtp.gmail.com with ESMTPSA id n11-20020a1709026a8b00b001ce6649d088sm7060340plk.195.2023.11.21.17.02.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Nov 2023 17:02:34 -0800 (PST)
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
In-Reply-To: <20231122004125.GA265607@bhelgaas>
Date: Tue, 21 Nov 2023 17:02:22 -0800
Cc: Dmitry Safonov <dima@arista.com>,
 Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
 Logan Gunthorpe <logang@deltatee.com>,
 linux-pci@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E3D7B584-12D8-4FFD-AF88-226921FCEE52@arista.com>
References: <20231122004125.GA265607@bhelgaas>
To: Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: Apple Mail (2.3731.700.6)


I apologize for the confusion.=20

Re-starting this thread wasn=E2=80=99t much about adding more reviewer =
names.

What I meant was what came out of his review:

diff --git a/drivers/pci/switch/switchtec.c =
b/drivers/pci/switch/switchtec.c
index 073d0f7f5e43..b1990bde688c 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1387,6 +1387,7 @@ static struct switchtec_dev *stdev_create(struct =
pci_dev *pdev)

 err_put:
        put_device(&stdev->dev);
+       pci_dev_put(stdev->pdev);
        return ERR_PTR(rc);
 }


I probably should not=E2=80=99 have put that patch fragment at the far =
end of my email, past the signature.

If you prefer a v4, I=E2=80=99ll make a v4.

Sorry again,
Daniel

> On Nov 21, 2023, at 4:41 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>=20
> On Wed, Nov 22, 2023 at 12:37:33AM +0000, Dmitry Safonov wrote:
>> On 11/13/23 21:21, Daniel Stodden wrote:
>>> A pci device hot removal may occur while stdev->cdev is held open. =
The
>>> call to stdev_release is then delivered during close or exit, at a
>>> point way past switchtec_pci_remove. Otherwise the last ref would
>>> vanish with the trailing put_device, just before return.
>>>=20
>>> At that later point in time, the device layer has alreay removed
>>> stdev->mrpc_mmio map. Also, the stdev->pdev reference was not a
>>> counted one. Therefore, in dma mode, the iowrite32 in stdev_release
>>> will cause a fatal page fault, and the subsequent dma_free_coherent,
>>> if reached, would pass a stale &stdev->pdev->dev pointer.
>>>=20
>>> Fixed by moving mrpc dma shutdown into switchtec_pci_remove, after
>>> stdev_kill. Counting the stdev->pdev ref is now optional, but may
>>> prevent future accidents.
>>>=20
>>> Signed-off-by: Daniel Stodden <dns@arista.com>
>>> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
>>=20
>> Just in case, duplicating on the patch.
>> With pci_dev_put(stdev->pdev) on stdev_create() err-path,
>>=20
>> Reviewed-by: Dmitry Safonov <dima@arista.com>
>=20
> OK, I'm totally lost.  Please post a v4 with the content you want.
>=20
> Bjorn



