Return-Path: <linux-pci+bounces-34182-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1308DB29CD7
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 10:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E53B03BB533
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 08:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F54307498;
	Mon, 18 Aug 2025 08:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="df3D12z8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F6C304BC4
	for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 08:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507322; cv=none; b=li02Kqjb05KNAo6ZHPWu3FUDPw0hGuWEW+RK7VG+IsjTrfBXNQEDejh0NardxJa+7tVtBLoJA43b/KzCJM08tRTdktGT3FqBMt8Dk9LxpFMHcJeE1QqSdoRXlv8e353OVnzggMt6Z6VmQRXWdVUrLB6YAtq61Hb7h/72dHxevr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507322; c=relaxed/simple;
	bh=doHN6EunE4q7NHlaNCFD732IGI30PIFL/jWt6aNwl7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oh2SH7EhWjycqe+qPeZTenuPLOZ1JCQgQNIW6mUpUXw6aEa/17hhLsuSuvA+ccIHGNedMhKNRdhqe8wo624BGjMpYESEH/NMBQd0i/oQYBCvzCkHg86ujBIzkjCHmnK+yMS9wnSed71DHu5FHu0WOUsz9hTlsajIj20Jr6lzbdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=df3D12z8; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e2ea6ccb7so2758432b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 01:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755507320; x=1756112120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oZn/2dNIEW/eVFC5JfnC1aipczmqj7uzjriC8bPsWpM=;
        b=df3D12z82MVMhgsPXGUVgJaQC/OJnuqLR57UTGn6BL2o3il38p3Crpd2pcBReCyM0s
         1vshYXWzucKA4YmZxkfswh0ntUBwHAqmUudGvuaTDTfdG6J0FxLTpQWdmuL7WtHZoDCJ
         EZJWeNExogFV5DWN9duma+fTuMzVpIF94rhsDLmbBwW4WwGYZUs6UqRrWs0GtGL9sZhc
         FG6soKSradjdaxELBs7Lhd673NHlqAIcFu+p4wMkoVlIIiS9XiSD3wd5sgfOKltj9CLW
         XfZH7b32d8Y5QGUOCo7V24+me3NFhb7jXeYVrI3BwkBc2Y8UuwnPh14xcJNm+hGOWGTV
         tvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755507320; x=1756112120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZn/2dNIEW/eVFC5JfnC1aipczmqj7uzjriC8bPsWpM=;
        b=kytprgZOSAmyUT83fYVrfN1Y8x9yM6CQwquaakV0Y9UyA3kOCnI1DyAjY83Iqzsv8z
         rUyMYUl2pZgzB5BcW2hoNJAwN6mkFkrw3TcLP8tLE83uDAUviaKe2UKEnj7wfR14l3L9
         2T38FBuciY7Ep9D+e3WSkDfU9NDU3xY8lHZOBO7ruGuDSxC6rUlKQwbCXnDtBIealEhU
         bW04vQg524B5FKDzL8X+kw7Iq9G2fVUl4sm0S7aLIQUkWmc5Zz+3cqj5Dab49Y0jy38o
         vhThF11Vd14mMjN8ya5RVMaHz5/AtgzEF0cm0KRepGUol3YRWRqd83PlKeJ7rG7cHVjJ
         YEjA==
X-Forwarded-Encrypted: i=1; AJvYcCX6A02w1wXSBv6yfWddHOUsjD8YvLAfbpxFyTn7hH/7R0vu9jrHT2bzKm6yo81pp3rau3fFFT81HIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0xsl+2nHZAfJdcTDS1AmaRQsrkyKsQIOeZXp/Tnjm5pFShOJC
	iIZEhnz03P6brAW0DI7VMVzET926rmsdu+SEZOeDWd/fo9xmPs1dw739QHhMtU2Ajr0=
X-Gm-Gg: ASbGncvtrffgddSNgjd5QKOHaylGTsQqaypLIm5nZ0qhd1vyLXHOdvvvGy3ImOhOCcP
	MRLlFfnsRtM8FKjkNACWh8DDuRnr07n2arLZOYHTeN6uf33DSUtQ8+AVyejyBpohDL3Df1uslKw
	ndxJoCs7qidarbOINnKUJr1eUP+mfR9uMexJ/qleEa2Xi2axxOX+h46cW45x9/XDpdMOIl1jo4i
	juSJnNAtLuxsoM+Obxycma+15o73PhMs6rgC5iF8Tt7pGDroJnTfX1vVCIfgi9XNQ4DXFGgzA+w
	+wxiSPun/fpFeA5F0+CdUjr5UMpRbNLRwK+OWiF0tHDHBUtnnu3YH7W/sICTl++libPRuWpKFvP
	rFrHz6ac8N5UeLpZtESlvOSap
X-Google-Smtp-Source: AGHT+IEwAoFmY5jt3W71l+SnRGhFYQeBBiVkuaX1UqUzqxvAN/4+HpvtbFxN/YglucS1GoqaljzKwQ==
X-Received: by 2002:a17:903:1c9:b0:240:6766:ac01 with SMTP id d9443c01a7336-2446d6f0386mr165051835ad.2.1755507319891;
        Mon, 18 Aug 2025 01:55:19 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d53eec7sm73735595ad.118.2025.08.18.01.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:55:19 -0700 (PDT)
Date: Mon, 18 Aug 2025 14:25:17 +0530
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
Subject: Re: [PATCH v2 1/3] PM/OPP: Support to match OPP based on both
 frequency and level.
Message-ID: <20250818085517.dj2nk4jeex263hvj@vireshk-i7>
References: <20250818-opp_pcie-v2-0-071524d98967@oss.qualcomm.com>
 <20250818-opp_pcie-v2-1-071524d98967@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818-opp_pcie-v2-1-071524d98967@oss.qualcomm.com>

On 18-08-25, 13:52, Krishna Chaitanya Chundru wrote:
> +static bool _compare_opp_key_exact(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
> +				   struct dev_pm_opp_key opp_key, struct dev_pm_opp_key key)
> +{
> +	bool freq_match = (opp_key.freq == 0 || key.freq == 0 || opp_key.freq == key.freq);

Why !opp_key.freq is okay ? If the user has provided a freq value,
then it must match. Isn't it ?

> +	bool level_match = (opp_key.level == OPP_LEVEL_UNSET ||
> +			    key.level == OPP_LEVEL_UNSET || opp_key.level == key.level);

We should compare bw too I guess in the same routine.

> +	if (freq_match && level_match) {
> +		*opp = temp_opp;
> +		return true;
> +	}
> +
> +	return false;
> +}
> +/**
> + * dev_pm_opp_find_freq_level_exact() - Search for an exact frequency and level

Instead dev_pm_opp_find_key_exact() and let the user pass the key
struct itself.

> +struct dev_pm_opp *dev_pm_opp_find_freq_level_exact(struct device *dev,
> +						    unsigned long freq,
> +						    unsigned int level,
> +						    bool available)
> +{
> +	struct opp_table *opp_table __free(put_opp_table);

The constructor here must be real, i.e. initialize opp_table here
itself. This is well documented in cleanup.h. Yes there are examples
like this in the OPP core which are required to be fixed too.

-- 
viresh

