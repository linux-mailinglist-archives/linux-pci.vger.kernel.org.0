Return-Path: <linux-pci+bounces-24004-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B956A66983
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 06:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4375D3B8BA7
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 05:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8731D90A5;
	Tue, 18 Mar 2025 05:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QLl9v818"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F140748F
	for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 05:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742276327; cv=none; b=TxIwBjzH6mlgxm/kZY3nCaMJS0KA7SpP2Rtoq/9xpuWglQQTuhTAdWLceqBIDR8W5Clcb53b7YWP3QPWuo6UGIRWvRs7wlBYUJ2GzvOg+YxsiMbNrUTw5sOHMl1zipTvXJHwlgo/2cOkD8z60VZa104VmvEybRtaOElgRkeI46E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742276327; c=relaxed/simple;
	bh=P5iM0uabpaJ1AbJIJnKcL+VevuH5PXzgqzzKXmVjFEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIhBdRrQZ5nyStbbOjhlTUdn75v2OJc7smp9b1EsvxTfVRVBPn9bX5kdwTdTvQe9Ow1fnQl9f0sehCCPevNL5x59eGZOXk9D4ywM6LwVy3Mcwir0/iRVY5n6o0fJ7To7da1YyTLzPlYiJFEv52dkB4SXCcPnwgCA9AHMA4DSRds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QLl9v818; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-223594b3c6dso106950475ad.2
        for <linux-pci@vger.kernel.org>; Mon, 17 Mar 2025 22:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742276325; x=1742881125; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tdaqatqISFRYNU0Pl5hfD9x9pMSiXYmVb+XBgyOMwkY=;
        b=QLl9v818V12gQj0t843raaAQ3YRcjybkx4tqoaoX3tZumoohYu9dBHxkiDImCIi9ph
         1gu9zg1gsV6DkAKiPqxbY0qB7FTbIRi7JTNuY/6dZoJQOn1ZmsUSMyA1IrcqlI2Pbzfc
         zTP5K4yzt5B8Lwsr6rklRmZzSCy9L/nUKT3/j+i1x5C9hVaoTe3TocaHt1zFkJHhwxnG
         0vkxGZVGJ36SFYvaoaUhq8bRUQxEq8+08AkBGEb3CDGExn/+uK7QSynrwTUi4inXOLOr
         9LW5/MFph9JSqbTfHHNfXWQjex+Ce59aZnyEICG4NIW2KOCxQKpGyXntw7d1RT9OEFJt
         VWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742276325; x=1742881125;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tdaqatqISFRYNU0Pl5hfD9x9pMSiXYmVb+XBgyOMwkY=;
        b=rm5S/cFJwPrNwql/l02eqmqidoQRycOBNJYFTw+wpyENScFJwvrZLXfGWg6SifuoF1
         JUZVPRXQZ9uEV2bIQ3BFlI169WpChLsokGUPT/phMz/LpgfV+2aJNejnEg63GopjF0jf
         q+bU87kP/TgHN2ipBJBVfjl/kEAwYJMna03W2b8SLX4PfO8RmPMweaI+E8eXHDmzJbf4
         TFBRbvZvK8q+Yv05cSV4IxW/IfUoxbsc9hAbtXeRcbcg93kWIfGwkVKG7roBBEkoRWGG
         v7jTaoJNKD8V9GO4KEKe7ASeuq96jz796dXZl1YJu3YiFIkFGEnkL/Q4yV6NgUx49gd3
         7pDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPR168I1/38MOYru6DTkxPKR35QzlnLDLCxxO787TR3VPIr4lkkWj8m57eP/yqyWrOqg/b8twJ6kM=@vger.kernel.org
X-Gm-Message-State: AOJu0YythowNqNMOLqn+imwepnrg0udnezX76d8U8Gw9ri93X5oRO0k7
	D1qykd13NV27nAn+8PeALSJ3C4Qn61zZb59b+222fW2VGysDQPpyZ1IL+0CAgQ==
X-Gm-Gg: ASbGncu7DCK3EZgAHp8jcjwwKMUZ77UyxhOXNUd0fsG/XBdf39mSzaisnWLf0n4dXLd
	9a/IAqoYYSGswV0TC3LOHVnR7juGW+Y/Fr3KvIsepJZpO+nd9RAiyUrGyWpCg9yU13NS2l/7lQE
	hdwJUClD+IEPxiGQwfUbx9burKpgvc9H4RYAsp9quLEf7AaHZpS1xA21gv2UvrTWgFYgXOrKRb7
	jax//sX43U4zsJAr6tyxZo2kYiHUyNDBvVz1OMsKIoez1bqoJoZKeUSScJaj1WvlQVJLU4uok5h
	ig/IdAxoR9lqDXe3a+yMsiBTk6kroa4TBY4nyc+3/xh3WKDJTN4s07Lvjcf+ljGZ/rU=
X-Google-Smtp-Source: AGHT+IGtKPupstxaJ9l2OYhRXppRqOSSephtsRZM9k0tdvFT4Iz+eKcqIdvaN6lvgoSbh8+SItbTKA==
X-Received: by 2002:a05:6a00:464f:b0:736:5f75:4a44 with SMTP id d2e1a72fcca58-737223fd0ecmr16558503b3a.22.1742276324825;
        Mon, 17 Mar 2025 22:38:44 -0700 (PDT)
Received: from thinkpad ([120.56.195.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737116b1024sm8604240b3a.168.2025.03.17.22.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 22:38:44 -0700 (PDT)
Date: Tue, 18 Mar 2025 11:08:36 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, dmitry.baryshkov@linaro.org,
	neil.armstrong@linaro.org, abel.vesa@linaro.org,
	quic_qianyu@quicinc.com, quic_krichai@quicinc.com,
	johan+linaro@kernel.org, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v4 4/8] PCI: qcom: Add QCS8300 PCIe support
Message-ID: <20250318053836.tievnd5ohzl7bmox@thinkpad>
References: <20250310063103.3924525-1-quic_ziyuzhan@quicinc.com>
 <20250310063103.3924525-5-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310063103.3924525-5-quic_ziyuzhan@quicinc.com>

On Mon, Mar 10, 2025 at 02:30:59PM +0800, Ziyue Zhang wrote:
> Add support for QCS8300 SoC that uses controller version 5.90 so reusing
> the 1.34.0 config.

This is not a valid argument. You should mention that the controller is of
version <Qcom IP version>, but compatible with version 1.34.0 controllers and
hence reusing that ops.

5.90 is the synopsys IP version, not Qcom one. You should mention both.

> 

Please add more info about the controller like link speed, max lane count,
etc...

Moreover, cfg_1_34_0 has the 'override_no_snoop' bit set to override read/write
no snoop attributes. Are they applicable to this controller also?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

