Return-Path: <linux-pci+bounces-7634-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB048C8AB6
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 19:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73DF02867C7
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 17:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E7C13DB98;
	Fri, 17 May 2024 17:15:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FD312F5A3;
	Fri, 17 May 2024 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715966142; cv=none; b=aPs68Oqg406vSX7FOy+S2QK3Yam2kJj/+uBPTEebG/Pp1Y40qqX3dvsCY3y5pia8ly+09wNfIQN1hVNaWp1a+MqceO70KXNNYwrJBLqAIwCJ1JpsBA6Wq5tl3xBQeUJp+qCkbGEJDmSlIIigfzyrWEHT6My2NRzEDqo/pl/1ruc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715966142; c=relaxed/simple;
	bh=CeNQAngPAHskc9myqiu7dhF2+9gR+EP96fzENpUqBwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSTxKn+Lzwb2XAfy9FvEYZN7UhmhwcZUQgfexP0s9DfLct5Vf+ANjCzz4koQTlpQ/Uue8i+9a/QE0NYUP+s7gB3Szl7EwhJmLTHPkSOP9zRr9MNIkbPPIW51aeicFyA0erapvlIjfBJRO9D9ur3Mzq2lHxaXg+pPubmtpH8aKlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ecd3867556so17527895ad.0;
        Fri, 17 May 2024 10:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715966140; x=1716570940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bELmLAMwPChhwLt0fHSO/AP39ozUSBeKENIPKuRogpE=;
        b=hXWYVEKOe9qBKY8FsDla0xRMG0CsVdubwueyu9IR+jwtW5xaKgxyshLTAEkHTrDp4m
         Z2hVXHGNXUbZ4FsuMn7QbF24hUhmVO8zed9sA+H7zL/1BcYD9MPY3/xGQv2+iKwE+T4B
         Uet/DvvfbcbOPlnT6cwilRW/5fyUBwDagrpw4sMUgfwmI1SPnBinjr7dj0J5ey5jQnak
         uHPwE1e2fBBO0dwTPzGUwmEkvQcdxWCnqXsQBC20StmMc9nP/lnkt1JSuA83fNmIeDFE
         g2ZxwJoIyT+gUnP3+e9XsY/B6kzpYThf+RJ/emyhc6vFATOLRTOVnwyOXMHNONsuITCz
         X9Vw==
X-Forwarded-Encrypted: i=1; AJvYcCXkIhqqdVQItTj2IhvAVqjTX6S7KZI9/MJNnaJWZ0mSpma9F7JiyvdJqClCj8+9SyrW2VjJRP8fyDbtZ4gTP6VGj2IMdq0AuxD1Y2FaUwKuGnVYL5Eq/b2ykEJ/49Vc2+QWLwjHMfl91n8TwExPrpCII5Dux/4jZhqnIlA/Bg8FNrmB6RUEuCElB6WOumRu5NSQkNUBLR5qghCciz8UEwdpQbE=
X-Gm-Message-State: AOJu0YxkH8FT2u9+M3jqNdsD6902vS84UUWtZLjw3OmQYQarOf/GdH0a
	nux9/iC644pt/A9pnB2KnWkvro4xuRPNNkH2C+PD1lnt9MOyfWwx
X-Google-Smtp-Source: AGHT+IHGCM/h+xvLunc+rCf8ukVrTOO0DqmQdWNqa/FarJjsqTTQzbE+Bq+Ve1YFvSZHrnzAVOQ2Ow==
X-Received: by 2002:a05:6a21:2d0a:b0:1af:f50f:cbe9 with SMTP id adf61e73a8af0-1aff50fcc78mr18516149637.44.1715966140433;
        Fri, 17 May 2024 10:15:40 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-65c33343c2fsm2625572a12.41.2024.05.17.10.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 10:15:39 -0700 (PDT)
Date: Sat, 18 May 2024 02:15:38 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, konrad.dybcio@linaro.org,
	manivannan.sadhasivam@linaro.org, quic_shazhuss@quicinc.com,
	quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com,
	quic_nayiluri@quicinc.com, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com, quic_schintav@quicinc.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 0/3] arm64: qcom: sa8775p: add support for EP PCIe
Message-ID: <20240517171538.GH1947919@rocinante>
References: <1714492540-15419-1-git-send-email-quic_msarkar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1714492540-15419-1-git-send-email-quic_msarkar@quicinc.com>

Hello,

> This series adds the relavent DT bindings, new compatible string,
> and add EP PCIe node in dtsi file for ep pcie0 controller.

Applied to qcom, thank you!

[01/02] dt-bindings: PCI: qcom-ep: Add support for SA8775P SoC
        https://git.kernel.org/pci/pci/c/6baf8302442b
[02/02] PCI: qcom-ep: Add support for SA8775P SOC
        https://git.kernel.org/pci/pci/c/a8c1b13ba036

	Krzysztof

