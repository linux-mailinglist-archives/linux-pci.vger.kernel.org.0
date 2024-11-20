Return-Path: <linux-pci+bounces-17112-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657A39D3EA6
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 16:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AB24281C21
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 15:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38341C7610;
	Wed, 20 Nov 2024 14:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DMgnCklC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA931B6CEE
	for <linux-pci@vger.kernel.org>; Wed, 20 Nov 2024 14:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732114768; cv=none; b=ZHerVIPc4THdJ6HmVRLefpJ6wxUk0FsMZoeaWL0+lnEkW3wpyQ6y8IHCokFtgwkWO/yQrJ82sbBg3VrhSUawe/20mM3qxuytwJYT5kG1f9LBmuOwgO+X8SDAwAYyHkNxyT6O8B/zKq2mWcORcWnUbESpkjeJY39w3pWh+oiY8yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732114768; c=relaxed/simple;
	bh=xaPF0Xudp3d/bmQL2xmlO/yPfi+mdTitYGkLa2xjOtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAYKJujNxUR3WUFHOVNMLfwqjemLHYVt7NdL7EzAYZb/t1WykfKIQnCPG09sy2DtOgchUUPsR4w/seA/BBsalJ+jEtN5mlCoSstsg+dPwiopeOw5Hlau+F6V7ONqMUXKly8YsuMm7MqeHbn2TcA6RG5K2OdieLHs7t8XBvVBnAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DMgnCklC; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3824aef833bso2358518f8f.0
        for <linux-pci@vger.kernel.org>; Wed, 20 Nov 2024 06:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732114765; x=1732719565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VNySOlZ728Qwil3fWKGNJRdQ74n20bXi/RqzObtMGPg=;
        b=DMgnCklCwPWA8R/TcT8KRb4dOYFxtWMdfQoseLOMPf/iwtwL5vlnT+krVo5VswsgXO
         l0csqp+j3gORaOsBd2lrTxrhK0pyeCJwJ+bW1pss7I5K8GRKook/KP5pAlwJf5cSVVHs
         YH4eZx9S5eCEurVUiQsvpmXGQ6mBgSh0gyeGfXOiXLhPIXBPl7wEA7DwYQctsfNHzk1D
         cNvwdQUGNq/3C/QAhuqXnhTG3Ou2/xmkmN5ODN8nsGmtHHPmqjRfj9qdbEkyU7Fvo1QL
         FZ+OQF6zM2iZmB+zuWz/Dx+48pmaBYwt6SsDvJlNWxGIYirf4WEIWp3aQoXCvbjM9p36
         HUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732114765; x=1732719565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNySOlZ728Qwil3fWKGNJRdQ74n20bXi/RqzObtMGPg=;
        b=Hc/dKN2ikAEZpYA26YQi7s7zy6MeWQTiSkoNZW4m4ZWmyX1ELiHRzQ7HI7FGy/35L3
         h20CbsUJnIwSRuf3RP1hPuFmMKD+/a2IMY9SYpiwgz55Vv/0/xkTofMOYla7kiuewFjI
         OO4CY1H3uwFbIG70131Cdd5v7TPUn0Ty0p8eG2FZAn4uVPZrK/WK38F9C1A1NPkyJhY0
         74dJ3VY3e5U9GNC6JmkAl0EmyyfGJVHFhjSmfI6ttgB/gRFmVFagB8TEvoETtL9L3o2d
         JQ+p6x874ztKnM17sXn5aRxpfSJopTELSM0x3DMuvK/8KI1B3iJE/je4Cy1Tq4xQpycn
         WOww==
X-Forwarded-Encrypted: i=1; AJvYcCW0BTxT0u9pZebaTGuTcYdLKzUf8B/kaREOAIAEAngA/7CiyN5zShZA/C5zzXyy0KfQQskNMmL+nQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyyzrEJ+P3EYLfl+ZAao1LHb1kCXVSmR8XZujDiuJkBwZB+GHt
	zMKzG53WCKJzGBKf4IbO00O2H+xxOzkUhw4tn2ywiqkUBkLwQZbwWCkIKsxwips=
X-Google-Smtp-Source: AGHT+IHQ2dmEzHfyh4PcYnC+LimJ6ZLtLl2LOMIvfxYsqrjiWJYRuSfmnpxmbQO+Vl8LsI0rFWX6gg==
X-Received: by 2002:a05:6000:1541:b0:382:5177:3a4f with SMTP id ffacd0b85a97d-38254b21313mr2465999f8f.49.1732114765245;
        Wed, 20 Nov 2024 06:59:25 -0800 (PST)
Received: from localhost (p509159f1.dip0.t-ipconnect.de. [80.145.89.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38254905328sm2348689f8f.2.2024.11.20.06.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 06:59:24 -0800 (PST)
Date: Wed, 20 Nov 2024 15:59:23 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: andersson@kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	Jingoo Han <jingoohan1@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] PCI: pwrctl: Add power control driver for qps615
Message-ID: <j44dasmtyopz3i5dhwq75m2nr7bikcifka2zzvjr55wdlr6bhh@5c2ite46tvxu>
References: <20241112-qps615_pwr-v3-0-29a1e98aa2b0@quicinc.com>
 <20241112-qps615_pwr-v3-6-29a1e98aa2b0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="me5utvjifrxgd6pz"
Content-Disposition: inline
In-Reply-To: <20241112-qps615_pwr-v3-6-29a1e98aa2b0@quicinc.com>


--me5utvjifrxgd6pz
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v3 6/6] PCI: pwrctl: Add power control driver for qps615
MIME-Version: 1.0

Hello,

On Tue, Nov 12, 2024 at 08:31:38PM +0530, Krishna chaitanya chundru wrote:
> +static struct platform_driver qps615_pwrctl_driver = {
> [...]
> +	.remove_new = qps615_pwrctl_remove,

Please use .remove instead of .remove_new.

Best regards
Uwe

--me5utvjifrxgd6pz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmc9+UgACgkQj4D7WH0S
/k5hBAf/axrIVl8P9918nf4b7oboxs1O5Z6BSG98CyDzUCKbeFYbtTiXpS/Q7Pk6
q1/09KeLUNOwaVrFPByOIR6z/SXxVfkDzaqgC98TsgWxs9H3NeT8b9LjdAqPW0Lo
T25ukMkxel8BsKQC8NREsjsgGEsNgZYsn5VWaMNQuOOX/rII7PLbe5FKtVT4y3mV
gmttxug1BnPCj13ZrN/2s+mnuYeM03ziWa14rX/BAjWnjkGr3tuzt0y+oWTIgpMr
5EipxngCY1/JS5UQ8rdgDBcyFAATut/c2s5SF1sONP1cdqkG1kVseZWvtHjrtpSe
P1p8X2WkoG57A5eNnX20N+qjxvX35g==
=rntr
-----END PGP SIGNATURE-----

--me5utvjifrxgd6pz--

