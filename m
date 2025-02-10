Return-Path: <linux-pci+bounces-21103-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E77CCA2F5FA
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 18:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19AD33A3D8C
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 17:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3596625B684;
	Mon, 10 Feb 2025 17:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KDBkQNeS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8662255E37
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 17:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209990; cv=none; b=lBXBL+RBX6ZZ4RIUEjj/Tyl0KbUWOHwVXBcdv12BC+BranuNcPX7EUP9z2eZyJuJrSBYhT4YTV0At1zqTD1KSD0zCaYDpD+4sujEpRE+owBjJJQKWBgdsFYa7vgkt7tUEWOZ6yaJuR0p3bY6j8ww/gD2qvpF06tXOJwEwgV9Iqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209990; c=relaxed/simple;
	bh=U+YQ5PhZVcxOIzhFI+20sedITuhk+41a7YpPgwQM7HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlgUM+uzB2MhXF0dKhpo1GbdMwo04SN0SBO2+Ph1rq8I3lGti4CZBPtKJfEkGJpOmjV3M+zDyV4wIqAJJlssWfANBYLrdlm0TsTvs+MaDYBZ30jRoBjrlfGyAd331Rklp6/gBDB5gEzFWAfQxO281QL/PO/YqBnrWkwRQu27FUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KDBkQNeS; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fa51743d80so2858499a91.2
        for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 09:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739209987; x=1739814787; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LGsMNA7hkuFPRoTb9bXf92iX6DhOUuWxNMoqTKxh3jw=;
        b=KDBkQNeS3QfNzmRGRZsNWvNWBJiQhiBPXYbbiF9ipG2ZPXAh5CZ3hmbytZ+4eX8SYp
         xLZRE1sh+aJkqb075+yIxx+7UR43dWa/pyknWkf6MkJe80QzMumX3ky33M8v4P7AiwQ5
         QQ4o/AYvthZCSwKis7OmhBy4Pm2iZ+Dxil2u7p/fKSdMgqwsO21ypPrDa6wxpBui7AeA
         TH0lSsyQq7QCIcNw4IXTwzHJsHz+kZbfEbAnivhM45xpKHP2WBGjJBjcoxOEHpifbWM6
         YYpNjvzBxGybdovKXZD1Sq/4QWHYLGKxb0S4RIso/hsOtzQzE3C+N+h5TZ8F9b0YfFMg
         Z0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739209987; x=1739814787;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LGsMNA7hkuFPRoTb9bXf92iX6DhOUuWxNMoqTKxh3jw=;
        b=Ih71kkOePenEzTpAS8Ezo3FpjqehxkPTjh5PBBQCBewov3Govn9su9ribkn6XQVuuV
         ZmL7OHoyy9agQQAM/7WLF2J+cGLIZdXMBbt+CFhrcftVEBdV+f9g6njkuAOB8kPzSODP
         wDZY9WCclpahNVn5NoqEnFjpCkU8MLg754CNlh4MyPqIxwLCJaP1F2Lh267oPlWZ7qUp
         xSzHF2iyqYSBqH++Iyz+dmxYNZrjuYTNc35PoakTYp0wj2ipYACQV9Vgolitfuy2HHNP
         Txw6hWK46083iqydxD6CN3HGDgAEosztHbYpzdl8f+sO1UzbGsMmef3FI6OGW+37PwLj
         i5+A==
X-Forwarded-Encrypted: i=1; AJvYcCUljSWyhw5OEVHRi0Ho/GgAYe4aw/KcPzjcK7fL0TsselEbEYSpzqQ6Kgb6rgzVXSoVzz0QrrldiIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrqmh9X0HVrpjO7wxQjFx+FJHmqphr1911KZw18THJoxr1Gyp3
	tyS13gKn2WC6Iog316LmcebdUwjAxqy2DUb0FOcjXT+cc0j9bcJfXR8JlboaLQ==
X-Gm-Gg: ASbGnctIf5h8ol4hmjwgllZaHe9Ji/adpXJMU/gjBtqxC1q1iR6DBf0qRwY+kHh+Qg3
	EM8EsS52dxBm/8//R7tCPCu0tLKAfdxjVXkydyJo2eMWwym8bnJcpBrub9meVECSLKi6a59Fh66
	n6at7gVVg43QxGy1tovsbL6HoG6MoJi9SThuVTPhP0ZpelWv5junWVUCxJYNQCJm+eP2anJSX3y
	YzDd0mowbaiIZft9r/TiyFAgu4lC4SdX4m4l8CaD6UeL5znKmJz+RyKmNkIF+627/7TpC2QOyEV
	FAxXof2rd+aR8rgzf+Qvxn6QDw8z
X-Google-Smtp-Source: AGHT+IGXtPEY3mjc1Vv3Gaj+GWe5Fs2qY7xOB5/6dE0Jux/iJmgud1Xfm7AdIWKZQ7mORD5U/TLpnw==
X-Received: by 2002:a17:90b:3e8a:b0:2ee:d96a:5816 with SMTP id 98e67ed59e1d1-2fa24062e1fmr23566047a91.10.1739209986903;
        Mon, 10 Feb 2025 09:53:06 -0800 (PST)
Received: from thinkpad ([220.158.156.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa099f4d6asm9079409a91.6.2025.02.10.09.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 09:53:06 -0800 (PST)
Date: Mon, 10 Feb 2025 23:22:58 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Hyper-V/Azure@thinkpad.smtp.subspace.kernel.org,
	CORE@thinkpad.smtp.subspace.kernel.org,
	AND@thinkpad.smtp.subspace.kernel.org,
	DRIVERS@thinkpad.smtp.subspace.kernel.org,
	"status:Supported"@thinkpad.smtp.subspace.kernel.org,
	PCI@thinkpad.smtp.subspace.kernel.org,
	NATIVE@thinkpad.smtp.subspace.kernel.org,
	HOST@thinkpad.smtp.subspace.kernel.org,
	BRIDGE@thinkpad.smtp.subspace.kernel.org,
	ENDPOINT@thinkpad.smtp.subspace.kernel.org,
	SUBSYSTEM@thinkpad.smtp.subspace.kernel.org
Subject: Re: [PATCH v2] PCI: hv: Correct a comment
Message-ID: <20250210175258.pwaqr3dqxstcjmui@thinkpad>
References: <20250207190716.89995-1-eahariha@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250207190716.89995-1-eahariha@linux.microsoft.com>

On Fri, Feb 07, 2025 at 07:07:15PM +0000, Easwar Hariharan wrote:
> The VF driver controls an endpoint attached to the pci-hyperv
> controller. An invalidation sent by the PF driver in the host would be
> delivered *to* the endpoint driver by the controller driver.
> 
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> ---

Where is the changelog?

- Mani

>  drivers/pci/controller/pci-hyperv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 6084b38bdda1..3ae3a8a79dcf 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1356,7 +1356,7 @@ static struct pci_ops hv_pcifront_ops = {
>   *
>   * If the PF driver wishes to initiate communication, it can "invalidate" one or
>   * more of the first 64 blocks.  This invalidation is delivered via a callback
> - * supplied by the VF driver by this driver.
> + * supplied to the VF driver by this driver.
>   *
>   * No protocol is implied, except that supplied by the PF and VF drivers.
>   */
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

