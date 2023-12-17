Return-Path: <linux-pci+bounces-1098-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D355815D41
	for <lists+linux-pci@lfdr.de>; Sun, 17 Dec 2023 04:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C6D91F2217F
	for <lists+linux-pci@lfdr.de>; Sun, 17 Dec 2023 03:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D5BEA9;
	Sun, 17 Dec 2023 03:08:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05911FA1;
	Sun, 17 Dec 2023 03:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-28aea039fb4so2267537a91.1;
        Sat, 16 Dec 2023 19:08:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702782533; x=1703387333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EYrUdsjmxHgO0jc3Qc76TYV2jlq9cGuy8R/Rh9fQFg=;
        b=OpCX7+DvelKyvrQtF85g2G59SfM7UTXW5KrU4ixF109mi7Qs/jX3vg3QPkCEXMVgr5
         +gEcM3UNgQe+BmM5KfCrSqqmamtGhCYNMffjBtWX2qKa7pTnlbS42GaKKyPfHxNKyPBv
         y1i0j3iZc/+T6HNM+Gog5xNflSugPO1TkP+HJBQGl3fd5rEX24qnePI7TgtjV8SvYLgk
         TR7asVw2nRpvirhNBhY+Ya7VEzN4dm64oY8yQfzwFneks8yhUruo4HOGxL4q57P6wafA
         f0mKhm4goa6aHQrjRnIBEk11VssE2FhRiGT3nUtzMtqPl2own6CVS2OEkbv1hLtl240n
         ci3g==
X-Gm-Message-State: AOJu0YxyJbO37rDagwAFYEqdIlMwJlrDnK0KGRDCK7AQJTVT7wcwXi5D
	Uvg+EqApAy75/yq9IwdzXUA=
X-Google-Smtp-Source: AGHT+IF5rYgpBeHDXBSQrxqJuotxyyj8yMPFVM3tC4o8PGngNr83cp2TqMW/o3kOLUZg0E6/YKvLzg==
X-Received: by 2002:a17:90a:9318:b0:28b:70b:1939 with SMTP id p24-20020a17090a931800b0028b070b1939mr6900001pjo.6.1702782532941;
        Sat, 16 Dec 2023 19:08:52 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id l2-20020a17090a598200b0028ad7a2867asm8158604pji.17.2023.12.16.19.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 19:08:52 -0800 (PST)
Date: Sun, 17 Dec 2023 12:08:50 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Xiaowei Song <songxiaowei@hisilicon.com>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: kirin: Use devm_kasprintf()
Message-ID: <20231217030850.GA1150418@rocinante>
References: <1bad6879083a7d836c8a47418a0afa22485e8f69.1700294127.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bad6879083a7d836c8a47418a0afa22485e8f69.1700294127.git.christophe.jaillet@wanadoo.fr>

Hello,

> Use devm_kasprintf() instead of hand writing it.
> This saves the need of an intermediate buffer.
> 
> There was also no reason to use the _const() version of devm_kstrdup().
> The string was known be not constant.

Applied to controller/kirin, thank you!

[1/1] PCI: kirin: Use devm_kasprintf() to dynamically allocate clock names
      https://git.kernel.org/pci/pci/c/9f5077ef8f81

	Krzysztof

