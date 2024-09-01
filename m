Return-Path: <linux-pci+bounces-12565-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACC096785C
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 18:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BDD01C20FDC
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 16:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9ED17E46E;
	Sun,  1 Sep 2024 16:31:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9681C68C;
	Sun,  1 Sep 2024 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725208261; cv=none; b=S2xh7CZXeNK2qluLsVX+sclHzVj+Hi9WiY9J/KACCDO+QbfBKywDWN2oPlODnb+iK/nmOyZtEsrEqQGB/Xp+WtK6A3QHUxynT6xTV3U+VOuLx5yzBBJUCNqwQEgbl+85iMG7qyl7W2WRHvA6PDUMtIU1l/t8+zYHfFz6ViPoCf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725208261; c=relaxed/simple;
	bh=EtLy3hQ2xvVykP8FrNndhx0mClZ6YC1ocIgQ9wkyQ6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+U7X+tcaJoBaBUH5C6BAuKYXEddgyMxp8mMTPWKp6L7hPxYHDbXLy9pOTp5XStnsOfOiX4hxUe2/EcZnayiLwLm7JGSD0Wqg/n0VUWDsPJW0qSMWEwG/HUVi/VSu22vQGv2Lw9fN1IyRjDJcpVfmG4D1GV3oFfxQM/p7lvn8RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2053616fa36so15978885ad.0;
        Sun, 01 Sep 2024 09:30:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725208259; x=1725813059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wP6a0ObVRJ45bjmxA06dysPPH+I7+nzgYg6tCWWzUuk=;
        b=BcxXxz/qcdJWwhgrUqLHMzjERoRpjiSApJdqmnAjYZvXNlZAskbGNBw7nMkNwvbplW
         Juk9CMN9rF0JtzhY8I6R0Gjz7g3EBtaNKImmJAodGWMIJu7AWl4NgXffVedUgkYijj0A
         w2dbE5g7SjPnPaqOl8pcTTpZNGvQCbTR1XwyO0+FwNz0po0tI7zBhndKFKyO8PFxW06C
         w1L9cGrmnrCa9f/xLS73s6Oox8p/NjvD+HoYzdhrCOkVkC0xA7867ergKkjkZlgsoPoc
         NBMA6NUf4A7tHD1/ZrWteS4cSzfilLsYTYeDGH5h3w5rQSa27usvUzoc/EF0An5vCTqa
         9gcw==
X-Forwarded-Encrypted: i=1; AJvYcCUHmOkg++vYsH3V4VnAXHkEiyP0gtvQTCQ0BXkL1Um43MxO1DWbeaIeaCA4xn37LmfDtrtgZFdgKpjAOrJn@vger.kernel.org, AJvYcCW+Cvcspvhxet2EqZW19CnRfU+MB0Yw68vyoqApIv71Ic+TQturCqwanSTplBRLrTbZXc0WbKMTAEN2@vger.kernel.org, AJvYcCXSKRKKrF8yaovdeDQ49HzuqgKJ2F9d5bWV2+5cLC44jISA3IOehISKekpNJwW3acQ23Fpvgq4QtRnldedB@vger.kernel.org
X-Gm-Message-State: AOJu0YyE/okmnon0W5NI6Fj6oXA90mjWz5Ljw7RV/rjxpNpbysbwcRv1
	l2Sf9CuyLz8sDcQB1JD+yD+2WC8FefEiuhfuRQ+56XvThJOL9YnP
X-Google-Smtp-Source: AGHT+IH17xCwWUghUlInlD3NVtEs3jnWjn2+cCoLihDAaTFelEh9DOv9/gTtwgfIOQmFkYAItkSwoA==
X-Received: by 2002:a17:902:e742:b0:202:162c:1f29 with SMTP id d9443c01a7336-2050c46deb5mr114450805ad.47.1725208258778;
        Sun, 01 Sep 2024 09:30:58 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515533acdsm53819995ad.124.2024.09.01.09.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 09:30:58 -0700 (PDT)
Date: Mon, 2 Sep 2024 01:30:57 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom-ep: Disable MHI RAM data parity error
 interrupt for SA8775P SoC
Message-ID: <20240901163057.GA235729@rocinante>
References: <20240808063057.7394-1-manivannan.sadhasivam@linaro.org>
 <20240813202956.GF1922056@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813202956.GF1922056@rocinante>

[...]
> Applied to controller/qcom, thank you!

Bjorn included the patch as part of his recent Pull Request with assorted
PCI tree fixes, as such, I removed this patch from the branch, since it's
upstream already.

	Krzysztof

