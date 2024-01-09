Return-Path: <linux-pci+bounces-1868-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA82B827DDF
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 05:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99C121F2372C
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 04:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFF038A;
	Tue,  9 Jan 2024 04:37:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7626126;
	Tue,  9 Jan 2024 04:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so1960521a12.1;
        Mon, 08 Jan 2024 20:37:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704775044; x=1705379844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtN3ZmJcpck/YIjWiYKe7RqUHRSvK9EmrpKHkflf+yc=;
        b=MkyN5/F85gE0KCmuusdVEfSYpsXjxYPtbnfor0+gOQIWJEzrMP2rPjB3d2Z5CIrTLY
         1I8fydasRI6F7eqPhtsgV3FgmTtFuWV+y3Ijyjn16Yl3uPxViP08hLc7/+p9YGSSSaDB
         LuQq8tN57Ei2d0KYsoJGW7/8GI2CqoWTfH5i+xvLPdtG3cCtiIZudXLySClCQR3FNFJR
         foYhagdIs5Dt9TyprJou7K/v5JY45RkgKIkCQlvMeR5rnb38kEBb5rApDIBvEeJC2Bi4
         hivPA0y3b30Qwdd6d2VFx52eqmKzKxmmIVtwWWG+49GrfcRq/qepJy3+O321Hd/XUEIx
         vppA==
X-Gm-Message-State: AOJu0Yyh2iq1wpWS21XE3bAc3QkAqLUiLzFZrdnF4hZAnlzcrghj8TO2
	cFCDGlc22MirPNhYm8Lqmi8=
X-Google-Smtp-Source: AGHT+IGnrfnENkktTC/HAy6Kyi0hoSLypKBEOvQYS+HnmqXAaepthmPAB61zJkRpucbhbGE3JnmlAQ==
X-Received: by 2002:a05:6a20:4298:b0:199:ee99:86fb with SMTP id o24-20020a056a20429800b00199ee9986fbmr571650pzj.44.1704775043784;
        Mon, 08 Jan 2024 20:37:23 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id jx7-20020a17090b46c700b0028c05e64f3csm806325pjb.7.2024.01.08.20.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 20:37:23 -0800 (PST)
Date: Tue, 9 Jan 2024 13:37:21 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Jianjun Wang <jianjun.wang@mediatek.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, jieyy.yang@mediatek.com,
	chuanjia.liu@mediatek.com, qizhong.cheng@mediatek.com,
	jian.yang@mediatek.com
Subject: Re: [PATCH v2] PCI: mediatek-gen3: Fix translation window
Message-ID: <20240109043721.GA3337479@rocinante>
References: <20231023081423.18559-1-jianjun.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023081423.18559-1-jianjun.wang@mediatek.com>

Hello,

> The size of translation table should be a power of 2, using fls()
> cannot get the proper value when the size is not a power of 2. For
> example, fls(0x3e00000) - 1 = 25, hence the PCIe translation window
> size will be set to 0x2000000 instead of the expected size 0x3e00000.
> 
> Fix translation window by splitting the MMIO space to multiple tables if
> its size is not a power of 2.

Applied to controller/mediatek, thank you!

[1/1] PCI: mediatek-gen3: Fix translation window size calculation
      https://git.kernel.org/pci/pci/c/8b7b89ef507c

	Krzysztof

