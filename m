Return-Path: <linux-pci+bounces-34184-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2669BB29D10
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 11:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5379F174C38
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 09:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B634830BF7D;
	Mon, 18 Aug 2025 09:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NYmUCQIp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AFB3009C8
	for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 09:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507766; cv=none; b=Y3B6vGjdCL0PlCXsEQ5uENmTjO1nzvJaNbi00UCBLVOpCEQVE3G8AAPqROITRfuS1s1t/l9IW23/ma9udHePQtmhwqeBnAxehaW1md0lBLCYPiKYu6/lvOlECXRqiGAv2dhAOjBgUlfqNtyFES4kjqjwa8SLzsIsXDnBWxD59+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507766; c=relaxed/simple;
	bh=KHB43Z17LrATDP+I+UcK8mr27MT522jgBABjSbmHMfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPqew22EkZBts0dVIdYRcUZzINAcMm4oN37sfI7PCV+omfgA4lD9kTLqtFuEpcrU3hALSJhLSq6+ghL49RaQeRZSUriIPn+YxPO91npARA3E06uQ2FghnY21fEG2RxCVXfNxMytr4UhR+J6J8Hm/fg5ljv/IrEFQWM7hyS59KR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NYmUCQIp; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2445818eb6eso28926885ad.2
        for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 02:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755507763; x=1756112563; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tw7dbgkD+zT5jAWthzRKn29Iz3U2WQf9p2WltyhBPN4=;
        b=NYmUCQIpI1imdGHzDkPC0xQkhWmc31Ix6vyTpNj5GGjgyKNOKWTHw0OdQ8yoEsIwU8
         bUnp0FFdKY7l6GYnQBdpOan/cFWgG14FPa4FxxyWgDxcknsg6czcPmJy+F0hiI5qxy5s
         p7+lp0xk8ekGyObhMKPcZkiVpxk61j64M+r6UshcqVE7X9Tu2it71NK8WJ4/6Dre+zFG
         O8wVcoIlRaY4eBRyfj2GClven61oBWxPQV+CS2iK/vp/57MPiEky574pRf6+oWucN/D8
         pE0Tpl+/9hO5jotUa2cDQIYpOtwuJF+sp8e9n4Vqq6eiaBcnc3FpPcMi2U/hT6swDifK
         vySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755507763; x=1756112563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tw7dbgkD+zT5jAWthzRKn29Iz3U2WQf9p2WltyhBPN4=;
        b=rOBoU+SDPL+N/FT9H9VKTwaL0WMVPsMuZdhJ9jkGogn5mhDG57cVMeoGhPm6z/39He
         XCBuPQIbnWllUDzV+Pc7zaLJienFw009W/TfPqhTpivc8pGoFe8VX/ZFqQ40bCXrK94Q
         AUvRYiQiGl77Dt6fVZ+tmSLRnIf1rykLFJs4CISFF3mvyqfcWaearpXbhpUtDZxX4fkw
         F3V1Hnbd9cM2b9HOPKlt5xEZCEEjGQylBfAui35WMlnk3pKtGL3SN8cdpvIUS41I7Cu3
         koVMERz60Mk6/GKIwpJ6c/iUvkafRoPRz1yV85JX770tUUR7BvLVaYIB+/yIOqd6TmpP
         FdrA==
X-Forwarded-Encrypted: i=1; AJvYcCUjGRAT97lPhUM6eP6pmx+dk13OPUb8Bgy6++ZEwUI7qwMfzgVE3DEYhNTGZD80HUXG+4FybJFfv/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmQfdLtYNqBaYI+JFBYRXjbS0ikrCVZP1xrPMHoeh4+E6u9Uer
	VIKgL6usFp1gC4IRJBjiHetwNEEH0cN9TXZROrkU9V2u4Z29PNiZoGeEp7L+YmyhHJc=
