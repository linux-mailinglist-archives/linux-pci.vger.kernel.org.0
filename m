Return-Path: <linux-pci+bounces-33360-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AABB1A057
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 13:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FA6F1895E5C
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 11:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD85B254846;
	Mon,  4 Aug 2025 11:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dlw3pFsq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683B725229C
	for <linux-pci@vger.kernel.org>; Mon,  4 Aug 2025 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754306026; cv=none; b=iKN2/C3qvS2cl7n7ruWferf945I+iSUixfP0wCVIAp++W1Uj7lbhEJKsjISUibeSua6vgGmkIEV1sCV32qAtiaDPSw7l3QhqDx2SiULxgLqSmbJh0mUe70mpV0qRTOuUTZwc3fClkGdo4NA9H6lkJa6UF+rIU9WkCHmYWdpTwLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754306026; c=relaxed/simple;
	bh=/yT6SIbwMsDyXivBPq/u5jEb7k18emFAPJlUdi6+mro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0Jv1zlf1rkD4w85NupaBBqT7YOwwLw81xgrFQjUuCS59UzxKD3jgw9kDKW1Wzvm6arth+eoRzcZIGqyWiTSEmqUVe6N3hgNt13VA6Q7LP0WwSzmvwiELy7FtkhTUKjsbrtrhkxKJQK3XDxNtK9TvdyxuKZyZQMqIri0BW3L7z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dlw3pFsq; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7682560a2f2so4050683b3a.1
        for <linux-pci@vger.kernel.org>; Mon, 04 Aug 2025 04:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754306024; x=1754910824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WYxFvBBR753en9vuNva6YOR53xSyO7VCvwj1GDT38Q8=;
        b=dlw3pFsq+p9GpRztCVrhzKP0lJcpdn5txTF0zArhvSwBI1CV4XDYWXofEwTCLcZYg+
         fVtPrkSWcdS02TXPg+Uv7kkqnqWeWwIpHQ+xuc+WBxbwUW7PAtfFt85cbfSsutXrxzS9
         rpceV+yfasP5YpzxuiCBe8Sx7zS0/8FGZc7DpIZ8HfzCiV+ZsKrmQ/ppSQ1KOAeU3qGk
         j7J5hetgKsB/9jBVI2g5ohM22iSIUedveBQkoGcxtgYXRmdT4ABkyaZnr2Ej0g2MRES4
         4qVmNVuqDDTarQElVNS4NtkI/SJokDkeojnnQQeBQFElpH/w0U0Xaz6b0mvEckv/vSgu
         Jp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754306024; x=1754910824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYxFvBBR753en9vuNva6YOR53xSyO7VCvwj1GDT38Q8=;
        b=rNbGy0tQ/QlUfsP3j99/OC1fdBDNECthEfKVd39vwYxagLjupaFo3TfocQcySNPg9y
         HSvjlyXtPsyGkOxhHfJWn1PXEaKJkbEwFL+a1jVGBPojI0dila87+gHiTb5vBpwu5tI6
         wyivF3SgxJG4IiUio69pZFvpULtBDP8YSuN4oY2r2rAjOj+2mqijqELMEcDKQGxZI0D1
         qKFzrNaCuSOamgKpiKJ2iuXkfOBv4RgsLYA66bJnstn0vyXn0xwDDz6/h7hwtyf5uCDT
         nxCR52QnlmaqDJLApCi/4dYL0pOR93RhATcu30+lQMtQ/5xeBU4UkCzW1UY+hJWrKXx6
         Z5cw==
X-Forwarded-Encrypted: i=1; AJvYcCUxRLsKgpCA7HRfJbX0OGxOoO1YVSzKttrUlT/66wayUXl9cWbkFnI2RqbIhfnXK4v50XniXgstanY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG3/y7MCyL7vxe0h1Gv0MaWr4XWHCHIIkP4j35FZXtaAw7LVky
	vRZDcb1MXF5Q4sMoCnwakcMrNsmE4UsCyASWT7S1Sfa1zKyEccPxXYZ3th1q+aST998=
X-Gm-Gg: ASbGncupxjwbpV1bkN0lNtS5/QYnpyEtQdU9DsQT+5+RRtaIehahwtmBXNwVuSCcC3B
	rDySsmJwUJsmj8k1xzBoROw4qW+IX0gyTCH3mO3uJVyO/thKuQ/AstpjkdJix1+EuHKQ/ssqi1g
	UTa1gNRzaK5fX4+Fjeu10RX+BYYvDmH7SnnsSmi/yT2qSbB7QRo9iwl6a+L3QmaAOtn/R4CAlXD
	nOu6REsvIaVk/CPnw4qVI7Ejq23HAe1A6YPSHjsjjna6L9PcfshqPIegUykF17OoaMjfQLQA08a
	fNLoPUaW2aau8fkGRtzORTBjoUfsZN+Dk/rLpZS12JhIzuekyUPOPqbaim932cfLyE5ogQYRNmC
	BunzaZEm0ZiC31vEeQZlQkTs=
X-Google-Smtp-Source: AGHT+IE3KOgmXKzWVwIXatZUzP0SpT7zF9MWUThR1kMx49+PPbc0ii9e8sraQgCudSaaczTwkfvsEg==
X-Received: by 2002:a05:6a00:ae15:b0:76b:fdac:d884 with SMTP id d2e1a72fcca58-76bfdacdd96mr5449606b3a.3.1754306023713;
        Mon, 04 Aug 2025 04:13:43 -0700 (PDT)
Received: from localhost ([122.172.83.75])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bfc270514sm3545933b3a.12.2025.08.04.04.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 04:13:43 -0700 (PDT)
Date: Mon, 4 Aug 2025 16:43:40 +0530
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
Subject: Re: [PATCH 0/3] opp: Add bw_factor support to adjust bandwidth
 dynamically
Message-ID: <20250804111340.t62d4y2zg77rr3rp@vireshk-i7>
References: <20250717-opp_pcie-v1-0-dde6f452571b@oss.qualcomm.com>
 <0dfe9025-de00-4ec2-b6ca-5ef8d9414301@oss.qualcomm.com>
 <20250801072845.ppxka4ry4dtn6j3m@vireshk-i7>
 <7bac637b-9483-4341-91c0-e31d5c2f0ea3@oss.qualcomm.com>
 <20250801085628.7gdqycsggnqxdr67@vireshk-i7>
 <7f1393ab-5ae2-428a-92f8-3c8a5df02058@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f1393ab-5ae2-428a-92f8-3c8a5df02058@oss.qualcomm.com>

On 01-08-25, 15:05, Krishna Chaitanya Chundru wrote:
> Currently we are fetching the OPP based on the frequency and setting
> that OPP using dev_pm_opp_set_opp().
> 
> As you are suggesting to use dev_pm_opp_set_prop_name() here.
> This what I understood
> 
> First set prop name using dev_pm_opp_set_prop_name then
> set opp dev_pm_opp_set_opp()
> 
> if you want to change above one we need to first clear using
> dev_pm_opp_put_prop_name() then again call dev_pm_opp_set_prop_name
> & dev_pm_opp_set_opp()

dev_pm_opp_set_prop_name() should be called only once at boot time and not
again later on. It is there to configure one of the named properties before the
OPP table initializes for a device. Basically it is there to select one of the
available properties for an OPP, like selecting a voltage applicable for an OPP
for a device.

-- 
viresh

