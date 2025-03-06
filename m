Return-Path: <linux-pci+bounces-23058-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D68A54B39
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 13:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D47C3B0BF9
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 12:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEAD1FF5FF;
	Thu,  6 Mar 2025 12:51:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2781F5FD;
	Thu,  6 Mar 2025 12:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741265511; cv=none; b=cwmvavMlWyzEN6zzrqmi+KdB87q6krbSYC51JgM+FvJjqDx0Ves7rxdIwNxh3ttJultk9R3peFhkyzhP4Rj1b4u+XVeKYtRbqOj789JfUe+FXbwYKHMVsk735oBw4QKi/NaiCv6BKZDfLZrFO0AGAQ554NE6xIAdaWGFvJHrzQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741265511; c=relaxed/simple;
	bh=Zz0u44CTQSns6sJk7jghxEbeUrI7Oc+e6U/ixES3qVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1pKPfcB1LvcZRNQw/OYTLo8oBhyc6l3f/q8OA9/hSmO818LBl2D6QBRNW0mSNIXjrs9x5VnU4/+kR67GSSbHw773gjLqODE1NWEuSyMnW1RbwewGCV9uOMJXf4gptm5ukUp8qY/YD6XxsP6WkT0WmJ1GTL3c+G37yiQFI4Mso0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2234e4b079cso9182195ad.1;
        Thu, 06 Mar 2025 04:51:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741265509; x=1741870309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4cM1T3UuNpNu/U2G8pNowOEoTdTHEWvrKuxbrr/y/s=;
        b=rrRzV8mztwuHf1pSFYbG6MMbfQslgMYCG7z91QLZD/5FzfW2Z/KdPbXo83inWxdEeD
         2CbtdFqMF3RW1iQ5WHVMxrh9SfH1oR/0eDg/9Vs2yGExZ3jGuAIAE0mYLe/Z58ZHPYNR
         Alx6+YurLKmW/T9fqR0Hb4sjVqEVFG2yF7cHGmjAAcUepMaeH129MqxdJ7rBpHYJ79cQ
         PXc+7kn7lwdT4jg+jFI93zh6M0DmLrM/YirmoasEgES+RVgNwYhIlsL8KcO1y8jtUrba
         FMmqVD5wgZMEfSAhXynaVst9XdEfeOBC54eflpyqYl+Es/Ah3vj3EGesKVtL0oIvhgNg
         StVg==
X-Forwarded-Encrypted: i=1; AJvYcCUnPFQ6e8KQDEPuG7EKXgu7LZImllZp2i5hMFP3xKPq4VMnK5O2di7GsEgsgRGNVroimPQf5hqxUH1c@vger.kernel.org, AJvYcCUvdZrbnkL0pC7fXbvmbfP4rohaLRwXXJ3uBXvinkw7HpNyIi7Yq7+6KuCdd8tF/W0SYPY9CxwWbHhSwwsr@vger.kernel.org, AJvYcCVRZWSn6v+yrdK8KLnkKNGuroESIHq1mrO4lPo6jK3Iv6PiyL4rvC0bT4xekI5nvlpsjiVSRV+xH9pc@vger.kernel.org, AJvYcCX5O6MsFO0aYONyv2hWKRX/3oJodOoNOeVxzN1zjQ+R4iBPG+N3ixJa3UI0JFe+oXSWPJLAd3t5r0V/Tchn5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlbJ2b7V4Dv/NCu6/qxj+r36yaJUHjnF1L1Y1/wYkmb4usWHRL
	K3mhKbqkS3vORKOOnePFwUC0ACyGC6OJZEAs2H+ANJxZwjpRPydo
X-Gm-Gg: ASbGncuk2ba+wD8gw5DYc3pinaN4ANs/nwLiOpm1AsjBlLipNGK+W8s5oACdTKhX71h
	cgkFK/waH0KUt5qpuDK/U0DOlqXjUlJfvWweyth0N7MTi1Q6gsIJ8y1A9Olv0ylqxC13ieu2vAI
	WWZCXWGGyN8ettWFOoXmZ3QgulPzTI8UXJjX2/MaPC30vfytlxeOYNtLsokcml1VxgOmzNEDAuR
	fs+BooM2/+3IFhrQ2R7Oe7g4m4VLwz+kNLSnyRoiSdeC22K/Fh9Ke2DwK9hAxvnkBVWQJqp1lUP
	MPLqhQXDrH2o9peQITlGTI0ioJy35YY3fg4vVOn9cw2fu996uqvHXbVerW42CbnKJGELsEeUatT
	NN5c=
X-Google-Smtp-Source: AGHT+IHlKKib+yNPGnND+D+ePJ/13KrkYSmXwFybdYM1CzCFTjspnrAFaPc8IvV3IWlpLQYFhO77rQ==
X-Received: by 2002:a05:6a00:cc7:b0:736:5725:59b4 with SMTP id d2e1a72fcca58-73682b5a0b6mr11753649b3a.3.1741265509412;
        Thu, 06 Mar 2025 04:51:49 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-736984f8611sm1272908b3a.98.2025.03.06.04.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 04:51:48 -0800 (PST)
Date: Thu, 6 Mar 2025 21:51:47 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Varadarajan Narayanan <quic_varada@quicinc.com>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2] dt-bindings: PCI: Revert "dt-bindings: PCI: qcom: Use
 SDX55 'reg' definition for IPQ9574"
Message-ID: <20250306125147.GB478887@rocinante>
References: <20250306120359.200369-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306120359.200369-1-krzysztof.kozlowski@linaro.org>

Hello,

> Revert commit 829aa3693f8d ("dt-bindings: PCI: qcom: Use SDX55 'reg'
> definition for IPQ9574") because it affected existing DTS (already
> released), without any valid reason and without explanation.
> 
> Reverted commit 829aa3693f8d ("dt-bindings: PCI: qcom: Use SDX55 'reg'
> definition for IPQ9574") also introduces new warnings:
> 
>   ipq9574-rdp449.dtb: pcie@10000000: reg-names:0: 'parf' was expected

I removed the offending commit from the dt-bindings branch.

The next branch will be updated in due course.

Thank you!

	Krzysztof