X-Gm-Gg: ASbGncvfSAPwAHo/N/CeiB6+1UNPPVbMBJdhjULUKjMjJxNYxoCQ2CjVRixdcHgGJL/
	I7MJDFFhl03goDNoKuJcEWbF0T0uUBbwvi3lqr+gd2V2UycTEhzO7xzTu6/swatiVbhtwiiSB5H
	pHYnjAZ8eyk2Si6Y6pyExnH1lYZdEiRpTGams2rjK0YCk+Q6INUNgusm800ErO+G8AzYB5GqkD5
	i6mHjCSKMTqwwmTzYYBGl7c5pqaa7wkjKV1rd2Ou/Z3TuRPJV9lvruEsRgEbRyEado0tcvLg46W
	l8o0Ip0rpZi0i7OQpWT0tkkOdfeSY76YeLRmJMSqrFoq6Fp4FZrf1tTvoY1/pIHHjeGd4ttdsUv
	TtbVZABE1cgSxDwqKx5Kvw4yM
X-Google-Smtp-Source: AGHT+IE49BY+QEUKqeX/ukisuqIYp2KG3N61jubdd/2kSq1yDYk+d5vzKqRZTTbGf4J9qjawWGj9IA==
X-Received: by 2002:a17:902:c942:b0:242:9bbc:3644 with SMTP id d9443c01a7336-2446d9db047mr150258105ad.54.1755507763265;
        Mon, 18 Aug 2025 02:02:43 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d552798sm74284645ad.138.2025.08.18.02.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 02:02:42 -0700 (PDT)
Date: Mon, 18 Aug 2025 14:32:40 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sm8450: Add opp-level to
 indicate PCIe data rates
Message-ID: <20250818090240.in7frzv4pudvnl6q@vireshk-i7>
References: <20250818-opp_pcie-v2-0-071524d98967@oss.qualcomm.com>
 <20250818-opp_pcie-v2-2-071524d98967@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818-opp_pcie-v2-2-071524d98967@oss.qualcomm.com>

On 18-08-25, 13:52, Krishna Chaitanya Chundru wrote:
> @@ -2210,45 +2213,67 @@ pcie1_opp_table: opp-table {
>  				compatible = "operating-points-v2";
>  
>  				/* GEN 1 x1 */
> -				opp-2500000 {
> +				opp-2500000-1 {

Why mention -1 here when there is only one entry with this freq value
?

>  					opp-hz = /bits/ 64 <2500000>;
>  					required-opps = <&rpmhpd_opp_low_svs>;
>  					opp-peak-kBps = <250000 1>;
> +					opp-level = <1>;
>  				};
>  
> -				/* GEN 1 x2 and GEN 2 x1 */
> -				opp-5000000 {
> +				/* GEN 1 x2 */
> +				opp-5000000-1 {
> +					opp-hz = /bits/ 64 <5000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <500000 1>;
> +					opp-level = <1>;
> +				};
> +
> +				/* GEN 2 x1 */
> +				opp-5000000-2 {
>  					opp-hz = /bits/ 64 <5000000>;
>  					required-opps = <&rpmhpd_opp_low_svs>;
>  					opp-peak-kBps = <500000 1>;
> +					opp-level = <2>;
>  				};

This looks okay.

>  
>  				/* GEN 2 x2 */
> -				opp-10000000 {
> +				opp-10000000-2 {

Why -2 here ?

>  					opp-hz = /bits/ 64 <10000000>;
>  					required-opps = <&rpmhpd_opp_low_svs>;
>  					opp-peak-kBps = <1000000 1>;
> +					opp-level = <2>;
>  				};
>  
>  				/* GEN 3 x1 */
> -				opp-8000000 {
> +				opp-8000000-3 {

same.

>  					opp-hz = /bits/ 64 <8000000>;
>  					required-opps = <&rpmhpd_opp_nom>;
>  					opp-peak-kBps = <984500 1>;
> +					opp-level = <3>;
> +				};
> +
> +				/* GEN 3 x2 */
> +				opp-16000000-3 {

Shouldn't this be opp-16000000-1 only ? This is the first occurrence
16000000.

> +					opp-hz = /bits/ 64 <16000000>;
> +					required-opps = <&rpmhpd_opp_nom>;
> +					opp-peak-kBps = <1969000 1>;
> +					opp-level = <3>;
>  				};
>  
> -				/* GEN 3 x2 and GEN 4 x1 */
> -				opp-16000000 {
> +				/* GEN 4 x1 */
> +				opp-16000000-4 {

opp-16000000-2 ?

-- 
viresh

