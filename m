Return-Path: <linux-pci+bounces-15952-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBFA9BB5CD
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 14:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ADE01F2234A
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 13:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55487DA7F;
	Mon,  4 Nov 2024 13:20:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB7C42A91;
	Mon,  4 Nov 2024 13:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730726450; cv=none; b=u+CfXAJpyQ1+F2qxwr2/6jGrJuruP4f8hT7ZhZ/izjOtq75P52SXDrQQpXwlFS50dwwNzaog3iVO4BMyBJryC0pmmQ3BxdZTRKlyDUackEnhJ7OCwH8lmw75sFnLn91FHNlc6KWwH2KSYdjJ7gwOZ0zS2nGXDKQtirWcFYh9Ics=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730726450; c=relaxed/simple;
	bh=oIoDtIF+2GZDMiRu2wj9nD2wnJGR5s9ZmdKIifr2wDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGERdU2KdyhtXY+O8fEdhRvwVilViWY1DrpM4vgl66p4iWdNdewSHOMuiPhipQijneTw7ol10V0E8sr1trf9mPDGZ60qcCAJPoX874JRHmkCTUXKbFCzsdACRNz2VoEJgT73pVinFYDLsSXnR8ISNZ8A2uuvocCWYYL1gTE7WWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21116b187c4so26972425ad.3;
        Mon, 04 Nov 2024 05:20:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730726448; x=1731331248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAYbSq5mlU7adPkgvorpMNMhcx0QaHzk2bxUeWeRhik=;
        b=aXPFevXK6rwJx7n3n4rwU9mdH/sc6Sf7mgcO1YjbblS0RnRcDrkQO1O0ENHFPgsXgb
         +xP+0QBRrFVIitvO083UwSl6IQkQKWGL8NFgWTKDBBOrEd/LUj7tBbKSZDl6HUYOUm2G
         x5QFYT5HgSQG7FdaAxH8lezaQ1Tov9MelXZSviClmi8ORLN/iBDq/eJyGsyUlt5ildl2
         GQpFzyMKA2q75G4fn0uTanrc/08iOOV+KM8N1cPsJlEDQsDzGNPltK0m9xrlxxertdO+
         j3btN6cGOaX8dpKFXcYPs2T7lmwJhKVWld6tMGDoq0cek9ifMxil/FzyWH6vFYOY68Hw
         +gJA==
X-Forwarded-Encrypted: i=1; AJvYcCVB75mXU1ZdlhgFRHJjiP4hvjgQyhf3o3hPrJxhiCjrsszpjQNbb2EiYP1Ag3uu0wpqOMJoLRxk9u7Fsbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRN31ixaKvxKSZgETA34kru1lFRQ8qlhHm5vTHGVI42X2uHEro
	PpB2JPwMR6SnHGLt8E/MCE8EFvRNP8fcENsocfCZQ9RDyM/GoPoX
X-Google-Smtp-Source: AGHT+IFPbiyTwQNpyLarXOasgjJJbddopeoCOOsJvaCh85ieSNwN3SrqIlcdYNIvZeGmYFnzFxul9w==
X-Received: by 2002:a17:902:ce8c:b0:20c:e262:2560 with SMTP id d9443c01a7336-2111b0078bdmr151908315ad.50.1730726448397;
        Mon, 04 Nov 2024 05:20:48 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93db18128sm7460203a91.36.2024.11.04.05.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 05:20:47 -0800 (PST)
Date: Mon, 4 Nov 2024 22:20:46 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pci@vger.kernel.org, ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com, lpieralisi@kernel.org, robh@kernel.org,
	bhelgaas@google.com, matthias.bgg@gmail.com,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
	fshao@chromium.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v4 2/2] PCI: mediatek-gen3: Add support for restricting
 link width
Message-ID: <20241104132046.GA2504924@rocinante>
References: <20241104114935.172908-1-angelogioacchino.delregno@collabora.com>
 <20241104114935.172908-3-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104114935.172908-3-angelogioacchino.delregno@collabora.com>

Hello,

> +	ret = of_property_read_u32(dev->of_node, "num-lanes", &num_lanes);
> +	if (ret == 0) {
> +		if (num_lanes == 0 || num_lanes > 16 || (num_lanes != 1 && num_lanes % 2))
> +			dev_warn(dev, "Invalid num-lanes, using controller defaults\n");
> +		else
> +			pcie->num_lanes = num_lanes;
> +	}
> +
>  	return 0;
>  }

If you were to handle non-zero return value as an error here, perhaps the
property has not been set, then we could reduce the indentation here.

Something like this, perhaps?

  ret = of_property_read_u32(dev->of_node, "num-lanes", &num_lanes);
  if (ret) {
          dev_err(dev, "Failed to read num-lanes: %d\n", ret);
          return ret;
  }
  
  if (!num_lanes || num_lanes > 16 || (num_lanes != 1 && num_lanes % 2))
  	dev_warn(dev, "Invalid num-lanes, using controller defaults\n");
  else
  	pcie->num_lanes = num_lanes;

Does this make sense here?  Thoughts?

	Krzysztof

