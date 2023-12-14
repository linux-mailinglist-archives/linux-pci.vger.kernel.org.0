Return-Path: <linux-pci+bounces-954-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D742812900
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 08:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29DC51C209E2
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 07:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65326CA5F;
	Thu, 14 Dec 2023 07:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sjqLzUJW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA340E8
	for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2023 23:22:06 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-db3fa47c2f7so8011349276.0
        for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2023 23:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702538526; x=1703143326; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dFId4vI/rtSZSgTfU2r7XTw+wmzc0CVyAnfLkGgxiTM=;
        b=sjqLzUJW6RpdCQEgCN6K+N+OrI3ieQhj9QeR1xOnqITzq0TLtAym7qiAl1LTmg6rC1
         LtPZkWsHO9mLMG061fhIlLHNzyKTHeR6zdMQ+a6sGeGRyvUVe9oVKifDF+DnPAxdKRf6
         gTw7ui0IpQtf+HNZMbcqv31YD25BfUG1gTR2/9/wFdnPP5GfODd8QJjb7+XO6KFx35f5
         RrGKM4QQ2i5pUMmEKD5O4VFhub6wOcV3TXSMOX6UZJoNCd5rt7ptRoqzQaxsQ4jpVSR6
         i0rzJVPRf6JhhsNHCbUTvqE7Bw0hP2usN5MrksdxG163DNIGO7jR7dIaUZ9WW1WE5qmo
         CYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702538526; x=1703143326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dFId4vI/rtSZSgTfU2r7XTw+wmzc0CVyAnfLkGgxiTM=;
        b=r5aZFEirrv4XhDcAdv22hoxDHmm3xNkgWk9keoeSZ6GK1CeQXc+oj605RTst8bN5xE
         b4IMsiTjRQv9EXTriObjPX8f587qV+BYx7JKAyymN634piBCjdEso+jFnfmYry7gbY8j
         feRB3+W17oMe3UcHkt9NssO1zAiSuXwFS3XEXTtmIYBPxEmalcv1CXIp5fWfdXra2KFD
         U9V0ReJx3+pyVohkeGlaKOhjyKL2s7sqaF9C3eQ1Gk3jrsZBUJ95EeL44TkYw/882f7P
         Rj2gP2U2BryN3vqgbppE2uuaPvbWDmB9g6N9T6JBhTHqIchi3bcXmpxHLHJFR3QdDls2
         dEgg==
X-Gm-Message-State: AOJu0Yy33UTxmKrQte2yAraWAiIKQVfm0grN/0vC51tWtByCPorjLriN
	pg9+sf5Wjl1HgIkLRrXJTBJ7GB9YpDzxfn6OWEDp+w==
X-Google-Smtp-Source: AGHT+IEIP8q9qBU3y2LHml94mJ5w75uay/PW56FAWRJuUt9I+fEJqyg3WA41JHlZil2H3kXxccuRg6o0HP4Vq3kWWb8=
X-Received: by 2002:a25:9d06:0:b0:dbc:6715:42b4 with SMTP id
 i6-20020a259d06000000b00dbc671542b4mr6327865ybp.73.1702538526017; Wed, 13 Dec
 2023 23:22:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214062847.2215542-1-quic_ipkumar@quicinc.com> <20231214062847.2215542-4-quic_ipkumar@quicinc.com>
In-Reply-To: <20231214062847.2215542-4-quic_ipkumar@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 14 Dec 2023 09:21:55 +0200
Message-ID: <CAA8EJpqJ_7CPjTs2zykqnZpm9bQ31G7Q+1CA308OdS1BNqK6GA@mail.gmail.com>
Subject: Re: [PATCH 03/10] arm64: dts: qcom: ipq5332: Add separate entry for
 USB pipe clock
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

On Thu, 14 Dec 2023 at 08:29, Praveenkumar I <quic_ipkumar@quicinc.com> wrote:
>
> Add separate entry in clock-controller for USB pipe clock.

In my opinion, there is no need to do that separately. Please squash
into patch 9.

>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5332.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> index 42e2e48b2bc3..f0d92effb783 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> @@ -213,6 +213,7 @@ gcc: clock-controller@1800000 {
>                                  <&sleep_clk>,
>                                  <0>,
>                                  <0>,
> +                                <0>,
>                                  <0>;
>                 };
>
> --
> 2.34.1
>
>


-- 
With best wishes
Dmitry

