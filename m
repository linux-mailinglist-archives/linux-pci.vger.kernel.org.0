Return-Path: <linux-pci+bounces-2201-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6900482EC86
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 11:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1782A1F2340C
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 10:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FF9134A3;
	Tue, 16 Jan 2024 10:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ps98n9t7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D23413AC0
	for <linux-pci@vger.kernel.org>; Tue, 16 Jan 2024 10:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e86c86a6fso183295e9.2
        for <linux-pci@vger.kernel.org>; Tue, 16 Jan 2024 02:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705399609; x=1706004409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZFO1yAGQW6jbC/7S5Gp/UgcbedeazJqK9TO6R35VgwI=;
        b=Ps98n9t7TWDphCp7Dbtbbj46IBH4zH9YZqEHcoxZFVIiLkrrixnXqo9xu3w7eG5DsE
         aVm2cCq9X3rKOaQ2AjVa/4+V2MFf0LIDxw6gJm8UsZd4/SooQCTv6+iuj6Lq1+qmM3Wt
         3j305rHvb66gHvFOeeZrTtASv/7kzLkHuhLEYU/Fcp8XbnEllPAvQzufjWCd7mRtz5ln
         vO2C/gn7NqX/oB3tDRrb2OErNTdrANznVcB9+v3XqbPYwZlxYpxXaDBEg12ciKZdAguX
         y0qEpsWMtY2G4iHQW4XtJFn99pwqtPB7GKBmVS9rdExvfh58UEPHpx0L2LkusLPBmuCo
         9tnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705399609; x=1706004409;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFO1yAGQW6jbC/7S5Gp/UgcbedeazJqK9TO6R35VgwI=;
        b=Mnlf5g0SgtS4/yhu7sVSov9XOXuIg4aBU5Wk/ZH6tvgd1fXJdNpnWOLS8Ke2FR9hQ4
         EWNyu9L5FAb2sxbBzxrVRaljPsUKL2ng85YTrnF0p3AekWZyOOOz7o2RSgPQ7M4I3g2v
         +20enGTcONg8jBLuqJGKh43li0xcMEaI6XaZZTavXsRVoIHoFF+wAVqneYgOZQWqCJAZ
         7wINYhZfFhbsZiADjqN+Y6CDxs7rVGNT55YyGMpoevfvN8ejDo57xibvW0C8DfIKuzlV
         uicYzMHKUG3He3FwWnCD67l2LXPYyIvnS9YBk5JffGkhSX3ZATWqyUSRMsmFTgawnVA4
         dK1Q==
X-Gm-Message-State: AOJu0Yw8m1deL/5hIDESL8AGFNtaJUlLU73oMwsz5bMjRMYrJ5aN8SxS
	NGYSEnTVo2b5jv3f2GTP58sPCG/goCabc9Mabd6eO1zev1mzdQ==
X-Google-Smtp-Source: AGHT+IEuBcf7ha8y/meOXJZo7IFgJlNJ3lP22wG1IplH414bJivQ5NZPrWXvHrCfQNI8GahECMcjEw==
X-Received: by 2002:a05:600c:4187:b0:40e:350e:4f6c with SMTP id p7-20020a05600c418700b0040e350e4f6cmr2178432wmh.56.1705399609320;
        Tue, 16 Jan 2024 02:06:49 -0800 (PST)
Received: from [192.168.100.86] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id f6-20020a05600c4e8600b0040d6ffae526sm22850811wmq.39.2024.01.16.02.06.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 02:06:48 -0800 (PST)
Message-ID: <cf8093a2-be15-4ec5-8b9e-84d7803ddae3@linaro.org>
Date: Tue, 16 Jan 2024 10:06:47 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/6] PCI: qcom: Add missing icc bandwidth vote for cpu
 to PCIe path
Content-Language: en-US
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Johan Hovold <johan+linaro@kernel.org>,
 Brian Masney <bmasney@redhat.com>, Georgi Djakov <djakov@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, vireshk@kernel.org,
 quic_vbadigan@quicinc.com, quic_skananth@quicinc.com,
 quic_nitegupt@quicinc.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240112-opp_support-v6-0-77bbf7d0cc37@quicinc.com>
 <20240112-opp_support-v6-3-77bbf7d0cc37@quicinc.com>
 <fecfd2d9-7302-4eb6-92d0-c2efbe824bf4@linaro.org>
 <1b7912c5-983c-b642-ca56-ae1e2def9633@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <1b7912c5-983c-b642-ca56-ae1e2def9633@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/01/2024 04:52, Krishna Chaitanya Chundru wrote:
>>
> There is no change required in the dts because the cpu-pcie path is
> already present in the dts.

Not at c4860af88d0cb1bb006df12615c5515ae509f73b its not, those dts 
entries get added later.

But anyway re-reading your commit log "vote for minimum bandwidth as at 
c4860af88d0cb1bb006df12615c5515ae509f73b" makes sense to me.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

