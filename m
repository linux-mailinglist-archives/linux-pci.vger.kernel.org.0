Return-Path: <linux-pci+bounces-15950-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFD99BB565
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 14:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 087F5B23FA4
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 13:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7D81B85D7;
	Mon,  4 Nov 2024 13:06:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C043B1B6D0B;
	Mon,  4 Nov 2024 13:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730725600; cv=none; b=FMYtLjPjk3Q93hV84sGDWaleSFXh2gsaNTk9EPdiCVZNgMI0sroCETfENWJf0ffoKLpslV1Vdzi5goTL4SwMjPRFPnu483UZfU+V3selwyw3cgPz+MeQjv1/x6yHB5fPT5bipp9nXBVbv2Ll+tgREKO9/TcKxjMkeKViJVIeHCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730725600; c=relaxed/simple;
	bh=Z8Csq6hrKg3KO0AmuTvJHxxhxuekmefkA3lKLHhWbtA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:Cc:To:
	 References:In-Reply-To; b=frdPTouaSPrvsaRTj1sDVWK/eBzMY2zlL/q5InV7kODFRe1oz0tJfX2ByhkHeN2rX65UHWMSWH83BzWn+kwufABm0hhWBqZD6UZR3/6vKfw5PSssIxQNsaF7yl6eib49GMZbWRkktOf6+mgiNH3RkWVHmj0NjtLp6fmvYWQhumo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7eae96e6624so3005910a12.2;
        Mon, 04 Nov 2024 05:06:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730725598; x=1731330398;
        h=in-reply-to:references:to:cc:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zZzOT97FdjuvYJUzFPlXRhKn4ZHWlskpvnv56Nhd+Gg=;
        b=EJKbeNbdWia8kJ3rZUoVQBEd4OB+7ZgxWl3aRneCiQ727B0FW1P2ATSVGA1RykkqBO
         RVQNbH8CibA35ntrG6SyvuJZKthVUX6SfQnAbtA/gX9Gdk1BTO3zwJvICGvuWw44foND
         80soMYeTNnF4A73erGFQohL9ZJv9fIIkKX2Sm5C3iAaUPRNXwF/b1I8al/+7Nm2IBzGx
         fQiGT8jpKpUd8ABrHoK3UKkH5DRd+1yWocjGdtr7dO5Rx733pGyfzDpDUSyudov2imAR
         ZhEUPvLGrWL3QeJVXPC755gkTtE7vCBJcXVw8wJDvZhVq2atM4QJ55msjrCSV36AsDNl
         PHtw==
X-Forwarded-Encrypted: i=1; AJvYcCXmLeLhrOMLyMweOFnv/s67G1OtiJXmZC4IPjjsiUCNlRankaer89CE7WQ+sZqto652bhlil/fpi9zQYBk=@vger.kernel.org, AJvYcCXqOuKk+kseNwOm3VZjumxQJE7yW/jmVNRvgpb8D8b6Xr7wewfpcmVJbfs1RA3epzg5OLlG3K/TrEAB@vger.kernel.org
X-Gm-Message-State: AOJu0YyFYlw9szoN0JhiDmMnRfymW3lvIG4ILX2vCVS1XtKVM28Mwq9y
	RBqki0jRPuVHPo6ryowarqu9suphLPL79g4tYtTV4JI4bVqwhKnw5y5qx0g9
X-Google-Smtp-Source: AGHT+IHCAHuac8LcRXb6oXySdYiXNuST/E5hZ792qvOEl2kds238Dclz1//IuMmOtE6OMUv4eXmd6A==
X-Received: by 2002:a17:90b:3755:b0:2e2:de27:db09 with SMTP id 98e67ed59e1d1-2e8f1078c4dmr33747346a91.19.1730725597840;
        Mon, 04 Nov 2024 05:06:37 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93da8e879sm7544666a91.10.2024.11.04.05.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 05:06:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 Nov 2024 22:06:35 +0900
Message-Id: <D5DF0QIO2UZQ.29U999LYCC05M@rocinante>
Subject: Re: [PATCH v4 1/2] PCI: mediatek-gen3: Add support for setting
 max-link-speed limit
From: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: <ryder.lee@mediatek.com>, <jianjun.wang@mediatek.com>,
 <lpieralisi@kernel.org>, <robh@kernel.org>, <bhelgaas@google.com>,
 <matthias.bgg@gmail.com>, <linux-mediatek@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <kernel@collabora.com>, <fshao@chromium.org>, "Manivannan Sadhasivam"
 <manivannan.sadhasivam@linaro.org>
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 <linux-pci@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20241104114935.172908-1-angelogioacchino.delregno@collabora.com> <20241104114935.172908-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20241104114935.172908-2-angelogioacchino.delregno@collabora.com>

Hello,

> +	if (err > 0) {

You could drop > 0 here.

> +		/* Get the maximum speed supported by the controller */
> +		max_speed =3D mtk_pcie_get_controller_max_link_speed(pcie);
> +
> +		/* Set max_link_speed only if the controller supports it */
> +		if (max_speed >=3D 0 && max_speed <=3D err) {
> +			pcie->max_link_speed =3D err;
> +			dev_dbg(pcie->dev,
> +				"Max controller link speed Gen%d, override to Gen%u",
> +				max_speed, pcie->max_link_speed);
> +		}
> +	}

I wonder if this debug message would be better served as a warning to let
the user know that the speed has been overridden due to the platform
limitation.  Thoughts?

Also, there is no need to sent a new series if you fine with the
suggestions.  I will mend the code on the branch when applying.

	Krzysztof

