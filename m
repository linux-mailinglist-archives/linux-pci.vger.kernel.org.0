Return-Path: <linux-pci+bounces-1701-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD83824F2D
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jan 2024 08:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CE191C228F8
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jan 2024 07:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D772E134A2;
	Fri,  5 Jan 2024 07:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aMo8RiMg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D481DDF5
	for <linux-pci@vger.kernel.org>; Fri,  5 Jan 2024 07:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a27e323fdd3so130749566b.2
        for <linux-pci@vger.kernel.org>; Thu, 04 Jan 2024 23:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704439586; x=1705044386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XXmyQ3cK0lczqAL+Dlzgj8zEo8SB1elDU46lsB3o5/s=;
        b=aMo8RiMgkO6yIgsVD+IHycJCzOxZ086kskaxV9AEnLLmDb0ma60mr0TgVsilG+vA7O
         lvcorUPJnRd3oHkgNsdoAEbK3pAbvZ4o0ZnmvJyMlqp/Yf7N6WkvWqgg+BnC4DUjOVhv
         nHu9Ez1BRIF+a5sHjkNliVJ9wP//3O1qG1vb4a/LM29COc3xMPsoJJtZ0JSWnuh0qrju
         cP7I79yjglaF4f0CJ10ucryZWs3r+Xg5hplaELMBUmH5wORF06hcu1JfX3uJyFsQ1oSX
         TGsCODJfz2HjXRS1TGJFuCEJBwBBdrJISnxuasmrNoT8Yu+oVQQUK4yNZt+k7rq6qjxK
         S1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704439586; x=1705044386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXmyQ3cK0lczqAL+Dlzgj8zEo8SB1elDU46lsB3o5/s=;
        b=qO3nSeTbzk8pk1CEbAt/Kq5XIEpN2fm6R6mLDa+AdpOcTOZ6hyCUMBn+lX8PjUgrbI
         58I2YDFmYDIDbYTCuQVO+EeXYT+RkANdDsuXJWc0/bG27FrY8ccDzuWL7DpyHpVuTV/h
         wwyWVbCnzQxyK0YyttUOe+jcchO8Qrj4yxE+bMZ5STEKPiBtLeKhigluRWyWWvawGR80
         16SUkO52sMBgfRr+b77UP3WULo3BAYR2nNxKciHquDKG1l4dOupqGkKvis6Z+LUt4jmt
         pd+p3YFlvyt1gPG7/5ULzf5qvvMbYMoHKXlnTi+WSa0kQrLg6wQUZU6SD2ObbuJy5as5
         xTEQ==
X-Gm-Message-State: AOJu0YxX42Y52cRFMaCkE6uC4H8EWfe6NvFY1yZMgxl9P6IhmBHza0t/
	R/2HH36DfiYdwosjshTgtd1Lqz4K+jQy4SjblLpSuxOg/wg=
X-Google-Smtp-Source: AGHT+IEHM0HpBfr/7q3jF2d4SfDju+KfaVpClgb40z0NIsrx6Yw15SxEf8lZupq130B5vQbW8Cy2BA==
X-Received: by 2002:a17:906:fe41:b0:a28:b0c8:1b66 with SMTP id wz1-20020a170906fe4100b00a28b0c81b66mr1023969ejb.12.1704439586215;
        Thu, 04 Jan 2024 23:26:26 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id n15-20020a170906724f00b00a28148beabdsm547993ejk.102.2024.01.04.23.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 23:26:25 -0800 (PST)
Date: Fri, 5 Jan 2024 10:26:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Eric Dumazet <edumazet@google.com>, alexis.lothore@bootlin.com,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/P2PDMA: Fix a sleeping issue in a RCU read section
Message-ID: <06711233-64e7-4f24-8c37-40a90c6db1c5@moroto.mountain>
References: <02d9ec4a10235def0e764ff1f5be881ba12e16e8.1704397858.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02d9ec4a10235def0e764ff1f5be881ba12e16e8.1704397858.git.christophe.jaillet@wanadoo.fr>

On Thu, Jan 04, 2024 at 08:52:35PM +0100, Christophe JAILLET wrote:
> It is not allowed to sleep within a RCU read section, so use GFP_ATOMIC
> instead of GFP_KERNEL here.
> 
> Fixes: ae21f835a5bd ("PCI/P2PDMA: Finish RCU conversion of pdev->p2pdma")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is speculative.
> It is based on a discussion related to another patch. See [1].
> 
> It also matches the doc, IIUC. See [2]
> 
> [1]: https://lore.kernel.org/all/20240104143925.194295-3-alexis.lothore@bootlin.com/
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/RCU/whatisRCU.rst#n161

Looks good to me.

Smatch is supposed to catch this sort of bug but there are some issues
with xa_store it's normally holding the the xas_lock() but if you pass
a sleeping GFP_ then it drops the lock in __xas_nomem().  Sort of
tricky.  So right now all xa_store() stuff triggers a false positive
but tomorrows version of Smatch will just miss this bug.

regards,
dan carpenter


