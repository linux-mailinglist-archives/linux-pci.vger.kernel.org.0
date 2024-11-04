Return-Path: <linux-pci+bounces-15970-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EED9BB853
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 15:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 661452824C2
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 14:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E29B1B85D3;
	Mon,  4 Nov 2024 14:57:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC05469D;
	Mon,  4 Nov 2024 14:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730732227; cv=none; b=Ljd/gGpB/3K1kZ6m3lK0cLWnth0YjBa6XMWY06Pl+uWZNVVuZflItLyUz8KxGYzHzPlzWZyvRJY21Q8XvNxB4ZIY37rFOGchH0P+uf+liHQahTifkpCw4eHWSWwYE1U25ScJnnSxv9kSrFXYIcq9gOBBvQadg/hb+VqxtVGQ73I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730732227; c=relaxed/simple;
	bh=RpCsSPbF9hPLxFknEQeCKjaWyspggWrBLgvsrjR4QVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIydfXI0fa/MvSdvVTw6sgMktnjNYp4ti/AyiuxUoKQeb35V5iSA6wVcY76vXpEdA3+QbGpthyLBmY1YtxPT5RIX+iGmUkM5ThoS77JHr4iPMCKy8ryMN4rCsQ2ANZpKYGdN5pf4tYehwlQI3KMsJxI9IaxrgsDoGPGdN8LMsNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso2956390a12.0;
        Mon, 04 Nov 2024 06:57:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730732225; x=1731337025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I82zg0d+bkgUiX2hBjnFGtZo3rhclu02If6kmZ3e1WY=;
        b=FMBM+Ul/CT98agBN7YvkdMLT4xYNCfcRET1fMiA4lJ3F08SuXZCZy+UXtVesjpIZ1m
         Sr1KTmA+S01pNfrRw0tl2GstY5JaihsK5Vp/VVBTnVCAgbQCc9tlA9cdFJCCFcXm7uBC
         xr3qcdWySnWayar6Umuec9RRh8wiTzC07YPualOghoAiDmZlqIyHm552CqLkqsYhrK40
         up5a1dVhq1MOcQ3pIXeSFNGpWyD78i/MqZBc8ufYZnW6JJc08Iletp7+tGYx3EReaaxK
         fo1UloLQvuLKDFC7vn+Zua1Biq7dBLict5mhsFzPaYg4is3cFp/z2UugBlVlsVckrMlH
         T8rw==
X-Forwarded-Encrypted: i=1; AJvYcCU1hQ6xkKKEMZUeu0MzoFVBwiZOrwgNo2RxBROkEUY/W3qz9REHzTLdYvgffU/+tFXDOecEzJYDfuiDYqJFmg==@vger.kernel.org, AJvYcCXD8uWlaohnRgY1xc8ZxlWpBLy4qQTIlDlgYamhZDSEzTkO/JKfOpct8GildQEwWEgVsCro7dJ348QT@vger.kernel.org, AJvYcCXSIZ7wG3ewNuQUUv20HUWpJpiS4iGJ0+iDO5VTV0AcwpwqLbJUjHAtC6lj7GSwmfyoqqaT+OaWfbXK@vger.kernel.org, AJvYcCXUptw8K0Hc5PgEe+q7vJlf4WYAcrLv2pYGd+0nkx5vTcGoCYjQrOCzQlpHH1WgilPUlgEp0/W4nCprTbBN@vger.kernel.org, AJvYcCXY4uPYhHSTub+Ggg8UPBL9wLqJzbzFBLUDq6/Ni/p+aLRlEo/wpPHqxHT2Oe7GPU7/dboVNwJcm3JE@vger.kernel.org
X-Gm-Message-State: AOJu0YwmmZ0oXdhyEKwAxMMsXP7DWPwPPqDFGE+hbKiWJ5jqvpeMjSjN
	wLhc+ghErU53jf/1VaySW8Qj5fKYI56ADlOh8Sc7ulJ14j+aBT3n
X-Google-Smtp-Source: AGHT+IG3+xbG1bGzU9fXWzq5gkcZkhfNYx/bQR3aEaPasmlEwVSOmKYE5BbIW0BlHnhDq7GVCfPmTg==
X-Received: by 2002:a05:6a20:6a21:b0:1db:db2f:f3a5 with SMTP id adf61e73a8af0-1dbdb3025c0mr5103280637.21.1730732225497;
        Mon, 04 Nov 2024 06:57:05 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2c3996sm7532967b3a.106.2024.11.04.06.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 06:57:05 -0800 (PST)
Date: Mon, 4 Nov 2024 23:57:03 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Johan Hovold <johan@kernel.org>
Cc: Qiang Yu <quic_qianyu@quicinc.com>, manivannan.sadhasivam@linaro.org,
	vkoul@kernel.org, kishon@kernel.org, robh@kernel.org,
	andersson@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
	abel.vesa@linaro.org, quic_msarkar@quicinc.com,
	quic_devipriy@quicinc.com, dmitry.baryshkov@linaro.org,
	lpieralisi@kernel.org, neil.armstrong@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	johan+linaro@kernel.org
Subject: Re: [PATCH v8 3/5] PCI: qcom: Remove BDF2SID mapping config for
 SC8280X family SoC
Message-ID: <20241104145703.GA3230448@rocinante>
References: <20241101030902.579789-1-quic_qianyu@quicinc.com>
 <20241101030902.579789-4-quic_qianyu@quicinc.com>
 <ZyjZE-U_7YZhScfG@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyjZE-U_7YZhScfG@hovoldconsulting.com>

Hello,

[...]
> Would have been good to say something about why there are no 'iommu-map'
> properties on sc8280xp (e.g. since it uses an SMMUv3) as Bjorn
> suggested.

Happy to update the commit log directly if there is a consensus about how
the final wording should look like.

> > struct, namely ops_1_21_0 which is same as ops_1_9_0 except that it
> > doesn't have config_sid() callback to clean it up.
> > 
> > Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> I see that this patch has been picked up now. The above is already much
> better and I guess this is good enough for now:
> 
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Added.  Thank you!

	Krzysztof

