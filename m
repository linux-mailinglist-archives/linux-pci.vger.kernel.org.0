Return-Path: <linux-pci+bounces-21903-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12721A3DD43
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 15:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D57A3A3F6B
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 14:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B08619D06E;
	Thu, 20 Feb 2025 14:45:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4FC846C;
	Thu, 20 Feb 2025 14:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740062755; cv=none; b=MIZt4wlVIslL4zFcYY6SZZCuYjn3f7QOLFVkQv9Lrz6DGiClfP/phGvo0y54FtmzySCnNpP9DvJeV+89buulV/gpJDVh/ZebbWF4MjnGey9ox0pxgL0cR1xVqEYqjioC1bVPHKTr3ITKK5nTItgGzYYdXquhgxgdYZj84PMSqLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740062755; c=relaxed/simple;
	bh=5X7ZMKsdgsyI7P1JCJHJEh1HLSrgsQuTswjrDXnKlg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=az3Y3A+3GMemZg7yDSUbx4CMB3Sy/aJu0C3oGKD2elzSJ2u3qTGZWgjcJUNJvI+2XYIjC8M2DxLjQQWSZy50YTj0n1jk4aC0a9D3RrB6V7TXnX6yexQP67BvY8JiwfGDzAmWpERhX/zDB5YDttQjzaoEs84G9zUSK0rbOcdfu8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22101839807so21482495ad.3;
        Thu, 20 Feb 2025 06:45:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740062753; x=1740667553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyO23lYkNvoQQUlbolJXF4K3o41Wq4pRTt+X6bZAIV0=;
        b=qVHEm8Gp4nri+0crX7onHpPjyfZXjXk1rZkxzH/5DjCG2dhkjgzq2lHH93/sNn5vPJ
         EPI6yJe45SalweCA3l4WmNNj+GmaiTT87isXgViPKjo7p2zM0zpgu874KQU3nSGa+ebT
         NnsT+clW+bJK6nwsyx/PSZgUwQuLNOzj8upnbAhTSPTyMmysdnpZ8PchFAThN68WYe5C
         5TuO8aWsbm7l3Aynmzmn1R/9+zq1+45vXK7cKc4xev8wvEl03ikVp1f5XAQd54Y5M5tN
         nlULzr42nEqWl3geyhswKm4E7IMS9xuuidpBuZX+UalnnKoPI9Rg/Rtub3HumVELUml1
         TTZA==
X-Forwarded-Encrypted: i=1; AJvYcCUSXv0KK0TnMcnS9KcXMAC3zZ0j1XgJ1lMEEzdAjSUMm1KIbvXr4icHhMid/sa3jb1UPydjYWnBWgfI@vger.kernel.org, AJvYcCW6jdzx76T+16E2qNl5hqgIPe8pzZhgnWwyXIiBXSzx8TL9SWFg4FMzuowhqjZZlMHeJbo7bofCSfr0@vger.kernel.org, AJvYcCWwppVh+MkzEqyGWsPIvgsRI9NHjhizZazQwfcg7la8abDY/TIpZot2GxH1JgTwKlKeeueaoS0N6rrpGPVn7A==@vger.kernel.org, AJvYcCXbz3I+nK6xV5uQwoyCdF8O81phZCJsxcpXPO66BjlXU10euqWy75S1Xlm0mVmOBl6LZ6Yunrd0/PDTu/6L@vger.kernel.org
X-Gm-Message-State: AOJu0Yw08AK1iPUQZxlvkoS488qxiE1ageF6uSx2uhFfI+8OtoLdIs0e
	A7NnNv6nuCUxs0CqNxb9bBYqrwqOEAMvEfp1tq9vEU5P8oqihAEp
X-Gm-Gg: ASbGncsn0X5J2Ehm6WcKZgG5twQRjqaNMWRLsRWJB0O4jJ0x9pUurTXK8KFRYDWqP2a
	JQ1+l+4lJTyF0fsAZwSn8oPYv4h09t01XFF8K3B4DU7d8bQunYnMgt0sNRKnxHPTmjyp7pjXEL7
	rQ57yy9gkyDMm3YEaxuAb7Zc/3KC8Util7ppFdRTZ0zjgZbFFvjydftiSGqeWxV3VpQFYMK68Di
	UAORJ+NjpiTK6hRqO2ccAyE2DACeY9HHdNu1xFsOQ7CERjjNqHsh5dXSaH+H3DQPJXZ/Ly4IGIR
	5I7jXCp1ND44c18U/0hMKb3X6BL9B8oOH4m703aacuyeocP2CA==
X-Google-Smtp-Source: AGHT+IEBKbHBfq3DOu9Wgjnn57HwJpQn3LwWmH/iOR4vVbY0PS1ZRcs7M2GQp8hnxm1C2wpw09bftw==
X-Received: by 2002:a17:902:d48a:b0:220:d1c3:24d1 with SMTP id d9443c01a7336-221711b7524mr131278365ad.46.1740062753298;
        Thu, 20 Feb 2025 06:45:53 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d545d448sm122367545ad.150.2025.02.20.06.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 06:45:52 -0800 (PST)
Date: Thu, 20 Feb 2025 23:45:51 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org,
	kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
	p.zabel@pengutronix.de, quic_nsekar@quicinc.com,
	dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v11 0/7] Add PCIe support for Qualcomm IPQ5332
Message-ID: <20250220144551.GB1777078@rocinante>
References: <20250220094251.230936-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220094251.230936-1-quic_varada@quicinc.com>

Hello,

> Patch series adds support for enabling the PCIe controller and
> UNIPHY found on Qualcomm IPQ5332 platform. PCIe0 is Gen3 X1 and
> PCIe1 is Gen3 X2 are added.

Applied to dt-bindings, thank you!

	Krzysztof

