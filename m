Return-Path: <linux-pci+bounces-2020-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4181B82A680
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 04:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 525F71C215CA
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 03:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F51EC0;
	Thu, 11 Jan 2024 03:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nX+1BjAo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4914920E0
	for <linux-pci@vger.kernel.org>; Thu, 11 Jan 2024 03:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d3ed1ca402so44143315ad.2
        for <linux-pci@vger.kernel.org>; Wed, 10 Jan 2024 19:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704943982; x=1705548782; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iScWVuqhfpheqwtS8P8/yXNx/aCMkmPoM914hptI/Iw=;
        b=nX+1BjAofLKSavGr9BrS/IxpxaO8EYYt4ruNfmsymXIud7gdiXMtRKb4MiyaVEMrPF
         qUMv2o8vkPqLOUKit7GZSFDz9r/kNXMZNWwimIRKAi/G0BkBT12/SflZStMJW+o6WjMf
         R7dFmrJDKbFpVfhIdaumUeOceKbrdGJ8DJwam5ATw0/lIRoVD00lFfzxSBLGKjwKJIYH
         EJSpWre2w0gIB1A6AfwX6K1Ah1AGtMBnFVwZTyShxhmcy+6AL6ijfEC21e4FadUtfcz4
         qAr4iMjzDuASVef41kbt02Ka/STFQzVaixD2MZtzus3jdOk7rkIZhHAeS+rc4jURvSZv
         6K2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704943982; x=1705548782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iScWVuqhfpheqwtS8P8/yXNx/aCMkmPoM914hptI/Iw=;
        b=tMg+fRr6IPrFcagir5iiSRc/VsZaZBrx87CAz6xErdNFuhOGGZ7neEkR6y/soRrDvz
         sgIT29H13QdEy3dhJHnAu0kdUmApFmSnUkTV9ZQyLS8tDhmYDNU2jkJvLrSfe+NnCZRc
         7RZAgjKXgjG7WDddjt2gV/CLyKMa5QhEaFw+W1vyOCzfxxVOG8YSzjklNdGrWvi7xCDm
         0dsRg5OKmHa1Z1Xc+0d0AH29wWZfOq/TGXXNFsX2av54Kds7ROq6dRmkvlL0usefB9CJ
         qCXNUncLmvidgvuz+S3hH1vmQin9ltA2XtYbTsax4AmaWMDdxdKTv3DgUCk8tVgyV843
         f94g==
X-Gm-Message-State: AOJu0Yz9JdxKmQ1yMHC/1jlS35EyPBlDs6de/JXmA5QYdqAQ09vkOzKU
	87C+KBjje2/yooHzBZpdi/S54z72H3P/eQ==
X-Google-Smtp-Source: AGHT+IF4eUYLrn4Ez/WaZRqyZDR2oIn8Xra42U1GhajMqpzSX9odZBLq6HasGPuLaVFUI46HmRHpxg==
X-Received: by 2002:a17:902:eb83:b0:1d5:89c8:3fc9 with SMTP id q3-20020a170902eb8300b001d589c83fc9mr483209plg.1.1704943982624;
        Wed, 10 Jan 2024 19:33:02 -0800 (PST)
Received: from localhost ([122.172.81.83])
        by smtp.gmail.com with ESMTPSA id kk11-20020a170903070b00b001cf96a0e4e6sm80235plb.242.2024.01.10.19.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 19:33:01 -0800 (PST)
Date: Thu, 11 Jan 2024 09:02:59 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, agross@kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, mani@kernel.org,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, rafael@kernel.org,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, quic_vbadigan@quicinc.com,
	quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
	quic_ramkri@quicinc.com, quic_parass@quicinc.com
Subject: Re: [PATCH v5 5/5] PCI: qcom: Add OPP support to scale performance
 state of power domain
Message-ID: <20240111033259.7h2jdr76wvkfnges@vireshk-i7>
References: <20231102053013.7yt7pxin5awlu7w7@vireshk-i7>
 <20231102120950.GA115288@bhelgaas>
 <20231103051247.u4cnckzstcvs4lf5@vireshk-i7>
 <15a98ec0-214b-218b-1e3c-c09f770fce2e@quicinc.com>
 <0ba9f2af-169e-a9a2-9ae4-4c6a70b0a94e@quicinc.com>
 <20240110065757.xde2nvpr3z7c4isu@vireshk-i7>
 <376b3716-46ff-2324-73fc-f3afa3f7af1c@quicinc.com>
 <20240110073807.sqwmsyr6nmigg6zc@vireshk-i7>
 <ba732b1c-223c-ee70-d25b-4c78b312402c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba732b1c-223c-ee70-d25b-4c78b312402c@quicinc.com>

On 10-01-24, 18:28, Krishna Chaitanya Chundru wrote:
> it might be less only for now may be around 20 opp entries, but PCIe spec is
> being updated every few years and a new gen
> 
> gen speed will release, right now PCIe GEN6 is released but I don't we had
> any device in the market now and GEN7 is in process.
> 
> So in future it might become very big table. Either we need to come up with
> a framework in the OPP to select the BW based up on lane width
> 
> for particular speed or use the driver way.

Lets solve the problem the right (current) way for right now and revisit the
whole thing when it gets complex ? So I would suggest configuring the bw via the
OPP framework only, since it takes care of that for all other device types too.

We can surely revisit and try to do it differently if we find some issues going
forward.

-- 
viresh

