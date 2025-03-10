Return-Path: <linux-pci+bounces-23387-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAD8A5A686
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 22:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7AEF1737CF
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 21:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5624437C;
	Mon, 10 Mar 2025 21:58:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA49936B;
	Mon, 10 Mar 2025 21:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741643882; cv=none; b=HwlFqxZB5zl4x8HULft9dFYmOiCFBzEjga6iM7juErhrYv/k7el5Zfjrbeyl+4OuKfHQ4m+gOvDUOMEiBjbFZTgp24QxWk+QK0MxZPr7Lm8/zBBcsqZsuIRfnruooKjr/cUZgw/j8ma5XlKGAZQNUqyTOAt9+bl4202gSKscQAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741643882; c=relaxed/simple;
	bh=7MT0cdOUDjuVEspylySZAy3uuOUbr9JOEWUtRBimMaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNiye9fZOyzL2+xLtrDby+72WJQetGXQDhRkxhAXDxm2FP1iZq2M3qxMQA/dribJohRm2YPVsQwkKwWcBgxXRr9lM4D+EeCoKngwNKiZahHjNhUFL1rGnTaEbVn6axj01mttLslyAiIdUbTfxTeuLrQ5+Q3cGaBwSKFZ6sW2EQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-223594b3c6dso84976905ad.2;
        Mon, 10 Mar 2025 14:58:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741643880; x=1742248680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZqba3gVX41zqsOhdc28XH+vmCDKWwigOXcxvppEBtM=;
        b=sgchSa2q9H99I7SuKK4LxRbgQu8xwHwZ3lTBiajys/Wg/yAFA/nkDhp/yt9UdXIWhZ
         S3Ifz6Sw6KRMS3lVT6bae5poghlMTyHRHiqV7ymMTQDH2Y5UZsHnfSJQldkigvFrBPH8
         bYoGC5XnkW7+SGfpLLYevCpIDI5nGorDK4XgIOvHk1TWDrkgzj3ldBoGboI7jD4ALHht
         bSv1bmVfgbGaaNygQL/A3cS+2u66YLt1xx7UhEHlNu4TACYng3wBa+5YPzBdHGT832kf
         A8prndzLLXumAi2VX3O7u4h+eW1e5PI16tynzjj+MhhGK1prb8yf4JWaVR+7EURlWa7r
         CdUg==
X-Forwarded-Encrypted: i=1; AJvYcCVEKkTYqNeYQNbhxdIiL6jbkxbsqEYGWLfOqn0aOvdjbQIz0REDu6WlmAHKEUXnoF7rqpxke+EJNYyP@vger.kernel.org, AJvYcCVKqYUrwQVO/PwLh6T4+1nHO/CzZJLNkuZJ8kIFFsyx9J70mIjWjJQFptVI2Ugg2eiHrFmbHMtQS3Xgbvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVQCTFmCbBYgw7DMutRemszgoEPuXSpJxgd1E+UvqE9lYEqGz/
	feOfdBlrn1QWLKZCqx7McMtEFouMrvklgzks2FJI0kUfNKHyQxqg
X-Gm-Gg: ASbGncsoh8/j1Kxn0vG3MLg7Gh00HO937tVqPW77NU9K4tZXb65p42CSQRONKOBT6Ra
	sgzpgr0vuZ2ILD9nqtizOwdoWq0oGe3ildzEYE8AzHvwbs3TBLyy1HFWrnwBd4XRWG9YeqLYxXN
	EkfGXDo633WYGUkRDLeBZVHnk1bQjseEprPa57yQt+y65pUAde4UmXwEFiy3cXpLJ/HycC6RJZd
	d5Bq2/dEc0DZ81NjU0ynox8MBxwX0vjuugIXPxLiXIIR75HYm8OiTVQc7xMxoix6EsP5lbFCk1H
	t3WnXjJ/4NcYh4oZPDFY0KW2eOHYKS2cnrz7n8ZsVslNRS7Kyp0iP9hB7wD0vw4Mm0LLlZKwQjP
	3cqM=
X-Google-Smtp-Source: AGHT+IGyxv4vNjjG7KaJ3iyPdfXj74x7uGlGIgwHhUObVU0+SSpA387sqH72IQVZOID5ZMrgBJYuhQ==
X-Received: by 2002:a17:902:f94d:b0:223:5a6e:b2c with SMTP id d9443c01a7336-2242889a729mr153897815ad.17.1741643880051;
        Mon, 10 Mar 2025 14:58:00 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-736cf005d87sm3571543b3a.49.2025.03.10.14.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 14:57:59 -0700 (PDT)
Date: Tue, 11 Mar 2025 06:57:56 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: manivannan.sadhasivam@linaro.org, robh@kernel.org,
	lpieralisi@kernel.org, l.stach@pengutronix.de, shawnguo@kernel.org,
	bhelgaas@google.com, s.hauer@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, imx@nxp.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH v1] PCI: imx6: Use devm_clk_bulk_get_all to fetch clocks
Message-ID: <20250310215756.GC2377483@rocinante>
References: <20250226025628.1681206-1-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226025628.1681206-1-hongxing.zhu@nxp.com>

Hello,

> Use devm_clk_bulk_get_all() to simple clock handle codes. No function
> changes.

Applied to controller/imx6, thank you!

	Krzysztof

