Return-Path: <linux-pci+bounces-1057-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6938145C8
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 11:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E3C283973
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 10:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B1A1A710;
	Fri, 15 Dec 2023 10:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OI9D/d5R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3141A5B6
	for <linux-pci@vger.kernel.org>; Fri, 15 Dec 2023 10:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dbcc63b7c68so411725276.1
        for <linux-pci@vger.kernel.org>; Fri, 15 Dec 2023 02:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702636748; x=1703241548; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jiq31jpN7wqW65DapKOn/OwXB85jbhUHaMgJPt6QQsE=;
        b=OI9D/d5RSm4zNS98JLyWuK6Gh1fP/1Pd2CIorFXRPy/Gruyh3id2FWt8MNp22AC/i9
         qnSJIau1Gj+kI82lnPm7ZAxRxuouTsJvgB8MacAfyUiVJwL02GMUVr4p9XAeAM2JXRCE
         jfoYDNayKrMGh0+CDZF7C6OfECilPqi62iaxo/496w6To8X0ehaH4oveOiHz8ETq1iht
         Hadl3+b4ByGyzh1FRlF1I4ednSLHo+p1hF/nZc+VhfjPwhCR1sZUnPxBcYCZBgD3om8K
         vpExmyEFzb8XAaXFykMFMqOtzqPuMHI68evn+tjFiDbGKsfsuqaB9Un+FXl4+GtA/5no
         q5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702636748; x=1703241548;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jiq31jpN7wqW65DapKOn/OwXB85jbhUHaMgJPt6QQsE=;
        b=Jd0hUEqdmvBvryRj5NCe/GsBMwsLsV1lJg/qL8mNQ/1if6tXIHNvs3aCDDtaCNPBlu
         OQSsb1G2Nxx3iKLOVDtETNKN9md0pmTf/ZdvPDY+OYTGzmlgWzbOML1Zd+V3yD6WfBxt
         D45MRsjTpUzkqiY+6c8ayqJHpDxOZq0chAJW5BU5WL0iUVEYpp4mmA6RnV+Y72cDXnbv
         UcUeW3GfgHkdf9P3s3+SNy+fQ5subjE3cCL6tR1EIPA9+Zn01WmTJRAPaWGR7KMfSJL+
         ChijF1uBgdk0qgJNeAKo1yHYf5PnY01jCK8wFT5araEt8oJhxb89yZI+V5VV1C7QXByY
         L3Fw==
X-Gm-Message-State: AOJu0Ywg3bw8IANZPglIpxogJGIlpd/egpE5S0me6fg6eIoOCh+12gZT
	R6vAA2MPAdlsYr5CyExr2c7swaDmvT1LQcQedQJOyg==
X-Google-Smtp-Source: AGHT+IElxcdrmH96P+ZEgAlgvlLpzFy7iBSuDziANg2vR8XMNL5IsP/0xtw+M60AD6jQ0D8un4ARlnBYJ0eGO/5EfGQ=
X-Received: by 2002:a25:2614:0:b0:dbc:c631:4461 with SMTP id
 m20-20020a252614000000b00dbcc6314461mr3877533ybm.92.1702636748662; Fri, 15
 Dec 2023 02:39:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214062847.2215542-1-quic_ipkumar@quicinc.com>
 <20231214062847.2215542-3-quic_ipkumar@quicinc.com> <CAA8EJpr61JuznqfdMG96mjrqquf2Qbfe=potB5vzk43XexWj2w@mail.gmail.com>
 <6a3895ad-7da3-49c0-a7a0-7dd1031e0544@quicinc.com>
In-Reply-To: <6a3895ad-7da3-49c0-a7a0-7dd1031e0544@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 15 Dec 2023 12:38:57 +0200
Message-ID: <CAA8EJpqhdNg7t026PwPdGOA+-ba_GEBwsYagu_0aAwhkSuM6KA@mail.gmail.com>
Subject: Re: [PATCH 02/10] clk: qcom: ipq5332: Add separate clocks for PCIe
 and USB for Combo PHY
To: Praveenkumar I <quic_ipkumar@quicinc.com>
Cc: agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org, 
	mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, bhelgaas@google.com, 
	lpieralisi@kernel.org, kw@linux.com, vkoul@kernel.org, kishon@kernel.org, 
	mani@kernel.org, quic_nsekar@quicinc.com, quic_srichara@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, 
	quic_varada@quicinc.com, quic_devipriy@quicinc.com, quic_kathirav@quicinc.com, 
	quic_anusha@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Dec 2023 at 07:44, Praveenkumar I <quic_ipkumar@quicinc.com> wrote:
>
>
>
> On 12/14/2023 12:39 PM, Dmitry Baryshkov wrote:
> > On Thu, 14 Dec 2023 at 08:29, Praveenkumar I <quic_ipkumar@quicinc.com> wrote:
> >> Qualcomm IPQ5332 has a combo PHY for PCIe and USB. Either one of the
> >> interface (PCIe/USB) can use this combo PHY and the PHY drivers are
> >> different for PCIe and USB. Hence separate the PCIe and USB pipe clock
> >> source from DT, and individual driver node can be used as a clock source
> >> separately in the gcc. Add separate enum for PCIe and USB pipe clock and
> >> change the parent in corresponding structures.
> >>
> >> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> > Please use your full name for the git authorship and or the S-o-B
> > tags. This applies to the whole series.
> My full name is "Praveenkumar I". In my region, we used to have only the
> initial letter of surname.

Oh, excuse me please then. I saw several of your colleagues using a
single letter instead of their surname and I supposed that it's a case
for you too.


-- 
With best wishes
Dmitry

